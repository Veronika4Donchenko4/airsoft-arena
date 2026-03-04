// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CityTypeStruct extends FFFirebaseStruct {
  CityTypeStruct({
    String? description,
    String? placeId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _description = description,
        _placeId = placeId,
        super(firestoreUtilData);

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "place_id" field.
  String? _placeId;
  String get placeId => _placeId ?? '';
  set placeId(String? val) => _placeId = val;

  bool hasPlaceId() => _placeId != null;

  static CityTypeStruct fromMap(Map<String, dynamic> data) => CityTypeStruct(
        description: data['description'] as String?,
        placeId: data['place_id'] as String?,
      );

  static CityTypeStruct? maybeFromMap(dynamic data) =>
      data is Map ? CityTypeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'description': _description,
        'place_id': _placeId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'place_id': serializeParam(
          _placeId,
          ParamType.String,
        ),
      }.withoutNulls;

  static CityTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      CityTypeStruct(
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        placeId: deserializeParam(
          data['place_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CityTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CityTypeStruct &&
        description == other.description &&
        placeId == other.placeId;
  }

  @override
  int get hashCode => const ListEquality().hash([description, placeId]);
}

CityTypeStruct createCityTypeStruct({
  String? description,
  String? placeId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CityTypeStruct(
      description: description,
      placeId: placeId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CityTypeStruct? updateCityTypeStruct(
  CityTypeStruct? cityType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cityType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCityTypeStructData(
  Map<String, dynamic> firestoreData,
  CityTypeStruct? cityType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cityType == null) {
    return;
  }
  if (cityType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cityType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cityTypeData = getCityTypeFirestoreData(cityType, forFieldValue);
  final nestedData = cityTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cityType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCityTypeFirestoreData(
  CityTypeStruct? cityType, [
  bool forFieldValue = false,
]) {
  if (cityType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cityType.toMap());

  // Add any Firestore field values
  cityType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCityTypeListFirestoreData(
  List<CityTypeStruct>? cityTypes,
) =>
    cityTypes?.map((e) => getCityTypeFirestoreData(e, true)).toList() ?? [];
