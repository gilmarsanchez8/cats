import 'package:demo_cats/pages/catDetail.page.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes{
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final navigator = navigatorKey.currentState;
  static final routes = {
    "/catDetails": (_) => CatDetailPage(),
  };
}