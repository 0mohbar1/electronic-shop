import 'package:electronic_shop/bloc/authbloc/authbloc_bloc.dart';
import 'package:electronic_shop/presentation/screens/auth_screen.dart';
import 'package:electronic_shop/presentation/widgets/drawer.dart';
import 'package:electronic_shop/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late SharedPreferences preferences;

  String? _email;
  String? _fullName;
  String? _address;
  String? _phone;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  void _loadEmail() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      _email = preferences.getString('email');
      _fullName = preferences.getString('fullName');
      _phone = preferences.getString('phone');
      _address = preferences.getString('address');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(

      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () => provider.toggleTheme(),
                child: Icon(provider.isDark ? Icons.nightlight : Icons.sunny)),
          ),
        ],
        leading: InkWell(
          child: const Icon(Icons.logout),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (BuildContext context) => AuthblocBloc(),
                  child: const AuthScreen(),
                ),
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: ThemeProvider.primColor,
        title: const Text('معلوماتي',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Text(
                "الاسم الكامل :$_fullName",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "الايميل : $_email",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "الرقم : $_phone",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "رقم الهاتف : $_address",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      //   drawer: const AppDrawer(),
    );
  }
}
