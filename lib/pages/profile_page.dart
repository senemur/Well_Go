import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:well_go/const.dart';
import 'login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
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
          // Eğer veri bulunamazsa varsayılan değerler
          setState(() {
            userData = {
              'firstName': 'Misafir',
              'lastName': '',
              'email': 'Bilinmiyor',
              'photoUrl':
                  'assets/images/profile_picture.png' // Varsayılan profil resmi
            };
          });
        }
      }
    } catch (e) {
      print("Veri çekme hatası: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userData!['photoUrl'] != null
                        ? NetworkImage(userData!['photoUrl'])
                        : const AssetImage('assets/images/profile_picture.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${userData!['firstName'] ?? 'Misafir'} ${userData!['lastName'] ?? ''}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData!['email'] ?? 'Bilinmiyor',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: const Text("Edit Profile"),
                    onTap: () {
                      // Profil düzenleme fonksiyonu
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: const Text("Settings"),
                    onTap: () {
                      // Ayarlar sayfasına yönlendirme
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text("Logout"),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
