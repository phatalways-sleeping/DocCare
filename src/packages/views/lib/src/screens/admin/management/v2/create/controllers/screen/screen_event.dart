// ignore_for_file: public_member_api_docs

part of 'screen_bloc.dart';

@immutable
sealed class ScreenEvent extends Equatable {
  const ScreenEvent();

  @override
  List<Object> get props => [];
}

final class NavigateToFirstScreen extends ScreenEvent {
  const NavigateToFirstScreen();
}

final class NavigateToSecondScreen extends ScreenEvent {
  const NavigateToSecondScreen();
}

final class NavigateToThirdScreen extends ScreenEvent {
  const NavigateToThirdScreen();
}
