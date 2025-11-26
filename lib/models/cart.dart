import 'cart_item.dart';
import 'product.dart';

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(Product product) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      _items.add(CartItem(product: product));
    } else {
      existingItem.quantity++;
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    final item = _items.firstWhere((item) => item.product.id == productId);
    item.quantity = quantity;
  }

  double get total => _items.fold(0, (sum, item) => sum + item.total);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void clear() {
    _items.clear();
  }
}