// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';

class CardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const CardTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.light,
      child: ListTile(
        title: Text(
          title,
          style: TextStyles.designText(
              bold: false, color: Palette.primary.value, size: 14),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
