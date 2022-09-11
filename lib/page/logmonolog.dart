import 'package:pole_dance_club/DataBase/DataBase.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class logmonolog{

  bool adminmod = true;
  String namepage ="NotName";

  logmonolog(String NamePage){
    namepage = NamePage;
    this.Message("logmonolog", "создан класс для работы с логами","Была авторизована страница имя:[$NamePage]", "это просто оповешение о том что класс логов создан");

  }

  void Message(String NameFunc,String NameDescription,String NameEvent,String Message){
    DateTime? data = DateTime.now();
    String a ="Page:[$namepage],Time:[$data],NameFunc["+NameFunc+"],NameDescription:["+NameDescription+"],NameEvent:["+NameEvent+"],Message["+Message+"];";
    if(adminmod == true)
    {
      print(a);
    }
    Log(a);

  }

  Future<void> Log(String Message) async {
    var box = await Hive.openBox(Data_Base.log);
    await box.add(Message);
    await box.close();
  }

  Future<void>Clearlog()async{
    var box = await Hive.openBox(Data_Base.log);
    box.clear();
    box.close();
  }


}