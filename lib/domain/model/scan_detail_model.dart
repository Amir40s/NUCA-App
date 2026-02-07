class ProductResponseModel {
  final bool success;
  final String message;
  final ProductDataModel? data;

  ProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic>? json) {
    return ProductResponseModel(
      success: json?['success'] ?? false,
      message: json?['message'] ?? '',
      data: json?['data'] != null
          ? ProductDataModel.fromJson(json!['data'])
          : null,
    );
  }

  ProductResponseModel copyWith({
    bool? success,
    String? message,
    ProductDataModel? data,
  }) {
    return ProductResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class ProductDataModel {
  final String barcode;
  final String name;
  final String brand;
  final String image;
  final String halalStatus;
  final NutritionModel? nutrition;
  final String nutritionScore;
  final IngredientsModel? ingredients;
  final AdditivesModel? additives;
  final List<ShopModel> shops;
  final String currency;
  final DateTime? lastUpdated;
  final UserStatsModel? userStats;

  ProductDataModel({
    required this.barcode,
    required this.name,
    required this.brand,
    required this.image,
    required this.halalStatus,
    required this.nutrition,
    required this.nutritionScore,
    required this.ingredients,
    required this.additives,
    required this.shops,
    required this.currency,
    required this.lastUpdated,
    required this.userStats,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic>? json) {
    return ProductDataModel(
      barcode: json?['barcode']?.toString() ?? '',
      name: json?['name'] ?? '',
      brand: json?['brand'] ?? '',
      image: json?['image'] ?? '',
      halalStatus: json?['halalStatus'] ?? '',
      nutrition: json?['nutrition'] != null
          ? NutritionModel.fromJson(json!['nutrition'])
          : null,
      nutritionScore: json?['nutritionScore']?.toString() ?? '',

      ingredients: json?['ingredients'] != null
          ? IngredientsModel.fromJson(json!['ingredients'])
          : null,
      additives: json?['additives'] != null
          ? AdditivesModel.fromJson(json!['additives'])
          : null,
      shops:
          (json?['shops'] as List?)
              ?.map((e) => ShopModel.fromJson(e))
              .toList() ??
          [],
      currency: json?['currency']?.toString() ?? '',
      lastUpdated: json?['lastUpdated'] != null
          ? DateTime.tryParse(json!['lastUpdated'])
          : null,
      userStats: json?['userStats'] != null
          ? UserStatsModel.fromJson(json!['userStats'])
          : null,
    );
  }

  ProductDataModel copyWith({
    String? barcode,
    String? name,
    String? brand,
    String? image,
    String? halalStatus,
    NutritionModel? nutrition,
    String? nutritionScore,
    IngredientsModel? ingredients,
    AdditivesModel? additives,
    List<ShopModel>? shops,
    String? currency,
    DateTime? lastUpdated,
    UserStatsModel? userStats,
  }) {
    return ProductDataModel(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      halalStatus: halalStatus ?? this.halalStatus,
      nutrition: nutrition ?? this.nutrition,
      nutritionScore: nutritionScore ?? this.nutritionScore,
      ingredients: ingredients ?? this.ingredients,
      additives: additives ?? this.additives,
      shops: shops ?? this.shops,
      currency: currency ?? this.currency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      userStats: userStats ?? this.userStats,
    );
  }
}

class NutritionModel {
  final NutritionValueModel? energy;
  final NutritionValueModel? sugar;
  final NutritionValueModel? salt;
  final NutritionValueModel? carbs;
  final NutritionValueModel? protein;

  NutritionModel({
    this.energy,
    this.sugar,
    this.salt,
    this.carbs,
    this.protein,
  });

  factory NutritionModel.fromJson(Map<String, dynamic>? json) {
    return NutritionModel(
      energy: NutritionValueModel.fromJson(json?['energy']),
      sugar: NutritionValueModel.fromJson(json?['sugar']),
      salt: NutritionValueModel.fromJson(json?['salt']),
      carbs: NutritionValueModel.fromJson(json?['carbs']),
      protein: NutritionValueModel.fromJson(json?['protein']),
    );
  }

  NutritionModel copyWith({
    NutritionValueModel? energy,
    NutritionValueModel? sugar,
    NutritionValueModel? salt,
    NutritionValueModel? carbs,
    NutritionValueModel? protein,
  }) {
    return NutritionModel(
      energy: energy ?? this.energy,
      sugar: sugar ?? this.sugar,
      salt: salt ?? this.salt,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
    );
  }
}

class NutritionValueModel {
  final num value;
  final String unit;

  NutritionValueModel({required this.value, required this.unit});

  factory NutritionValueModel.fromJson(Map<String, dynamic>? json) {
    return NutritionValueModel(
      value: json?['value'] ?? 0,
      unit: json?['unit'] ?? '',
    );
  }

  NutritionValueModel copyWith({num? value, String? unit}) {
    return NutritionValueModel(
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }
}

class IngredientsModel {
  final String full;
  final List<String> flagged;

  IngredientsModel({required this.full, required this.flagged});

  factory IngredientsModel.fromJson(Map<String, dynamic>? json) {
    return IngredientsModel(
      full: json?['full'] ?? '',
      flagged: (json?['flagged'] as List?)?.cast<String>() ?? [],
    );
  }

  IngredientsModel copyWith({String? full, List<String>? flagged}) {
    return IngredientsModel(
      full: full ?? this.full,
      flagged: flagged ?? this.flagged,
    );
  }
}

class AdditivesModel {
  final String gmo;
  final String bio;
  final String nova;

  AdditivesModel({required this.gmo, required this.bio, required this.nova});

  factory AdditivesModel.fromJson(Map<String, dynamic>? json) {
    return AdditivesModel(
      gmo: json?['gmo'] ?? '',
      bio: json?['bio'] ?? '',
      nova: json?['nova']?.toString() ?? '',
    );
  }

  AdditivesModel copyWith({String? gmo, String? bio, String? nova}) {
    return AdditivesModel(
      gmo: gmo ?? this.gmo,
      bio: bio ?? this.bio,
      nova: nova ?? this.nova,
    );
  }
}

class ShopModel {
  final String merchant;
  final String price;
  final String link;
  final String distance;
  final String? discount;
  final String id;
  final String? address;
  final String? googleMapsLink;
  final String? size;

  ShopModel({
    required this.merchant,
    required this.price,
    required this.link,
    required this.distance,
    required this.discount,
    required this.id,
    this.address,
    this.googleMapsLink,
    this.size,
  });

  factory ShopModel.fromJson(Map<String, dynamic>? json) {
    final String? address = json?['address'];
    final String? size = json?['size'];

    return ShopModel(
      merchant: json?['merchant'] ?? '',
      price: json?['price']?.toString() ?? '',
      distance: json?['distance']?.toString() ?? '',
      link: json?['link'] ?? '',
      discount: json?['discount'],
      id: json?['_id'] ?? '',
      address: address,
      googleMapsLink: address != null && address.isNotEmpty
          ? "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}"
          : null,
      size: size,
    );
  }

  ShopModel copyWith({
    String? merchant,
    String? price,
    String? link,
    String? distance,
    String? discount,
    String? id,
    String? address,
    String? googleMapsLink,
    String? size,
  }) {
    return ShopModel(
      merchant: merchant ?? this.merchant,
      price: price ?? this.price,
      link: link ?? this.link,
      distance: distance ?? this.distance,
      discount: discount ?? this.discount,
      id: id ?? this.id,
      address: address ?? this.address,
      googleMapsLink: googleMapsLink ?? this.googleMapsLink,
      size: size ?? this.size,
    );
  }
}

class UserStatsModel {
  final int totalScans;
  final String subscription;
  final String scansRemaining;

  UserStatsModel({
    required this.totalScans,
    required this.subscription,
    required this.scansRemaining,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic>? json) {
    return UserStatsModel(
      totalScans: json?['totalScans'] ?? 0,
      subscription: json?['subscription'] ?? '',
      scansRemaining: json?['scansRemaining']?.toString() ?? '',
    );
  }

  UserStatsModel copyWith({
    int? totalScans,
    String? subscription,
    String? scansRemaining,
  }) {
    return UserStatsModel(
      totalScans: totalScans ?? this.totalScans,
      subscription: subscription ?? this.subscription,
      scansRemaining: scansRemaining ?? this.scansRemaining,
    );
  }
}
