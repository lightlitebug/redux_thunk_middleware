import 'package:redux/redux.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';
import 'app_state.dart';
import 'product/product_action.dart';
import 'products/products_action.dart';

void productInfoMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next,
) {
  if (action is GetProductsAction) {
    ProductRepository.instance.getProducts().then((List<Product> products) {
      store.dispatch(GetProductsSucceededAction(products: products));
    }).catchError((error) {
      store.dispatch(GetProductsFailedAction(error: error.toString()));
    });
  } else if (action is GetProductAction) {
    ProductRepository.instance.getProduct(action.id).then((Product product) {
      store.dispatch(GetProductSucceededAction(product: product));
    }).catchError((error) {
      store.dispatch(GetProductFailedAction(error: error.toString()));
    });
  }

  next(action);
}
