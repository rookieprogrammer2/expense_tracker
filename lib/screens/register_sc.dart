// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:expense_tracker/providers/auth_provider.dart';
// import 'package:expense_tracker/providers/lang_provider.dart';
// import 'package:expense_tracker/providers/theme_mode_provider.dart';
// import 'package:expense_tracker/screens/login_sc.dart';
// import 'package:expense_tracker/utilities/dialogs.dart';
// import 'package:expense_tracker/utilities/field_validations.dart';
// import 'package:expense_tracker/widgets/my_text_field.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   static const routeName = "registration_sc";
//
//   const RegistrationScreen({super.key});
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   bool _obscureText = true;
//   bool _obscureTextTwo = true;
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             headerText(width, height),
//             SizedBox(height: height * 0.1,),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 35, 168, 51),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(50),
//                     topRight: Radius.circular(50),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: width * 0.15, vertical: height * 0.01),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(height: height * 0.085),
//                         Form(
//                           key: formKey,
//                           child: Column(
//                             children: <Widget>[
//                               MyTextFormField(
//                                   context: context,
//                                   hintText: "Email",
//                                   textFieldIcon: Icon(
//                                       Icons.email_outlined,
//                                       color: Colors.white.withOpacity(0.8),
//                                   ),
//                                   textEditingController: emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   validator: (value) => FormValidator.validateEmail(value)
//                               ),
//                               MyTextFormField(
//                                 context: context,
//                                 textFieldIcon: Icon(
//                                   Icons.lock_outline_rounded,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                                 validator: (value) =>
//                                     FormValidator.validatePassword(value),
//                                 textEditingController: passwordController,
//                                 keyboardType: TextInputType.visiblePassword,
//                                 hintText: "Password",
//                                 isObscure: _obscureText,
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     _obscureText = !_obscureText;
//                                     print("ICON CLICKED!");
//                                     setState(() {});
//                                   },
//                                   icon: _obscureText
//                                       ? const Icon(
//                                           Icons.visibility,
//                                           color: Colors.white,
//                                           size: 18,
//                                         )
//                                       : const Icon(
//                                           Icons.visibility_off,
//                                           color: Colors.lightBlueAccent,
//                                           size: 18,
//                                         ),
//                                 ),
//                               ),
//                               MyTextFormField(
//                                 context: context,
//                                 textFieldIcon: Icon(
//                                   Icons.lock_outline_rounded,
//                                   color: Colors.white.withOpacity(0.8),
//                                 ),
//                                 validator: (value) =>
//                                     FormValidator.validatePasswordConfirmation(
//                                         value, passwordController.text),
//                                 keyboardType: TextInputType.visiblePassword,
//                                 hintText: "Confirm Password",
//                                 isObscure: _obscureTextTwo,
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     _obscureTextTwo = !_obscureTextTwo;
//                                     print("ICON CLICKED!");
//                                     setState(() {});
//                                   },
//                                   icon: _obscureTextTwo
//                                       ? const Icon(
//                                           Icons.visibility,
//                                           color: Colors.white,
//                                           size: 18,
//                                         )
//                                       : const Icon(
//                                           Icons.visibility_off,
//                                           color: Colors.lightBlueAccent,
//                                           size: 18,
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: height * 0.077),
//                         createAccountButton(width, height),
//                         SizedBox(height: height * 0.02),
//                         loginInstead(context),
//                         SizedBox(height: height * 0.02),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// => Header Text <== ///
//   Padding headerText(double width, double height) {
//     return Padding(
//       padding: EdgeInsets.only(left: width * 0.05, top: height * 0.079),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "Register",
//             style: TextStyle(
//               fontSize: 40,
//               color: Colors.black,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// => Create Account Button <== ///
//   Container createAccountButton(double width, double height) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: width * 0.079),
//       child: ElevatedButton(
//         onPressed: () {
//           createAccount();
//         },
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: height * 0.02),
//           backgroundColor: Colors.black,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(60),
//           ),
//         ),
//         child: const Center(
//           child: Text(
//             "Create Account",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//               fontSize: 17,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// => Clickable Login Text <== ///
//   Row loginInstead(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Or ",
//           style: TextStyle(
//               color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.pushReplacementNamed(context, LoginScreen.routeName);
//           },
//           child: const Text(
//             "Login ",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
//           ),
//         ),
//         const Text(
//           "Instead",
//           style: TextStyle(
//               color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
//         ),
//       ],
//     );
//   }
//
//   void createAccount() async {
//     if (formKey.currentState?.validate() == false) {
//       return;
//     }
//     try {
//       MyDialogs.showLoadingDialog(context);
//       var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
//       await authProvider.register(
//           emailController.text,
//           passwordController.text,
//       );
//       MyDialogs.dismissDialog(context);
//       MyDialogs.showCustomDialog(context,
//           dialogMessage: "Account created successfully!",
//           isDismissible: true,
//           positiveActionName: "Ok",
//           positiveAction: () {Navigator.pushReplacementNamed(context, LoginScreen.routeName);});
//
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         MyDialogs.showCustomDialog(context,
//             dialogMessage: "This email is already in use.",
//             isDismissible: true,
//             positiveActionName: "Ok", positiveAction: () {
//           Navigator.pop(context);
//         });
//       } else {
//         MyDialogs.showCustomDialog(context,
//             dialogMessage: "Error: ${e.code}",
//             isDismissible: true,
//             positiveActionName: "Ok", positiveAction: () {
//           Navigator.pop(context);
//         });
//       }
//     }
//   }
//
//   void checkCurrAuthState() {
//     /* "authStateChanges" is a method provided by the Firebase Authentication plugin
//          that returns a STREAM of changes to the authentication state --the user sign-in state.
//        That STREAM emits events --Asynchronously-- whenever the user's sign in state changes.
//
//        The "listen" method is called on the stream that is returned by the "authStateChanges" method,
//          and one of its parameters is a call-back function. It is executed whenever the authentication
//          state changes --whenever the user sign-in state changes.
//        The call-back function takes an object of the type "User" that represents a
//          a user in Firebase Authentication. */
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//   }
//
// }
