class AbilityListModel {
  AbilityListModel({
    this.name,
    this.description,
    this.logoUrl,
  });

  String name;
  String description;
  String logoUrl;

  factory AbilityListModel.fromJson(Map<String, dynamic> json) =>
      AbilityListModel(
        name: json["name"],
        description: json["description"],
        logoUrl: json["logo_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "logo_url": logoUrl,
      };
}
