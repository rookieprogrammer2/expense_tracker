import 'dart:async';
import 'package:expense_tracker/screens/expenses_sc/expenses_sc.dart';
import 'package:expense_tracker/screens/landing_sc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/authentication_provider.dart';
import 'package:expense_tracker/utilities/app_assets.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4),
        () => navigate(context)
    );
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.splashScreen),
        ),
      ),
    );
  }
  void navigate (BuildContext context) async {
    var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    if(authProvider.alreadyLoggedIn()) {
      Navigator.pushReplacementNamed(context, ExpensesScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LandingScreen.routeName);
    }
  }
}

