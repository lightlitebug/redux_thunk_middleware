import 'package:equatable/equatable.dart';

import '../../models/product.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure,
}

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final Product product;
  final String error;
  const ProductState({
    required this.productStatus,
    required this.product,
    required this.error,
  });

  factory ProductState.initial() {
    return ProductState(
      productStatus: ProductStatus.initial,
      product: Product.initial(),
      error: '',
    );
  }

  @override
  List<Object?> get props => [productStatus, product, error];

  @override
  String toString() =>
      'ProductsState(productsStatus: $productStatus, products: $product, error: $error)';

  ProductState copyWith({
    ProductStatus? productStatus,
    Product? product,
    String? error,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }
}
