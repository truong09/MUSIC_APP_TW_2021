import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/page/offline_page.dart';
import 'package:my_music_app/page/online_page.dart';
import 'package:my_music_app/page/search_page.dart';
import 'package:my_music_app/widgets/drawer.dart';
import 'package:my_music_app/widgets/minibar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> pages = [OfflinePage(), OnlinePage(), SearchPage(), MPerson()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: pages[_currentIndex]),
        _currentIndex == 3
            ? Container()
            : Positioned(
                child: MiniBar(),
                bottom: 0,
                right: 0,
                left: 0,
              ),
      ])),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Trang chủ'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bar_chart),
            title: Text('BXH'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Tìm kiếm',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Tôi',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
