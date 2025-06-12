import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class ItinerairePage extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;
  final double destinationLatitude;
  final double destinationLongitude;

  const ItinerairePage({
    super.key,
    required this.currentLatitude,
    required this.currentLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
  });

  @override
  State<ItinerairePage> createState() => _ItinerairePageState();
}

class _ItinerairePageState extends State<ItinerairePage> {
  List<LatLng> routePoints = [];
  LatLng? motoPosition;
  List<LatLng> motoToUserRoute = [];
  double? distance;
  double? duration;
  double? motoToUserDuration;
  int? selectedCategoryIndex;

  final List<Map<String, dynamic>> motoCategories = [
    {'name': 'Éco', 'multiplier': 100, 'image': 'assets/images/motorbike.png'},
    {'name': 'Confort', 'multiplier': 150, 'image': 'assets/images/motorcycle-with-ai-generated-free-png.webp'},
    {'name': 'Confort+', 'multiplier': 200, 'image': 'assets/images/motoconfort+.jpg'},
    {'name': 'Livraison', 'multiplier': 110, 'image': 'assets/images/motocourse.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    fetchMainRoute();
  }

  Future<void> fetchMainRoute() async {
    final data = await fetchRoute(
      widget.currentLatitude,
      widget.currentLongitude,
      widget.destinationLatitude,
      widget.destinationLongitude,
    );

    setState(() {
      routePoints = data['points'];
      distance = data['distance'];
      duration = data['duration'];
    });
  }

  Future<void> onCategorySelected(int index) async {
    setState(() {
      selectedCategoryIndex = index;
    });

    final random = Random();
    final offsetLat = (random.nextDouble() * 0.009) - 0.001;
    final offsetLng = (random.nextDouble() * 0.009) - 0.001;

    final newMotoLat = widget.currentLatitude + offsetLat;
    final newMotoLng = widget.currentLongitude + offsetLng;
    final newMotoPosition = LatLng(newMotoLat, newMotoLng);

    final data = await fetchRoute(
      newMotoLat,
      newMotoLng,
      widget.currentLatitude,
      widget.currentLongitude,
    );

    setState(() {
      motoPosition = newMotoPosition;
      motoToUserRoute = data['points'];
      motoToUserDuration = data['duration'];
    });
  }

  Future<Map<String, dynamic>> fetchRoute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car');

    final response = await http.post(
      url,
      headers: {
        'Authorization': '5b3ce3597851110001cf6248544edf171a8c4e8499cbc63b332de31a',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "coordinates": [
          [startLng, startLat],
          [endLng, endLat]
        ],
        "language": "fr"
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      final distanceKm = data['routes'][0]['summary']['distance'] / 1000;
      final durationMin = data['routes'][0]['summary']['duration'] / 60;

      final List coords = decodePolyline(geometry);
      return {
        'points': coords.map((e) => LatLng(e[1], e[0])).toList(),
        'distance': distanceKm,
        'duration': durationMin,
      };
    } else {
      throw Exception("Erreur de calcul d'itinéraire");
    }
  }

  List decodePolyline(String encoded) {
    List<List<double>> coordinates = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      coordinates.add([lng / 1E5, lat / 1E5]);
    }

    return coordinates;
  }

  @override
  Widget build(BuildContext context) {
    final bounds = LatLngBounds.fromPoints([
      LatLng(widget.currentLatitude, widget.currentLongitude),
      if (motoPosition != null) motoPosition!,
      LatLng(widget.destinationLatitude, widget.destinationLongitude),
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text("Itinéraire")),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: FlutterMap(
              options: MapOptions(
                bounds: bounds,
                boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(40)),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.bike_go',
                ),
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
                if (motoToUserRoute.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: motoToUserRoute,
                        strokeWidth: 4.0,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(widget.currentLatitude, widget.currentLongitude),
                      width: 60,
                      height: 60,
                      builder: (context) => const Icon(Icons.my_location, color: Colors.blue, size: 40),
                    ),
                    Marker(
                      point: LatLng(widget.destinationLatitude, widget.destinationLongitude),
                      width: 60,
                      height: 60,
                      builder: (context) => const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                    if (motoPosition != null)
                      Marker(
                        point: motoPosition!,
                        width: 50,
                        height: 50,
                        builder: (context) => const Icon(Icons.motorcycle, color: Colors.black, size: 30),
                      ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (distance != null && duration != null)
                    Text(
                      'Distance: ${distance!.toStringAsFixed(2)} km | Durée: ${duration!.toStringAsFixed(1)} min',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),

                  if (motoToUserDuration != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Moto arrive dans : ${motoToUserDuration!.toStringAsFixed(1)} min',
                        style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold),
                      ),
                    ),

                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: motoCategories.length,
                      itemBuilder: (context, index) {
                        final category = motoCategories[index];
                        final price = distance != null ? (distance! * category['multiplier']).round() : 0;
                        final isSelected = selectedCategoryIndex == index;

                        return GestureDetector(
                          onTap: () => onCategorySelected(index),
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue[50] : Colors.white,
                              border: Border.all(
                                color: isSelected ? Colors.blue : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(category['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('$price F'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
