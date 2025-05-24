import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/noti_model.dart';
import 'package:boardlock/modules/home/widgets/noti/notifications_list_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsView extends StatefulWidget {
  final NotiListModel? model;
  const NotificationsView({super.key, this.model});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  NotiModel? model;
  List<String> readIds = [];
  @override
  void initState() {
    getReadIds();
    super.initState();
  }

  getReadIds() async {
    var prefences = await SharedPreferences.getInstance();
    var readIds = prefences.getStringList("readIds") ?? [];
    setState(() {
      this.readIds = readIds;
    });
  }

  setRead(String id) async {
    var prefences = await SharedPreferences.getInstance();
    var readIds = prefences.getStringList("readIds") ?? [];
    readIds.add(id);
    await prefences.setStringList("readIds", readIds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: widget.model?.matches.isEmpty ?? true
              ? Center(
                  child: CustomText(
                    text: AppLocalizations.of(context)?.noNotifications,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: widget.model?.matches.length ?? 0,
                  itemBuilder: (context, index) => NotificationListItemView(
                    model: widget.model?.matches[index],
                    isRead: !readIds
                        .contains(widget.model?.matches[index].id.toString()),
                    onInit: () {
                      setRead(
                          (widget.model?.matches[index].id ?? 0).toString());
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
