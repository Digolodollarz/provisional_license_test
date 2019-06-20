import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'dashboard_item_widget.dart';
import 'dashboard_statistics_card.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
//                constraints: BoxConstraints.expand(height: 128),
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 64.0,
                  bottom: 32.0,
                ),
                child: Text(
                  "Learn to drive",
                  style: Theme.of(context).textTheme.display1.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  'Welcome to a drunkard\'s freaking application',
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
        ],
      ),
    );
  }
}
