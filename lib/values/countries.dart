import 'package:flutter/material.dart';

const List<Map<String, dynamic>> countries = [
  {
    'country': 'India',
    'states': [
      {
        'state': 'Karnataka',
        'districts': [
          {
            'district': 'Bangalore Urban',
            'cities': ['Bangalore']
          },
          {
            'district': 'Mysore',
            'cities': ['Mysore']
          }
        ]
      },
      {
        'state': 'Tamil Nadu',
        'districts': [
          {
            'district': 'Chennai',
            'cities': ['Chennai']
          },
          {
            'district': 'Coimbatore',
            'cities': ['Coimbatore']
          }
        ]
      },
      {
        'state': 'Kerala',
        'districts': [
          {
            'district': 'Ernakulam',
            'cities': ['Kochi']
          },
          {
            'district': 'Thiruvananthapuram',
            'cities': ['Thiruvananthapuram']
          }
        ]
      },
      {
        'state': 'Andhra Pradesh',
        'districts': [
          {
            'district': 'Visakhapatnam',
            'cities': ['Visakhapatnam']
          },
          {
            'district': 'Vijayawada',
            'cities': ['Vijayawada']
          }
        ]
      },
      {
        'state': 'Telangana',
        'districts': [
          {
            'district': 'Hyderabad',
            'cities': ['Hyderabad']
          },
          {
            'district': 'Warangal',
            'cities': ['Warangal']
          }
        ]
      }
    ]
  }
];

class CountrySelector extends StatefulWidget {
  final Function(Map) onChanged;
  final Map? counryStateDistrictCity;
  const CountrySelector({
    super.key,
    required this.onChanged,
    this.counryStateDistrictCity,
  });

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  String? selectedCountry;
  String? selectedState;
  String? selectedDistrict;
  String? selectedCity;

  @override
  void initState() {
    selectedCountry = widget.counryStateDistrictCity?['country'];
    selectedState = widget.counryStateDistrictCity?['state'];
    selectedDistrict = widget.counryStateDistrictCity?['district'];
    selectedCity = widget.counryStateDistrictCity?['city'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Select Country, State, District & City'),
        const SizedBox(height: 10),
        DropdownButton<String>(
          hint: Text('Select Country'),
          value: selectedCountry,
          isExpanded: true,
          borderRadius: BorderRadius.circular(15),
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
              selectedState = null;
              selectedDistrict = null;
              selectedCity = null;
            });

            widget.onChanged({
              'country': selectedCountry,
              'state': null,
              'district': null,
              'city': null,
            });
          },
          items: countries.map((country) {
            return DropdownMenuItem<String>(
              value: country['country'],
              child: Text(country['country']),
            );
          }).toList(),
        ),
        if (selectedCountry != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select State'),
              value: selectedState,
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedDistrict = null;
                  selectedCity = null;
                });
                widget.onChanged({
                  'country': selectedCountry,
                  'state': selectedState,
                  'district': null,
                  'city': null,
                });
              },
              items: countries
                  .firstWhere((country) =>
                      country['country'] == selectedCountry)['states']
                  .map<DropdownMenuItem<String>>((state) {
                return DropdownMenuItem<String>(
                  value: state['state'],
                  child: Text(state['state']),
                );
              }).toList(),
            ),
          ),
        if (selectedState != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select District'),
              value: selectedDistrict,
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedCity = null;
                });
                widget.onChanged({
                  'country': selectedCountry,
                  'state': selectedState,
                  'district': selectedDistrict,
                  'city': null,
                });
              },
              items: countries
                  .firstWhere((country) =>
                      country['country'] == selectedCountry)['states']
                  .firstWhere(
                      (state) => state['state'] == selectedState)['districts']
                  .map<DropdownMenuItem<String>>((district) {
                return DropdownMenuItem<String>(
                  value: district['district'],
                  child: Text(district['district']),
                );
              }).toList(),
            ),
          ),
        if (selectedDistrict != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select City'),
              value: selectedCity,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
                widget.onChanged({
                  'country': selectedCountry,
                  'state': selectedState,
                  'district': selectedDistrict,
                  'city': selectedCity,
                });
              },
              items: countries
                  .firstWhere((country) =>
                      country['country'] == selectedCountry)['states']
                  .firstWhere(
                      (state) => state['state'] == selectedState)['districts']
                  .firstWhere((district) =>
                      district['district'] == selectedDistrict)['cities']
                  .map<DropdownMenuItem<String>>((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
