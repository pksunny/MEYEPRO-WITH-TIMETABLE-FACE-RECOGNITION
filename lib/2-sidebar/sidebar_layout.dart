// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:m_eye_gui/3-HomeScreen/HomeScreen.dart';
// import 'navigation_bloc.dart';
// import 'sidebar.dart';

// class SideBarLayout extends StatelessWidget with NavigationStates{
//   const SideBarLayout({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: BlocProvider<NavigationBloc>(
//       //   create: (context) => NavigationBloc(),
//       //   child: Stack(
//       //     children: <Widget>[
//       //       BlocBuilder<NavigationBloc, NavigationStates>(
//       //         builder: (context, navigationState){
//       //           return navigationState as Widget;
//       //         },
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       body: Stack(
//         children: <Widget>[
//           HomeScreen(),
//           SideBar(),
//         ],
//       ),
//     );
//   }
// }
