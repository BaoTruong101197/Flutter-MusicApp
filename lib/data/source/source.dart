import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:Flutter_MusicApp/data/model/songinfo.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<SongInfo>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<SongInfo>?> loadData() async {
    const api = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(api);
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final content = utf8.decode(resp.bodyBytes);
      var contentWrap = jsonDecode(content) as Map;
      var songsJson = contentWrap['songs'] as List;
      List<SongInfo> songs = songsJson.map((song) => SongInfo.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<SongInfo>?> loadData() async {
    final String resp = await rootBundle.loadString('assets/songs.json');
    final contentWrap = jsonDecode(resp) as Map;
    final songsJson = contentWrap['songs'] as List;
    // print(songsJson);
    List<SongInfo> songs = songsJson.map((song) => SongInfo.fromJson(song)).toList();
    return songs;
  }
}