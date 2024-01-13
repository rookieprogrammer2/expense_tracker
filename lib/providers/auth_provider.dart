// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:expense_tracker/database/models/user_model.dart' as MyUser;
// import 'package:expense_tracker/database/models/expense.dart' as MyUser;
// import 'package:expense_tracker/database/user_dao.dart';
// import 'package:expense_tracker/database/expense_dao.dart';
// import 'package:expense_tracker/ui/screens/login/login_sc.dart';
// import 'package:expense_tracker/utilities/dialogs.dart';
//
// class AuthenticationProvider extends ChangeNotifier {
//   User? firebaseAuthenticationUser;
//   MyUser.User? databaseUser;
//
//
//
//   /* Firstly, the "register" method is called to create an authenticated user.
//    The "createUserWithEmailAndPassword" method returns a "UserCredential" and stores it into "credential".
//   Now, "credential" holds the result of the authentication operation, which includes information about
//   the newly-created user. */
//   Future<void> register(String emailController, String passwordController,
//       String usernameController, String role) async {
//     final credential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//             email: emailController, password: passwordController);
//
// /* Secondly: using the data passed into the "register" function,
//   the "createUser" method creates a document within the "users" collection with the information passed to it.
//  Note that the "uid" of that specific newly-created user is passed into the "id" parameter.
//  "user?" is a method that is called on the "credential" variable, which holds an object of the class "UserCredential".
//  This method returns a "User?", which holds more information and methods about the "UserCredential"
//   object it was called on; in this case, "credential". */
//     await UsersDAO.createUser(
//     MyUser.User(
//         id: credential.user?.uid,
//         email: emailController
//         ));
//   }
//
//   Future<void> login(String emailController, String passwordController,
//       BuildContext context) async {
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController, password: passwordController);
//
//     var user = await UsersDAO.getUser(credential.user!.uid);
//     updateDatabaseUser(user);
//     /// databaseUser = user;
//     firebaseAuthenticationUser = credential.user;
//
//     try {
//      Navigator.pushReplacementNamed (context, ExpensesScreen.routeName);
//      } catch (e) {
//        print("${e.message}");
//        }
//
//   logout(BuildContext context) async {
//     updateDatabaseUser(null);
//     firebaseAuthenticationUser = null;
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
//   }
//
//   void updateDatabaseUser (MyUser.User? user) {
//     databaseUser = user;
//     notifyListeners();
// }
//
//   bool alreadyLoggedIn () {
//     return FirebaseAuth.instance.currentUser != null;
//   }
//
//   Future<void> retrieveUserFromDatabase () async {
//     firebaseAuthenticationUser = FirebaseAuth.instance.currentUser;
//     databaseUser = await UsersDAO.getUser(firebaseAuthenticationUser!.uid);
//   }
// }
