class ServiceProvider {
  final String name;
  final String profession;
  final String description;
  final String phone;
  final bool isIndividual;

  // Constructor
  ServiceProvider({
    required this.name,
    required this.profession,
    required this.description,
    required this.phone,
    required this.isIndividual,
  });

  // toString method
  @override
  String toString() {
    return 'Name: $name \nProfession: $profession \nPhone: $phone \nDescription: $description';
  }
}