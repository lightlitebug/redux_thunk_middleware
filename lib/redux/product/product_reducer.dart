import 'package:redux/redux.dart';

import 'product_action.dart';
import 'product_state.dart';

ProductState getProductReducer(
  ProductState state,
  GetProductAction action,
) {
  return state.copyWith(productStatus: ProductStatus.loading);
}

ProductState getProductSucceededReducer(
  ProductState state,
  GetProductSucceededAction action,
) {
  return state.copyWith(
    productStatus: ProductStatus.success,
    product: action.product,
  );
}

ProductState getProductFailedReducer(
  ProductState state,
  GetProductFailedAction action,
) {
  return state.copyWith(
    productStatus: ProductStatus.failure,
    error: action.error,
  );
}

Reducer<ProductState> productReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, GetProductAction>(getProductReducer),
  TypedReducer<ProductState, GetProductSucceededAction>(
    getProductSucceededReducer,
  ),
  TypedReducer<ProductState, GetProductFailedAction>(
    getProductFailedReducer,
  ),
]);
