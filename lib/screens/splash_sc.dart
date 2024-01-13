// import 'dart:async';
// import 'package:expense_tracker/screens/expenses_sc.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:expense_tracker/providers/auth_provider.dart';
// import 'package:expense_tracker/ui/landing_sc.dart';
// import 'package:expense_tracker/screens/login_sc.dart';
// import 'package:expense_tracker/utilities/app_assets.dart';
//
// class SplashScreen extends StatelessWidget {
//   static const routeName = "splash_sc";
//
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Timer(const Duration(seconds: 4),
//         () => navigate(context));
//     // navigate(context)
//     // Navigator.pushReplacementNamed(context, LandingScreen.routeName)
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.fitWidth,
//           image: AssetImage(AppAssets.splashScreen),
//         ),
//       ),
//     );
//   }
//   void navigate (BuildContext context) async {
//     var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
//     if(authProvider.alreadyLoggedIn()) {
//       await authProvider.retrieveUserFromDatabase();
//       Navigator.pushReplacementNamed(context, ExpensesScreen.routeName);
//     } else {
//       Navigator.pushReplacementNamed(context, LandingScreen.routeName);
//     }
//   }
// }
//
