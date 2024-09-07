
import 'dart:io';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/global/constants/db_key.dart';
import 'package:fitnessappadmin/modules/dashboard/model/usermodel.dart';
import 'package:fitnessappadmin/modules/dashboard/view/attendance_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/registration_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/users_list_screen.view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widget/registration_data.widget.dart';
import '../widget/upload_photo.widget.dart';

class DashBoardController extends ChangeNotifier{
 
 // controllers
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController bloodCtrl = TextEditingController();

  // bottom navigation bar screens
  List screens = [const AttendanceScreen(),const RegistrationScreen(),const UsersListScreen()];

// selecting the index(bottom navigation)
  int selectedIndex = 0;
setIndex(int index){
selectedIndex = index;
notifyListeners();
}



// page controller for pageview

final PageController pageController = PageController(initialPage: 0);
  int currentpage = 0;
  setPage(int value){
    currentpage = value;
    notifyListeners();
  }
  
  // list
 List <UserModel> userModel = [];
  List <UserModel> checkInList = [];
 List <UserModel> checkOutList = [];
 
 // adding users from hive to an list

 addUserData() {
  checkInList.clear();
  checkOutList.clear();
  userModel.clear();

  var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  for (int i = 0; i < userBox.length; i++) {
    var user = userBox.getAt(i) as UserModel?;
    if (user != null) {
      userModel.add(user,);

      // Check if the user has a status for the current date
      var status = user.dailyStatus?[currentDate];

      if (status == null) {
        // If there's no status for today, add the user to the checkInList
        checkInList.add(user);
      } else if (status.isCheckedIn && !status.isCheckedOut) {
        // If the user has checked in but not checked out, add to checkOutList
        checkOutList.add(user);
      }
    }
  }
  notifyListeners();
}


 // when the user checkin, it moves to checkout list
 checkInUser(int index) {
    var user = checkInList[index];
    var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Initialize the map if null
    user.dailyStatus ??= {};

    // Update the current date's status
    user.dailyStatus?[currentDate] = CheckInCheckOutStatus(isCheckedIn: true);

    user.save();

    // Move user from checkInList to checkOutList
    checkInList.removeAt(index);
    if (!checkOutList.contains(user)) {
      checkOutList.add(user);
    }

    notifyListeners();
}


// when user checkedout, it removed from that list
checkOutUser(int index) {
    var user = checkOutList[index];
    var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Initialize the map if null
    user.dailyStatus ??= {};

    // Ensure the date entry exists and update it
    user.dailyStatus?[currentDate] ??= CheckInCheckOutStatus();
    user.dailyStatus?[currentDate]?.isCheckedOut = true;

    user.save(); 
    
    checkOutList.remove(user);
    notifyListeners();
}

 // init function
 onInit(){ 
  addUserData();
  ageCtrl.clear();
  nameCtrl.clear();
  phoneCtrl.clear();
  weightCtrl.clear();
  heightCtrl.clear();
  galleryFile = null;
 }
 // pick image from gallery and camera
  File? galleryFile;
  
  final picker = ImagePicker();
  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
   
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        
        } else {
         
        }
        notifyListeners();
  }

  showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(backgroundColor: KColors().kWhite,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

// registration flow
  changePage(int index,BuildContext  context){
    switch(index){
    case 0:
    return RegistrationDetails(title: 'Name',hintText: 'Name',
      textEditingController:nameCtrl,value: 1 / 7,length: '1 / 7',);
   case 1: 
    return  RegistrationDetails(title: 'PhoneNumber',value: 2 / 7,length: '2 / 7',
      hintText: 'Phone',textEditingController:phoneCtrl,);
   case 2:  
    return RegistrationDetails(title: 'Age',hintText: 'Age',textEditingController:ageCtrl,
      value: 3 / 7,length: '3 / 7');
    case 3: 
     return RegistrationDetails(title: 'Weight',hintText: 'Kg',textEditingController:weightCtrl,
      value: 4 / 7,length: '4 / 7');
    case 4: 
     return RegistrationDetails(title: 'Height',hintText: 'Cm',textEditingController:heightCtrl
      ,value: 5 / 7,length: '5 / 7');
    case 5: 
     return RegistrationDetails(title: 'Blood Group',hintText: 'blood group',textEditingController:bloodCtrl,
      value: 6 / 7,length: '6 / 7');
      case 6:
      return UploadPhotoWidget(title: 'Upload Photo', length: '7 / 7', value: 7 / 7, onPressed: ()async{
     await  userBox.add(UserModel(name: nameCtrl.text, 
         age: ageCtrl.text,weight:weightCtrl.text ,
          height: heightCtrl.text,bloodgroup:bloodCtrl.text ,
         phonenumber: phoneCtrl.text,
          dp: galleryFile!.path,
          paymentHistory: [ PaymentHistory(month: 'January', type: 'online', status: 'paid', date: '2024-01-05'),
  PaymentHistory(month: 'February', type: 'cash', status: 'paid', date: '2024-02-07'),]),
           );
         addUserData();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
           });

 default :  
   




    
    }
  }
}