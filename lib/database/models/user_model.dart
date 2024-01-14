class User {
  String? id;
  String? username;
  String? email;

  User ({
    this.id,
    this.email,
    this.username,
  });

  User.fromFirestore (Map<String, dynamic>? data) {
    id = data?['id'];
    username = data?['username'];
    email = data?['email'];
  }

  Map<String, dynamic> toFirestore () {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

}