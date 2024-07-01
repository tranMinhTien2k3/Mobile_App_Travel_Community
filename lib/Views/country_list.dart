
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:travel_app/Views/cities_list.dart';
// import 'package:travel_app/Views/country_detail.dart';
// import 'package:travel_app/repositories/api_provider.dart';
// import 'package:travel_app/repositories/auth_provider.dart';


// class CountryListScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countriesAsyncValue = ref.watch(countriesProvider);
//     final userAsyncValue = ref.watch(userProvider);

//     return Scaffold(
//       body: countriesAsyncValue.when(
//         data: (countries) {
//           return ListView.builder(
//             itemCount: countries.length,
//             itemBuilder: (context, index) {
//               final country = countries[index];
//               return ListTile(
//                 title: Text(country.name),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CountryDetail( name: country.name, iso2: country.iso2,),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/repositories/api_provider.dart';
import 'package:travel_app/Views/country_detail.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class CountryListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsyncValue = ref.watch(countriesProvider);
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      body: userAsyncValue.when(
        data: (user) {
          final userId = user?.uid ?? ''; // Lấy userId từ userProvider

          return countriesAsyncValue.when(
            data: (countries) {
              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ListTile(
                      title: Text(country.name),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryDetail(
                              name: country.name,
                              iso2: country.iso2,
                              userId: userId, // Truyền userId vào CountryDetail
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
