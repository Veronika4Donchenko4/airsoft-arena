import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SporeVariantRecord extends FirestoreRecord {
  SporeVariantRecord._(
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
      FirebaseFirestore.instance.collection('SporeVariant');

  static Stream<SporeVariantRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SporeVariantRecord.fromSnapshot(s));

  static Future<SporeVariantRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SporeVariantRecord.fromSnapshot(s));

  static SporeVariantRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SporeVariantRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SporeVariantRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SporeVariantRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SporeVariantRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SporeVariantRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSporeVariantRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class SporeVariantRecordDocumentEquality
    implements Equality<SporeVariantRecord> {
  const SporeVariantRecordDocumentEquality();

  @override
  bool equals(SporeVariantRecord? e1, SporeVariantRecord? e2) {
    return e1?.name == e2?.name;
  }

  @override
  int hash(SporeVariantRecord? e) => const ListEquality().hash([e?.name]);

  @override
  bool isValidKey(Object? o) => o is SporeVariantRecord;
}
