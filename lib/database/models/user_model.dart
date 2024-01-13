// class User {
//   String? id;
//   String? username;
//   String? role;
//   String? email;
//
//   User ({
//     this.id,
//     this.email,
//     this.username,
//     this.role
//   });
//
//   User.fromFirestore (Map<String, dynamic>? data) {
//     id = data?['id'];
//     username = data?['username'];
//     email = data?['email'];
//     role = data?['role'];
//   }
//
//   Map<String, dynamic> toFirestore () {
//     return {
//       'id': id,
//       'username': username,
//       'email': email,
//       'role': role
//     };
//   }
//
// }