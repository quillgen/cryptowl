import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture(
        AssetBytesLoader("assets/images/cryptowl-full.svg.vec"),
        height: 50,
      ),
    );
  }
}
