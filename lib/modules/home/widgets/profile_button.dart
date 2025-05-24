import 'package:boardlock/helpers/extansions/color_ext.dart';
import 'package:boardlock/helpers/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileButton extends StatelessWidget {
  final String text, route;
  final VoidCallback? onTap;
  const ProfileButton({
    super.key,
    required this.text,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(
          20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      onPressed: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.push(route);
        }
      },
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: text,
              style: TextStyle(
                fontSize: 20,
                color: HexColor.fromHex(
                  "#0055AE",
                ),
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: HexColor.fromHex(
              "#0055AE",
            ),
          )
        ],
      ),
    );
  }
}
