# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.5] - 2025-08-28

### Changed
- Day-wise attendance tab now instantly displays day wise data
- Day-wise attendance now displays On-duty in blue color
- Made refresh button more user friendly across all pages
- Reduced timeout time for university wifi and hostel wifi

### Added
- Emergency announcement feature in the homepage
- University wifi user limit bypass instruction
- Share button in Grade History page to share grades
- AWS website to For You section
- External CGPA Calculator support

### Fixed
- Biometrics log page fix where biometric data not available instantly for the present day
- Loss of user data due to VTOP client session expiration
- Restored full screen (status bar on top and bottom) for iOS devices
- Attendance day-wise not displayed for few courses due to incorrect course type



## [2.1.4] - 2025-08-02

### Added
- Smart Wifi feature
- Faculty name display in home page classes view
- Slot information in timetable view
- PDF viewer for outing documents
- Improved app-wide analytics

### Fixed
- Missing course names for some courses
- Downloaded outing PDF visibility in files app for iOS and Android
- Local data duplication issue
- iPhone home screen widget functionality

## [2.1.3] - 2025-07-24

### Changed
- Minor ui and performance improvements

### Fixed
- Issue with data not stored locally in some cases.


## [2.1.2] - 2025-07-20

### Fixed
- Incorrect faculty names in timetable


## [2.1.1] - 2025-07-20

### Changed
- Reduced response time by 40%
- Improved FAQ Page questions
- Enhanced developer footer by fetching dev profile pic from github
- User login flow

### Added
- Add search button and filter in Grade history page
- Add [@sanjay7178](https://github.com/sanjay7178) to the developer footer
- Add Weekend/General Outing Page with support to download outing reports

### Removed
- Mentor page for now from quick access.

## [2.1.0] - 2025-07-18

### Changed
- Integrate rust library 'lib_vtop' to parse data locally 

### Added
- Added day wise attendance detailed view to attendance page
- Added course wise grade history page
- Added support for new semester

### Fixed
- Fixed issue with attendance page being empty in some cases
- Fixed an with login due to pfp not available
- Fixed issue with feedback pop up not being closed

## [2.0.6] - 2025-06-20

### Changed
- minor updates in hostel wifi page 

### Added
- Added tooltip for Sync option in account page

### Fixed
- Fixed issue with profile picture not being persisted after app being closed.
- Fixed an with timetable notifications where timeslot is shown instead of time delay

---

## [2.0.5] - 2025-06-19

### Changed
- Navigating with the bottom nav bar now always takes back to the Home screen to prevent accidental app exits.
- Increased timeout duration for better performance on slower connections.
- Updated backend URL for improved stability and faster responses.

### Added
- Added support for in-app update prompts
- New sync reminder dialog — get prompted to sync after changing semester.
- Added support for custom profile pictures

---

## [2.0.4] - 2025-06-08

### Changed
- Improved clarity of error messages

### Fixed
- Fixed issue with class timetable notification not expanding properly

### Added
- Added a helpful tip for using Privacy Mode
- Added tooltip for Privacy Mode

---

## [2.0.3] - 2025-06-01
### Changed
- Improved exam schedule page ui
- Sort daily schedule in timetable page

### Added
- Add Manage Credentials Page
- Add payment receipts and pending payments page

---

## [2.0.2] - 2025-06-01

### Added
- Add between attendnace percentage
- add support for short and long semesters

### Changed
- Remove registration number validation for now
- Improved exam schedule page ui

---

## [2.0.0] - 2025-05-30

### Changed
- Migrate entire app to MVVM Pattern

---

## [0.2.3] - 2025-05-27

### Changed
- Timetable parser to not include any global variables

---

## [0.2.0] - 2025-05-24

### Added
- Initial release: Attendance, Timetable, Exam Schedule, Profile, Weekend and General Outing