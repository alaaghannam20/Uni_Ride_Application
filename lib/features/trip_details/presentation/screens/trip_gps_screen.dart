import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

// ── Checkpoint Data Model ────────────────────────────────────────────────────
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

  factory CheckpointData.fromJson(Map<String, dynamic> json) {
    return CheckpointData(
      id: json['id'] ?? '',
      checkpoint: json['checkpoint'] ?? '',
      city: json['city'] ?? '',
      enteringStatus: json['entering_status'] ?? '',
      leavingStatus: json['leaving_status'] ?? '',
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}

// ── Checkpoint Service ───────────────────────────────────────────────────────
class CheckpointService {
  static const String apiKey = 'arw_25d6362cde01937614b022a8f92e5298fae369989b2da4d8fef2aa4384656947';
  static const String baseUrl = 'https://aweenrayeh.com';

  Future<List<CheckpointData>> fetchCheckpoints(String city) async {
    try {
      final url = '$baseUrl/api/v1/checkpoints/city/$city';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-API-Key': apiKey,
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> data = jsonData['data'] ?? [];
        
        return data
            .map((checkpoint) => CheckpointData.fromJson(checkpoint))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or missing API key. Please verify your API key is correct.');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else if (response.statusCode == 403) {
        throw Exception('Your IP has been temporarily blocked. Please wait 5 minutes and try again.');
      } else {
        throw Exception('Failed to fetch checkpoints: ${response.statusCode} - ${response.body}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: $e');
    } catch (e) {
      throw Exception('Error fetching checkpoints: $e');
    }
  }
}

// ── Trip GPS Arguments ───────────────────────────────────────────────────────
class TripGpsArgs {
  final String driverName;
  final double driverRating;
  final String carModel;
  final String carColor;

  const TripGpsArgs({
    required this.driverName,
    required this.driverRating,
    required this.carModel,
    required this.carColor,
  });
}

// ── Trip GPS Screen ──────────────────────────────────────────────────────────
class TripGpsScreen extends StatefulWidget {
  final TripGpsArgs args;
  const TripGpsScreen({super.key, required this.args});

  @override
  State<TripGpsScreen> createState() => _TripGpsScreenState();
}

class _TripGpsScreenState extends State<TripGpsScreen> {
  late GoogleMapController mapController;
  final CheckpointService _checkpointService = CheckpointService();
  
  static const LatLng ramallahCenter = LatLng(31.9454, 35.2075);
  static const LatLng driverLocation = LatLng(31.9500, 35.2120);
  
  List<CheckpointData> checkpoints = [];
  bool isLoading = true;
  bool _isSheetExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchCheckpoints();
  }

  Future<void> _fetchCheckpoints() async {
    try {
      final data = await _checkpointService.fetchCheckpoints('ramallah');
      if (mounted) {
        setState(() {
          checkpoints = data;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: ramallahCenter,
              zoom: 13.5,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('driver'),
                position: driverLocation,
                infoWindow: InfoWindow(title: widget.args.driverName),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              ),
            },
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                color: Colors.white.withOpacity(0.95),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE8E8E8)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 14,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Track Trip',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Driver info card
          Positioned(
            top: 70,
            right: 16,
            left: 16,
            child: _buildDriverCard(),
          ),

          // Bottom sheet (Checkpoints)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildCheckpointsSheet(l),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFCF8307).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                widget.args.driverName.isNotEmpty 
                  ? widget.args.driverName.substring(0, 1).toUpperCase()
                  : '?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCF8307),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.args.driverName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 13, color: Color(0xFFCF8307)),
                    const SizedBox(width: 3),
                    Text(
                      '${widget.args.driverRating}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFCF8307),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.args.carModel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.args.carColor,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF888888),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckpointsSheet(AppLocalizations l) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Column(
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 16),
            child: GestureDetector(
              onTap: () {
                setState(() => _isSheetExpanded = !_isSheetExpanded);
              },
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Title with icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFFCF8307),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Checkpoint Status',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCF8307).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${checkpoints.length} Checkpoints',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCF8307),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Checkpoints list
          Expanded(
            child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFCF8307)),
                )
              : checkpoints.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_rounded,
                          color: Colors.grey[300],
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No checkpoints available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: checkpoints.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) {
                      final checkpoint = checkpoints[index];
                      return _buildCheckpointItem(checkpoint, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckpointItem(CheckpointData checkpoint, int index) {
    final isOpen = checkpoint.enteringStatus == 'سالك';
    final statusColor = isOpen ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
    final statusIcon = isOpen ? Icons.check_circle_rounded : Icons.block_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Status circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Checkpoint info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    checkpoint.checkpoint,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'In: ',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888888),
                        ),
                      ),
                      Text(
                        checkpoint.enteringStatus,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Out: ',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888888),
                        ),
                      ),
                      Text(
                        checkpoint.leavingStatus,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: checkpoint.leavingStatus == 'سالك'
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF6B6B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Index badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFCF8307).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${index + 1}/${checkpoints.length}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCF8307),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
