class RewardModel {
  final int totalPoints;
  final String level;
  final int rank;
  final int completedTrips;
  final int targetTrips;

  const RewardModel({
    required this.totalPoints,
    required this.level,
    required this.rank,
    required this.completedTrips,
    required this.targetTrips,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      totalPoints: (json['totalPoints'] ?? 0).toInt(),
      level: json['level'] ?? '',
      rank: (json['rank'] ?? 0).toInt(),
      completedTrips: (json['completedTrips'] ?? 0).toInt(),
      targetTrips: (json['targetTrips'] ?? 0).toInt(),
    );
  }

  double get progress => targetTrips > 0 ? completedTrips / targetTrips : 0.0;
}
