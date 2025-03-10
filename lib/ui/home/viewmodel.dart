import 'dart:async';

import 'package:Flutter_MusicApp/data/model/songinfo.dart';
import 'package:Flutter_MusicApp/data/repository/repository.dart';

class ViewModel {
  StreamController<List<SongInfo>> songStream = StreamController();

  void loadData() {
    final repo = Repository();
    repo.loadData().then((song) => songStream.add(song!));
  }
}