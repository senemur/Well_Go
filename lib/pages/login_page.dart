import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:well_go/pages/question_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:well_go/const.dart';
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences import edildi

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool rememberMe = false; // Checkbox durumu
  late SharedPreferences prefs; // SharedPreferences'i burada tanımladık

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCredentials(); // Saklanan bilgileri yükle
  }

  // Register işlemi
  Future<void> register() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Kullanıcı bilgilerini Firestore'a kaydetme
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'firstName': nameController.text,
        'lastName': surnameController.text,
        'email': emailController.text,
      });

      // Remember Me'yi kontrol et
      await saveCredentials(emailController.text, passwordController.text);

      // Kayıt başarılı mesajı gösterme
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Register Successful! Now you can log in."),
            backgroundColor: kBackgroundColor,
          ),
        );
      }
      setState(() {
        isLogin = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kayıt başarısız: $e",
              style: TextStyle(color: Colors.white)),
          backgroundColor: kButtonColor,
        ),
      );
    }
  }

  // Login işlemi
  Future<void> login() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Kullanıcı bilgilerini Firestore'dan çekme
      var userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      var userData = userDoc.data();

      // Remember Me'yi kontrol et
      await saveCredentials(emailController.text, passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => QuestionPage()),
      );
    } catch (e) {
      print("Login Error: $e");
    }
  }

  // Kullanıcı bilgilerini sakla
  Future<void> saveCredentials(String email, String password) async {
    if (rememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  // Saklanan kullanıcı bilgilerini yükle
  Future<void> loadCredentials() async {
    prefs = await SharedPreferences
        .getInstance(); // SharedPreferences'i burada başlatıyoruz
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://wallpapercave.com/wp/wp3100510.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 175),
                    Text(
                      isLogin ? 'Login' : 'Register',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (!isLogin) ...[
                      TextField(
                        controller: nameController,
                        style: const TextStyle(color: kBackgroundColor),
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle: const TextStyle(color: kBackgroundColor),
                          prefixIcon:
                              const Icon(Icons.person, color: kButtonColor),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: surnameController,
                        style: const TextStyle(color: kBackgroundColor),
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          hintStyle: const TextStyle(color: kBackgroundColor),
                          prefixIcon: const Icon(Icons.person_outline,
                              color: kButtonColor),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: kBackgroundColor),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: kBackgroundColor),
                        prefixIcon:
                            const Icon(Icons.email, color: kButtonColor),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: kBackgroundColor),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: kBackgroundColor),
                        prefixIcon: const Icon(Icons.lock, color: kButtonColor),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const Text(
                          'FORGET PASSWORD',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLogin ? login : register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isLogin ? 'Login' : 'Register',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin
                              ? "Don't have an account?"
                              : "Already have an account?",
                          style: const TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: toggleForm,
                          child: Text(
                            isLogin ? 'Sign Up' : 'Login',
                            style: const TextStyle(color: kButtonColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
