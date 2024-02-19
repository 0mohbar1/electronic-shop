part of 'authbloc_bloc.dart';


abstract class AuthblocState {}

class AuthblocInitial extends AuthblocState {}
class LogInLoadingState extends AuthblocState{}
class LogInLoadedState extends AuthblocState{

}
class LogInFailState extends AuthblocState{
  String message;
  LogInFailState({required this.message});
}
class SignInLoadingState extends AuthblocState{}
class SignInLoadedState extends AuthblocState{

}
class SignInFailState extends AuthblocState{
  String message;
  SignInFailState({required this.message});
}
