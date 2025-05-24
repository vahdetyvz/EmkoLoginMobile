import 'package:boardlock/helpers/extansions/custom_gradient.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/modules/auth/bloc/auth_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../helpers/singleton/base_singelton.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_states.dart';
import '../widgets/auth_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with BaseSingleton {
  late AuthBloc bloc;
  int index = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    bloc.add(GetAuth());
    customDio.initilaze();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthLoaded) {
          context.go(RouteEnums.history.routeName);
        } else if (state is AuthFailed) {
          setState(() {
            isLoading = true;
          });
        } else if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is AuthToPage) {
          setState(() {
            index = state.page;
            isLoading = true;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: customGradient(colors),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const AuthWidget(),
          ),
        ),
      ),
    );
  }
}
