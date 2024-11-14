import 'dart:math';

Random random = Random();

class TravelDestination {
  final int id, price, review;
  final List<String>? image;
  final String name, description, category, location;
  final double rate;

  TravelDestination({
    required this.name,
    required this.price,
    required this.id,
    required this.category,
    required this.description,
    required this.review,
    required this.image,
    required this.rate,
    required this.location,
  });
}

List<TravelDestination> myDestination = [
  TravelDestination(
    id: 2,
    name: "Dolmabahçe Palace",
    category: 'popular',
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/1dolmabahcesarayi-min-1920x1281.webp",
      "https://plus.unsplash.com/premium_photo-1688645554172-d3aef5f837ce?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bW91bnQlMjBldmVyZXN0fGVufDB8fDB8fHww",
      "https://media.breezeadventure.com/uploads/media/blog-photos/mt.everest-location%281%29.jpg",
      "https://nationalparks-15bc7.kxcdn.com/images/parks/sagarmatha/Sagarmatha%20National%20Park.jpg",
    ],
    location: "Beşiktaş,İstanbul",
    review: random.nextInt(300) + 25,
    price: 999,
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 7,
    price: 100,
    name: "Galata Tower",
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/7galatakulesi-min-1920x1280.webp",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Pashupatinath_Temple-2020.jpg/1200px-Pashupatinath_Temple-2020.jpg",
      "https://miro.medium.com/v2/resize:fit:982/1*P7It43hWVB-UWxl2WuT26w.jpeg",
      "https://holidaystonepal.in/media/files/Blogs/Pashupatinath-Temple-Photos/pashupatinath-viewpoint.png",
    ],
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Beyoğlu, İstanbul",
    description: description,
    rate: 4.8,
  ),
  TravelDestination(
    id: 3,
    name: "Grand Bazaar",
    review: random.nextInt(300) + 25,
    price: 599,
    category: 'recomend',
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/18kapalicarsi-min-1920x1282.webp",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFF40BKievkEY2Kd1wP-MEcK1ITOdvf_DzhA&s",
      "https://upload.wikimedia.org/wikipedia/commons/1/18/BRP_Lumbini_Mayadevi_temple.jpg",
      "https://blogger.googleusercontent.com/img/a/AVvXsEgJLGz7rSD1euAgJjZipKghOwfNYcXHYzAKNPIak9V6sfHj5QI1fSMkQQa3LbYstY0JsPQ4Uad6Z4aoqEeJfSXtyhojJHog73SCPmqLE-CyNrqGpjKDFQhNcMJ3Hg46F7qF75XzYLz9W7qqckJQHY4dGbpquC0NiGjDnGhh0OQvM7tH_v5FKmyDTv_mC4g",
    ],
    location: "Fatih, İstanbul",
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 8,
    name: "Hagia Sophia Mosque",
    review: random.nextInt(300) + 25,
    price: 777,
    category: "popular",
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/5ayasofya-min-1024x622.webp",
      "https://facts.net/wp-content/uploads/2023/09/16-unbelievable-facts-about-rara-lake-1694520647.jpg",
      "https://www.insidehimalayas.com/wp-content/uploads/2018/08/42089507610_036a78545e_k.jpg",
    ],
    location: "Fatih, İstanbul",
    description: description,
    rate: 4.5,
  ),
  TravelDestination(
    id: 1,
    name: "İstiklal Street",
    review: random.nextInt(300) + 25,
    price: 920,
    category: 'recomend',
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/9istiklalcaddesi-min-1920x1275.webp",
      "https://upload.wikimedia.org/wikipedia/commons/2/27/Kali_Gandaki_Valley%2C_Road%2C_Mustang%2C_Nepal%2C_Himalaya.jpg",
      "https://static.toiimg.com/photo/54323153.cms",
      "https://www.nepalguideinfo.com/new/wp-content/uploads/2024/01/upper_mustang_mansoon-1024x517-1.jpg"
    ],
    location: "Beyoğlu, İstanbul",
    description: description,
    rate: 4.6,
  ),
  TravelDestination(
    id: 9,
    name: "Basilica Cistern",
    review: random.nextInt(300) + 25,
    category: "popular",
    price: 199,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/6yerebatan-min-1024x683.webp",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNn9DYI6MivBwG2NDgZf7R8A6RHxzSHJTVfA&s",
      "https://superdesk-pro-c.s3.amazonaws.com/sd-nepalitimes/20221108101132/636a22729c7e80680e04178cjpeg.jpg",
      "https://highlightstourism.com/wp-content/uploads/2023/01/SA_Surkhet_0939.jpg",
    ],
    location: "Fatih, İstanbul",
    description: description,
    rate: 4.7,
  ),
  TravelDestination(
    id: 12,
    name: "Belgrad Forest",
    category: "recomend",
    review: random.nextInt(300) + 25,
    price: 499,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/33belgradormani-min-1920x1277.jpeg",
      "https://www.travelandleisure.com/thmb/kfcKH88gBt_d1ZJPFg_rUcyMekU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-grand-teton-USMNTNSIPOG0823-2538d183b9094e3fb59dd5e54bbe791c.jpg",
      "https://assets.iflscience.com/assets/articleNo/73209/aImg/74597/longest-ocean-range-meta.jpg",
      "https://www.brit.co/media-library/image.jpg?id=20912072&width=600&height=600&quality=90&coordinates=0%2C0%2C0%2C0",
    ],
    location: "Sarıyer, İstanbul",
    description: description,
    rate: 4.8,
  ),
  TravelDestination(
    id: 14,
    name: "Rumeli Fortress ",
    review: random.nextInt(300) + 25,
    category: "recomend",
    price: 99,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/35rumelihisari-min-1920x1281.webp",
      "https://mountainroutes.com/wp-content/uploads/2022/07/KTM-Durbar-Square.jpg",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGdbXCAE475wXv2GuDOEyRTwj2Lomg5KGZMxR8GMEupL2e4KAx1fiqvnbeUBXW2HpFgfU&usqp=CAU",
    ],
    location: "Sarıyer, İstanbul",
    description: description,
    rate: 4.7,
  ),
];
const description =
    'Travel places offer a wide array of experiences, each with its own unique charm and appeal. From stunning natural landscapes to historic landmarks, there is something for every traveler. Coastal TravelDestinations like tropical beaches invite relaxation with crystal-clear waters, while mountainous regions offer adventurous hiking trails and breathtaking views.';
