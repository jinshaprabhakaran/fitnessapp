import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  dynamic phonenumber;

  @HiveField(2)
  dynamic age;

  @HiveField(3)
  dynamic weight; 

  @HiveField(4)
  dynamic height;

  @HiveField(5)
  String? bloodgroup;

  @HiveField(6)
  dynamic dp;

  @HiveField(7)
  Map<String, CheckInCheckOutStatus>? dailyStatus;

  @HiveField(8)
  List<PaymentHistory>? paymentHistory;

  @HiveField(9)
  bool hasPaidAdvance; // New field to store advance payment status

  @HiveField(10)
  WeightOption? selectedWeightOption; // New field for selected weight option

  UserModel({
    required this.name,
    this.phonenumber,
    this.age,
    this.weight,
    this.height,
    this.bloodgroup,
    this.dp,
    this.dailyStatus,
    this.paymentHistory,
    this.hasPaidAdvance = false, // Default is false (advance not paid)
    this.selectedWeightOption, // Option selected from the list (e.g., cardio)
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

@HiveType(typeId: 2)
class PaymentHistory extends HiveObject {
  @HiveField(0)
  String month;

  @HiveField(1)
  String type; 

  @HiveField(2)
  String status;

  @HiveField(3)
  String date; 

  PaymentHistory({
    required this.month,
    required this.type,
    required this.status,
    required this.date,
  });
}

@HiveType(typeId: 3)
class WeightOption extends HiveObject { 
  @HiveField(0)
  String optionName; 

  @HiveField(1)
  double feeAmount; 

  @HiveField(2)
  double advanceAmount; 

  WeightOption({
    required this.optionName,
    required this.feeAmount,
    required this.advanceAmount,
  });
}
