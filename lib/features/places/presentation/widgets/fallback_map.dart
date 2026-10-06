import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/place.dart';

/// Interactive vector map surface used on platforms where the Google Maps
/// plugin is unavailable (desktop) or unkeyed, so the screen never renders an
/// empty grey tile. Markers are projected from real coordinates and are
/// individually tappable.
class FallbackMap extends StatelessWidget {
  const FallbackMap({
    super.key,
    required this.places,
    required this.referencePlaces,
    required this.onPlaceTap,
  });

  final List<Place> places;
  final List<Place> referencePlaces;
  final ValueChanged<Place> onPlaceTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final painter = VectorMapPainter(
          places: places,
          referencePlaces: referencePlaces,
          viewport: size,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) {
            final place = painter.placeAt(details.localPosition);
            if (place != null) onPlaceTap(place);
          },
          child: Semantics(
            image: true,
            label: 'Map with ${places.length} places',
            child: RepaintBoundary(
              child: CustomPaint(size: size, painter: painter),
            ),
          ),
        );
      },
    );
  }
}

class VectorMapPainter extends CustomPainter {
  VectorMapPainter({
    required this.places,
    required this.referencePlaces,
    required this.viewport,
  }) {
    _markerOffsets = _computeOffsets();
  }

  final List<Place> places;
  final List<Place> referencePlaces;
  final Size viewport;

  late final Map<String, Offset> _markerOffsets;

  /// Returns the place whose marker is within ~34px of [point], or `null`.
  Place? placeAt(Offset point) {
    Place? match;
    var closest = 34.0;
    _markerOffsets.forEach((id, offset) {
      final distance = (offset - point).distance;
      if (distance < closest) {
        closest = distance;
        for (final place in places) {
          if (place.id == id) match = place;
        }
      }
    });
    return match;
  }

  Map<String, Offset> _computeOffsets() {
    const padLeft = 44.0;
    const padTop = 54.0;
    const padBottom = 48.0;

    if (places.isEmpty || referencePlaces.isEmpty) {
      return <String, Offset>{};
    }

    var minLat = referencePlaces.first.latitude;
    var maxLat = referencePlaces.first.latitude;
    var minLng = referencePlaces.first.longitude;
    var maxLng = referencePlaces.first.longitude;

    for (final place in referencePlaces) {
      minLat = place.latitude < minLat ? place.latitude : minLat;
      maxLat = place.latitude > maxLat ? place.latitude : maxLat;
      minLng = place.longitude < minLng ? place.longitude : minLng;
      maxLng = place.longitude > maxLng ? place.longitude : maxLng;
    }

    double usableWidth = (viewport.width - padLeft * 2).toDouble();
    if (usableWidth < 1) usableWidth = 1;
    double usableHeight = (viewport.height - padTop - padBottom).toDouble();
    if (usableHeight < 1) usableHeight = 1;

    final latSpan = (maxLat - minLat).abs();
    final lngSpan = (maxLng - minLng).abs();

    final result = <String, Offset>{};
    for (final place in places) {
      final num rawDx = lngSpan == 0
          ? usableWidth / 2
          : ((place.longitude - minLng) / lngSpan) * usableWidth;
      final num rawDy = latSpan == 0
          ? usableHeight / 2
          : ((maxLat - place.latitude) / latSpan) * usableHeight;

      double x = (padLeft + rawDx).toDouble();
      double y = (padTop + rawDy).toDouble();
      if (x < padLeft) x = padLeft;
      if (x > viewport.width - padLeft) x = viewport.width - padLeft;
      if (y < padTop) y = padTop;
      if (y > viewport.height - padBottom) y = viewport.height - padBottom;

      result[place.id] = Offset(x, y);
    }
    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Base terrain.
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.mapLand);

    // Parks.
    _blob(
      canvas,
      Rect.fromLTWH(
        size.width * 0.06,
        size.height * 0.1,
        size.width * 0.3,
        size.height * 0.26,
      ),
    );
    _blob(
      canvas,
      Rect.fromLTWH(
        size.width * 0.62,
        size.height * 0.58,
        size.width * 0.32,
        size.height * 0.3,
      ),
    );

    // River.
    final river = Path()
      ..moveTo(-12, size.height * 0.74)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.56,
        size.width * 0.54,
        size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.84,
        size.width + 12,
        size.height * 0.62,
      );
    canvas.drawPath(
      river,
      Paint()
        ..color = AppColors.mapWater
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round,
    );

    // Road grid.
    final road = Paint()
      ..color = AppColors.mapRoad
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    for (double y = 46; y < size.height; y += 66) {
      canvas.drawLine(Offset(0, y + 8), Offset(size.width, y), road);
    }
    for (double x = 56; x < size.width; x += 78) {
      canvas.drawLine(Offset(x, 0), Offset(x + 10, size.height), road);
    }

    // Local streets for texture.
    final lane = Paint()
      ..color = AppColors.mapRoad
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (double x = 24; x < size.width; x += 78) {
      canvas.drawLine(Offset(x, 0), Offset(x + 6, size.height), lane);
    }

    // Markers.
    for (final place in places) {
      final offset = _markerOffsets[place.id];
      if (offset != null) _drawPin(canvas, offset);
    }
  }

  void _blob(Canvas canvas, Rect rect) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(26)),
      Paint()..color = AppColors.mapPark,
    );
  }

  void _drawPin(Canvas canvas, Offset tip) {
    // Contact shadow.
    canvas.drawOval(
      Rect.fromCenter(center: Offset(tip.dx, tip.dy + 3), width: 24, height: 9),
      Paint()..color = const Color(0x33000000),
    );

    final head = Offset(tip.dx, tip.dy - 34);

    // Stem.
    final stem = Path()
      ..moveTo(tip.dx - 10, tip.dy - 24)
      ..lineTo(tip.dx + 10, tip.dy - 24)
      ..lineTo(tip.dx, tip.dy)
      ..close();
    canvas.drawPath(stem, Paint()..color = AppColors.markerRed);

    // Head.
    canvas.drawCircle(head, 18, Paint()..color = AppColors.markerRed);
    canvas.drawCircle(head, 7, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(VectorMapPainter oldDelegate) =>
      oldDelegate.places != places ||
      oldDelegate.referencePlaces != referencePlaces ||
      oldDelegate.viewport != viewport;
}
