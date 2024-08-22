import 'package:fitnessappadmin/modules/dashboard/controller/dashboard_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget>providersList = [
   ChangeNotifierProvider(create: (_) => DashBoardController()),
  
   ];