import 'package:equatable/equatable.dart';

import 'product/product_state.dart';
import 'products/products_state.dart';

class AppState extends Equatable {
  final ProductsState productsState;
  final ProductState productState;
  const AppState({
    required this.productsState,
    required this.productState,
  });

  factory AppState.initial() {
    return AppState(
      productsState: ProductsState.initial(),
      productState: ProductState.initial(),
    );
  }

  @override
  List<Object> get props => [productsState, productState];

  @override
  String toString() =>
      'AppState(productsState: $productsState, productState: $productState)';

  AppState copyWith({
    ProductsState? productsState,
    ProductState? productState,
  }) {
    return AppState(
      productsState: productsState ?? this.productsState,
      productState: productState ?? this.productState,
    );
  }
}
