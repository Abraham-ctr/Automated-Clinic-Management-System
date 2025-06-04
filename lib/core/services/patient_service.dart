import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  final CollectionReference _patientsCollection =
      FirebaseFirestore.instance.collection('patients');

  // Create/Update a full patient record
  Future<void> savePatient(Patient patient) async {
    try {
      await _patientsCollection
          .doc(patient.biodata.matricNumber)
          .set(patient.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw "Failed to save patient: ${e.message}";
    }
  }

  // Create/Update only biodata
  Future<void> saveBiodata(PatientBiodata biodata) async {
    try {
      await _patientsCollection
          .doc(biodata.matricNumber)
          .set(biodata.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw "Failed to save biodata: ${e.message}";
    }
  }

  // Add/Update medical test data
  Future<void> saveMedicalTest({
    required String matricNumber,
    required PatientMedicalTest medicalTest,
  }) async {
    try {
      await _patientsCollection
          .doc(matricNumber)
          .set(medicalTest.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw "Failed to save medical test: ${e.message}";
    }
  }

  // Get patient by matric number
  Future<Patient?> getPatient(String matricNumber) async {
    try {
      final snapshot = await _patientsCollection.doc(matricNumber).get();
      if (snapshot.exists) {
        return Patient.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseException catch (e) {
      throw "Failed to get patient: ${e.message}";
    }
  }

  // Get only biodata
  Future<PatientBiodata?> getBiodata(String matricNumber) async {
    try {
      final snapshot = await _patientsCollection.doc(matricNumber).get();
      if (snapshot.exists) {
        return PatientBiodata.fromMap(
            snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseException catch (e) {
      throw "Failed to get biodata: ${e.message}";
    }
  }

  // Get only medical test data
  Future<PatientMedicalTest?> getMedicalTest(String matricNumber) async {
    try {
      final snapshot = await _patientsCollection.doc(matricNumber).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return PatientMedicalTest(
          heightMeters: data['heightMeters'],
          heightCm: data['heightCm'],
          weightKg: data['weightKg'],
          weightG: data['weightG'],
          visualAcuityWithoutGlassesRight: data['visualAcuityWithoutGlassesRight'],
          visualAcuityWithoutGlassesLeft: data['visualAcuityWithoutGlassesLeft'],
          visualAcuityWithGlassesRight: data['visualAcuityWithGlassesRight'],
          visualAcuityWithGlassesLeft: data['visualAcuityWithGlassesLeft'],
          hearingLeft: data['hearingLeft'],
          hearingRight: data['hearingRight'],
          heart: data['heart'],
          bloodPressure: data['bloodPressure'],
          eyes: data['eyes'],
          respiratorySystem: data['respiratorySystem'],
          pharynx: data['pharynx'],
          lungs: data['lungs'],
          teeth: data['teeth'],
          liver: data['liver'],
          lymphaticGlands: data['lymphaticGlands'],
          spleen: data['spleen'],
          skin: data['skin'],
          hernia: data['hernia'],
          papillaryReflex: data['papillaryReflex'],
          spinalReflex: data['spinalReflex'],
          urineAlbumin: data['urineAlbumin'],
          urineSugar: data['urineSugar'],
          urineProtein: data['urineProtein'],
          stoolOccultBlood: data['stoolOccultBlood'],
          stoolMicroscope: data['stoolMicroscope'],
          stoolOvaOrCyst: data['stoolOvaOrCyst'],
          bloodHb: data['bloodHb'],
          bloodGroup: data['bloodGroup'],
          genotype: data['genotype'],
          vdrlTest: data['vdrlTest'],
          chestXRayFilmNo: data['chestXRayFilmNo'],
          chestXRayHospital: data['chestXRayHospital'],
          chestXRayReport: data['chestXRayReport'],
          otherObservation: data['otherObservation'],
          remarks: data['remarks'],
          testDate: (data['testDate'] as Timestamp).toDate(),
          medicalOfficerName: data['medicalOfficerName'],
          hospitalAddress: data['hospitalAddress'],
        );
      }
      return null;
    } on FirebaseException catch (e) {
      throw "Failed to get medical test: ${e.message}";
    }
  }

  // Check if matric number exists
  Future<bool> matricNumberExists(String matricNumber) async {
    try {
      final snapshot = await _patientsCollection.doc(matricNumber).get();
      return snapshot.exists;
    } on FirebaseException {
      return false;
    }
  }

  // Get all patients (paginated)
  Stream<List<PatientBiodata>> getPatients({int limit = 20}) {
    return _patientsCollection
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PatientBiodata.fromMap(
                doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Search patients by name or matric number
  Stream<List<PatientBiodata>> searchPatients(String query) {
    return _patientsCollection
        .where('matricNumber', isGreaterThanOrEqualTo: query)
        .where('matricNumber', isLessThan: '${query}z')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PatientBiodata.fromMap(
                doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Delete patient
  Future<void> deletePatient(String matricNumber) async {
    try {
      await _patientsCollection.doc(matricNumber).delete();
    } on FirebaseException catch (e) {
      throw "Failed to delete patient: ${e.message}";
    }
  }

  // Update specific fields
  Future<void> updateFields({
    required String matricNumber,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _patientsCollection.doc(matricNumber).update(updates);
    } on FirebaseException catch (e) {
      throw "Failed to update patient: ${e.message}";
    }
  }
}