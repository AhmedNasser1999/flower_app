part of 'nav_bar_cubit.dart';

@immutable
sealed class NavBarState {
  final int selectedIndex;

  const NavBarState(this.selectedIndex);
}

final class NavBarInitial extends NavBarState {
  const NavBarInitial(super.selectedIndex);
}
