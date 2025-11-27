import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'payment_screen.dart';

class PaymentLinkScreen extends StatelessWidget {
  final String paymentId;

  const PaymentLinkScreen({
    super.key,
    required this.paymentId,
  });

  // Mock function to decode payment link and recreate cart
  // In a real app, this would fetch data from a server
  Cart _decodePaymentLink(String paymentId) {
    // For demo purposes, create a sample cart
    // In reality, you'd decode the paymentId and fetch order details from server
    final Cart cart = Cart();

    // Add some sample items for demonstration
    cart.addItem(Product(
      id: '1',
      name: 'Nasi Goreng',
      price: 15000,
      category: 'Makanan',
      paymentMethods: ['Cash', 'QRIS', 'E-Wallet'],
    ));

    cart.addItem(Product(
      id: '13',
      name: 'Es Teh',
      price: 5000,
      category: 'Minuman',
      paymentMethods: ['Cash'],
    ));

    return cart;
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = _decodePaymentLink(paymentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Pembayaran'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              // Share this payment link
              final linkMessage = '💳 *LINK PEMBAYARAN*\n\nSaya telah membagikan link pembayaran untuk Anda. Silakan klik link berikut untuk menyelesaikan pembayaran:\n\nhttps://kasirpintar.app/pay/$paymentId\n\n⏰ Link berlaku selama 24 jam';

              final whatsappUrl = 'whatsapp://send?text=${Uri.encodeComponent(linkMessage)}';

              try {
                final Uri uri = Uri.parse(whatsappUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  final webWhatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(linkMessage)}';
                  final Uri webUri = Uri.parse(webWhatsappUrl);
                  if (await canLaunchUrl(webUri)) {
                    await launchUrl(webUri, mode: LaunchMode.externalApplication);
                  }
                }
              } catch (e) {
                // Handle error silently
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.payment,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'PEMBAYARAN VIA LINK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: $paymentId',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '📱 Link ini diakses dari perangkat mobile',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Detail Pesanan:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${item.quantity} x Rp ${item.product.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Rp ${item.total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Pembayaran:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp ${cart.total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Link ini dibagikan oleh pelanggan untuk pembayaran. Silakan lanjutkan ke pembayaran.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Mobile payment reminder
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.smartphone, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pastikan aplikasi e-wallet (GoPay, OVO, Dana, dll) sudah terinstall di perangkat Anda',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(cart: cart),
                    ),
                  );
                },
                icon: const Icon(Icons.payment),
                label: const Text(
                  'Lanjutkan ke Pembayaran',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}