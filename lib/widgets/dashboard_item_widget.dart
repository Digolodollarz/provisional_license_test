import 'package:flutter/material.dart';
import 'package:provisional_license_test/practice/practice_quiz.dart';

class DashboardItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> _openRandomTest(context),
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "Mock Test",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Theme.of(context).primaryColorDark),
                ),
                alignment: Alignment(-1, 0),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Start Now",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/img/home_icons/gym-angled.png',
                          color: Theme.of(context).primaryColor,
                        ),
                        width: 64,
                        height: 64,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Take a quick timed practice test",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Color(0xAA000000)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xAA000000),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_openRandomTest(BuildContext context){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (BuildContext context){
      return PracticeQuizPage();
    })
  );
}
