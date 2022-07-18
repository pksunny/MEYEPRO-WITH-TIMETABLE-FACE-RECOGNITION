import 'package:flutter/material.dart';


// CUSTOM CONTAINER WIDGET //

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {required this.child,
      required this.height,
      required this.width,
      required this.color});

  final Widget child;
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(8))),
      child: child,
    );
  }
}



class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Widgets'),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: Colors.blue,
          width: double.infinity,
          height: 200,
          child: Column(
            children: [Text('CUSTOM')],
        ),
      )),
    );
  }
}
