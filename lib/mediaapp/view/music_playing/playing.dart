import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:Flutter_MusicApp/mediaapp/core/model/songinfo.dart';
import 'package:Flutter_MusicApp/mediaapp/view/music_playing/audio_player_manager.dart';

class MusicPlaying extends StatelessWidget {
  const MusicPlaying({super.key, required this.songs, required this.playingSong});

  final SongInfo playingSong;
  final List<SongInfo> songs;

  @override
  Widget build(BuildContext context) {
    return MusicPlayingPage(
      songs: songs,
      playingSong: playingSong,
    );
  }
}

class MusicPlayingPage extends StatefulWidget {
  const MusicPlayingPage({super.key, required this.songs, required this.playingSong});

  final SongInfo playingSong;
  final List<SongInfo> songs;

  @override
  State<MusicPlayingPage> createState() => _MusicPlayingPageState();
}

class _MusicPlayingPageState extends State<MusicPlayingPage> with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimCtrl;
  late AudioPlayerManager _audioPlayerManager;

  @override
  void initState() {
    super.initState();
    _imageAnimCtrl = AnimationController(vsync: this, duration: const Duration(microseconds: 12000));
    _audioPlayerManager = AudioPlayerManager(songUrl: widget.playingSong.source);
    _audioPlayerManager.init();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width- 300;
    const delta = 64;
    final radius = (screenWidth - delta) / 2;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Now Playing'
        ),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.playingSong.album),
              const SizedBox(
                height: 16,
              ),
              const Text('_ ___ _'),
              const SizedBox(
                height: 48
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_imageAnimCtrl),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/no_image.png', 
                    image: widget.playingSong.image,
                    width: screenWidth - delta,
                    height: screenWidth - delta,
                    imageErrorBuilder: (context, error, stackStrace) {
                      return Image.asset('assets/no_image.png',
                      width: screenWidth - delta, height: screenWidth - delta);
                    },
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 16),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {}, 
                        icon: const Icon(Icons.share_outlined),
                        color: Theme.of(context).colorScheme.primary
                      ),
                      Column(
                        children: [
                          Text(
                            widget.playingSong.title,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).textTheme.bodyMedium!.color
                            )
                          ),
                          const SizedBox(height: 8,),
                          Text(
                            widget.playingSong.artist,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).textTheme.bodyMedium!.color
                            )
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline),
                        color: Theme.of(context).colorScheme.primary
                      )
                    ],
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 24,
                  right: 24,
                  bottom: 16
                ),
                child: _progressBar(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 24,
                  right: 24,
                ),
                child: _mediaButton(),
              )
            ]
          )
        )
      )
    );
  }

  Widget _mediaButton() {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(function: null, icon: Icons.shuffle, color: Colors.deepPurple, size: 24),
          MediaButtonControl(function: null, icon: Icons.skip_previous, color: Colors.deepPurple, size: 36),
          MediaButtonControl(function: null, icon: Icons.play_arrow_sharp, color: Colors.deepPurple, size: 48),
          MediaButtonControl(function: null, icon: Icons.skip_next, color: Colors.deepPurple, size: 36),
          MediaButtonControl(function: null, icon: Icons.repeat, color: Colors.deepPurple, size: 24),
        ],
      )
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(progress: progress, total: total);
      }
    );
  }
}

class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl({super.key, this.function, required this.icon, this.size, this.color});

  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  State<MediaButtonControl> createState() => _MediaButtonControlState();
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.function, 
      icon: Icon(widget.icon),
      iconSize: widget.size,
      color: widget.color ?? Theme.of(context).colorScheme.primary
    );
  }
}