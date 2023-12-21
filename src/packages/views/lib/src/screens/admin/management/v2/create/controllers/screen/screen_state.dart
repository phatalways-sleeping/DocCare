// ignore_for_file: public_member_api_docs

part of 'screen_bloc.dart';

@immutable
sealed class ScreenState extends Equatable {
  const ScreenState();

  @override
  List<Object> get props => [];
}

final class FirstScreen extends ScreenState {
  const FirstScreen();
}

final class SecondScreen extends ScreenState {
  const SecondScreen();
}

final class ThirdScreen extends ScreenState {
  const ThirdScreen();
}
