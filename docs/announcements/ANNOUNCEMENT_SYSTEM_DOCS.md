# Announcement System Documentation

## Overview
The announcement system provides a flexible way to display important announcements to students in the VIT-AP Student App. Announcements are fetched from a JSON file hosted on GitHub and displayed in a modern, user-friendly container on the home page.

## File Structure
```
/Users/udhayxd/Projects/vitap_student_app/
├── announcements.json (Production)
├── docs/announcements/announcements_examples.json (Reference with all examples)
├── lib/features/home/
│   ├── model/announcement.dart
│   ├── repository/announcement_repository.dart
│   ├── viewmodel/announcement_viewmodel.dart
│   └── view/widgets/announcement_container.dart
```

## JSON Schema

### Root Structure
```json
{
  "version": "1.0.0",
  "lastUpdated": "2025-08-28T12:00:00Z",
  "announcements": [...],
  "metadata": {...}
}
```

### Announcement Object
```json
{
  "id": "unique_identifier",
  "title": "Announcement Title",
  "message": "Detailed message content",
  "type": "academic|facility|maintenance|system|general",
  "importance": "low|medium|high|critical",
  "createdAt": "2025-08-28T10:00:00Z",
  "expiresAt": "2025-09-15T23:59:59Z",
  "isActive": true,
  "actionUrl": "https://example.com (optional)",
  "actionText": "Action Button Text (optional)"
}
```

## Announcement Types

### 1. Academic (`"type": "academic"`)
- Course-related announcements
- Exam schedules and changes
- Registration deadlines
- Academic calendar updates
- **Icon**: Book (Iconsax.book)

### 2. Facility (`"type": "facility"`)
- Library updates
- Hostel facilities
- Dining services
- Campus amenities
- **Icon**: Building (Iconsax.building)

### 3. Maintenance (`"type": "maintenance"`)
- Infrastructure repairs
- Utility outages
- Facility closures
- Maintenance schedules
- **Icon**: Settings (Iconsax.setting_2)

### 4. System (`"type": "system"`)
- VTOP updates
- IT system maintenance
- Technical issues
- Software updates
- **Icon**: Monitor (Iconsax.monitor)

### 5. General (`"type": "general"`)
- Events and activities
- Emergency notifications
- General information
- Student announcements
- **Icon**: Info Circle (Iconsax.info_circle)

## Importance Levels

### Critical (`"importance": "critical"`)
- **Color**: Red
- **Use Cases**: Emergency situations, safety alerts, immediate action required
- **Example**: Campus lockdown, severe weather warnings

### High (`"importance": "high"`)
- **Color**: Orange
- **Use Cases**: Important deadlines, significant changes, urgent updates
- **Example**: Exam registration deadlines, system outages

### Medium (`"importance": "medium"`)
- **Color**: Blue
- **Use Cases**: Important information, moderate urgency
- **Example**: Library hour changes, facility updates

### Low (`"importance": "low"`)
- **Color**: Green
- **Use Cases**: General information, optional activities
- **Example**: Event announcements, new course offerings

## Filtering and Display Logic

### Automatic Filtering
1. **Active Only**: Only announcements with `"isActive": true` are shown
2. **Non-Expired**: Announcements past their `expiresAt` date are filtered out
3. **Auto-Sorting**: Sorted by importance (critical → high → medium → low), then by creation date (newest first)
4. **Display Limit**: Maximum 3 announcements shown at once

### Visibility Rules
```javascript
// An announcement is visible if:
isActive === true && 
expiresAt > currentDateTime
```

## Best Practices

### Title Guidelines
- Keep under 60 characters
- Use clear, descriptive language
- Avoid special formatting
- Make it scannable

### Message Guidelines
- Keep under 200 characters for optimal mobile display
- Use clear, concise language
- Include essential information only
- Use proper grammar and punctuation

### Action Buttons
- Use clear, action-oriented text (max 20 characters)
- Examples: "Register Now", "Learn More", "Download", "Call Now"
- Only include if there's a specific action to take

### Timing Best Practices
- Post time-sensitive announcements early
- Set realistic expiration dates
- Don't overwhelm users with too many announcements
- Consider time zones (use UTC format)

## Examples and Use Cases

### 1. Emergency Announcement
```json
{
  "id": "emergency_001",
  "title": "Campus Emergency Alert",
  "message": "Severe weather warning in effect. All students remain in hostels.",
  "type": "general",
  "importance": "critical",
  "createdAt": "2025-08-28T06:00:00Z",
  "expiresAt": "2025-08-29T23:59:59Z",
  "isActive": true,
  "actionUrl": "tel:+91-9999999999",
  "actionText": "Emergency Line"
}
```

### 2. Academic Deadline
```json
{
  "id": "academic_001",
  "title": "Exam Registration Closes Tomorrow",
  "message": "Final reminder: Complete your exam registration by 11:59 PM tomorrow.",
  "type": "academic",
  "importance": "high",
  "createdAt": "2025-08-28T09:00:00Z",
  "expiresAt": "2025-08-30T23:59:59Z",
  "isActive": true,
  "actionUrl": "https://vtop.vitap.ac.in/exam-registration",
  "actionText": "Register Now"
}
```

### 3. Facility Update
```json
{
  "id": "facility_001",
  "title": "Library Extended Hours",
  "message": "Library now open 6 AM to 12 AM during exam period.",
  "type": "facility",
  "importance": "medium",
  "createdAt": "2025-08-28T08:00:00Z",
  "expiresAt": "2025-09-30T23:59:59Z",
  "isActive": true,
  "actionUrl": null,
  "actionText": null
}
```

### 4. Maintenance Notice
```json
{
  "id": "maintenance_001",
  "title": "WiFi Maintenance Tonight",
  "message": "Campus WiFi will be down 2-6 AM for upgrades.",
  "type": "maintenance",
  "importance": "medium",
  "createdAt": "2025-08-28T16:00:00Z",
  "expiresAt": "2025-08-29T06:00:00Z",
  "isActive": true,
  "actionUrl": null,
  "actionText": null
}
```

### 5. Event Announcement
```json
{
  "id": "event_001",
  "title": "Tech Fest Registration Open",
  "message": "Register for VIT-AP Tech Fest 2026. Amazing prizes await!",
  "type": "general",
  "importance": "low",
  "createdAt": "2025-08-28T10:00:00Z",
  "expiresAt": "2025-12-31T23:59:59Z",
  "isActive": true,
  "actionUrl": "https://techfest.vitap.ac.in/register",
  "actionText": "Register"
}
```

## How to Add New Announcements

### Step 1: Edit announcements.json
1. Open `/announcements.json` in the repository
2. Add your announcement object to the `announcements` array
3. Ensure all required fields are present
4. Use proper ISO 8601 datetime format for dates

### Step 2: Validate JSON
- Use a JSON validator to ensure syntax is correct
- Check that all required fields are present
- Verify datetime formats are correct

### Step 3: Commit and Push
- Commit the changes to the main branch
- The app will automatically fetch the updated announcements

### Step 4: Verify
- Open the app and check if the announcement appears
- Test any action buttons if included

## Technical Implementation

### Repository Pattern
- `AnnouncementRepository`: Handles fetching from GitHub
- Automatic error handling and fallbacks
- Caching and offline support

### State Management
- Uses Riverpod for state management
- `AnnouncementViewModel`: Manages announcement state
- Automatic refresh and background updates

### UI Components
- `AnnouncementContainer`: Main container widget
- `AnnouncementTile`: Individual announcement display
- Responsive design for different screen sizes

### Error Handling
- Graceful degradation on network errors
- Silent failures (no announcements shown if error)
- Retry mechanisms

## Testing Edge Cases

### Date and Time Testing
- Test with past expiration dates
- Test with future start dates
- Test timezone handling

### Content Testing
- Very long titles and messages
- Special characters and emojis
- Multilingual content
- HTML/Markdown in content

### Network Testing
- No internet connection
- Slow network conditions
- GitHub API downtime
- Invalid JSON responses

### State Testing
- Empty announcements array
- Mixed active/inactive announcements
- All expired announcements
- Maximum announcement limits

## Maintenance and Updates

### Regular Tasks
- Remove expired announcements monthly
- Update `lastUpdated` timestamp when making changes
- Monitor announcement performance and user engagement
- Review and update best practices

### Performance Considerations
- Keep announcements array reasonably sized (< 50 items)
- Remove old, expired announcements
- Optimize images and media if added in future
- Monitor API response times

## Future Enhancements

### Possible Features
- Push notifications for critical announcements
- User preferences for announcement types
- Analytics and engagement tracking
- Rich media support (images, videos)
- Localization and multi-language support
- Admin dashboard for managing announcements

### API Considerations
- Consider moving to a proper API if scale increases
- Add authentication for sensitive announcements
- Implement real-time updates with WebSockets
- Add user-specific targeting capabilities

## Support and Troubleshooting

### Common Issues
1. **Announcements not showing**: Check JSON syntax and GitHub connectivity
2. **Wrong sorting**: Verify importance levels and datetime formats
3. **Action buttons not working**: Check URL format and validity
4. **Styling issues**: Verify importance colors and type icons

### Debug Information
- Check app logs for network errors
- Verify JSON response in browser
- Test announcement logic with different datasets
- Use the examples file for comprehensive testing

---

**Last Updated**: August 28, 2025
**Version**: 1.0.0
