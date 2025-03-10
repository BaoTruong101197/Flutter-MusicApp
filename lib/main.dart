import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Flutter_MusicApp/ui/account/account.dart';
import 'package:Flutter_MusicApp/ui/discovery/discovery.dart';
import 'package:Flutter_MusicApp/ui/settings/settings.dart';
import 'package:Flutter_MusicApp/ui/home/home.dart';

void main() {
  runApp(MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      home: MainApp(),
      debugShowCheckedModeBanner: false,
    ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Widget> _tabs = [
    const HomePage(),
    const DiscoveryPage(),
    const AccountPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.blue,
        middle: const Text(
          'Music App',
          style: TextStyle(color: Colors.black),
        ),
        border: null,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.album), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ]
        ), 
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        }
      )
    );
  }
}