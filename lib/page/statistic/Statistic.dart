import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pole_dance_club/page/Menu.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;


//все что нужно для бд
import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//это нужно для ведения логов итд и оповощения админ панели
import 'package:pole_dance_club/page/logmonolog.dart';



class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {

  //переменная для логов
  logmonolog logm = logmonolog("Statistic");


  Data_Base Data_Base_work = Data_Base();

  File? image;

  DateTime selectedDateEnd = DateTime.now();

  DateTime selectedDateStart = DateTime.now();

  String NameTable = "НЕ ВЫБРАНА";

  List<List<dynamic>> data = [];



void selectDate(BuildContext context,But)async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day));
    if (picked != null && picked != selectedDate) {
      setState(() {

        if(But == 1)
        {

          if(picked.millisecondsSinceEpoch >= selectedDateStart.millisecondsSinceEpoch)
            {
              selectedDateEnd = picked;
            }
          else
            {
              selectedDateEnd= DateTime.now();
              print("Ошибка");
            }
        }
        else
        {
          selectedDateStart = picked;
        }
      });
    }

  }

  Future< List<List<dynamic>>> Read(String NameBox)async{
    //имя и описание функции
    String NameFunc= "Read";
    String DescriptionFunc= "Функция $NameFunc занимаеться тем что :показывает данные из бокса";
    logm.Message(NameFunc,DescriptionFunc,"нажата кнопка связанная с таблицами","На данный момент получаем данные из бокса под именем:[$NameBox])");

    var box;
    List<List<dynamic>> DataExport = [];
    box = await Hive.openBox(NameBox);
    int BoxL = box.length;
    while(BoxL>0)
    {
      BoxL = BoxL -1;
      List KeyAdd = box.getAt(BoxL)?.DataExport();
      KeyAdd.add(box.getAt(BoxL)?.key);
      DataExport.add(KeyAdd);

    }
    return DataExport;
  }


  void loadAsset() async {
    final myData = await rootBundle.loadString("csvTable/testRead.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    data = csvTable;

  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MenuDrawer(),
        body:SingleChildScrollView(
          child:  Column(children: [

          Container(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Выберите времменой промежуток для таблиц:'),
                    Row(children: [

                       Text('Дата с'),
                         ElevatedButton(
                             onPressed: (){ selectDate(context,0);},
                              child: Text("${selectedDateStart.toLocal()}".split(' ')[0]),
                         ),
                       Text('Дата до'),
                       ElevatedButton(
                          onPressed: () {selectDate(context,1);},
                          child: Text("${selectedDateEnd.toLocal()}".split(' ')[0]),
                        ),

                    ],),

                  Text("Выбери желаемую таблицу:"),
            Container(
              margin: EdgeInsets.only(top: 10),
              child:
                  ElevatedButton(onPressed: () async {

                    NameTable = "Статистика БД";

                    final UserInf= await Read("TestBox");
                    final AboInf= await Read("TestBoxAboniment");
                    final CliInf= await Read("TestBoxClient");
                    data.clear();
                    data.add(["Общие количество записей:",UserInf.length+AboInf.length+CliInf.length]);
                    data.add(["Кол-во акк:",UserInf.length]);
                    data.add(["Кол-во клиентов:",CliInf.length]);
                    data.add(["Кол-во абониментов:",AboInf.length]);
                    data.add(["Кол-во (оформлений) Абониментов:",0]);
                    data.add(["последние внесение в бд:",0]);
                    data.add(["Послдняя выгрузка бд:",0]);




                    setState(() {

                    });


                  }, child:Text("Статистика БД", style: TextStyle(fontSize: 17),)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child:
                  ElevatedButton(onPressed: () async {

                    NameTable = "Список пользователей";

                    data.clear();
                    // пречень боксов ({TestUser}{NameBox})
                    //первая запись в бд
                    //   Data_Base_work.Write(User("Anton", "123", 310798),"TestUser");
                    data.add(['фио','Пароль','Дата регистрации','картинка','ID пользователя']);
                    data += await Read(Data_Base.user);


                    print(data);



                    setState(() {

                    });
                  }, child:Text("Список пользователей", style: TextStyle(fontSize: 17),)),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child:
                  ElevatedButton(onPressed: () async {

                    NameTable = "Список клиентов";

                    data.clear();
                    // пречень боксов ({TestUser}{NameBox})
                    //первая запись в бд
                    //   Data_Base_work.Write(User("Anton", "123", 310798),"TestUser");
                    data = await Read("TestBoxClient");

                    print(data);


                    setState(() {

                    });
                    print(data);
                  }, child:Text("Список клиентов", style: TextStyle(fontSize: 17),)),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child:
                  ElevatedButton(onPressed: () async {

                    NameTable = "Список абониментов";

                    data.clear();
                    // пречень боксов ({TestUser}{NameBox})
                    //первая запись в бд
                    //   Data_Base_work.Write(User("Anton", "123", 310798),"TestUser");
                    data = await Read("TestBoxAboniment");

                    print(data);

                    setState(() {

                    });
                    print(data);
                  }, child:Text("Список абониментов", style: TextStyle(fontSize: 17),)),
            ),

                  Text("Выполнить дествие:"),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child:
                    ElevatedButton(onPressed: () async {
                      setState(() {});
                      print(data);
                    }, child:Text("Эксп БД", style: TextStyle(fontSize: 17),)),
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      child:
                    ElevatedButton(onPressed: () async {
                      setState(() {});
                      print(data);
                    }, child:Text("Эксп Табл", style: TextStyle(fontSize: 17),)),
                    ),

                    Container(
                      margin: EdgeInsets.all(10)  ,
                      child:
                    ElevatedButton(onPressed: () async {
                      setState(() {});
                      print(data);
                    }, child:Text("Импорт БД", style: TextStyle(fontSize: 17),)),
                    ),

                  ],),
                ],),



          ),

            Text("ТАБЛИЦА($NameTable)"),
            Table(

            border: TableBorder.all(width: 1.0),
            children: data.map((item) {
              return TableRow(
                  children: item.map((row) {
                    return Container(
                      color:
                      row.toString().contains("NA") ? Colors.red : Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          row.toString(),
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ),
                    );
                  }).toList());
            }).toList(),
          ),


           ],),
        ),
        appBar: AppBar(
          title: Text('CLUB POLE DANCE'),
          centerTitle: true,
        ));
  }

}

