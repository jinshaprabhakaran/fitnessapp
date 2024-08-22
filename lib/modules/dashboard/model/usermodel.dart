import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

   @HiveField(1)
  dynamic   phonenumber;

  @HiveField(2)
  dynamic age;
   @HiveField(3)
  dynamic weight;

  @HiveField(4)
  dynamic height;
   @HiveField(5)
  String ? bloodgroup;
 @HiveField(6)
  dynamic dp;
  @HiveField(7)
 Map<String, CheckInCheckOutStatus> ? dailyStatus;

  UserModel({
    required this.name,
   this.phonenumber,
    this.age,
   this.weight,
     this.height,
      this.bloodgroup,
       this.dp,this.dailyStatus
  });
  
}

@HiveType(typeId: 1)
class CheckInCheckOutStatus extends HiveObject {
   @HiveField(0)
  bool isCheckedIn;
  @HiveField(1)
  bool isCheckedOut;

  CheckInCheckOutStatus({
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  });
}


 
