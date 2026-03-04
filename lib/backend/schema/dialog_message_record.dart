import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DialogMessageRecord extends FirestoreRecord {
  DialogMessageRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "dialog" field.
  DocumentReference? _dialog;
  DocumentReference? get dialog => _dialog;
  bool hasDialog() => _dialog != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _user = snapshotData['user'] as DocumentReference?;
    _images = getDataList(snapshotData['images']);
    _dialog = snapshotData['dialog'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DialogMessage');

  static Stream<DialogMessageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DialogMessageRecord.fromSnapshot(s));

  static Future<DialogMessageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DialogMessageRecord.fromSnapshot(s));

  static DialogMessageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DialogMessageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DialogMessageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DialogMessageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DialogMessageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DialogMessageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDialogMessageRecordData({
  String? text,
  DateTime? dateTime,
  DocumentReference? user,
  DocumentReference? dialog,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'dateTime': dateTime,
      'user': user,
      'dialog': dialog,
    }.withoutNulls,
  );

  return firestoreData;
}

class DialogMessageRecordDocumentEquality
    implements Equality<DialogMessageRecord> {
  const DialogMessageRecordDocumentEquality();

  @override
  bool equals(DialogMessageRecord? e1, DialogMessageRecord? e2) {
    const listEquality = ListEquality();
    return e1?.text == e2?.text &&
        e1?.dateTime == e2?.dateTime &&
        e1?.user == e2?.user &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.dialog == e2?.dialog;
  }

  @override
  int hash(DialogMessageRecord? e) => const ListEquality()
      .hash([e?.text, e?.dateTime, e?.user, e?.images, e?.dialog]);

  @override
  bool isValidKey(Object? o) => o is DialogMessageRecord;
}
