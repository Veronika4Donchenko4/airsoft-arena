import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamRecord extends FirestoreRecord {
  TeamRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  bool hasColor() => _color != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  // "recruitmentOpen" field.
  bool? _recruitmentOpen;
  bool get recruitmentOpen => _recruitmentOpen ?? false;
  bool hasRecruitmentOpen() => _recruitmentOpen != null;

  // "usersJob" field.
  List<UserJobStruct>? _usersJob;
  List<UserJobStruct> get usersJob => _usersJob ?? const [];
  bool hasUsersJob() => _usersJob != null;

  // "applicationList" field.
  List<DocumentReference>? _applicationList;
  List<DocumentReference> get applicationList => _applicationList ?? const [];
  bool hasApplicationList() => _applicationList != null;

  // "userCaptain" field.
  DocumentReference? _userCaptain;
  DocumentReference? get userCaptain => _userCaptain;
  bool hasUserCaptain() => _userCaptain != null;

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _color = getSchemaColor(snapshotData['color']);
    _description = snapshotData['description'] as String?;
    _creator = snapshotData['creator'] as DocumentReference?;
    _recruitmentOpen = snapshotData['recruitmentOpen'] as bool?;
    _usersJob = getStructList(
      snapshotData['usersJob'],
      UserJobStruct.fromMap,
    );
    _applicationList = getDataList(snapshotData['applicationList']);
    _userCaptain = snapshotData['userCaptain'] as DocumentReference?;
    _game = snapshotData['game'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Team');

  static Stream<TeamRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeamRecord.fromSnapshot(s));

  static Future<TeamRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeamRecord.fromSnapshot(s));

  static TeamRecord fromSnapshot(DocumentSnapshot snapshot) => TeamRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeamRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeamRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeamRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeamRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeamRecordData({
  String? name,
  Color? color,
  String? description,
  DocumentReference? creator,
  bool? recruitmentOpen,
  DocumentReference? userCaptain,
  DocumentReference? game,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'color': color,
      'description': description,
      'creator': creator,
      'recruitmentOpen': recruitmentOpen,
      'userCaptain': userCaptain,
      'game': game,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeamRecordDocumentEquality implements Equality<TeamRecord> {
  const TeamRecordDocumentEquality();

  @override
  bool equals(TeamRecord? e1, TeamRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.color == e2?.color &&
        e1?.description == e2?.description &&
        e1?.creator == e2?.creator &&
        e1?.recruitmentOpen == e2?.recruitmentOpen &&
        listEquality.equals(e1?.usersJob, e2?.usersJob) &&
        listEquality.equals(e1?.applicationList, e2?.applicationList) &&
        e1?.userCaptain == e2?.userCaptain &&
        e1?.game == e2?.game;
  }

  @override
  int hash(TeamRecord? e) => const ListEquality().hash([
        e?.name,
        e?.color,
        e?.description,
        e?.creator,
        e?.recruitmentOpen,
        e?.usersJob,
        e?.applicationList,
        e?.userCaptain,
        e?.game
      ]);

  @override
  bool isValidKey(Object? o) => o is TeamRecord;
}
