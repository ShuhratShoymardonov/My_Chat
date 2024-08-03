import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:my_chat/consts.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/models/user_profil.dart';
import 'package:my_chat/services/auth_service.dart';
import 'package:my_chat/services/alart_service.dart';
import 'package:my_chat/services/media_service.dart';
import 'package:my_chat/widget/Costom_from_fild.dart';
import 'package:my_chat/services/storage_service.dart';
import 'package:my_chat/services/data_basa_servoce.dart';
import 'package:my_chat/services/navigation_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _registerFromKey = GlobalKey();

  late MediaService _mediaService;
  late NavigationService _navigationService;
  late AuthService _authService;
  late StorageService _storageService;
  late AlartService _alartService;
  late DatabaseService _dataBasaServoce;

  String? email, password, name;

  bool isLoading = false;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService>();
    _dataBasaServoce = _getIt.get<DatabaseService>();
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
          if (!isLoading) _registerForm(),
          if (!isLoading) _LoginAcountLink(),
          if (isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
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
            "Les't get going!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            "Register an accaund using the form below",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.60,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.05,
        ),
        child: Form(
          key: _registerFromKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pfpSelectonFiled(),
              CostomFromFild(
                hintText: "Name",
                heigth: MediaQuery.sizeOf(context).height * 0.1,
                velidationRegExp: NAME_VALIDATION_REGEX,
                onSaved: (p0) {
                  setState(() {
                    name = p0;
                  });
                },
              ),
              CostomFromFild(
                hintText: "Email",
                heigth: MediaQuery.sizeOf(context).height * 0.1,
                velidationRegExp: EMAIL_VALIDATION_REGEX,
                onSaved: (p0) {
                  setState(() {
                    email = p0;
                  });
                },
              ),
              CostomFromFild(
                hintText: "Password",
                heigth: MediaQuery.sizeOf(context).height * 0.1,
                velidationRegExp: PASSWORD_VALIDATION_REGEX,
                onSaved: (p0) {
                  setState(() {
                    password = p0;
                  });
                },
              ),
              _registerBottom(),
            ],
          ),
        ));
  }

  Widget _pfpSelectonFiled() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getimageFormGalery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }

  Widget _registerBottom() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        height: 50,
        color: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          try {
            if ((_registerFromKey.currentState?.validate() ?? false) &&
                selectedImage != null) {
              _registerFromKey.currentState?.save();
              bool result = await _authService.signum(email!, password!);
              if (result) {
                String? pfpURL = await _storageService.uploadUserPfp(
                  file: selectedImage!,
                  uid: _authService.user!.uid,
                );
                if (pfpURL == null) {
                  await _dataBasaServoce.createUser(
                    userProfile: UserProfile(
                        uid: _authService.user!.uid,
                        name: name,
                        pfpURL: pfpURL),
                  );
                  _alartService.showToast(
                    text: "User registered successfully!",
                    icon: Icons.check,
                  );
                  _navigationService.goBack();
                  _navigationService.pushReplacementName("/home");
                } else {
                  throw Exception("Unable to oplut user profile pictuer");
                }
              } else {
                throw Exception("Unable to register user");
              }
              print(result);
            }
          } catch (e) {
            print(e);
            _alartService.showToast(
              text: "Failed to register, Please try again!",
              icon: Icons.error,
            );
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _LoginAcountLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Alreadi have an Account? "),
          GestureDetector(
            onTap: () {
              _navigationService.goBack();
            },
            child: Text(
              "Login",
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
