import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/product.dart';
import '../redux/app_state.dart';
import '../redux/products/products_action.dart';
import '../redux/products/products_state.dart';
import 'product_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: StoreConnector<AppState, _ViewModel>(
          distinct: true,
          onInit: (Store<AppState> store) {
            store.dispatch(GetProductsAction());
          },
          onWillChange: (_ViewModel? prev, _ViewModel current) {
            if (current.status == ProductsStatus.failure) {
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
            if (vm.status == ProductsStatus.initial) {
              return Container();
            } else if (vm.status == ProductsStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: vm.products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = vm.products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ProductPage(productId: product.id);
                      }),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text("\$${product.price}"),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final List<Product> products;
  final ProductsStatus status;
  final String error;
  const _ViewModel({
    required this.products,
    required this.status,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      products: store.state.productsState.products,
      status: store.state.productsState.productsStatus,
      error: store.state.productsState.error,
    );
  }

  @override
  List<Object> get props => [products, status, error];
}
