import 'package:demo_cats/model/cat.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatsService {
  // Singleton
  static final CatsService _instance = CatsService._internal();

  factory CatsService() {
    return _instance;
  }

  final _apikey = 'bda53789-d59e-46cd-9bc4-2936630fde39';
  final _url = 'api.thecatapi.com';
  int cont = 0;

  CatsService._internal();

  Future<List<Cat>> _findInformation(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cats = Cats.fromJsonList(decodedData);
    for (var cat in cats.items) {
      cont++;
      if (cont <= 5) {
        cat.urlImage = await getImageCat(cat.referenceImageId.toString());
      } else {
        cat.urlImage = "";
      }
    }

    return cats.items;
  }

  Future<List<Cat>> getInformationCats() async {
    final url = Uri.https(_url, 'v1/breeds', {'api_key': _apikey});
    return await _findInformation(url);
  }

  Future<String> getImageCat(String reference) async {
    final url = Uri.https(_url, 'v1/images/$reference');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    return decodedData["url"];
  }
}
