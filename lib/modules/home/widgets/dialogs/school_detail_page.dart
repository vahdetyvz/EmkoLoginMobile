import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_button.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../helpers/extansions/color_ext.dart';

class SchoolDetailPage extends StatefulWidget {
  final String? schoolId;
  const SchoolDetailPage({super.key, this.schoolId});

  @override
  State<SchoolDetailPage> createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage>
    with BaseSingleton {
  late HomeBloc bloc;
  bool isLoading = false, isFailed = false;
  SchoolModel? model;
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
        if (state is HomeLoading) {
          setState(() {
            isLoading = true;
            isFailed = false;
          });
        } else if (state is SchoolDetailLoaded) {
          setState(() {
            isLoading = false;
            isFailed = false;
            model = state.model;
          });
        } else if (state is HomeFailed) {
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
                            CustomText(
                              text:
                                  "${AppLocalizations.of(context)?.installCode} \n${int.tryParse(widget.schoolId ?? "0") ?? 0}",
                              maxLines: 2,
                              align: TextAlign.center,
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
          )),
    );
  }
}
