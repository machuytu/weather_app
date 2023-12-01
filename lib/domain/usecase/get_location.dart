import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import '../../presentation/res/constant.dart';

class GetLocation {
  /// List information about the location
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

  /// Fetches the details of a place. Only the requested [fields] will
  /// be returned. If none specified, all fields will be returned.
  Future<FetchPlaceResponse> call(String placeId) async {
    /// Init google places
    FlutterGooglePlacesSdk googlePlace =
        FlutterGooglePlacesSdk(Constants.keyGooglePlaces);

    return await googlePlace.fetchPlace(placeId, fields: placeFields);
  }
}
