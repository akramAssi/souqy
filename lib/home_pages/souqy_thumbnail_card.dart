import 'package:flutter/material.dart';

class SouqyThumbnailCard extends StatelessWidget {
  final String path;
  SouqyThumbnailCard({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 135,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(path),
          // image: AssetImage('lib/mo/kia-op.jpg'),
        ),
      ),
    );
  }
}
