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
    mapController.animateCamera(
      CameraUpdate.newLatLng(
          LatLng(_currentPosition.latitude, _currentPosition.longitude)),
    );
  }

  void onPageSelected(int index) {
    setState(() {
      selectedPage = index;
    });
    // Eğer harita sekmesi seçildiyse burada yönlendirme veya diğer işlemleri yapabilirsiniz
  }

  // Marker eklemek için fonksiyon
  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'Gezilecek Yer',
            snippet: 'Burada çok güzel bir yer var!',
          ),
        ),
      );
    });
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
                target: LatLng(37.7749, -122.4194), // Başlangıç konumu
                zoom: 10, // Yakınlaştırma seviyesi
              ),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: _markers, // Eklenen marker'lar
              onTap: (LatLng position) {
                _addMarker(
                    position); // Harita üzerinde tıklanarak marker ekleyebiliriz
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
