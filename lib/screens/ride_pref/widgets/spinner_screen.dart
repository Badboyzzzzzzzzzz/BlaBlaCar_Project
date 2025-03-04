import 'package:flutter/material.dart';

class SpinnerScreen extends StatefulWidget {
  const SpinnerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpinnerScreenState createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen> {
  int _passengerCount = 1;

  void _incrementPassenger() {
    if (_passengerCount < 8) {
      setState(() {
        _passengerCount++;
      });
    }
  }

  void _decrementPassenger() {
    if (_passengerCount > 1) {
      setState(() {
        _passengerCount--;
      });
    }
  }

  void _savePassengerCount() {
    Navigator.of(context)
        .pop(_passengerCount); // Return the count to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Passengers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementPassenger,
                ),
                Text(
                  '$_passengerCount',
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementPassenger,
                ),
              ],
            ),
            SizedBox(
                height:
                    20), // Add some space between the counter and the button
            ElevatedButton(
              onPressed: _savePassengerCount,
              child: Text('Save'), // Button to save the count
            ),
          ],
        ),
      ),
    );
  }
}
