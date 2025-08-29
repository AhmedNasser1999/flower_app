import 'package:flower_app/features/categories/presentation/view/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

class SearchAndFilterWidget extends StatelessWidget {
  final String currentTab;
  final String? categoryId;

  const SearchAndFilterWidget({
    super.key,
    required this.currentTab,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (_) => null,
            onChanged: (value) {
              if (currentTab == "All") {
                context.read<MostSellingProductsViewmodel>().filterProducts(value);
              } else {
                if (categoryId != null) {
                  context.read<MostSellingProductsViewmodel>().filterByCategoryAndSearch(categoryId!, value);
                }
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: (){
            showModalBottomSheet(
              backgroundColor: AppColors.white,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(37))
                ),
                builder: (context) {
              return const FilterBottomSheet();
                }
            );
          },
          child: Container(
            width: 64,
            height: 59,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(color: AppColors.grey, width: 0.9),
            ),
            child: Image.asset("assets/icons/filter-Icon.png"),
          ),
        ),
      ],
    );
  }
}
