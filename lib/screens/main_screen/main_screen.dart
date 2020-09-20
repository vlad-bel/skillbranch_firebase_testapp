import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildLogoSliver(),
          _buildUserList(),
        ],
      ),
    );
  }

  Widget _buildLogoSliver() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          top: 32,
          left: 16,
          bottom: 8,
        ),
        child: Text('Пользователи'),
      ),
    );
  }

  Widget _buildUserList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          ///build user item
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.network(
                  "https://www.shareicon.net/data/512x512/2017/01/06/868320_people_512x512.png",
                  height: 200,
                ),
                Text("user_name"),
                Text("user_phone")
              ],
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
