import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Views/city_detail.dart';
import 'package:travel_app/repositories/api_provider.dart';

class CityListScreen extends ConsumerWidget {
  final String iso2;
  final String name;

  CityListScreen({required this.iso2, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProvider(iso2));

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities in $name'),
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