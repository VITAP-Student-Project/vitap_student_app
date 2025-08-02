import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

class AnalyticsRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  final Map<Route<dynamic>, DateTime> _routeStartTimes = {};

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    try {
      final routeName = _getRouteName(route);
      final previousRouteName =
          previousRoute != null ? _getRouteName(previousRoute) : 'unknown';

      _routeStartTimes[route] = DateTime.now();

      // Log navigation event
      AnalyticsService.logNavigation(previousRouteName, routeName);

      // Log screen view
      AnalyticsService.logScreen(routeName);
    } catch (e) {
      // If route name extraction fails, log a generic event
      AnalyticsService.logEvent('route_push_error', {
        'error': e.toString(),
        'route_type': route.runtimeType.toString(),
      });
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    try {
      final routeName = _getRouteName(route);
      final previousRouteName =
          previousRoute != null ? _getRouteName(previousRoute) : 'unknown';

      // Calculate time spent on route
      final startTime = _routeStartTimes[route];
      if (startTime != null) {
        final timeSpent = DateTime.now().difference(startTime).inSeconds;
        AnalyticsService.logEvent('screen_time', {
          'screen_name': routeName,
          'time_spent_seconds': timeSpent,
        });
        _routeStartTimes.remove(route);
      }

      // Log navigation event
      AnalyticsService.logNavigation(routeName, previousRouteName);
    } catch (e) {
      // If route name extraction fails, clean up and log error
      _routeStartTimes.remove(route);
      AnalyticsService.logEvent('route_pop_error', {
        'error': e.toString(),
        'route_type': route.runtimeType.toString(),
      });
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute != null && oldRoute != null) {
      final newRouteName = _getRouteName(newRoute);
      final oldRouteName = _getRouteName(oldRoute);

      // Transfer time tracking
      if (_routeStartTimes.containsKey(oldRoute)) {
        final startTime = _routeStartTimes.remove(oldRoute)!;
        final duration = DateTime.now().difference(startTime);
        AnalyticsService.logTimeSpentOnScreen(oldRouteName, duration.inSeconds);
      }

      _routeStartTimes[newRoute] = DateTime.now();

      AnalyticsService.logNavigation(oldRouteName, newRouteName);
      AnalyticsService.logScreen(newRouteName);
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
