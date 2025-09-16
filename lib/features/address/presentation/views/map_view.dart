import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class MapView extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final Function(String) onAddressFetched;
  final LatLng? initialLocation; // Add this

  const MapView({
    super.key,
    required this.onLocationSelected,
    required this.onAddressFetched,
    this.initialLocation,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  bool _mapReady = false;
  bool _isLoadingLocation = false;

  LatLng? _currentPosition;
  Marker? _selectedMarker;
  String _currentAddress = '';

  LocationPermissionStatus _permissionStatus =
      LocationPermissionStatus.checking;
  final double _zoomLevel = 13.0;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _currentPosition = widget.initialLocation;
      _selectedMarker = Marker(
        point: widget.initialLocation!,
        width: 40,
        height: 40,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      );
    }
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local!.selectLocation,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (_permissionStatus == LocationPermissionStatus.checking)
          const Center(child: CircularProgressIndicator()),
        if (_permissionStatus == LocationPermissionStatus.granted) _buildMap(),
        if (_permissionStatus == LocationPermissionStatus.denied)
          _buildPermissionRequest(),
        if (_permissionStatus == LocationPermissionStatus.deniedForever)
          _buildPermissionPermanentlyDenied(),
        if (_permissionStatus == LocationPermissionStatus.serviceDisabled)
          _buildServiceDisabled(),
        /*    if (_currentAddress.isNotEmpty &&
            _permissionStatus == LocationPermissionStatus.granted)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _currentAddress,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),*/
      ],
    );
  }

  Future<void> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(
            () => _permissionStatus = LocationPermissionStatus.serviceDisabled);
        return;
      }

      final geoPerm = await Geolocator.checkPermission();
      if (geoPerm == LocationPermission.always ||
          geoPerm == LocationPermission.whileInUse) {
        setState(() => _permissionStatus = LocationPermissionStatus.granted);
        await _getCurrentLocation();
      } else if (geoPerm == LocationPermission.denied) {
        setState(() => _permissionStatus = LocationPermissionStatus.denied);
      } else if (geoPerm == LocationPermission.deniedForever) {
        setState(
            () => _permissionStatus = LocationPermissionStatus.deniedForever);
      }
    } catch (e, st) {
      debugPrint('Error checking permission: $e\n$st');
      setState(() => _permissionStatus = LocationPermissionStatus.error);
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      LocationPermission gp = await Geolocator.requestPermission();
      if (gp == LocationPermission.always ||
          gp == LocationPermission.whileInUse) {
        setState(() => _permissionStatus = LocationPermissionStatus.granted);
        await _getCurrentLocation();
      } else if (gp == LocationPermission.deniedForever) {
        setState(
            () => _permissionStatus = LocationPermissionStatus.deniedForever);
        await openAppSettings();
      } else {
        setState(() => _permissionStatus = LocationPermissionStatus.denied);
      }
    } catch (e) {
      debugPrint('Error requesting permission: $e');
      setState(() => _permissionStatus = LocationPermissionStatus.error);
    }
  }

  Future<void> _getCurrentLocation() async {
    if (_isLoadingLocation) return;

    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location services are disabled")),
        );
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission denied")),
          );
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "Location permission permanently denied. Enable it in settings.")),
        );
        await openAppSettings();
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 10),
        ),
      );

      final newPos = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = newPos;
        _selectedMarker = Marker(
          point: newPos,
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, color: AppColors.pink, size: 36),
        );
      });

      if (_mapReady) {
        _mapController.move(newPos, 16.0);
      }

      widget.onLocationSelected(newPos);
      await _getAddressFromLatLng(newPos);
    } catch (e) {
      debugPrint("Error getting current location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: $e")),
      );
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placeMarks.isNotEmpty) {
        final place = placeMarks.first;
        final addressParts = <String>[
          if (place.street?.isNotEmpty ?? false) place.street!,
          if (place.locality?.isNotEmpty ?? false) place.locality!,
          if (place.administrativeArea?.isNotEmpty ?? false)
            place.administrativeArea!,
          if (place.country?.isNotEmpty ?? false) place.country!,
        ];

        final address = addressParts.join(', ');
        setState(() => _currentAddress = address);
        widget.onAddressFetched(address);
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
  }

  Future<void> _onMapTap(TapPosition tapPosition, LatLng latLng) async {
    if (_permissionStatus != LocationPermissionStatus.granted) {
      await _requestLocationPermission();
      if (_permissionStatus != LocationPermissionStatus.granted) return;
    }

    final marker = Marker(
      point: latLng,
      width: 40,
      height: 40,
      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
    );

    setState(() {
      _selectedMarker = marker;
      _currentPosition = latLng;
    });

    widget.onLocationSelected(latLng);
    await _getAddressFromLatLng(latLng);
  }

  Widget _buildMap() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter:
                    _currentPosition ?? const LatLng(30.041570, 31.236346),
                initialZoom: _zoomLevel,
                minZoom: 2,
                maxZoom: 18,
                cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(
                    const LatLng(-85.0, -180.0),
                    const LatLng(85.0, 180.0),
                  ),
                ),
                onMapReady: () {
                  _mapReady = true;
                  if (_currentPosition != null) {
                    _mapController.move(_currentPosition!, _zoomLevel);
                  }
                },
                onTap: _onMapTap,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.flower_app',
                  tileBounds: LatLngBounds(
                    const LatLng(-85.0, -180.0),
                    const LatLng(85.0, 180.0),
                  ),
                  keepBuffer: 2,
                ),
                if (_selectedMarker != null)
                  MarkerLayer(markers: [_selectedMarker!]),
              ],
            ),
            if (_isLoadingLocation)
              const Center(child: CircularProgressIndicator()),
            Positioned(
              right: 8,
              bottom: 8,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'zoomIn',
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _mapController.move(
                        _mapController.camera.center,
                        _mapController.camera.zoom + 1,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.pink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: 'zoomOut',
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _mapController.move(
                        _mapController.camera.center,
                        _mapController.camera.zoom - 1,
                      );
                    },
                    child: Icon(
                      Icons.remove,
                      color: AppColors.pink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: 'myLocation',
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: _getCurrentLocation,
                    child: Icon(
                      Icons.my_location,
                      color: AppColors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionRequest() {
    return Column(
      children: [
        const Text('Location permission required'),
        ElevatedButton(
          onPressed: _requestLocationPermission,
          child: const Text('Grant Permission'),
        ),
      ],
    );
  }

  Widget _buildPermissionPermanentlyDenied() {
    return Column(
      children: [
        const Text('Location permission permanently denied'),
        ElevatedButton(
          onPressed: () => openAppSettings(),
          child: const Text('Open Settings'),
        ),
      ],
    );
  }

  Widget _buildServiceDisabled() {
    return Column(
      children: [
        const Text('Location services are disabled'),
        ElevatedButton(
          onPressed: () => Geolocator.openLocationSettings(),
          child: const Text('Enable Location'),
        ),
      ],
    );
  }
}

enum LocationPermissionStatus {
  checking,
  granted,
  denied,
  deniedForever,
  serviceDisabled,
  error,
}
