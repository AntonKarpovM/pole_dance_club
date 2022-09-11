import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//это нужно для ведения логов итд и оповощения админ панели
import 'package:pole_dance_club/page/logmonolog.dart';

//все что нужно для бд
 import 'package:pole_dance_club/DataBase/DataBase.dart';
 import 'package:hive/hive.dart';
 import 'package:hive_flutter/hive_flutter.dart';




class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {

  logmonolog logm = logmonolog("Authorization");
  //переменная для бд
  Data_Base Data_Base_work = Data_Base();
  //переменны для данных логин
  String? _Login;
  String? _Pass;



  ProvAuth() {

    String NameFunc= "ProvAuth";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что: проверяет введенные данные пользователя";

    bool _prov = true;
    if(_Login=="" || _Login == null){
      logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки войти","Логин не заполнен");
      Toast("Запоните Логин!");
      _prov = false;
    }
    if(_Pass=="" || _Pass == null){
      Toast("Запоните Пароль!");
      logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки войти","Пароль не заполнен");
      _prov = false;}
    return _prov;
  }


  Future<int?> SearchUser()async{

    String NameFunc= "SearchUser";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что: ищет пользователя по в веденным данным в ящике hive на данный момент работает с данными login:[$_Login],pass:[$_Pass]";


    var box = await Hive.openBox(Data_Base.user);

      User FindUser ;
        for(int n = 0; n< box.length;n++)
        {

          FindUser = await box.getAt(n);
          if(FindUser.Login==_Login && FindUser.Pass==_Pass){

            Toast("нашел");
            logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки войти","Нашел пользователя");


            return FindUser.key;
          }

        }

    logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки войти","не нашел пользователя");
    Toast("не нашел");
    return null;
  }

 void Coming() async {

   String NameFunc= "Coming";
   String DescriptionFunc= "Функция $NameFunc занимаеться тем что проверяет введенные данные и записывает пользователя для дальнейшего использованиея программой на данный момент работает с данными login:[$_Login],pass:[$_Pass]";


   if(ProvAuth()) {
     int? FindUser = await SearchUser();
     if (FindUser != null) {
       logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки войти","пользователь есть данные пользователя:[$FindUser]");
       Toast("пользователь найден");

       var box = await Hive.openBox(Data_Base.dataapp);
       await box.put("UserNow",FindUser);
       await box.close();
       //Data_Base_work.WritePut(FindUser, 'DataApp', 'DataAppMenu');
       Navigator.pushNamed(context, '/help');
     }
     else {
       logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки","пользователь не наден $FindUser");
       Toast("пользователь не наден");
     }
   }
}


  _changeLogin(String text){
    setState(() =>_Login = text);
  }

  _changePass(String text){
    setState(() =>_Pass = text);
  }


//message function



  void Toast(String tmessage){
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(tmessage),duration: Duration(seconds: 1),));
  }




  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child:  Column(
            children: [


            TextField( decoration: InputDecoration(
              labelText: 'Логин',
              filled: true,
              fillColor: Colors.white,

            ),
                onChanged: _changeLogin
            ),
            TextField(

                decoration: InputDecoration(
                  labelText: 'Пароль',
                  filled: true,
                  fillColor: Colors.white,

                ),

              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: _changePass



            ),


Container(
  margin: EdgeInsets.only(top: 10),
  child:
    ElevatedButton(
      onPressed: (){Coming();logm.Message("onPressed button","фукнция при нажатие кнопки войти","нажатие кнопки","Вы нажали войти идет проверка данных");},
      child:Text("Войти", style: TextStyle(fontSize: 22),)
  )

),

      Container(
        margin: EdgeInsets.only(top: 10),
        child:
        ElevatedButton(onPressed: (){logm.Message("onPressed button создать","фукнция при нажатие кнопки войти","нажатие кнопки","Вы нажали зарегистрировать переходите на страницу регистрации");Navigator.pushNamed(context, '/Reg');}, child:Text("Зарегистрировать", style: TextStyle(fontSize: 22),)),

      ),

          ],),
        ),
        appBar: AppBar(
          title: Text('CLUB POLE DANCE'),
          centerTitle: true,
        ));
  }
}

