import 'package:flutter/material.dart';
import './login.dart';
import './register.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Login Page'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Existing',
              ),
              Tab(
                text: 'New',
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[LoginPage(),RegisterPage()],
        ),
      ),
    );
  }
}