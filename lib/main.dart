import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double? _numberFrom;
  String? _startMeasure = 'meters';
  String? _convertedMeasure = "kilometers";
  String? _resultMessage;

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  void convert(double value, String? from, String? to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage = """${_numberFrom.toString()} $_startMeasure are
${result.toString()} $_convertedMeasure""";
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  void initState() {
    _numberFrom = 0;

    super.initState();
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];

    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'value',
                    style: labelStyle,
                  ),
                ),
                TextField(
                  style: inputStyle,
                  decoration: InputDecoration(
                    hintText: "Please insert the measure to be converted",
                  ),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberFrom = rv;
                      });
                    } else {
                      setState(() {
                        _numberFrom = 0;
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      (_numberFrom == null) ? '' : _numberFrom.toString(),
                      style: labelStyle),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'From',
                    style: labelStyle,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  value: _startMeasure,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _startMeasure = value!;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'To',
                    style: labelStyle,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: inputStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _convertedMeasure = value;
                    });
                  },
                  value: _convertedMeasure,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    child: Text('Convert', style: inputStyle),
                    onPressed: () {
                      if (_startMeasure==null ||
                          _convertedMeasure==null ||
                          _numberFrom == 0) {
                        return;
                      } else {
                        convert(_numberFrom!, _startMeasure, _convertedMeasure);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      (_resultMessage == null) ? '' : _resultMessage.toString(),
                      style: labelStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
