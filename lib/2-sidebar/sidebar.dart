// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:m_eye_gui/1-Login+Signup%20Screen/LoginScreen.dart';
// import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';
// import 'package:m_eye_gui/7-Setting%20Screen/Setting.dart';
// import 'package:m_eye_gui/8-About%20Screen/AboutPage.dart';
// import 'package:m_eye_gui/9-Notification%20Screen/NotificationPage.dart';
// import 'package:rxdart/rxdart.dart';

// import 'menu_item.dart';

// class SideBar extends StatefulWidget {
//   const SideBar({Key? key}) : super(key: key);

//   @override
//   State<SideBar> createState() => _SideBarState();
// }

// class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {

//   late AnimationController _animationController;
//   late StreamController<bool> isSideBarOpenedStreamController;
//   late Stream<bool> isSideBarOpenedStream;
//   late StreamSink<bool> isSideBarOpenedSink;
//   // final bool isSideBarOpened = true;
//   final _animationDuration = const Duration(milliseconds: 500);

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(vsync: this, duration: _animationDuration);
//     isSideBarOpenedStreamController = PublishSubject<bool>();
//     isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
//     isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     isSideBarOpenedStreamController.close();
//     super.dispose();
//   }

//   void onIconPressed(){
//     final animationStatus =  _animationController.status;
//     final isAnimationCompleted = animationStatus == AnimationStatus.completed;

//     if(isAnimationCompleted){
//       isSideBarOpenedSink.add(false);
//       _animationController.reverse();
//     }else{
//       isSideBarOpenedSink.add(true);
//       _animationController.forward();
//     }
//   }

//   // var cardtextstyle = TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));

//   @override
//   Widget build(BuildContext context) {

//     final screenWidth = MediaQuery.of(context).size.width;

//     return StreamBuilder<bool>(
//       initialData: false,
//       stream: isSideBarOpenedStream,
//       builder: (context, isSideBarOpenedAsync) {
//         return AnimatedPositioned(
//           duration: _animationDuration,
//           top: 60,
//           bottom: 0,
//           left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
//           right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20,),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.centerRight,
//                         colors: [
//                           Color(0xFF03E5B7),
//                           Color(0xFF08C8F6),
//                           Color(0xFF48A9FE),
//                         ]
//                     ),
//                   ),
//                   // color: Colors.white,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 100,),
//                       ListTile(
//                         title: Text("Admin",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 30,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                         subtitle: Text("admin@gmail.com",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 20,
//                           // fontWeight: FontWeight.normal,
//                         ),
//                         ),
//                         leading: CircleAvatar(
//                           child: Icon(
//                             Icons.perm_identity,
//                             color: Colors.white,
//                           ),
//                           radius: 40,
//                         ),
//                       ),
//                       Divider(
//                         height: 64,
//                         thickness: 0.5,
//                         color: Colors.white,
//                         indent: 32,
//                         endIndent: 32,
//                       ),
//                       InkWell(
//                         child: MenuItem(
//                           icon: Icons.home,
//                           title: "Home",
//                         ),
//                         onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SideBarLayout()));},
//                       ),
//                       InkWell(
//                         child: MenuItem(
//                           icon: Icons.notifications_active_outlined,
//                            title: "Notification",
//                         ),
//                         onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));},
//                       ),
//                       InkWell(
//                         splashColor: Colors.blue,
//                         highlightColor: Colors.cyanAccent,
//                         child: MenuItem(
//                           icon: Icons.info_outlined,
//                           title: "About",
//                         ),
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
//                         },
//                       ),
//                       InkWell(
//                         child: MenuItem(
//                           icon: Icons.settings,
//                           title: "Setting",
//                         ),
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
//                         },
//                       ),
//                       Divider(
//                         height: 64,
//                         thickness: 0.5,
//                         color: Colors.white,
//                         indent: 32,
//                         endIndent: 32,
//                       ),
//                       InkWell(
//                         splashColor: Colors.redAccent,
//                         highlightColor: Colors.limeAccent,
//                         child: MenuItem(
//                           icon: Icons.logout,
//                           title: "Logout",
//                         ),
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               Align(
//                 alignment: Alignment(0,-0.9),
//                 child: GestureDetector(
//                   onTap: (){
//                     onIconPressed();
//                   },
//                   child: ClipPath(
//                     clipper: CustomMenuClipper(),
//                     child: Container(
//                       width: 35,
//                       height: 110,
//                       // decoration: BoxDecoration(
//                       //   //borderRadius: BorderRadius.circular(50),
//                       //   gradient: LinearGradient(
//                       //       begin: Alignment.centerLeft,
//                       //       end: Alignment.centerRight,
//                       //       colors: [
//                       //         Color(0xFF03E5B7),
//                       //         Color(0xFF08C8F6),
//                       //         Color(0xFF48A9FE),
//                       //       ]
//                       //   ),
//                       // ),
//                       color: Colors.blue,
//                       alignment: Alignment.centerLeft,
//                       child: AnimatedIcon(
//                         progress: _animationController.view,
//                         icon: AnimatedIcons.menu_close,
//                         color: Colors.white,
//                         size: 25,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


// // CUSTOME MENU CLIPPER
// class CustomMenuClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Paint paint = Paint();
//     paint.color = Colors.white;

//     final width = size.width;
//     final height = size.height;

//     Path path = Path();
//     path.moveTo(0, 0);
//     path.quadraticBezierTo(0, 8, 10, 16);
//     path.quadraticBezierTo(width-1, height/2-20, width, height/2);
//     path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
//     path.quadraticBezierTo(0, height-8, 0, height);
//     path.close();
    
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
  
// }