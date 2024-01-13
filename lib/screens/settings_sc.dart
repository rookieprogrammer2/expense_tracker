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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quizzler/providers/auth_provider.dart';
// import 'package:quizzler/ui/screens/login/login_sc.dart';
// import 'package:quizzler/utilities/dialogs.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//   static const String routeName = "settings_sc";
//   @override
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text(
//                 "Settings",
//             style: TextStyle(
//               color: Colors.black
//             ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 TextButton(
//                   onPressed: (){
//                     signout(context);
//                   },
//                   child: const Text(
//                     "Logout",
//                     style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
//   void signout (BuildContext context) {
//     var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
//     MyDialogs.showCustomDialog(
//         context,
//         dialogMessage: "Are you sure you want to logout?",
//         isDismissible: false,
//       positiveActionName: "Yes",
//       negativeActionName: "No",
//       positiveAction: () {
//           authProvider.logout(context);
//       }
//     );
//   }
// }
//
