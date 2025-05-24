import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/widgets/custom_button.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrDialog extends StatefulWidget {
  final Barcode scanData;
  const QrDialog({
    super.key,
    required this.scanData,
  });

  @override
  State<QrDialog> createState() => _QrDialogState();
}

class _QrDialogState extends State<QrDialog> {
  final keyPass = encrypt.Key.fromUtf8('apltechsemkolock');
  final iv = IV.fromLength(16);
  String text = "";
  @override
  void initState() {
    createNewQrCode();
    super.initState();
  }

  void createNewQrCode() async {
    final encrypter = Encrypter(AES(keyPass, mode: AESMode.ecb));
    var decripted = encrypter
        .decrypt(Encrypted.fromBase64(widget.scanData.code ?? ''), iv: iv);
    setState(() {
      text = decripted.contains("|||")
          ? decripted.split("|||")[0]
          : decripted.split('|')[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#3D5EA8").withOpacity(.6),
      body: Center(
        child: Stack(
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
                      text: "${AppLocalizations.of(context)?.pinCode} $text",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    CustomButton(
                        text: AppLocalizations.of(context)?.ok ?? "",
                        onTap: () {
                          context.pop(context);
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
