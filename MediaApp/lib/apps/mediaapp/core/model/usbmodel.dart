import 'dart:async';

import 'package:Flutter_MusicApp/apps/mediaapp/core/model/songinfo.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/core/source/usbsource.dart';

class USBModel {
  StreamController<List<SongInfo>> songStream = StreamController();

  void query() {
    final usbSrc = USBSource();
    usbSrc.query().then((song) => songStream.add(song!));
  }
}