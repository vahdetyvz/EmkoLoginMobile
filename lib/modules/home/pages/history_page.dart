import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_events.dart';
import 'package:boardlock/modules/home/widgets/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_states.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with BaseSingleton {
  late HomeBloc bloc;
  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    bloc.add(GetModels());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (
                  MediaQuery.of(context).size.height> 700 ? .22:
                  .2) +  MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
              color: colors.blue,
              ),
            ),
          ),
          SafeArea(
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is ModelsLoaded) {
                  return HistoryView(model: state.model);
                } else {
                  return functions.platformIndicator(false);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
