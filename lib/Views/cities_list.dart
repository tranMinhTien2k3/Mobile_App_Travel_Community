import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Components/bottom_nav.dart';
import 'package:travel_app/Views/city_detail.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/repositories/api_provider.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/route_transition.dart';
import 'package:travel_app/repositories/theme_notifier.dart';

class CityListScreen extends ConsumerWidget {
  final String iso2;
  final String name;

  CityListScreen({required this.iso2, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsyncValue = ref.watch(citiesProvider(name));
    final userAsyncValue = ref.watch(userProvider);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;

    return Scaffold(
      appBar: AppBar(
        title: BigText(text: 'City List', color: isDarkMode ? ColorList.white70 : Colors.black,),
        automaticallyImplyLeading: false,
      ),
      body: userAsyncValue.when(
        data: (user) {
          final userId = user?.uid ?? ''; // Lấy userId từ userProvider

          return citiesAsyncValue.when(
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
                            builder: (context) => CityDetailsScreen(
                              name: country.name,
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