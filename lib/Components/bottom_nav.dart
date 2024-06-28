// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/gestures.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
// // import 'package:hooks_riverpod/hooks_riverpod.dart';
// // import 'package:travel_app/Views/favorite_screen.dart';
// // import 'package:travel_app/Views/home_page.dart';
// // import 'package:travel_app/Views/profile_page.dart';
// // import 'package:travel_app/Views/setting.dart';
// // import 'package:travel_app/repositories/page_state_provider.dart';



// // class BottomNav extends ConsumerWidget {
// //   BottomNav({super.key});

// //   final List<Widget> _pages = [
// //   const Home_Page(),
// //   const FavoriteScreen(userId: ''),
// //   const ProfilePage(),
// //   const SettingPage(),
// //   ];

  

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final currentPage = ref.watch(currentPageProvider);
// //     final pageController = ref.watch(pageControllerProvider);
// //     final tabController = ref.watch(tabControllerProvider);
// //     final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
// //     final bool isBacgroundLight = backgroundColor.computeLuminance() > 0.5;
// //     final color = isBacgroundLight ? Colors.black : Colors.white;

// //     // final List<Icon> icon =   [
// //     // Icon(Icons.home_filled),
// //     // Icon(Icons.favorite),
// //     // Icon(Icons.person),
// //     // Icon(Icons.settings)
// //     // ];

// //     return Scaffold(
// //       body: BottomBar(
// //         child: TabBar(
// //           controller: tabController,
// //           indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
// //           indicator: UnderlineTabIndicator(
// //             borderSide: BorderSide(
// //               color: color,
// //               width: 4
// //             ),
// //             insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
// //           ),
// //           tabs: [
// //             SizedBox(
// //               height: 55,
// //               width: 40,
// //               child: Center(
// //                 child: Icon(
// //                   Icons.home_filled,
// //                   color: isBacgroundLight ? Colors.black : Colors.white,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 55,
// //               width: 40,
// //               child: Center(
// //                 child: Icon(
// //                   Icons.favorite,
// //                   color: isBacgroundLight ? Colors.black : Colors.white,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 55,
// //               width: 40,
// //               child: Center(
// //                 child: Icon(
// //                   Icons.person,
// //                   color: isBacgroundLight ? Colors.black : Colors.white,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 55,
// //               width: 40,
// //               child: Center(
// //                 child: Icon(
// //                   Icons.settings,
// //                   color: isBacgroundLight ? Colors.black : Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         borderRadius: BorderRadius.circular(500),
// //         duration: Duration(seconds: 1),
// //         curve: Curves.decelerate,
// //         showIcon: true,
// //         width: MediaQuery.of(context).size.width * 0.8,
// //         barColor: backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white ,
// //         start: 2,
// //         end: 0,
// //         offset: 10,
// //         barAlignment: Alignment.bottomCenter,
// //         iconHeight: 35,
// //         iconWidth: 35,
// //         hideOnScroll: true,
// //         scrollOpposite: false,
// //         body: (context, controller) => TabBarView(
// //           controller: tabController,
// //           dragStartBehavior: DragStartBehavior.down,
// //           physics: const BouncingScrollPhysics(),
// //           children: _pages,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
// import 'package:travel_app/Views/favorite_screen.dart';
// import 'package:travel_app/Views/home_page.dart';
// import 'package:travel_app/Views/profile_page.dart';
// import 'package:travel_app/Views/setting.dart';
// import 'package:travel_app/repositories/page_state_provider.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class BottomNav extends StatefulWidget {
//   BottomNav({Key? key}) : super(key: key);

//   @override
//   _BottomNavState createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final List<Widget> _pages = [
//     const Home_Page(),
//     const FavoriteScreen(userId: ''),
//     const ProfilePage(),
//     const SettingPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
//     final bool isBackgroundLight = backgroundColor.computeLuminance() > 0.5;
//     final color = isBackgroundLight ? Colors.black : Colors.white;

//     return Scaffold(
//       body: BottomBar(
//         child: TabBar(
//           controller: _tabController,
//           indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(
//               color: color,
//               width: 4,
//             ),
//             insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
//           ),
//           tabs: [
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                 child: Icon(
//                   Icons.home_filled,
//                   color: isBackgroundLight ? Colors.black : Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                 child: Icon(
//                   Icons.favorite,
//                   color: isBackgroundLight ? Colors.black : Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                 child: Icon(
//                   Icons.person,
//                   color: isBackgroundLight ? Colors.black : Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: 40,
//               child: Center(
//                 child: Icon(
//                   Icons.settings,
//                   color: isBackgroundLight ? Colors.black : Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(500),
//         duration: Duration(seconds: 1),
//         curve: Curves.decelerate,
//         showIcon: true,
//         width: MediaQuery.of(context).size.width * 0.8,
//         barColor: backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
//         start: 2,
//         end: 0,
//         offset: 10,
//         barAlignment: Alignment.bottomCenter,
//         iconHeight: 35,
//         iconWidth: 35,
//         hideOnScroll: true,
//         scrollOpposite: false,
//         body: (context, controller) => TabBarView(
//           controller: _tabController,
//           dragStartBehavior: DragStartBehavior.down,
//           physics: const BouncingScrollPhysics(),
//           children: _pages,
//         ),
//       ),
//     );
//   }
// }
