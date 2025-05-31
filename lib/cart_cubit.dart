import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<Map<String, dynamic>>> {
  CartCubit() : super([]);

  void addToCart(Map<String, dynamic> item) {
    final updatedCart = [...state, item];
    emit(updatedCart);
  }

  void removeFromCart(int index) {
    final updatedCart = [...state]..removeAt(index);
    emit(updatedCart);
  }

  void clearCart() {
    emit([]);
  }
}
