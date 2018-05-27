import 'package:catbox/models/cat.dart';
import 'package:flutter/material.dart';

class DetailsShowCase extends StatelessWidget {
  final Cat cat;

  DetailsShowCase(this.cat);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Container(
        child: new Text(
          cat.description,
          textAlign: TextAlign.start,
          style: textTheme.subhead.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
