import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/place.dart';
import '../widgets/accessibility_badge.dart';

/// Dynamic place details: media, facts, accessibility badges and the
/// navigation hand-off to the user's maps application.
class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  Future<void> _openDirections(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${place.latitude},${place.longitude}',
    );

    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      launched = false;
    }

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.directionsFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      headerLeading: HeaderLeading.back,
      body: SingleChildScrollView(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.detailsTitle, style: textTheme.headlineSmall),
            const SizedBox(height: 16),
            _PlaceImage(place: place),
            const SizedBox(height: AppDimens.gap),
            _FactRow(label: l10n.placeName, value: place.name),
            const SizedBox(height: 10),
            if (place.distanceKm != null) ...[
              const SizedBox(height: 10),
              _FactRow(
                label: l10n.distance,
                value: '${place.distanceKm!.toStringAsFixed(1)} ${l10n.kmUnit}',
              ),
            ],
            if (place.rating != null) ...[
              const SizedBox(height: 10),
              _FactRow(
                label: l10n.rating,
                value: place.reviewCount == null
                    ? place.rating!.toStringAsFixed(1)
                    : '${place.rating!.toStringAsFixed(1)} (${place.reviewCount})',
                showStar: true,
              ),
            ],
            if (!place.accessibilityVerified) ...[
              const SizedBox(height: AppDimens.gap),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.skyBlueSoft,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.skyBlue),
                ),
                child: Text(
                  l10n.accessibilityNotVerified,
                  style: const TextStyle(
                    color: AppColors.brandBlue,
                    height: 1.5,
                  ),
                ),
              ),
            ],
            if (place.features.isNotEmpty) ...[
              const SizedBox(height: AppDimens.gapLg),
              Text(l10n.featuresTitle, style: textTheme.titleMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final feature in place.features)
                    AccessibilityBadge(feature: feature),
                ],
              ),
            ],
            const SizedBox(height: AppDimens.gapLg),
            PrimaryButton(
              label: l10n.goToLocation,
              icon: Icons.navigation,
              onPressed: () => _openDirections(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: SizedBox(
        width: double.infinity,
        height: 190,
        child: place.imageUrl == null
            ? _placeholder(l10n.placeImage)
            : Image.network(
                place.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _placeholder(l10n.placeImage),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.deepBlue,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _placeholder(String label) {
    return Container(
      color: AppColors.skyBlueSoft,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, size: 44, color: AppColors.deepBlue),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.deepBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.label,
    required this.value,
    this.showStar = false,
  });

  final String label;
  final String value;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.brandBlue,
            height: 1.3,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showStar) ...[
                  const Icon(Icons.star, size: 17, color: AppColors.gold),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
