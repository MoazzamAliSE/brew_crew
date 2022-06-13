import 'package:flutter/material.dart';

import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  // const BrewTile({Key? key}) : super(key: key);
  final Brew brew;
  const BrewTile({
    Key? key,
    required this.brew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: const AssetImage('assets/coffeeCircle.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
