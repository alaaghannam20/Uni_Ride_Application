import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/provider/booking_provider.dart';
import 'package:uni_ride_application/core/provider/gps_provider.dart';
import 'package:uni_ride_application/core/provider/payment_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/provider/rating_provider.dart';
import 'package:uni_ride_application/core/provider/reward_provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/app_router.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_theme.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/core/provider/notification_provider.dart';
import 'package:uni_ride_application/core/provider/one_signal_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPrefs.init();

  if (!kIsWeb) {
    OneSignalService().setNavigatorKey(navigatorKey);
    await OneSignalService().initialize(
      languageCode: AppPrefs.getLanguageCode(),
    );
  }

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => GpsProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => RatingProvider()),
        ChangeNotifierProvider(create: (_) => RewardProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? _lastLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppLanguageProvider, AppThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        final languageCode = languageProvider.locale.languageCode;

        if (_lastLanguageCode != languageCode) {
          _lastLanguageCode = languageCode;

          if (!kIsWeb) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              OneSignalService().initialize(
                languageCode: languageCode,
              );
            });
          }
        }

        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,

          localizationsDelegates:
              AppLocalizations.localizationsDelegates,
          supportedLocales:
              AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
