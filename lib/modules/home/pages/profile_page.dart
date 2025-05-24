import 'dart:io';

import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/auth/bloc/auth_bloc.dart';
import 'package:boardlock/modules/auth/bloc/auth_events.dart';
import 'package:boardlock/modules/auth/bloc/auth_states.dart';
import 'package:boardlock/modules/auth/model/auth_model.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/widgets/delete_account_dialog.dart';
import 'package:boardlock/modules/home/widgets/dialogs/edit_master_key_dialog.dart';
import 'package:boardlock/modules/home/widgets/dialogs/school_detail_page.dart';
import 'package:boardlock/modules/home/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/model/school_model.dart';
import '../bloc/home_events.dart';
import '../bloc/home_states.dart';
import '../widgets/invate_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with BaseSingleton {
  late AuthBloc bloc;
  late HomeBloc homeBloc;
  AuthModel? model;
  SchoolModel? schoolModel;
  String selectedFile = "";

  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    homeBloc = context.read<HomeBloc>();

    bloc.add(GetAuth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is SchoolDetailLoaded) {
          setState(() {
            schoolModel = state.model;
          });
        }
      },
      child: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is AuthLoaded) {
            setState(() {
              model = state.model;
            });
            homeBloc.add(GetSchoolDetail(model!.schoolId));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height *
                                (MediaQuery.of(context).size.height > 700
                                    ? .22
                                    : .2) +
                            MediaQuery.of(context).padding.top,
                        color: colors.blue,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).padding.top,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SvgPicture.asset(
                                "title_logo".toSvg,
                                width: 120,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomText(
                                text: "Emko Smart Lock Pro ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor.fromHex("#F3661E"),
                                        image: model?.image != null &&
                                                model?.image != ""
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
                                                    bloc.add(
                                                        UpdateProfilePicture(
                                                            path)),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: model?.fullName,
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
                  ProfileButton(
                    text: AppLocalizations.of(context)?.profile ?? "",
                    route: RouteEnums.profileEdit.routeName,
                  ),
                  if (model?.canEditTeacher == true)
                    Column(
                      children: [
                        ProfileButton(
                          text: AppLocalizations.of(context)?.installCode ?? "",
                          route: RouteEnums.schoolDetail.routeName,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SchoolDetailPage(
                                    schoolId: schoolModel?.number.toString(),
                                  );
                                });
                          },
                        ),
                        ProfileButton(
                          text: AppLocalizations.of(context)?.addTeacher ?? "",
                          route: RouteEnums.history.routeName,
                          onTap: () {
                            context.push(
                              RouteEnums.addTeacher.routeName,
                              extra: schoolModel?.id.toString(),
                            );
                          },
                        ),
                        ProfileButton(
                          text:
                              AppLocalizations.of(context)?.resetTeacher ?? "",
                          route: RouteEnums.teachers.routeName,
                        ),
                        ProfileButton(
                          text: AppLocalizations.of(context)?.editMaster ?? "",
                          route: RouteEnums.history.routeName,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const EditMasterKey();
                                });
                          },
                        ),
                      ],
                    ),
                  ProfileButton(
                    text: AppLocalizations.of(context)?.deleteAccount ?? "",
                    route: RouteEnums.history.routeName,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => DeleteAccountDialog(
                                id: model?.id ?? 0,
                              ));
                    },
                  ),
                  if (model?.email.contains("ee.com") ?? false)
                    ProfileButton(
                      text: AppLocalizations.of(context)?.invate ?? "",
                      route: RouteEnums.history.routeName,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const InvateDialog());
                      },
                    ),
                  ProfileButton(
                    text: AppLocalizations.of(context)?.about ?? "",
                    route: RouteEnums.aboutPage.routeName,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final prefences = await SharedPreferences.getInstance();
                      await prefences.clear();
                      context.go(RouteEnums.auth.routeName);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: AppLocalizations.of(context)?.logOut,
                            style: TextStyle(
                              fontSize: 20,
                              color: HexColor.fromHex(
                                "#0055AE",
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.logout,
                          color: HexColor.fromHex(
                            "#0055AE",
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
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
