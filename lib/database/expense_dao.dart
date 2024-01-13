// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:quizzler/database/models/expense_model.dart';
// import 'package:quizzler/database/models/user_model.dart';
// import 'package:quizzler/database/user_dao.dart';
//
// class QuizDAO {
//
//   static CollectionReference<Quiz> getQuizzesCollection (String uid) {
//     return UsersDAO.usersCollection.doc(uid).collection("quizzes").withConverter(
//         fromFirestore: (snapshot, options) => Quiz.fromFirestore(snapshot.data()),
//         toFirestore: (quiz, options) => quiz.toFirestore(),
//     );
//   }
//
//   static Future <void> createQuiz (Quiz quiz, String uid) {
//     var docRef = getQuizzesCollection(uid).doc();
//     quiz.id = docRef.id;
//     return docRef.set(quiz);
//
//   }
// }
// /*
// Containing class: CollectionReference
// DocumentReference<User> doc([String? path])
// Type: DocumentReference<User> Function([String?])
// Returns a DocumentReference with the provided path.
// If no path is provided, an auto-generated ID is used.
// The unique key generated is prefixed with a client-generated timestamp so that the resulting list will be chronologically-sorted.
// */
//
// /*
// Containing class: DocumentReference
// Future<void> set(User data, [SetOptions? options])
// Type: Future<void> Function(User, [SetOptions?])
// Sets data on the document, overwriting any existing data. If the document does not yet exist, it will be created.
// If SetOptions are provided, the data can be merged into an existing document instead of overwriting.
// */
//
// /*
// Containing class: DocumentReference
// Future<DocumentSnapshot<User>> get([GetOptions? options])
// Type: Future<DocumentSnapshot<User>> Function([GetOptions?])
// Reads the document referenced by this DocumentReference.
// By providing options, this method can be configured to
//  fetch results only from the server,
//  only from the local cache, or
//  attempt to fetch results from the server and fall back to the cache (the default).
// */
