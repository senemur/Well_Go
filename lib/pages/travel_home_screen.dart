import 'package:flutter/material.dart';
import 'package:well_go/const.dart';
import 'package:well_go/pages/place_detail.dart';
import 'package:well_go/pages/profile_page.dart';
import 'package:well_go/widgets/popular_place.dart';
import 'package:well_go/widgets/recomendate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:well_go/pages/question_page.dart';

import '../models/travel_model.dart';
import 'package:well_go/pages/map_page.dart'; // Harita sayfası
import 'package:well_go/models/bottomnavigation_model.dart';

class TravelHomeScreen extends StatefulWidget {
  final Map<String, dynamic> userData; // Kullanıcı verilerini alıyoruz
  const TravelHomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<TravelHomeScreen> createState() => _TravelHomeScreenState();
}

class _TravelHomeScreenState extends State<TravelHomeScreen> {
  int selectedPage = 0; // Aktif sekme

  // Popüler ve önerilen yerler için filtreleme
  List<TravelDestination> popular =
      myDestination.where((element) => element.category == "popular").toList();
  List<TravelDestination> recomendate =
      myDestination.where((element) => element.category == "recomend").toList();

  void onPageSelected(int index) {
    setState(() {
      selectedPage = index;
    });
    // Burada herhangi bir başka işlemi de yapabilirsiniz, örneğin sayfa yönlendirme
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: headerParts(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular place",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 14,
                    color: blueTextColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 40),
            child: Row(
              children: List.generate(
                popular.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlaceDetailScreen(
                            destination: popular[index],
                          ),
                        ),
                      );
                    },
                    child: PopularPlace(
                      destination: popular[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommendation for you",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 14,
                    color: blueTextColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: List.generate(
                  recomendate.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaceDetailScreen(
                              destination: recomendate[index],
                            ),
                          ),
                        );
                      },
                      child: Recomendate(
                        destination: recomendate[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // BottomNavigationModel kullanımı
          BottomNavigationModel(
            selectedPage: selectedPage,
            onPageSelected: onPageSelected,
          ),
        ],
      ),
    );
  }

  AppBar headerParts() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leadingWidth: 180,
      leading: const Row(
        children: [
          SizedBox(width: 15),
          Icon(
            Iconsax.location,
            color: Colors.black,
          ),
          SizedBox(width: 5),
          Text(
            "Istanbul",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 30,
            color: Colors.black26,
          ),
        ],
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          padding: const EdgeInsets.all(7),
          child: const Stack(
            children: [
              Icon(
                Iconsax.notification,
                color: Colors.black,
                size: 30,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
