import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/database/models/expense_model.dart';
import 'package:expense_tracker/database/user_dao.dart';

class ExpenseDAO {

  static CollectionReference<Expense> getExpensesCollection (String uid) {
    return UsersDAO.usersCollection.doc(uid).collection("expenses").withConverter(
        fromFirestore: (snapshot, options) => Expense.fromFirestore(snapshot.data()),
        toFirestore: (expense, options) => expense.toFirestore(),
    );
  }

  static Future <void> createExpense (Expense expense, String uid) {
    var docRef = getExpensesCollection(uid).doc();
    expense.id = docRef.id;
    return docRef.set(expense);

  }

  static Future<List<Expense>> getAllExpenses (String uid) async {
    var expensesSnapshot = await getExpensesCollection(uid).get();
    var expensesList = expensesSnapshot.docs.map((snapshot) => snapshot.data()).toList();
    return expensesList;
  }

  static Future<void> deleteExpense (String expenseID, String uid) async {
    return getExpensesCollection(uid).doc(expenseID).delete();

  }

  static Stream<List<Expense>> listenToExpenses(String uid) {
    return getExpensesCollection(uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static Stream<List<Expense>> listenToExpensesByDate(
      String uid,
      DateTime selectedDate,
      ) async* {
    var startDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      0,
      0,
      0,
    );

    var endDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      23,
      59,
      59,
    );

    yield* getExpensesCollection(uid)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // static Stream<List<Expense>> listenToExpenses (String uid) async* {
  //   var stream = getExpensesCollection(uid).snapshots();
  //   yield* stream.map((querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
  // }
}

/*
Containing class: CollectionReference
DocumentReference<User> doc([String? path])
Type: DocumentReference<User> Function([String?])
Returns a DocumentReference with the provided path.
If no path is provided, an auto-generated ID is used.
The unique key generated is prefixed with a client-generated timestamp so that the resulting list will be chronologically-sorted.
*/

/*
Containing class: DocumentReference
Future<void> set(User data, [SetOptions? options])
Type: Future<void> Function(User, [SetOptions?])
Sets data on the document, overwriting any existing data. If the document does not yet exist, it will be created.
If SetOptions are provided, the data can be merged into an existing document instead of overwriting.
*/

/*
Containing class: DocumentReference
Future<DocumentSnapshot<User>> get([GetOptions? options])
Type: Future<DocumentSnapshot<User>> Function([GetOptions?])
Reads the document referenced by this DocumentReference.
By providing options, this method can be configured to
 fetch results only from the server,
 only from the local cache, or
 attempt to fetch results from the server and fall back to the cache (the default).
*/
