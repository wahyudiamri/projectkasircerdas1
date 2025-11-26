class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String? imageUrl;
  final List<String> paymentMethods; // ⬅️ tambahkan ini

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    required this.paymentMethods, // ⬅️ wajib diisi
  });

  // Sample products
  static List<Product> sampleProducts = [
    // Makanan (Food)
    Product(
      id: '1',
      name: 'Nasi Goreng',
      price: 15000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400',
      paymentMethods: ['Cash', 'QRIS', 'E-Wallet'],
    ),
    Product(
      id: '2',
      name: 'Ayam Bakar',
      price: 20000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '3',
      name: 'Bakso',
      price: 12000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=400',
      paymentMethods: ['Cash', 'QRIS', 'Transfer Bank'],
    ),
    Product(
      id: '4',
      name: 'Sate Ayam',
      price: 18000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '5',
      name: 'Mie Goreng',
      price: 13000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=400',
      paymentMethods: ['Cash', 'QRIS', 'E-Wallet'],
    ),
    Product(
      id: '6',
      name: 'Ayam Goreng',
      price: 17000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '8',
      name: 'Rendang',
      price: 25000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '10',
      name: 'Soto Ayam',
      price: 15000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '11',
      name: 'Nasi Padang',
      price: 22000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=400',
      paymentMethods: ['Cash', 'QRIS', 'Transfer Bank'],
    ),
    Product(
      id: '12',
      name: 'Ayam Rica-Rica',
      price: 19000,
      category: 'Makanan',
      imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),

    // Minuman (Drinks)
    Product(
      id: '13',
      name: 'Es Teh',
      price: 5000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
      paymentMethods: ['Cash'],
    ),
    Product(
      id: '14',
      name: 'Kopi Hitam',
      price: 8000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=400',
      paymentMethods: ['Cash', 'E-Wallet'],
    ),
    Product(
      id: '15',
      name: 'Jus Jeruk',
      price: 10000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=400',
      paymentMethods: ['Cash'],
    ),
    Product(
      id: '16',
      name: 'Jus Alpukat',
      price: 12000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=400',
      paymentMethods: ['Cash', 'E-Wallet'],
    ),
    Product(
      id: '17',
      name: 'Teh Hangat',
      price: 4000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400',
      paymentMethods: ['Cash'],
    ),
    Product(
      id: '18',
      name: 'Kopi Susu',
      price: 10000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '19',
      name: 'Soda',
      price: 6000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1581006852262-e4307cf6283a?w=400',
      paymentMethods: ['Cash', 'E-Wallet'],
    ),
    Product(
      id: '20',
      name: 'Es Jeruk',
      price: 8000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '22',
      name: 'Jus Strawberry',
      price: 13000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '23',
      name: 'Wedang Jahe',
      price: 7000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400',
      paymentMethods: ['Cash'],
    ),
    Product(
      id: '24',
      name: 'Es Cendol',
      price: 9000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      paymentMethods: ['Cash', 'QRIS'],
    ),
    Product(
      id: '25',
      name: 'Bandrek',
      price: 8000,
      category: 'Minuman',
      imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=400',
      paymentMethods: ['Cash', 'E-Wallet'],
    ),
  ];
}
