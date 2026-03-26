import 'package:flutter/foundation.dart';

import 'url_opener_stub.dart' if (dart.library.html) 'url_opener_web.dart'
    as url_opener;

class Utils {
  static Future<void> launchURL(String link) async {
    final normalizedLink =
        link.startsWith('http://') || link.startsWith('https://')
            ? link
            : 'https://$link';

    if (!await url_opener.openUrl(normalizedLink)) {
      debugPrint('Could not launch $normalizedLink');
    }
  }
}
