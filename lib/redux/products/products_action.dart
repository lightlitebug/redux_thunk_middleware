import '../../models/product.dart';

class GetProductsAction {
  @override
  String toString() => 'GetProductsAction()';
}

class GetProductsSucceededAction {
  final List<Product> products;
  GetProductsSucceededAction({
    required this.products,
  });

  @override
  String toString() => 'GetProductsSucceededAction(products: $products)';
}

class GetProductsFailedAction {
  final String error;
  GetProductsFailedAction({
    required this.error,
  });

  @override
  String toString() => 'GetProductsFailedAction(error: $error)';
}
