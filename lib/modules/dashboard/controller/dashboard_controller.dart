import 'dart:io';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/global/constants/db_key.dart';
import 'package:fitnessappadmin/modules/dashboard/model/usermodel.dart';
import 'package:fitnessappadmin/modules/dashboard/view/attendance_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/registration_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/users_list_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/widget/advance_amount.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widget/registration_data.widget.dart';
import '../widget/upload_photo.widget.dart';
import '../widget/weight_training_options.widget.dart';

class DashBoardController extends ChangeNotifier {
  // controllers
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController bloodCtrl = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode weightFocusNode = FocusNode();
  FocusNode heightFocusNode = FocusNode();
  FocusNode bloodFocusNode = FocusNode();

  // bottom navigation bar screens
  List screens = [
    const AttendanceScreen(),
    const RegistrationScreen(),
    const UsersListScreen()
  ];

// selecting the index(bottom navigation)
  int selectedIndex = 0;
setIndex(int index){
selectedIndex = index;
notifyListeners();
}



// page controller for pageview

  final PageController pageController = PageController(initialPage: 0);
  int currentpage = 0;
  setPage(int value) {
    currentpage = value;
    notifyListeners();
  }

  // list
  List<UserModel> userModel = [];
  List<UserModel> checkInList = [];
  List<UserModel> checkOutList = [];

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

        var status = user.dailyStatus?[currentDate];

        //  to track users checkin and checkout
        if (status?.isCheckedOut == false) {
          checkOutList.add(user);
        } else if (status == null || !status.isCheckedOut) {
          checkInList.add(user);
        }
      }
    }
    notifyListeners();
  }

  // when the user checkin, it moves to checkout list
  checkInUser(int index) {
    var user = checkInList[index];
    var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    user.dailyStatus = {};
    user.dailyStatus?[currentDate] = CheckInCheckOutStatus();
    user.dailyStatus?[currentDate]?.isCheckedIn = true;

    user.save();
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
  onInit() {
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
    } else {}
    notifyListeners();
  }

  showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      backgroundColor: KColors().kWhite,
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

  // get unpaid months
List<String> getUnpaidMonths(UserModel user) {
  Set<String> paidMonths = user.paymentHistory
      ?.where((entry) => entry.status == 'paid')
      .map((entry) => entry.month)
      .toSet() ?? {};

  List<String> unpaidMonths = [];
  DateTime now = DateTime.now();

  for (int i = 1; i <= 12; i++) {
    String month = DateFormat('MMMM').format(DateTime(now.year, i, 1));
    if (!paidMonths.contains(month)) {
      unpaidMonths.add(month);
    }
  }

  return unpaidMonths;
}
// update payments
 updatePaymentStatus(int index, List<String> selectedMonths) {
  UserModel user = userModel[index];

 
  List<PaymentHistory> newPaymentHistory = List.from(user.paymentHistory ?? []);
  for (String month in selectedMonths) {
  
      newPaymentHistory.add(
        PaymentHistory(month: month, type: 'online', status: 'paid', date: DateFormat('yyyy-MM-dd').format(DateTime.now())),
      );
    
  }

  
  user.paymentHistory = newPaymentHistory;
  userBox.put(index,user);
  notifyListeners(); 
}



  

 WeightOption? selectedWeightOption; 
bool hasPaidAdvance = false; 

changePage(int index, BuildContext context) {
  switch (index) {
    case 0:
      return RegistrationDetails(
        title: 'Name',
        hintText: 'Name',
        textEditingController: nameCtrl,
        value: 1 / 9,
        length: '1 / 9',
      );
    case 1:
      return RegistrationDetails(
        title: 'PhoneNumber',
        value: 2 / 9,
        length: '2 / 9',
        textInputType: TextInputType.phone,
        hintText: 'Phone',
        textEditingController: phoneCtrl,
      );
    case 2:
      return RegistrationDetails(
        title: 'Age',
        hintText: 'Age',
        textEditingController: ageCtrl,
        value: 3 / 9,
        length: '3 / 9',
        textInputType: TextInputType.number,
      );
    case 3:
      return RegistrationDetails(
          title: 'Weight',
          hintText: 'Kg',
          textEditingController: weightCtrl,
          textInputType: TextInputType.number,
          value: 4 / 9,
          length: '4 / 9');
    case 4:
      return RegistrationDetails(
          title: 'Height',
          hintText: 'Cm',
          textEditingController: heightCtrl,
          textInputType: TextInputType.number,
          value: 5 / 9,
          length: '5 / 9');
    case 5:
      return RegistrationDetails(
          title: 'Blood Group',
          hintText: 'Blood Group',
          textEditingController: bloodCtrl,
          value: 6 / 9,
          length: '6 / 9');
    case 6:
      return const UploadPhotoWidget(
        title: 'Upload Photo',
        length: '7 / 9',
        value: 7 / 9,
      );
    case 7:
      return const WeightSelectionScreen(
        value: 8 / 9,
        length: '8 / 9',
       
      );
    case 8:
      return AdvanceAmountSelectionScreen(
        value: 9 / 9,
        length: '9 / 9',
       
        onSubmit: () async {
          
             await userBox.add(UserModel(
        name: nameCtrl.text,
        phonenumber: phoneCtrl.text,
        age: ageCtrl.text,
        weight: weightCtrl.text,
        height: heightCtrl.text,
        bloodgroup: bloodCtrl.text,
        dp: galleryFile!.path,
        selectedWeightOption: selectedWeightOption, 
        hasPaidAdvance: hasPaidAdvance, 
      ));

            addUserData(); 
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          
        },
      );
    default:
      return Container(); // Fallback widget if case doesn't match
  }
}

  

  changeFocusNode(FocusNode ? focusNode, BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
