class DriverReviewModel {
  final String studentName;
  final String? studentProfilePicture;
  final int score;
  final String comment;
  final List<String> tags;
  final DateTime createdAt;

  const DriverReviewModel({
    required this.studentName,
    this.studentProfilePicture,
    required this.score,
    required this.comment,
    required this.tags,
    required this.createdAt,
  });

  factory DriverReviewModel.fromJson(Map<String, dynamic> json) {
    return DriverReviewModel(
      studentName:           json['studentName'] ?? json['StudentName'] ?? json['fullName'] ?? json['FullName'] ?? json['name'] ?? json['Name'] ?? '',
      studentProfilePicture: json['studentProfilePicture'] ?? json['StudentProfilePicture'],
      score:                 (json['score']                ?? json['Score']                ?? 0).toInt(),
      comment:               json['comment']               ?? json['Comment']               ?? '',
      tags:                  _parseTags(json['tags']       ?? json['Tags']       ?? json['feedbackTags'] ?? json['FeedbackTags'] ?? []),
      createdAt:             DateTime.tryParse(json['createdAt'] ?? json['CreatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  static List<String> _parseTags(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    if (raw is String && raw.isNotEmpty) return raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return [];
  }
}

class DriverReviewsResponse {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> breakdown;
  final List<DriverReviewModel> reviews;

  const DriverReviewsResponse({
    required this.averageRating,
    required this.totalReviews,
    required this.breakdown,
    required this.reviews,
  });

  factory DriverReviewsResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['breakdown'] as Map<String, dynamic>? ?? {};
    final breakdown = <int, int>{};
    for (final e in raw.entries) {
      final key = int.tryParse(e.key);
      if (key != null) breakdown[key] = (e.value ?? 0).toInt();
    }
    return DriverReviewsResponse(
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews:  (json['totalReviews']  ?? 0).toInt(),
      breakdown:     breakdown,
      reviews:       (json['reviews'] as List? ?? [])
                         .map((e) => DriverReviewModel.fromJson(e))
                         .toList(),
    );
  }
}
