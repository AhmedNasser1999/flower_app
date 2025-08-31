import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/theme/app_colors.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/states/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileViewModel, ProfileStates>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOut,
              colors: [AppColors.pink],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
            ),);
          }
          else if (state is ProfileSuccessState){
            final profile = state.user;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profile.photo),
                    ),
                    const SizedBox(height: 16),
                    Text("${profile.firstName} ${profile.lastName}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(profile.email),
                    const SizedBox(height: 8),
                    Text("Phone: ${profile.phone}"),
                    const SizedBox(height: 8),
                    Text("Gender: ${profile.gender}"),
                  ],
                ),
              ),
            );
          }
          else if (state is ProfileErrorState) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        }
      ),
    );
  }
}
