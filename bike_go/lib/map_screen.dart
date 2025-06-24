import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  final String styleUrl =
      "https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png";
  final String apiKey = "e745562c-4dac-4ef2-a917-b2a56945e990";

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData getIconForType(String type) {
    switch (type) {
      case 'banque':
        return Icons.account_balance;
      case 'restaurant':
        return Icons.restaurant;
      case 'hotel':
        return Icons.hotel;
      case 'poste':
        return Icons.local_post_office;
      case 'pharmacie':
        return Icons.local_pharmacy;
      case 'boutique':
        return Icons.store;
      case 'arret':
        return Icons.directions_bus;
      default:
        return Icons.location_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pointsInteret = [
      {
        "nom": "Poste Centrale",
        "lat": 3.848,
        "lng": 11.502,
        "type": "poste",
        "description": "La poste principale de Yaoundé."
      },
      {
        "nom": "Banque SGBC",
        "lat": 3.8492,
        "lng": 11.5015,
        "type": "banque",
        "description": "Agence SGBC proche du centre-ville."
      },
      {
        "nom": "Restaurant La Paix",
        "lat": 3.8475,
        "lng": 11.5032,
        "type": "restaurant",
        "description": "Restaurant populaire pour la cuisine locale."
      },
      {
        "nom": "Hôtel Djeuga Palace",
        "lat": 3.8503,
        "lng": 11.5008,
        "type": "hotel",
        "description": "Hôtel haut standing à Yaoundé."
      },
      {
        "nom": "Boutique Express",
        "lat": 3.8478,
        "lng": 11.5003,
        "type": "boutique",
        "description": "Épicerie de proximité."
      },
      {
        "nom": "Pharmacie Centrale",
        "lat": 3.8489,
        "lng": 11.504,
        "type": "pharmacie",
        "description": "Pharmacie ouverte 24h/24."
      },
      {
        "nom": "Arrêt de Bus",
        "lat": 3.8467,
        "lng": 11.501,
        "type": "arret",
        "description": "Point d’arrêt des bus interurbains."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Bike-Go'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(3.848, 11.502),
              zoom: 17,
            ),
            nonRotatedChildren: [
              RichAttributionWidget(attributions: [
                TextSourceAttribution("Stadia Maps",
                    onTap: () => launchUrl(Uri.parse("https://stadiamaps.com/")),
                    prependCopyright: true),
                TextSourceAttribution("OpenMapTiles",
                    onTap: () => launchUrl(Uri.parse("https://openmaptiles.org/")),
                    prependCopyright: true),
                TextSourceAttribution("OpenStreetMap",
                    onTap: () => launchUrl(Uri.parse("https://www.openstreetmap.org/copyright")),
                    prependCopyright: true),
              ])
            ],
            children: [
              TileLayer(
                urlTemplate: "$styleUrl?api_key={api_key}",
                additionalOptions: {"api_key": apiKey},
                maxZoom: 20,
              ),
              MarkerLayer(
                markers: [
                  ...pointsInteret.map((lieu) {
                    return Marker(
                      point: LatLng(lieu["lat"], lieu["lng"]),
                      width: 180,
                      height: 50,
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(lieu["nom"]),
                              content: Text(lieu["description"]),
                              actions: [
                                TextButton(
                                  child: Text('Fermer'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                getIconForType(lieu["type"]),
                                color: Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  lieu["nom"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  // Moto animée au-dessus du Djeuga Palace
                  Marker(
                    point: LatLng(3.8508, 11.5008),
                    width: 60,
                    height: 60,
                    builder: (ctx) => ScaleTransition(
                      scale: _animation,
                      child: Image.asset(
                        'assets/images/motorbike.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Bande inférieure animée
          Positioned(
            bottom: 80,
            left: 14,
            right: 14,
            child: ScaleTransition(
              scale: _animation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 187, 0, 1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.two_wheeler, color: Colors.black),
                    Text(
                      "Où allons-nous ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
