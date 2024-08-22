import 'package:dio/dio.dart';
import 'package:electronic_shop/constants/strings.dart';

class StoreShoppingWebServices {
  late Dio dio;

  StoreShoppingWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllItemStore() async {
    try {
      Response response = await dio.get('http://192.168.92.77/TechShop/public/api/product/2');

      if (response.data is Map<String, dynamic>) {
        return response.data['product'] ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  Future<void> storeOrder(String productId) async {
    await dio.post('http://192.168.92.77/TechShop/public/api/storeOrder',
        options: Options(headers: {
          'Authorization':
          'Bearer 4|Y9ufdrOvvnTdRVv8erYYZk73rsvJVmmlpYX1yQ3hca7aa2c5'
        }),
        data: {
          'address': "Aleppo Forkan",
          'product_id': productId,
          'quantity': 1
        });
  }
}
