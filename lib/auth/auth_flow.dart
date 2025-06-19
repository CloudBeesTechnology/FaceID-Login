import 'package:face_id_login/auth/pages/face_id_login_page.dart';
import 'package:face_id_login/auth/pages/home_page.dart';
import 'package:face_id_login/auth/pages/regular_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user == null) {
            return FutureBuilder<bool>(
              future: authService.canLoginWithFaceId,
              builder: (context, faceIdSnapshot) {
                if (faceIdSnapshot.connectionState == ConnectionState.done) {
                  return faceIdSnapshot.data == true
                      ? const FaceIdLoginPage()
                      : const RegularLoginPage();
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          }
          return const HomePage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}