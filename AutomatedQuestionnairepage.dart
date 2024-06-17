import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Automatedquestionnairepage(),
    );
  }
}

class Automatedquestionnairepage extends StatefulWidget {
  get userIdProfile => userIdProfile;

  int get userId =>12 ;

  @override
  _AutomatedquestionnairepageState createState() => _AutomatedquestionnairepageState();
}

class _AutomatedquestionnairepageState extends State<Automatedquestionnairepage> {
  double _budgetRange = 0;
  double _budgetRange1 = 0;
  String? _selectedProvince;
  String? _selectedLength;
  bool _isChecked = false;
  TextEditingController _studyFieldController = TextEditingController();
  TextEditingController _additionalCriteriaController = TextEditingController();

  Future<void> _submitData() async {
    try {
      final url = Uri.parse('https://syfer001testing.000webhostapp.com/cloneapi/Automatedquestionnairepg.php');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'user_id': widget.userId.toString(),
          'budget_range': _budgetRange.toString(),
          'province': _selectedProvince ?? '',
          'study_field': _studyFieldController.text,
          'program_length': _selectedLength ?? '',
          'scholarships_available': _isChecked ? '1' : '0',
          'application_fee': _budgetRange1.toString(),
          'additional_criteria': _additionalCriteriaController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Handle the response data as needed
      } else {
        // Handle the failure
      }
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automated Questionnaire"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.grey),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Tuition Budget",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "0",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Slider(
                      value: _budgetRange,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _budgetRange.round().toString(),
                      activeColor: Colors.green,
                      onChanged: (double value) {
                        setState(() {
                          _budgetRange = value;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "100",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Province",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Province',
                ),
                value: _selectedProvince,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                  });
                },
                items: <String>[
                  'Ontario',
                  'Manitoba',
                  'Nova Scotia',
                  'Alberta',
                  'Northwest Territories'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "Study Field",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              TextField(
                controller: _studyFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your study field',
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Length Of Program",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Program Length',
                ),
                value: _selectedLength,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLength = newValue;
                  });
                },
                items: <String>['1 Year', '2 Year', '3 Year', '4 Year', '5 Year']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "Checkbox",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    activeColor: Colors.cyan,
                  ),
                  Text('Scholarships Available'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Application Fee",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "0",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Slider(
                      value: _budgetRange1,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _budgetRange1.round().toString(),
                      activeColor: Colors.green,
                      onChanged: (double value) {
                        setState(() {
                          _budgetRange1 = value;
                        });
                      },
                    ),
                  ),
                  const Text(
                    "100",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Additional Criteria",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              TextField(
                controller: _additionalCriteriaController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter any additional criteria',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
