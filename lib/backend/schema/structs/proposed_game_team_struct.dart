// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProposedGameTeamStruct extends FFFirebaseStruct {
  ProposedGameTeamStruct({
    DocumentReference? game,
    DocumentReference? team,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _game = game,
        _team = team,
        super(firestoreUtilData);

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  set game(DocumentReference? val) => _game = val;

  bool hasGame() => _game != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  set team(DocumentReference? val) => _team = val;

  bool hasTeam() => _team != null;

  static ProposedGameTeamStruct fromMap(Map<String, dynamic> data) =>
      ProposedGameTeamStruct(
        game: data['game'] as DocumentReference?,
        team: data['team'] as DocumentReference?,
      );

  static ProposedGameTeamStruct? maybeFromMap(dynamic data) => data is Map
      ? ProposedGameTeamStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'game': _game,
        'team': _team,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'game': serializeParam(
          _game,
          ParamType.DocumentReference,
        ),
        'team': serializeParam(
          _team,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static ProposedGameTeamStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProposedGameTeamStruct(
        game: deserializeParam(
          data['game'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Game'],
        ),
        team: deserializeParam(
          data['team'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Team'],
        ),
      );

  @override
  String toString() => 'ProposedGameTeamStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProposedGameTeamStruct &&
        game == other.game &&
        team == other.team;
  }

  @override
  int get hashCode => const ListEquality().hash([game, team]);
}

ProposedGameTeamStruct createProposedGameTeamStruct({
  DocumentReference? game,
  DocumentReference? team,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProposedGameTeamStruct(
      game: game,
      team: team,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProposedGameTeamStruct? updateProposedGameTeamStruct(
  ProposedGameTeamStruct? proposedGameTeam, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    proposedGameTeam
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProposedGameTeamStructData(
  Map<String, dynamic> firestoreData,
  ProposedGameTeamStruct? proposedGameTeam,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (proposedGameTeam == null) {
    return;
  }
  if (proposedGameTeam.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && proposedGameTeam.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final proposedGameTeamData =
      getProposedGameTeamFirestoreData(proposedGameTeam, forFieldValue);
  final nestedData =
      proposedGameTeamData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = proposedGameTeam.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProposedGameTeamFirestoreData(
  ProposedGameTeamStruct? proposedGameTeam, [
  bool forFieldValue = false,
]) {
  if (proposedGameTeam == null) {
    return {};
  }
  final firestoreData = mapToFirestore(proposedGameTeam.toMap());

  // Add any Firestore field values
  proposedGameTeam.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProposedGameTeamListFirestoreData(
  List<ProposedGameTeamStruct>? proposedGameTeams,
) =>
    proposedGameTeams
        ?.map((e) => getProposedGameTeamFirestoreData(e, true))
        .toList() ??
    [];
