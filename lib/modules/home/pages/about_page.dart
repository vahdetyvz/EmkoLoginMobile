import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_error_view.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/bloc/about/about_bloc.dart';
import 'package:boardlock/modules/home/bloc/about/about_events.dart';
import 'package:boardlock/modules/home/bloc/about/about_states.dart';
import 'package:boardlock/modules/home/widgets/about_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatefulWidget with BaseSingleton {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with BaseSingleton {
  late AboutBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<AboutBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(GetAbout(AppLocalizations.of(context)?.code ?? "tr"));
    });
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
              height: MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).size.height > 700 ? .22 : .2) +
                  MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(
                color: colors.blue,
              ),
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                    ),
                    Image.asset(
                      "only_logo".toPng,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomText(
                      text: "Emko Smart Lock Pro",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is AboutLoaded) {
                      return AboutWidget(model: state.model);
                    } else if (state is AboutFailed) {
                      return const Center(
                        child: CustomErrorView(
                          isBlack: true,
                        ),
                      );
                    } else {
                      return functions.platformIndicator(false);
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
