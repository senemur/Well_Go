import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:well_go/pages/profile_page.dart'; // Harita sayfası
import 'package:well_go/pages/map_page.dart'; // Profil sayfası
import 'package:well_go/pages/travel_home_screen.dart';
import 'package:well_go/const.dart';

class BottomNavigationModel extends StatefulWidget {
  final int selectedPage;
  final Function(int) onPageSelected;
  final Map<String, dynamic>?
      userData; // userData'yı parametre olarak ekliyoruz
  const BottomNavigationModel({
    Key? key,
    required this.selectedPage,
    required this.onPageSelected,
    this.userData, // userData'yı burada alıyoruz
  }) : super(key: key);

  @override
  State<BottomNavigationModel> createState() => _BottomNavigationModelState();
}

class _BottomNavigationModelState extends State<BottomNavigationModel> {
  List<IconData> icons = [
    Iconsax.home1,
    Icons.map_sharp,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 22,
            ),
            decoration: BoxDecoration(
              color: kButtonColor, // kButtonColor
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                icons.length,
                (index) => GestureDetector(
                  onTap: () {
                    widget.onPageSelected(index);
                    /* if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TravelHomeScreen(userData: widget.userData),
                        ),
                      );
                    } */
                    if (index == 1) {
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
                              userData: widget
                                  .userData), // userData'yı buraya geçiriyoruz
                        ),
                      );
                    }
                  },
                  child: Icon(
                    icons[index],
                    size: 32,
                    color: widget.selectedPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
