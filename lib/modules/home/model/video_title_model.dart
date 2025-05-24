class VideoTitleModel {
  late String header, text;
  late Duration start, end;

  VideoTitleModel(this.header, this.text, this.start, this.end);

  String getStart() {
    var min = start.inSeconds ~/ 60;
    var second = start.inSeconds % 60;
    return "${min >= 10 ? min : "0$min"}:${second >= 10 ? second : "0$second"}";
  }
}
