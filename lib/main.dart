import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LengthConversionScreen(),
    );
  }
}

class LengthConversionScreen extends StatefulWidget {
  @override
  _LengthConversionScreenState createState() => _LengthConversionScreenState();
}

class _LengthConversionScreenState extends State<LengthConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';

  final Map<String, double> _conversionRates = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Miles': 0.000621371,
    'Inches': 39.3701,
    'Centimeters': 100.0,
    'Feet': 3.28084,
  };

  void _convert() {
    double? input = double.tryParse(_controller.text);
    if (input != null) {
      double meters = input / _conversionRates[_fromUnit]!;
      double resultValue = meters * _conversionRates[_toUnit]!;
      setState(() {
        _result = '$input $_fromUnit = ${resultValue.toStringAsFixed(4)} $_toUnit';
      });
    } else {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Length Conversion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromUnit = newValue!;
                      });
                    },
                    items: _conversionRates.keys.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ),
                Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toUnit = newValue!;
                      });
                    },
                    items: _conversionRates.keys.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
