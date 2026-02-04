class ScanHistoryModel {
  final bool success;
  final String message;
  final List<ScanHistoryDataModel> data;

  ScanHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ScanHistoryModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return ScanHistoryModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => ScanHistoryDataModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class ScanHistoryDataModel {
  final String id;
  final String barcode;
  final String name;
  final String brand;
  final String overallStatus;
  final String? image;
  final DateTime? lastScanned;
  final DateTime? scannedAt;

  ScanHistoryDataModel({
    required this.id,
    required this.barcode,
    required this.name,
    required this.brand,
    required this.overallStatus,
    this.image,
    this.lastScanned,
    this.scannedAt,
  });

  factory ScanHistoryDataModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};

    return ScanHistoryDataModel(
      id: json['_id'] as String? ?? "",
      barcode: json['barcode'] as String? ?? "",
      name: json['name'] as String? ?? "",
      brand: json['brand'] as String? ?? "",
      overallStatus: json['overallStatus'] as String? ?? "",
      image: json['image'] as String?,
      lastScanned: json['lastScanned'] != null
          ? DateTime.tryParse(json['lastScanned'] as String)
          : null,
      scannedAt: json['scannedAt'] != null
          ? DateTime.tryParse(json['scannedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'barcode': barcode,
    'name': name,
    'brand': brand,
    'overallStatus': overallStatus,
    'image': image,
    'lastScanned': lastScanned?.toIso8601String(),
    'scannedAt': scannedAt?.toIso8601String(),
  };
}
