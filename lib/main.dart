import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/expenses_sc.dart';
import 'package:expense_tracker/utilities/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: Locale(settingsProvider.currentLocale),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('ar'),
      // ],
      debugShowCheckedModeBanner: false,
      title: 'expense_tracker',
      themeMode: ThemeMode.light, /// Todo => a provider should provide this parameter with its value
      theme: AppTheme.lightMode,
      home: const ExpensesScreen(),
    );
  }
}