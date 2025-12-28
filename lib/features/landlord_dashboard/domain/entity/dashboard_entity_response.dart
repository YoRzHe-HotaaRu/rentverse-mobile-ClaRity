class DashboardResponseEntity {
  final OverviewEntity overview;

  DashboardResponseEntity({required this.overview});

  factory DashboardResponseEntity.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final overviewJson = data['overview'] as Map<String, dynamic>? ?? {};
    return DashboardResponseEntity(
      overview: OverviewEntity.fromJson(overviewJson),
    );
  }
}

class OverviewEntity {
  final TotalIncomeEntity totalIncome;
  final OccupancyEntity occupancy;
  final TrustEntity trust;
  final InventoryEntity inventory;

  OverviewEntity({
    required this.totalIncome,
    required this.occupancy,
    required this.trust,
    required this.inventory,
  });

  factory OverviewEntity.fromJson(Map<String, dynamic> json) => OverviewEntity(
    totalIncome: TotalIncomeEntity.fromJson(
      json['totalIncome'] as Map<String, dynamic>? ?? {},
    ),
    occupancy: OccupancyEntity.fromJson(
      json['occupancy'] as Map<String, dynamic>? ?? {},
    ),
    trust: TrustEntity.fromJson(json['trust'] as Map<String, dynamic>? ?? {}),
    inventory: InventoryEntity.fromJson(
      json['inventory'] as Map<String, dynamic>? ?? {},
    ),
  );
}

class TotalIncomeEntity {
  final num amount;
  final String currency;
  final String label;

  TotalIncomeEntity({
    required this.amount,
    required this.currency,
    required this.label,
  });

  factory TotalIncomeEntity.fromJson(Map<String, dynamic> json) =>
      TotalIncomeEntity(
        amount: json['amount'] as num? ?? 0,
        currency: json['currency'] as String? ?? '',
        label: json['label'] as String? ?? '',
      );
}

class OccupancyEntity {
  final int active;
  final int pending;
  final String label;

  OccupancyEntity({
    required this.active,
    required this.pending,
    required this.label,
  });

  factory OccupancyEntity.fromJson(Map<String, dynamic> json) =>
      OccupancyEntity(
        active: (json['active'] as num?)?.toInt() ?? 0,
        pending: (json['pending'] as num?)?.toInt() ?? 0,
        label: json['label'] as String? ?? '',
      );
}

class TrustEntity {
  final int score;
  final int responseRate;
  final String label;

  TrustEntity({
    required this.score,
    required this.responseRate,
    required this.label,
  });

  factory TrustEntity.fromJson(Map<String, dynamic> json) => TrustEntity(
    score: (json['score'] as num?)?.toInt() ?? 0,
    responseRate: (json['responseRate'] as num?)?.toInt() ?? 0,
    label: json['label'] as String? ?? '',
  );
}

class InventoryEntity {
  final int total;
  final String label;

  InventoryEntity({required this.total, required this.label});

  factory InventoryEntity.fromJson(Map<String, dynamic> json) =>
      InventoryEntity(
        total: (json['total'] as num?)?.toInt() ?? 0,
        label: json['label'] as String? ?? '',
      );
}
