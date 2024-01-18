import 'package:expense_tracker/providers/lang_provider.dart';
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
  var dropDownValue = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Text(
              "Start saving money\nby tracking your expenses",
            ),
            const SizedBox(height: 7),
            const Text(
              textAlign: TextAlign.center,
              "Have a better overview of your spending track and habits,\nand "
              "start saving more money today than ever\n"
              "by tracking your expenses!",
            ),
            Row(
              children: [
                const Text("Theme: "),
                // DropdownMenu<String>(
                //     width: 300,
                //     initialSelection: languageProvider.currentLocale == "en"
                //         ? AppLocalizations.of(context)!.english
                //         : AppLocalizations.of(context)!.arabic,
                //     dropdownMenuEntries: [
                //       DropdownMenuEntry<String>(
                //           value: AppLocalizations.of(context)!.arabic,
                //           label: AppLocalizations.of(context)!.arabic),
                //       DropdownMenuEntry<String>(
                //           value: AppLocalizations.of(context)!.english,
                //           label: AppLocalizations.of(context)!.english),
                //     ],
                //     onSelected: (value) {
                //       setState(() {
                //         dropDownValue = value!;
                //       });
                //       if (languageProvider.currentLocale == "en") {
                //       languageProvider.changeLanguage("ar");
                //     } else {
                //       languageProvider.changeLanguage("en");
                //     }
                //   },
                // ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RegistrationScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
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
                    fontSize: 17,
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
