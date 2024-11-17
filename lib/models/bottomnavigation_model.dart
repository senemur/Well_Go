import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:well_go/pages/profile_page.dart'; // Profil sayfası
import 'package:well_go/pages/map_page.dart'; // Harita sayfası
import 'package:well_go/pages/travel_home_screen.dart';
import 'package:well_go/const.dart';

class BottomNavigationModel extends StatefulWidget {
  final int selectedPage;
  final Function(int) onPageSelected;
  final Map<String, dynamic>? userData;

  const BottomNavigationModel({
    Key? key,
    required this.selectedPage,
    required this.onPageSelected,
    this.userData,
  }) : super(key: key);

  @override
  State<BottomNavigationModel> createState() => _BottomNavigationModelState();
}

class _BottomNavigationModelState extends State<BottomNavigationModel> {
  final List<IconData> icons = [
    Iconsax.home1,
    Icons.map_sharp,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
      decoration: const BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          icons.length,
          (index) => GestureDetector(
            onTap: () {
              widget.onPageSelected(index);
              if (index == 0) {
                // Home ikonu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TravelHomeScreen(
                      userData: widget.userData ??
                          {}, // Kullanıcı verisi parametre olarak gönderiliyor
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapScreen(),
                  ),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      userData: widget.userData,
                    ),
                  ),
                );
              }
            },
            child: Icon(
              icons[index],
              size: 30, // İkon boyutunu biraz küçülttük
              color: widget.selectedPage == index
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
