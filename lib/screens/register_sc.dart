import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/screens/login_sc.dart';
import 'package:expense_tracker/utilities/dialogs.dart';
import 'package:expense_tracker/utilities/field_validations.dart';
import 'package:expense_tracker/widgets/my_text_field.dart';
class RegistrationScreen extends StatefulWidget {
  static const routeName = "registration_screen";

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextTwo = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerText(width, height),
            SizedBox(height: height * 0.1,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 5, 99, 125),
                  // Color.fromARGB(255, 35, 168, 51),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.15, vertical: height * 0.01),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: height * 0.085),
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              MyTextFormField(
                                context: context,
                                /// Todo -> add another validation rule that makes sure the Username does not already exist.
                                textFieldIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.white.withOpacity(0.8)),
                                hintText: "Username",
                                textEditingController:
                                usernameController,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    FormValidator.validateUsername(value),
                              ),
                              MyTextFormField(
                                  context: context,
                                  hintText: "Email",
                                  textFieldIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white.withOpacity(0.8),
                                  ),
                                  textEditingController: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => FormValidator.validateEmail(value)
                              ),
                              MyTextFormField(
                                context: context,
                                textFieldIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                validator: (value) =>
                                    FormValidator.validatePassword(value),
                                textEditingController: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                hintText: "Password",
                                isObscure: _obscureText,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureText = !_obscureText;
                                    print("ICON CLICKED!");
                                    setState(() {});
                                  },
                                  icon: _obscureText
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.lightBlueAccent,
                                          size: 18,
                                        ),
                                ),
                              ),
                              MyTextFormField(
                                textEditingController: passwordConfirmationController,
                                context: context,
                                textFieldIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                validator: (value) =>
                                    FormValidator.validatePasswordConfirmation(
                                        value, passwordController.text
                                    ),
                                keyboardType: TextInputType.visiblePassword,
                                hintText: "Confirm Password",
                                isObscure: _obscureTextTwo,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureTextTwo = !_obscureTextTwo;
                                    print("ICON CLICKED!");
                                    setState(() {});
                                  },
                                  icon: _obscureTextTwo
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.lightBlueAccent,
                                          size: 18,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.077),
                        createAccountButton(width, height),
                        SizedBox(height: height * 0.02),
                        loginInstead(context),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// => Header Text <== ///
  Padding headerText(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, top: height * 0.079),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Register",
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Lato"
            ),
          ),
        ],
      ),
    );
  }

  /// => Create Account Button <== ///
  Container createAccountButton(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.079),
      child: ElevatedButton(
        onPressed: () {
          createAccount();
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
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  /// => Clickable Login Text <== ///
  Row loginInstead(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Or ",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          child: const Text(
            "Login ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
          ),
        ),
        const Text(
          "Instead",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  void createAccount() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      MyDialogs.showLoadingDialog(context);
      var authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      await authProvider.register(
          emailController.text,
          passwordController.text,
          usernameController.text
      );
      MyDialogs.dismissDialog(context);
      MyDialogs.showCustomDialog(
          context,
          dialogMessage: "Account created successfully!",
          isDismissible: true,
          positiveActionName: "Ok",
          positiveAction: () {
            Navigator.pushReplacementNamed(
                context,
                LoginScreen.routeName
            );
          });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        MyDialogs.showCustomDialog(
            context,
            title: const Text("Error"),
            dialogMessage: "This email is already in use.",
            isDismissible: true,
            positiveActionName: "Ok",
            positiveAction: () {
          Navigator.pop(context);
        });
      } else {
        MyDialogs.showCustomDialog(context,
            dialogMessage: "Error: ${e.code}",
            isDismissible: true,
            positiveActionName: "Ok",
            positiveAction: () {
          Navigator.pop(context);
        });
      }
    }
  }

  void checkCurrAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

}
