import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/core/theme/app_theme.dart';
import 'package:movie_app/features/home/viewmodel/home_view_model.dart';
import 'package:movie_app/features/favorites/viewmodel/favorites_view_model.dart';
import 'package:movie_app/core/router/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/core/localization/app_localization.dart';
import 'package:movie_app/core/providers/language_provider.dart';
import 'package:movie_app/core/config/flavors.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final apiService = ApiService();
  await apiService.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: apiService),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(apiService: apiService)),
        ChangeNotifierProvider(
            create: (_) => FavoritesViewModel(apiService: apiService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp.router(
          title: F.title,
          theme: AppTheme.darkTheme,
          routerConfig: goRouter,
          locale: languageProvider.currentLocale,
          supportedLocales: const [
            Locale('en'),
            Locale('tr'),
          ],
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: F.isDev,
          builder: (context, child) {
            return Banner(
              location: BannerLocation.topEnd,
              message: F.bannerText,
              color: F.bannerColor,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
