import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AchievementRecord extends FirestoreRecord {
  AchievementRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  bool hasType() => _type != null;

  // "maxKills" field.
  int? _maxKills;
  int get maxKills => _maxKills ?? 0;
  bool hasMaxKills() => _maxKills != null;

  // "gameCount" field.
  int? _gameCount;
  int get gameCount => _gameCount ?? 0;
  bool hasGameCount() => _gameCount != null;

  // "winSeries" field.
  int? _winSeries;
  int get winSeries => _winSeries ?? 0;
  bool hasWinSeries() => _winSeries != null;

  // "winsCount" field.
  int? _winsCount;
  int get winsCount => _winsCount ?? 0;
  bool hasWinsCount() => _winsCount != null;

  // "rate" field.
  double? _rate;
  double get rate => _rate ?? 0.0;
  bool hasRate() => _rate != null;

  // "format" field.
  int? _format;
  int get format => _format ?? 0;
  bool hasFormat() => _format != null;

  void _initializeFields() {
    _image = snapshotData['image'] as String?;
    _name = snapshotData['name'] as String?;
    _text = snapshotData['text'] as String?;
    _type = castToType<int>(snapshotData['type']);
    _maxKills = castToType<int>(snapshotData['maxKills']);
    _gameCount = castToType<int>(snapshotData['gameCount']);
    _winSeries = castToType<int>(snapshotData['winSeries']);
    _winsCount = castToType<int>(snapshotData['winsCount']);
    _rate = castToType<double>(snapshotData['rate']);
    _format = castToType<int>(snapshotData['format']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Achievement');

  static Stream<AchievementRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AchievementRecord.fromSnapshot(s));

  static Future<AchievementRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AchievementRecord.fromSnapshot(s));

  static AchievementRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AchievementRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AchievementRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AchievementRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AchievementRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AchievementRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAchievementRecordData({
  String? image,
  String? name,
  String? text,
  int? type,
  int? maxKills,
  int? gameCount,
  int? winSeries,
  int? winsCount,
  double? rate,
  int? format,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'image': image,
      'name': name,
      'text': text,
      'type': type,
      'maxKills': maxKills,
      'gameCount': gameCount,
      'winSeries': winSeries,
      'winsCount': winsCount,
      'rate': rate,
      'format': format,
    }.withoutNulls,
  );

  return firestoreData;
}

class AchievementRecordDocumentEquality implements Equality<AchievementRecord> {
  const AchievementRecordDocumentEquality();

  @override
  bool equals(AchievementRecord? e1, AchievementRecord? e2) {
    return e1?.image == e2?.image &&
        e1?.name == e2?.name &&
        e1?.text == e2?.text &&
        e1?.type == e2?.type &&
        e1?.maxKills == e2?.maxKills &&
        e1?.gameCount == e2?.gameCount &&
        e1?.winSeries == e2?.winSeries &&
        e1?.winsCount == e2?.winsCount &&
        e1?.rate == e2?.rate &&
        e1?.format == e2?.format;
  }

  @override
  int hash(AchievementRecord? e) => const ListEquality().hash([
        e?.image,
        e?.name,
        e?.text,
        e?.type,
        e?.maxKills,
        e?.gameCount,
        e?.winSeries,
        e?.winsCount,
        e?.rate,
        e?.format
      ]);

  @override
  bool isValidKey(Object? o) => o is AchievementRecord;
}
