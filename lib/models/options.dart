class Options {
  final String titre;

  Options({
    this.titre,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      titre: json['titre'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $titre}';
  }
}
