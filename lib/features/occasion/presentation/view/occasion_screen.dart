import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/categories/presentation/view/widgets/products_grid_widget.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_product_states.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_states.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class OccasionScreen extends StatefulWidget {
  final String? initialOccasionId;
  const OccasionScreen({super.key, this.initialOccasionId});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<OccasionEntity> _occasions = [];
  int _selectedTabIndex = 0;
  bool _initialLoadComplete = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _updateTabController(
      List<OccasionEntity> occasions, BuildContext context) {
    if (_tabController != null) {
      _tabController!.dispose();
    }

    if (widget.initialOccasionId != null) {
      _selectedTabIndex =
          occasions.indexWhere((o) => o.id == widget.initialOccasionId);
      if (_selectedTabIndex == -1) _selectedTabIndex = 0;
    }

    _tabController = TabController(
      length: occasions.length,
      vsync: this,
      initialIndex: _selectedTabIndex.clamp(0, occasions.length - 1),
    );

    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController!.index;
        });
        final occasionId = occasions[_tabController!.index].id;
        _filterProductsByOccasion(context, occasionId);
      }

      setState(() {});

      if (!_initialLoadComplete && occasions.isNotEmpty) {
        _initialLoadComplete = true;
        final selectedOccasionId = occasions[_selectedTabIndex].id;
        _filterProductsByOccasion(context, selectedOccasionId);
      }
    });
  }

  void _filterProductsByOccasion(BuildContext context, String occasionId) {
    context.read<MostSellingProductsViewmodel>().filterByOccasion(occasionId);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<OccasionViewmodel>(),
        ),
        BlocProvider(
          create: (context) => getIt<MostSellingProductsViewmodel>(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoriesCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.occasionsTitle,
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: "Janna",
                    fontWeight: FontWeight.w400),
              ),
              Text(
                local.occasionsSubTitle,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            BlocConsumer<OccasionViewmodel, OccasionState>(
              listener: (context, state) {
                if (state is OccasionLoaded) {
                  _occasions = state.occasions;
                  _updateTabController(state.occasions, context);
                }
              },
              builder: (context, state) {
                if (state is OccasionInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<OccasionViewmodel>().getOccasions();
                    context
                        .read<MostSellingProductsViewmodel>()
                        .getMostSellingProducts();
                  });
                }

                if (state is OccasionLoading) {
                  return const Center(
                    child: LinearProgressIndicator(
                      color: AppColors.pink,
                      backgroundColor: AppColors.white,
                    ),
                  );
                } else if (state is OccasionLoaded) {
                  if (_tabController == null ||
                      _tabController!.length != state.occasions.length) {
                    return const SizedBox();
                  }
                  return TabBar(
                    controller: _tabController,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    labelColor: AppColors.pink,
                    unselectedLabelColor: AppColors.grey,
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontSize: 15),
                    dividerColor: Colors.transparent,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.5, color: AppColors.pink),
                      insets: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    tabs: state.occasions
                        .map((occasion) => Tab(text: occasion.name))
                        .toList(),
                  );
                } else if (state is OccasionError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Error: ${state.message}"),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OccasionViewmodel>().getOccasions();
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: LinearProgressIndicator(
                      color: AppColors.pink,
                      backgroundColor: AppColors.white,
                    ),
                  );
                }
              },
            ),
            Expanded(
              flex: 10,
              child: BlocBuilder<MostSellingProductsViewmodel,
                  MostSellingProductStates>(
                builder: (context, state) {
                  if (state is MostSellingSuccessState &&
                      !_initialLoadComplete) {
                    _initialLoadComplete = true;
                    if (_occasions.isNotEmpty &&
                        _selectedTabIndex < _occasions.length) {
                      final occasionId = _occasions[_selectedTabIndex].id;
                      _filterProductsByOccasion(context, occasionId);
                    }
                  }
                  return _buildProductsSection(
                      context, state, local.noProductsForOccasion);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsSection(BuildContext context,
      MostSellingProductStates state, String noProductsForOccasion) {
    if (state is MostSellingLoadingState) {
      return const Center(
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
    } else if (state is MostSellingSuccessState) {
      if (state.products.isEmpty) {
        return Center(
          child: Text(noProductsForOccasion),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await context.read<OccasionViewmodel>().getOccasions();
          if (_occasions.isNotEmpty && _selectedTabIndex < _occasions.length) {
            final occasionId = _occasions[_selectedTabIndex].id;
            _filterProductsByOccasion(context, occasionId);
          }
        },
        color: AppColors.pink,
        backgroundColor: AppColors.white,
        child: const ProductsGridWidget(isFromCategories: false),
      );
    } else if (state is MostSellingProductsErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Something went wrong, please try again"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_occasions.isNotEmpty &&
                    _selectedTabIndex < _occasions.length) {
                  final occasionId = _occasions[_selectedTabIndex].id;
                  _filterProductsByOccasion(context, occasionId);
                }
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('Select an occasion to see products'),
      );
    }
  }

  int calculateDiscountPercentage(int originalPrice, int discountedPrice) {
    if (originalPrice <= 0 ||
        discountedPrice < 0 ||
        discountedPrice > originalPrice) {
      return 0;
    }
    double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return discount.round();
  }
}
