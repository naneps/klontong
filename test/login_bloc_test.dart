import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong/bloc/auth/login.bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LoginBloc loginBloc;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    loginBloc = LoginBloc();
  });

  test('initial state is LoginInitial', () {
    expect(loginBloc.state, isA<LoginInitial>());
  });

  blocTest<LoginBloc, LoginState>(
    'emits [LoginLoading, LoginSuccess] when LoginSubmitted is added with valid credentials',
    build: () => loginBloc,
    act: (bloc) {
      // Mock the setBool method to return a successful Future

      SharedPreferences.getInstance().then((value) {
        value.setBool('isLoggedIn', true);
      });
      bloc.add(const LoginSubmitted('admin', 'password'));
    },
    expect: () => [
      LoginLoading(),
      LoginSuccess(),
    ],
    verify: (bloc) {
      verify(mockSharedPreferences.setBool('isLoggedIn', true));
    },
  );
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
