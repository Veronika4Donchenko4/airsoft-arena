import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserRecord extends FirestoreRecord {
  UserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  bool hasType() => _type != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "clubName" field.
  String? _clubName;
  String get clubName => _clubName ?? '';
  bool hasClubName() => _clubName != null;

  // "clubDescription" field.
  String? _clubDescription;
  String get clubDescription => _clubDescription ?? '';
  bool hasClubDescription() => _clubDescription != null;

  // "subscription" field.
  DocumentReference? _subscription;
  DocumentReference? get subscription => _subscription;
  bool hasSubscription() => _subscription != null;

  // "city" field.
  CityTypeStruct? _city;
  CityTypeStruct get city => _city ?? CityTypeStruct();
  bool hasCity() => _city != null;

  // "subscriptionTill" field.
  DateTime? _subscriptionTill;
  DateTime? get subscriptionTill => _subscriptionTill;
  bool hasSubscriptionTill() => _subscriptionTill != null;

  // "rate" field.
  double? _rate;
  double get rate => _rate ?? 0.0;
  bool hasRate() => _rate != null;

  // "kilss" field.
  int? _kilss;
  int get kilss => _kilss ?? 0;
  bool hasKilss() => _kilss != null;

  // "deth" field.
  int? _deth;
  int get deth => _deth ?? 0;
  bool hasDeth() => _deth != null;

  // "win" field.
  int? _win;
  int get win => _win ?? 0;
  bool hasWin() => _win != null;

  // "losses" field.
  int? _losses;
  int get losses => _losses ?? 0;
  bool hasLosses() => _losses != null;

  // "geoTag" field.
  LatLng? _geoTag;
  LatLng? get geoTag => _geoTag;
  bool hasGeoTag() => _geoTag != null;

  // "proposedGameTeam" field.
  List<ProposedGameTeamStruct>? _proposedGameTeam;
  List<ProposedGameTeamStruct> get proposedGameTeam =>
      _proposedGameTeam ?? const [];
  bool hasProposedGameTeam() => _proposedGameTeam != null;

  // "maxKills" field.
  int? _maxKills;
  int get maxKills => _maxKills ?? 0;
  bool hasMaxKills() => _maxKills != null;

  // "gameCount" field.
  int? _gameCount;
  int get gameCount => _gameCount ?? 0;
  bool hasGameCount() => _gameCount != null;

  // "seriesNoLosess" field.
  List<bool>? _seriesNoLosess;
  List<bool> get seriesNoLosess => _seriesNoLosess ?? const [];
  bool hasSeriesNoLosess() => _seriesNoLosess != null;

  // "adminName" field.
  String? _adminName;
  String get adminName => _adminName ?? '';
  bool hasAdminName() => _adminName != null;

  // "adminStatus" field.
  int? _adminStatus;
  int get adminStatus => _adminStatus ?? 0;
  bool hasAdminStatus() => _adminStatus != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _type = castToType<int>(snapshotData['type']);
    _name = snapshotData['name'] as String?;
    _clubName = snapshotData['clubName'] as String?;
    _clubDescription = snapshotData['clubDescription'] as String?;
    _subscription = snapshotData['subscription'] as DocumentReference?;
    _city = snapshotData['city'] is CityTypeStruct
        ? snapshotData['city']
        : CityTypeStruct.maybeFromMap(snapshotData['city']);
    _subscriptionTill = snapshotData['subscriptionTill'] as DateTime?;
    _rate = castToType<double>(snapshotData['rate']);
    _kilss = castToType<int>(snapshotData['kilss']);
    _deth = castToType<int>(snapshotData['deth']);
    _win = castToType<int>(snapshotData['win']);
    _losses = castToType<int>(snapshotData['losses']);
    _geoTag = snapshotData['geoTag'] as LatLng?;
    _proposedGameTeam = getStructList(
      snapshotData['proposedGameTeam'],
      ProposedGameTeamStruct.fromMap,
    );
    _maxKills = castToType<int>(snapshotData['maxKills']);
    _gameCount = castToType<int>(snapshotData['gameCount']);
    _seriesNoLosess = getDataList(snapshotData['seriesNoLosess']);
    _adminName = snapshotData['adminName'] as String?;
    _adminStatus = castToType<int>(snapshotData['adminStatus']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('User');

  static Stream<UserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRecord.fromSnapshot(s));

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRecord.fromSnapshot(s));

  static UserRecord fromSnapshot(DocumentSnapshot snapshot) => UserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? type,
  String? name,
  String? clubName,
  String? clubDescription,
  DocumentReference? subscription,
  CityTypeStruct? city,
  DateTime? subscriptionTill,
  double? rate,
  int? kilss,
  int? deth,
  int? win,
  int? losses,
  LatLng? geoTag,
  int? maxKills,
  int? gameCount,
  String? adminName,
  int? adminStatus,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'type': type,
      'name': name,
      'clubName': clubName,
      'clubDescription': clubDescription,
      'subscription': subscription,
      'city': CityTypeStruct().toMap(),
      'subscriptionTill': subscriptionTill,
      'rate': rate,
      'kilss': kilss,
      'deth': deth,
      'win': win,
      'losses': losses,
      'geoTag': geoTag,
      'maxKills': maxKills,
      'gameCount': gameCount,
      'adminName': adminName,
      'adminStatus': adminStatus,
    }.withoutNulls,
  );

  // Handle nested data for "city" field.
  addCityTypeStructData(firestoreData, city, 'city');

  return firestoreData;
}

class UserRecordDocumentEquality implements Equality<UserRecord> {
  const UserRecordDocumentEquality();

  @override
  bool equals(UserRecord? e1, UserRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.type == e2?.type &&
        e1?.name == e2?.name &&
        e1?.clubName == e2?.clubName &&
        e1?.clubDescription == e2?.clubDescription &&
        e1?.subscription == e2?.subscription &&
        e1?.city == e2?.city &&
        e1?.subscriptionTill == e2?.subscriptionTill &&
        e1?.rate == e2?.rate &&
        e1?.kilss == e2?.kilss &&
        e1?.deth == e2?.deth &&
        e1?.win == e2?.win &&
        e1?.losses == e2?.losses &&
        e1?.geoTag == e2?.geoTag &&
        listEquality.equals(e1?.proposedGameTeam, e2?.proposedGameTeam) &&
        e1?.maxKills == e2?.maxKills &&
        e1?.gameCount == e2?.gameCount &&
        listEquality.equals(e1?.seriesNoLosess, e2?.seriesNoLosess) &&
        e1?.adminName == e2?.adminName &&
        e1?.adminStatus == e2?.adminStatus;
  }

  @override
  int hash(UserRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.type,
        e?.name,
        e?.clubName,
        e?.clubDescription,
        e?.subscription,
        e?.city,
        e?.subscriptionTill,
        e?.rate,
        e?.kilss,
        e?.deth,
        e?.win,
        e?.losses,
        e?.geoTag,
        e?.proposedGameTeam,
        e?.maxKills,
        e?.gameCount,
        e?.seriesNoLosess,
        e?.adminName,
        e?.adminStatus
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRecord;
}
