import 'package:boardlock/helpers/routes/enums/route_enums.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:boardlock/modules/home/model/about_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutWidget extends StatelessWidget {
  final AboutModel? model;
  const AboutWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          CustomText(
            text: model?.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          CustomText(
            text: model?.content,
            maxLines: 20,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                context.push(RouteEnums.agreementPage.routeName);
              },
              child: CustomText(
                text: AppLocalizations.of(context)?.readTermsAndPolicy,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
          ),
        ]),
      ),
    );
  }
}
