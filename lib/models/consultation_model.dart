class Consultation {
  final String id;
  final String patientId; // link to Patient
  final String symptoms;
  final String diagnosis;
  final String treatment;
  final String doctorName;
  final DateTime consultationDate;
  final String notes;

  Consultation({
    required this.id,
    required this.patientId,
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.doctorName,
    required this.consultationDate,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'doctorName': doctorName,
      'consultationDate': consultationDate.toIso8601String(),
      'notes': notes,
    };
  }

  factory Consultation.fromMap(Map<String, dynamic> map) {
    return Consultation(
      id: map['id'],
      patientId: map['patientId'],
      symptoms: map['symptoms'],
      diagnosis: map['diagnosis'],
      treatment: map['treatment'],
      doctorName: map['doctorName'],
      consultationDate: DateTime.parse(map['consultationDate']),
      notes: map['notes'],
    );
  }
}
