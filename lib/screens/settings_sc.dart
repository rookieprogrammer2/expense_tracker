import 'package:expense_tracker/providers/authentication_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String routeName = "settings_screen";

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              themeProvider.isDark() == true
                  ? const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 53, 74, 83),
                      child: Icon(
                        Icons.logout,
                        size: 25,
                        color: Colors.blue,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.logout,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),

              const SizedBox(width: 3),
              TextButton(
                onPressed: () {
                  signout(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      fontFamily: "Lato",
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signout(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    MyDialogs.showCustomDialog(context,
        dialogMessage: "Are you sure you want to logout?",
        isDismissible: false,
        positiveActionName: "Yes",
        negativeActionName: "No", positiveAction: () {
      authProvider.logout(context);
    });
  }
}
