import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameUserRecord extends FirestoreRecord {
  GameUserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  // "kills" field.
  int? _kills;
  int get kills => _kills ?? 0;
  bool hasKills() => _kills != null;

  // "deth" field.
  int? _deth;
  int get deth => _deth ?? 0;
  bool hasDeth() => _deth != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  bool hasTeam() => _team != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _game = snapshotData['game'] as DocumentReference?;
    _kills = castToType<int>(snapshotData['kills']);
    _deth = castToType<int>(snapshotData['deth']);
    _team = snapshotData['team'] as DocumentReference?;
    _rating = castToType<double>(snapshotData['rating']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('GameUser');

  static Stream<GameUserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameUserRecord.fromSnapshot(s));

  static Future<GameUserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameUserRecord.fromSnapshot(s));

  static GameUserRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GameUserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameUserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameUserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameUserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameUserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameUserRecordData({
  DocumentReference? user,
  DocumentReference? game,
  int? kills,
  int? deth,
  DocumentReference? team,
  double? rating,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'game': game,
      'kills': kills,
      'deth': deth,
      'team': team,
      'rating': rating,
    }.withoutNulls,
  );

  return firestoreData;
}

class GameUserRecordDocumentEquality implements Equality<GameUserRecord> {
  const GameUserRecordDocumentEquality();

  @override
  bool equals(GameUserRecord? e1, GameUserRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.game == e2?.game &&
        e1?.kills == e2?.kills &&
        e1?.deth == e2?.deth &&
        e1?.team == e2?.team &&
        e1?.rating == e2?.rating;
  }

  @override
  int hash(GameUserRecord? e) => const ListEquality()
      .hash([e?.user, e?.game, e?.kills, e?.deth, e?.team, e?.rating]);

  @override
  bool isValidKey(Object? o) => o is GameUserRecord;
}
