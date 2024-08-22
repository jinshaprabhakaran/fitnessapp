// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[0] as String,
      phonenumber: fields[1] as dynamic,
      age: fields[2] as dynamic,
      weight: fields[3] as dynamic,
      height: fields[4] as dynamic,
      bloodgroup: fields[5] as String?,
      dp: fields[6] as dynamic,
      dailyStatus: (fields[7] as Map?)?.cast<String, CheckInCheckOutStatus>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phonenumber)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.bloodgroup)
      ..writeByte(6)
      ..write(obj.dp)
      ..writeByte(7)
      ..write(obj.dailyStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CheckInCheckOutStatusAdapter extends TypeAdapter<CheckInCheckOutStatus> {
  @override
  final int typeId = 1;

  @override
  CheckInCheckOutStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckInCheckOutStatus(
      isCheckedIn: fields[0] as bool,
      isCheckedOut: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckInCheckOutStatus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isCheckedIn)
      ..writeByte(1)
      ..write(obj.isCheckedOut);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInCheckOutStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
