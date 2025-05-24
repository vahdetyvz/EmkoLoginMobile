import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_events.dart';
import 'package:boardlock/modules/home/bloc/home_states.dart';
import 'package:boardlock/modules/home/widgets/dialogs/new_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../helpers/extansions/color_ext.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> with BaseSingleton {
  late HomeBloc bloc;
  List<dynamic>? teachers;
  bool isLoading = false, isFailed = false;
  @override
  void initState() {
    super.initState();
    bloc = context.read<HomeBloc>();
    bloc.add(GetTeachers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is HomeLoading) {
          setState(() {
            isLoading = true;
            isFailed = false;
          });
        } else if (state is HomeFailed) {
          setState(() {
            isLoading = false;
            isFailed = true;
          });
        } else if (state is TeachersLoaded) {
          setState(() {
            isLoading = false;
            isFailed = false;
            teachers = state.teacher;
          });
        } else if (state is ResetPasswordSuccess) {
          bloc.add(GetTeachers());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          HexColor.fromHex(
                            "#504CA0",
                          ),
                          HexColor.fromHex(
                            "#3A90CD",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: CustomText(
                        text: AppLocalizations.of(context)?.teachers,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Column(
                    children: [
                      if (isLoading) functions.platformIndicator(false),
                      if (isFailed)
                        const CustomErrorView(
                          isBlack: true,
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: CustomText(
                                text: AppLocalizations.of(context)?.nameSurname,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Center(
                              child: CustomText(
                                text: AppLocalizations.of(context)?.email,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Center(
                              child: CustomText(
                                text: AppLocalizations.of(context)?.action,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: teachers?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: CustomText(
                                      text: teachers?[index].fullName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: CustomText(
                                      text: teachers?[index].email,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return NewPasswordDialog(
                                            id: teachers?[index].id ?? 0,
                                          );
                                        });
                                  },
                                  child: CustomText(
                                    text: AppLocalizations.of(context)?.reset,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
