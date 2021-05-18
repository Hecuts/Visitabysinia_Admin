import 'package:flutter/material.dart';


class BottomButton extends StatefulWidget {

  BottomButton({this.onTap, this.buttonTitle});
  final Function onTap;
  final String buttonTitle;
  static const kLargeButtonStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w900,
    letterSpacing: 3.0,
  );

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    ) ..addListener(() {
      setState(() {
      });
      super.initState();
    });
  }
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      //onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff4cf34f),
                  Color(0xff3cd5ac),
                ],
              )),
          child: Center(
            child: Text(
              widget.buttonTitle,
              style: BottomButton.kLargeButtonStyle ,
            ),
          ),
          //  color:  Colors.transparent,
          margin: EdgeInsets.only(top: 10.0),
          width: double.infinity,
          height: 80.0,
          padding: EdgeInsets.only(bottom: 20.0),

        ),
      ),
    );
  }
}