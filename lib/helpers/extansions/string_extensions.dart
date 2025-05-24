import '../constants/app_constants.dart';

extension ImagePath on String {
  String get toSvg => "assets/svg/$this.svg";
  String get toPng => "assets/png/$this.png";

  String get toNetwork => "${AppConstants.instance.baseUrlForImage}$this";
  String get toApi => "${AppConstants.instance.baseUrl}/$this";
}
