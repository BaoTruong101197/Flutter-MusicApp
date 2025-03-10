import 'package:Flutter_MusicApp/data/model/songinfo.dart';
import 'package:Flutter_MusicApp/data/source/source.dart';

abstract interface class BaseRepository {
  Future<List<SongInfo>?> loadData();
}

class Repository implements BaseRepository {
  final _localDataSrc = LocalDataSource();
  final _remoteDataSrc = RemoteDataSource();

  @override
  Future<List<SongInfo>?> loadData() async {
    List<SongInfo> songs = [];
    await _remoteDataSrc.loadData().then((remoteSongs) {
      if (remoteSongs == null) {
        _localDataSrc.loadData().then((localSongs) {
          if (localSongs != null) {
            songs.addAll(localSongs);
          }
        });
      } else {
        songs.addAll(remoteSongs);
      }
    });

    return songs;    
  }
}