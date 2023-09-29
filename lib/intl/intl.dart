import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'translations/en_US.dart';
import 'translations/es_ES.dart';


class Intl extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'es-ES': es_ES,
      };

  /*LOCALES*/
  static Locale get localeEN_US => const Locale('en_US');

  static Locale get localeSpanish => const Locale('es-ES');


}
