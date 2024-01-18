import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/providers/lang_provider.dart';
import 'package:expense_tracker/screens/landing_sc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/splash_sc.dart';
import 'package:expense_tracker/screens/register_sc.dart';
import 'package:expense_tracker/screens/login_sc.dart';
import 'package:expense_tracker/screens/expenses_sc.dart';
import 'package:expense_tracker/screens/settings_sc.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
          child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'expense_tracker',
      theme: ThemeProvider.lightMode,
      darkTheme: ThemeProvider.darkMode,
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
      // locale: Locale(languageProvider.currentLocale),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('ar'),
      // ],
      routes: {
        ExpensesScreen.routeName: (_) => const ExpensesScreen(),
        RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
        SplashScreen.routeName: (_) => const SplashScreen(),
        LandingScreen.routeName: (_) => const LandingScreen(),
      },
      initialRoute: ExpensesScreen.routeName,
    );
  }
}