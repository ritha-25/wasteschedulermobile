import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? fullName;
  final String? email;
  final String? phone;
  final List<String> authMethods;
  final String? district;
  final String? sector;
  final String? cell;
  final String? village;
  final String? street;
  final String? gateNumber;
  final String? concessionaire;
  final List<String> collectionDays;
  final String? binType;
  final bool onboardingComplete;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    this.fullName,
    this.email,
    this.phone,
    this.authMethods = const [],
    this.district,
    this.sector,
    this.cell,
    this.village,
    this.street,
    this.gateNumber,
    this.concessionaire,
    this.collectionDays = const [],
    this.binType,
    this.onboardingComplete = false,
    required this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      uid: id,
      fullName: map['fullName'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      authMethods: List<String>.from(map['authMethods'] ?? []),
      district: map['district'] as String?,
      sector: map['sector'] as String?,
      cell: map['cell'] as String?,
      village: map['village'] as String?,
      street: map['street'] as String?,
      gateNumber: map['gateNumber'] as String?,
      concessionaire: map['concessionaire'] as String?,
      collectionDays: List<String>.from(map['collectionDays'] ?? []),
      binType: map['binType'] as String?,
      onboardingComplete: map['onboardingComplete'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'authMethods': authMethods,
      'district': district,
      'sector': sector,
      'cell': cell,
      'village': village,
      'street': street,
      'gateNumber': gateNumber,
      'concessionaire': concessionaire,
      'collectionDays': collectionDays,
      'binType': binType,
      'onboardingComplete': onboardingComplete,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  AppUser copyWith({
    String? fullName,
    String? email,
    String? phone,
    List<String>? authMethods,
    String? district,
    String? sector,
    String? cell,
    String? village,
    String? street,
    String? gateNumber,
    String? concessionaire,
    List<String>? collectionDays,
    String? binType,
    bool? onboardingComplete,
    DateTime? createdAt,
  }) {
    return AppUser(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      authMethods: authMethods ?? this.authMethods,
      district: district ?? this.district,
      sector: sector ?? this.sector,
      cell: cell ?? this.cell,
      village: village ?? this.village,
      street: street ?? this.street,
      gateNumber: gateNumber ?? this.gateNumber,
      concessionaire: concessionaire ?? this.concessionaire,
      collectionDays: collectionDays ?? this.collectionDays,
      binType: binType ?? this.binType,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
