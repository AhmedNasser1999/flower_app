import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/services/guest_service.dart';
import '../widgets/login_dialog.dart';
part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial(0));

  Future<void> changeTab(BuildContext context, int index) async {
    final isGuest = await GuestService.isGuest();

    if (isGuest && (index == 2 || index == 3)) {
      showDialog(
        context: context,
        builder: (_) => const LoginRequiredDialog(),
      );
      return;
    }
    if (!isClosed) {
      emit(NavBarInitial(index));
    }
  }

  void navigateToCategories() {
    emit(NavBarInitial(1));
  }
}
