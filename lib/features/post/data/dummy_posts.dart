import 'package:clozii/features/post/data/post.dart';

List<Post> dummyPosts = [
  Post(
    id: '1',
    title: 'iPhone 13 for sale',
    content: 'Great conditions! \nComes with case and charger.',
    createdAt: DateTime.now().subtract(Duration(seconds: 50)),
    updatedAt: DateTime.now().subtract(Duration(seconds: 50)),
    tradeType: TradeType.sell,
    price: 7200,
    imageUrls: [
      'https://images.unsplash.com/photo-1726574686436-5ef90358e032?q=80&w=969&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
  ),
  Post(
    id: '2',
    title: 'Free book giveaway!',
    content: 'Giving away 5 novels for free. Meet-up near the subway station.',
    createdAt: DateTime.now().subtract(Duration(hours: 1)),
    updatedAt: DateTime.now().subtract(Duration(hours: 1)),
    tradeType: TradeType.share,
    imageUrls: [
      'https://hips.hearstapps.com/hmg-prod/images/gh-best-romance-books-64ecb8c82221e.png?crop=0.502xw:1.00xh;0.250xw,0&resize=1200:*',
    ],
    price: 0,
  ),
  Post(
    id: '3',
    title: 'Gaming chair for sale',
    content: 'Used but still sturdy. Color: Black/Red.',
    createdAt: DateTime.now().subtract(Duration(hours: 5)),
    updatedAt: DateTime.now().subtract(Duration(hours: 5)),
    tradeType: TradeType.sell,
    price: 3300,
    imageUrls: [
      'https://xrocker.co.uk/cdn/shop/files/fury-rgb-junior-gaming-chair-1.jpg',
    ],
  ),
  Post(
    id: '4',
    title: 'Dog food giveaway',
    content:
        'Brand new dog food left over, giving away to anyone who needs it.',
    imageUrls: [
      'https://headsupfortails.com/cdn/shop/files/8906002482832_10kg.jpg?v=1754125871&width=1445',
    ],
    price: 0,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    tradeType: TradeType.share,
  ),
  Post(
    id: '5',
    title: 'Laptop for sale',
    content: 'Dell XPS 13, lightly used, includes original charger.',
    imageUrls: [
      'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/xps-notebooks/xps-13-9350/spi/platinum/oled/notebook-xps-13-9350-oled-silver-campaign-hero-504x350-ng.psd?fmt=jpg&wid=570&hei=400',
    ],
    price: 20500,
    createdAt: DateTime.now().subtract(const Duration(minutes: 58)),
    updatedAt: DateTime.now().subtract(const Duration(minutes: 58)),
    tradeType: TradeType.sell,
  ),
  Post(
    id: '6',
    title: 'Kitchenware giveaway',
    content: 'Set of plates and cups, barely used. Free to pick up.',
    imageUrls: [
      'https://www.ikea.com/global/assets/range-categorisation/images/dinnerware-sets-31781.jpeg',
    ],
    price: 0,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
    tradeType: TradeType.share,
  ),
  Post(
    id: '7',
    title: 'Mountain bike for sale',
    content: 'Giant mountain bike, excellent condition, good for trails.',
    imageUrls: [
      'https://www.canyon.com/dw/image/v2/BCML_PRD/on/demandware.static/-/Sites-canyon-storefront/default/dwead92c71/category-landing/mountain/seo-mtb-light.jpg?sw=1280&sfrm=jpg&q=80',
    ],
    price: 8900,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    tradeType: TradeType.sell,
  ),
  Post(
    id: '8',
    title: 'Clothes giveaway',
    content: 'Bag of T-shirts and jeans, free if you can pick them up.',
    imageUrls: [
      'https://www.shutterstock.com/shutterstock/photos/517957723/display_1500/stock-photo-wardrobe-with-clothes-and-shopping-bags-on-line-shopping-close-up-on-many-full-bags-in-a-woman-517957723.jpg',
    ],
    price: 0,
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    tradeType: TradeType.share,
  ),
  Post(
    id: '9',
    title: 'PlayStation 5 for sale',
    content: 'PS5 console with one controller, rarely used.',
    imageUrls: [
      'https://as1.ftcdn.net/v2/jpg/05/62/73/08/1000_F_562730828_RWKHyahgDFwinSf4vcID8jEG2ns1Bgfd.jpg',
    ],
    price: 15000,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    tradeType: TradeType.sell,
  ),
  Post(
    id: '10',
    title: 'Baby stroller giveaway',
    content: 'Used stroller in good condition. Free for pick up.',
    imageUrls: [
      'https://i5.walmartimages.com/seo/Costway-Foldable-Baby-Stroller-2-in-1-Newborn-Infant-Travel-Buggy-Pushchair-22-lbs-Gray_d5d0e7ba-e1df-4ee5-bd37-6c4a934cf317.38a838b43c51749c9fe66efca6bb9f8a.jpeg',
    ],
    price: 0,

    createdAt: DateTime.now().subtract(const Duration(days: 6)),
    updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    tradeType: TradeType.share,
  ),
];
