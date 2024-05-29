import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/repositories/repository_provider.dart';



class CityListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: citiesAsyncValue.when(
        data: (either) {
          return either.fold(
            (failure) => Center(child: Text(failure)),
            (cities) {
              return ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return ListTile(
                    title: Text(city.name),
                    subtitle: Text(city.country),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(city: city),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load cities: $error')),
      ),
    );
  }
}

class CityDetailPage extends ConsumerWidget {
  final City city;

  CityDetailPage({required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityHistoryAsyncValue = ref.watch(cityHistoryProvider(city.name));
    final cityPhotoAsyncValue = ref.watch(cityPhotoProvider(city.name));

    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: cityHistoryAsyncValue.when(
        data: (either) {
          return either.fold(
            (failure) => Center(child: Text(failure)),
            (history) {
              return Column(
                children: [
                  Text('City: ${city.name}'),
                  Text('Country: ${city.country}'),
                  Text('Population: ${city.population}'),
                  Text('History: $history'),
                  Expanded(
                    child: cityPhotoAsyncValue.when(
                      data: (either) {
                        return either.fold(
                          (failure) => Center(child: Text(failure)),
                          (photo) {
                            return Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    photo.urls['small']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    photo.description ?? 'No description',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (error, stack) => Text('Failed to load photo: $error'),
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Failed to load city history: $error'),
      ),
    );
  }
}
