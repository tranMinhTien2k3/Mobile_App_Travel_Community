import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Views/country_detail.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/get_firebase_data_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  final String userId;
  const FavoriteScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<String>> favoriteCountriesAsyncValue = ref.watch(getCountryFavoriteProvider(userId));
    final userAsyncValue = ref.watch(userProvider);
    return Scaffold(
      body: userAsyncValue.when(
        data: (user){
          final userId = user?.uid?? '';
          return favoriteCountriesAsyncValue.when(
            data: (countries){
              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index){
                  final country = countries[index];
                  final countryName = country[1];
                  final iso2 = country[2];
                  return ListTile(
                    title: Text(countryName),
                    onTap:() => Navigator.push (
                      context,
                      MaterialPageRoute(
                        builder:(context) => CountryDetail(
                          name: countryName,
                          iso2: iso2,
                          userId: userId,
                        )
                      )
                    ),
                  );
                  
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error'),)
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error'),)
      ),
    );
  }
}