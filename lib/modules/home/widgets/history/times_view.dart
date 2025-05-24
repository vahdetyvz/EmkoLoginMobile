import 'package:boardlock/modules/home/model/history_model.dart';
import 'package:flutter/material.dart';

import 'time_list_item_view.dart';

class TimesView extends StatefulWidget {
  final int index;
  final HistoryListModel? model;

  const TimesView({
    super.key,
    required this.index,
    required this.model,
  });

  @override
  State<TimesView> createState() => _TimesViewState();
}

class _TimesViewState extends State<TimesView> {
  int oldIndex = 0;
  List<HistoryEventModel> times = [];
  findHours() {
    oldIndex = widget.index;

    DateTime date =
        DateTime.now().subtract(Duration(days: (19 - widget.index).abs()));
    DateTime firsDate = DateTime(date.year, date.month, date.day);
    var filteredRecord = widget.model?.history.where(
      (element) => element.date == firsDate,
    );
    if (filteredRecord != null) {
      setState(() {
        times = filteredRecord.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (oldIndex != widget.index) {
      findHours();
    }
    return Expanded(
      child: ListView.builder(
        itemCount: times.length,
        itemBuilder: (context, index) {
          return TimeListItemView(time: times[index]);
        },
      ),
    );
  }
}
