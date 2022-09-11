import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

//все что нужно для бд
import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//это нужно для ведения логов итд и оповощения админ панели
import 'package:pole_dance_club/page/logmonolog.dart';


class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {


  logmonolog logm = logmonolog("Menu");
  //переменная для бд
  Data_Base Data_Base_work = Data_Base();

  List UserInfo=['Ожидайте...','Ожидайте...','Ожидайте...','Ожидайте...','Ожидайте...'];
  User UserNowPage = User("Не найден", "Не найден", DateTime.now(), "Не найден");



  File? image;

  _MenuDrawerState() {
    //GetUserInfo();
   UserNowUprageTest();
  }

  UserNowUprageTest()async{
   // UserNowPage = await GetUserInfoTest(true, 0);

  }
  void GetUserInfo()async{
//описание функции
    String NameFunc= "GetUserInfo";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что: получает информацию из определенного ящика DataApp о пользователе под ключем UserNow";
    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","данная функция запущена");

// переменные для работы функции в самой функции





    var box = await Hive.openBox(Data_Base.dataapp);
    int userid = await box.get("UserNow");
    await box.close();
    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","получен ключ пользователя который входил userid:[$userid]");

    box = await Hive.openBox(Data_Base.user);
    User a = await box.get(userid);
    UserInfo = a.DataExport();
    UserInfo.add(a.key);
    if(a.ImagePath != "0"){
      logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","картинка есть начат поиск по данным UserInfo:[$UserInfo]");
      final imageTemporary = File(UserInfo[3]);
      try {
        setState(() => this.image = imageTemporary);
      }
      on PlatformException catch (e){print('ERROR');}
    }
    else{
      logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","картинки нет обновленны данные по данным UserInfo:[$UserInfo]");
      setState(() {});
    }
    await box.close();
    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","получен пользователь по ключу:[$userid] который входил.Пользователь UserInfo:[$UserInfo]");

  }

  //1.3 начало(функция для получения данных о пользователе по id)
  Future<User> GetUserInfoTest(bool UserNow,int id) async {
    //описание функции
    String NameFunc= "GetUserInfoTest";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что: получает информацию из определенного ящика DataApp о пользователе под ключем UserNow";
    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","данная функция запущена");

    // переменные для работы функции
    int userid = -1;
    User U = User("Не найден!", "Не найден!", DateTime.now(), "Не найден!");
    //тело функции
    if(UserNow== true){
      await Duration(seconds: 10);
      var box = await Hive.openBox(Data_Base.dataapp);
      if(box.length != 0){
          userid = await box.get("UserNow");
      }
      else{
        await Duration(seconds: 10);
          logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","Пользователь не найден возвращаем[$U]");
          return U;
      }
      await box.close();

    }
    else{
      userid = id;
    }



    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки сохранить","получен ключ пользователя который входил userid:[$id]");
    var box = await Hive.openBox(Data_Base.user);
    U = await box.get(id);
    await box.close();
    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","получен пользователь по ключу:[$id] который входил.Пользователь UserInfo:[$U]");
    return U;
  }
  //1.3 конец



  @override

  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          children: <Widget>[
            new DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Colors.blue),
              child: UserAccountsDrawerHeader (
                decoration: BoxDecoration(color: Colors.blue.shade300),
                accountName: Text('ФИО:'+UserNowPage.Login),
                accountEmail: Text("Уникальны ключ:"+(UserNowPage.key ?? "Не наден")),
                currentAccountPicture: Container(
                  child: image != null ? Image.file(image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ):FlutterLogo(size: 160,)
                ),
              ),
            ),
            new ListTile(
                title: new Text("Ученики"),
                leading: Icon(Icons.account_box),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Ученики]");
                  Navigator.pushNamed(context, '/Client_list');
                }
            ),

            new ListTile(
                title: new Text("Клиенты (ТЕСТОВОЕ)"),
                leading: Icon(Icons.alternate_email_rounded),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Клиенты (ТЕСТОВОЕ)]");

                  Navigator.pushNamed(context, '/Client_cre');
                }
            ),



            new ListTile(
                title: new Text("Абонименты редактор (ТЕСТОВОЕ)"),
                leading: Icon(Icons.alternate_email_rounded),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Абонименты редактор (ТЕСТОВОЕ)]");
                  Navigator.pushNamed(context, '/Abo_cre');
                }
            ),

            new ListTile(
                title: new Text("Абонементы"),
                leading: Icon(Icons.list),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Абонименты]");

                  Navigator.pushNamed(context, '/Abo_list');
                }
            ),

            new ListTile(
                title: new Text("Продажи Абониментов"),
                leading: Icon(Icons.monetization_on),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Продажи Абониментов]");
                  Navigator.pushNamed(context, '/Client_list');
                }
            ),


            new ListTile(
                title: new Text("Помощь"),
                leading: Icon(Icons.help),
                onTap: (){

                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Помощь]");

                  Navigator.pushNamed(context, '/help');
                }
            ),

            new ListTile(
                title: new Text("Окно приветсвия (ТЕСТОВОЕ)"),
                leading: Icon(Icons.alternate_email_rounded),
                onTap: (){
                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Окно приветсвия (ТЕСТОВОЕ)]");

                  Navigator.pushNamed(context, '/SplashScreen');
                }
            ),

            new ListTile(
                title: new Text("Статистика"),
                leading: Icon(Icons.info),
                onTap: (){

                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Статистика]");


                  Navigator.pushNamed(context, '/Stat');
                }
            ),

            new ListTile(
                title: new Text("Войти"),
                leading: Icon(Icons.assistant_photo),
                onTap: (){

                  String NameFunc= "OnTap";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: срабатывает при клике пункта меню";
                  logm.Message(NameFunc,DescriptionFunc,"клик по пункту меню","был совершен клик по пункту меню:[Войти]");

                  Navigator.pushNamed(context, '/Auth');
                }
            ),

          ],
        ),
      );
  }
}
