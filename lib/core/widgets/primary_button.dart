import 'package:flutter/material.dart';
import 'package:instagram_user_viewer/core/constants.dart';
import 'package:instagram_user_viewer/theme/palette.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius / 2),
            ),
            fixedSize: Size(width ?? double.infinity, 48)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator(color: Palette.red300,)
            else
              Text(
                text,
                style: Theme.of(context).textTheme.button,
              ),
          ],
        ),
      ),
    );
  }
}
