import 'package:equatable/equatable.dart';

import 'accessibility_feature.dart';
import 'place_category.dart';

/// A discoverable location with its accessibility metadata.
class Place extends Equatable {
  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distanceKm,
    this.rating,
    this.reviewCount,
    this.imageUrl,
    this.features = const <AccessibilityFeature>{},
    this.accessibilityVerified = false,
  });

  final String id;
  final String name;
  final PlaceCategory category;
  final String address;
  final double latitude;
  final double longitude;
  final double? distanceKm;
  final double? rating;
  final int? reviewCount;
  final String? imageUrl;
  final Set<AccessibilityFeature> features;
  final bool accessibilityVerified;

  Place copyWith({
    String? id,
    String? name,
    PlaceCategory? category,
    String? address,
    double? latitude,
    double? longitude,
    double? distanceKm,
    double? rating,
    int? reviewCount,
    String? imageUrl,
    Set<AccessibilityFeature>? features,
    bool? accessibilityVerified,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      distanceKm: distanceKm ?? this.distanceKm,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      imageUrl: imageUrl ?? this.imageUrl,
      features: features ?? this.features,
      accessibilityVerified:
          accessibilityVerified ?? this.accessibilityVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        address,
        latitude,
        longitude,
        distanceKm,
        rating,
        reviewCount,
        imageUrl,
        features,
        accessibilityVerified,
      ];
}
