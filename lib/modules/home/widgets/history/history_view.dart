import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/history_model.dart';
import 'package:boardlock/modules/home/widgets/history/times_view.dart';
import 'package:flutter/material.dart';

import 'date_list_item_view.dart';

class HistoryView extends StatefulWidget {
  final HistoryListModel? model;

  const HistoryView({
    super.key,
    required this.model,
  });

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  int currentIndex = 20;
  PageController controller =
      PageController(viewportFraction: .3, initialPage: 20);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  if (currentIndex > 0) {
                    controller.animateToPage(currentIndex - 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  itemBuilder: (context, index) {
                    return DateListItemView(
                      index: index,
                      isMain: currentIndex == index,
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (currentIndex < 19) {
                    controller.animateToPage(currentIndex + 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TimesView(
          index: currentIndex,
          model: widget.model,
        ),
      ],
    );
  }
}
