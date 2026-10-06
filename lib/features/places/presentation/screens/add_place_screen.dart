import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/accessibility_feature.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';
import '../bloc/places_bloc.dart';
import '../widgets/category_chip.dart';
import '../widgets/place_ui.dart';

/// Community contribution form — the "Add a place" entry point from the map.
class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  static const LatLngSeed _seedLocation = LatLngSeed(
    latitude: 31.9539,
    longitude: 35.9106,
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  PlaceCategory? _category;
  final Set<AccessibilityFeature> _features = <AccessibilityFeature>{};
  bool _locationPinned = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleCategory(PlaceCategory category) {
    setState(() => _category = category);
  }

  void _toggleFeature(AccessibilityFeature feature) {
    setState(() {
      if (!_features.remove(feature)) _features.add(feature);
    });
  }

  void _pinLocation() {
    setState(() => _locationPinned = true);
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.locationPinned)));
  }

  void _save() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    if (_category == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorCategory)),
        );
      return;
    }

    FocusScope.of(context).unfocus();
    _submitted = true;

    final place = Place(
      id: 'place-${DateTime.now().microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      category: _category!,
      address: _addressController.text.trim(),
      // Placed near the map centre until a real picker is wired up.
      latitude: _seedLocation.latitude,
      longitude: _seedLocation.longitude,
      accessibilityVerified: false,
      features: Set<AccessibilityFeature>.of(_features),
    );

    BlocProvider.of<PlacesBloc>(context).add(PlaceAdded(place));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<PlacesBloc, PlacesState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (!_submitted) return;
        if (state.status == PlacesStatus.ready) {
          final savedMessage = l10n.placeSaved;
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(savedMessage)));
        } else if (state.status == PlacesStatus.failure) {
          _submitted = false;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.saveFailed)));
        }
      },
      child: AppScaffold(
        headerLeading: HeaderLeading.back,
        body: BlocBuilder<PlacesBloc, PlacesState>(
          builder: (context, state) {
            final isSaving = state.status == PlacesStatus.loading;

            return SingleChildScrollView(
              padding: kScreenPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.addPlaceTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    LabeledTextField(
                      label: l10n.placeNameLabel,
                      hint: l10n.placeNameHint,
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validators.required(value, l10n.errorPlaceName),
                    ),
                    const SizedBox(height: AppDimens.gap),
                    Text(
                      l10n.placeTypeLabel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.brandBlue,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final category in PlaceCategory.values)
                          if (category != PlaceCategory.all)
                            CategoryChip(
                              label: category.label(l10n),
                              icon: category.icon,
                              selected: _category == category,
                              onTap: () => _toggleCategory(category),
                            ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.gap),
                    LabeledTextField(
                      label: l10n.addressLabel,
                      hint: l10n.addressHint,
                      controller: _addressController,
                      textInputAction: TextInputAction.done,
                      validator: (value) =>
                          Validators.required(value, l10n.errorAddress),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: AppDimens.minTouchTarget + 8,
                      child: OutlinedButton.icon(
                        onPressed: _pinLocation,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.deepBlue,
                          side: const BorderSide(
                            color: AppColors.deepBlue,
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimens.buttonRadius,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        icon: const Icon(Icons.location_on, size: 20),
                        label: Text(
                          _locationPinned
                              ? l10n.locationPinned
                              : l10n.pinLocation,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    Text(
                      l10n.featuresTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final feature in kFeatureOrder)
                          CategoryChip(
                            label: feature.label(l10n),
                            imagePath: feature.imagePath,
                            selected: _features.contains(feature),
                            onTap: () => _toggleFeature(feature),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.gapLg),
                    PrimaryButton(
                      label: l10n.savePlace,
                      onPressed: _save,
                      isLoading: isSaving,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Placeholder coordinate used until a map picker is integrated.
class LatLngSeed {
  const LatLngSeed({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}
