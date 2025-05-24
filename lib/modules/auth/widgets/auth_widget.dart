import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/widgets/custom_button.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "only_logo".toPng,
                  width: MediaQuery.of(context).size.width * .5,
                ),
                const CustomText(
                  text: "Emko\nSmart Lock Pro",
                  maxLines: 2,
                  fontFamily: "Brown",
                  align: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                CustomText(
                  text: AppLocalizations.of(context)?.inControl,
                  align: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  isGrey: true,
                  text: AppLocalizations.of(context)?.login ?? "",
                  onTap: () {
                    context.push(RouteEnums.login.routeName);
                  },
                ),
              ],
            ),
          ),
          if(MediaQuery.of(context).size.height > 680)
          const SizedBox(
            height: 60,
          ),
          CustomText(
            text: "Emko Smart Lock Pro created by ",
            style: TextStyle(
              color: Colors.white.withOpacity(.5)
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SvgPicture.asset(
            "title_logo".toSvg,
            width: 110,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
