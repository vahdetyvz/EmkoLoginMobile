import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/noti_model.dart';
import 'package:flutter/material.dart';

class NotificationDetailPage extends StatelessWidget with BaseSingleton {
  final NotiModel? model;
  const NotificationDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SafeArea(
              top: false,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *
                        (MediaQuery.of(context).size.height > 700 ? .22 : .2) +
                    MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  color: colors.blue,
                ),
              ),
            ),
            Column(
              children: [
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                      ),
                      Image.asset(
                        "only_logo".toPng,
                        height: 80,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(
                        text: "Emko Smart Lock Pro",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomText(
                          text: model?.name ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomText(
                          text: model?.detail ?? "",
                          maxLines: 120,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
