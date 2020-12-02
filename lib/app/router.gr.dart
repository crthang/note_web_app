// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/login/login_view.dart';
import '../ui/views/note/note_view.dart';

class Routes {
  static const String loginViewRoute = '/';
  static const String noteViewRoute = '/note-view';
  static const all = <String>{
    loginViewRoute,
    noteViewRoute,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginViewRoute, page: LoginView),
    RouteDef(Routes.noteViewRoute, page: NoteView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    NoteView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NoteView(),
        settings: data,
      );
    },
  };
}
