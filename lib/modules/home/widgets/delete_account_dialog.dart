import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/network/auth_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/extansions/color_ext.dart';
import '../../../helpers/routes/enums/route_enums.dart';
import '../../../helpers/widgets/custom_button.dart';

class DeleteAccountDialog extends StatefulWidget {
  final int id;
  const DeleteAccountDialog({super.key, required this.id});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
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
              height: MediaQuery.of(context).size.height * .2,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor.fromHex(
                  "#3D5EA8",
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: AppLocalizations.of(context)?.sureToDelete ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: CustomButton(
                          text: AppLocalizations.of(context)?.cancel ?? "",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: CustomButton(
                          text: AppLocalizations.of(context)?.delete ?? "",
                          onTap: () async {
                            AuthNetwork().deleteAccount(widget.id);

                            Navigator.pop(context);
                            context.go(RouteEnums.auth.routeName);
                          },
                        ),
                      )
                    ],
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
