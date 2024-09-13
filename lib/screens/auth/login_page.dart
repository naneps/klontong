import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/login.bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:klontong/bloc/password_visibility/password_visibility.bloc.dart';
import 'package:klontong/bloc/password_visibility/password_visibility.event.dart';
import 'package:klontong/bloc/password_visibility/password_visibility.state.dart';
import 'package:klontong/screens/product/product_list_page.dart';
import 'package:klontong/widgets/logo.widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc()..add(CheckLoginStatus()),
        ),
        BlocProvider(
          create: (context) => PasswordVisibilityBloc(),
        ),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProductListPage()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoWidget(),
                    const SizedBox(height: 20),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Login to your account'),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              hintText: 'e.g. johndoe',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          BlocBuilder<PasswordVisibilityBloc,
                              PasswordVisibilityState>(
                            builder: (context, passwordState) {
                              return TextFormField(
                                controller: _passwordController,
                                obscureText: passwordState.isObscure,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordState.isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<PasswordVisibilityBloc>()
                                          .add(TogglePasswordVisibility());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(30),
                            ),
                            onPressed: () {
                              String username = _usernameController.text;
                              String password = _passwordController.text;
                              context
                                  .read<LoginBloc>()
                                  .add(LoginSubmitted(username, password));
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
