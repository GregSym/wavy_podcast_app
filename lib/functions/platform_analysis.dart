import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformAnalysis {
  static bool get isMobile =>
      !kIsWeb ? Platform.isAndroid || Platform.isIOS : false;
  static bool get isWeb => kIsWeb;
}
