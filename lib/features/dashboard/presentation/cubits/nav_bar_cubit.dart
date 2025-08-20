import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial(0));
  void changeTab(int index) {
    if (!isClosed) {
      emit(NavBarInitial(index));
    }
  }
}
