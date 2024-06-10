import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/repositories/api_provider.dart';


class CountryListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsyncValue = ref.watch(countriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Countries List'),
      ),
      body: countriesAsyncValue.when(
        data: (countries) {
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];
              return ListTile(
                title: Text(country.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityListScreen(iso2: country.iso2),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}


class CityListScreen extends ConsumerWidget {
  final String iso2;

  CityListScreen({required this.iso2});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProvider(iso2));

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities in $iso2'),
      ),
      body: citiesAsyncValue.when(
        data: (cities) {
          if (cities.isEmpty) {
            return Center(child: Text('No cities found'));
          }
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                title: Text(city.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityDetailsScreen(city: city.name),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}


class CityDetailsScreen extends ConsumerWidget {
  final String city;

  CityDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combinedDataFuture = Future.wait([
      ref.read(wikiProvider(city).future), // Đọc dữ liệu từ WikiProvider
      ref.read(imageProvider(city).future), // Đọc dữ liệu từ ImageProvider
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details for $city'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: combinedDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error loading data: ${snapshot.error}');
          } else {
            final List<dynamic> combinedData = snapshot.data!;

            final wikiData = combinedData[0] as Map<String, dynamic>;
            final imageUrl = combinedData[1] as String;

            // Hiển thị dữ liệu trong giao diện
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Hiển thị hình ảnh của thành phố
                Image.network(
                  imageUrl,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                // Hiển thị thông tin từ Wikipedia
                Text(wikiData['extract'] != null ? wikiData['extract'] : 'No data available from Wikipedia'),
              ],
            );
          }
        },
      ),
    );
  }
}