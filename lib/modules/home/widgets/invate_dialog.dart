import 'dart:developer';

import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/network/auth_network.dart';
import 'package:boardlock/modules/home/widgets/dialogs/sucess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../helpers/extansions/color_ext.dart';
import '../../../helpers/widgets/custom_button.dart';
import '../../auth/widgets/auth_text_input_view.dart';

class InvateDialog extends StatefulWidget {
  const InvateDialog({super.key});

  @override
  State<InvateDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<InvateDialog> with BaseSingleton {
  TextEditingController email = TextEditingController();

  bool loading = false,
      isEmailFailed = false,
      isSchoolCodeFailed = false,
      isPasswordFailed = false;
  int failed = -1;
  @override
  void initState() {
    super.initState();
    email.addListener(() {
      setState(() {
        isEmailFailed = !RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email.text.trim());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#3D5EA8").withOpacity(.6),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .3,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex(
                  "#3D5EA8",
                ),
              ),
              child: loading
                  ? functions.platformIndicator(true)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)?.invate ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        AuthTextInputView(
                          hint: AppLocalizations.of(context)?.email ?? "",
                          controller: email,
                          isFailed: (failed == 5 && email.text.trim() == "") ||
                              isEmailFailed,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: CustomButton(
                            text: AppLocalizations.of(context)?.invate ?? "",
                            onTap: () async {
                              if (!isEmailFailed && email.text.trim() != "") {
                                setState(() {
                                  loading = true;
                                });
                                final response = await AuthNetwork().sendInvate(
                                  email.text.trim(),
                                );
                                log(response.toString(), name: "response");
                                setState(() {
                                  loading = false;
                                });
                                if (response == true) {
                                  Navigator.pop(context);

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const SuccessDialog();
                                      });
                                } else {
                                  setState(() {
                                    failed = 5;
                                  });
                                }
                              } else {
                                setState(() {
                                  failed = 5;
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
