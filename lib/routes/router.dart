import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:noid_app/homepage.dart';
import 'package:noid_app/cbd_education.dart';
import 'package:noid_app/shoppage.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/', page: Homepage, children: [
      AutoRoute(
          path: 'shop',
          name: 'ShopRouter',
          page: EmptyRouterPage,
          children: [AutoRoute(path: '', page: ShopPage)]),
      AutoRoute(
          path: 'cbd_education',
          name: 'education_router',
          page: EmptyRouterPage,
          children: [AutoRoute(path: '', page: CBDEducation)]),
    ]),
  ],
)
class $AppRouter {}

//SinglePostPageRoute

