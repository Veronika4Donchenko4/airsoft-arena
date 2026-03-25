import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameRoundUserRecord extends FirestoreRecord {
  GameRoundUserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "kills" field.
  int? _kills;
  int get kills => _kills ?? 0;
  bool hasKills() => _kills != null;

  // "isDead" field.
  bool? _isDead;
  bool get isDead => _isDead ?? false;
  bool hasIsDead() => _isDead != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  bool hasTeam() => _team != null;

  // "isReady" field.
  bool? _isReady;
  bool get isReady => _isReady ?? false;
  bool hasIsReady() => _isReady != null;

  // "roundReference" field.
  DocumentReference? _roundReference;
  DocumentReference? get roundReference => _roundReference;
  bool hasRoundReference() => _roundReference != null;

  // "attended" field.
  bool? _attended;
  bool get attended => _attended ?? false;
  bool hasAttended() => _attended != null;

  void _initializeFields() {
    _game = snapshotData['game'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _kills = castToType<int>(snapshotData['kills']);
    _isDead = snapshotData['isDead'] as bool?;
    _rating = castToType<double>(snapshotData['rating']);
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _team = snapshotData['team'] as DocumentReference?;
    _isReady = snapshotData['isReady'] as bool?;
    _roundReference = snapshotData['roundReference'] as DocumentReference?;
    _attended = snapshotData['attended'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('GameRoundUser');

  static Stream<GameRoundUserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameRoundUserRecord.fromSnapshot(s));

  static Future<GameRoundUserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameRoundUserRecord.fromSnapshot(s));

  static GameRoundUserRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GameRoundUserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameRoundUserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameRoundUserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameRoundUserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameRoundUserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameRoundUserRecordData({
  DocumentReference? game,
  DocumentReference? user,
  int? kills,
  bool? isDead,
  double? rating,
  DateTime? dateTime,
  DocumentReference? team,
  bool? isReady,
  DocumentReference? roundReference,
  bool? attended,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'game': game,
      'user': user,
      'kills': kills,
      'isDead': isDead,
      'rating': rating,
      'dateTime': dateTime,
      'team': team,
      'isReady': isReady,
      'roundReference': roundReference,
      'attended': attended,
    }.withoutNulls,
  );

  return firestoreData;
}

class GameRoundUserRecordDocumentEquality
    implements Equality<GameRoundUserRecord> {
  const GameRoundUserRecordDocumentEquality();

  @override
  bool equals(GameRoundUserRecord? e1, GameRoundUserRecord? e2) {
    return e1?.game == e2?.game &&
        e1?.user == e2?.user &&
        e1?.kills == e2?.kills &&
        e1?.isDead == e2?.isDead &&
        e1?.rating == e2?.rating &&
        e1?.dateTime == e2?.dateTime &&
        e1?.team == e2?.team &&
        e1?.isReady == e2?.isReady &&
        e1?.roundReference == e2?.roundReference &&
        e1?.attended == e2?.attended;
  }

  @override
  int hash(GameRoundUserRecord? e) => const ListEquality().hash([
        e?.game,
        e?.user,
        e?.kills,
        e?.isDead,
        e?.rating,
        e?.dateTime,
        e?.team,
        e?.isReady,
        e?.roundReference
      ]);

  @override
  bool isValidKey(Object? o) => o is GameRoundUserRecord;
}
