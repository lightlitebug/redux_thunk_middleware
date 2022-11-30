import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/product.dart';
import '../redux/app_state.dart';
import '../redux/product/product_action.dart';
import '../redux/product/product_state.dart';

class ProductPage extends StatelessWidget {
  final int productId;
  const ProductPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (Store<AppState> store) {
          store.dispatch(GetProductAction(id: productId));
        },
        onWillChange: (_ViewModel? prev, _ViewModel current) {
          if (current.status == ProductStatus.failure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('ERROR'),
                  content: Text(current.error),
                );
              },
            );
          }
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.status == ProductStatus.initial) {
            return Container();
          } else if (vm.status == ProductStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (vm.status == ProductStatus.failure) {
            return const Center(
              child: Text(
                'Product Not Found',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
            );
          }

          final product = vm.product;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10.0),
                  Text(product.description),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'rate: ${product.rating.rate}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'count: ${product.rating.count}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final Product product;
  final ProductStatus status;
  final String error;
  const _ViewModel({
    required this.product,
    required this.status,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      product: store.state.productState.product,
      status: store.state.productState.productStatus,
      error: store.state.productState.error,
    );
  }

  @override
  List<Object> get props => [product, status, error];
}
