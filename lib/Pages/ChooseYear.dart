import 'package:flutter/material.dart';
import 'package:rent_books/Pages/Mainpage.dart';

import '../Models/Mydata..dart';

class chooseYear extends StatefulWidget {
  const chooseYear({Key? key}) : super(key: key);

  @override
  _chooseYearState createState() => _chooseYearState();
}

class _chooseYearState extends State<chooseYear>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  // late Animation<Offset> _offsetAnimation;

  bool _showOkText = false;
   String _text = "Choose Your stream";
  late String stream;
  late String Year;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)  );
    //   ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     setState(() {
    //       _text = "Choose your Year";
    //     });
    //   }
    // });

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,reverseCurve: Curves.easeOutSine,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Container(

                  child: SlideTransition(
                    position: _offsetAnimation,

                    child: Column(
                      children: [
                        Text(_text,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),

                        Row(
                          children: [
                            _buildCard(
                              "assets/images/cse.png",
                              "Cse",
                                  () {
                                stream = "Cse";
                                // _showOkText = true;
                                _animateOut();
                              },
                            ),
                            _buildCard(
                              "assets/images/it.png",
                              "It",
                                  () {
                                    stream = "It";

                                    _animateOut();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),



                SlideTransition(
                  position: _offsetAnimation,
                  child: Row(
                    children: [
                      _buildCard(
                        "assets/images/civil.png",
                        "Civil",
                        () {
                          stream = "Civil";
                          _animateOut();
                        },
                      ),
                      _buildCard(
                        "assets/images/automobile.png",
                        "Automobile",
                        () {
                          stream = "Automobile";
                          _animateOut();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _showOkText,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [



                      Container(


                        child: SlideTransition(
                          position: _offsetAnimation,

                          child: Column(
                            children: [
                              Text(_text,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),),

                              Row(
                                children: [
                                  _buildCard(
                                    "assets/images/1.png",
                                    "First",
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Mainpage(MyData(stream,"First")),
                                            ),
                                          );
                                    },
                                  ),
                                  _buildCard(
                                    "assets/images/2.png",
                                    "Second",
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Mainpage(MyData(stream,"Second")),
                                            ),
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 20),
                    SlideTransition(
                      position: _offsetAnimation,
                      child: Row(
                        children: [
                          _buildCard(
                            "assets/images/3.png",
                            "Third",
                                () {
                              print("third");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Mainpage(MyData(stream,"Third")),
                                    ),
                                  );
                            },
                          ),
                          _buildCard(
                            "assets/images/4.png",
                            "Fourth",
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Mainpage(MyData(stream,"Fourth")),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _animateOut() {
    _controller.reverse().whenComplete(() {
      setState(() {
        _text = "Choose your year";
        _showOkText = true;
        _controller.forward();
      });
    });
  }



  Widget _buildCard(String imagePath, String text, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Card(
            elevation: Checkbox.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
