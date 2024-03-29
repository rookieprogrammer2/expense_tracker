import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/providers/date_provider.dart';
import 'package:expense_tracker/screens/landing_sc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/authentication_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/splash_sc.dart';
import 'package:expense_tracker/screens/register_sc.dart';
import 'package:expense_tracker/screens/login_sc.dart';
import 'package:expense_tracker/screens/expenses_sc/expenses_sc.dart';
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
          ChangeNotifierProvider(create: (context) => ThemeProvider()..init()),
          ChangeNotifierProvider(create: (context) => DateProvider()),
        ],
          child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'expense_tracker',
      theme: ThemeProvider.lightMode,
      darkTheme: ThemeProvider.darkMode,
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LandingScreen.routeName: (_) => const LandingScreen(),
        RegistrationScreen.routeName: (_) => const RegistrationScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        ExpensesScreen.routeName: (_) => const ExpensesScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}