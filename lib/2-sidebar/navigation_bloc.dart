// import 'package:bloc/bloc.dart';
// import 'package:m_eye_gui/2-sidebar/sidebar_layout.dart';

// enum NavigationEvents {
//   HomePageClickEvent,
//   SettingClickEvent,
//   AboutClickEvent,
//   LogoutClickEvent,
// }

// abstract class NavigationStates{}

// class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
//   NavigationBloc(NavigationStates initialState) : super(initialState);

//   @override
//   NavigationStates? get initialState => SideBarLayout();

//   @override
//   Stream<NavigationStates>? mapEventToState(NavigationEvents event) async*{
//     switch(event) {
//       case NavigationEvents.HomePageClickEvent:
//         yield SideBarLayout();
//         break;
//       case NavigationEvents.SettingClickEvent:
//         yield SideBarLayout();
//         break;
//       case NavigationEvents.AboutClickEvent:
//         yield SideBarLayout();
//         break;
//       case NavigationEvents.LogoutClickEvent:
//         yield SideBarLayout();
//         break;
//     }
//   }

// }