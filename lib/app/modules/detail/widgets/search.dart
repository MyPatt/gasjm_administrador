import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/sliver_header_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      //pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 95.0,
        minHeight: 95.0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.search_outlined,
                  color: AppTheme.blueDark,
                ),
              ),
              Expanded(
                child: CupertinoTextField(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: const BoxDecoration(),
                  placeholder: 'Buscar',
                  placeholderStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                          color: AppTheme.searchColor,
                          fontWeight: FontWeight.w100),
                  cursorColor: AppTheme.searchColor,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppTheme.searchColor,
                        fontWeight: FontWeight.w100,
                      ),
                ),
              ),
              /*Icon(
                Icons.folder_delete_outlined,
                color: AppTheme.blueDark,
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
