part of 'authbloc_bloc.dart';

abstract class AuthblocEvent {}
class LogInEvent extends AuthblocEvent{
  String email;
  String password;

  LogInEvent(this.email,this.password);
}
class SignInEvent extends AuthblocEvent{
  String email;
  String password;

  SignInEvent(this.email,this.password);
}