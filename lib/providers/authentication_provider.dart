import 'package:expense_tracker/screens/expenses_sc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expense_tracker/database/models/user_model.dart' as MyUser;
import 'package:expense_tracker/database/user_dao.dart';
import 'package:expense_tracker/screens/login_sc.dart';


class AuthenticationProvider extends ChangeNotifier {
  User? firebaseAuthenticationUser;
  MyUser.User? databaseUser;
  void updateDatabaseUser (MyUser.User? user) {
    databaseUser = user;
    notifyListeners();
  }

  Future<void> register(String emailController, String passwordController,
      String usernameController) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController, password: passwordController);

    await UsersDAO.createUser(
    MyUser.User(
        id: credential.user?.uid,
        email: emailController,
        username: usernameController
        ));
  }

  Future<void> login(String emailController, String passwordController) async {
    final credential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController,
        password: passwordController
    );
    var user = await UsersDAO.getUser(credential.user!.uid);
    updateDatabaseUser(user);
    firebaseAuthenticationUser = credential.user;

  }

  logout(BuildContext context) async {
    updateDatabaseUser(null);
    firebaseAuthenticationUser = null;
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  bool alreadyLoggedIn () {
    return FirebaseAuth.instance.currentUser != null;
  }

}
