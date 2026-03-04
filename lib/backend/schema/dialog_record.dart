import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DialogRecord extends FirestoreRecord {
  DialogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "lastMessageText" field.
  String? _lastMessageText;
  String get lastMessageText => _lastMessageText ?? '';
  bool hasLastMessageText() => _lastMessageText != null;

  // "lastMessageDateTime" field.
  DateTime? _lastMessageDateTime;
  DateTime? get lastMessageDateTime => _lastMessageDateTime;
  bool hasLastMessageDateTime() => _lastMessageDateTime != null;

  // "author" field.
  DocumentReference? _author;
  DocumentReference? get author => _author;
  bool hasAuthor() => _author != null;

  // "usersBlocked" field.
  List<DocumentReference>? _usersBlocked;
  List<DocumentReference> get usersBlocked => _usersBlocked ?? const [];
  bool hasUsersBlocked() => _usersBlocked != null;

  void _initializeFields() {
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _users = getDataList(snapshotData['users']);
    _lastMessageText = snapshotData['lastMessageText'] as String?;
    _lastMessageDateTime = snapshotData['lastMessageDateTime'] as DateTime?;
    _author = snapshotData['author'] as DocumentReference?;
    _usersBlocked = getDataList(snapshotData['usersBlocked']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Dialog');

  static Stream<DialogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DialogRecord.fromSnapshot(s));

  static Future<DialogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DialogRecord.fromSnapshot(s));

  static DialogRecord fromSnapshot(DocumentSnapshot snapshot) => DialogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DialogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DialogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DialogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DialogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDialogRecordData({
  DateTime? dateTime,
  String? lastMessageText,
  DateTime? lastMessageDateTime,
  DocumentReference? author,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateTime': dateTime,
      'lastMessageText': lastMessageText,
      'lastMessageDateTime': lastMessageDateTime,
      'author': author,
    }.withoutNulls,
  );

  return firestoreData;
}

class DialogRecordDocumentEquality implements Equality<DialogRecord> {
  const DialogRecordDocumentEquality();

  @override
  bool equals(DialogRecord? e1, DialogRecord? e2) {
    const listEquality = ListEquality();
    return e1?.dateTime == e2?.dateTime &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.lastMessageText == e2?.lastMessageText &&
        e1?.lastMessageDateTime == e2?.lastMessageDateTime &&
        e1?.author == e2?.author &&
        listEquality.equals(e1?.usersBlocked, e2?.usersBlocked);
  }

  @override
  int hash(DialogRecord? e) => const ListEquality().hash([
        e?.dateTime,
        e?.users,
        e?.lastMessageText,
        e?.lastMessageDateTime,
        e?.author,
        e?.usersBlocked
      ]);

  @override
  bool isValidKey(Object? o) => o is DialogRecord;
}
