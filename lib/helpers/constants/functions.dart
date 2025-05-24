import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../extansions/color_ext.dart';
import '../singleton/base_singelton.dart';

class BaseFunctions with BaseSingleton {
  static BaseFunctions? _instance;
  static BaseFunctions get instance {
    _instance ??= BaseFunctions._init();
    return _instance!;
  }

  final ValueNotifier<Locale?> _locale = ValueNotifier<Locale?>(null);

  BaseFunctions._init();
  ValueNotifier<Locale?> getNotifer() {
    return _locale;
  }

  Widget platformIndicator(bool? isWhite) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              color:
                  isWhite == true ? Colors.white : HexColor.fromHex("#395EBC"),
            )
          : CircularProgressIndicator(
              color:
                  isWhite == true ? Colors.white : HexColor.fromHex("#395EBC"),
            ),
    );
  }

  animatedRouting({
    required GoRouterState state,
    required Widget route,
  }) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: route,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );

  animatedRoutingFade({
    required GoRouterState state,
    required Widget route,
  }) =>
      MaterialPage<void>(
        key: state.pageKey,
        child: route,
      );

  selectImage(Function(String path) onImageChange, BuildContext context) {
    final picker = ImagePicker();

    getfromgalery() async {
      final pickedfile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedfile != null) {
        onImageChange(pickedfile.path);
      }
    }

    getfromcamera() async {
      final pickedfile = await picker.pickImage(
        source: ImageSource.camera,
      );
      log("burda ${pickedfile?.path}");
      if (pickedfile != null) {
        onImageChange(pickedfile.path);
      }
    }

    showCupertinoModalPopup(
        context: context,
        builder: (cxt) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: const Text(
                  "Kamera",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  getfromcamera();
                  Navigator.pop(cxt);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text(
                  "Galeri",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  getfromgalery();
                  Navigator.pop(cxt);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text(
                "İPTAL",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(cxt);
              },
            ),
          );
        });
  }
}
