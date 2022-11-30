import 'package:redux/redux.dart';

import 'products_action.dart';
import 'products_state.dart';

ProductsState getProductsReducer(
  ProductsState state,
  GetProductsAction action,
) {
  return state.copyWith(productsStatus: ProductsStatus.loading);
}

ProductsState getProductsSucceededReducer(
  ProductsState state,
  GetProductsSucceededAction action,
) {
  return state.copyWith(
    productsStatus: ProductsStatus.success,
    products: action.products,
  );
}

ProductsState getProductsFailedReducer(
  ProductsState state,
  GetProductsFailedAction action,
) {
  return state.copyWith(
    productsStatus: ProductsStatus.failure,
    error: action.error,
  );
}

Reducer<ProductsState> productsReducer = combineReducers<ProductsState>([
  TypedReducer<ProductsState, GetProductsAction>(getProductsReducer),
  TypedReducer<ProductsState, GetProductsSucceededAction>(
    getProductsSucceededReducer,
  ),
  TypedReducer<ProductsState, GetProductsFailedAction>(
    getProductsFailedReducer,
  ),
]);
