import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizationsCustomDirect {
  AppLocalizationsCustomDirect(this.isZh);

  //是否为中文
  bool isZh = false;

  //为了使用方便，我们定义一个静态方法
  static AppLocalizationsCustomDirect of(BuildContext context) {
    return Localizations.of<AppLocalizationsCustomDirect>(context, AppLocalizationsCustomDirect)!;
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? "Flutter应用" : "Flutter APP";
  }
}

class AppLocalizationsCustomDirectDelegate extends LocalizationsDelegate<AppLocalizationsCustomDirect> {
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizationsCustomDirect> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<AppLocalizationsCustomDirect>(
        AppLocalizationsCustomDirect(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizationsCustomDirect> old) =>
      false;
}
