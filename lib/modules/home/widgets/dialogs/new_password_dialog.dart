import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_events.dart';
import 'package:boardlock/modules/home/widgets/dialogs/sucess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/extansions/color_ext.dart';
import '../../../../helpers/widgets/custom_button.dart';
import '../../../auth/widgets/auth_text_input_view.dart';
import '../../bloc/home_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewPasswordDialog extends StatefulWidget {
  final int id;
  const NewPasswordDialog({super.key, required this.id});

  @override
  State<NewPasswordDialog> createState() => _NewPasswordDialogState();
}

class _NewPasswordDialogState extends State<NewPasswordDialog>
    with BaseSingleton {
  late HomeBloc bloc;
  TextEditingController controller = TextEditingController();
  bool isLoading = false, isFailed = false;

  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          setState(() {
            isLoading = true;
            isFailed = false;
          });
        } else if (state is ResetPasswordSuccess) {
          setState(() {
            isLoading = false;
            isFailed = false;
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  return const SuccessDialog();
                });
          });
        } else if (state is ResetPasswordFailed) {
          setState(() {
            isLoading = false;
            isFailed = true;
          });
        }
      },
      child: Scaffold(
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
                child: isLoading
                    ? functions.platformIndicator(true)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (isFailed) const CustomErrorView(),
                          AuthTextInputView(
                            controller: controller,
                            hint:
                                AppLocalizations.of(context)?.newPassword ?? "",
                            textColor: Colors.white,
                          ),
                          CustomButton(
                            text: AppLocalizations.of(context)?.reset ?? "",
                            onTap: () {
                              if (controller.text.trim() != "") {
                                bloc.add(
                                  ResetTeacherPassword(
                                    widget.id,
                                    controller.text.trim(),
                                  ),
                                );
                              }
                            },
                          )
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

/*
*bloc.add(
                                ResetTeacherPassword(
                                  teachers?[index].id,
                                  '123',
                                ),
                              );
* */
