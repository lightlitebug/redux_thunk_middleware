import 'package:redux/redux.dart';
// import 'product_info_middleware.dart';

import 'app_state.dart';
import 'product/product_middleware.dart';
import 'products/products_middleware.dart';

List<Middleware<AppState>> appMiddleware() {
  // return [productInfoMiddleware];
  return [productsMiddleware, productMiddleware];
}
