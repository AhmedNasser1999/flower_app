import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/profile/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/Widgets/custom_text_field.dart';
import '../../../../core/config/di.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/usecases/edit_profile_data_usecase.dart';
import '../viewmodel/edit_profile_viewmodel.dart';
import '../viewmodel/states/edit_profile_states.dart';

class EditProfileScreen extends StatelessWidget {
  final UserEntity user;
  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context, true);
        }, icon: Image.asset(AppImages.arrowBack),),
        title: Text(
          local.profileTitle,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
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
      body: BlocProvider(
        create: (_) {
          final cubit = EditProfileViewModel(
            getIt<EditProfileDataUseCase>(),
          );
          cubit.setInitialData(user);
          return cubit;
        },
        child: BlocConsumer<EditProfileViewModel, EditProfileStates>(
          builder: (context, state) {
            final editCubitController = context.read<EditProfileViewModel>();

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.photo),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColors.lightPink,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ).setVerticalPadding(context, 0.05),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          label: local.firstNameLabel,
                          controller: editCubitController.firstnameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          label: local.lastNameLabel,
                          controller: editCubitController.lastnameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ).setHorizontalAndVerticalPadding(context, 0.005, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.emailLabel,
                    controller: editCubitController.emailController,
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.phoneNumberLabel,
                    controller: editCubitController.phoneController,
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.password,
                    readonly: true,
                    initialText: "******",
                    suffixText: local.passwordChangeText,
                    onPressed: () {},
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.004),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IgnorePointer(
                        child: Radio<String>(
                          value: "male",
                          groupValue: user.gender,
                          onChanged: (_) {},
                          activeColor: AppColors.pink,
                        ),
                      ),
                      const Text(
                        "Male",
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.black,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      IgnorePointer(
                        child: Radio<String>(
                          value: "female",
                          groupValue: user.gender,
                          onChanged: (_) {},
                          activeColor: AppColors.pink,
                        ),
                      ),
                      const Text(
                        "Female",
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.black,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ).setHorizontalPadding(context, 0.05),
                  const SizedBox(height: 50),
                  CustomElevatedButton(
                    text: local.updateButton,
                    isLoading: state is EditProfileLoadingState,
                    onPressed: () {
                      editCubitController.submitProfileUpdate();
                    },
                  ).setVerticalPadding(context, 0.03),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is EditProfileSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(local.profileUpdatedSuccessMsg)),
              );
            } else if (state is EditProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${local.errorText}: ${state.message}')),
              );
            }
          },
        ),
      ),
    );
  }
}
