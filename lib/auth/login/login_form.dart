import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provisional_license_test/auth/login/login.dart';
import 'package:provisional_license_test/auth/login/signin_button.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "What's your email address?",
                          labelText: "Email,"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Try 'bears'...",
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SigninButton(
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontFamily: "RobotoMedium",
                                  fontSize: 16,
                                  color: Colors.white)),
                          onPressed: _onLoginButtonPressed),
                    )
                  ],
                )),
              ));
        },
      ),
    );
  }
}
