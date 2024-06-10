// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:travel_app/Widgets/big_text.dart';
// // import 'package:travel_app/repositories/api_provider.dart';

// // class CountryInfor extends ConsumerWidget {
// //   const CountryInfor({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final countriesAsyncValue = ref.watch(countryProvider2);
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: BigText(
// //           text: 'Country infor',
// //           size: 20,
// //           color: Colors.black,
// //         ),
// //       ),
// //       body: countriesAsyncValue.when(
// //         data: (countries) => ListView.builder(
// //           itemCount: countries.length,
// //           itemBuilder: (context, index){
// //             Padding(
// //               padding: EdgeInsets.all(24),
// //               child: Wrap(
// //                 spacing: 10,
// //                 runSpacing: 10,
// //                 children: [
// //                   for(var i = 0; i < index; i++){
// //                     GestureDetector(
// //                       onTap: ,
// //                     )
// //                   }
// //                 ],
// //               ),
// //             )
// //           },
// //         ), 
// //         error: (error, stack) => Center(child: Text('Error: $error')), 
// //         loading: () => Center(child: CircularProgressIndicator())
// //       )
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:travel_app/repositories/api_provider.dart';



// class CountryListWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countriesAsyncValue = ref.watch(countryProvider2);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countries'),
//       ),
//       body: countriesAsyncValue.when(
//         data: (countries) => ListView.builder(
//           itemCount: countries.length,
//           itemBuilder: (context, index) {
//             final country = countries[index];
//             return ListTile(
//               title: Text(country.name),
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => CountryInfor(countryName: country.name,),
//                 //   ),
//                 // );
//               },
//             );
//           },
//         ),
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }

// // class CountryInfor extends ConsumerWidget {
// //   final String countryName;

// //   CountryInfor({required this.countryName});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     // Đọc dữ liệu từ provider
// //     final photoAsyncValue = ref.watch(photoProvider(countryName));

// //     return photoAsyncValue.when(
// //       data: (photoUrl) => Image.network(photoUrl), // Hiển thị ảnh nếu có dữ liệu
// //       loading: () => CircularProgressIndicator(), // Hiển thị tiến trình nếu đang tải
// //       error: (error, stack) => Text('Error: $error'), // Hiển thị thông báo lỗi nếu có lỗi
// //     );
// //   }
// // }