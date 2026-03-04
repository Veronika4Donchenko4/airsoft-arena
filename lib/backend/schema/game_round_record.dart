import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameRoundRecord extends FirestoreRecord {
  GameRoundRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "teamWinner" field.
  DocumentReference? _teamWinner;
  DocumentReference? get teamWinner => _teamWinner;
  bool hasTeamWinner() => _teamWinner != null;

  // "startDateTime" field.
  DateTime? _startDateTime;
  DateTime? get startDateTime => _startDateTime;
  bool hasStartDateTime() => _startDateTime != null;

  // "endDateTime" field.
  DateTime? _endDateTime;
  DateTime? get endDateTime => _endDateTime;
  bool hasEndDateTime() => _endDateTime != null;

  // "roundUsers" field.
  List<DocumentReference>? _roundUsers;
  List<DocumentReference> get roundUsers => _roundUsers ?? const [];
  bool hasRoundUsers() => _roundUsers != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _teamWinner = snapshotData['teamWinner'] as DocumentReference?;
    _startDateTime = snapshotData['startDateTime'] as DateTime?;
    _endDateTime = snapshotData['endDateTime'] as DateTime?;
    _roundUsers = getDataList(snapshotData['roundUsers']);
    _status = castToType<int>(snapshotData['status']);
    _game = snapshotData['game'] as DocumentReference?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('GameRound');

  static Stream<GameRoundRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameRoundRecord.fromSnapshot(s));

  static Future<GameRoundRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameRoundRecord.fromSnapshot(s));

  static GameRoundRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GameRoundRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameRoundRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameRoundRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameRoundRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameRoundRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameRoundRecordData({
  DocumentReference? teamWinner,
  DateTime? startDateTime,
  DateTime? endDateTime,
  int? status,
  DocumentReference? game,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'teamWinner': teamWinner,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'status': status,
      'game': game,
      'createdTime': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class GameRoundRecordDocumentEquality implements Equality<GameRoundRecord> {
  const GameRoundRecordDocumentEquality();

  @override
  bool equals(GameRoundRecord? e1, GameRoundRecord? e2) {
    const listEquality = ListEquality();
    return e1?.teamWinner == e2?.teamWinner &&
        e1?.startDateTime == e2?.startDateTime &&
        e1?.endDateTime == e2?.endDateTime &&
        listEquality.equals(e1?.roundUsers, e2?.roundUsers) &&
        e1?.status == e2?.status &&
        e1?.game == e2?.game &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(GameRoundRecord? e) => const ListEquality().hash([
        e?.teamWinner,
        e?.startDateTime,
        e?.endDateTime,
        e?.roundUsers,
        e?.status,
        e?.game,
        e?.createdTime
      ]);

  @override
  bool isValidKey(Object? o) => o is GameRoundRecord;
}
