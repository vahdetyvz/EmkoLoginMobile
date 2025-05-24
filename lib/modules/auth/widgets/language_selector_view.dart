import 'package:boardlock/helpers/bloc/language_bloc.dart';
import 'package:boardlock/helpers/bloc/language_events.dart';
import 'package:boardlock/helpers/bloc/language_states.dart';
import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectorView extends StatefulWidget {
  const LanguageSelectorView({super.key});

  @override
  State<LanguageSelectorView> createState() => _LanguageSelectorViewState();
}

class _LanguageSelectorViewState extends State<LanguageSelectorView> {
  String selectedLangugage = "en";
  var languages = [
    "ar",
    "de",
    "en",
    "fi",
    "fr",
    "he",
    "lt",
    "ro",
    "tr",
  ];

  var lngImages = {
    "ar": "flags/ar_flag".toPng,
    "de": "flags/de_flag".toPng,
    "en": "flags/en_flag".toPng,
    "fi": "flags/fi_flag".toPng,
    "fr": "flags/fr_flag".toPng,
    "he": "flags/he_flag".toPng,
    "lt": "flags/lt_flag".toPng,
    "ro": "flags/ro_flag".toPng,
    "tr": "flags/tr_flag".toPng,
  };
  late LanguageBloc bloc;
  @override
  void initState() {
    bloc = context.read<LanguageBloc>();
    bloc.add(GetLanguage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var languagesTranslated = {
      "ar": AppLocalizations.of(context)?.ar,
      "de": AppLocalizations.of(context)?.de,
      "en": AppLocalizations.of(context)?.en,
      "fi": AppLocalizations.of(context)?.fi,
      "fr": AppLocalizations.of(context)?.fr,
      "he": AppLocalizations.of(context)?.he,
      "lt": AppLocalizations.of(context)?.lt,
      "ro": AppLocalizations.of(context)?.ro,
      "tr": AppLocalizations.of(context)?.tr,
    };
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is LanguageLoaded) {
          setState(() {
            selectedLangugage = state.locale.languageCode;
          });
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              iconSize: 30,
            ),
            items: languages
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                            child: Image.asset(
                              "flags/${item}_flag".toPng,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomText(
                              text: languagesTranslated[item],
                              align: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            value: selectedLangugage,
            onChanged: (String? value) {
              bloc.add(SetLanguage(value ?? "en"));
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#395EBC"),
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: HexColor.fromHex("#395EBC"),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
