import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/profile/presentation/view/widgets/menu_item_widget.dart';
import 'package:flower_app/features/profile/presentation/view/widgets/notification_toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/states/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        titleSpacing: 15,
        title: SvgPicture.asset(
          AppIcons.logo,
          height: 32,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                iconSize: 32,
                icon:
                    const Icon(Icons.notifications_none, color: AppColors.grey),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ProfileViewModel, ProfileStates>(
          builder: (context, state) {
        if (state is ProfileLoadingState) {
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
        } else if (state is ProfileSuccessState) {
          final profile = state.user;

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profile.photo),
                      ),
                      const SizedBox(height: 16),
                      Text("${profile.firstName} ${profile.lastName}",
                          style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      Text(
                        profile.email,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                MenuItemWidget(
                  leading: SvgPicture.asset(
                    AppIcons.orderIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: local.myOrders,
                  onTap: () {},
                ),

                MenuItemWidget(
                  leading: SvgPicture.asset(
                    AppIcons.locationIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: local.savedAddress,
                  onTap: () {},
                ),

                const SizedBox(height: 2),

                Divider(
                  color: AppColors.white[70],
                ),

                const NotificationToggleWidget(),

                Divider(
                  color: AppColors.white[70],
                ),

                MenuItemWidget(
                  leading: SvgPicture.asset(
                    AppIcons.translateIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: local.language,
                  trailing: Text(
                    local.languageChanged,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.pink),
                  ),
                  onTap: () {},
                ),

                MenuItemWidget(
                  title: local.aboutUs,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.aboutUs);
                  },
                ),

                MenuItemWidget(
                  title: local.termsConditions,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.termsAndConditions);
                  },
                ),

                Divider(
                  color: AppColors.white[70],
                ),

                MenuItemWidget(
                  leading: SvgPicture.asset(
                    AppIcons.logoutIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: local.logout,
                  trailing: Icon(Icons.logout),
                  onTap: () {},
                ),

                Spacer(),

                // Version
                Center(
                  child: Text(
                    local.versionInfo,
                    style:
                        theme.textTheme.displayMedium?.copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ).setHorizontalAndVerticalPadding(context, 0.03, 0.02),
          );
        } else if (state is ProfileErrorState) {
          return Center(child: Text("${local.error} ${state.message}"));
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
