import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provisional_license_test/auth/user_repository.dart';

import 'package:provisional_license_test/auth/authentication.dart';
import 'package:provisional_license_test/auth/login/login.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provisional_license_test/auth/authentication.dart';
import 'package:provisional_license_test/auth/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provisional_license_test/widgets/home_widget.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Material(
      child: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  FractionallySizedBox(
                    heightFactor: 1,
                    child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: 3 / 5,
                    child: ClipPath(
                      clipper: DiagonalPathClipperOne(),
                      child: Container(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: 2 / 5,
                    child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 64.0,
                        bottom: 32.0,
                      ),
                      child: Text(
                        "Learn to drive",
                        style: Theme.of(context).textTheme.display3.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    LoginForm(),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            )),
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {
                          final _loginBloc = BlocProvider.of<LoginBloc>(context);
                          _loginBloc.dispatch(SkipLogin());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "Skip for now",
                            style: Theme.of(context).textTheme.body1.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
