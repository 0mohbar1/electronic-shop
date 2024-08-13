import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
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
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
              width: deviceSize.width,
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100,),
                    Flexible(
                      child: Image.asset('images/Whats.png',height: 220,)
                    ),
                    const SizedBox(height: 20,),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
