class AchievementModel {
  final String id;
  final int current;
  final int target;
  final bool completed;
  final int points;

  const AchievementModel({
    required this.id,
    required this.current,
    required this.target,
    required this.completed,
    required this.points,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] ?? '',
      current: (json['current'] ?? 0).toInt(),
      target: (json['target'] ?? 0).toInt(),
      completed: json['completed'] ?? false,
      points: (json['points'] ?? 0).toInt(),
    );
  }
}

class RewardModel {
  final int totalPoints;
  final String level;
  final int rank;
  final String referralCode;
  final int referralCount;
  final int referralPoints;
  final List<AchievementModel> achievements;

  const RewardModel({
    required this.totalPoints,
    required this.level,
    required this.rank,
    required this.referralCode,
    required this.referralCount,
    required this.referralPoints,
    required this.achievements,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      totalPoints: (json['totalPoints'] ?? 0).toInt(),
      level: json['level'] ?? '',
      rank: (json['rank'] ?? 0).toInt(),
      referralCode: json['referralCode'] ?? '',
      referralCount: (json['referralCount'] ?? 0).toInt(),
      referralPoints: (json['referralPoints'] ?? 0).toInt(),
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => AchievementModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
