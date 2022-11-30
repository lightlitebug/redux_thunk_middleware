import 'package:redux/redux.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import '../app_state.dart';
import 'product_action.dart';

void productMiddleware(
  Store<AppState> store,
  action,
  NextDispatcher next,
) {
  if (action is GetProductAction) {
    ProductRepository.instance.getProduct(action.id).then((Product product) {
      store.dispatch(GetProductSucceededAction(product: product));
    }).catchError((error) {
      store.dispatch(GetProductFailedAction(error: error.toString()));
    });
  }

  next(action);
}
