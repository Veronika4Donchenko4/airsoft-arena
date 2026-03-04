// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserJobStruct extends FFFirebaseStruct {
  UserJobStruct({
    DocumentReference? user,
    DocumentReference? job,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _user = user,
        _job = job,
        super(firestoreUtilData);

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  set user(DocumentReference? val) => _user = val;

  bool hasUser() => _user != null;

  // "job" field.
  DocumentReference? _job;
  DocumentReference? get job => _job;
  set job(DocumentReference? val) => _job = val;

  bool hasJob() => _job != null;

  static UserJobStruct fromMap(Map<String, dynamic> data) => UserJobStruct(
        user: data['user'] as DocumentReference?,
        job: data['job'] as DocumentReference?,
      );

  static UserJobStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserJobStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'user': _user,
        'job': _job,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user': serializeParam(
          _user,
          ParamType.DocumentReference,
        ),
        'job': serializeParam(
          _job,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static UserJobStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserJobStruct(
        user: deserializeParam(
          data['user'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['User'],
        ),
        job: deserializeParam(
          data['job'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Job'],
        ),
      );

  @override
  String toString() => 'UserJobStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserJobStruct && user == other.user && job == other.job;
  }

  @override
  int get hashCode => const ListEquality().hash([user, job]);
}

UserJobStruct createUserJobStruct({
  DocumentReference? user,
  DocumentReference? job,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserJobStruct(
      user: user,
      job: job,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserJobStruct? updateUserJobStruct(
  UserJobStruct? userJob, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userJob
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserJobStructData(
  Map<String, dynamic> firestoreData,
  UserJobStruct? userJob,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userJob == null) {
    return;
  }
  if (userJob.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userJob.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userJobData = getUserJobFirestoreData(userJob, forFieldValue);
  final nestedData = userJobData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userJob.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserJobFirestoreData(
  UserJobStruct? userJob, [
  bool forFieldValue = false,
]) {
  if (userJob == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userJob.toMap());

  // Add any Firestore field values
  userJob.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserJobListFirestoreData(
  List<UserJobStruct>? userJobs,
) =>
    userJobs?.map((e) => getUserJobFirestoreData(e, true)).toList() ?? [];
