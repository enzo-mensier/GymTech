enum Genre {
  homme,
  femme,
  autre;

  String get value {
    switch (this) {
      case Genre.homme:
        return 'Homme';
      case Genre.femme:
        return 'Femme';
      case Genre.autre:
        return 'Autre';
    }
  }

  static Genre fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'homme':
        return Genre.homme;
      case 'femme':
        return Genre.femme;
      case 'autre':
        return Genre.autre;
      default:
        throw ArgumentError('Genre invalide: $value');
    }
  }

  String get displayName => value;

  static List<String> get displayValues =>
      Genre.values.map((genre) => genre.value).toList();

  static List<String> get displayNames =>
      Genre.values.map((genre) => genre.displayName).toList();
}
