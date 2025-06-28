import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'itineraire_page.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final TextEditingController destinationController = TextEditingController();

  final List<Map<String, dynamic>> lieux = [
    {"nom": "poste centrale", "lat": 3.848, "lng": 11.502},
    {"nom": "banque SGBC", "lat": 3.8492, "lng": 11.5015},
    {"nom": "restaurant la paix", "lat": 3.8475, "lng": 11.5032},
    {"nom": "hôtel djeuga palace", "lat": 3.8503, "lng": 11.5008},
    {"nom": "boutique express", "lat": 3.8478, "lng": 11.5003},
    {"nom": "pharmacie centrale", "lat": 3.8489, "lng": 11.504},
    {"nom": "arrêt de Bus", "lat": 3.8467, "lng": 11.501},
    {"nom":"olembe","lat":4.289628, "lng":11.658448},
    {"nom":"olembe stade yaounde","lat":3.848024, "lng":11.502013},
    {"nom":"olembe pharmacy","lat":3.956843, "lng":11.533337},
    {"nom":" echengeur olembe","lat":3.955250, "lng":11.531405},
    {"nom":"dispensaire messasi","lat":3.946190, "lng":11.522083},
    {"nom":"dispensaire nkozoa","lat":3.974825, "lng":11.543190},
    {"nom":"marche messasi","lat":3.941813, "lng":11.518187},
    {"nom":"marche etoudi","lat":3.915551, "lng":11.529189},
    {"nom":"fokou etoudi","lat":3.916170, "lng":11.522834},
    {"nom":"emana","lat":3.935129, "lng":11.519041},
    {"nom":"pont emana","lat":3.932078, "lng":11.519782},
    {"nom":"fokou emana","lat":3.932375, "lng":11.513890},
    // {"nom":"","lat": , "lng": },
    // {"nom":"","lat": , "lng": },
    // {"nom":"","lat": , "lng": },
    // {"nom":"","lat": , "lng": },
  ];

  void rechercherDestination() async {
    String input = destinationController.text.trim();
    Map<String, dynamic>? lieu;

    try {
      lieu = lieux.firstWhere(
        (element) =>
            element['nom'].toString().toLowerCase() == input.toLowerCase(),
      );
    } catch (e) {
      lieu = null;
    }

    if (lieu != null) {
       double fixedLatitude = 3.952769;
       double fixedLongitude = 11.516665;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Position actuelle: ${position.latitude}, ${position.longitude}');
      print('Destination lat: ${lieu['lat']}, lng: ${lieu['lng']}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItinerairePage(
            currentLatitude: fixedLatitude,
            currentLongitude: fixedLongitude,
            destinationLatitude: lieu?['lat']?? 0.0,
            destinationLongitude: lieu?['lng']?? 0.0,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lieu inconnu"),
          content: const Text("Veuillez entrer un nom d'endroit valide."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choisir la destination")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: "Entrez le nom de votre destination",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: rechercherDestination,
              child: const Text("Go"),
            ),
          ],
        ),
      ),
    );
  }
}
