class Patient {
  final String id;
  final String surname;
  final String firstName;
  final String middleName;
  final String email;
  final String phoneNumber;
  final String registrationNumber;
  final String department;
  final String course;
  final Map<String, dynamic> part1Data; // Holds Part 1 fields (optional, based on your setup)

  // Part 2 fields
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
  final DateTime date;
  final String medicalOfficerName;
  final String hospitalAddress;

  Patient({
    required this.id,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.email,
    required this.phoneNumber,
    required this.registrationNumber,
    required this.department,
    required this.course,
    required this.part1Data,
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
    required this.date,
    required this.medicalOfficerName,
    required this.hospitalAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surname': surname,
      'firstName': firstName,
      'middleName': middleName,
      'email': email,
      'phoneNumber': phoneNumber,
      'registrationNumber': registrationNumber,
      'department': department,
      'course': course,
      'part1Data': part1Data,
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
      'date': date.toIso8601String(),
      'medicalOfficerName': medicalOfficerName,
      'hospitalAddress': hospitalAddress,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      surname: map['surname'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      registrationNumber: map['registrationNumber'],
      department: map['department'],
      course: map['course'],
      part1Data: Map<String, dynamic>.from(map['part1Data']),
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
      date: DateTime.parse(map['date']),
      medicalOfficerName: map['medicalOfficerName'],
      hospitalAddress: map['hospitalAddress'],
    );
  }
}
