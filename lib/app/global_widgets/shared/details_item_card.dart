import 'package:flutter/material.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';

class DetailsItemCard extends StatelessWidget {
  const DetailsItemCard({this.title, this.desc, Key? key}) : super(key: key);

  final String? title, desc;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Text(
              '$title',
              style: AppStyles.primaryStyle(bold: true),
            ),
            Text(
              '$desc',
              style: AppStyles.primaryStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
