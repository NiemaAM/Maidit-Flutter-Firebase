// ignore_for_file: file_names

class UserHistory {
  String? maidId = '';
  String? service = '';
  int? serviceState = 0;
  DateTime? serviceDate = DateTime(0, 0, 0);

  UserHistory({
    this.maidId,
    this.service,
    this.serviceState,
    this.serviceDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'maidId': maidId,
      'service': service,
      'serviceState': serviceState,
      'serviceDate': serviceDate!.toIso8601String(),
    };
  }

  factory UserHistory.fromMap(Map<String, dynamic> map) {
    return UserHistory(
      maidId: map['maidId'] ?? '',
      service: map['service'] ?? '',
      serviceState: map['serviceState'] ?? 0,
      serviceDate: map['serviceDate'] != null
          ? DateTime.parse(map['serviceDate'])
          : DateTime(0, 0, 0),
    );
  }
}
