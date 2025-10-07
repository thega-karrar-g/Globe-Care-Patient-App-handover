import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';

import '../../core/language_and_localization/app_strings.dart';

class SearchResultWidget extends StatelessWidget {
  SearchResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppStrings.search.tr,
                style: AppStyles.primaryStyle(),
              ),
              subtitle: Text(
                "Subtitle",
                style: AppStyles.primaryStyle(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onSubmitted: (text) async {
                // await _con.refreshSearch(text);
                // _con.saveSearch(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: AppStrings.searchHint.tr,
                hintStyle:
                    (TextStyle(fontSize: 14)),
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.1))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.3))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.1))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
