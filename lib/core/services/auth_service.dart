import 'package:automated_clinic_management_system/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel> registerUser(
      {required String surname,
      required String firstName,
      required String middleName,
      required String email,
      required String phoneNumber,
      required String regNumber,
      required String gender,
      required String role,
      required String password}) async {
    final userCred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final uid = userCred.user!.uid;
    final user = UserModel(
        uid: uid,
        surname: surname,
        firstName: firstName,
        middleName: middleName,
        email: email,
        phoneNumber: phoneNumber,
        regNumber: regNumber,
        gender: gender,
        role: role,
        createdAt: Timestamp.now());

    await _firestore.collection('users').doc(uid).set(user.toMap());
    return user;
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!, user.uid);
  }

  Future<User?> login(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> logout() async {
    _auth.signOut();
  }
}
