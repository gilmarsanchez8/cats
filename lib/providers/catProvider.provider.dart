import 'package:demo_cats/model/cat.model.dart';
import 'package:demo_cats/services/serviceCats.service.dart';
import 'package:flutter/cupertino.dart';

class CatProvider extends ChangeNotifier {
  final CatsService catsService = CatsService();
  List<Cat>? _cats;
  int _currentCats = 0;

  List<Cat>? get cats => _cats;
  set cats(List<Cat>? cats) {
    if (cats == null) {
      _cats = null;
    } else {
      _cats = [];
      _cats?.addAll(cats);
    }

    _currentCats = 0;
    notifyListeners();
  }

  getCats() async {
    final respCats = await catsService.getInformationCats();
    cats = respCats;
  }

  int get currentCats => _currentCats;
  set currentCats(int value) {
    _currentCats = value;
    notifyListeners();
  }
}