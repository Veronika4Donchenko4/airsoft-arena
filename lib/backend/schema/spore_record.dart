import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SporeRecord extends FirestoreRecord {
  SporeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  bool hasTeam() => _team != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  // "sporeVariant" field.
  DocumentReference? _sporeVariant;
  DocumentReference? get sporeVariant => _sporeVariant;
  bool hasSporeVariant() => _sporeVariant != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _team = snapshotData['team'] as DocumentReference?;
    _description = snapshotData['description'] as String?;
    _game = snapshotData['game'] as DocumentReference?;
    _sporeVariant = snapshotData['sporeVariant'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Spore');

  static Stream<SporeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SporeRecord.fromSnapshot(s));

  static Future<SporeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SporeRecord.fromSnapshot(s));

  static SporeRecord fromSnapshot(DocumentSnapshot snapshot) => SporeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SporeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SporeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SporeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SporeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSporeRecordData({
  String? name,
  DocumentReference? user,
  DocumentReference? team,
  String? description,
  DocumentReference? game,
  DocumentReference? sporeVariant,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'user': user,
      'team': team,
      'description': description,
      'game': game,
      'sporeVariant': sporeVariant,
    }.withoutNulls,
  );

  return firestoreData;
}

class SporeRecordDocumentEquality implements Equality<SporeRecord> {
  const SporeRecordDocumentEquality();

  @override
  bool equals(SporeRecord? e1, SporeRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.user == e2?.user &&
        e1?.team == e2?.team &&
        e1?.description == e2?.description &&
        e1?.game == e2?.game &&
        e1?.sporeVariant == e2?.sporeVariant;
  }

  @override
  int hash(SporeRecord? e) => const ListEquality().hash(
      [e?.name, e?.user, e?.team, e?.description, e?.game, e?.sporeVariant]);

  @override
  bool isValidKey(Object? o) => o is SporeRecord;
}
