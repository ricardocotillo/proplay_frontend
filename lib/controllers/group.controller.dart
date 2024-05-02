import 'package:flutter/foundation.dart';
import 'package:proplay/models/progroup.model.dart';
import 'package:share_plus/share_plus.dart';

class GroupController with ChangeNotifier {
  int viewIndex = 0;

  void changeView(int i) {
    viewIndex = i;
    notifyListeners();
  }

  void share(ProGroup group) {
    Share.share(
        'Únete a mi grupo. Descarga https://proplay.app.com y usa el código ${group.code}');
  }
}
