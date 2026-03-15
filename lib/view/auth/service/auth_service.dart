import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../res/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Attempts to sign in with [email] and [password].
  /// Returns the [UserModel] from Firestore on success.
  /// Throws [FirebaseAuthException] on failure.
  Future<UserModel> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return getUserProfile(credential.user!.uid);
  }

  /// Creates a new Firebase Auth account, then writes the user document
  /// to Firestore under users/{uid}. Password is never stored.
  /// Throws [FirebaseAuthException] on failure.
  Future<UserModel> register(
    String email,
    String password,
    String username,
    String birthday,
  ) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      uid: credential.user!.uid,
      email: email,
      username: username,
      birthday: birthday,
    );
    await _createUserDocument(user);
    return user;
  }

  /// Reads the user document from Firestore and returns a [UserModel].
  /// Throws a plain [Exception] if the document does not exist.
  Future<UserModel> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) {
      throw Exception('User profile not found');
    }
    return UserModel.fromMap(uid, doc.data()!);
  }

  /// Signs out the current user from Firebase Auth.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _createUserDocument(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }
}
