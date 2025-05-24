import 'dart:convert';

import 'package:flutter/material.dart';

class HistoryEventModel {
  late DateTime date;
  late List<dynamic> times;
  late String macAdrress;

  HistoryEventModel(
    this.date,
    this.times,
    this.macAdrress,
  );

  String getStart(int index) {
    return "${times[index].hour >= 10 ? times[index].hour : "0${times[index].hour}"}:${times[index].minute >= 10 ? times[index].minute : "0${times[index].minute}"}";
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toString(),
      "times": times.map((e) => '"${e.hour}:${e.minute}"').toList().toString(),
      "macAdress": macAdrress,
    };
  }

  factory HistoryEventModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      HistoryEventModel(
        DateTime.parse(
          json["date"] ?? DateTime.now(),
        ),
        jsonDecode(json["times"] ?? "[]")
            .map((k) => TimeOfDay(
                hour: int.tryParse(k.split(":")[0]) ?? 0,
                minute: int.tryParse(k.split(":")[1]) ?? 0))
            .toList(),
        json["macAdress"] ?? "",
      );
}

class HistoryListModel {
  late List<HistoryEventModel> history;
  HistoryListModel(this.history);

  factory HistoryListModel.fromJson(
    List<dynamic> json,
  ) =>
      HistoryListModel(
        json.map((e) => HistoryEventModel.fromJson(e)).toList(),
      );
  List<Map<String, dynamic>> toJson() {
    return history.map((e) => e.toJson()).toList();
  }
}
