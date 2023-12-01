import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/model/location_model.dart';
import 'package:weather_app/domain/usecase/get_current_weather.dart';
import 'package:weather_app/domain/usecase/get_list_predictions.dart';
import 'package:weather_app/domain/usecase/get_location.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:weather_app/presentation/res/colors_data.dart';
import 'package:weather_app/presentation/res/text_data.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';
import 'package:weather_app/presentation/util/common_dialog.dart';
import 'package:weather_app/presentation/widget/another_flushbar.dart';
import '../../../../domain/usecase/get_list_five_days_weather.dart';
import '../../../../data/local/shared_preferences.dart';

class WidgetSearchBar extends StatefulWidget {
  final InitPageBloc _initPageBloc;
  const WidgetSearchBar(InitPageBloc initPageBloc, {Key? key})
      : _initPageBloc = initPageBloc,
        super(key: key);

  @override
  State<WidgetSearchBar> createState() => _WidgetSearchBarState();
}

class _WidgetSearchBarState extends State<WidgetSearchBar> {
  /// Use Google api to search place
  List<AutocompletePrediction> _predictions = [];

  /// Get place information
  GetLocation getLocation = GetLocation();

  /// Get list predictions with textfield
  GetListPrediction getListPrediction = GetListPrediction();

  /// Get current weather
  GetCurrentWeather getCurrentWeather = GetCurrentWeather();

  /// Get list weather 5 day / 3hr forecast from openweathermap
  GetListFiveDaysWeather getListFiveDaysWeather = GetListFiveDaysWeather();

  /// Local data
  SharedPref sharedPref = SharedPref();

  final TextEditingController _searchController =
      TextEditingController(text: "");
  DialogService dialogService = DialogService();

  @override
  void dispose() {
    _searchController.dispose();
    _predictions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SearchBar(
            onChanged: (value) {
              if (value.isNotEmpty) {
                _autoCompleteSearch(value);
              } else {
                _clearPredictions();
              }
            },
            trailing: <Widget>[
              if (_searchController.text.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _clearPredictions();
                  },
                  icon: const Icon(Icons.close),
                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                ),
            ],
            controller: _searchController,
            hintText: "Find location/country",
            backgroundColor:
                MaterialStateProperty.all(ColorsData.backgroundContainer),
          ),
          if (_predictions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsData.backgroundContainer,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _predictions.length,
                  itemBuilder: (context, index) {
                    final item = _predictions[index];
                    return ListTile(
                      onTap: () => _chooseLocation(item, context),
                      title: Text(
                        item.primaryText,
                        style: TextData.bodyText2,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// clear list search and search field text
  void _clearPredictions() {
    return setState(() {
      _searchController.text = "";
      _predictions = [];
    });
  }

  _chooseLocation(AutocompletePrediction item, BuildContext context) async {
    FlushBar flushBar = FlushBar();
    try {
      _searchController.text = item.primaryText;
      FocusScope.of(context).unfocus();
      dialogService.showLoaderDialogShort(context);
      // Get the location from the placeId
      final res = await getLocation.call(item.placeId);
      final lat = res.place!.latLng!.lat;
      final lng = res.place!.latLng!.lng;
      // Get current weather from openweathermap
      Weather forecast = await getCurrentWeather.call(lat, lng);

      // Get list weather 5 day / 3hr forecast from openweathermap
      List<Weather> listForecast = await getListFiveDaysWeather.call(lat, lng);

      // Store last location chose by the user
      LocationModel locationModel = LocationModel(lat: lat, lng: lng);
      sharedPref.save(
          "fetchPlaceResponse", json.encode(locationModel.toJson()));

      Get.back();
      widget._initPageBloc.add(LoadInitPageEvent(forecast, listForecast));
      _predictions = [];
      setState(() {});
    } catch (e) {
      _clearPredictions();
      Get.back();
      // If check failed with fetchPlace or forecast error arlet for user try again
      flushBar.showFlushBar(
          title: "Not have weather on this location, try again");
    }
  }

  /// Search word by word of location
  Future<void> _autoCompleteSearch(String value) async {
    var result = await getListPrediction.call(value);
    if (mounted) {
      setState(() {
        _predictions = result.predictions;
      });
    }
  }
}
