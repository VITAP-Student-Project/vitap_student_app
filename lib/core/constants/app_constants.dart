class AppConstants {
  // Regular Expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  // Error Messages
  static const Map<String, String> errorMessages = {
    'network_error': 'Network connection error. Please try again.',
    'timeout_error': 'Request timed out. Please try again.',
    'server_error': 'Server error occurred. Please try again later.',
    'validation_error': 'Please check your input and try again.',
  };

  // Analytics Events
  static const Map<String, String> analyticsEvents = {
    'user_login': 'user_login_event',
    'user_logout': 'user_logout_event',
    'item_purchase': 'item_purchase_event',
    'page_view': 'page_view_event',
  };
}
