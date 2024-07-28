class Kurye {
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String job;
  final String uid;

  Kurye({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.job,
    required this.uid,
  });

  //fromJson
  factory Kurye.fromJson(Map<String, dynamic> json) {
    return Kurye(
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      job: json['job'] as String,
      uid: json['uid'] as String,
    );
  }
  //intial
  factory Kurye.initial() {
    return Kurye(
      name: '',
      surname: '',
      email: '',
      phoneNumber: '',
      job: '',
      uid: '',
    );
  }
}
