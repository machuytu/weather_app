import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import '../../presentation/res/constant.dart';

class GetListPrediction {
  /// Fetches autocomplete predictions based on a query.
  /// [location] can be any text will match with country, city, address,...
  Future<FindAutocompletePredictionsResponse> call(String location) async {
    /// Init google places
    FlutterGooglePlacesSdk googlePlace =
        FlutterGooglePlacesSdk(Constants.keyGooglePlaces);

    return await googlePlace.findAutocompletePredictions(location);
  }
}
