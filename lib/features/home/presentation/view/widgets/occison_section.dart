import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../viewmodel/home_cubit.dart';
import '../../viewmodel/home_state.dart';
import 'occasion_list.dart';

class OccasionsSection extends StatelessWidget {
  final HomeState state;
  const OccasionsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isOccasionsLoading) {
      return const Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScalePulseOut,
            colors: [AppColors.pink],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else if (state.occasionsError != null) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error loading occasions'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshOccasions(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return OccasionList(
        occasionList: state.occasionsList,
        onTap: (occasion) {
          Navigator.pushNamed(context, AppRoutes.occasions,
              arguments: occasion.id);
        },
      );
    }
  }
}
