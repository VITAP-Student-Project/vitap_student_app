class ServerConstants {
  // API Configuration
  static const Duration apiTimeout = Duration(seconds: 20); // seconds
  static const int maxRetryAttempts = 3;

  static const String hostelWifiBaseUrl =
      "https://hfw.vitap.ac.in:8090/httpclient.html";
  static const String universityWifiBaseUrl = "http://172.18.10.10:1000";

  static const String cgpaCalculatorBaseUrl =
      "https://cgpa-calculator-vitap.vercel.app/api/app/";
}
