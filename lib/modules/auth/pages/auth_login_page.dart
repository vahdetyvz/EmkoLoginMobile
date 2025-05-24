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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text_input_view.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> with BaseSingleton {
  late AuthBloc bloc;
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  bool isPasswordVisable = true,
      isRead = false,
      isLoading = false,
      isEmailFailed = false;
  int isFailed = -1;

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    password.addListener(() {
      setState(() {});
    });
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
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        log(state.toString());
        if (state is AuthLoaded) {
          setState(() {
            isLoading = false;
            isFailed = -1;
          });
          context.push(RouteEnums.history.routeName);
        } else if (state is AuthLoading) {
          setState(() {
            isLoading = true;
            isFailed = -1;
          });
        } else if (state is AuthFailed) {
          setState(() {
            isLoading = false;
            isFailed = int.tryParse(state.text) ?? 2;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                        ),
                        //kconst LanguageSelectorView(),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)?.login,
                          style: TextStyle(
                            fontSize: 40,
                            color: colors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (isFailed != -1)
                          CustomErrorView(
                            isBlack: true,
                            text: isFailed == 1
                                ? AppLocalizations.of(context)?.checkInfo
                                : isFailed == 2
                                    ? AppLocalizations.of(context)?.worngEmail
                                    : isFailed == 3
                                        ? AppLocalizations.of(context)
                                            ?.worngPassword
                                        : isFailed == 4
                                            ? AppLocalizations.of(context)
                                                ?.isNotActive
                                            : isFailed == 5
                                                ? AppLocalizations.of(context)
                                                    ?.infoApcent
                                                : isFailed == 8
                                                    ? AppLocalizations.of(
                                                            context)
                                                        ?.deviceError
                                                    : null,
                          ),
                        if (isFailed != -1)
                          const SizedBox(
                            height: 30,
                          ),
                        AuthTextInputView(
                          hint: AppLocalizations.of(context)?.email ?? "",
                          controller: email,
                          isFailed:
                              (isFailed == 5 && email.text.trim() == "") ||
                                  (isEmailFailed && isFailed != -1),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthTextInputView(
                          isHidden: isPasswordVisable,
                          isFailed: isFailed == 5 && password.text.trim() == "",
                          hiddenToggle: () {
                            setState(() {
                              isPasswordVisable = !isPasswordVisable;
                            });
                          },
                          hint: AppLocalizations.of(context)?.password ?? "",
                          controller: password,
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width - 55,
                          child: Row(
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
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(
                                        RouteEnums.agreementPage.routeName);
                                  },
                                  child: CustomText(
                                    text:
                                        AppLocalizations.of(context)?.approval,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: isFailed == 5 && !isRead
                                          ? Colors.red
                                          : colors.greyNew.withOpacity(.8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        isLoading
                            ? functions.platformIndicator(false)
                            : CustomButton(
                                text: AppLocalizations.of(context)?.login ?? "",
                                onTap: () {
                                  if (email.text.trim() != "" &&
                                      password.text.trim() != "" &&
                                      !isEmailFailed &&
                                      isRead) {
                                    bloc.add(Login(
                                      email.text.trim(),
                                      password.text.trim(),
                                    ));
                                  } else {
                                    setState(() {
                                      isFailed = 5;
                                    });
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                CustomText(
                  text: AppLocalizations.of(context)?.mustLogin,
                  maxLines: 2,
                  align: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: HexColor.fromHex(
                      "#999999",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
