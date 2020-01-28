import 'dart:convert';

import 'package:app_flutter_form/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider {

  final String _url = 'https://app-flutter-9696e.firebaseio.com';

  Future<bool> create(ProductoModel productoModel) async {
    final url = "$_url/productos.json";
    final resp = await http.post(url, body: productoModelToJson(productoModel));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> update(ProductoModel productoModel) async {
    final url = "$_url/productos/${productoModel.id}.json";
    final resp = await http.put(url, body: productoModelToJson(productoModel));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> getAll() async {
    final url = "$_url/productos.json";
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if(decodedData == null) return [];


    print(decodedData);

    decodedData.forEach((id, prod){
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);

    });

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = "$_url/productos/$id.json";
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}