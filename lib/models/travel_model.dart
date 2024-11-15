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
      "https://cdn-imgix.headout.com/blog-banner/image/f01bc213b95ab86534ee04fe64f21987-AdobeStock_68862154.jpeg",
      "https://cdn.britannica.com/33/242533-050-738E09AA/Dolmabahce-Palace-interior-Istanbul-Turkey.jpg",
    ],
    location: "Beşiktaş,İstanbul",
    review: random.nextInt(300) + 25,
    price: 0,
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 7,
    price: 0,
    name: "Galata Tower",
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/7galatakulesi-min-1920x1280.webp",
      "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcRQj3xppvmWffkdArDOxluDAgef2sUJyxQ6kx-yUGaQM1Pidl_dXwMpQ5qebUEoGwgKh_x9Erx2dxeirj_EuYF28JERGg8C-NXfxLnkHQ",
      "https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcTerclHPXfYrfn_kzZIlkPSRSGQyizsOwNPqHhBkDbnuKGhhqkuW2tNV94XFg6_ih6gVRAqxZnNvtc_vsTay9b0KUw3GI7aDPnR0FIVOQ",
      "https://muze.gov.tr/s3/SectionPicture/SP_e2f876b6-49c9-442e-be95-ea7c12f6b9a3.jpg",
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
    price: 0,
    category: 'recomend',
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/18kapalicarsi-min-1920x1282.webp",
      "https://media.istockphoto.com/id/485981826/tr/foto%C4%9Fraf/on-the-grand-bazaar-in-istanbul.jpg?s=612x612&w=0&k=20&c=qbON8eWkr-UXn7gwK8pKp0keqgml05RjZ6V10M44XX8=",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7iPxo9spWdygcxE2a9nbHpBIEV8JqO0lqJakA56JG_6_zu6Og5sC67aqVeACcRx-alek&usqp=CAU",
    ],
    location: "Fatih, İstanbul",
    description: description,
    rate: 4.9,
  ),
  TravelDestination(
    id: 8,
    name: "Hagia Sophia Mosque",
    review: random.nextInt(300) + 25,
    price: 0,
    category: "popular",
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/5ayasofya-min-1024x622.webp",
      "https://www.bosphorustoursistanbul.com/wp-content/uploads/2020/06/Hagia-Sophia.jpg",
      "https://www.insideoutinistanbul.com/wp-content/uploads/2024/01/Istanbul.jpg",
    ],
    location: "Fatih, İstanbul",
    description: description,
    rate: 4.5,
  ),
  TravelDestination(
    id: 1,
    name: "İstiklal Street",
    review: random.nextInt(300) + 25,
    price: 0,
    category: 'recomend',
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/9istiklalcaddesi-min-1920x1275.webp",
      "https://istanbulpoints.com/wp-content/uploads/2020/10/Depositphotos_179618424_s-2019-1.jpg"
          "https://hatirlayansehir.hakikatadalethafiza.org/wp-content/uploads/2019/01/Rota01_03_01.jpg",
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
    price: 0,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/6yerebatan-min-1024x683.webp",
      "https://visitturkey.in/wp-content/uploads/2024/07/Basilica-Cistern-1200x900.webp",
      "https://dwq3yv87q1b43.cloudfront.net/public/blogs/fit-in/1200x675/Blog_20240517-85784181-1715943311.jpg",
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
    price: 0,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/33belgradormani-min-1920x1277.jpeg",
      "https://upload.wikimedia.org/wikipedia/commons/8/83/Belgradormani2.jpg",
      "https://www.shutterstock.com/image-photo/turkey-istanbul-belgrad-forest-big-600nw-2260327417.jpg",
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
    price: 0,
    image: [
      "https://blog.obilet.com/wp-content/uploads/2021/10/35rumelihisari-min-1920x1281.webp",
      "https://www.bosphorustour.com/img/the-castle-at-rumeli-rumeli-hisar.jpg",
      "https://www.bosphorustour.com/img/the-castle-at-rumeli-rumeli-hisar-1.jpg",
    ],
    location: "Sarıyer, İstanbul",
    description: description,
    rate: 4.7,
  ),
];
const description =
    'This wonderful place of Istanbul is a masterpiece worth seeing. If you want to visit and see these places, you can find an option suitable for the accommodation you choose.';
