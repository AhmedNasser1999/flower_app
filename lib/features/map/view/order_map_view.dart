import 'dart:developer';

import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/contants/app_icons.dart';

class OrderMapView extends StatefulWidget {
  const OrderMapView({super.key});

  @override
  State<OrderMapView> createState() => _OrderMapViewState();
}

class _OrderMapViewState extends State<OrderMapView>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final LatLng _userLocation = const LatLng(30.046578, 31.235374);
  final LatLng _storeLocation = const LatLng(30.048026, 31.241605);
  final List<LatLng> _routePoints = [];

  final List<Marker> _markers = [];
  LatLng _currentVehiclePosition = const LatLng(0, 0);
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _setupRoute();
    _setupAnimation();
    _setupMarkers();
  }

  void _setupRoute() {
    _routePoints.addAll([
      _userLocation,
      const LatLng(30.046578, 31.235374),
      const LatLng(30.046614, 31.241001),
      const LatLng(30.047503, 31.240820),
      const LatLng(30.048026, 31.241605),
      _storeLocation,
    ]);

    _currentVehiclePosition = _routePoints.first;
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat(reverse: false);

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            setState(() {
              _progress = _animation.value;
              _updateVehiclePosition();
            });
          });
  }

  void _updateVehiclePosition() {
    if (_routePoints.length < 2) return;

    final double totalDistance = _calculateTotalDistance();
    double targetDistance = totalDistance * _progress;
    double accumulatedDistance = 0.0;

    for (int i = 0; i < _routePoints.length - 1; i++) {
      final LatLng start = _routePoints[i];
      final LatLng end = _routePoints[i + 1];
      final double segmentDistance = _calculateDistance(start, end);

      if (accumulatedDistance + segmentDistance >= targetDistance) {
        final double segmentProgress =
            (targetDistance - accumulatedDistance) / segmentDistance;
        _currentVehiclePosition =
            _interpolatePoint(start, end, segmentProgress);
        break;
      } else {
        accumulatedDistance += segmentDistance;
      }
    }
  }

  double _calculateTotalDistance() {
    double total = 0.0;
    for (int i = 0; i < _routePoints.length - 1; i++) {
      total += _calculateDistance(_routePoints[i], _routePoints[i + 1]);
    }
    return total;
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const Distance distance = Distance();
    return distance(start, end);
  }

  LatLng _interpolatePoint(LatLng start, LatLng end, double progress) {
    return LatLng(
      start.latitude + (end.latitude - start.latitude) * progress,
      start.longitude + (end.longitude - start.longitude) * progress,
    );
  }

  void _setupMarkers() {
    _markers.addAll([
      Marker(
        width: 80.0,
        height: 80.0,
        point: _userLocation,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(
                      AppIcons.flowerHomeIcon,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  const Text(
                    'Apartment',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.location_on_outlined,
                color: AppColors.pink, size: 24.0),
          ],
        ),
      ),
      Marker(
        width: 70.0,
        height: 80.0,
        point: _storeLocation,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      AppIcons.floweryIcon,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  const Text(
                    'Flowery',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.location_on_outlined,
                color: AppColors.pink, size: 24.0),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _calculateMapCenter(),
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 6.0,
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                doubleTapZoomDuration: Duration(milliseconds: 100),
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.flower_app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: AppColors.pink,
                    strokeWidth: 2.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  ..._markers,
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: _currentVehiclePosition,
                    child: _buildVehicleIcon(),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomSheet(),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleIcon() {
    return SvgPicture.asset(
      AppIcons.motorcycleDeliveryIcon,
      height: 14,
      width: 14,
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated arrival',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '03 Sep 2024, 11:00 AM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset(AppIcons.deliveryBoyIcon),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Omar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Is your delivery hero for today',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    call('+201122795825');
                  },
                  child: SvgPicture.asset(
                    AppIcons.phoneIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    shareViaWhatsApp('+201122795825');
                  },
                  child: SvgPicture.asset(
                    AppIcons.whatsappIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              child: Center(
                child: CustomElevatedButton(
                  text: 'Order Details',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LatLng _calculateMapCenter() {
    double avgLat = (_userLocation.latitude + _storeLocation.latitude) / 2;
    double avgLng = (_userLocation.longitude + _storeLocation.longitude) / 2;
    return LatLng(avgLat, avgLng);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

void call(String phoneNumber) async {
  final url = Uri.parse("tel:$phoneNumber");
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    log("Phone is not installed");
  }
}

void shareViaWhatsApp(String phoneNumber) async {
  final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  final phone =
  cleanedPhone.startsWith('+') ? cleanedPhone : '+$cleanedPhone';
  final url = Uri.parse("https://wa.me/$phone");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    final phoneUrl = Uri.parse("tel:$phone");
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    }
  }
}
