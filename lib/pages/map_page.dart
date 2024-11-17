import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  void onPageSelected(int index) {
    setState(() {
      selectedPage = index;
    });
    // Eğer harita sekmesi seçildiyse burada yönlendirme veya diğer işlemleri yapabilirsiniz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Map View",
          /*style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white), */
        ),
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
            child: const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Başlangıç konumu
                zoom: 10, // Yakınlaştırma seviyesi
              ),
              mapType: MapType.normal,
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

/*
MapScreen'i StatefulWidget olarak değiştirdim çünkü BottomNavigationModel'da aktif sekme değişikliklerini yönetmek için setState kullanmanız gerekecek.
selectedPage değişkeni ile aktif sayfa izleniyor ve BottomNavigationModel'a parametre olarak geçiyor.
onPageSelected fonksiyonu, seçilen sekme değiştiğinde çağrılacak ve aktif sekme değişecektir.
 */
