class UserModel {
  final String uid;
  final String email;
  final String username;
  final String birthday;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.birthday,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) => UserModel(
    uid: uid,
    email: map['email'] as String,
    username: map['username'] as String,
    birthday: map['birthday'] as String,
  );

  // uid is stored as the Firestore document ID, NOT as a field.
  // Password is never stored.
  Map<String, dynamic> toMap() => {
    'email': email,
    'username': username,
    'birthday': birthday,
  };
}
