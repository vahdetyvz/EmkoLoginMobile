import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/noti_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationListItemView extends StatefulWidget {
  final NotiModel? model;
  final VoidCallback onInit;
  final bool isRead;
  const NotificationListItemView(
      {super.key,
      required this.model,
      required this.isRead,
      required this.onInit});

  @override
  State<NotificationListItemView> createState() =>
      _NotificationListItemViewState();
}

class _NotificationListItemViewState extends State<NotificationListItemView> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RouteEnums.notificationDetail.routeName,
            extra: widget.model);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HexColor.fromHex("#B2D4EA"),
          border: Border.all(
            color: HexColor.fromHex("#0775BA"),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isRead)
              SvgPicture.asset(
                "noti".toSvg,
                width: 20,
              ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 75,
                  child: CustomText(
                    text: widget.model?.name ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 75,
                  child: CustomText(
                    text: widget.model?.detail ?? "",
                    maxLines: 10,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
