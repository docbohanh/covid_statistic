import 'package:covid_statistic/helper/spinning_widget.dart';
import 'package:covid_statistic/model/localization.dart';
import 'package:covid_statistic/utils/app_theme.dart';
import 'package:covid_statistic/utils/constant.dart';
import 'package:covid_statistic/utils/local_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LocaleDropDown extends StatelessWidget {
  final ILocalization locale;
  final void Function(String newValue) onChanged;

  const LocaleDropDown({Key key, this.locale, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: DropdownButton<String>(
        value: locale.localeCode.toUpperCase(),
        iconEnabledColor: Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.arrow_drop_down, color: Colors.transparent),
        iconSize: 15,
        elevation: 16,
        style: GoogleFonts.robotoSlab(
            color: Theme.of(context).accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        underline: Container(
          height: 0,
          color: Theme.of(context).accentColor,
        ),
        onChanged: onChanged,
        selectedItemBuilder: _selectedItemBuilder,
        items: _dropdownMenuItem(),
      ),
    );
  }

  List<Widget> _selectedItemBuilder(context) {
    return LocalizationUtils.getLocaleNamesPretty()
        .map(
          (value) => SpinningWidget(
            size: 28,
            child: SizedBox(
              height: 28,
              width: 28,
              child: SvgPicture.asset(
                "assets/flags/${locale.countryCode.toLowerCase()}.svg",
              ),
            ),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<String>> _dropdownMenuItem() {
    return Constant.locales.keys.map<DropdownMenuItem<String>>((String key) {
      ILocalization localeTemp = LocalizationUtils.getLocale(key);
      return DropdownMenuItem<String>(
        value: key.toUpperCase(),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          height: 32,
          width: 32,
          child: SvgPicture.asset(
            "assets/flags/${localeTemp.countryCode.toLowerCase()}.svg",
          ),
        ),
      );
    }).toList();
  }
}
