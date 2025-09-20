import 'dart:io';
import 'package:flower_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/Widgets/custom_text_field.dart';
import '../../../../core/config/di.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/edit_profile_data_usecase.dart';
import '../../domain/usecases/upload_photo_usecase.dart';
import '../viewmodel/edit_profile_viewmodel.dart';
import '../viewmodel/states/edit_profile_states.dart';

class EditProfileScreen extends StatelessWidget {
  final UserEntity user;

  const EditProfileScreen({super.key, required this.user});

  Future<void> _pickAndUploadPhoto(
    BuildContext context,
    EditProfileViewModel cubit,
  ) async {
    final picker = ImagePicker();
    try {
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (picked != null) {
        final file = File(picked.path);
        cubit.uploadPhoto(file);
      }
    } catch (e) {
      debugPrint("❌ Failed to pick image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Unsupported image type. Please pick JPG or PNG.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = false;
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, isEdit);
          },
          icon: Image.asset(AppImages.arrowBack),
        ),
        title: Text(
          local.profileTitle,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                iconSize: 32,
                icon: SvgPicture.asset(
                  AppIcons.notificationsIcon,
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.notification);
                },
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
            getIt<UploadPhotoUseCase>(),
          );
          cubit.setInitialData(user);
          return cubit;
        },
        child: BlocConsumer<EditProfileViewModel, EditProfileStates>(
          listener: (context, state) {
            if (state is EditProfileSuccessState) {
              showCustomSnackBar(context, local.profileUpdatedSuccessMsg,
                  isError: false);
              Navigator.pop(context);
            } else if (state is EditProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${local.errorText}: ${state.message}')),
              );
            } else if (state is ProfilePhotoUpdatedState) {
              showCustomSnackBar(context, local.profilePhotoUpdatedSuccessfully,
                  isError: false);
            } else if (state is ProfilePhotoErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<EditProfileViewModel>();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: cubit.currentPhotoUrl != null
                            ? (cubit.currentPhotoUrl!.startsWith("http")
                                ? NetworkImage(cubit.currentPhotoUrl!)
                                : FileImage(File(cubit.currentPhotoUrl!))
                                    as ImageProvider)
                            : NetworkImage(user.photo),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            isEdit = true;
                            _pickAndUploadPhoto(context, cubit);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.lightPink,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: state is ProfilePhotoLoadingState
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(AppColors.grey),
                                  )
                                : const Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.grey,
                                    size: 20,
                                  ),
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
                          controller: cubit.firstnameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextFormField(
                          label: local.lastNameLabel,
                          controller: cubit.lastnameController,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ).setHorizontalAndVerticalPadding(context, 0.005, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.emailLabel,
                    controller: cubit.emailController,
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.phoneNumberLabel,
                    controller: cubit.phoneController,
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.005),
                  const SizedBox(height: 13),
                  CustomTextFormField(
                    label: local.password,
                    readonly: true,
                    initialText: "******",
                    suffixText: local.passwordChangeText,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.changePasswordScreen);
                    },
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.004),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
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
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    text: local.updateButton,
                    isLoading: state is EditProfileLoadingState,
                    onPressed: () {
                      isEdit = true;
                      cubit.submitProfileUpdate();
                    },
                  ).setVerticalPadding(context, 0.03),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
