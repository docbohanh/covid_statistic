import 'package:covid_statistic/model/main_info.dart';
import 'package:covid_statistic/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDropdown extends StatelessWidget {
  final MainInfo value;
  final void Function(MainInfo newValue) onChanged;

  const MainDropdown({Key key, this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: DropdownButton<MainInfo>(
        value: value,
        iconEnabledColor: Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor,
        iconSize: 15,
        elevation: 16,
        style: GoogleFonts.roboto(
          color: Theme.of(context).accentColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        underline: SizedBox(),
        icon: SizedBox(),
        selectedItemBuilder: (BuildContext context) {
          return MainInfo.items.map((item) {
            return Center(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_downward,
                    color: Theme.of(context).accentColor,
                    size: 16,
                  ),
                  Text(
                    '${item.name}',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      letterSpacing: 0.5,
                      color: AppTheme.nearlyDarkBlue,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
        onChanged: onChanged,
        items: MainInfo.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              '${item.name}',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                letterSpacing: 0.5,
                color: AppTheme.lightText,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
