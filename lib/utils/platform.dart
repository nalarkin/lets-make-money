import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class PlatformFinder with ChangeNotifier {
  PlatformFinder() {
    if ((defaultTargetPlatform == TargetPlatform.android)) {
      // Some android/ios specific code
      _isAndroid = true;
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      _isAndroid = false;
      // Some desktop specific code there
    } else {
      _isAndroid = false;
      // Some web specific code there
    }
  }
  bool _isAndroid = false;

  bool get isAndroid => _isAndroid;
}
