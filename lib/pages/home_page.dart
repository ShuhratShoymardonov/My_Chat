import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/services/auth_service.dart';
import 'package:my_chat/services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
        actions: [
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.logout),
            onPressed: () async {
              bool result = await _authService.logout();
              if (result) {
                _navigationService.pushReplacementName("/login");
              }
            },
          ),
        ],
      ),
    );
  }
}
