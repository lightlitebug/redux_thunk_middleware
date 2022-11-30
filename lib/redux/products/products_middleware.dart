import 'package:redux/redux.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../app_state.dart';
import 'products_action.dart';

void productsMiddleware(
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
  }

  next(action);
}
