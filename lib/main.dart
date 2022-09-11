import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:pole_dance_club/page/authorization/Authorization.dart';
import 'package:pole_dance_club/page/authorization/Registration.dart';
import 'package:pole_dance_club/page/statistic/Statistic.dart';
import 'package:pole_dance_club/page/aboniment/Aboniment_creator.dart';



import 'package:pole_dance_club/page/Help.dart';
import 'package:pole_dance_club/page/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AbonimentAdapter());
  Hive.registerAdapter(ClientAdapter());


  print("Hive инициализирован!");
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
    ),

    initialRoute: '/Abo_cre',// здесь должно быть скрин приложения/SplashScreen
    routes: {
      '/SplashScreen':(context)=> SplashScreen(nextRoute: '/Auth'),//должен быть /Auth но значение меняеться в зависимости от тестируемого обьеката
      '/help':(context)=> Help(),
      '/Reg':(context)=> Registration(),
      //'/Client_Read':(context)=> Client_ReaderBuy(),
      '/Auth':(context)=> Authorization(),
      '/Stat':(context)=> Statistic(),
      //'/Client_list':(context)=> Client_list(),
      //'/Abo_list':(context)=> Aboniment_list(),
      //'/Client_cre':(context)=> Client_creator(),
      '/Abo_cre':(context)=> Aboniment_Creator(),
    },
  ));
}


