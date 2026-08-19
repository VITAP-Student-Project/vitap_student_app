# For You feed — API contract

The For You section on the home page and its View All page read a single
endpoint. This file is the contract the app expects; it lives here because the
dashboard that serves it is a separate repo and the two drift otherwise.

Base URL: `ServerConstants.forYouApiBaseUrl`
Auth: `X-API-Key: <FOR_YOU_API_KEY>` on every request.

## `GET /items`

Returns a **JSON array** of items. The app filters and sorts locally, so there
are no query parameters — one response serves the carousel, the search, the type
chips and the sort menu.

```jsonc
{
  "id": "abc123",
  "title": "Attendance Predictor",
  "author": "Someone",
  "author_email": "someone@vitapstudent.ac.in",
  "image_url": "https://…",        // nullable
  "type": "tools",                  // tools|event|resource|academics|placement|other
  "description": "…",
  "url": "https://…",

  "note": "Marks appear only after the term ends",   // nullable, free text
  "requires": "campus_wifi",        // nullable enum, see below
  "tags": ["attendance", "marks"],  // nullable/absent -> []
  "is_active": true,                // absent -> true
  "verified": false,                // absent -> false

  "is_approved": true,
  "is_featured": false,
  "display_order": 0,
  "likes": 12,
  "created_at": "2026-01-01T00:00:00Z",
  "updated_at": "2026-07-01T00:00:00Z"  // nullable
}
```

### The fields added after launch

All of them are optional, and old rows that lack them decode to the defaults
above, so the dashboard can backfill at its own pace.

- **`note`** — a free-text caveat, rendered as a callout on the detail page.
  Use this for one-off wording.
- **`requires`** — the recurring prerequisites, where the app owns the wording
  so it stays consistent. Recognised values: `campus_wifi`, `hostel_wifi`,
  `vtop_login`. **Anything else decodes to "no requirement"** — it is not an
  error, it simply isn't shown, so a value this app version doesn't know can be
  rolled out safely.
- **`tags`** — searchable alongside title, author and description, and listed on
  the detail page.
- **`is_active`** — set false to retire a dead link. The app hides it while the
  row (and its likes) survives. Prefer this over deleting.
- **`verified`** — a maintainer opened the link and confirmed it does what it
  claims. This is the *visible* mark; `is_approved` only gates listing.
- **`updated_at`** — untouched by the app today, stored so freshness can be
  shown later without another migration.

**`type` is a closed enum** — `tools`, `event`, `resource`, `academics`,
`placement`, `other`. Note the singular `event`. `AppConstants.forYouItemTypes`
must stay identical to it: the API validates submissions against this list and
rejects anything else with a 400.

The API normalises every row on read, so a response always carries the full
shape above even for rows written before these fields existed.

### Parsing is deliberately lenient

`parseForYouFeed` skips a malformed entry rather than failing the whole feed,
the same way `announcements.json` is handled — the source is hand-curated with
no schema validation, and one bad row must not blank the section. It gives up
only when the body isn't a JSON array. Keep it that way.

Items with `is_approved: false` or `is_active: false` are dropped during
parsing, so no caller can forget to filter them.

## Caching — please serve these headers

The app caches the response body on disk for
`forYouCacheTtl` (6 hours) and revalidates with `If-None-Match` after that. A
pull-to-refresh bypasses the TTL but still sends the ETag.

For that to actually save anything, `GET /items` must return:

- **`ETag`** on every 200, and
- **`304 Not Modified`** with an empty body when `If-None-Match` matches.

`Cache-Control: public, max-age=300, stale-while-revalidate=86400` on top lets
the CDN absorb the rest. A feed that changes a few times a month should be
almost entirely 304s and edge hits.

Images referenced by `image_url` are cached to disk by the app
(`cached_network_image`), so they are fetched roughly once per install rather
than once per launch. Serving them from object storage with a long `max-age`
costs nothing after that.

### The ETag

Derived from the git SHA of `data/items.json`, the sum of all like counters, and
a response-shape version: `W/"<sha>-<likes>-v3"`. The version half matters — the SHA does not move when only the
serialising code changes, so without it a client holding a cached copy would
keep getting 304s and never see a new field. Bump it on the server whenever the
response shape changes.

## `POST /items`

Body is `ForYouItemSubmission`: `title`, `author`, `author_email`, `image_url`,
`type`, `description`, `url`, `note`, `requires`. Everything else is
server-assigned; submissions land unapproved.

## `POST /items/:id/like`

Returns the updated item. The app keeps one like per item per session and
patches its in-memory copy; the cached body keeps the old count until the next
revalidation, which is intentional.

Server-side the counter lives in a Cloudflare D1 table rather than in the JSON
feed, so a like is one atomic SQL statement. The like total is folded into the
ETag, which means a like elsewhere does invalidate the cached feed on the next
revalidation — the app just won't go looking before its TTL is up.
