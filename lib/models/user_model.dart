import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String surname;
  final String firstName;
  final String middleName;
  final String email;
  final String phoneNumber;
  final String regNumber;
  final String gender;
  final String role;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.email,
    required this.phoneNumber,
    required this.regNumber,
    required this.gender,
    required this.role,
    required this.createdAt,
  });

  // Convert instance to Firestore document
  Map<String, dynamic> toMap() {
    return {
      "surname": surname,
      "firstName": firstName,
      "middleName": middleName,
      "email": email,
      "phoneNumber": phoneNumber,
      "regNumber": regNumber,
      "gender": gender,
      "role": role,
      "createdAt": createdAt,
    };
  }

  // Factory method to create an instance from Firestore data
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      surname: data['surname'] ?? '',
      firstName: data['firstName'] ?? '',
      middleName: data['middleName'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      regNumber: data['regNumber'] ?? '',
      gender: data['gender'] ?? '',
      role: data['role'] ?? 'nurse',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
