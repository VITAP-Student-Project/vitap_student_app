class ServerConstants {
  // API Configuration
  static const Duration apiTimeout = Duration(seconds: 20); // seconds
  static const int maxRetryAttempts = 3;

  // VTOP Configuration
  static const String vtopBaseUrl = 'https://vtop.vitap.ac.in';
  static const String vtopDomain = 'vtop.vitap.ac.in';

  // VTOP Routes
  static const String vtopOpenPage = '/vtop/open/page';
  static const String vtopContentPage = '/vtop/content';
  static const String vtopLoginPage = '/vtop/login';
  static const String vtopPreLoginPage = '/vtop/prelogin';

  static const String hostelWifiBaseUrl =
      "https://hfw.vitap.ac.in:8090/httpclient.html";
  static const String universityWifiBaseUrl = "http://172.18.10.10:1000";

  static const String cgpaCalculatorBaseUrl =
      "https://cgpa-calculator-vitap.vercel.app/api/app/";

  static const String githubBaseUrl =
      "https://raw.githubusercontent.com/VITAP-Student-Project/vitap_student_app/main";
}
