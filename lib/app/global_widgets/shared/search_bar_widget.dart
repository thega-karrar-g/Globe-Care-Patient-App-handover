import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import 'search_widget.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged? onClickFilter;

  const SearchBarWidget({Key? key, this.onClickFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.all(9),
        margin: const EdgeInsets.only(top: 5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search, color: AppColors.mainColor),
            ),
            Expanded(
              child: Text(
                AppStrings.search.tr,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: (TextStyle(fontSize: 16, color: AppColors.mainColor)),
              ),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: () {
                onClickFilter!('e');
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: AppColors.extraGrey.withOpacity(0.1),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      AppStrings.filter,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.filter_list,
                      color: Theme.of(context).hintColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
