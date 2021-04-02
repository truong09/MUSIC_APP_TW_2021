import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayHome extends StatefulWidget {
  @override
  _PlayHomeState createState() => _PlayHomeState();
}

class _PlayHomeState extends State<PlayHome> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Slider(
                    value: rate,
                    onChanged: (newRating) {
                      setState(() {
                        rate = newRating;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0.0"),
                  Text("2:28"),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  "Nhu phut ban dau eeeeeeeeeeeeeeeeeeeeeeeee",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  "Noo Phuoc Thinh",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/pre.png'),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/icons/play.png'),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/icons/next.png'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/list_play.png')),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/none_repeat.png')),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/icons/clock.png')),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
