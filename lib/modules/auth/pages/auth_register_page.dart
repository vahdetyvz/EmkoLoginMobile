import 'dart:developer';

import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_button.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/bloc/auth_bloc.dart';
import 'package:boardlock/modules/auth/bloc/auth_events.dart';
import 'package:boardlock/modules/auth/bloc/auth_states.dart';
import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text_input_view.dart';
import '../widgets/language_selector_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthRegisterPage extends StatefulWidget {
  final String? schoolId;
  const AuthRegisterPage({
    super.key,
    this.schoolId,
  });

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage>
    with BaseSingleton {
  late AuthBloc bloc;
  TextEditingController nameSurname = TextEditingController(),
      email = TextEditingController(),
      phone = MaskedTextController(mask: "0000000000"),
      password = TextEditingController(),
      passwordAgin = TextEditingController(),
      schoolCode = MaskedTextController(mask: "00000000");
  bool isPasswordVisable = true, isRead = false, isPasswordVisableAgin = true;
  SchoolListModel? model;
  SchoolModel? selectedModel;
  bool loading = false,
      isEmailFailed = false,
      isPhoneFailed = false,
      isSchoolCodeFailed = false,
      isPasswordFailed = false;
  String phoneCode = "+90";
  int failed = -1;
  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    email.addListener(() {
      setState(() {
        isEmailFailed = !RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email.text.trim());
      });
    });
    phone.addListener(() {
      setState(() {
        isPhoneFailed = phone.text.trim().length != 10;
      });
    });
    schoolCode.addListener(() {
      setState(() {
        isSchoolCodeFailed = schoolCode.text.trim().length != 8;
      });
    });
    passwordAgin.addListener(() {
      setState(() {
        isPasswordFailed = passwordAgin.text.trim() != password.text.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            loading = true;
            failed = -1;
          });
        } else if (state is RegisterSuccess) {
          setState(() {
            loading = false;
            failed = -1;
          });
          if (widget.schoolId != null) {
            context.pop();
          } else {
            context.go(RouteEnums.login.routeName);
          }
        } else if (state is AuthFailed) {
          setState(() {
            loading = false;
            failed = int.tryParse(state.text) ?? 2;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                  ),
                  if (widget.schoolId == null) const LanguageSelectorView(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: widget.schoolId == null
                        ? AppLocalizations.of(context)?.signUp
                        : AppLocalizations.of(context)?.addTeacher,
                    style: TextStyle(
                      fontSize: 40,
                      color: HexColor.fromHex(
                        "#0055AE",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextInputView(
                    hint: AppLocalizations.of(context)?.nameSurname ?? "",
                    controller: nameSurname,
                    isFailed: (failed == 5 && nameSurname.text.trim() == ""),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextInputView(
                    hint: AppLocalizations.of(context)?.email ?? "",
                    controller: email,
                    isFailed: (failed == 5 && email.text.trim() == "") ||
                        isEmailFailed,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextInputView(
                    hint: AppLocalizations.of(context)?.phone ?? "",
                    controller: phone,
                    isPhoneCode: true,
                    isFailed: (failed == 5 && phone.text.trim() == "") ||
                        isPhoneFailed,
                    onPhoneCodeChange: (val) {
                      setState(() {
                        phoneCode = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (widget.schoolId == null)
                    AuthTextInputView(
                      hint: AppLocalizations.of(context)?.schoolCode ?? "",
                      controller: schoolCode,
                      isFailed: (failed == 5 && schoolCode.text.trim() == "") ||
                          isSchoolCodeFailed,
                    ),
                  if (widget.schoolId == null)
                    const SizedBox(
                      height: 30,
                    ),
                  AuthTextInputView(
                    hint: AppLocalizations.of(context)?.password ?? "",
                    controller: password,
                    isFailed: (failed == 5 && password.text.trim() == ""),
                    isHidden: isPasswordVisable,
                    hiddenToggle: () {
                      setState(() {
                        isPasswordVisable = !isPasswordVisable;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextInputView(
                    hint: AppLocalizations.of(context)?.rePassword ?? "",
                    controller: passwordAgin,
                    isHidden: isPasswordVisableAgin,
                    isFailed: (failed == 5 && passwordAgin.text.trim() == "") ||
                        isPasswordFailed,
                    hiddenToggle: () {
                      setState(() {
                        isPasswordVisableAgin = !isPasswordVisableAgin;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  if (widget.schoolId == null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isRead,
                          activeColor: HexColor.fromHex(
                            "#0055AE",
                          ),
                          checkColor: Colors.white,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                isRead = newValue;
                              });
                            }
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(RouteEnums.agreementPage.routeName);
                          },
                          child: CustomText(
                            text: AppLocalizations.of(context)?.approval,
                            style: TextStyle(
                              color: failed == 5 && !isRead
                                  ? Colors.red
                                  : HexColor.fromHex(
                                      "#CCCCCC",
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (failed != -1)
                    CustomErrorView(
                      isBlack: true,
                      text: failed == 1
                          ? AppLocalizations.of(context)?.checkInfo
                          : failed == 3
                              ? AppLocalizations.of(context)?.userExists
                              : failed == 5
                                  ? AppLocalizations.of(context)?.infoApcent
                                  : null,
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  loading
                      ? functions.platformIndicator(false)
                      : CustomButton(
                          text: widget.schoolId == null
                              ? AppLocalizations.of(context)?.signUp ?? ""
                              : AppLocalizations.of(context)?.add ?? "",
                          onTap: () {
                            log("$phoneCode${phone.text.trim()}");
                            if (nameSurname.text.trim() != "" &&
                                email.text.trim() != "" &&
                                password.text.trim() != "" &&
                                passwordAgin.text.trim() != "" &&
                                passwordAgin.text.trim() ==
                                    password.text.trim() &&
                                (schoolCode.text.trim() != "" ||
                                    widget.schoolId != null) &&
                                (widget.schoolId != null ? true : isRead) &&
                                !isEmailFailed &&
                                !isPhoneFailed &&
                                !isSchoolCodeFailed &&
                                !isPasswordFailed) {
                              bloc.add(Register(
                                nameSurname.text.trim(),
                                email.text.trim(),
                                widget.schoolId ?? schoolCode.text.trim(),
                                "$phoneCode${phone.text.trim()}",
                                password.text.trim(),
                              ));
                            } else {
                              setState(() {
                                failed = 5;
                              });
                            }
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.schoolId == null)
                    CustomText(
                      text: AppLocalizations.of(context)?.mustSignIn,
                      maxLines: 2,
                      align: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor.fromHex(
                          "#999999",
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
