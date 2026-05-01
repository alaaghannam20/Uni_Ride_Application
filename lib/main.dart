import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/provider/booking_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/app_router.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPrefs.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppLanguageProvider, AppThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            cardColor: const Color(0xFFFFFFFF),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFFFFFFF),
              foregroundColor: Color(0xFF101828),
              elevation: 0,
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFCF8307),
              surface: Color(0xFFFFFFFF),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1A1D2E),
            cardColor: const Color(0xFF252836),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E2235),
              foregroundColor: Color(0xFFE8ECF4),
              elevation: 0,
            ),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFCF8307),
              surface: Color(0xFF252836),
              onSurface: Color(0xFFE8ECF4),
            ),
          ),
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
