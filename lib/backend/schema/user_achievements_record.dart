import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserAchievementsRecord extends FirestoreRecord {
  UserAchievementsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "achievement" field.
  DocumentReference? _achievement;
  DocumentReference? get achievement => _achievement;
  bool hasAchievement() => _achievement != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  void _initializeFields() {
    _achievement = snapshotData['achievement'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('UserAchievements');

  static Stream<UserAchievementsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserAchievementsRecord.fromSnapshot(s));

  static Future<UserAchievementsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserAchievementsRecord.fromSnapshot(s));

  static UserAchievementsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserAchievementsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserAchievementsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserAchievementsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserAchievementsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserAchievementsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserAchievementsRecordData({
  DocumentReference? achievement,
  DocumentReference? user,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'achievement': achievement,
      'user': user,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserAchievementsRecordDocumentEquality
    implements Equality<UserAchievementsRecord> {
  const UserAchievementsRecordDocumentEquality();

  @override
  bool equals(UserAchievementsRecord? e1, UserAchievementsRecord? e2) {
    return e1?.achievement == e2?.achievement && e1?.user == e2?.user;
  }

  @override
  int hash(UserAchievementsRecord? e) =>
      const ListEquality().hash([e?.achievement, e?.user]);

  @override
  bool isValidKey(Object? o) => o is UserAchievementsRecord;
}
