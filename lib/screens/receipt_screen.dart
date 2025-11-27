import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cart.dart';
import 'product_list_screen.dart';

class ReceiptScreen extends StatefulWidget {
  final Cart cart;
  final String paymentMethod;

  const ReceiptScreen({
    super.key,
    required this.cart,
    required this.paymentMethod,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {

  String _generateReceiptMessage() {
    final StringBuffer message = StringBuffer();
    final now = DateTime.now();

    message.writeln('🧾 *STRUK PEMBAYARAN*');
    message.writeln('🏪 Kasir Pintar');
    message.writeln('');
    message.writeln('📅 ${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}');
    message.writeln('');
    message.writeln('📋 *Detail Pembelian:*');

    for (final item in widget.cart.items) {
      message.writeln('• ${item.product.name}');
      message.writeln('  ${item.quantity} x Rp ${item.product.price.toStringAsFixed(0)} = Rp ${item.total.toStringAsFixed(0)}');
    }

    message.writeln('');
    message.writeln('💰 *Total: Rp ${widget.cart.total.toStringAsFixed(0)}*');
    message.writeln('💳 *Metode Pembayaran: ${widget.paymentMethod}*');
    message.writeln('');
    message.writeln('✅ *Status: LUNAS*');
    message.writeln('');
    message.writeln('Terima kasih atas kunjungan Anda! 🙏');
    message.writeln('🏪 Kasir Pintar');

    return message.toString();
  }

  Future<void> _shareViaWhatsApp() async {
    final String message = _generateReceiptMessage();
    final String whatsappUrl = 'whatsapp://send?text=${Uri.encodeComponent(message)}';

    try {
      final Uri uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: try web WhatsApp
        final String webWhatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
        final Uri webUri = Uri.parse(webWhatsappUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('WhatsApp tidak terinstall atau tidak dapat diakses'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membagikan ke WhatsApp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareReceipt() async {
    final String message = _generateReceiptMessage();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bagikan Struk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
              title: const Text('WhatsApp'),
              subtitle: const Text('Kirim via WhatsApp'),
              onTap: () async {
                Navigator.of(context).pop();
                await _shareViaWhatsApp();
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('SMS'),
              subtitle: const Text('Kirim via pesan teks'),
              onTap: () async {
                Navigator.of(context).pop();
                final smsUrl = 'sms:?body=${Uri.encodeComponent(message)}';
                final Uri uri = Uri.parse(smsUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('Kirim via email'),
              onTap: () async {
                Navigator.of(context).pop();
                final emailUrl = 'mailto:?subject=Struk Pembayaran&body=${Uri.encodeComponent(message)}';
                final Uri uri = Uri.parse(emailUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Struk Pembayaran'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'KASIR PINTAR',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Detail Pembelian:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.cart.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart.items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('${item.quantity}x ${item.product.name}'),
                            ),
                            Text('Rp ${item.total.toStringAsFixed(0)}'),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${widget.cart.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Metode Pembayaran: ${widget.paymentMethod}'),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Terima Kasih Atas Kunjungannya!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Primary WhatsApp button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _shareViaWhatsApp,
                    icon: const Icon(Icons.chat),
                    label: const Text('Kirim Struk WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF25D366), // WhatsApp green
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Secondary sharing options
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _shareReceipt,
                    icon: const Icon(Icons.share),
                    label: const Text('Opsi Bagikan Lainnya'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.cart.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const ProductListScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Transaksi Baru'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}