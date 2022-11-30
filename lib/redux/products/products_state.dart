import 'package:equatable/equatable.dart';

import '../../models/product.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  failure,
}

class ProductsState extends Equatable {
  final ProductsStatus productsStatus;
  final List<Product> products;
  final String error;
  const ProductsState({
    required this.productsStatus,
    required this.products,
    required this.error,
  });

  factory ProductsState.initial() {
    return const ProductsState(
      productsStatus: ProductsStatus.initial,
      products: [],
      error: '',
    );
  }

  @override
  List<Object> get props => [productsStatus, products, error];

  @override
  String toString() =>
      'ProductsState(productsStatus: $productsStatus, products: $products, error: $error)';

  ProductsState copyWith({
    ProductsStatus? productsStatus,
    List<Product>? products,
    String? error,
  }) {
    return ProductsState(
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}
