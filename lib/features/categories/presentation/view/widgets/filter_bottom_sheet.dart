import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedOption;

  final options = [
    "Lowest Price",
    "Highest Price",
    "New",
    "Old",
    "Discount",
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Sort By", style: TextStyle(
              color: AppColors.pink,
              fontSize: 21,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold
            ),),
          ).setHorizontalPadding(context,0.035),
          const SizedBox(height: 5,),
          ...options.map((option) {
            return ListTile(
              focusColor: AppColors.pink,
              hoverColor: AppColors.pink,
              title: Text(option),
              trailing: Radio<String>(
                value: option,
                groupValue: selectedOption,
                activeColor: AppColors.pink,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            );
          }).toList(),
          const SizedBox(height: 40,),

          CustomElevatedButton(text: "Filter", onPressed: (){
            Navigator.pop(context);
          },)
        ],
      ),
    ).setHorizontalAndVerticalPadding(context, 0.025, 0.025);
  }
}
