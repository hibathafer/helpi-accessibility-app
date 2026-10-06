import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/places/domain/entities/place.dart';
import '../../features/places/presentation/screens/add_place_screen.dart';
import '../../features/places/presentation/screens/map_screen.dart';
import '../../features/places/presentation/screens/place_details_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/transport_screen.dart';
import '../../features/profile/presentation/screens/services_screen.dart';

/// Route names used across the app. Kept in one place so navigation cannot
/// silently break on a typo.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const map = '/map';
  static const addPlace = '/add-place';
  static const placeDetails = '/place-details';
  static const profile = '/profile';
  static const services = '/services';
  static const transport = '/transport';
}

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(const SplashScreen());
      case AppRoutes.login:
        return _page(const LoginScreen());
      case AppRoutes.register:
        return _page(const RegisterScreen());
      case AppRoutes.dashboard:
        return _page(const DashboardScreen());
      case AppRoutes.map:
        return _page(const MapScreen());
      case AppRoutes.addPlace:
        return _page(const AddPlaceScreen());
      case AppRoutes.profile:
        return _page(const ProfileScreen());
      case AppRoutes.services:
        return _page(const ServicesScreen());
      case AppRoutes.transport:
        return _page(const TransportScreen());
      case AppRoutes.placeDetails:
        final place = settings.arguments;
        if (place is Place) return _page(PlaceDetailsScreen(place: place));
        // Reached only if the screen was opened without arguments.
        return _page(const MapScreen());
      default:
        return _page(const SplashScreen());
    }
  }

  static MaterialPageRoute<T> _page<T>(Widget child) {
    return MaterialPageRoute<T>(builder: (_) => child);
  }
}
