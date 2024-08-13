import 'package:dio/dio.dart';
import 'package:electronic_shop/bloc/authbloc/authbloc_bloc.dart';
import 'package:electronic_shop/constants/strings.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'fullName': '',
    'email': '',
    'phone': '',
    'address': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  bool _isLoading = false;

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
      context.read<AuthblocBloc>().add(SignUpEvent(
          _authData['fullName']!,
          _authData['email']!,
          _authData['phone']!,
          _authData['address']!,
          _authData['password']!));
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //  backgroundColor: ThemeProvider.primColor,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(230, 30, 99, 1.0).withOpacity(0.7),
              const Color.fromRGBO(192, 32, 90, 1.0).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1],
          )),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8.0,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: deviceSize.width * 0.75,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'الاسم الكامل',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'يرجى إدخال الاسم الكامل';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['fullName'] = val!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'الايميل',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty || !val.contains('@')) {
                              return 'يرجى ادخال ايميل صحيح';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['email'] = val!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'الرقم',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val!.isEmpty && val.length == 10) {
                              return 'يرجى إدخال الرقم';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['phone'] = val!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'العنوان',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'يرجى إدخال العنوان';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['address'] = val!;
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
                              return 'يرجى ادخال كلمة المرور';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['password'] = val!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                          ),
                          obscureText: true,
                          validator: (val) {
                            if (val != _passwordController.text) {
                              return 'كلمة المرور غير مطابقة';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_isLoading)
                          const CircularProgressIndicator()
                        else
                          ElevatedButton(
                            onPressed: _submit,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                            child: const Text('انشاء حساب'),
                          ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(auth_screen);

                            },
                            child: Text(
                              'تسجيل دخول',
                              style: TextStyle(color: ThemeProvider.primColor),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
