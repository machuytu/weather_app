import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/presentation/res/constant.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:weather_app/presentation/res/text_data.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';
import 'package:weather_app/presentation/screen/init_page/init_page_bloc.dart';
import 'package:weather_app/presentation/util/common_dialog.dart';
import 'package:weather_app/presentation/widget/another_flushbar.dart';

class WidgetSearchBar extends StatefulWidget {
  final InitPageBloc _initPageBloc;
  const WidgetSearchBar(InitPageBloc initPageBloc, {Key? key})
      : _initPageBloc = initPageBloc,
        super(key: key);

  @override
  State<WidgetSearchBar> createState() => _WidgetSearchBarState();
}

class _WidgetSearchBarState extends State<WidgetSearchBar> {
  //* Package of openweathermap
  late WeatherFactory wf;
  // Use Google api to search place
  late FlutterGooglePlacesSdk googlePlace;
  List<AutocompletePrediction> predictions = [];
  // get place information
  List<PlaceField> placeFields = [
    PlaceField.Address,
    PlaceField.AddressComponents,
    PlaceField.BusinessStatus,
    PlaceField.Id,
    PlaceField.Location,
    PlaceField.Name,
    PlaceField.OpeningHours,
    PlaceField.PhoneNumber,
    PlaceField.PhotoMetadatas,
    PlaceField.PlusCode,
    PlaceField.PriceLevel,
    PlaceField.Rating,
    PlaceField.Types,
    PlaceField.UserRatingsTotal,
    PlaceField.UTCOffset,
    PlaceField.Viewport,
    PlaceField.WebsiteUri,
  ];

  TextEditingController searchController = TextEditingController(text: "");

  @override
  void initState() {
    // Init google places
    googlePlace = FlutterGooglePlacesSdk(Constants.keyGooglePlaces);
    // Init weather api
    wf = WeatherFactory(Constants.keyWeather);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    predictions.clear();
    placeFields.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SearchBar(
            controller: searchController,
            hintText: "Location",
            trailing: <Widget>[
              if (searchController.text.isNotEmpty)
                IconButton(
                  onPressed: () {
                    clearPredictions();
                  },
                  icon: const Icon(Icons.close),
                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                ),
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                autoCompleteSearch(value);
              } else {
                clearPredictions();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                final item = predictions[index];
                return Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: ListTile(
                    onTap: () => chooseLocation(item, context),
                    title: Text(
                      item.primaryText,
                      style: TextData.bodyText,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // clear list search and search field text
  void clearPredictions() {
    return setState(() {
      searchController.text = "";
      predictions = [];
    });
  }

  chooseLocation(AutocompletePrediction item, BuildContext context) async {
    FlushBar flushBar = FlushBar();
    try {
      DialogService dialogService = DialogService();
      dialogService.showLoaderDialogShort(context);
      // Get the location from the placeId
      final res =
          await googlePlace.fetchPlace(item.placeId, fields: placeFields);
      // Get current weather from openweathermap
      Weather forecast = await wf.currentWeatherByLocation(
          res.place!.latLng!.lat, res.place!.latLng!.lng);
      Get.back();
      widget._initPageBloc.add(LoadInitPageEvent(forecast));
      predictions = [];
      setState(() {});
    } catch (e) {
      clearPredictions();
      Get.back();
      // if check failed with fetchPlace or forecast error arlet for user try again
      flushBar.showFlushBar(
          title: "Not have weather on this location, try again");
    }
  }

  // Search word by word of location
  Future<void> autoCompleteSearch(String value) async {
    var result = await googlePlace.findAutocompletePredictions(value);
    if (mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }
}
