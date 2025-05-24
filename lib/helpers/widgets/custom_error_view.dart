import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_text.dart';

class CustomErrorView extends StatelessWidget {
  final bool? isBlack;
  final String? text;
  const CustomErrorView({
    super.key,
    this.isBlack,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text ?? AppLocalizations.of(context)?.error,
      style: TextStyle(
        color: isBlack == true ? Colors.black : Colors.white,
        fontSize: 20,
      ),
    );
  }
}
