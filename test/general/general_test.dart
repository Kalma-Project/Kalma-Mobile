import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/model/general/general.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Login User', () {
    final AuthService authService = AuthService();

    test('login dengan credentials valid', () async {
      AuthUser? user = await authService.login('cakuakz', 'kopkopL321');
      expect(user, isNotNull);
      // expect(user.email, 'valid@example.com');
    });

    test('login dengan credentials tidak valid', () async {
      expect(() async {
        await authService.login('owigirio', 'wrongpassword');
      }, throwsException);
    });
  });

  group('Register User', () {
    final AuthService authService = AuthService();

    test('register dengan data valid', () async {

      await authService.registerUserRequest(
        'newuser@example.com',
        'newpassword123',
        'baharudin',
        'Rafi Irfansyah Ganteng',
        '22',
      );
    });

    test('register with already used email', () async {
      await authService.registerUserRequest(
        'rafiirvansyah88@gmail.com',
        'password123',
        'existinguser',
        'Existing User',
        '30',
      );
      expect(() async {
        await authService.registerUserRequest(
          'existing@example.com',
          'anotherpassword',
          'existinguser2',
          'Existing User 2',
          '25',
        );
      }, throwsException);
    });
  });
}