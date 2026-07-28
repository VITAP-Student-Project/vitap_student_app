import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

/// Emits a `screen_view` as the user moves between routes.
///
/// Deliberately emits *only* `screen_view`. An earlier version also logged a
/// custom `navigation` event on every push and pop plus a `screen_time` event
/// on every pop, which tripled event volume to re-derive things Firebase
/// already provides: `screen_view` gives the previous screen and the funnel,
/// and `user_engagement` gives time-per-screen automatically.
class AnalyticsRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  AnalyticsRouteObserver(this._analytics);

  final AnalyticsService _analytics;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _analytics.logScreen(_getRouteName(route));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Popping reveals the route underneath, which is a new screen view.
    if (previousRoute != null) {
      _analytics.logScreen(_getRouteName(previousRoute));
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _analytics.logScreen(_getRouteName(newRoute));
    }
  }

  String _getRouteName(Route<dynamic> route) {
    // First, try to get the name from route settings
    if (route.settings.name != null && route.settings.name!.isNotEmpty) {
      return route.settings.name!;
    }

    // For MaterialPageRoute, try to extract the widget class name safely
    if (route is MaterialPageRoute && route.subtreeContext != null) {
      try {
        final widget = route.builder(route.subtreeContext!);
        return widget.runtimeType.toString();
      } catch (e) {
        // If context is invalid, fall back to route type
        return route.runtimeType.toString();
      }
    }

    // Fallback to route type name
    return route.runtimeType.toString();
  }
}
