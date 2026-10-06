import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/place_category.dart';
import '../bloc/places_bloc.dart';
import '../widgets/category_chip.dart';
import '../widgets/map_surface.dart';
import '../widgets/place_card.dart';
import '../widgets/place_ui.dart';

/// Accessibility map: search, interactive map, category filters and the
/// suggested places list.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openPlace(Place place) {
    Navigator.of(context).pushNamed(AppRoutes.placeDetails, arguments: place);
  }

  void _onSearchChanged(String value) {
    BlocProvider.of<PlacesBloc>(context).add(PlacesSearchChanged(value));
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      body: BlocBuilder<PlacesBloc, PlacesState>(
        builder: (context, state) {
          if (state.status == PlacesStatus.initial ||
              state.status == PlacesStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.deepBlue),
            );
          }

          if (state.status == PlacesStatus.failure) {
            return _LoadFailed(
              message: l10n.loadFailed,
              onRetry: () => BlocProvider.of<PlacesBloc>(context)
                  .add(const PlacesLoadRequested()),
            );
          }

          final results = state.visiblePlaces;

          return SingleChildScrollView(
            padding: kScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.searchTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: l10n.searchHint,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                      color: AppColors.deepBlue,
                    ),
                    suffixIcon: state.query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: _clearSearch,
                            tooltip: l10n.clearSearch,
                            constraints: const BoxConstraints(
                              minWidth: AppDimens.minTouchTarget,
                              minHeight: AppDimens.minTouchTarget,
                            ),
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                              color: AppColors.textSecondary,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: AppDimens.gapLg),
                Text(l10n.nearbyTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                MapSurface(
                  places: results,
                  referencePlaces: state.places,
                  onPlaceTap: _openPlace,
                  height: 230,
                ),
                const SizedBox(height: AppDimens.gapLg),
                Text(
                  l10n.suggestedTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final category in PlaceCategory.values)
                      CategoryChip(
                        label: category.label(l10n),
                        icon: category.icon,
                        selected: state.category == category,
                        onTap: () =>
                            BlocProvider.of<PlacesBloc>(context)
                                .add(PlacesCategoryChanged(category)),
                      ),
                  ],
                ),
                const SizedBox(height: AppDimens.gap),
                if (results.isEmpty)
                  _EmptyResults(message: l10n.noResults)
                else
                  Column(
                    children: [
                      for (var i = 0; i < results.length; i++) ...[
                        if (i > 0) const SizedBox(height: 12),
                        PlaceCard(
                          place: results[i],
                          onTap: () => _openPlace(results[i]),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: AppDimens.gapLg),
                PrimaryButton(
                  label: l10n.addPlace,
                  icon: Icons.add,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.addPlace),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: AppDecorations.card(elevated: false),
      child: Column(
        children: [
          const Icon(Icons.place, size: 36, color: AppColors.skyBlue),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _LoadFailed extends StatelessWidget {
  const _LoadFailed({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: kScreenPadding,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: AppDecorations.card(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off,
                size: 40,
                color: AppColors.skyBlue,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 220,
                child: PrimaryButton(label: l10n.retry, onPressed: onRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
