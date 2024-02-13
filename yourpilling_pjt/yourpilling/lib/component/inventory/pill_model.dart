class PillModel {
  final int pillId;
  final int remains;
  final int totalCount;
  var takeWeekdays;

  // final int available;

  PillModel({
    required this.pillId,
    required this.remains,
    required this.totalCount,
    this.takeWeekdays,
    // this.available
  });

  Map toJson() => {
        'pillId': pillId,
        'remains': remains,
        'totalCount': totalCount,
        'takeWeekdays': ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
      };

  PillModel.fromJson(Map json)
      : pillId = json['pillId'],
        remains = json['remains'],
        totalCount = json['totalCount'],
        takeWeekdays = json['takeWeekdays'];
}
