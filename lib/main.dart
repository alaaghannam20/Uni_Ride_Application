import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      builder: (context, languageprovider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageprovider.locale,
          initialRoute: Routes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
