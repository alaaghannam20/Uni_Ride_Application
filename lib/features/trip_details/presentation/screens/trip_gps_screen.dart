import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uni_ride_application/core/services/gps_hub_service.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

enum _GpsStatus { connecting, connectionFailed, waitingForDriver, live }

// ── Checkpoint Model ─────────────────────────────────────────────────────────

class CheckpointData {
  final String id;
  final String checkpoint;
  final String city;
  final String enteringStatus;
  final String leavingStatus;
  final String lastUpdated;

  CheckpointData({
    required this.id,
    required this.checkpoint,
    required this.city,
    required this.enteringStatus,
    required this.leavingStatus,
    required this.lastUpdated,
  });

  factory CheckpointData.fromJson(Map<String, dynamic> json) => CheckpointData(
        id: json['id'] ?? '',
        checkpoint: json['checkpoint'] ?? '',
        city: json['city'] ?? '',
        enteringStatus: json['entering_status'] ?? '',
        leavingStatus: json['leaving_status'] ?? '',
        lastUpdated: json['last_updated'] ?? '',
      );
}

// ── Checkpoint Service ────────────────────────────────────────────────────────

class CheckpointService {
  static const String _apiKey =
      'arw_25d6362cde01937614b022a8f92e5298fae369989b2da4d8fef2aa4384656947';
  static const String _baseUrl = 'https://aweenrayeh.com';

  static const Map<String, String> _cityMap = {
    'رام الله': 'ramallah', 'البيرة': 'ramallah', 'بيتونيا': 'ramallah',
    'نابلس': 'nablus', 'بلاطة': 'nablus',
    'الخليل': 'hebron', 'حلحول': 'hebron', 'دورا': 'hebron',
    'بيت لحم': 'bethlehem', 'بيت جالا': 'bethlehem', 'بيت ساحور': 'bethlehem',
    'أريحا': 'jericho',
    'جنين': 'jenin',
    'طولكرم': 'tulkarm',
    'قلقيلية': 'qalqilya',
    'سلفيت': 'salfit',
    'طوباس': 'tubas',
    'القدس': 'jerusalem', 'أبو ديس': 'jerusalem', 'العيزرية': 'jerusalem',
    'ramallah': 'ramallah', 'nablus': 'nablus', 'hebron': 'hebron',
    'bethlehem': 'bethlehem', 'jericho': 'jericho', 'jenin': 'jenin',
    'tulkarm': 'tulkarm', 'qalqilya': 'qalqilya', 'salfit': 'salfit',
    'tubas': 'tubas', 'jerusalem': 'jerusalem',
  };

  static String? _extractSlug(String location) {
    final city = location.split(RegExp(r'\s*[-–]\s*')).first.trim();
    return _cityMap[city] ?? _cityMap[city.toLowerCase()];
  }

  Future<List<CheckpointData>> _fetchForSlug(String slug) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/v1/checkpoints/city/$slug'),
        headers: {'X-API-Key': _apiKey, 'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'] ?? [];
        return data.map((e) => CheckpointData.fromJson(e)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<CheckpointData>> fetchForTrip(
      String pickupLocation, String dropoffLocation) async {
    final slugs = <String>{};
    final s1 = _extractSlug(pickupLocation);
    final s2 = _extractSlug(dropoffLocation);
    if (s1 != null) slugs.add(s1);
    if (s2 != null) slugs.add(s2);
    if (slugs.isEmpty) return [];
    final results = await Future.wait(slugs.map(_fetchForSlug));
    final seen = <String>{};
    return results.expand((list) => list).where((cp) => seen.add(cp.id)).toList();
  }
}

// ── Notification Service ──────────────────────────────────────────────────────

class CheckpointNotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> _ensureInit() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    // Request permission on Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _initialized = true;
  }

  static Future<void> showCheckpointAlert(
      List<CheckpointData> checkpoints) async {
    await _ensureInit();
    final blocked = checkpoints.where((c) => c.enteringStatus != 'سالك').toList();
    final title = blocked.isNotEmpty ? '⚠️ حاجز مغلق على طريقك!' : 'ℹ️ حاجز على طريقك';
    final body = blocked.isNotEmpty
        ? '${blocked.length} حاجز مغلق - قد يكون هناك تأخير في رحلتك'
        : '${checkpoints.length} حاجز على الطريق - الطريق سالك حالياً';
    await _plugin.show(
      42,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'checkpoints_channel',
          'Checkpoint Alerts',
          channelDescription: 'إشعارات الحواجز على طريقك',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}

// ── Args ──────────────────────────────────────────────────────────────────────

class TripGpsArgs {
  final String driverName;
  final String? driverPhotoUrl;
  final double driverRating;
  final String carModel;
  final String carColor;
  final int tripId;
  final String driverUserId;
  final String pickupLocation;
  final String dropoffLocation;

  const TripGpsArgs({
    required this.driverName,
    this.driverPhotoUrl,
    required this.driverRating,
    required this.carModel,
    required this.carColor,
    required this.tripId,
    required this.driverUserId,
    required this.pickupLocation,
    required this.dropoffLocation,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class TripGpsScreen extends StatefulWidget {
  final TripGpsArgs args;
  const TripGpsScreen({super.key, required this.args});

  @override
  State<TripGpsScreen> createState() => _TripGpsScreenState();
}

class _TripGpsScreenState extends State<TripGpsScreen> {
  GoogleMapController? _mapController;
  final GpsHubService _gpsService = GpsHubService();

  static const LatLng _palestineCenter = LatLng(32.2211, 35.2544);

  LatLng? _driverLatLng;
  bool _isFirstLocation = true;
  double _bearing = 0;
  BitmapDescriptor? _arrowIcon;
  bool _notificationShown = false;

  List<LatLng> _routePoints = [];
  LatLng? _pickupLatLng;
  LatLng? _dropoffLatLng;

  bool _isLive = false;
  _GpsStatus _gpsStatus = _GpsStatus.connecting;

  @override
  void initState() {
    super.initState();
    _connectHub();
    _loadArrowMarker();
    _checkAndNotify();
    _fetchRoute();
  }

  Future<void> _connectHub() async {
    await _gpsService.startTracking(
      tripId: widget.args.tripId,
      onLocation: _onLocation,
      onError: (_) {
        if (mounted) setState(() => _gpsStatus = _GpsStatus.connectionFailed);
      },
    );
    if (mounted && !_isLive) {
      setState(() => _gpsStatus = _GpsStatus.waitingForDriver);
    }
  }

  void _onLocation(DriverGpsLocation loc) {
    if (!mounted) return;
    final latLng = LatLng(loc.latitude, loc.longitude);
    // Calculate bearing from previous position
    if (_driverLatLng != null) {
      _bearing = _calcBearing(_driverLatLng!, latLng);
    }
    setState(() {
      _driverLatLng = latLng;
      _isLive = true;
      _gpsStatus = _GpsStatus.live;
    });
    if (_isFirstLocation) {
      _isFirstLocation = false;
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15)),
      );
    } else {
      _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  double _calcBearing(LatLng from, LatLng to) {
    final lat1 = from.latitude * pi / 180;
    final lat2 = to.latitude * pi / 180;
    final dLon = (to.longitude - from.longitude) * pi / 180;
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return (atan2(y, x) * 180 / pi + 360) % 360;
  }

  Future<void> _loadArrowMarker() async {
    const double size = 80;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size, size));

    // Orange filled circle
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2,
      Paint()..color = const Color(0xFFCF8307),
    );
    // White border ring
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2 - 3,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    // White arrow pointing upward (north = 0 bearing)
    final arrow = Path()
      ..moveTo(size * 0.50, size * 0.12) // tip
      ..lineTo(size * 0.76, size * 0.68) // bottom-right
      ..lineTo(size * 0.50, size * 0.54) // inner bottom
      ..lineTo(size * 0.24, size * 0.68) // bottom-left
      ..close();
    canvas.drawPath(arrow, Paint()..color = Colors.white);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    if (mounted && bytes != null) {
      setState(() {
        _arrowIcon =
            BitmapDescriptor.bytes(bytes.buffer.asUint8List());
      });
    }
  }

  Future<void> _checkAndNotify() async {
    final checkpoints = await CheckpointService().fetchForTrip(
      widget.args.pickupLocation,
      widget.args.dropoffLocation,
    );
    if (!mounted || _notificationShown || checkpoints.isEmpty) return;
    _notificationShown = true;
    await CheckpointNotificationService.showCheckpointAlert(checkpoints);
  }

  // PTUK exact coordinates — used whenever location mentions the university
  static const LatLng _ptukLatLng = LatLng(32.3149, 35.0260);

  static bool _isPtuk(String location) {
    final l = location.toLowerCase();
    return l.contains('خضوري') ||
        l.contains('ptuk') ||
        l.contains('palestine technical') ||
        l.contains('فلسطين التقنية');
  }

  // Returns "lat,lng" string for the API if we know the exact spot,
  // otherwise returns the location name with country appended.
  static String _apiAddress(String location) {
    if (_isPtuk(location)) return '${_ptukLatLng.latitude},${_ptukLatLng.longitude}';
    return Uri.encodeComponent('$location, فلسطين');
  }

  Future<void> _fetchRoute() async {
    const apiKey = 'AIzaSyAmB3o83NlGXBLTR5gsp56KP3OKTF4upIo';
    final origin = _apiAddress(widget.args.pickupLocation);
    final dest   = _apiAddress(widget.args.dropoffLocation);
    try {
      final res = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=$origin&destination=$dest&key=$apiKey&language=ar',
      )).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) return;
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final routes = data['routes'] as List?;
      if (routes == null || routes.isEmpty) return;
      final leg    = routes[0]['legs'][0];
      final points = _decodePolyline(routes[0]['overview_polyline']['points'] as String);

      // Use our known coordinates for PTUK instead of API geocode result
      final startLat = _isPtuk(widget.args.pickupLocation)
          ? _ptukLatLng.latitude
          : (leg['start_location']['lat'] as num).toDouble();
      final startLng = _isPtuk(widget.args.pickupLocation)
          ? _ptukLatLng.longitude
          : (leg['start_location']['lng'] as num).toDouble();
      final endLat = _isPtuk(widget.args.dropoffLocation)
          ? _ptukLatLng.latitude
          : (leg['end_location']['lat'] as num).toDouble();
      final endLng = _isPtuk(widget.args.dropoffLocation)
          ? _ptukLatLng.longitude
          : (leg['end_location']['lng'] as num).toDouble();

      if (!mounted) return;
      setState(() {
        _routePoints   = points;
        _pickupLatLng  = LatLng(startLat, startLng);
        _dropoffLatLng = LatLng(endLat,   endLng);
      });
      _fitRoute();
    } catch (_) {}
  }

  List<LatLng> _decodePolyline(String encoded) {
    final points = <LatLng>[];
    int idx = 0, lat = 0, lng = 0;
    while (idx < encoded.length) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(idx++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : result >> 1;
      shift = 0; result = 0;
      do {
        b = encoded.codeUnitAt(idx++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : result >> 1;
      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  void _fitRoute() {
    if (_routePoints.isEmpty || _mapController == null) return;
    final lats = _routePoints.map((p) => p.latitude);
    final lngs = _routePoints.map((p) => p.longitude);
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(lats.reduce(min), lngs.reduce(min)),
          northeast: LatLng(lats.reduce(max), lngs.reduce(max)),
        ),
        72,
      ),
    );
  }

  @override
  void dispose() {
    _gpsService.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  String _statusLabel(AppLocalizations l) {
    switch (_gpsStatus) {
      case _GpsStatus.connecting:       return l.gpsConnecting;
      case _GpsStatus.connectionFailed: return l.gpsConnectionFailed;
      case _GpsStatus.waitingForDriver: return l.gpsWaitingForDriver;
      case _GpsStatus.live:             return l.gpsLive;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          // ── Map ──────────────────────────────────────────────────────────
          GoogleMap(
            onMapCreated: (c) {
              _mapController = c;
              if (_routePoints.isNotEmpty) _fitRoute();
            },
            initialCameraPosition:
                const CameraPosition(target: _palestineCenter, zoom: 9),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            polylines: _routePoints.isNotEmpty
                ? {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: _routePoints,
                      color: AppColors.orangeprimary,
                      width: 5,
                      startCap: Cap.roundCap,
                      endCap: Cap.roundCap,
                      jointType: JointType.round,
                    ),
                  }
                : {},
            markers: {
              if (_pickupLatLng != null)
                Marker(
                  markerId: const MarkerId('pickup'),
                  position: _pickupLatLng!,
                  anchor: const Offset(0.5, 1.0),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(
                    title: widget.args.pickupLocation
                        .split(RegExp(r'\s*[-–]\s*'))
                        .first,
                  ),
                ),
              if (_dropoffLatLng != null)
                Marker(
                  markerId: const MarkerId('dropoff'),
                  position: _dropoffLatLng!,
                  anchor: const Offset(0.5, 1.0),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(
                    title: widget.args.dropoffLocation
                        .split(RegExp(r'\s*[-–]\s*'))
                        .first,
                  ),
                ),
              if (_driverLatLng != null)
                Marker(
                  markerId: const MarkerId('driver'),
                  position: _driverLatLng!,
                  rotation: _bearing,
                  flat: true,
                  anchor: const Offset(0.5, 0.5),
                  infoWindow: InfoWindow(title: widget.args.driverName),
                  icon: _arrowIcon ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueOrange),
                ),
            },
          ),

          // ── Top bar ───────────────────────────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Container(
                color: context.appBarBg.withValues(alpha: 0.95),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: context.borderColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: context.borderColor),
                        ),
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 14, color: context.textPrimary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l.trackTrip,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: context.textPrimary)),
                          Text(
                            '${widget.args.pickupLocation.split(RegExp(r'\s*[-–]\s*')).first} → ${widget.args.dropoffLocation.split(RegExp(r'\s*[-–]\s*')).first}',
                            style: TextStyle(
                                fontSize: 11, color: context.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Live / status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _isLive
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF9800),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        if (_isLive) ...[
                          Container(
                              width: 6, height: 6,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                        ],
                        Text(_statusLabel(l),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Driver info card ──────────────────────────────────────────────
          Positioned(
            top: 80, right: 16, left: 16,
            child: _buildDriverCard(),
          ),

        ],
      ),
    );
  }

  Widget _driverInitialAvatar() => Container(
        color: AppColors.orangeprimary.withValues(alpha: 0.15),
        alignment: Alignment.center,
        child: Text(
          widget.args.driverName.isNotEmpty
              ? widget.args.driverName[0].toUpperCase()
              : '?',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.orangeprimary),
        ),
      );

  Widget _buildDriverCard() {
    final ctx = context;
    return Container(
      decoration: BoxDecoration(
        color: ctx.bgCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: widget.args.driverPhotoUrl != null
              ? Image.network(
                  'http://uniride.runasp.net/${widget.args.driverPhotoUrl}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, _) => _driverInitialAvatar(),
                )
              : _driverInitialAvatar(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.args.driverName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 3),
              Row(children: [
                const Icon(Icons.star_rounded,
                    size: 13, color: AppColors.orangeprimary),
                const SizedBox(width: 3),
                Text('${widget.args.driverRating}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.orangeprimary)),
              ]),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.args.carModel,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(widget.args.carColor,
                style: TextStyle(
                    fontSize: 11, color: ctx.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ]),
    );
  }
}
