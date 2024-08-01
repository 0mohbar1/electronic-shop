import 'package:dio/dio.dart';
import 'package:electronic_shop/constants/strings.dart';
import 'package:electronic_shop/presentation/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/authbloc/authbloc_bloc.dart';

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

//enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  //AuthMode _authMode = AuthMode.Login;
  Map<String, String> authData = {
    'address': '',
    'password': ''
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      context
          .read<AuthblocBloc>()
          .add(LogInEvent(authData['email']!, authData['password']!));
    } on DioException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'هذا الايميل موجود من قبل';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'هذا الايميل ليس موجود';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'هذا الايميل ليس موجود';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you, Please try again later';
      print('errror +$error');
      _showErrorDialog(errorMessage);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('succes', true);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamed(Product_overview_screen);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('هناك خطأ حدث'),
        content: Text(message),
        actions: [
          InkWell(
            onTap: () => Navigator.of(ctx).pop(),
            child: const Text('اوك!'),
          )
        ],
      ),
    );
  }

  // void _switchAuthMode() {
  //   if (_authMode == AuthMode.Login) {
  //     setState(() {
  //       _authMode = AuthMode.SignUp;
  //     });
  //     _controller.forward();
  //   } else {
  //     setState(() {
  //       _authMode = AuthMode.Login;
  //     });
  //     _controller.reverse();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocProvider<AuthblocBloc>(
      create: (BuildContext context) => AuthblocBloc(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: 260,
          constraints: BoxConstraints(
            minHeight: 260,
          ),
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'الايميل',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty || !val.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      authData['email'] = val!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'كلمة المرور',
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (val) {
                      if (val!.isEmpty || val.length < 5) {
                        return 'كلمة المرور قصيرة جدا';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      authData['password'] = val!;
                    },
                  ),
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 300),
                  //
                  //   curve: Curves.easeIn,
                  //   child: FadeTransition(
                  //     opacity: _opacityAnimation,
                  //     child: SlideTransition(
                  //       position: _slideAnimation,
                  //       child: TextFormField(
                  //         decoration: const InputDecoration(
                  //           labelText: 'Confirm Password',
                  //         ),
                  //         obscureText: true,
                  //         enabled: _authMode == AuthMode.SignUp,
                  //         validator: _authMode == AuthMode.SignUp
                  //             ? (val) {
                  //                 if (val != _passwordController.text) {
                  //                   return 'Password do not match!';
                  //                 }
                  //                 return null;
                  //               }
                  //             : null,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isLoading) const CircularProgressIndicator(),
                  if (!_isLoading)
                    ElevatedButton(
                      onPressed: _submit,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color),
                      ),
                      child: const Text('تسجيل الدخول'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(signUp_screen);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8)),
                    ),
                    child: const Text(
                      'انشاء حساب',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
