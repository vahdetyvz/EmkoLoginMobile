import 'dart:developer';
import 'dart:io';

import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_events.dart';
import 'package:boardlock/modules/home/model/history_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../helpers/singleton/base_singelton.dart';
import '../widgets/qr_dialog.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> with BaseSingleton {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late HomeBloc bloc;
  bool isRead = false;
  final keyPass = encrypt.Key.fromUtf8('apltechsemkolock');
  final iv = IV.fromLength(16);
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        if (!isRead) {
          isRead = true;
          var now = DateTime.now();
          final encrypter = Encrypter(AES(keyPass, mode: AESMode.ecb));
          var decripted = encrypter
              .decrypt(Encrypted.fromBase64(scanData.code ?? ''), iv: iv);
          log(decripted, name: 'code deneme');
          bloc.add(
            SaveModel(
              HistoryEventModel(
                DateTime(
                  now.year,
                  now.month,
                  now.day,
                ),
                [
                  TimeOfDay.fromDateTime(now),
                ],
                decripted.contains("|||'")
                    ? decripted.split('|||').last
                    : decripted.split('|')[1],
              ),
            ),
          );

          context.pop();
          showDialog(
              context: context,
              builder: (context) {
                return QrDialog(
                  scanData: scanData,
                );
              });
        }
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: _qrKey,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          borderColor: HexColor.fromHex(
            "#0081BD",
          ),
        ),
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
