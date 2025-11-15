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

  // Outing Constants
  static const List<String> outingPlaces = [
    'Vijayawada',
    'Guntur',
    'Tenali',
    'Eluru',
    'Others'
  ];

  static const List<String> outingTimeSlots = [
    '9:30 AM - 3:30 PM',
    '10:30 AM - 4:30 PM',
    '11:30 AM - 5:30 PM',
    '12:30 PM - 6:30 PM'
  ];
}
