// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:expense_tracker/providers/settings_provider.dart';
// import 'package:provider/provider.dart';
//
// List<String> languages = <String>['English', 'Arabic'];
//
// class SettingsTab extends StatelessWidget {
//   const SettingsTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
//     return Container(
//       margin: const EdgeInsets.only(left: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 70),
//           Text(
//             AppLocalizations.of(context)!.languages,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const LangDropdownMenu(),
//         ],
//       ),
//     );
//   }
// }
//
// class LangDropdownMenu extends StatefulWidget {
//   const LangDropdownMenu({super.key});
//
//   @override
//   State<LangDropdownMenu> createState() => _LangDropdownMenu();
// }
//
// class _LangDropdownMenu extends State<LangDropdownMenu> {
//   var dropDownValue = "";
//
//   @override
//   Widget build(BuildContext context) {
//     SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
//     return DropdownMenu<String>(
//         width: 300,
//         initialSelection: settingsProvider.currentLocale == "en"
//             ? AppLocalizations.of(context)!.english
//             : AppLocalizations.of(context)!.arabic,
//         onSelected: (value) {
//           setState(() {});
//           dropDownValue = value!;
//           if (settingsProvider.currentLocale == "en")
//             settingsProvider.getLanguage("ar");
//           else
//             settingsProvider.getLanguage("en");
//         },
//         dropdownMenuEntries: [
//           DropdownMenuEntry<String>(
//               value: AppLocalizations.of(context)!.arabic,
//               label: AppLocalizations.of(context)!.arabic),
//           DropdownMenuEntry<String>(
//               value: AppLocalizations.of(context)!.english,
//               label: AppLocalizations.of(context)!.english),
//         ]
//
//       // languages.map<DropdownMenuEntry<String>> ((value) =>
//       //    DropdownMenuEntry<String> (value: value, label: value,)).toList(),
//       /*
//         * map is a function that is going to transform every list item into whatever
//         *  the generic type within its brackets is -in this case, it is going to
//         *  transform every list item into a "DropdownMenuEntry" widget.
//         *  The return of this function is the callback function (value) {...}.
//         *
//         * (value) {...} is a callback function that will execute for each
//         *  list item, transforming it into a "DropdownMenuEntry" widget.
//         *  it exactly defines how each language value should be created and transformed
//         *   into a DropdownMenuEntry widget.
//         */
//     );
//   }
// }

import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/screens/login_sc.dart';
import 'package:expense_tracker/utilities/dialogs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const String routeName = "settings_screen";
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              themeProvider.isDark() == true ? const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 53, 74, 83),
                child: Icon(
                  Icons.logout,
                  size: 25,
                  color: Colors.blue,
                ),
              ) : const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.logout,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 3,),
              TextButton(
                onPressed: (){
                  signout(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
  void signout (BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    MyDialogs.showCustomDialog(
        context,
        dialogMessage: "Are you sure you want to logout?",
        isDismissible: false,
      positiveActionName: "Yes",
      negativeActionName: "No",
      positiveAction: () {
          authProvider.logout(context);
      }
    );
  }
}

