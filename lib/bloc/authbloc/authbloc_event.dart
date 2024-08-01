part of 'authbloc_bloc.dart';

abstract class AuthblocEvent {}
class LogInEvent extends AuthblocEvent{
  String email;
  String password;

  LogInEvent(this.email,this.password);
}
class SignUpEvent extends AuthblocEvent{
  String email;
  String fullname;
  String phone;
  String address;
  String password;

  SignUpEvent(
      this.email, this.fullname, this.phone, this.address, this.password);
}