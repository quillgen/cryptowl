import 'dart:io';

import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData apply(ThemeData baseTheme) {
    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
        titleTextStyle: Platform.isMacOS
            ? TextStyle(
                color: Colors.black,
                fontFamily: 'RobotoMono',
                fontSize: 16,
              )
            : baseTheme.appBarTheme.titleTextStyle,
      ),
    );
  }
}

/**
 * generated from: http://material-foundation.github.io/material-theme-builder/?primary=%231E3A8A&secondary=%233B82F6&tertiary=%2310B981&error=%23EF4444&neutral=%23F5F5F5&neutralVariant=%23333333&bodyFont=Open+Sans&displayFont=Inter&colorMatch=false
 */
class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4c5c92),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdce1ff),
      onPrimaryContainer: Color(0xff344479),
      secondary: Color(0xff445e91),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd8e2ff),
      onSecondaryContainer: Color(0xff2b4678),
      tertiary: Color(0xff226a4c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaaf2cc),
      onTertiaryContainer: Color(0xff005236),
      error: Color(0xff904a46),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad7),
      onErrorContainer: Color(0xff733330),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffb6c4ff),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff03174b),
      primaryFixedDim: Color(0xffb6c4ff),
      onPrimaryFixedVariant: Color(0xff344479),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a42),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff2b4678),
      tertiaryFixed: Color(0xffaaf2cc),
      onTertiaryFixed: Color(0xff002113),
      tertiaryFixedDim: Color(0xff8ed5b0),
      onTertiaryFixedVariant: Color(0xff005236),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff233367),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5b6ba2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff183566),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff536da1),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003f29),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff337a5a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e2321),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa15853),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff0c1213),
      onSurfaceVariant: Color(0xff2f3839),
      outline: Color(0xff4b5456),
      outlineVariant: Color(0xff656f70),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffb6c4ff),
      primaryFixed: Color(0xff5b6ba2),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff435288),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff536da1),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3a5487),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff337a5a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff156043),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7c9),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe3e9ea),
      surfaceContainerHigh: Color(0xffd8dedf),
      surfaceContainerHighest: Color(0xffcdd3d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff18295c),
      surfaceTint: Color(0xff4c5c92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff37467b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0a2b5b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e487a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003421),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005438),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511918),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff763632),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e2f),
      outlineVariant: Color(0xff414b4c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffb6c4ff),
      primaryFixed: Color(0xff37467b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1f2f63),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e487a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff143162),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005438),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003b26),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babb),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f3),
      surfaceContainer: Color(0xffdee3e5),
      surfaceContainerHigh: Color(0xffcfd5d6),
      surfaceContainerHighest: Color(0xffc2c7c9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb6c4ff),
      surfaceTint: Color(0xffb6c4ff),
      onPrimary: Color(0xff1d2d61),
      primaryContainer: Color(0xff344479),
      onPrimaryContainer: Color(0xffdce1ff),
      secondary: Color(0xffadc6ff),
      onSecondary: Color(0xff112f60),
      secondaryContainer: Color(0xff2b4678),
      onSecondaryContainer: Color(0xffd8e2ff),
      tertiary: Color(0xff8ed5b0),
      onTertiary: Color(0xff003824),
      tertiaryContainer: Color(0xff005236),
      onTertiaryContainer: Color(0xffaaf2cc),
      error: Color(0xffffb3ad),
      onError: Color(0xff571e1b),
      errorContainer: Color(0xff733330),
      onErrorContainer: Color(0xffffdad7),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff4c5c92),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff03174b),
      primaryFixedDim: Color(0xffb6c4ff),
      onPrimaryFixedVariant: Color(0xff344479),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a42),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff2b4678),
      tertiaryFixed: Color(0xffaaf2cc),
      onTertiaryFixed: Color(0xff002113),
      tertiaryFixedDim: Color(0xff8ed5b0),
      onTertiaryFixedVariant: Color(0xff005236),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd3dbff),
      surfaceTint: Color(0xffb6c4ff),
      onPrimary: Color(0xff102255),
      primaryContainer: Color(0xff7f8ec8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcfdcff),
      onSecondary: Color(0xff012454),
      secondaryContainer: Color(0xff7790c7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa4ecc6),
      onTertiary: Color(0xff002c1c),
      tertiaryContainer: Color(0xff599e7d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2ce),
      onError: Color(0xff481312),
      errorContainer: Color(0xffcb7b75),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dee0),
      outline: Color(0xffaab4b5),
      outlineVariant: Color(0xff889294),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff36457a),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff000d37),
      primaryFixedDim: Color(0xffb6c4ff),
      onPrimaryFixedVariant: Color(0xff233367),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff00102e),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff183566),
      tertiaryFixed: Color(0xffaaf2cc),
      onTertiaryFixed: Color(0xff00150b),
      tertiaryFixedDim: Color(0xff8ed5b0),
      onTertiaryFixedVariant: Color(0xff003f29),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff3f4647),
      surfaceContainerLowest: Color(0xff040809),
      surfaceContainerLow: Color(0xff191f20),
      surfaceContainer: Color(0xff23292a),
      surfaceContainerHigh: Color(0xff2d3435),
      surfaceContainerHighest: Color(0xff393f40),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeeefff),
      surfaceTint: Color(0xffb6c4ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb1c0fd),
      onPrimaryContainer: Color(0xff00082a),
      secondary: Color(0xffecefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffa9c2fc),
      onSecondaryContainer: Color(0xff000a22),
      tertiary: Color(0xffbaffda),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff8ad1ad),
      onTertiaryContainer: Color(0xff000e07),
      error: Color(0xffffecea),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea8),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f3),
      outlineVariant: Color(0xffbbc4c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff36457a),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb6c4ff),
      onPrimaryFixedVariant: Color(0xff000d37),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffadc6ff),
      onSecondaryFixedVariant: Color(0xff00102e),
      tertiaryFixed: Color(0xffaaf2cc),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff8ed5b0),
      onTertiaryFixedVariant: Color(0xff00150b),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff4b5152),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2122),
      surfaceContainer: Color(0xff2b3133),
      surfaceContainerHigh: Color(0xff363c3e),
      surfaceContainerHighest: Color(0xff424849),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
