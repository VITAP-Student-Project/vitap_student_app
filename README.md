# VITAP Companion App 🎓📱

<br />
<div style="display: flex; justify-content: space-between;">
    <img src="previews/Final_Icon_512x512.png" width="100" height="100" style="margin-right: 60px;"> 
    <img src="previews/vitaplogo.png" width="322" height="100"> 
</div>


##

[![GitHub stars](https://img.shields.io/github/stars/Udhay-Adithya/vit_ap_student_app?style=social)](https://github.com/Udhay-Adithya/vit_ap_student_app/tree/testing)
[![GitHub Issues](https://img.shields.io/github/issues/Udhay-Adithya/vit_ap_student_app)](https://github.com/Udhay-Adithya/vit_ap_student_app/tree/testing)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)


The VITAP Companion App is a comprehensive mobile application designed to revolutionize the student experience at VIT-AP University. Built with Flutter, this app provides a seamless, user-friendly platform for students to access academic information, engage with the community, and stay informed.

## 📦 Table of Contents

- [Features](#-features)
- [Installation](#-installation)
- [Screenshots](#-screenshots)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Contributing](#-contributing)
- [Tech Stack](#-tech-stack)
- [API Integration](#-api-integration)
- [Performance Metrics](#-performance-metrics)
- [Security](#-security)
- [Future Roadmap](#-future-roadmap)
- [License](#-license)
- [Code of Conduct](#-code-of-conduct)
- [Contact](#-contact)

## 🚀 Features

- **🎓 Academic Hub**
  - Real-time attendance tracking
  - Detailed timetable management
  - Comprehensive profile information
  - Grade and performance insights
  - Outing requests with ease

- **💬 Community Platform**
  - Engage with others through Posts
  - Like, Dislike and Comment on others posts
  - Moderation tools

- **⏰ Smart Notifications**
  - Class alerts
  - Exam alerts
  - Important university announcements

- **🌦️ Live Utilities**
  - Local weather updates
  - Campus event notifications
  - Quick access to useful student made tools

- **🎨 User Experience**
  - Adaptive theme modes
  - Responsive design
  - Intuitive navigation

## 💻 Installation

### Prerequisites
- Flutter SDK 3.10+
- Dart SDK
- Android Studio or VS Code
- Android device/emulator (Android 6.0+)

### Setup Steps
1. Clone the repository
   ```bash
   git clone https://github.com/Udhay-Adithya/vit_ap_student_app.git
   cd vit_ap_student_app
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Run the app
   ```bash
   flutter run
   ```

## 📸 Screenshots

<div style="display: flex; gap: 10px; justify-content: center; align-items: center;">
    <img src="previews/home.png" width="135" height="300"> 
    <img src="previews/timetable.png" width="135" height="300">
    <img src="previews/community.png" width="135" height="300"> 
    <img src="previews/profile.png" width="135" height="300">  
</div>

## 🏗️ Project Structure

```
vitap_companion_app/
│
├── lib/
│   ├── pages/
│   ├── models/
│   ├── widgets/
│   └── utils/
│
├── assets/
│   ├── fonts/
│   ├── images/
│   └── weather_icons/
│
└── docs/
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter/Dart style guidelines
- Write comprehensive unit and widget tests
- Update documentation
- Maintain code quality

## 🛠️ Tech Stack

- **Framework**: Flutter 3.24.2
- **State Management**: Riverpod
- **Network**: http
- **Persistence**: Hive/Shared Preferences
- **Authentication**: VIT-AP VTOP API & VTOP
- **Backend**: VIT-AP VTOP API

## 🔌 API Integration

Seamlessly integrates with [VIT-AP VTOP API](https://github.com/Udhay-Adithya/VIT-AP-VTOP-API)

## 📊 Performance Metrics

- **App Size**: < 75 MB
- **Startup Time**: < 2 seconds
- **API Response Time**: < 2500ms
- **Battery Usage**: Optimized for minimal drain

## 🔒 Security

- **Platform-Specific Encryption**:
  - **iOS**: Keychain for secure credential storage
  - **Android**: 
    - AES encryption for data protection
    - AES secret key encrypted with RSA
    - RSA key stored in Android KeyStore
- Secure API communication
- Regular security audits

## 🗺️ Future Roadmap

- [ ] Implement friend scheduling feature with privacy controls
- [ ] Add at least 3 new custom themes
- [ ] Create push notification system for exam schedules

## 💖 Support the Project

Maintaining this app involves monthly backend hosting costs. Your support helps keep the project alive!

### Donation Methods
- **Buy Me a Coffee**: [Support Project](https://www.buymeacoffee.com/udhayxd)
- **Google Pay (GPay)**: [Donate via UPI](upi://pay?pa=udhayxd@okaxis&pn=Udhay%20Adithya&mc=0000&mode=02&purpose=00)

Every contribution, no matter how small, helps sustain the app and supports student-driven innovation. 🙏

## 📄 License

Distributed under GNU General Public License v3.0. 
See `LICENSE` for more information.

## 📢 Disclaimer

> **Note**: This is a community-driven project and is not an official VIT-AP University application. Developed by students, for students.

## 📧 Contact

Udhay Adithya - [udhayxd@gmail.com](mailto:udhayxd@gmail.com)

Project Link: [https://github.com/Udhay-Adithya/VITAP-Companion-App](https://github.com/Udhay-Adithya/vit_ap_student_app)

---

**Give a ⭐ to support the project!**