import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClanRecord extends FirestoreRecord {
  ClanRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "slogan" field.
  String? _slogan;
  String get slogan => _slogan ?? '';
  bool hasSlogan() => _slogan != null;

  // "flagImage" field.
  String? _flagImage;
  String get flagImage => _flagImage ?? '';
  bool hasFlagImage() => _flagImage != null;

  // "formImage" field.
  String? _formImage;
  String get formImage => _formImage ?? '';
  bool hasFormImage() => _formImage != null;

  // "captain" field.
  DocumentReference? _captain;
  DocumentReference? get captain => _captain;
  bool hasCaptain() => _captain != null;

  // "members" field.
  List<DocumentReference>? _members;
  List<DocumentReference> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "applicationList" field.
  List<DocumentReference>? _applicationList;
  List<DocumentReference> get applicationList => _applicationList ?? const [];
  bool hasApplicationList() => _applicationList != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _slogan = snapshotData['slogan'] as String?;
    _flagImage = snapshotData['flagImage'] as String?;
    _formImage = snapshotData['formImage'] as String?;
    _captain = snapshotData['captain'] as DocumentReference?;
    _members = getDataList(snapshotData['members']);
    _applicationList = getDataList(snapshotData['applicationList']);
    _createdTime = snapshotData['createdTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Clan');

  static Stream<ClanRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ClanRecord.fromSnapshot(s));

  static Future<ClanRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ClanRecord.fromSnapshot(s));

  static ClanRecord fromSnapshot(DocumentSnapshot snapshot) => ClanRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ClanRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ClanRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ClanRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ClanRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createClanRecordData({
  String? name,
  String? slogan,
  String? flagImage,
  String? formImage,
  DocumentReference? captain,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'slogan': slogan,
      'flagImage': flagImage,
      'formImage': formImage,
      'captain': captain,
      'createdTime': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ClanRecordDocumentEquality implements Equality<ClanRecord> {
  const ClanRecordDocumentEquality();

  @override
  bool equals(ClanRecord? e1, ClanRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.slogan == e2?.slogan &&
        e1?.flagImage == e2?.flagImage &&
        e1?.formImage == e2?.formImage &&
        e1?.captain == e2?.captain &&
        listEquality.equals(e1?.members, e2?.members) &&
        listEquality.equals(e1?.applicationList, e2?.applicationList) &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(ClanRecord? e) => const ListEquality().hash([
        e?.name,
        e?.slogan,
        e?.flagImage,
        e?.formImage,
        e?.captain,
        e?.members,
        e?.applicationList,
        e?.createdTime,
      ]);

  @override
  bool isValidKey(Object? o) => o is ClanRecord;
}
