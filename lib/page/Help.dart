import 'package:flutter/material.dart';
import 'package:pole_dance_club/page/Menu.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
  //здесь активируеться меню
        drawer: MenuDrawer(),
        body: Container(child: Center(child: Text('Нету помощи!!'),),),
        appBar: AppBar(
    title: Text('CLUB POLE DANCE'),
    centerTitle: true,
    ));
  }
}