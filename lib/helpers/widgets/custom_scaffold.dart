import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  final GoRouterState? navigatorState;
  const CustomScaffold({
    super.key,
    required this.child,
    required this.navigatorState,
  });

  @override
  State<CustomScaffold> createState() => CustomScaffoldState();
}

class CustomScaffoldState extends State<CustomScaffold> with BaseSingleton {
  final List<String> locations = [
    RouteEnums.history.routeName,
    RouteEnums.profile.routeName,
    RouteEnums.qr.routeName,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        shape: const CircleBorder(),
        backgroundColor: HexColor.fromHex(
          "#0081BD",
        ),
        onPressed: () {
          context.push(RouteEnums.qr.routeName);
        },
        child: SvgPicture.asset(
          "qr".toSvg,
          width: MediaQuery.of(context).size.width * .125,
        ),
      ),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: HexColor.fromHex(
                "#7C8692",
              ),
              blurRadius: 10,
            ),
          ],
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go(locations[0]);
                    },
                    child: Icon(
                      Icons.history,
                      size: 40,
                      color: HexColor.fromHex(
                        "#0081BD",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go(locations[1]);
                    },
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: HexColor.fromHex(
                        "#0081BD",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            top: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: SafeArea(
              child: IconButton(
                  onPressed: () {
                    context.push(RouteEnums.notifications.routeName);
                  },
                  icon: SvgPicture.asset(
                    "noti".toSvg,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 30,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
