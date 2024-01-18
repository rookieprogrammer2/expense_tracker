import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/register_sc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = "landing_screen";

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.currentTheme == ThemeMode.dark
          ? const Color.fromARGB(255, 5, 99, 125)
          : Colors.white,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(width * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Start saving money by tracking your expenses",
              style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: height * 0.03),
            const Text(
              textAlign: TextAlign.center,
              "Have a better overview of your spending track and habits, and start saving more money today than ever by tracking your expenses!",
              style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w400,
                  fontSize: 20
              ),
            ),
            SizedBox(height: height * 0.03),
            Container(
              padding: EdgeInsets.only(left: width * 0.43 ),
              child: Row(
                children: [
                  const Text(
                    "Theme",
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: themeProvider.isDark() == true
                        ? const Icon(
                            Icons.light_mode_rounded,
                            size: 25,
                            color: Colors.yellow,
                          )
                        : const Icon(
                            Icons.dark_mode_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.3),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegistrationScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
