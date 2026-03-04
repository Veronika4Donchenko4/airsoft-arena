import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamRolesRecord extends FirestoreRecord {
  TeamRolesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TeamRoles');

  static Stream<TeamRolesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeamRolesRecord.fromSnapshot(s));

  static Future<TeamRolesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeamRolesRecord.fromSnapshot(s));

  static TeamRolesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeamRolesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeamRolesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeamRolesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeamRolesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeamRolesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeamRolesRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeamRolesRecordDocumentEquality implements Equality<TeamRolesRecord> {
  const TeamRolesRecordDocumentEquality();

  @override
  bool equals(TeamRolesRecord? e1, TeamRolesRecord? e2) {
    return e1?.name == e2?.name;
  }

  @override
  int hash(TeamRolesRecord? e) => const ListEquality().hash([e?.name]);

  @override
  bool isValidKey(Object? o) => o is TeamRolesRecord;
}
