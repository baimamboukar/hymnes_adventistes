import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:lottie/lottie.dart';

class NoReferenceCantique extends ConsumerWidget {
  const NoReferenceCantique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Aucune référence disponible",
            style: TextStyles.designText(bold: true, size: 20),
          ),
          Center(
            child: Lottie.asset("assets/animations/notes.json"),
          ),
        ],
      ),
    );
  }
}
