import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'StartPage': ParameterData.none(),
  'RouterPage': ParameterData.none(),
  'OnboardingPage': ParameterData.none(),
  'LoginPage': ParameterData.none(),
  'LoginPhoneCodePage': (data) async => ParameterData(
        allParams: {
          'phone': getParameter<String>(data, 'phone'),
        },
      ),
  'UseConditionsPage': (data) async => ParameterData(
        allParams: {
          'type': getParameter<int>(data, 'type'),
        },
      ),
  'CreateProfile': ParameterData.none(),
  'ProfilePage': ParameterData.none(),
  'NotificationPage': ParameterData.none(),
  'EditProfilePage': ParameterData.none(),
  'ChangeRolePage': ParameterData.none(),
  'GamesClubPage': ParameterData.none(),
  'AboutGamePage': (data) async => ParameterData(
        allParams: {
          'gameReferens': getParameter<DocumentReference>(data, 'gameReferens'),
        },
      ),
  'CreateGamePage': (data) async => ParameterData(
        allParams: {
          'gameDocument': await getDocumentParameter<GameRecord>(
              data, 'gameDocument', GameRecord.fromSnapshot),
        },
      ),
  'GamePlacePage': ParameterData.none(),
  'TeamPage': (data) async => ParameterData(
        allParams: {
          'teamRef': getParameter<DocumentReference>(data, 'teamRef'),
          'gameDoc': await getDocumentParameter<GameRecord>(
              data, 'gameDoc', GameRecord.fromSnapshot),
        },
      ),
  'AppliListGamePage': (data) async => ParameterData(
        allParams: {
          'gameReference':
              getParameter<DocumentReference>(data, 'gameReference'),
        },
      ),
  'MyGamePage': ParameterData.none(),
  'StartGamePage': ParameterData.none(),
  'ProcessRoundPage': ParameterData.none(),
  'EndRoundPage': ParameterData.none(),
  'ResultRoundPage': ParameterData.none(),
  'AccResultGameClubPage': ParameterData.none(),
  'LeaderboardPage': ParameterData.none(),
  'ChatPage': ParameterData.none(),
  'GamesPage': ParameterData.none(),
  'AppliListTeamPage': (data) async => ParameterData(
        allParams: {
          'teamRef': getParameter<DocumentReference>(data, 'teamRef'),
          'gameDoc': await getDocumentParameter<GameRecord>(
              data, 'gameDoc', GameRecord.fromSnapshot),
        },
      ),
  'InvitePage': ParameterData.none(),
  'StartGameClubPage': ParameterData.none(),
  'EndRoundClubPage': ParameterData.none(),
  'ResultRoundGlubPage': ParameterData.none(),
  'ResultGameGlubPage': ParameterData.none(),
  'ResultGamePage': ParameterData.none(),
  'ProcessRoundClubPage': ParameterData.none(),
  'MyRatePage': ParameterData.none(),
  'DialogPage': (data) async => ParameterData(
        allParams: {
          'dialog': getParameter<DocumentReference>(data, 'dialog'),
        },
      ),
  'ShareUserInfo': (data) async {
    final allParams = {
      'userId': getParameter<String>(data, 'userId'),
    };
    return ParameterData(
      requiredParams: {
        'userId': serializeParam(
          allParams['userId'],
          ParamType.String,
        ),
      },
      allParams: allParams,
    );
  },
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
