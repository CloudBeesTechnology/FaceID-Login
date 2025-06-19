import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 100,color: Colors.green,),
            const SizedBox(height: 20),
            Text('Welcome',style: TextStyle(fontSize: 24),),
            Text(
              '${user?.email ?? 'User'}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text('You are successfully authenticated'),
          ],
        ),
      ),
    );
  }
}