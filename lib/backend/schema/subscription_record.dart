import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionRecord extends FirestoreRecord {
  SubscriptionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "features" field.
  List<String>? _features;
  List<String> get features => _features ?? const [];
  bool hasFeatures() => _features != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  bool hasIcon() => _icon != null;

  // "maxGames" field.
  int? _maxGames;
  int get maxGames => _maxGames ?? 0;
  bool hasMaxGames() => _maxGames != null;

  // "maxTeams" field.
  int? _maxTeams;
  int get maxTeams => _maxTeams ?? 0;
  bool hasMaxTeams() => _maxTeams != null;

  void _initializeFields() {
    _index = castToType<int>(snapshotData['index']);
    _name = snapshotData['name'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _description = snapshotData['description'] as String?;
    _features = getDataList(snapshotData['features']);
    _icon = snapshotData['icon'] as String?;
    _maxGames = castToType<int>(snapshotData['maxGames']);
    _maxTeams = castToType<int>(snapshotData['maxTeams']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Subscription');

  static Stream<SubscriptionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionRecord.fromSnapshot(s));

  static Future<SubscriptionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubscriptionRecord.fromSnapshot(s));

  static SubscriptionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubscriptionRecordData({
  int? index,
  String? name,
  double? price,
  String? description,
  String? icon,
  int? maxGames,
  int? maxTeams,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'index': index,
      'name': name,
      'price': price,
      'description': description,
      'icon': icon,
      'maxGames': maxGames,
      'maxTeams': maxTeams,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionRecordDocumentEquality
    implements Equality<SubscriptionRecord> {
  const SubscriptionRecordDocumentEquality();

  @override
  bool equals(SubscriptionRecord? e1, SubscriptionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.index == e2?.index &&
        e1?.name == e2?.name &&
        e1?.price == e2?.price &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.features, e2?.features) &&
        e1?.icon == e2?.icon &&
        e1?.maxGames == e2?.maxGames &&
        e1?.maxTeams == e2?.maxTeams;
  }

  @override
  int hash(SubscriptionRecord? e) => const ListEquality().hash([
        e?.index,
        e?.name,
        e?.price,
        e?.description,
        e?.features,
        e?.icon,
        e?.maxGames,
        e?.maxTeams
      ]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionRecord;
}
