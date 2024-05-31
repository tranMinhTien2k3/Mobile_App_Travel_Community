import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/country_model.dart';
import 'package:travel_app/repositories/city_repository.dart';
import 'package:travel_app/services/api_service.dart';

final apiProvider = Provider((ref) => ApiService());



class CountryListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryListAsyncValue = ref.watch(countryProvider2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách quốc gia'),
      ),
      body: countryListAsyncValue.when(
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return ListTile(
              title: Text(country.name),
              // subtitle: Text('Region: ${country.region}'),
              leading: Text(country.iso2),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Đã xảy ra lỗi: $error')),
      ),
    );
  }
}

