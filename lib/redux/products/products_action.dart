import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../app_state.dart';

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

ThunkAction<AppState> getProductsAndDispatch() {
  return (Store<AppState> store) async {
    store.dispatch(GetProductsAction());

    try {
      final List<Product> products =
          await ProductRepository.instance.getProducts();
      store.dispatch(GetProductsSucceededAction(products: products));
    } catch (e) {
      store.dispatch(GetProductsFailedAction(error: e.toString()));
    }
  };
}
