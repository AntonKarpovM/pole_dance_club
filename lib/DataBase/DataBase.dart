import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'DataBase.g.dart';

///список ебанных ящиков [TestBox](описание:{Тестовый ящик с юзерами})
///

// здесь напиханы класы для псевдо работы таблицы в целом база работает как говно

  //только для инициазилации hive
  class Data_Base extends ReadWriter {
    //именна боксов для обращения
    static String user = "user_box";//бокс с пользователями
    static String client = "client_box";//бокс с клиентами
    static String abonement = "abonement_box";//бокс с абониментами
    static String discounts = "discounts_box";//бокс со скидкдами
    static String sale = "sale_box";//бокс в котором зафиксированна продажа абонимента клиенту имеет следующию структуру (ключ пользователя,ключ клиента,ключ обонимента,цена обонимента,ключ скидки,условия скидки,sold for продана за[цена с учетом скидки],дата оформления)
    static String log = "log_box";//бокс с логами
    static String dataapp = "dataapp_box";//бокс с данными приложения изменяеться после каждого входа


    //инициализация
  Data_Base(){
    Start();
  }

  //Функция
  void Start()async{
    String NameT = "Function";
    String Name = "Start";
    Message(NameT,Name,"Инициализация HIVE");
  }






  Future< List<List<dynamic>>> Date_Base_Stat() async{
    String Name = "Date_Base_User";
    List<List<dynamic>> DataExport = [];
    DataExport.add(["test","test"]);
    DataExport.add(["Размер бд(мб):",]);
    DataExport.add(["Кол-во акк:",132]);
    DataExport.add(["Кол-во клиентов:",132]);
    DataExport.add(["Кол-во абониментов:",132]);
    DataExport.add(["последние внесение в бд:",132]);
    DataExport.add(["Послдняя выгрузка бд:",132]);
    return DataExport;
  } //не работает срет псевдо таблицей


}
  //псевдо класс параши для записи чтения итд переполнен говном
  class ReadWriter{



    var box;




  Future Read_and_get_box(String NameBox)async{
    String NameT = "Function";
    String Name = "Read[Read_and_get_box]";

    box = await Hive.openBox(NameBox);

    Message(NameT,Name, "Вытащили данные из тестовой таблицы ($NameBox)");
    return  box;
  }





// я как даун занес "NameBox" в боксы
  void Write(var ObjectAdd,String NameBox) async{
    String NameT = "Function";
    String Name = "Write[ReadWriter]";
    box = await Hive.openBox(NameBox);
    box.add(ObjectAdd);

    Message(NameT,Name, "открыли тест таблицу($NameBox ) и записали ($ObjectAdd)");

  }


  void WriteDataBaseObject(var ObjectAdd,String NameBox) async{
    String NameT = "Function";
    String Name = "Write[ReadWriter]";
    box = await Hive.openBox(NameBox);
    box.add(ObjectAdd.key);
User Man = User('Login', 'Pass', DateTime.now(), 'ImagePath');
Man.key;
    Message(NameT,Name, "открыли тест таблицу($NameBox ) и записали ($ObjectAdd)");

  }


  void ClosedBox(String NameBox){
   Hive.box(NameBox).close();
  }

  void DeliteBox(String NameBox){
    Hive.deleteBoxFromDisk(NameBox);
  }

  Future<int> BoxLength(String NameBox) async {
    if(!Hive.isBoxOpen(NameBox)){box = await Hive.openBox(NameBox);}
    return box.length;
  }


  void WritePut(var ObjectAdd,String NameBox,String ID) async{
    String NameT = "Function";
    String Name = "Write[ReadWriter]";
    box = await Hive.openBox(NameBox);
    box.put(ID,ObjectAdd);

    Message(NameT,Name, "открыли тест таблицу($NameBox ) и записали ($ObjectAdd)");

  }


  Future <dynamic> ReadID(String NameBox,ID)async{
    String NameT = "Function";
    String Name = "Read[ReadWriter]";
    dynamic ObjectReturn;
    box = await Hive.openBox(NameBox);
    ObjectReturn = box.get(ID);


    Message(NameT,Name, "Вытащили данные из тестовой таблицы ($NameBox)");
    return ObjectReturn;
  }


}
///
//здесь собраны адаптеры которые нужно для работы и фунционала базы изминяя их изменяй и адаптатеры в g.dart созданный автоматически

  //Юзер
  @HiveType(typeId: 0)
  class User extends HiveObject {
  @HiveField(0)
  String Login;
  @HiveField(1)
  String Pass;
  @HiveField(2)
  DateTime Date;
  @HiveField(3)
  String ImagePath;

  User(this.Login,this.Pass,this.Date,this.ImagePath);

  @override
  //методы
  String  toString() => "$Login):Pass( $Pass):Date( $Date):ImagePath( $ImagePath)";


  List<dynamic> DataExport() => [Login,Pass,Date,ImagePath];
}
  //Абонименты
  @HiveType(typeId: 1)
  class Aboniment extends HiveObject{
  @HiveField(0)
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




  Aboniment(this.NumberAbo,this.NameAbo,this.DateCreate,this.KolVoZan,this.KolVoDay,this.Price,this.Author);

  @override
  String  toString() => "Номер($NumberAbo):Имя( $NameAbo):Date( $DateCreate):Количество занятий( $KolVoZan):Количество дней($KolVoDay):Цена($Price):Автор($Author)";

  List<dynamic> DataExport() => [NumberAbo,NameAbo,DateCreate,KolVoZan,KolVoDay,Price,Author];
}
  //Клиенты
  @HiveType(typeId: 2)
  class Client extends HiveObject{
  @HiveField(0)
  String NameClient;
  @HiveField(1)
  int NumberPhoneHome;
  @HiveField(2)
  int NumberPhone;
  @HiveField(3)
  String Adress;
  @HiveField(4)
  DateTime DateCreate;
  @HiveField(5)
  HiveList<User>? Author;
  @HiveField(6)
  DateTime DateBrithDay;
  @HiveField(7)
  int Year;
  @HiveField(8)
  String ImagePath;




  Client(this.NameClient,this.NumberPhoneHome,this.NumberPhone,this.Adress,this.DateCreate,this.Author,this.DateBrithDay,this.Year,this.ImagePath);

  @override
  String  toString() => "Номер домашний($NumberPhoneHome):Имя( $NameClient):Date( $DateCreate):Номер Мобильника( $NumberPhone):Адресс($Adress):Дата Рождения($DateBrithDay):Автор($Author):Количество лет($Year):Картинка($ImagePath)";

  List<dynamic> DataExport() => [NameClient,NumberPhoneHome,NumberPhone,Adress,DateCreate,Author,DateBrithDay,Year,ImagePath];
}



///
//функции необходимые для работы проверенные

  //данная функция помогает отслеживать что откуда пришло и куда течет для получения данных
  void Message(String NT,NF,Mess) async {
  print('Тип обьекта($NT):Название($NF):Сообщенние($Mess)');
}
///
///
///
