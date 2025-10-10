import 'package:flower_app/core/Widgets/custom_Elevated_Button.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? categoryId;
  const FilterBottomSheet({super.key, this.categoryId});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedOption;

  final Map<String, String> sortOptions = {
    "Lowest Price": "price",
    "Highest Price": "-price",
    "New": "new",
    "Old": "old",
    "Discount": "discount",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Sort By",
              style: TextStyle(
                  color: AppColors.pink,
                  fontSize: 21,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold),
            ),
          ).setHorizontalPadding(context, 0.035),
          const SizedBox(
            height: 5,
          ),
          ...sortOptions.keys.map((option) {
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
          }),
          const SizedBox(
            height: 40,
          ),
          CustomElevatedButton(
            text: "Filter",
            onPressed: () {
              if (selectedOption != null) {
                final selectedSort = sortOptions[selectedOption!];
                final viewmodel = context.read<MostSellingProductsViewmodel>();
                viewmodel.getProduct(
                  sort: selectedSort,
                  category: widget.categoryId,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    ).setHorizontalAndVerticalPadding(context, 0.025, 0.025);
  }
}
