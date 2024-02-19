import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:electronic_shop/constants/strings.dart';

class StoreShoppingWebServices{
  late Dio dio;
  StoreShoppingWebServices(){
    BaseOptions options=BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),// 60 seconds,

    );
    dio=Dio(options);
  }
  Future<List<dynamic>> getAllItemStore()async {
    try {
      Response response = await dio.get('https://fakestoreapi.com/products');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}