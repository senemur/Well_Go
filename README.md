# 🌍✈️ Well Go 🌍✈️

**Well Go**, yapay zeka destekli bir seyahat ve rota planlama uygulamasıdır. Bu proje, kullanıcıların seyahat deneyimlerini kişiselleştirmek ve kolaylaştırmak amacıyla modern teknolojiler kullanılarak hazırlanmış bir mezuniyet projesidir.

## 📱 Ekran Görüntüleri

| Giriş Ekranı | Login & Register  | Ana Sayfa |AI Rehber |
|:---:|:---:|:---:|:---:|
| ![1](https://github.com/user-attachments/assets/a2f0d051-6f2b-4e90-81ca-8f25bf68fc20) |![2](https://github.com/user-attachments/assets/2ef8420b-54c0-4fed-b9e5-eb540ece8bda)| ![3](https://github.com/user-attachments/assets/9a35a372-de23-41fc-9321-2ca97988e99e) | ![8](https://github.com/user-attachments/assets/e2b9d470-371b-4631-b98c-19f3bc580692)|

| Şehir Detayı | Rota Planlama | Favoriler& Kayıtlı Rotalar | Şehirlerin Nüfus Yoğunluğu ve Gezgin Yorumları|
|:---:|:---:|:---:|:---:|
| ![4](https://github.com/user-attachments/assets/ccd37226-24f5-46b9-93e9-6301170cab8b)| ![5](https://github.com/user-attachments/assets/6108b67a-8efb-410d-af16-1592a099aca8)| ![6](https://github.com/user-attachments/assets/7fb0dc7c-5750-46ad-81c7-40852e48677e)|![7](https://github.com/user-attachments/assets/3b62f8f8-82ad-4107-9fc0-691cb1eed98e)
 |


## ✨ Özellikler

*   **🤖 GuidAI (Yapay Zeka Rehberi):** Google Gemini Pro destekli, kullanıcıların seyahatle ilgili sorularını yanıtlayan ve önerilerde bulunan akıllı asistan. Markdown desteği ile zengin metin formatında yanıtlar.
*   **🗺️ Rota Planlama:** Seçilen destinasyonlar için optimize edilmiş seyahat rotaları oluşturma.
*   **🏙️ Şehir ve Mekan Keşfi:** Popüler şehirleri ve turistik mekanları detaylı inceleme imkanı.
*   **📍 Harita Entegrasyonu:** Google Maps ile konum görüntüleme ve yönlendirme.
*   **👤 Kullanıcı Yönetimi:** Firebase Authentication ile güvenli giriş ve kayıt işlemleri.
*   **❤️ Favoriler:** Beğenilen şehirleri ve mekanları favorilere ekleme.
*   **💬 Yorumlar:** Şehirler, ilçeler hakkında yorum yapma ve diğer kullanıcıların yorumlarını okuma.
*   **💾 Yerel Depolama:** `get_storage` ile kullanıcı tercihlerinin cihazda saklanması.

## 🛠️ Kullanılan Teknolojiler ve Kütüphaneler

Bu proje **Flutter** kullanılarak geliştirilmiştir. Aşağıdaki temel paketler ve teknolojiler kullanılmıştır:

*   **Framework:** Flutter & Dart
*   **Backend & Auth:** Firebase (Core, Auth, Cloud Firestore)
*   **Yapay Zeka:** `google_generative_ai` (Gemini API)
*   **Harita:** `google_maps_flutter`, `google_maps_utils`, `geolocator`, `location`
*   **HTTP İstekleri:** `dio`, `http`
*   **Arayüz & Animasyon:** `animate_do`, `floating_draggable_widget`, `flutter_markdown`
*   **Yerel Depolama:** `get_storage`, `shared_preferences`
*   **Diğer:** `intl` (Tarih/Saat), `url_launcher` (Web/Harita yönlendirme)

## 🚀 Kurulum ve Başlangıç

Projeyi yerel makinenizde çalıştırmak için aşağıdaki adımları izleyin:

1.  **Projeyi Klonlayın:**
    ```bash
    git clone https://github.com/kullaniciadi/Well_Go.git
    cd Well_Go
    ```

2.  **Bağımlılıkları Yükleyin:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Kurulumu:**
    Proje Firebase kullanmaktadır. Kendi `google-services.json` (Android) ve `GoogleService-Info.plist` (iOS) dosyalarınızı ilgili klasörlere eklediğinizden veya Firebase CLI ile yapılandırdığınızdan emin olun.

4.  **API Anahtarları:**
    *   **Google Maps API:** `android/app/src/main/AndroidManifest.xml` ve `ios/Runner/AppDelegate.swift` dosyalarındaki API anahtarlarını kendi anahtarınızla güncelleyin.
    *   **Gemini API:** `lib/pages/ai_page.dart` içerisindeki API anahtarını kendi Gemini anahtarınızla değiştirin.

5.  **Uygulamayı Çalıştırın:**
    ```bash
    flutter run
    ```

---
Bu proje bir mezuniyet projesi olarak geliştirilmiştir.
