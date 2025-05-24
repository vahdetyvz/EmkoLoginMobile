import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/extansions/color_ext.dart';
import '../../../helpers/widgets/custom_text.dart';

class SchoolSelector extends StatelessWidget {
  final SchoolListModel? schools;
  final SchoolModel? selected;
  final Function(SchoolModel? selected) onSelect;
  const SchoolSelector({
    super.key,
    required this.schools,
    required this.onSelect,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const CustomText(
              text: "school",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CupertinoColors.placeholderText,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<SchoolModel?>(
                  isExpanded: true,
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                  ),
                  items: schools?.schools
                      .map((SchoolModel item) => DropdownMenuItem<SchoolModel?>(
                            value: item,
                            child: CustomText(
                              text: item.name,
                              align: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selected,
                  onChanged: (SchoolModel? value) {
                    onSelect(value);
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 3,
          color: HexColor.fromHex(
            "#7B7E9D",
          ),
        )
      ],
    );
  }
}
