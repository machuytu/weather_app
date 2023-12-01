# Weather App

A basic Flutter mobile app that fetches and displays current weather information for a given location.

## Table of Contents

- [Details](#details)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Package Credits](#package-credits)
- [Evaluation Criteria](#evaluation-criteria)
- [Credits](#credits)

## Details

### Project: Weather App

#### Objective

Create a basic Flutter mobile app that fetches and displays current weather information for a given location.

#### Requirements

1. **Location Input:** Users should be able to input a location (e.g., city name or zip code).
2. **Weather Display:** Upon entering a location, the app should fetch and display the current weather information, including:
   - Temperature (in Celsius or Fahrenheit)
   - Weather condition (e.g., sunny, cloudy, rainy)
3. **Error Handling:** Implement basic error handling for cases where the location input is invalid or the weather data cannot be retrieved.
4. **User-Friendly UI:** Design a simple and user-friendly UI.

## Getting Started

Follow these steps to set up and run the Weather App:

1. Clone the repository:

   ```bash
   git clone https://github.com/machuytu/weather_app.git
   cd weather_app
   ```

- Flutter: 3.16

2. Run project:

   ```bash
   flutter pub get
   flutter run
   ```

## Project Structure

The project follows a clean architecture structure:

- lib/data: data layer.
- lib/domain: domain layer.
- lib/presentation: presentation layer.

## Package credits

The package is built from these wonderful packages.

| Name                                                       | Features                   |
| :--------------------------------------------------------- | :------------------------- |
| [weather][weather pub]                                     | Get weather data.          |
| [flutter_google_places_sdk][flutter_google_places_sdk pub] | Get place with google api. |

API KEY on file lib/presentation/res/constant.dart. This my API KEY. If it not working, please go to GooglePlacesSdk and OpenWeather to sign in and generate your API KEY

## Evaluation Criteria

### Code Quality, Structure, and Organization:

- The code is organized using the BLoC pattern for state management.
- Clear separation of concerns with distinct files for BLoC, events, states, and the repository.

### User Interface Design and User Experience:

- The UI is simple and user-friendly, allowing users to input a location easily.
- Loading and error states provide feedback to the user.

### Functionality and Adherence to Requirements:

- The app fetches current weather information for a given location using the OpenWeatherMap API.
- Temperature and weather conditions are displayed.
- Basic error handling is implemented for invalid locations or failed API requests.

### Bonus Features:

- Additional features change measure temperature (Celsius/Fahrenheit).
- Local store chose measure temperature
- Local store last chose location when re-open app
- Get list weather 5 day / 3hr forecast from openweathermap

### Documentation and Instructions:

- The code is documented with comments to explain key functionalities.
- Instructions are provided in the comments for obtaining an API key.

## Credits

Icon:

- https://www.figma.com/community/file/1126777451931792118/weather-glassmorphism-icon
- https://www.figma.com/community/file/1194413192427153067/glassmorphism-weather-icon

UI reference:

- https://www.figma.com/community/file/1100826294536456295/weather-app-ui-design
- IOS app weather

[weather pub]: https://pub.dev/packages/weather
[flutter_google_places_sdk pub]: https://pub.dev/packages/flutter_google_places_sdk
