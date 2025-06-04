import 'package:cloud_firestore/cloud_firestore.dart';

class PatientBiodata {
  final String matricNumber;
  final String surname;
  final String firstName;
  final String otherNames;
  final DateTime dateOfBirth;
  final String sex;
  final String maritalStatus;
  final String nationality;
  final String placeOfBirth;
  final String phoneNumber;
  final String department;
  final String programme;
  final String nameOfParentOrGuardian;
  final String phoneNumberOfParentOrGuardian;
  final String nameOfNextOfKin;
  final String phoneNumberOfNextOfKin;

  PatientBiodata({
    required this.matricNumber,
    required this.surname,
    required this.firstName,
    required this.otherNames,
    required this.dateOfBirth,
    required this.sex,
    required this.maritalStatus,
    required this.nationality,
    required this.placeOfBirth,
    required this.phoneNumber,
    required this.department,
    required this.programme,
    required this.nameOfParentOrGuardian,
    required this.phoneNumberOfParentOrGuardian,
    required this.nameOfNextOfKin,
    required this.phoneNumberOfNextOfKin,
  });

  Map<String, dynamic> toMap() {
    return {
      'matricNumber': matricNumber,
      'surname': surname,
      'firstName': firstName,
      'otherNames': otherNames,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'sex': sex,
      'maritalStatus': maritalStatus,
      'nationality': nationality,
      'placeOfBirth': placeOfBirth,
      'phoneNumber': phoneNumber,
      'department': department,
      'programme': programme,
      'nameOfParentOrGuardian': nameOfParentOrGuardian,
      'phoneNumberOfParentOrGuardian': phoneNumberOfParentOrGuardian,
      'nameOfNextOfKin': nameOfNextOfKin,
      'phoneNumberOfNextOfKin': phoneNumberOfNextOfKin,
    };
  }

  factory PatientBiodata.fromMap(Map<String, dynamic> map) {
    return PatientBiodata(
      matricNumber: map['matricNumber'],
      surname: map['surname'],
      firstName: map['firstName'],
      otherNames: map['otherNames'],
      dateOfBirth: (map['dateOfBirth'] as Timestamp).toDate(),
      sex: map['sex'],
      maritalStatus: map['maritalStatus'],
      nationality: map['nationality'],
      placeOfBirth: map['placeOfBirth'],
      phoneNumber: map['phoneNumber'],
      department: map['department'],
      programme: map['programme'],
      nameOfParentOrGuardian: map['nameOfParentOrGuardian'],
      phoneNumberOfParentOrGuardian: map['phoneNumberOfParentOrGuardian'],
      nameOfNextOfKin: map['nameOfNextOfKin'],
      phoneNumberOfNextOfKin: map['phoneNumberOfNextOfKin'],
    );
  }
}

class PatientMedicalTest {
  final int heightMeters;
  final int heightCm;
  final int weightKg;
  final int weightG;
  final String visualAcuityWithoutGlassesRight;
  final String visualAcuityWithoutGlassesLeft;
  final String visualAcuityWithGlassesRight;
  final String visualAcuityWithGlassesLeft;
  final String hearingLeft;
  final String hearingRight;
  final String heart;
  final String bloodPressure;
  final String eyes;
  final String respiratorySystem;
  final String pharynx;
  final String lungs;
  final String teeth;
  final String liver;
  final String lymphaticGlands;
  final String spleen;
  final String skin;
  final String hernia;
  final String papillaryReflex;
  final String spinalReflex;
  final String urineAlbumin;
  final String urineSugar;
  final String urineProtein;
  final String stoolOccultBlood;
  final String stoolMicroscope;
  final String stoolOvaOrCyst;
  final String bloodHb;
  final String bloodGroup;
  final String genotype;
  final String vdrlTest;
  final String chestXRayFilmNo;
  final String chestXRayHospital;
  final String chestXRayReport;
  final String otherObservation;
  final String remarks;
  final DateTime testDate;
  final String medicalOfficerName;
  final String hospitalAddress;

  PatientMedicalTest({
    required this.heightMeters,
    required this.heightCm,
    required this.weightKg,
    required this.weightG,
    required this.visualAcuityWithoutGlassesRight,
    required this.visualAcuityWithoutGlassesLeft,
    required this.visualAcuityWithGlassesRight,
    required this.visualAcuityWithGlassesLeft,
    required this.hearingLeft,
    required this.hearingRight,
    required this.heart,
    required this.bloodPressure,
    required this.eyes,
    required this.respiratorySystem,
    required this.pharynx,
    required this.lungs,
    required this.teeth,
    required this.liver,
    required this.lymphaticGlands,
    required this.spleen,
    required this.skin,
    required this.hernia,
    required this.papillaryReflex,
    required this.spinalReflex,
    required this.urineAlbumin,
    required this.urineSugar,
    required this.urineProtein,
    required this.stoolOccultBlood,
    required this.stoolMicroscope,
    required this.stoolOvaOrCyst,
    required this.bloodHb,
    required this.bloodGroup,
    required this.genotype,
    required this.vdrlTest,
    required this.chestXRayFilmNo,
    required this.chestXRayHospital,
    required this.chestXRayReport,
    required this.otherObservation,
    required this.remarks,
    required this.testDate,
    required this.medicalOfficerName,
    required this.hospitalAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'heightMeters': heightMeters,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'weightG': weightG,
      'visualAcuityWithoutGlassesRight': visualAcuityWithoutGlassesRight,
      'visualAcuityWithoutGlassesLeft': visualAcuityWithoutGlassesLeft,
      'visualAcuityWithGlassesRight': visualAcuityWithGlassesRight,
      'visualAcuityWithGlassesLeft': visualAcuityWithGlassesLeft,
      'hearingLeft': hearingLeft,
      'hearingRight': hearingRight,
      'heart': heart,
      'bloodPressure': bloodPressure,
      'eyes': eyes,
      'respiratorySystem': respiratorySystem,
      'pharynx': pharynx,
      'lungs': lungs,
      'teeth': teeth,
      'liver': liver,
      'lymphaticGlands': lymphaticGlands,
      'spleen': spleen,
      'skin': skin,
      'hernia': hernia,
      'papillaryReflex': papillaryReflex,
      'spinalReflex': spinalReflex,
      'urineAlbumin': urineAlbumin,
      'urineSugar': urineSugar,
      'urineProtein': urineProtein,
      'stoolOccultBlood': stoolOccultBlood,
      'stoolMicroscope': stoolMicroscope,
      'stoolOvaOrCyst': stoolOvaOrCyst,
      'bloodHb': bloodHb,
      'bloodGroup': bloodGroup,
      'genotype': genotype,
      'vdrlTest': vdrlTest,
      'chestXRayFilmNo': chestXRayFilmNo,
      'chestXRayHospital': chestXRayHospital,
      'chestXRayReport': chestXRayReport,
      'otherObservation': otherObservation,
      'remarks': remarks,
      'testDate': Timestamp.fromDate(testDate),
      'medicalOfficerName': medicalOfficerName,
      'hospitalAddress': hospitalAddress,
    };
  }
}

class Patient {
  final PatientBiodata biodata;
  final PatientMedicalTest medicalTest;
  final DateTime dateTimeCreated;

  Patient({
    required this.biodata,
    required this.medicalTest,
    required this.dateTimeCreated,
  });

  // Firestore document ID
  String get id => biodata.matricNumber;

  Map<String, dynamic> toMap() {
    return {
      ...biodata.toMap(),
      ...medicalTest.toMap(),
      'dateTimeCreated': Timestamp.fromDate(dateTimeCreated),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      biodata: PatientBiodata.fromMap(map),
      medicalTest: PatientMedicalTest(
        heightMeters: map['heightMeters'],
        heightCm: map['heightCm'],
        weightKg: map['weightKg'],
        weightG: map['weightG'],
        visualAcuityWithoutGlassesRight: map['visualAcuityWithoutGlassesRight'],
        visualAcuityWithoutGlassesLeft: map['visualAcuityWithoutGlassesLeft'],
        visualAcuityWithGlassesRight: map['visualAcuityWithGlassesRight'],
        visualAcuityWithGlassesLeft: map['visualAcuityWithGlassesLeft'],
        hearingLeft: map['hearingLeft'],
        hearingRight: map['hearingRight'],
        heart: map['heart'],
        bloodPressure: map['bloodPressure'],
        eyes: map['eyes'],
        respiratorySystem: map['respiratorySystem'],
        pharynx: map['pharynx'],
        lungs: map['lungs'],
        teeth: map['teeth'],
        liver: map['liver'],
        lymphaticGlands: map['lymphaticGlands'],
        spleen: map['spleen'],
        skin: map['skin'],
        hernia: map['hernia'],
        papillaryReflex: map['papillaryReflex'],
        spinalReflex: map['spinalReflex'],
        urineAlbumin: map['urineAlbumin'],
        urineSugar: map['urineSugar'],
        urineProtein: map['urineProtein'],
        stoolOccultBlood: map['stoolOccultBlood'],
        stoolMicroscope: map['stoolMicroscope'],
        stoolOvaOrCyst: map['stoolOvaOrCyst'],
        bloodHb: map['bloodHb'],
        bloodGroup: map['bloodGroup'],
        genotype: map['genotype'],
        vdrlTest: map['vdrlTest'],
        chestXRayFilmNo: map['chestXRayFilmNo'],
        chestXRayHospital: map['chestXRayHospital'],
        chestXRayReport: map['chestXRayReport'],
        otherObservation: map['otherObservation'],
        remarks: map['remarks'],
        testDate: (map['testDate'] as Timestamp).toDate(),
        medicalOfficerName: map['medicalOfficerName'],
        hospitalAddress: map['hospitalAddress'],
      ),
      dateTimeCreated: (map['dateTimeCreated'] as Timestamp).toDate(),
    );
  }
}
