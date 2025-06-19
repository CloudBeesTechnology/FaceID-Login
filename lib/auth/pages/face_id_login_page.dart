import 'package:face_id_login/auth/pages/regular_login_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';

class FaceIdLoginPage extends StatefulWidget {
  const FaceIdLoginPage({super.key});

  @override
  State<FaceIdLoginPage> createState() => _FaceIdLoginPageState();
}

class _FaceIdLoginPageState extends State<FaceIdLoginPage> {
  bool _isLoading = false;

  final Logger _logger = Logger();

  Future<void> _loginWithFaceId() async {
    setState(() => _isLoading = true);
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      _logger.i('Attempting Face ID authentication');
      final user = await authService.loginWithFaceId();

      if (user == null) {
        _logger.w('Face ID authentication failed - no user returned');
      } else {
        _logger.i('Face ID authentication successful for user: ${user.email}');
      }
    } catch (e, stackTrace) {
      _logger.e('Face ID authentication error',
          error: e,
          stackTrace: stackTrace);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.face_retouching_natural, size: 100),
              const SizedBox(height: 32),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Authenticate with Face ID to continue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _loginWithFaceId,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Authenticate with Face ID',style: TextStyle(color: Colors.blue,fontSize: 18),),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegularLoginPage()),
                  );
                },
                child: const Text('Use password instead',style: TextStyle(color: Colors.blue),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}