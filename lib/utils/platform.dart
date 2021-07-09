import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class PlatformFinder with ChangeNotifier {
  PlatformFinder() {
    if ((defaultTargetPlatform == TargetPlatform.android)) {
      _isAndroid = true;
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      _isAndroid = false;
    } else {
      _isAndroid = false;
    }
  }
  bool _isAndroid = false;

  bool get isAndroid => _isAndroid;
}
