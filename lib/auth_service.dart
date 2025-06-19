// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;
// import 'package:logger/logger.dart';
//
// class BiometricPinAuthService {
//   static final _logger = Logger();
//   static final LocalAuthentication _localAuthentication = LocalAuthentication();
//
// //check Biometric support
//   static Future<bool> canCheckBiometrics() async {
//     return await _localAuthentication.canCheckBiometrics;
//   }
//
// //check devicelevel auth
//   static Future<bool> deviceLevelAuth() async {
//     return await _localAuthentication.isDeviceSupported();
//   }
//
// //check biometric or devicelevel
//   static Future<bool> checkDeviceAuthSupport() async {
//     bool isSupport = await canCheckBiometrics() || await deviceLevelAuth();
//     return isSupport;
//   }
//
// //check wheter fingerprint or face id biometrics enrolled
//   static Future<List<BiometricType>> checkEnrolledBiometrics() async {
//     return await _localAuthentication.getAvailableBiometrics();
//   }
//
//   static Future<bool> authenticateBioMetrics() async {
//     bool didAuthenticate = false;
//
//     try {
//       _logger.i("Starting biometric authentication...");
//       didAuthenticate = await _localAuthentication.authenticate(
//         localizedReason: "Please authenticate to continue",
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//           stickyAuth: false,
//           useErrorDialogs: true,
//           sensitiveTransaction: false,
//         ),
//       );
//       _logger.i("Biometric auth result: $didAuthenticate");
//     } on PlatformException catch (e) {
//       _logger.e("Authentication failed: ${e.code} - ${e.message}");
//       _logger.e("Detailed error: $e");
//
//       if (e.code == auth_error.notAvailable) {
//         _logger.w("Biometric hardware not available");
//       } else if (e.code == auth_error.notEnrolled) {
//         _logger.w("No biometrics enrolled on this device");
//       } else if (e.code == auth_error.lockedOut) {
//         _logger.w("Too many failed attempts - biometrics locked out");
//       } else if (e.code == auth_error.passcodeNotSet) {
//         _logger.w("Device passcode not set (required for biometrics)");
//       }
//
//       didAuthenticate = false;
//     } catch (e) {
//       _logger.e("Unexpected error: $e");
//       didAuthenticate = false;
//     }
//     return didAuthenticate;
//   }
//
//
//  // static Future<bool> checkEnrolledBiometrics() async {
//  //    List<BiometricType> enrolledBioMetricsList =
//  //        await _localAuthentication.getAvailableBiometrics();
//  //
//  //    print(enrolledBioMetricsList);
//  //
//  //    if (enrolledBioMetricsList.isEmpty) {
//  //      //
//  //      print("no biometrics enrolled");
//  //      return false;
//  //    } else {
//  //      return true;
//  //    }
//  //  }
//
// }