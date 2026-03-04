// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamUsersStruct extends FFFirebaseStruct {
  TeamUsersStruct({
    DocumentReference? user,
    DocumentReference? role,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _user = user,
        _role = role,
        super(firestoreUtilData);

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  set user(DocumentReference? val) => _user = val;

  bool hasUser() => _user != null;

  // "role" field.
  DocumentReference? _role;
  DocumentReference? get role => _role;
  set role(DocumentReference? val) => _role = val;

  bool hasRole() => _role != null;

  static TeamUsersStruct fromMap(Map<String, dynamic> data) => TeamUsersStruct(
        user: data['user'] as DocumentReference?,
        role: data['role'] as DocumentReference?,
      );

  static TeamUsersStruct? maybeFromMap(dynamic data) => data is Map
      ? TeamUsersStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user': _user,
        'role': _role,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user': serializeParam(
          _user,
          ParamType.DocumentReference,
        ),
        'role': serializeParam(
          _role,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static TeamUsersStruct fromSerializableMap(Map<String, dynamic> data) =>
      TeamUsersStruct(
        user: deserializeParam(
          data['user'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['User'],
        ),
        role: deserializeParam(
          data['role'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['TeamRoles'],
        ),
      );

  @override
  String toString() => 'TeamUsersStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeamUsersStruct && user == other.user && role == other.role;
  }

  @override
  int get hashCode => const ListEquality().hash([user, role]);
}

TeamUsersStruct createTeamUsersStruct({
  DocumentReference? user,
  DocumentReference? role,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeamUsersStruct(
      user: user,
      role: role,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeamUsersStruct? updateTeamUsersStruct(
  TeamUsersStruct? teamUsers, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teamUsers
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeamUsersStructData(
  Map<String, dynamic> firestoreData,
  TeamUsersStruct? teamUsers,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teamUsers == null) {
    return;
  }
  if (teamUsers.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teamUsers.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teamUsersData = getTeamUsersFirestoreData(teamUsers, forFieldValue);
  final nestedData = teamUsersData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teamUsers.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeamUsersFirestoreData(
  TeamUsersStruct? teamUsers, [
  bool forFieldValue = false,
]) {
  if (teamUsers == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teamUsers.toMap());

  // Add any Firestore field values
  teamUsers.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeamUsersListFirestoreData(
  List<TeamUsersStruct>? teamUserss,
) =>
    teamUserss?.map((e) => getTeamUsersFirestoreData(e, true)).toList() ?? [];
