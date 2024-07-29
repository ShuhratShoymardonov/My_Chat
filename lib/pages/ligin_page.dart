import 'package:get_it/get_it.dart';
import 'package:my_chat/consts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_chat/services/auth_service.dart';
import 'package:my_chat/services/alart_service.dart';
import 'package:my_chat/widget/Costom_from_fild.dart';
import 'package:my_chat/services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;
  late AlartService _alartService;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alartService = _getIt.get<AlartService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Column(
        children: [
          _headerText(),
          _loginFrom(),
          _createAnAcoundLink(),
        ],
      ),
    ));
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, Welcome Back!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "Hi, again, you've been mussed",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginFrom() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CostomFromFild(
              onSaved: (p0) {
                setState(() {
                  email = p0;
                });
              },
              heigth: MediaQuery.sizeOf(context).height * 0.1,
              hintText: 'Email',
              velidationRegExp: EMAIL_VALIDATION_REGEX,
            ),
            CostomFromFild(
              onSaved: (p0) {
                setState(() {
                  password = p0;
                });
              },
              heigth: MediaQuery.sizeOf(context).height * 0.1,
              hintText: 'Passwold',
              velidationRegExp: PASSWORD_VALIDATION_REGEX,
              obscreText: true,
            ),
            _liginBottom(),
          ],
        ),
      ),
    );
  }

  Widget _liginBottom() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        height: 50,
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool rezult = await _authService.login(email!, password!);
            print(rezult);
            if (rezult) {
              _navigationService.pushReplacementName("/home");
            } else {
              _alartService.showToast(
                text: "Faild to login, Please try again!",
                icon: Icons.error,
              );
            }
          }
        },
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAnAcoundLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Don't have an accound? "),
          GestureDetector(
            onTap: () {
              _navigationService.pushName("/register");
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
