// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Hcm23User {
  final String? password;
  final String? email;

  Hcm23User({
    this.password,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'email': email,
    };
  }

  factory Hcm23User.fromMap(Map<String, dynamic> map) {
    return Hcm23User(
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hcm23User.fromJson(String source) =>
      Hcm23User.fromMap(json.decode(source) as Map<String, dynamic>);

  Hcm23User copyWith({
    String? password,
    String? email,
  }) {
    return Hcm23User(
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
}

class UserX {
  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final String? phoneNumber;
  final String? photoURL;
  final String? uid;
  UserX({
    this.uid,
    this.displayName,
    this.email,
    this.emailVerified,
    this.phoneNumber,
    this.photoURL,
  });

  static UserX default$({
    required String uid,
    required String email,
  }) =>
      UserX(
        uid: uid,
        email: email,
        displayName: "User",
        emailVerified: false,
        phoneNumber: "",
        photoURL: "",
      );

  UserX copyWith({
    String? displayName,
    String? email,
    bool? emailVerified,
    String? phoneNumber,
    String? photoURL,
    String? uid,
  }) {
    return UserX(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'uid': uid,
    };
  }

  factory UserX.fromMap(Map<String, dynamic> map) {
    return UserX(
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      emailVerified:
          map['emailVerified'] != null ? map['emailVerified'] as bool : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserX.fromJson(String source) =>
      UserX.fromMap(json.decode(source) as Map<String, dynamic>);
}
