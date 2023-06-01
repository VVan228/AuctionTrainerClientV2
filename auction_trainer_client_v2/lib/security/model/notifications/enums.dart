enum Status {
  SAVED, SCHEDULED, ONGOING, ENDED
}
enum IntervalType {
  LOT, LOT_PAUSE, ROUND, ROUND_PAUSE
}

enum PayloadType {
  RoomEvent, UserJoined, UserLeft
}
enum SortType {
  Popular, New
}

Map<String, SortType> sortMap = {
  "popular": SortType.Popular,
  "new": SortType.New,
};
Map<SortType, String> sortMapReverse = {
  SortType.Popular: "popular",
  SortType.New: "new",
};
Map<String, Status> statusMap = {
  "SAVED": Status.SAVED,
  "SCHEDULED": Status.SCHEDULED,
  "ONGOING": Status.ONGOING,
  "ENDED": Status.ENDED,
};
Map<String, PayloadType> payloadTypeMap = {
  "room:event": PayloadType.RoomEvent,
  "users:joinedRoom": PayloadType.UserJoined,
  "users:leftRoom": PayloadType.UserLeft,
};
Map<PayloadType, String> payloadTypeMapReverse = {
  PayloadType.RoomEvent: "room:event",
  PayloadType.UserJoined: "users:joinedRoom",
  PayloadType.UserLeft: "users:leftRoom",
};
Map<String, IntervalType> intervalTypeMap = {
  "LOT": IntervalType.LOT,
  "LOT_PAUSE": IntervalType.LOT_PAUSE,
  "ROUND": IntervalType.ROUND,
  "ROUND_PAUSE": IntervalType.ROUND_PAUSE,
};

Status statusFromString(String str) {
  Status? res = statusMap[str];
  return res??=Status.SAVED;
}
IntervalType intervalTypeFromString(String str) {
  IntervalType? res = intervalTypeMap[str];
  return res??=IntervalType.ROUND;
}

PayloadType payloadTypeFromString(String str){
  return payloadTypeMap[str] ?? PayloadType.UserLeft;
}


String sortToString(SortType type) {
  return sortMapReverse[type] ?? "";
}