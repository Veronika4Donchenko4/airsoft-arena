import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameRecord extends FirestoreRecord {
  GameRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "teams" field.
  List<DocumentReference>? _teams;
  List<DocumentReference> get teams => _teams ?? const [];
  bool hasTeams() => _teams != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "place" field.
  String? _place;
  String get place => _place ?? '';
  bool hasPlace() => _place != null;

  // "placeId" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  bool hasPlaceId() => _placeId != null;

  // "teamLimit" field.
  int? _teamLimit;
  int get teamLimit => _teamLimit ?? 0;
  bool hasTeamLimit() => _teamLimit != null;

  // "playersLimit" field.
  int? _playersLimit;
  int get playersLimit => _playersLimit ?? 0;
  bool hasPlayersLimit() => _playersLimit != null;

  // "roundsLimit" field.
  int? _roundsLimit;
  int get roundsLimit => _roundsLimit ?? 0;
  bool hasRoundsLimit() => _roundsLimit != null;

  // "conditions" field.
  String? _conditions;
  String get conditions => _conditions ?? '';
  bool hasConditions() => _conditions != null;

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "applicationGameList" field.
  List<DocumentReference>? _applicationGameList;
  List<DocumentReference> get applicationGameList =>
      _applicationGameList ?? const [];
  bool hasApplicationGameList() => _applicationGameList != null;

  // "roundsRefs" field.
  List<DocumentReference>? _roundsRefs;
  List<DocumentReference> get roundsRefs => _roundsRefs ?? const [];
  bool hasRoundsRefs() => _roundsRefs != null;

  // "teamsAcceptedResults" field.
  List<DocumentReference>? _teamsAcceptedResults;
  List<DocumentReference> get teamsAcceptedResults =>
      _teamsAcceptedResults ?? const [];
  bool hasTeamsAcceptedResults() => _teamsAcceptedResults != null;

  // "sporeAboutGame" field.
  List<DocumentReference>? _sporeAboutGame;
  List<DocumentReference> get sporeAboutGame => _sporeAboutGame ?? const [];
  bool hasSporeAboutGame() => _sporeAboutGame != null;

  // "gameUsers" field.
  List<DocumentReference>? _gameUsers;
  List<DocumentReference> get gameUsers => _gameUsers ?? const [];
  bool hasGameUsers() => _gameUsers != null;

  // "teamWinner" field.
  List<DocumentReference>? _teamWinner;
  List<DocumentReference> get teamWinner => _teamWinner ?? const [];
  bool hasTeamWinner() => _teamWinner != null;

  // "allowFreeJoin" field.
  bool? _allowFreeJoin;
  bool get allowFreeJoin => _allowFreeJoin ?? false;
  bool hasAllowFreeJoin() => _allowFreeJoin != null;

  // "isPending" field.
  bool? _isPending;
  bool get isPending => _isPending ?? false;
  bool hasIsPending() => _isPending != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "orderedFromClub" field.
  DocumentReference? _orderedFromClub;
  DocumentReference? get orderedFromClub => _orderedFromClub;
  bool hasOrderedFromClub() => _orderedFromClub != null;

  // "requestedBy" field.
  DocumentReference? _requestedBy;
  DocumentReference? get requestedBy => _requestedBy;
  bool hasRequestedBy() => _requestedBy != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _teams = getDataList(snapshotData['teams']);
    _status = castToType<int>(snapshotData['status']);
    _place = snapshotData['place'] as String?;
    _placeId = snapshotData['placeId'] as String?;
    _teamLimit = castToType<int>(snapshotData['teamLimit']);
    _playersLimit = castToType<int>(snapshotData['playersLimit']);
    _roundsLimit = castToType<int>(snapshotData['roundsLimit']);
    _conditions = snapshotData['conditions'] as String?;
    _creator = snapshotData['creator'] as DocumentReference?;
    _users = getDataList(snapshotData['users']);
    _applicationGameList = getDataList(snapshotData['applicationGameList']);
    _roundsRefs = getDataList(snapshotData['roundsRefs']);
    _teamsAcceptedResults = getDataList(snapshotData['teamsAcceptedResults']);
    _sporeAboutGame = getDataList(snapshotData['sporeAboutGame']);
    _gameUsers = getDataList(snapshotData['gameUsers']);
    _teamWinner = getDataList(snapshotData['teamWinner']);
    _allowFreeJoin = snapshotData['allowFreeJoin'] as bool?;
    _isPending = snapshotData['isPending'] as bool?;
    _password = snapshotData['password'] as String?;
    _orderedFromClub = snapshotData['orderedFromClub'] as DocumentReference?;
    _requestedBy = snapshotData['requestedBy'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Game');

  static Stream<GameRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameRecord.fromSnapshot(s));

  static Future<GameRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameRecord.fromSnapshot(s));

  static GameRecord fromSnapshot(DocumentSnapshot snapshot) => GameRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameRecordData({
  String? name,
  DateTime? dateTime,
  int? status,
  String? place,
  String? placeId,
  int? teamLimit,
  int? playersLimit,
  int? roundsLimit,
  String? conditions,
  DocumentReference? creator,
  bool? allowFreeJoin,
  bool? isPending,
  String? password,
  DocumentReference? orderedFromClub,
  DocumentReference? requestedBy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'dateTime': dateTime,
      'status': status,
      'place': place,
      'placeId': placeId,
      'teamLimit': teamLimit,
      'playersLimit': playersLimit,
      'roundsLimit': roundsLimit,
      'conditions': conditions,
      'creator': creator,
      'allowFreeJoin': allowFreeJoin,
      'isPending': isPending,
      'password': password,
      'orderedFromClub': orderedFromClub,
      'requestedBy': requestedBy,
    }.withoutNulls,
  );

  return firestoreData;
}

class GameRecordDocumentEquality implements Equality<GameRecord> {
  const GameRecordDocumentEquality();

  @override
  bool equals(GameRecord? e1, GameRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.dateTime == e2?.dateTime &&
        listEquality.equals(e1?.teams, e2?.teams) &&
        e1?.status == e2?.status &&
        e1?.place == e2?.place &&
        e1?.placeId == e2?.placeId &&
        e1?.teamLimit == e2?.teamLimit &&
        e1?.playersLimit == e2?.playersLimit &&
        e1?.roundsLimit == e2?.roundsLimit &&
        e1?.conditions == e2?.conditions &&
        e1?.creator == e2?.creator &&
        listEquality.equals(e1?.users, e2?.users) &&
        listEquality.equals(e1?.applicationGameList, e2?.applicationGameList) &&
        listEquality.equals(e1?.roundsRefs, e2?.roundsRefs) &&
        listEquality.equals(
            e1?.teamsAcceptedResults, e2?.teamsAcceptedResults) &&
        listEquality.equals(e1?.sporeAboutGame, e2?.sporeAboutGame) &&
        listEquality.equals(e1?.gameUsers, e2?.gameUsers) &&
        listEquality.equals(e1?.teamWinner, e2?.teamWinner) &&
        e1?.allowFreeJoin == e2?.allowFreeJoin &&
        e1?.isPending == e2?.isPending &&
        e1?.password == e2?.password &&
        e1?.orderedFromClub == e2?.orderedFromClub &&
        e1?.requestedBy == e2?.requestedBy;
  }

  @override
  int hash(GameRecord? e) => const ListEquality().hash([
        e?.name,
        e?.dateTime,
        e?.teams,
        e?.status,
        e?.place,
        e?.placeId,
        e?.teamLimit,
        e?.playersLimit,
        e?.roundsLimit,
        e?.conditions,
        e?.creator,
        e?.users,
        e?.applicationGameList,
        e?.roundsRefs,
        e?.teamsAcceptedResults,
        e?.sporeAboutGame,
        e?.gameUsers,
        e?.teamWinner,
        e?.allowFreeJoin,
        e?.isPending,
        e?.password,
        e?.orderedFromClub,
        e?.requestedBy
      ]);

  @override
  bool isValidKey(Object? o) => o is GameRecord;
}
