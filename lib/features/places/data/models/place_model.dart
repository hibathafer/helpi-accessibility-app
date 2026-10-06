import '../../domain/entities/accessibility_feature.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';

/// JSON-mappable [Place]. Serialization lives at the data boundary so a REST
/// payload can be introduced without changing the domain entity.
class PlaceModel extends Place {
  const PlaceModel({
    required super.id,
    required super.name,
    required super.category,
    required super.address,
    required super.latitude,
    required super.longitude,
    super.distanceKm,
    super.rating,
    super.reviewCount,
    super.imageUrl,
    super.features,
    super.accessibilityVerified,
  });

  factory PlaceModel.fromPlace(Place place) {
    return PlaceModel(
      id: place.id,
      name: place.name,
      category: place.category,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
      distanceKm: place.distanceKm,
      rating: place.rating,
      reviewCount: place.reviewCount,
      imageUrl: place.imageUrl,
      features: place.features,
      accessibilityVerified: place.accessibilityVerified,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      category: _category(json['category'] as String?),
      address: json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      features: _features(json['features'] as List<dynamic>?),
      accessibilityVerified: json['accessibilityVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category.name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distanceKm': distanceKm,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageUrl': imageUrl,
      'features': features.map((f) => f.name).toList(),
      'accessibilityVerified': accessibilityVerified,
    };
  }

  static Set<AccessibilityFeature> _features(List<dynamic>? raw) {
    final result = <AccessibilityFeature>{};
    for (final value in raw ?? const <dynamic>[]) {
      final parsed = _feature(value as String?);
      if (parsed != null) result.add(parsed);
    }
    return result;
  }

  static PlaceCategory _category(String? raw) {
    for (final value in PlaceCategory.values) {
      if (value.name == raw) return value;
    }
    return PlaceCategory.attraction;
  }

  static AccessibilityFeature? _feature(String? raw) {
    for (final value in AccessibilityFeature.values) {
      if (value.name == raw) return value;
    }
    return null;
  }
}
