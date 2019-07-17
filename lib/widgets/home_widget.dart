import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provisional_license_test/auth/authentication.dart';
import 'package:provisional_license_test/auth/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings.dart';
import 'dashboard_item_widget.dart';
import 'dashboard_previous_results_card.dart';
import 'dashboard_statistics_card.dart';

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  AuthenticationBloc authenticationBloc;

  @override
  Widget build(BuildContext context) {
    authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
//                constraints: BoxConstraints.expand(height: 128),
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Learn to drive",
                        style: Theme.of(context).textTheme.display3.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      IconButton(
                        icon: Icon(Platform.isIOS? Icons.more_horiz: Icons.more_vert),
                        onPressed: () => openSettings(context),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            DashboardItemWidget(),
                            DashboardStatisticsCard(),
                            DashboardItemWidget(),
                            DashboardPreviousResultsCard(),
                            DashboardItemWidget(),
                          ],
                        ),
                      ),
                      Container(
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  Theme.of(context).primaryColor.withOpacity(0.0),
                                  Theme.of(context).primaryColor,
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ])),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _logout(){
    authenticationBloc.dispatch(LoggedOut());
  }
}
