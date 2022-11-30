import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../app_state.dart';

class GetProductAction {
  GetProductAction();
  @override
  String toString() => 'GetProductAction()';
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

ThunkAction<AppState> getProductAndDispatch(int id) {
  return (Store<AppState> store) async {
    store.dispatch(GetProductAction());

    try {
      final Product product = await ProductRepository.instance.getProduct(id);
      store.dispatch(GetProductSucceededAction(product: product));
    } catch (e) {
      store.dispatch(GetProductFailedAction(error: e.toString()));
    }
  };
}
