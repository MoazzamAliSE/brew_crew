import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
 final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900]; 
  //form values
  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew Settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars,
                    items: sugars.map((sugars) {
                      return DropdownMenuItem(
                        value: sugars,
                        child: Text('$sugars sugar'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(
                      () {
                        _currentSugars = val.toString();
                      },
                    ),
                  ),
                  //slider
                  Slider(
                    value: (_currentStrength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength],
                    inactiveColor:
                        Colors.brown[_currentStrength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                  ),
                  //
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? snapshot.data!.sugars,
                              _currentName ?? snapshot.data!.name,
                              _currentStrength ?? snapshot.data!.strength);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }

                      // print(_currentName);
                      // print(_currentSugars);
                      // print(_currentStrength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
