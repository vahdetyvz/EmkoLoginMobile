import 'dart:io';

import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_button.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/bloc/auth_bloc.dart';
import 'package:boardlock/modules/auth/bloc/auth_events.dart';
import 'package:boardlock/modules/auth/bloc/auth_states.dart';
import 'package:boardlock/modules/auth/model/auth_model.dart';
import 'package:boardlock/modules/auth/widgets/auth_text_input_view.dart';
import 'package:boardlock/modules/home/widgets/dialogs/sucess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with BaseSingleton {
  TextEditingController name = TextEditingController(),
      password = TextEditingController(),
      oldPassword = TextEditingController(),
      rePassword = TextEditingController();
  bool passwordVissable = true,
      oldPsswordVissable = true,
      rePasswordVissable = true,
      noti = true,
      loading = false;
  int failed = 0;
  late AuthBloc bloc;
  AuthModel? model;
  String selectedFile = "";
  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    bloc.add(GetAuth());
    super.initState();
  }

  @override
  void dispose() {
    bloc.add(GetAuth());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            loading = true;
            failed = 0;
          });
        } else if (state is AuthLoaded) {
          setState(() {
            loading = false;
            failed = 0;
            name.text = state.model?.fullName ?? "";
            model = state.model;
          });
        } else if (state is UpdateSuccess) {
          password.text = "";
          rePassword.text = "";
          oldPassword.text = "";
          name.text = state.model?.fullName ?? "";
          setState(() {
            loading = false;
            failed = 0;
            model = state.model;
          });

          showDialog(
              context: context,
              builder: (context) {
                return const SuccessDialog();
              });
        } else if (state is AuthFailed) {
          setState(() {
            loading = false;
            failed = state.text.contains("sifre") ? 2 : 1;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  CustomText(
                    text: AppLocalizations.of(context)?.profile,
                    style: TextStyle(
                      fontSize: 30,
                      color: HexColor.fromHex(
                        "#0055AE",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor.fromHex("#F3661E"),
                            image: model?.image != null && model?.image != ""
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      model!.image.toNetwork,
                                    ),
                                  )
                                : selectedFile != ""
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(
                                          selectedFile,
                                        )),
                                      )
                                    : DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          "person".toPng,
                                        ),
                                      ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: HexColor.fromHex(
                                "#3A90CD",
                              ),
                            ),
                            onPressed: () {
                              functions.selectImage(
                                  (path) => {
                                        setState(() {
                                          selectedFile = path;
                                        }),
                                        bloc.add(UpdateProfilePicture(path)),
                                      },
                                  context);
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: model?.fullName ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      color: HexColor.fromHex(
                        "#0055AE",
                      ),
                    ),
                  ),
                  CustomText(
                    text: model?.canEditTeacher == true
                        ? AppLocalizations.of(context)?.bt
                        : AppLocalizations.of(context)?.teacher,
                    style: TextStyle(
                      fontSize: 15,
                      color: HexColor.fromHex(
                        "#0055AE",
                      ),
                    ),
                  ),
                  AuthTextInputView(
                    controller: name,
                    placeHolder: model?.fullName,
                    hint: AppLocalizations.of(context)?.nameSurname ?? "",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextInputView(
                    isEnabled: false,
                    controller: TextEditingController(text: model?.email),
                    placeHolder: model?.email,
                    hint: AppLocalizations.of(context)?.email ?? "",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthTextInputView(
                    controller: oldPassword,
                    isHidden: oldPsswordVissable,
                    hiddenToggle: () {
                      setState(() {
                        oldPsswordVissable = !oldPsswordVissable;
                      });
                    },
                    hint: AppLocalizations.of(context)?.oldPassword ?? "",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextInputView(
                    controller: password,
                    isHidden: passwordVissable,
                    hiddenToggle: () {
                      setState(() {
                        passwordVissable = !passwordVissable;
                      });
                    },
                    hint: AppLocalizations.of(context)?.password ?? "",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextInputView(
                    controller: rePassword,
                    isHidden: rePasswordVissable,
                    hiddenToggle: () {
                      setState(() {
                        rePasswordVissable = !rePasswordVissable;
                      });
                    },
                    hint: AppLocalizations.of(context)?.rePassword ?? "",
                  ),
                  /*   const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: AppLocalizations.of(context)?.notifications,
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor.fromHex(
                              "#303535",
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        value: noti,
                        activeColor: HexColor.fromHex(
                          "#0081BD",
                        ),
                        onChanged: (newNoit) {
                          setState(() {
                            noti = newNoit;
                          });
                        },
                      )
                    ],
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  if (failed > 0)
                    Column(
                      children: [
                        CustomErrorView(
                          isBlack: true,
                          text: failed == 2
                              ? AppLocalizations.of(context)?.enterOldPassword
                              : null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  loading
                      ? functions.platformIndicator(false)
                      : CustomButton(
                          text: AppLocalizations.of(context)?.save ?? "",
                          onTap: () {
                            if (model != null) {
                              if (password.text.trim() != "" &&
                                  oldPassword.text.trim() != "" &&
                                  password.text.trim() != "" &&
                                  oldPassword.text.trim().length > 7 &&
                                  password.text.trim().length > 7 &&
                                  (oldPassword.text.trim() ==
                                      model?.password)) {
                                bloc.add(
                                  UpdateUser(
                                    name.text.trim(),
                                    oldPassword.text.trim(),
                                    password.text.trim(),
                                    model!,
                                  ),
                                );
                              } else if (oldPassword.text.trim() == "" &&
                                  password.text.trim() == "" &&
                                  rePassword.text.trim() == "") {
                                bloc.add(
                                  UpdateUser(
                                    name.text.trim(),
                                    oldPassword.text.trim(),
                                    password.text.trim(),
                                    model!,
                                  ),
                                );
                              } else {
                                setState(() {
                                  failed = 2;
                                });
                              }
                            }
                          })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
