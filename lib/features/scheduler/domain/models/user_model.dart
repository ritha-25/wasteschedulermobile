class UserScheduleModel {
  final String uid;
  final String fullname;
  final String sector;
  final String collectionDay;
  final String shiftTime;

  UserScheduleModel({
    required this.uid,
    required this.fullname,
    required this.sector,
    required this.collectionDay,
    required this.shiftTime,
  });

  factory UserScheduleModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return UserScheduleModel(
      uid: documentId,
      fullname: map['fullname'] ?? '',
      sector: map['sector'] ?? '',
      collectionDay: map['collectionname'] ?? 'pending',
      shiftTime: map['shiftTime'] ?? 'Morning',
    );
  }
    Map<String, dynamic> toMap() {
      return {
        'fullname': fullname,
        'sector': sector,
        'collectionDay': collectionDay,
        'shiftTime': shiftTime,
      };

    }

  }

