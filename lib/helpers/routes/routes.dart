import 'package:boardlock/helpers/widgets/custom_scaffold.dart';
import 'package:boardlock/modules/auth/pages/auth_login_page.dart';
import 'package:boardlock/modules/auth/pages/auth_page.dart';
import 'package:boardlock/modules/auth/pages/auth_register_page.dart';
import 'package:boardlock/modules/auth/widgets/agreement_dialog.dart';
import 'package:boardlock/modules/home/model/noti_model.dart';
import 'package:boardlock/modules/home/pages/about_page.dart';
import 'package:boardlock/modules/home/pages/edit_profile_page.dart';
import 'package:boardlock/modules/home/pages/history_page.dart';
import 'package:boardlock/modules/home/pages/notification_detial_page.dart';
import 'package:boardlock/modules/home/pages/notifications_page.dart';
import 'package:boardlock/modules/home/pages/profile_page.dart';
import 'package:boardlock/modules/home/pages/qr_page.dart';
import 'package:boardlock/modules/home/pages/teachers_page.dart';
import 'package:boardlock/modules/home/widgets/dialogs/school_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/functions.dart';
import 'enums/route_enums.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class Routes {
  static Routes? _instance;
  static Routes get instance {
    _instance ??= Routes._init();

    return _instance!;
  }

  Routes._init();

  GoRouter routes = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteEnums.auth.routeName,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: RouteEnums.auth.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const AuthPage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.schoolDetail.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: SchoolDetailPage(
              schoolId: state.extra as String?,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.login.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const AuthLoginPage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.register.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const AuthRegisterPage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.profileEdit.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const EditProfilePage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.qr.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const QRPage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.addTeacher.routeName,
        pageBuilder: (context, state) {
          String schoolId = state.extra as String;
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: AuthRegisterPage(
              schoolId: schoolId,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.agreementPage.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRoutingFade(
            state: state,
            route: const AgreementDialog(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) =>
            BaseFunctions.instance.animatedRouting(
          state: state,
          route: CustomScaffold(
            navigatorState: state,
            child: child,
          ),
        ),
        routes: [
          /*   GoRoute(
            path: RouteEnums.home.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const HomePage(),
              );
            },
          ),*/
          /*  GoRoute(
            path: RouteEnums.search.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const HomePage(),
              );
            },
          ),*/
          GoRoute(
            path: RouteEnums.history.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const HistoryPage(),
              );
            },
          ),
          GoRoute(
            path: RouteEnums.profile.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const ProfilePage(),
              );
            },
          ),
          GoRoute(
            path: RouteEnums.aboutPage.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const AboutPage(),
              );
            },
          ),
          GoRoute(
            path: RouteEnums.notifications.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const NotificationsPage(),
              );
            },
          ),
          GoRoute(
            path: RouteEnums.notificationDetail.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: NotificationDetailPage(
                  model: state.extra as NotiModel?,
                ),
              );
            },
          ),
          /* GoRoute(
            path: RouteEnums.faq.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const FAQPage(),
              );
            },
          ),*/
          GoRoute(
            path: RouteEnums.profileEdit.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const EditProfilePage(),
              );
            },
          ),
          GoRoute(
            path: RouteEnums.teachers.routeName,
            pageBuilder: (context, state) {
              return BaseFunctions.instance.animatedRoutingFade(
                state: state,
                route: const TeachersPage(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
