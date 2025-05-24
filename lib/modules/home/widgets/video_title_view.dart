import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../model/video_title_model.dart';

class VideoTitleView extends StatelessWidget {
  final VideoTitleModel model;
  final Duration currentPostion;
  final Function(Duration) seekTo;
  const VideoTitleView({
    super.key,
    required this.model,
    required this.currentPostion,
    required this.seekTo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seekTo(model.start);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .15,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: currentPostion.inSeconds >= model.start.inSeconds &&
                  currentPostion.inSeconds < model.end.inSeconds
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor.fromHex("#504CA0"),
                    HexColor.fromHex("#3A90CD"),
                  ],
                )
              : null,
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                children: [
                  CustomText(
                    text: model.header,
                    style: TextStyle(
                      fontSize: 20,
                      color: currentPostion.inSeconds < model.start.inSeconds
                          ? HexColor.fromHex("#0081BD")
                          : currentPostion.inSeconds >= model.end.inSeconds
                              ? HexColor.fromHex("#666666")
                              : Colors.white,
                    ),
                  ),
                  CustomText(
                    text: model.text,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 10,
                      color: currentPostion.inSeconds < model.start.inSeconds
                          ? HexColor.fromHex("#0081BD")
                          : currentPostion.inSeconds >= model.end.inSeconds
                              ? HexColor.fromHex("#666666")
                              : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomText(
              text: model.getStart(),
              style: TextStyle(
                fontSize: 20,
                color: currentPostion.inSeconds < model.start.inSeconds
                    ? HexColor.fromHex("#0081BD")
                    : currentPostion.inSeconds >= model.end.inSeconds
                        ? HexColor.fromHex("#666666")
                        : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
