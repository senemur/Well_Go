import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:well_go/const.dart';
import 'login_page.dart';
import 'package:well_go/models/bottomnavigation_model.dart'; // BottomNavigationModel'ı import ediyoruz

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userData; // userData'yı alıyoruz
  const ProfileScreen({super.key, required this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;
  int selectedPage =
      3; // Profile sekmesinin varsayılan olarak seçili olduğunu varsayıyoruz

  @override
  void initState() {
    super
        .initState(); // Eğer userData null değilse, widget'tan gelen userData'yı kullanıyoruz
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
          // Varsayılan kullanıcı bilgileri
          setState(() {
            userData = {
              'firstName': 'Misafir',
              'lastName': '',
              'email': 'Bilinmiyor',
              'photoUrl': 'assets/images/profile_picture.png'
            };
          });
        }
      }
    } catch (e) {
      // Hata durumunda varsayılan değerler
      setState(() {
        userData = {
          'firstName': 'Hata',
          'lastName': '',
          'email': 'Kullanıcı verisi alınamadı',
          'photoUrl': 'assets/images/error_image.png'
        };
      });
      print("Veri çekme hatası: $e");
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
      appBar: AppBar(
        title: const Text(
          "Profile",
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
      body: userData != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profil fotoğrafı
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userData!['photoUrl'] != null
                        ? NetworkImage(userData!['photoUrl'])
                        : const AssetImage('assets/images/profile_picture.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 20),
                  // Kullanıcı adı ve soyadı
                  Text(
                    '${userData!['firstName'] ?? 'Misafir'} ${userData!['lastName'] ?? ''}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Kullanıcı emaili
                  Text(
                    userData!['email'] ?? 'Bilinmiyor',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  // Profil düzenleme
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: const Text("Edit Profile"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const Placeholder(), // Düzenleme sayfası eklenecek
                        ),
                      );
                    },
                  ),
                  // Ayarlar
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: const Text("Settings"),
                    onTap: () {
                      // Ayarlar ekranına yönlendirme
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Ayarlar ekranı henüz eklenmedi.")),
                      );
                    },
                  ),
                  // Çıkış yap
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text("Logout"),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
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
