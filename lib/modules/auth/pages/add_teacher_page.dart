import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/modules/auth/pages/auth_register_page.dart';
import 'package:boardlock/modules/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_events.dart';

class AddTeacherPage extends StatefulWidget {
  final String? schoolId;

  const AddTeacherPage({super.key, this.schoolId});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> with BaseSingleton {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(GetSchoolDetail(int.tryParse(widget.schoolId ?? "0") ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: BlocBuilder(builder: (context, state) {
          if (state is SchoolDetailLoaded) {
            return AuthRegisterPage(
              schoolId: state.model?.number.toString(),
            );
          } else if (state is HomeFailed) {
            return const Center(
              child: CustomErrorView(
                isBlack: true,
              ),
            );
          } else {
            return functions.platformIndicator(false);
          }
        }),
      ),
    );
  }
}
