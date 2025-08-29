import 'package:flower_app/core/Widgets/products_card.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_states.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_view_model.dart';
import 'package:flower_app/features/occasion/presentation/widgets/occasion_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/contants/app_images.dart';

class OccasionScreen extends StatelessWidget {
  const OccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.occasionsTitle,
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              local.occasionsSubTitle ?? 'Browse all occasions',
              style: theme.textTheme.displayMedium,
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => context.read<OccasionViewmodel>()..getOccasions(),
        child: BlocBuilder<OccasionViewmodel, OccasionState>(
          builder: (context, state) {
            if (state is OccasionLoading) {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOut,
                    colors: [AppColors.pink],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              );
            } else if (state is OccasionLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<OccasionViewmodel>().getOccasions(),
                color: AppColors.pink,
                backgroundColor: AppColors.white,
                child: Expanded(
                  child: GridView.builder(
                    itemCount: state.occasions.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final occasion = state.occasions[index];
                      return ProductCard(
                        productPrice: 600,
                        productPriceDiscount: 800,
                        priceDiscount: 20,
                        productTitle: occasion.name,
                        productImg: occasion.image,
                      );
                    },
                  ),
                ),
              );
            } else if (state is OccasionError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error: ${state.message}"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<OccasionViewmodel>().getOccasions(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
