import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [1, 2, 3, 4, 5, 6, 7]
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = e;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: e != currentIndex
                                ? null
                                : LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      HexColor.fromHex("#F3661E"),
                                      HexColor.fromHex("#F14328"),
                                    ],
                                  ),
                          ),
                          child: Center(
                            child: CustomText(
                              text: e.toString(),
                              style: TextStyle(
                                color: e < currentIndex
                                    ? Colors.white.withOpacity(.7)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  10,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text:
                          "${AppLocalizations.of(context)?.question} $currentIndex",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const CustomText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies, leo sollicitudin feugiat vestibulum, enim sem porttitor felis, in condimentum sapien nisi sed elit. Nullam sollicitudin et dui ",
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: AppLocalizations.of(context)?.answer,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const CustomText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies, leo sollicitudin feugiat vestibulum, enim sem porttitor felis, in condimentum sapien nisi sed elit. Nullam sollicitudin et dui ",
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                if (currentIndex > 1)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex -= 1;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: HexColor.fromHex(
                            "#0081BD",
                          ),
                        ),
                        CustomText(
                          text: AppLocalizations.of(context)?.back,
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor.fromHex(
                              "#0081BD",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                if (currentIndex < 7)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex += 1;
                      });
                    },
                    child: Row(
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)?.next,
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor.fromHex(
                              "#0081BD",
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: HexColor.fromHex(
                            "#0081BD",
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  width: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
