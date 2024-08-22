import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({super.key,required this.value,required this.onChanged});
final bool value;
final Function(bool ?) onChanged;
  @override
  Widget build(BuildContext context) {
  return Checkbox(  
                            checkColor: Colors.greenAccent,  
                            activeColor: Colors.red.shade200,  
                            value: value,
  onChanged:onChanged
                          );
  }
}