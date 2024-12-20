import 'package:flutter/material.dart';
import 'service_provider.dart';

// List of providers
final List<ServiceProvider> providers = [
  ServiceProvider(
      name: 'John Doe',
      profession: 'Plumber',
      description: 'Experienced plumber with 10+ years of expertise.',
      phone: '0711223344',
      isIndividual: true),
  ServiceProvider(
      name: 'FixIt Co.',
      profession: 'Plumber',
      description: 'Reliable plumbing services for residential needs.',
      phone: '0123456789',
      isIndividual: false),
  ServiceProvider(
      name: 'Sarah Smith',
      profession: 'Electrician',
      description: 'Certified electrician specializing in home wiring.',
      phone: '0787654321',
      isIndividual: true),
  ServiceProvider(
      name: 'Bright Sparks Inc.',
      profession: 'Electrician',
      description: 'Top-notch electrical services for all projects.',
      phone: '0712345678',
      isIndividual: false),
  ServiceProvider(
      name: 'Mike Brown',
      profession: 'Carpenter',
      description: 'Custom furniture and woodwork expert.',
      phone: '0719876543',
      isIndividual: true),
  ServiceProvider(
      name: 'Crafted Solutions',
      profession: 'Carpenter',
      description: 'Tailored carpentry for modern designs.',
      phone: '0112233445',
      isIndividual: false),
  ServiceProvider(
      name: 'Paul Johnson',
      profession: 'Painter',
      description: 'Professional painter for homes and offices.',
      phone: '0723456789',
      isIndividual: true),
  ServiceProvider(
      name: 'ColorPro Ltd.',
      profession: 'Painter',
      description: 'Premium painting services with durable finishes.',
      phone: '0745678901',
      isIndividual: false),
  ServiceProvider(
      name: 'Anna Lee',
      profession: 'Gardener',
      description: 'Experienced in landscaping and garden care.',
      phone: '0798765432',
      isIndividual: true),
  ServiceProvider(
      name: 'Green Thumb Services',
      profession: 'Gardener',
      description: 'Expert garden maintenance and design.',
      phone: '0754321987',
      isIndividual: false),
];

//main function
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Providers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ServiceProviderScreen(),
    );
  }
}

class ServiceProviderScreen extends StatefulWidget {
  @override
  _ServiceProviderScreenState createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  String selectedType = "Any";
  String? selectedProfession;
  String? selectedProvider;

  // Filter providers based on type and profession
  List<ServiceProvider> getFilteredProviders() {
    return providers.where((provider) {
      final matchesType = selectedType == "Any" ||
          (selectedType == "Individual" && provider.isIndividual) ||
          (selectedType == "Company" && !provider.isIndividual);

      final matchesProfession = selectedProfession == null ||
          provider.profession == selectedProfession;

      return matchesType && matchesProfession;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final professions =
        providers.map((provider) => provider.profession).toSet().toList();
    final filteredProviders = getFilteredProviders();

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Providers"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Title
            Text(
              "Service Providers",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Radio Buttons for Type
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Individual",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                          selectedProvider = null;
                        });
                      },
                    ),
                    Text("Individual"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Company",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                          selectedProvider = null;
                        });
                      },
                    ),
                    Text("Company"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Any",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                          selectedProvider = null;
                        });
                      },
                    ),
                    Text("Any"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Profession Dropdown
            DropdownButton<String>(
              hint: Text("Select Profession"),
              value: selectedProfession,
              isExpanded: true,
              items: professions.map((profession) {
                return DropdownMenuItem<String>(
                  value: profession,
                  child: Text(profession),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProfession = value;
                  selectedProvider = null;
                });
              },
            ),
            SizedBox(height: 20),

            // Provider Dropdown
            DropdownButton<String>(
              hint: Text("Select Provider"),
              value: selectedProvider,
              isExpanded: true,
              items: filteredProviders.map((provider) {
                return DropdownMenuItem<String>(
                  value: provider.name,
                  child: Text(provider.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProvider = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Provider Details
            if (selectedProvider != null)
              ...filteredProviders
                  .where((provider) => provider.name == selectedProvider)
                  .map((provider) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("Profession: ${provider.profession}"),
                        Text("Phone: ${provider.phone}"),
                        Text("Description: ${provider.description}"),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
