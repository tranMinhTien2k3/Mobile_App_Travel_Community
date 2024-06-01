// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:travel_app/models/country_model.dart';
// import 'package:travel_app/repositories/api_provider.dart';
// import 'package:travel_app/repositories/city_repository.dart';
// import 'package:travel_app/services/api_service.dart';

// final apiProvider = Provider((ref) => ApiService());



// class CountryListScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countryListAsyncValue = ref.watch(countryProvider2);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách quốc gia'),
//       ),
//       body: countryListAsyncValue.when(
//         data: (countries) => ListView.builder(
//           itemCount: countries.length,
//           itemBuilder: (context, index) {
//             final country = countries[index];
//             return ListTile(
//               title: Text(country.name),
//               // subtitle: Text('Region: ${country.region}'),
//               leading: Text(country.iso2),
//             );
//           },
//         ),
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Đã xảy ra lỗi: $error')),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/api_provider.dart';


class CountryListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsyncValue = ref.watch(countryProvider2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      body: countriesAsyncValue.when(
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return ListTile(
              title: Text(country.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityListWidget(iso2: country.iso2, name: country.name,),
                  ),
                );
              },
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}




class CityListWidget extends ConsumerWidget {
  final String iso2, name;

  CityListWidget({required this.iso2, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProvider(iso2));

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities in $name'),
      ),
      body: citiesAsyncValue.when(
        data: (cities) {
          print('Rendering cities: $cities'); // Debug log
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                title: Text(city.name),
                subtitle: Text('Population: ${city.population}'),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('Error: $error'); // Debug log
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}