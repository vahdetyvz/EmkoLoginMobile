import 'package:boardlock/helpers/extansions/custom_gradient.dart';
import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateListItemView extends StatefulWidget {
  final int index;
  final bool isMain;
  const DateListItemView({
    super.key,
    required this.index,
    required this.isMain,
  });

  @override
  State<DateListItemView> createState() => _DateListItemViewState();
}

class _DateListItemViewState extends State<DateListItemView> with BaseSingleton {
  late DateTime date;
  late List<String?> weekDays = [
    AppLocalizations.of(context)?.weekDay1Short,
    AppLocalizations.of(context)?.weekDay2Short,
    AppLocalizations.of(context)?.weekDay3Short,
    AppLocalizations.of(context)?.weekDay4Short,
    AppLocalizations.of(context)?.weekDay5Short,
    AppLocalizations.of(context)?.weekDay6Short,
    AppLocalizations.of(context)?.weekDay7Short,
  ];

  @override
  void initState() {
    date = DateTime.now().subtract(Duration(days: (19 - widget.index).abs()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * .05,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: widget.isMain ? MediaQuery.of(context).size.height * .025 : MediaQuery.of(context).size.height * .06,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: widget.isMain
            ? null
            : colors.grey,
        gradient: widget.isMain ? customGradient(colors) : null,
      ),
      duration: const Duration(
        milliseconds: 200,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: date.day.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          CustomText(
            text: weekDays[date.weekday - 1],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          if (widget.isMain)
            const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
