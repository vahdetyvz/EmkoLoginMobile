import 'dart:developer';

import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/extansions/color_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthTextInputView extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? placeHolder;
  final bool? isHidden;
  final VoidCallback? hiddenToggle;
  final Color? textColor;
  final bool? isPhoneCode;
  final Function(String)? onPhoneCodeChange;
  final bool? isFailed;
  final bool isEnabled;
  const AuthTextInputView({
    super.key,
    required this.controller,
    required this.hint,
    this.isHidden,
    this.hiddenToggle,
    this.placeHolder,
    this.textColor,
    this.isPhoneCode,
    this.onPhoneCodeChange,
    this.isFailed,
    this.isEnabled = true,
  });

  @override
  State<AuthTextInputView> createState() => _AuthTextInputViewState();
}

class _AuthTextInputViewState extends State<AuthTextInputView>
    with BaseSingleton {
  bool showText = true;
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        showText = widget.controller.text.trim() == "";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          enabled: widget.isEnabled,
          controller: widget.controller,
          obscureText: widget.isHidden == true,
          placeholder: widget.placeHolder,
          style: TextStyle(
            color: widget.textColor ?? Colors.black,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: widget.isFailed == true
                    ? Colors.red
                    : widget.textColor ??
                        HexColor.fromHex(
                          "#7B7E9D",
                        ),
              ),
            ),
          ),
          suffix: widget.isHidden != null
              ? IconButton(
                  onPressed: widget.hiddenToggle,
                  icon: Icon(widget.isHidden == true
                      ? Icons.visibility
                      : Icons.visibility_off))
              : null,
          prefix: Row(
            children: [
              if (showText)
                SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Text(
                    widget.hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.textColor != null
                          ? widget.textColor?.withOpacity(.6)
                          : colors.greyNew,
                    ),
                  ),
                ),
              if (widget.isPhoneCode == true)
                CountryCodePicker(
                  onChanged: (val) {
                    log(val.code.toString());
                    if (widget.onPhoneCodeChange != null) {
                      widget.onPhoneCodeChange!(val.dialCode ?? "");
                    }
                  },
                  initialSelection: AppLocalizations.of(context)?.phoneCode,
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  textStyle: TextStyle(
                    color: widget.textColor ?? Colors.black,
                  ),
                ),
            ],
          ),
        ),
        if (widget.isFailed == true)
          Text(
            AppLocalizations.of(context)?.valueError ?? "",
            style: const TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
