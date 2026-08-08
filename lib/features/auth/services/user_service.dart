import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get _usernames =>
      _firestore.collection('usernames');

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> createUser(UserModel user) async {
    await _users.doc(user.uid).set(
      user.toMap(),
    );
  }

  Future<bool> isUsernameAvailable(String username) async {
    final doc = await _usernames.doc(username).get();

    return !doc.exists;
  }

  Future<void> updateUsername(String uid, String username) async {
    await _users.doc(uid).update({
      'username': username,
    });

    await _usernames.doc(username).set({
      'uid': uid,
    });
  }
}