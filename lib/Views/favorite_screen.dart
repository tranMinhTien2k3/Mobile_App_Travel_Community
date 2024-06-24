import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/form/favorite_city_list.dart';
import 'package:travel_app/form/favorite_country_list.dart';

final selectedViewProvider = StateProvider<int>((ref) => 0);
class FavoriteScreen extends ConsumerWidget {
  final userId;
  const FavoriteScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedIndex = ref.watch(selectedViewProvider);

    final List<Widget> views = [
      FavoriteCountryList(userId: userId),
      FavoriteCityList(userId: userId),
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: ToggleButtons(
              // borderColor: Colors.blue.shade800,
              // selectedBorderColor: Colors.blue.shade800,
              fillColor: Colors.white,
              selectedColor: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(10),
              isSelected: [selectedIndex == 0, selectedIndex == 1],
              onPressed: (int index){
                ref.read(selectedViewProvider.notifier).state = index;
              },
              children:  [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Country'),
                  ),
                ),
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('City'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: selectedIndex == 0
                ? FavoriteCountryList(userId: userId)
                : FavoriteCityList(userId: userId),
          )
        ],
      ),
    );
  }
}