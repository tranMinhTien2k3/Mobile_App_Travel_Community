import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Views/country_detail.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/favorite_provider.dart';
import 'package:travel_app/repositories/get_firebase_data_provider.dart';
import 'package:travel_app/repositories/theme_notifier.dart';

class FavoriteCountryList extends ConsumerWidget {
  final String userId;
  const FavoriteCountryList({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final favoritesCountriesAsyncValue = ref.watch(getCountryFavoriteProvider(userId));
    final favoritesCountriesAsyncValue = ref.watch(getCountriesFavoriteProvider(userId));
    final userAsyncValue = ref.watch(userProvider);
    final favoriteController = ref.watch(favoriteManagerProvider);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;
    
    return Container(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: SingleChildScrollView(
          child: userAsyncValue.when(
            data: (user){
              final userId = user?.uid?? '';
              print(userId);
              return favoritesCountriesAsyncValue.when(
                data: (countries){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: countries.length,
                    itemBuilder: (context, index){
                      final country = countries[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: const Icon(Icons.delete, color: Colors.white, size: 35,),
                        ),
                        onDismissed: (direction){                     
                          favoriteController.removeFromFavorite(country.name);
                          showToast(message: 'Remove ${country.name} successful');
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: ListTile(
                            title: Text(country.name, style: TextStyle(color: isDarkMode? Colors.white : Colors.black),),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap:() => Navigator.push (
                              context,
                              MaterialPageRoute(
                                builder:(context) => CountryDetail(
                                  name: country.name,
                                  iso2: country.iso2,
                                  userId: userId,
                                )
                              )
                            ),
                          ),
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
        ),
      ),
    );
  }
}