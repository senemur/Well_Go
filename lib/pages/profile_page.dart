import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'package:well_go/models/bottomnavigation_model.dart';
import 'package:well_go/const.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;
  int selectedPage = 3;

  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      setState(() {
        userData = widget.userData!;
      });
    } else {
      fetchUserProfile(); // Firebase'den veri çekmeye devam et
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Eğer giriş yapılmışsa kullanıcı bilgilerini Firebase'den al
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (snapshot.exists && snapshot.data() != null) {
          setState(() {
            userData = snapshot.data()!;
          });
        } else {
          // Giriş yapılmış ancak kullanıcı verisi bulunamamışsa varsayılan bilgileri yükle
          // Varsayılan kullanıcı bilgileri
          setState(() {
            userData = {
              'firstName': 'Guest',
              'lastName': '',
              'email': 'Unknown',
              'photoUrl': 'assets/images/profile_picture.png'
            };
          });
        }
      } else {
        // Eğer giriş yapılmamışsa, misafir kullanıcı bilgilerini yükle
        setState(() {
          userData = {
            'firstName': 'Guest',
            'lastName': '',
            'email': 'No login',
            'photoUrl': 'assets/images/profile_picture.png',
          };
        });
      }
    } catch (e) {
      // Hata durumunda varsayılan değerler
      setState(() {
        userData = {
          'firstName': 'Error',
          'lastName': '',
          'email': 'Error retrieving data',
          'photoUrl': 'assets/images/error_image.png'
        };
      });
      print("Data fetch error: $e");
    }
  }

  void onPageSelected(int index) {
    setState(() {
      selectedPage = index;
    });
    // Kullanıcı profili sayfasına geldiğinde alt sekmelerin nasıl çalıştığını buradan yönetebilirsiniz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor, // Açık bir arka plan
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: userData != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: userData!['photoUrl'] != null
                        ? NetworkImage(userData!['photoUrl'])
                        : const AssetImage('assets/images/profile_picture.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userData!['firstName'] ?? 'Guest'} ${userData!['lastName'] ?? ''}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData!['email'] ?? 'Unknown',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: Icons.person,
                          text: "Edit Profile",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Edit Profile screen is not ready yet.")),
                            );
                          },
                        ),
                        const Divider(),
                        ProfileMenuItem(
                          icon: Icons.settings,
                          text: "Settings",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Settings screen is not ready yet.")),
                            );
                          },
                        ),
                        const Divider(),
                        ProfileMenuItem(
                          icon: Icons.logout,
                          text: "Logout",
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      // BottomNavigationBar'ı ekliyoruz
      bottomNavigationBar: BottomNavigationModel(
        selectedPage: selectedPage,
        onPageSelected: onPageSelected,
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 28),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
