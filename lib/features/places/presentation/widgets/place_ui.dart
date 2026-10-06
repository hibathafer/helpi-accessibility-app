import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/accessibility_feature.dart';
import '../../domain/entities/place_category.dart';

/// Presentation mapping from domain enums to icons and localized copy.
extension PlaceCategoryUi on PlaceCategory {
  IconData get icon => switch (this) {
    PlaceCategory.all => Icons.category,
    PlaceCategory.hospital => Icons.local_hospital,
    PlaceCategory.school => Icons.school,
    PlaceCategory.government => Icons.account_balance,
    PlaceCategory.cafe => Icons.local_cafe,
    PlaceCategory.attraction => Icons.attractions,
    PlaceCategory.park => Icons.park,
    PlaceCategory.palace => Icons.account_balance,
    PlaceCategory.themePark => Icons.attractions,
    PlaceCategory.landmark => Icons.location_city,
    PlaceCategory.district => Icons.map,
  };

  String label(AppLocalizations l10n) => switch (this) {
    PlaceCategory.all => l10n.categoryAll,
    PlaceCategory.hospital => l10n.categoryHospitals,
    PlaceCategory.school => l10n.categorySchools,
    PlaceCategory.government => l10n.categoryGovernment,
    PlaceCategory.cafe => l10n.categoryCafes,
    PlaceCategory.attraction => l10n.categoryAttractions,
    PlaceCategory.park => l10n.categoryParks,
    PlaceCategory.palace => l10n.categoryPalaces,
    PlaceCategory.themePark => l10n.categoryThemeParks,
    PlaceCategory.landmark => l10n.categoryLandmarks,
    PlaceCategory.district => l10n.categoryDistricts,
  };
}

extension AccessibilityFeatureUi on AccessibilityFeature {
  IconData get icon => switch (this) {
    AccessibilityFeature.ramp => Icons.trending_up,
    AccessibilityFeature.accessibleRestroom => Icons.accessible,
    AccessibilityFeature.wideElevator => Icons.elevator,
    AccessibilityFeature.wideDoors => Icons.door_front_door,
  };

  String get imagePath => switch (this) {
    AccessibilityFeature.ramp => 'assets/images/rampImage.png',
    AccessibilityFeature.accessibleRestroom =>
      'assets/images/accessibleRestroomImage.png',
    AccessibilityFeature.wideElevator => 'assets/images/elevatorImage.png',
    AccessibilityFeature.wideDoors => 'assets/images/wideDoorsImage.png',
  };

  String label(AppLocalizations l10n) => switch (this) {
    AccessibilityFeature.ramp => l10n.featureRamp,
    AccessibilityFeature.accessibleRestroom => l10n.featureRestroom,
    AccessibilityFeature.wideElevator => l10n.featureElevator,
    AccessibilityFeature.wideDoors => l10n.featureDoors,
  };
}

/// Ordered feature display so badges read the same way everywhere.
const List<AccessibilityFeature> kFeatureOrder = <AccessibilityFeature>[
  AccessibilityFeature.ramp,
  AccessibilityFeature.accessibleRestroom,
  AccessibilityFeature.wideElevator,
  AccessibilityFeature.wideDoors,
];
