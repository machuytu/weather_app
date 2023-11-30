class Constants {
  // Key api weather
  static const String keyWeather = "6e83123f83cc54e3567c70820696fb81";

  // Key api google places
  static const String keyGooglePlaces =
      "AIzaSyDtLxBSzPRNpy-u_bALJbNCAcpAlKvky5Y";

  static RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.\-_]+@(?=[a-zA-Z0-9\-_])(?=[a-zA-Z0-9.\-_])[a-zA-Z0-9.\-_]{1,}(?=[a-zA-Z0-9\-_]).\.(?=[a-zA-Z0-9])[a-zA-Z0-9]{2,}$");
}
