import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

//это нужно для ведения логов итд и оповощения админ панели
import 'package:pole_dance_club/page/logmonolog.dart';
//все что нужно для бд
import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';




class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //переменная для логов
  logmonolog logm = logmonolog("Registration");

  //переменная для бд
  Data_Base Data_Base_work = Data_Base();
  //переменны для данных логин
  String? _Login;
  String? _Pass;
  DateTime? _Data;
  String? _ImagePath;
  // вспомогательные переменные
  File? image;



  ProvAuth() {
    //имя и описание функции
    String NameFunc= "ProvAuth";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что :проверяет ввели логин или пароль";
    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass],_ImagePath:[$_ImagePath])");


    bool _prov = true;
    if(_Login=="" || _Login == null){Toast("Запоните Логин!");logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","логин не введен");_prov = false;}
    if(_Pass=="" || _Pass == null){Toast("Запоните Пароль!");logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","логин не введен");_prov = false;}
    //основная проверка    if(NonImage){if(_ImagePath=="" || _ImagePath == null){Toast("Запоните Фото!");print('Запоните Фото!');_prov = false;}}
    //проверка с возможностью отказаться от фото
    if(_ImagePath=="" || _ImagePath == null){_ImagePath = "0";logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","Картинке нет присвоен 0");}
    return _prov;
  }

  void CreateUser()async{
    //имя и описание функции
    String NameFunc= "CreateUser";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что :Записывает нового пользователя в бокс";
    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(Date:[$_Data],_Login:[$_Login],_Pass:[$_Pass],_ImagePath:[$_ImagePath])");



    var box = await Hive.openBox(Data_Base.user);

    if(ProvAuth()){
      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","пройдена проверка со следующими параметрами(Date:[$_Data],_Login:[$_Login],_Pass:[$_Pass],_ImagePath:[$_ImagePath])");

      if(await SearchUser()== null){

        await box.add(User(_Login!,_Pass!, _Data!, _ImagePath!));
        Toast("Записал");
        await box.close();
      }
      else{
        Toast("Такой пользователь уже есть");
      }

    }
    else{

      Toast("Не записал");
    }
  }



  Future<int?> SearchUser()async{
    String NameFunc= "SearchUser";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что :ищет пользователя в боксе";
    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass])");



    var box = await Hive.openBox(Data_Base.user);
    if(ProvAuth()){

      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass]) проверка пройдена ");

      User FindUser ;
      for(int n = 0; n< box.length;n++)
      {
        FindUser = await box.getAt(n);
        if(FindUser.Login==_Login && FindUser.Pass==_Pass){

          logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass]) и пользователь найден но учитывая что мы регистрируем пользователя это плохо");

          Toast("нашел");

          return FindUser.key;
        }

      }


    }
    else{

      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass]) и пользователь найден но учитывая что мы регистрируем пользователя этого не должно прозоти СМОТРИ ЛОГИ");

      Toast('Что-то упустили');
    }

    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(_Login:[$_Login],_Pass:[$_Pass]) и пользователь найден но учитывая что мы регистрируем пользователя это хорошо");

    Toast("не нашел");
    return null;
  }


  Future pickImage(ImageSource source) async{
//это часть описывает функцию
    String NameFunc= "pickImage";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что :дают нам картинку которую мы можем использвать";
    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","запущена функция с параметрами(source:[$source])");
//это часть содержит все переменный которыми оперирует функция

//это тело функции где происходит манипуляции входными данными и перемеными и глоюальными переменными
    try
    {

      final image = await ImagePicker().pickImage(source: source);
      if(image==null)return;
      final path = await getApplicationDocumentsDirectory();
      final pathStr = path.path;
      Toast(pathStr);
      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","Мы получаем путь картинки(pathStr:[$pathStr])");
      final fileName = image.name;
      await image.saveTo('$pathStr/$fileName');
      final imageTemporary = File('$pathStr/$fileName');
      Toast('$pathStr/$fileName');
      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","Мы получаем путь картинки и название(pathStr:[$pathStr/$fileName])");
      _ImagePath ='$pathStr/$fileName';
      setState(() => this.image = imageTemporary);
    }
    on PlatformException catch (e)
    {
      logm.Message(NameFunc,DescriptionFunc,"нажата кнопка зарегистрировать","Прблема возникла:$e");

      Toast('Прблема возникла:$e');

    }
  }

  _changeLogin(String text){
    setState(() =>_Login = text);
  }

  _changePass(String text){
    setState(() =>_Pass = text);
  }

  //message function
  void Toast(String Message){
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(Message),duration: Duration(seconds: 1),));
    print(Message);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child:  Column(children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image != null ? Image.file(image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ):FlutterLogo(size: 160,),
                Text("Выберите фото(пожеланию)"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: ()=>pickImage(ImageSource.camera), child:Text("Камера", style: TextStyle(fontSize: 22),)),
                    ElevatedButton(onPressed: ()=>pickImage(ImageSource.gallery), child:Text("Галерея", style: TextStyle(fontSize: 22),)),

                  ],),
              ],),


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
              ElevatedButton(onPressed: (){_Data=DateTime.now();CreateUser();logm.Message("onPressed button","фукнция при нажатие кнопки создать","нажатие кнопки","Вы нажали войти идет проверка данных");}, child:Text("Создать", style: TextStyle(fontSize: 22),)),

            ),


            Container(
                margin: EdgeInsets.only(top: 10),
                child:
                ElevatedButton(
                    onPressed: (){Navigator.pushNamed(context, '/Auth');},
                    child:Text("Авторизоваться", style: TextStyle(fontSize: 22),)

                )

            ),



          ],),
        ),
        appBar: AppBar(
          title: Text('CLUB POLE DANCE'),
          centerTitle: true,
        ));
  }

}

