import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GoogleMap extends StatefulWidget {
  const GoogleMap({super.key});

  @override
  State<GoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  final MapController mapController = MapController();
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final String orsApiKey =
      'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjY1MDliYWE0MzFmNDRmZTk4ZDJjM2M0MmY1MTRkODljIiwiaCI6Im11cm11cjY0In0=';

  final LatLng userLocation = LatLng(37.7749, -122.4194);
  final LatLng storeLocation = LatLng(37.8049, -122.4294);
  final LatLng motoLocation = LatLng(
    (37.7749 + 37.8049) / 2,
    (-122.4194 + -122.4294) / 2,
  );

  @override
  void initState() {
    super.initState();
    _setupLocations();
  }

  void _setupLocations() {
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: userLocation,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: storeLocation,
          child: const Icon(Icons.store, color: Colors.red, size: 40.0),
        ),
      );
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: motoLocation,
          child: const Icon(Icons.two_wheeler, color: Colors.black, size: 40.0),
        ),
      );
    });
    _getRoute(userLocation, storeLocation);
  }

  Future<void> _getRoute(LatLng start, LatLng destination) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        routePoints = coords
            .map((coord) => LatLng(coord[1], coord[0]))
            .toList();
      });
    } else {
      print('Failed to fetch the route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Order Map'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(
            (userLocation.latitude + storeLocation.latitude) / 2,
            (userLocation.longitude + storeLocation.longitude) / 2,
          ),
          initialZoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
          if (routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
      bottomSheet: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estimated arrival',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '03 Sep 2024, 11:00 AM',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Divider(color: Colors.grey[300], thickness: 1.0, height: 16.0),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ahmed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Is your delivery hero for today',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.black, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Order Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
