class Recipe {
  final List<dynamic>? notificationid;
  final String? recipename;
  final int? dose;
  final String? recipetype;
  final int? interval;
  final String? starttime;

  Recipe(
      {this.notificationid,
      this.recipename,
      this.dose,
      this.recipetype,
      this.interval,
      this.starttime});

  //getters
  List<dynamic> get getid => notificationid!;
  String get getrecipename => recipename!;
  int get getdose => dose!;
  String get getrecipetype => recipetype!;
  int get getinterval => interval!;
  String get getstarttime => starttime!;

  Map<String, dynamic> toJson() {
    return {
      'id': notificationid,
      'name': recipename,
      'dose': dose,
      'type': recipetype,
      'interval': interval,
      'starttime': starttime
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> paredJson) {
    return Recipe(
        notificationid: paredJson['id'],
        recipename: paredJson['name'],
        dose: paredJson['dose'],
        recipetype: paredJson['type'],
        interval: paredJson['interval'],
        starttime: paredJson['starttime']);
  }
}
