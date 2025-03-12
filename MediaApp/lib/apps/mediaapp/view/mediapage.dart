import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/core/model/songinfo.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/core/model/usbmodel.dart';
import 'package:Flutter_MusicApp/apps/mediaapp/view/music_playing/playing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SongInfo> songs = [];
  late USBModel _usbModel;

  @override
  void initState() {
    _usbModel = USBModel();
    _usbModel.query();
    observeData();
    super.initState();
  }

  @override
  void dispose() {
    _usbModel.songStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center (
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, position) {
        return getRow(position);
      }, 
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      }, 
      itemCount: songs.length,
      // shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    return Center(
      child: _SongItemSection(parent: this, songInfo: songs[index])
    );
  }

  void observeData(){
    _usbModel.songStream.stream.listen((songList) {
      setState(() {
        songs.addAll(songList);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 400,
            color: Colors.grey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Close')
                  )
                ],
              )
            )
          ),
        );
      }
    );
  }

  void navigate(SongInfo songInfo) {
    Navigator.push(context, 
      CupertinoPageRoute(builder: (context) {
        return MusicPlaying(
          songs: songs,
          playingSong: songInfo,
        );
      })
    );
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({
    required this.parent,
    required this.songInfo,
  });

  final _HomePageState parent;
  final SongInfo songInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 24, right:  16),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/no_image.png', 
          image: songInfo.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/no_image.png',
              width: 48,
              height: 48,
            );
          },
        )
      ),
      title: Text(songInfo.title),
      subtitle: Text(songInfo.artist),
      trailing: IconButton(
        onPressed: () {
          parent.showBottomSheet();
        }, 
        icon: const Icon(Icons.more_horiz)
      ),
      onTap: () {
        parent.navigate(songInfo);
      },
    );
  }
}