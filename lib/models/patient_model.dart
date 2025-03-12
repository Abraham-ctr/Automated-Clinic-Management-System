class Patient {
  String id;
  String fullName;
  String registrationNumber;
  String dob;
  String gender;
  String phone;
  String email;
  String address;
  String bloodGroup;
  String genotype;
  List<String> allergies;
  List<String> chronicConditions;
  Map<String, String> emergencyContact;
  String fitnessReportStatus; // e.g., "Cleared", "Pending"
  String fitnessReportHospital; // Name of the hospital
  String fitnessReportDate; // Date of fitness test

  Patient({
    required this.id,
    required this.fullName,
    required this.registrationNumber,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.bloodGroup,
    required this.genotype,
    required this.allergies,
    required this.chronicConditions,
    required this.emergencyContact,
    required this.fitnessReportStatus,
    required this.fitnessReportHospital,
    required this.fitnessReportDate,
  });

  // Convert to Firestore format
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "registrationNumber": registrationNumber,
      "dob": dob,
      "gender": gender,
      "phone": phone,
      "email": email,
      "address": address,
      "bloodGroup": bloodGroup,
      "genotype": genotype,
      "allergies": allergies,
      "chronicConditions": chronicConditions,
      "emergencyContact": emergencyContact,
      "fitnessReportStatus": fitnessReportStatus,
      "fitnessReportHospital": fitnessReportHospital,
      "fitnessReportDate": fitnessReportDate,
    };
  }

  // Convert Firestore data to Patient object
  factory Patient.fromMap(Map<String, dynamic> map, String documentId) {
    return Patient(
      id: documentId,
      fullName: map["fullName"],
      registrationNumber: map["registrationNumber"],
      dob: map["dob"],
      gender: map["gender"],
      phone: map["phone"],
      email: map["email"],
      address: map["address"],
      bloodGroup: map["bloodGroup"],
      genotype: map["genotype"],
      allergies: List<String>.from(map["allergies"]),
      chronicConditions: List<String>.from(map["chronicConditions"]),
      emergencyContact: Map<String, String>.from(map["emergencyContact"]),
      fitnessReportStatus: map["fitnessReportStatus"],
      fitnessReportHospital: map["fitnessReportHospital"],
      fitnessReportDate: map["fitnessReportDate"],
    );
  }
}
