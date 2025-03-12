import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/core/model/songinfo.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/core/source/basesource.dart';


class USBSource implements Basesource {

  Future<List<SongInfo>?> query() async {
    final String resp = await rootBundle.loadString('assets/songs.json');
    final contentWrap = jsonDecode(resp) as Map;
    final songsJson = contentWrap['songs'] as List;
    List<SongInfo> songs = songsJson.map((song) => SongInfo.fromJson(song)).toList();
    return songs;
  }
}