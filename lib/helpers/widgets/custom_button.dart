import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget with BaseSingleton{
  final String text;
  final VoidCallback onTap;
  final bool isGrey;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,  this.isGrey = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        padding: const EdgeInsets.all(
          10,
        ),
        decoration: BoxDecoration(
          color: isGrey? colors.grey: colors.blue,

          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: Center(
          child: CustomText(
            text: text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
