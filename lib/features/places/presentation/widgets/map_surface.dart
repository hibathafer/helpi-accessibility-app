import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../domain/entities/place.dart';
import 'fallback_map.dart';

/// Map surface shared by the map screen.
///
/// Renders `google_maps_flutter` when [AppConfig.useGoogleMaps] is enabled on
/// a supported platform (Android, iOS, web); otherwise it renders the
/// built-in vector surface so the screen is never blank — desktop has no
/// Google Maps implementation, and an unkeyed Google map renders as an empty
/// grey tile.
class MapSurface extends StatefulWidget {
  const MapSurface({
    super.key,
    required this.places,
    required this.referencePlaces,
    required this.onPlaceTap,
    this.height = 220,
  });

  final List<Place> places;
  final List<Place> referencePlaces;
  final ValueChanged<Place> onPlaceTap;
  final double height;

  @override
  State<MapSurface> createState() => _MapSurfaceState();
}

class _MapSurfaceState extends State<MapSurface> {
  static const LatLng _fallbackCenter = LatLng(31.9546, 35.9106);

  Completer<GoogleMapController>? _controller;

  bool get _pluginSupported {
    if (kIsWeb) return true;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool get _useGoogleMaps => AppConfig.useGoogleMaps && _pluginSupported;

  @override
  void didUpdateWidget(covariant MapSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_useGoogleMaps && oldWidget.places != widget.places) {
      _fitToPlaces();
    }
  }

  Future<void> _fitToPlaces() async {
    final completer = _controller;
    if (completer == null || !completer.isCompleted) return;
    if (!mounted || widget.places.isEmpty) return;
    final controller = await completer.future;
    if (!mounted || widget.places.isEmpty) return;
    if (widget.places.length == 1) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              widget.places.single.latitude,
              widget.places.single.longitude,
            ),
            zoom: 14,
          ),
        ),
      );
      return;
    }
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(_bounds(widget.places), 72),
    );
  }

  LatLngBounds _bounds(List<Place> places) {
    var minLat = places.first.latitude;
    var maxLat = places.first.latitude;
    var minLng = places.first.longitude;
    var maxLng = places.first.longitude;
    for (final place in places) {
      minLat = place.latitude < minLat ? place.latitude : minLat;
      maxLat = place.latitude > maxLat ? place.latitude : maxLat;
      minLng = place.longitude < minLng ? place.longitude : minLng;
      maxLng = place.longitude > maxLng ? place.longitude : maxLng;
    }
    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  LatLng _center() {
    if (widget.places.isEmpty) return _fallbackCenter;
    final num lat =
        widget.places.map((p) => p.latitude).reduce((a, b) => a < b ? a : b) +
        widget.places.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    final num lng =
        widget.places.map((p) => p.longitude).reduce((a, b) => a < b ? a : b) +
        widget.places.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);
    return LatLng((lat / 2).toDouble(), (lng / 2).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: _useGoogleMaps ? _buildGoogleMap() : _buildVectorMap(),
      ),
    );
  }

  Widget _buildVectorMap() {
    return FallbackMap(
      places: widget.places,
      referencePlaces: widget.referencePlaces,
      onPlaceTap: widget.onPlaceTap,
    );
  }

  Widget _buildGoogleMap() {
    _controller ??= Completer<GoogleMapController>();

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F2)),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center(), zoom: 13),
        onMapCreated: (controller) {
          final completer = _controller;
          if (completer != null && !completer.isCompleted) {
            completer.complete(controller);
            _fitToPlaces();
          }
        },
        markers: widget.places
            .map(
              (place) => Marker(
                markerId: MarkerId(place.id),
                position: LatLng(place.latitude, place.longitude),
                onTap: () => widget.onPlaceTap(place),
              ),
            )
            .toSet(),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        rotateGesturesEnabled: false,
      ),
    );
  }
}
