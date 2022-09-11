// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataBase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.Login)
      ..writeByte(1)
      ..write(obj.Pass)
      ..writeByte(2)
      ..write(obj.Date)
      ..writeByte(3)
      ..write(obj.ImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AbonimentAdapter extends TypeAdapter<Aboniment> {
  @override
  final int typeId = 1;

  @override
  Aboniment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Aboniment(
      fields[0] as int,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as int,
      fields[4] as int,
      fields[5] as double,
      (fields[6] as HiveList?)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Aboniment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.NumberAbo)
      ..writeByte(1)
      ..write(obj.NameAbo)
      ..writeByte(2)
      ..write(obj.DateCreate)
      ..writeByte(3)
      ..write(obj.KolVoZan)
      ..writeByte(4)
      ..write(obj.KolVoDay)
      ..writeByte(5)
      ..write(obj.Price)
      ..writeByte(6)
      ..write(obj.Author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbonimentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 2;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
      fields[4] as DateTime,
      (fields[5] as HiveList?)?.castHiveList(),
      fields[6] as DateTime,
      fields[7] as int,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.NameClient)
      ..writeByte(1)
      ..write(obj.NumberPhoneHome)
      ..writeByte(2)
      ..write(obj.NumberPhone)
      ..writeByte(3)
      ..write(obj.Adress)
      ..writeByte(4)
      ..write(obj.DateCreate)
      ..writeByte(5)
      ..write(obj.Author)
      ..writeByte(6)
      ..write(obj.DateBrithDay)
      ..writeByte(7)
      ..write(obj.Year)
      ..writeByte(8)
      ..write(obj.ImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

