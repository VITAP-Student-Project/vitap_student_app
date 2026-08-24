import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/features/vtop_webview/models/webview_cookie_data.dart';

void main() {
  group('parseCookieString', () {
    // The input is the Cookie *request header* the Rust session would send —
    // `fetch_cookies` returns what reqwest's cookie store hands back for the
    // VTOP URL, not a Set-Cookie line. So there are no attributes to strip,
    // just name=value pairs, and every one of them has to survive: a dropped
    // pair means the WebView presents a partial session and VTOP bounces it to
    // the login page.
    test('reads every pair out of a session cookie header', () {
      final cookies = parseCookieString(
        'JSESSIONID=8A1F3C9E2B; _csrf=aa11-bb22; loginFlag=true',
      );

      expect(cookies.map((c) => c.name).toList(), <String>[
        'JSESSIONID',
        '_csrf',
        'loginFlag',
      ]);
      expect(cookies.map((c) => c.value).toList(), <String>[
        '8A1F3C9E2B',
        'aa11-bb22',
        'true',
      ]);
    });

    // Base64-ish session values routinely contain '=' padding. Splitting on
    // every '=' instead of the first would truncate the value and quietly
    // hand the WebView a cookie the portal does not recognise.
    test('keeps everything after the first equals sign in the value', () {
      final cookies = parseCookieString('token=YWJjZGVmZw==');

      expect(cookies, hasLength(1));
      expect(cookies.single.name, 'token');
      expect(cookies.single.value, 'YWJjZGVmZw==');
    });

    test('trims the whitespace around names and values', () {
      final cookies = parseCookieString('  a = 1 ;   b=2  ');

      expect(cookies.map((c) => c.toString()).toList(), <String>['a=1', 'b=2']);
    });

    test('skips empty segments rather than emitting blank cookies', () {
      final cookies = parseCookieString('a=1;;  ; b=2;');

      expect(cookies, hasLength(2));
      expect(cookies.map((c) => c.name).toList(), <String>['a', 'b']);
    });

    test('skips a segment with no equals sign at all', () {
      final cookies = parseCookieString('a=1; HttpOnly; b=2');

      expect(cookies.map((c) => c.name).toList(), <String>['a', 'b']);
    });

    test('skips a segment whose name is empty', () {
      final cookies = parseCookieString('=orphan; a=1');

      expect(cookies, hasLength(1));
      expect(cookies.single.name, 'a');
    });

    test('an empty header yields no cookies', () {
      expect(parseCookieString(''), isEmpty);
      expect(parseCookieString('   '), isEmpty);
    });

    test('an empty value is preserved rather than dropped', () {
      final cookies = parseCookieString('a=; b=2');

      expect(cookies, hasLength(2));
      expect(cookies.first.name, 'a');
      expect(cookies.first.value, isEmpty);
    });
  });
}
