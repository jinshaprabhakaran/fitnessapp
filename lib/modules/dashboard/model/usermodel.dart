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
  List<PaymentHistory>? paymentHistory; // New field to store payment history

  UserModel({
    required this.name,
    this.phonenumber,
    this.age,
    this.weight,
    this.height,
    this.bloodgroup,
    this.dp,
    this.dailyStatus,
    this.paymentHistory, // Added to constructor
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

@HiveType(typeId: 2) // New type for payment history
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
