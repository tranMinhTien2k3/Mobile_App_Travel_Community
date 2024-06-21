
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/services/api_service.dart';


void showReviewSheet(BuildContext context){
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context){
      final double sheetHeight = MediaQuery.of(context).size.height * 0.41;

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Container(
          height: sheetHeight,
          child: ReviewSheet(),
        ),
      );
    }
  );
}

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({super.key});

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {

  final TextEditingController typeAheadController = TextEditingController();
  final TextEditingController cityChosseController = TextEditingController();
  final TextEditingController reviewTextController = TextEditingController();
  final ApiService _apiService =  ApiService();
  final FocusNode focusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();



  String countryIso2s = '';

  Country? _selectedCountry;

  Future<List<Country>> _getCountrySuggestion(String query) async{
    List<Country>  countries = await _apiService.fetchCountries();
    // countryIso2s = countries.map((country) => country.iso2).toList();
    // print(countryIso2s);
    List<Country> filteredCountries = countries.where((country) => country.iso2.toLowerCase().contains(query.toLowerCase())).toList();
    print(filteredCountries);
    return filteredCountries;
  } 

  void _conCountrySelected(Country country) async{
    setState(() {
      _selectedCountry = country;
      typeAheadController.text = country.name;
      // print(typeAheadController);
      countryIso2s = country.iso2;
      // print(countryIso2s);
    });

   
  }

  void _oncitySelected(City city){
    cityChosseController.text = city.name;
  }

  Future<List<City>> _getCitySuggestion(countryIso2s) async{
    List<City> cities = await _apiService.fetchCities(countryIso2s);
    return cities;
  }




  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: 'Chosse the place',
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.only(top: 100),
                width: 150,
                child: TypeAheadField<Country>(
                  hideOnUnfocus: true,
                  builder: (context, controller, focusNode){
                      return TextField(
                        controller: typeAheadController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Country'
                        ),
                      );
                    },
                    itemBuilder: (context, sugesstion){
                      print('DATA COUNTRY: ${sugesstion.name}');
                      return ListTile(
                        title: Text(sugesstion.name),
                      );
                    } , 
                    onSelected: (Country country){
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _conCountrySelected(country);
                      });
                      
                    }, 
                    suggestionsCallback: (parttern) => _getCountrySuggestion(parttern)
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  // margin: EdgeInsets.only(top: 100),
                  width: 150,
                  child: TypeAheadField(
                    builder: (context, controller, focusNode){
                      return TextField(
                        controller: cityChosseController,
                        focusNode: cityFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'City'
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) => _getCitySuggestion(pattern),
                    itemBuilder: (context, sugesstion){
                      print('DATA NE: ${sugesstion.name}');
                      return ListTile(
                        title: Text(sugesstion.name),
                      );
                    }, 
                    onSelected: _oncitySelected,
                    
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BigText(
              text: 'Leave your tips or review here',
            ),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: TextField(
                controller: reviewTextController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (){},
                child: Text('Submit'),
              ),
            )
          ],
        ),
    );
  }
}