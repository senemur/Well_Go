import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // Kullanıcı konumunu almak için
import 'package:well_go/models/bottomnavigation_model.dart'; // BottomNavigationModel'ı import ediyoruz
import 'package:well_go/const.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedPage =
      1; // Başlangıçta Harita sekmesinin seçili olduğunu varsayıyoruz
  late GoogleMapController mapController; // Harita kontrolörü
  late Position _currentPosition; // Kullanıcının mevcut konumu
  Set<Marker> _markers = {}; // Harita üzerine yerleştirilecek marker'lar
  Map<MarkerId, String> markerDescriptions =
      {}; // Marker'lara ait açıklamaları tutan map

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Uygulama başladığında kullanıcı konumunu alıyoruz
  }

  // Kullanıcı konumunu almak için gerekli fonksiyon
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servislerinin etkin olup olmadığını kontrol et
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Eğer etkin değilse, kullanıcıya konum servislerini açmasını söyleyebiliriz
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    // Kullanıcı konumunu al
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
    });

    // Harita üzerinde kullanıcının konumunu göster
    /*
    mapController.animateCamera(
      CameraUpdate.newLatLng(
          LatLng(_currentPosition.latitude, _currentPosition.longitude)),
    );

     */
  }

  void onPageSelected(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  // Marker eklemek veya kaldırmak için fonksiyon
  void _addMarker(LatLng position) async {
    final markerId = MarkerId(position.toString());

    // Eğer marker zaten varsa, kaldırıyoruz
    if (_markers.any((marker) => marker.markerId == markerId)) {
      setState(() {
        _markers.removeWhere((marker) => marker.markerId == markerId);
        markerDescriptions
            .remove(markerId); // Marker silindiğinde açıklamayı da kaldırıyoruz
      });
    } else {
      // Eğer marker yoksa, ekliyoruz
      String description =
          await _showDescriptionBottomSheet(); // Kullanıcıdan açıklama alıyoruz
      setState(() {
        _markers.add(
          Marker(
            markerId: markerId,
            position: position,
            infoWindow: InfoWindow(
              title: 'Places',
              snippet: description, // Kullanıcı tarafından girilen açıklama
            ),
          ),
        );
        markerDescriptions[markerId] =
            description; // Açıklamayı map'e kaydediyoruz
      });
    }
  }

  // Kullanıcıdan açıklama almak için BottomSheet kullanıyoruz
  Future<String> _showDescriptionBottomSheet() async {
    String description = '';
    TextEditingController controller = TextEditingController();

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Marker Explanation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  description =
                      value; // Kullanıcı yazıyı girdikçe description değişiyor
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // BottomSheet'i kapatıyoruz
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      },
    );

    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map View"),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kButtonColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Google Map'ı ekliyoruz
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(41.0082, 28.9784), // Başlangıç konumu
                zoom: 15, // Yakınlaştırma seviyesi
              ),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: _markers, // Eklenen marker'lar
              onTap: (LatLng position) {
                // Harita üzerinde bir yere tıklayınca haritayı o noktaya odaklama
                mapController.animateCamera(
                  CameraUpdate.newLatLng(position),
                );
              },
              onLongPress: (LatLng position) {
                // Harita üzerinde bir yere uzun bastığınızda marker ekleme
                _addMarker(position);
              },
            ),
          ),
          // BottomNavigationBar'ı ekliyoruz
          BottomNavigationModel(
            selectedPage: selectedPage,
            onPageSelected: onPageSelected,
          ),
        ],
      ),
    );
  }
}
