
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

import 'package:pole_dance_club/page/Menu.dart';

//это нужно для ведения логов итд и оповощения админ панели
import 'package:pole_dance_club/page/logmonolog.dart';
//все что нужно для бд
import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


/*
*
class Aboniment extends StatefulWidget {
  const Aboniment({Key? key}) : super(key: key);

  @override
  _AbonimentState createState() => _AbonimentState();
}

class _AbonimentState extends State<Aboniment> {
  //переменная для логов
  logmonolog logm = logmonolog("Aboniment");

  //переменная для бд
  Data_Base Data_Base_work = Data_Base();
  //переменны для данных логин
  int? _NumberAbo;
  String? _NameAbo;
  DateTime? _DateCreate;
  int? _KolVoZan;
  int? _KolVoDay;
  double? _Price;
  HiveList<User>? _Author;
  /*
  * @HiveField(0)
  int NumberAbo;
  @HiveField(1)
  String NameAbo;
  @HiveField(2)
  DateTime DateCreate;
  @HiveField(3)
  int KolVoZan;
  @HiveField(4)
  int KolVoDay;
  @HiveField(5)
  double Price;
  @HiveField(6)
  HiveList<User>? Author;
  *
  * */

  // вспомогательные переменные
  //  File? image;



  CheckInputData() {
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [

            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ключ(Уникальный ключ):" + UserInfo[4].toString()),
                  Text("Автор:" + UserInfo[0]),
                ],),
            ],),

            TextField(decoration: InputDecoration(
              labelText: 'Введите уникальный номер для абонимента',
              filled: true,
              fillColor: Colors.white,
            ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: _ChangeNumberAbo
            ),
            TextField(decoration: InputDecoration(
              labelText: 'Введите название',
              filled: true,
              fillColor: Colors.white,
            ),
                onChanged: _ChangeNameAbo
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите количество занятий',
              filled: true,
              fillColor: Colors.white,
            ),

                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: _ChangeKolVoZan
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите количество дней',
              filled: true,
              fillColor: Colors.white,
            ),

                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: _ChangeKolVoDay
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите стоимость абонимента',
              filled: true,
              fillColor: Colors.white,

            ),


                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: _ChangePrice
            ),

            ElevatedButton(onPressed: () {
              CreateAboniment();
            }, child: Text("Сохранить", style: TextStyle(fontSize: 22),)),
            ElevatedButton(onPressed: () {},
                child: Text("Очистить", style: TextStyle(fontSize: 22),)),
          ],),
        ),
        appBar: AppBar(
          title: Text('CLUB POLE DANCE'),
          centerTitle: true,
        ));
  }

  }
*/

class Aboniment_Creator extends StatefulWidget {
  const Aboniment_Creator({Key? key}) : super(key: key);

  @override
  State<Aboniment_Creator> createState() => _Aboniment_CreatorState();
}

class _Aboniment_CreatorState extends State<Aboniment_Creator> {
  //переменная для логов
  logmonolog logm = logmonolog("Aboniment");




  //переменная для бд
  Data_Base Data_Base_work = Data_Base();
  //переменны для данных (_NumberAbo:[$_NumberAbo],_NameAbo:[$_NameAbo],_DateCreate:[$_DateCreate],_KolVoZan:[$_KolVoZan], _KolVoDay:[$ _KolVoDay],_Price:[$_Price],_Author:[$_Author])
  int? _NumberAbo;
  String? _NameAbo;
  DateTime? _DateCreate;
  int? _KolVoZan;
  int? _KolVoDay;
  double? _Price;
  HiveList<User>? _Author;
  User UserNowPage = User("Не найден", "Не найден", DateTime.now(), "Не найден");

  // вспомогательные переменные
  //  File? image;

  //1) Начало (Блог с функциями)
      //1.1)Начало(функции с по выводу сообщений)(Основа)
          void Toast(String Message){
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(Message),duration: Duration(seconds: 1),));
              print(Message);
          }
      //1.1)Конец
      //1.2)Начало (функции проверки введенных данных)
          int CheckInputDataForEmpty(ObjectChecksName,ObjectChecksData) {
              //имя и описание функции
                  String NameFunc= "CheckInputData";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что :проверяет веденные данные на наличеие пустого текста или null значений";
                  logm.Message(NameFunc,DescriptionFunc,"нажата кнопка сохранить","запущена функция с параметрами(ObjectChecksName:[$ObjectChecksName],ObjectChecks:[$ObjectChecksData])");
              //Переменные функции
                  int _prov = 0;

              //Тело функции
                  if(ObjectChecksData=="" || ObjectChecksData == null){Toast("Запоните $ObjectChecksName!");logm.Message(NameFunc,DescriptionFunc,"нажата кнопка сохранить","$ObjectChecksName не введен");_prov = 1;}
                  return _prov;
          }
          CheckInputDataForFields(){
            //имя и описание функции
                String NameFunc= "CheckInputDataForFields";
                String DescriptionFunc= "Функция $NameFunc занимаеться тем что :проверяет ввели все данные название абонимента,цену,итд";
                logm.Message(NameFunc,DescriptionFunc,"нажата кнопка сохранить","запущена функция с параметрами(_NumberAbo:[$_NumberAbo],_NameAbo:[$_NameAbo],_DateCreate:[$_DateCreate],_KolVoZan:[$_KolVoZan], _KolVoDay:[$_KolVoDay],_Price:[$_Price],_Author:[$_Author])");
            //Переменные функции
                int CounterEmptyData = 0;
            //переменны для данных (_NumberAbo:[$_NumberAbo],_NameAbo:[$_NameAbo],_DateCreate:[$_DateCreate],_KolVoZan:[$_KolVoZan], _KolVoDay:[$ _KolVoDay],_Price:[$_Price],_Author:[$_Author])
            // Тело функции
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_NumberAbo",_NumberAbo);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_NameAbo",_NameAbo);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_DateCreate",_DateCreate);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_KolVoZan",_KolVoZan);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_KolVoDay",_KolVoDay);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_Price",_Price);
                CounterEmptyData = CounterEmptyData + CheckInputDataForEmpty("_Author",_Author);
                if(CounterEmptyData != 0){
                    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка сохранить","Одно из полей не введено количество пустых поле:[$CounterEmptyData]");
                    return false;
                }
                return true;



          }
      //1.2)Окончание(функции проверки введенных данных)
      //1.3 начало(функция для получения данных о пользователе по id)
          Future<User> GetUserInfo(bool UserNow,int id) async {
              //описание функции
                  String NameFunc= "GetUserInfo";
                  String DescriptionFunc= "Функция $NameFunc занимаеться тем что: получает информацию из определенного ящика DataApp о пользователе под ключем UserNow";
                  logm.Message(NameFunc,DescriptionFunc,"нажатие кнопки меню","данная функция запущена");

              // переменные для работы функции
                  int userid = -1;
                  User U = User("Не найден", "Не найден", DateTime.now(), "Не найден");
              //тело функции
                 if(UserNow== true){
                      var box = await Hive.openBox(Data_Base.dataapp);
                      userid = await box.get("UserNow");
                      await box.close();
                      if(userid== null){
                          return U;
                      }
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
      //1.4 начало
       ValueCheck(Value){
         //описание функции
         String NameFunc= "ValueCheck";
         String DescriptionFunc= "Функция $NameFunc занимаеться тем что: получает значение проверяет его на null или пустоту и заменят на нулевое значение которое означает ошибку";
         String NameEvent= "проверка значения элемента для избежания ошибки";
         logm.Message(NameFunc,DescriptionFunc,NameEvent,"данная функция запущена с значениями Value:[$Value]");

         // переменные для работы функции

         //тело функции
            if(Value == null){
                logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value:[$Value] определенно как пустое теперь идет определине типа элемента");
                if(Value.runtimeType == int){
                    logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value:[$Value] тип int будет возвращен [0]");
                    return 0;
                }
                if(Value.runtimeType == String){
                    logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value:[$Value] тип String будет возвращен [Ожидайте...]");
                    return "Ожидайте...";
                }
                if(Value.runtimeType == DateTime){
                    logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value:[$Value] тип DateTime будет возвращен [DateTime.Now]");
                    return DateTime.now();
                }
                if(Value.runtimeType == double){
                  logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value:[$Value] тип double будет возвращен [0.0]");
                  return 0.0;
                }
                logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение Value тип неопределен будет возвращен [$Value]");
                return Value;
            }
         logm.Message(NameFunc,DescriptionFunc,NameEvent,"Значение проверено будет возвращен [$Value]");
         return Value;
      }
      //1.4 конец
  //1) Окончание (Блог с функциями)

  //2)Начало (процедуры страницы)

  //2)Конец (процедуры страницы)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [

            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ключ(Уникальный ключ):" + (UserNowPage.key ?? "Не найден")),
                  Text("Автор:" + UserNowPage.Login ),
                ],),
            ],),

            TextField(decoration: InputDecoration(
              labelText: 'Введите уникальный номер для абонимента',
              filled: true,
              fillColor: Colors.white,
            ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
               // onChanged: _ChangeNumberAbo
            ),
            TextField(decoration: InputDecoration(
              labelText: 'Введите название',
              filled: true,
              fillColor: Colors.white,
            ),
             //   onChanged: _ChangeNameAbo
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите количество занятий',
              filled: true,
              fillColor: Colors.white,
            ),

                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              //  onChanged: _ChangeKolVoZan
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите количество дней',
              filled: true,
              fillColor: Colors.white,
            ),

                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
       //         onChanged: _ChangeKolVoDay
            ),

            TextField(decoration: InputDecoration(
              labelText: 'Введите стоимость абонимента',
              filled: true,
              fillColor: Colors.white,

            ),


                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
          //      onChanged: _ChangePrice
            ),

            ElevatedButton(onPressed: () {
              CheckInputDataForFields();
         //     CreateAboniment();
            }, child: Text("Сохранить", style: TextStyle(fontSize: 22),)),
            ElevatedButton(onPressed: () {},
                child: Text("Очистить", style: TextStyle(fontSize: 22),)),
          ],),
        ),
        appBar: AppBar(
          title: Text('CLUB POLE DANCE'),
          centerTitle: true,
        ));
  }
}
