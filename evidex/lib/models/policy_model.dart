class PolicyModel {
  final String title;
  final String description;

  PolicyModel({
    required this.title,
    required this.description,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
