import '../../models/product.dart';

class GetProductAction {
  final int id;
  GetProductAction({
    required this.id,
  });
  @override
  String toString() => 'GetProductAction(id: $id)';
}

class GetProductSucceededAction {
  final Product product;
  GetProductSucceededAction({
    required this.product,
  });

  @override
  String toString() => 'GetProductSucceededAction(product: $product)';
}

class GetProductFailedAction {
  final String error;
  GetProductFailedAction({
    required this.error,
  });

  @override
  String toString() => 'GetProductFailedAction(error: $error)';
}
