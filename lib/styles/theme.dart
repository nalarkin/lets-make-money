import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

const TextTheme appTextTheme = TextTheme(
    headline1:
        TextStyle(fontSize: 96.0, fontFamily: 'Roboto', color: kTextColor),
    headline2:
        TextStyle(fontSize: 60.0, fontFamily: 'Roboto', color: kTextColor),
    headline3:
        TextStyle(fontSize: 48.0, fontFamily: 'Roboto', color: kTextColor),
    headline4:
        TextStyle(fontSize: 34.0, fontFamily: 'Roboto', color: kTextColor),
    headline5:
        TextStyle(fontSize: 24.0, fontFamily: 'Roboto', color: kTextColor),
    headline6:
        TextStyle(fontSize: 20.0, fontFamily: 'Roboto', color: kTextColor),
    bodyText1:
        TextStyle(fontSize: 16.0, fontFamily: 'Roboto', color: kTextColor),
    bodyText2:
        TextStyle(fontSize: 14.0, fontFamily: 'Roboto', color: kTextColor),
    button: TextStyle(fontSize: 14.0, fontFamily: 'Roboto', color: kTextColor),
    caption: TextStyle(fontSize: 12.0, fontFamily: 'Roboto', color: kTextColor),
    overline:
        TextStyle(fontSize: 10.0, fontFamily: 'Roboto', color: kTextColor));

ThemeData appThemeData = ThemeData(
  colorScheme: appColorScheme,
  textTheme: appTextTheme,
);


ColorScheme appColorScheme = ColorScheme.fromSwatch(
  accentColor:
      kAccentColor, // // The foreground color for widgets (knobs, text, overscroll edge effect, etc
  primarySwatch:
      kPrimarySwatch, //  The color displayed most frequently across your app’s screens and components.
  cardColor: kCardColor,
  errorColor: kErrorColor,
  backgroundColor: kBackgroundColor,
  brightness: kBrightness,
  primaryColorDark: kPrimaryColorDark,
);

// const AppBarTheme appBarTheme = AppBarTheme(
//   backgroundColor:
//       kAppBarBackgroundColor, // The fill color to use for an app bar's Material.
//   elevation:
//       0, // This property controls the size of the shadow below the app bar.
//   foregroundColor:
//       kAppBarForegroundColor, // The default color for Text and Icons within the app bar.
//   // iconTheme: , // The color, opacity, and size to use for toolbar icons.
//   // textTheme: , // Overrides the default value of the obsolete AppBar.textTheme property in all descendant AppBar widgets.
//   // titleTextStyle: , // The default text style for the AppBar's title widget.
// );

// ColorScheme appColorScheme = ColorScheme(
  
//   primaryVariant:
//       kPrimaryVariantColor, //  A darker version of the primary color.
//   secondary:
//       kSecondaryColor, //  An accent color that, when used sparingly, calls attention to parts of your app.
//   secondaryVariant:
//       kSecondaryVariantColor, //  A darker version of the secondary color.
//   surface: kSurfaceColor, //  The background color for widgets like Card.
//   background:
//       kBackgroundColor, //  A color that typically appears behind scrollable content.
//   error:
//       kErrorColor, //  The color to use for input validation errors, e.g. for InputDecoration.errorText.
//   onPrimary:
//       kOnPrimaryColor, //  A color that's clearly legible when drawn on primary. [...]
//   onSecondary: kOnSecondaryColor, //  A darker version of the secondary color.
//   onSurface: kOnSurfaceColor,

//   /// A color that's clearly legible when drawn on surface.
//   onBackground:
//       kOnBackgroundColor, //  A color that's clearly legible when drawn on background. [...]
//   onError:
//       kOnErrorColor, //  A color that's clearly legible when drawn on error. [...]
//   brightness: kBrightness, //  The overall brightness of this color scheme.
// );
