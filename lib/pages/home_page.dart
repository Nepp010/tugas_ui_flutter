import 'package:flutter/material.dart';

// ==========================================
// 1. MODEL DATA PRODUK
// ==========================================
class Product {
  final String name;
  final String price;
  final String rating;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// ==========================================
// 2. CUSTOM WIDGET: KARTU PRODUK (PRODUCT CARD)
// ==========================================
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto Produk (Bagian Atas)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              product.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              // Fallback jika gambar gagal dimuat internet
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          
          // Detail Produk (Bagian Bawah)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      product.rating,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN UTAMA BERANDA (HOME PAGE)
// ==========================================
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Mock Data: 6 produk sesuai ketentuan tugas
  final List<Product> dummyProducts = [
    Product(
      name: 'Kaos Gaul Kekinian',
      price: 'Rp 35.000',
      rating: '4.8',
      imageUrl: 'assets/ryan1.jpeg',
    ),
    Product(
      name: 'Balon Ulang Tahun Bebas Request Warna',
      price: 'Rp 150.000',
      rating: '4.9',
      imageUrl: 'assets/balon2.jpeg',
    ),
    Product(
      name: 'Obeng Khusus Tangan Kiri (Kidal)',
      price: 'Rp 200.000',
      rating: '4.7',
      imageUrl: 'assets/obengkidal.jpeg',
    ),
    Product(
      name: 'Obeng Khusus Tangan Kanan (Kadal)',
      price: 'Rp 25.000',
      rating: '4.5',
      imageUrl: 'assets/obengkadal.jpeg',
    ),
    Product(
      name: 'TOPI SKENA FUAD99',
      price: 'Rp 250.000',
      rating: '4.9',
      imageUrl: 'assets/topi.jpeg',
    ),
    Product(
      name: 'Hijab Murah 5pcs',
      price: 'Rp 65.000',
      rating: '4.6',
      imageUrl: 'assets/ryan2.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      // --- APP BAR DENGAN SEARCH BOX ---
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: Container(
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Cari di Shopee...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      
      // --- BODY UTAMA (SCROLLABLE) ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Kategori Atas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.deepOrange,
              child: const Text(
                'Gratis Ongkir Rp0 | Shopee Live',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            
            // Grid Produk Utama
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), 
                shrinkWrap: true, 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 0.7, 
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: dummyProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: dummyProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}