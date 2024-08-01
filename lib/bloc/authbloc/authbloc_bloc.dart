import 'package:bloc/bloc.dart';
import 'package:electronic_shop/data/repository/authrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Assuming you have AuthSharedRepo in a separate file

part 'authbloc_event.dart';

part 'authbloc_state.dart';

class AuthblocBloc extends Bloc<AuthblocEvent, AuthblocState> {
  AuthblocBloc() : super(AuthblocInitial()) {
    on<LogInEvent>((event, emit) async {
      if (event is LogInEvent) {
        try {
          emit(LogInLoadingState());

          await saveLogInInfo(event.email, event.password);
          emit(LogInLoadedState());
        } catch (e) {
          emit(LogInFailState(message: 'An error occurred: $e'));
        }
      }
    });

    on<SignUpEvent>((event, emit) async {
      if (event is SignUpEvent) {
        try {
          emit(SignInLoadingState());

          await saveSignUpInfo(event.fullname, event.email, event.phone,
              event.address, event.password);

          emit(SignInLoadedState());
        } catch (e) {
          emit(SignInFailState(message: 'An error occurred: $e'));
        }
      }
    });
  }

  Future<void> saveSignUpInfo(String fullname, String email, String phone,
      String address, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('fullName', fullname);
    await prefs.setString('phone', phone);
    await prefs.setString('address', address);
    await prefs.setString('password', password);
  }

  Future<void> saveLogInInfo(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }
}
