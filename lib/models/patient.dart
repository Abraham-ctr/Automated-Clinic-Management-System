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

  PatientBiodata copyWith({
    String? matricNumber,
    String? surname,
    String? firstName,
    String? otherNames,
    DateTime? dateOfBirth,
    String? sex,
    String? maritalStatus,
    String? nationality,
    String? placeOfBirth,
    String? phoneNumber,
    String? department,
    String? programme,
    String? nameOfParentOrGuardian,
    String? phoneNumberOfParentOrGuardian,
    String? nameOfNextOfKin,
    String? phoneNumberOfNextOfKin,
  }) {
    return PatientBiodata(
      matricNumber: matricNumber ?? this.matricNumber,
      surname: surname ?? this.surname,
      firstName: firstName ?? this.firstName,
      otherNames: otherNames ?? this.otherNames,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      nationality: nationality ?? this.nationality,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      department: department ?? this.department,
      programme: programme ?? this.programme,
      nameOfParentOrGuardian:
          nameOfParentOrGuardian ?? this.nameOfParentOrGuardian,
      phoneNumberOfParentOrGuardian:
          phoneNumberOfParentOrGuardian ?? this.phoneNumberOfParentOrGuardian,
      nameOfNextOfKin: nameOfNextOfKin ?? this.nameOfNextOfKin,
      phoneNumberOfNextOfKin:
          phoneNumberOfNextOfKin ?? this.phoneNumberOfNextOfKin,
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

  factory PatientMedicalTest.fromMap(Map<String, dynamic> map) {
    return PatientMedicalTest(
      heightMeters: map['heightMeters'] ?? 0,
      heightCm: map['heightCm'] ?? 0,
      weightKg: map['weightKg'] ?? 0,
      weightG: map['weightG'] ?? 0,
      visualAcuityWithoutGlassesRight:
          map['visualAcuityWithoutGlassesRight'] ?? 'Not yet provided',
      visualAcuityWithoutGlassesLeft:
          map['visualAcuityWithoutGlassesLeft'] ?? 'Not yet provided',
      visualAcuityWithGlassesRight:
          map['visualAcuityWithGlassesRight'] ?? 'Not yet provided',
      visualAcuityWithGlassesLeft:
          map['visualAcuityWithGlassesLeft'] ?? 'Not yet provided',
      hearingLeft: map['hearingLeft'] ?? 'Not yet provided',
      hearingRight: map['hearingRight'] ?? 'Not yet provided',
      heart: map['heart'] ?? 'Not yet provided',
      bloodPressure: map['bloodPressure'] ?? 'Not yet provided',
      eyes: map['eyes'] ?? 'Not yet provided',
      respiratorySystem: map['respiratorySystem'] ?? 'Not yet provided',
      pharynx: map['pharynx'] ?? 'Not yet provided',
      lungs: map['lungs'] ?? 'Not yet provided',
      teeth: map['teeth'] ?? 'Not yet provided',
      liver: map['liver'] ?? 'Not yet provided',
      lymphaticGlands: map['lymphaticGlands'] ?? 'Not yet provided',
      spleen: map['spleen'] ?? 'Not yet provided',
      skin: map['skin'] ?? 'Not yet provided',
      hernia: map['hernia'] ?? 'Not yet provided',
      papillaryReflex: map['papillaryReflex'] ?? 'Not yet provided',
      spinalReflex: map['spinalReflex'] ?? 'Not yet provided',
      urineAlbumin: map['urineAlbumin'] ?? 'Not yet provided',
      urineSugar: map['urineSugar'] ?? 'Not yet provided',
      urineProtein: map['urineProtein'] ?? 'Not yet provided',
      stoolOccultBlood: map['stoolOccultBlood'] ?? 'Not yet provided',
      stoolMicroscope: map['stoolMicroscope'] ?? 'Not yet provided',
      stoolOvaOrCyst: map['stoolOvaOrCyst'] ?? 'Not yet provided',
      bloodHb: map['bloodHb'] ?? 'Not yet provided',
      bloodGroup: map['bloodGroup'] ?? 'Not yet provided',
      genotype: map['genotype'] ?? 'Not yet provided',
      vdrlTest: map['vdrlTest'] ?? 'Not yet provided',
      chestXRayFilmNo: map['chestXRayFilmNo'] ?? 'Not yet provided',
      chestXRayHospital: map['chestXRayHospital'] ?? 'Not yet provided',
      chestXRayReport: map['chestXRayReport'] ?? 'Not yet provided',
      otherObservation: map['otherObservation'] ?? 'Not yet provided',
      remarks: map['remarks'] ?? 'Not yet provided',
      testDate: (map['testDate'] as Timestamp?)?.toDate() ?? DateTime(2000),
      medicalOfficerName: map['medicalOfficerName'] ?? 'Not yet provided',
      hospitalAddress: map['hospitalAddress'] ?? 'Not yet provided',
    );
  }

  PatientMedicalTest copyWith({
    int? heightMeters,
    int? heightCm,
    int? weightKg,
    int? weightG,
    String? visualAcuityWithoutGlassesRight,
    String? visualAcuityWithoutGlassesLeft,
    String? visualAcuityWithGlassesRight,
    String? visualAcuityWithGlassesLeft,
    String? hearingLeft,
    String? hearingRight,
    String? heart,
    String? bloodPressure,
    String? eyes,
    String? respiratorySystem,
    String? pharynx,
    String? lungs,
    String? teeth,
    String? liver,
    String? lymphaticGlands,
    String? spleen,
    String? skin,
    String? hernia,
    String? papillaryReflex,
    String? spinalReflex,
    String? urineAlbumin,
    String? urineSugar,
    String? urineProtein,
    String? stoolOccultBlood,
    String? stoolMicroscope,
    String? stoolOvaOrCyst,
    String? bloodHb,
    String? bloodGroup,
    String? genotype,
    String? vdrlTest,
    String? chestXRayFilmNo,
    String? chestXRayHospital,
    String? chestXRayReport,
    String? otherObservation,
    String? remarks,
    DateTime? testDate,
    String? medicalOfficerName,
    String? hospitalAddress,
  }) {
    return PatientMedicalTest(
      heightMeters: heightMeters ?? this.heightMeters,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      weightG: weightG ?? this.weightG,
      visualAcuityWithoutGlassesRight: visualAcuityWithoutGlassesRight ??
          this.visualAcuityWithoutGlassesRight,
      visualAcuityWithoutGlassesLeft:
          visualAcuityWithoutGlassesLeft ?? this.visualAcuityWithoutGlassesLeft,
      visualAcuityWithGlassesRight:
          visualAcuityWithGlassesRight ?? this.visualAcuityWithGlassesRight,
      visualAcuityWithGlassesLeft:
          visualAcuityWithGlassesLeft ?? this.visualAcuityWithGlassesLeft,
      hearingLeft: hearingLeft ?? this.hearingLeft,
      hearingRight: hearingRight ?? this.hearingRight,
      heart: heart ?? this.heart,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      eyes: eyes ?? this.eyes,
      respiratorySystem: respiratorySystem ?? this.respiratorySystem,
      pharynx: pharynx ?? this.pharynx,
      lungs: lungs ?? this.lungs,
      teeth: teeth ?? this.teeth,
      liver: liver ?? this.liver,
      lymphaticGlands: lymphaticGlands ?? this.lymphaticGlands,
      spleen: spleen ?? this.spleen,
      skin: skin ?? this.skin,
      hernia: hernia ?? this.hernia,
      papillaryReflex: papillaryReflex ?? this.papillaryReflex,
      spinalReflex: spinalReflex ?? this.spinalReflex,
      urineAlbumin: urineAlbumin ?? this.urineAlbumin,
      urineSugar: urineSugar ?? this.urineSugar,
      urineProtein: urineProtein ?? this.urineProtein,
      stoolOccultBlood: stoolOccultBlood ?? this.stoolOccultBlood,
      stoolMicroscope: stoolMicroscope ?? this.stoolMicroscope,
      stoolOvaOrCyst: stoolOvaOrCyst ?? this.stoolOvaOrCyst,
      bloodHb: bloodHb ?? this.bloodHb,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      genotype: genotype ?? this.genotype,
      vdrlTest: vdrlTest ?? this.vdrlTest,
      chestXRayFilmNo: chestXRayFilmNo ?? this.chestXRayFilmNo,
      chestXRayHospital: chestXRayHospital ?? this.chestXRayHospital,
      chestXRayReport: chestXRayReport ?? this.chestXRayReport,
      otherObservation: otherObservation ?? this.otherObservation,
      remarks: remarks ?? this.remarks,
      testDate: testDate ?? this.testDate,
      medicalOfficerName: medicalOfficerName ?? this.medicalOfficerName,
      hospitalAddress: hospitalAddress ?? this.hospitalAddress,
    );
  }
}

class Patient {
  final PatientBiodata biodata;
  final PatientMedicalTest medicalTest;

  Patient({
    required this.biodata,
    required this.medicalTest,
  });

  Map<String, dynamic> toMap() {
    return {
      'biodata': biodata.toMap(),
      'medicalTest': medicalTest.toMap(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      biodata: PatientBiodata.fromMap(map['biodata'] ?? {}),
      medicalTest: map['medicalTest'] != null
          ? PatientMedicalTest.fromMap(map['medicalTest'])
          : PatientMedicalTest.fromMap({}), // fallback to empty map
    );
  }

  Patient copyWith({
    PatientBiodata? biodata,
    PatientMedicalTest? medicalTest,
  }) {
    return Patient(
      biodata: biodata ?? this.biodata,
      medicalTest: medicalTest ?? this.medicalTest,
    );
  }
}
