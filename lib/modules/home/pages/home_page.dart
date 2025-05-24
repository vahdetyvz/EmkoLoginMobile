import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/video_title_model.dart';
import 'package:boardlock/modules/home/widgets/video_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';

import '../bloc/home_bloc.dart';
import '../../../../../helpers/singleton/base_singelton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseSingleton {
  late HomeBloc bloc;
  late VideoPlayerController _controller;
  late var videoLists = [
    VideoTitleModel(
      AppLocalizations.of(context)?.step1Header ?? "",
      AppLocalizations.of(context)?.step1Explain ?? "",
      const Duration(minutes: 0, seconds: 0),
      const Duration(minutes: 1, seconds: 20),
    ),
    VideoTitleModel(
      AppLocalizations.of(context)?.step2Header ?? "",
      AppLocalizations.of(context)?.step2Explain ?? "",
      const Duration(minutes: 1, seconds: 20),
      const Duration(minutes: 2, seconds: 20),
    ),
    VideoTitleModel(
      AppLocalizations.of(context)?.step3Header ?? "",
      AppLocalizations.of(context)?.step3Explain ?? "",
      const Duration(minutes: 2, seconds: 20),
      const Duration(minutes: 3, seconds: 9),
    ),
    VideoTitleModel(
      AppLocalizations.of(context)?.step4Header ?? "",
      AppLocalizations.of(context)?.step4Explain ?? "",
      const Duration(minutes: 3, seconds: 9),
      const Duration(minutes: 4, seconds: 48),
    ),
  ];
  @override
  void initState() {
    bloc = context.read<HomeBloc>();
    _controller = VideoPlayerController.asset(
      "assets/raw/emko.mp4",
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (_controller.value.isInitialized) {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
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
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : const SizedBox(),
                ),
              ),
              if (!_controller.value.isPlaying)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_controller.value.isInitialized) {
                          _controller.play();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HexColor.fromHex(
                                "#849FFF",
                              ),
                              HexColor.fromHex(
                                "#5379F5",
                              ),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 10,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .85,
                      child: SmoothVideoProgress(
                        controller: _controller,
                        builder: (context, position, duration, child) => Slider(
                          activeColor: HexColor.fromHex("#0055AE"),
                          thumbColor: HexColor.fromHex("#4950A1"),
                          inactiveColor: Colors.white,
                          onChangeStart: (_) => _controller.pause(),
                          onChangeEnd: (_) => _controller.play(),
                          onChanged: (value) => _controller
                              .seekTo(Duration(milliseconds: value.toInt())),
                          value: position.inMilliseconds.toDouble(),
                          min: 0,
                          max: duration.inMilliseconds.toDouble(),
                        ),
                      ),
                    ),
                    CustomText(
                        text:
                            '${(_controller.value.position.inSeconds ~/ 60) >= 10 ? (_controller.value.position.inSeconds ~/ 60) : "0${(_controller.value.position.inSeconds ~/ 60)}"} : ${(_controller.value.position.inSeconds % 60) > 10 ? (_controller.value.position.inSeconds % 60) : "0${(_controller.value.position.inSeconds % 60)}"}')
                  ],
                ),
              )
            ],
          ),
          CustomText(
            text: AppLocalizations.of(context)?.howToUse,
            style: TextStyle(
              fontSize: 25,
              color: HexColor.fromHex("#0055AE"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videoLists.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      bottom: index == videoLists.length - 1
                          ? MediaQuery.of(context).size.width * .1
                          : 0),
                  child: VideoTitleView(
                      seekTo: (position) {
                        _controller.seekTo(position);
                      },
                      model: videoLists[index],
                      currentPostion: _controller.value.position),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
