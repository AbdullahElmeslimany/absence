import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

fingerAuth() async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool didAuthenticate = await auth.authenticate(
      options: const AuthenticationOptions(),
      localizedReason: 'يرجي اعطاء بصمة اصبعك للدخول',
      authMessages: const <AuthMessages>[
        AndroidAuthMessages(
          biometricSuccess: "تم تسجيل المصادقة بنجاح",
          signInTitle: 'مرحبا بك في معهد مصر العالي',
          cancelButton: 'No thanks',
        ),
        IOSAuthMessages(
          cancelButton: 'No thanks',
        ),
      ]);
}
