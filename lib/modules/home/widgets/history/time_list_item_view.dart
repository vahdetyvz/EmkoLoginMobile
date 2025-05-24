import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../model/history_model.dart';

class TimeListItemView extends StatelessWidget  with BaseSingleton{
  final HistoryEventModel time;
  const TimeListItemView({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...time.times]
          .map(
            (e) => Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: colors.blue,
                    ),
                    child: Image.asset(
                      "only_logo".toPng,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text:
                          "${((e as TimeOfDay).hour) >= 10 ? e.hour : "0${e.hour}"}:${(e.minute) >= 10 ? e.minute : "0${e.minute}"}",
                      align: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                        color: HexColor.fromHex(
                          "#808080",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: time.macAdrress,
                      align: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                        color: HexColor.fromHex(
                          "#808080",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
