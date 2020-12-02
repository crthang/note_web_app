import 'package:auto_route/auto_route_annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'package:note_web_app/ui/views/login/login_view.dart';
import 'package:note_web_app/ui/views/note/note_view.dart';

//TODO: Đang tạo auto_router

@CustomAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(
      page: LoginView,
      name: 'loginViewRoute',
      initial: true,
    ),
    MaterialRoute(
      page: NoteView,
      name: 'noteViewRoute',
    ),
  ],
  transitionsBuilder: TransitionsBuilders.zoomIn,
  durationInMilliseconds: 400,
)
class $Router {}
