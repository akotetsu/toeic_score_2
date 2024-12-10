// lib/models/study_record.dart

class TOEICStudyRecord {
  final String testDate;
  final String session; // 午前 or 午後
  final String testCenter;
  final int listeningScore;
  final int readingScore;
  final String notes;

  TOEICStudyRecord({
    required this.testDate,
    required this.session,
    required this.testCenter,
    required this.listeningScore,
    required this.readingScore,
    required this.notes,
  });
}
