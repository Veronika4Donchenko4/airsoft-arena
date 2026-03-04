import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ComplaintsRecord extends FirestoreRecord {
  ComplaintsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Complaints');

  static Stream<ComplaintsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ComplaintsRecord.fromSnapshot(s));

  static Future<ComplaintsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ComplaintsRecord.fromSnapshot(s));

  static ComplaintsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ComplaintsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ComplaintsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ComplaintsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ComplaintsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ComplaintsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createComplaintsRecordData({
  String? name,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class ComplaintsRecordDocumentEquality implements Equality<ComplaintsRecord> {
  const ComplaintsRecordDocumentEquality();

  @override
  bool equals(ComplaintsRecord? e1, ComplaintsRecord? e2) {
    return e1?.name == e2?.name && e1?.index == e2?.index;
  }

  @override
  int hash(ComplaintsRecord? e) =>
      const ListEquality().hash([e?.name, e?.index]);

  @override
  bool isValidKey(Object? o) => o is ComplaintsRecord;
}
