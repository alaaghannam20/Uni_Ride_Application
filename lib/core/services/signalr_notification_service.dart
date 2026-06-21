import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:uni_ride_application/core/provider/notification_provider.dart';
import 'package:uni_ride_application/core/services/checkpoint_service.dart';

class SignalRNotificationService {
  static final SignalRNotificationService _instance =
      SignalRNotificationService._internal();
  factory SignalRNotificationService() => _instance;
  SignalRNotificationService._internal();

  static const String _hubUrl =
      'https://uniride.runasp.net/notificationHub';

  HubConnection? _connection;
  bool _manuallyStopped = false;
  GlobalKey<NavigatorState>? _navigatorKey;

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  Future<void> connect(String token) async {
    if (_connection != null) await disconnect();

    _manuallyStopped = false;

    final httpOptions = HttpConnectionOptions(
      accessTokenFactory: () async => token,
      transport: HttpTransportType.WebSockets,
    );

    _connection = HubConnectionBuilder()
        .withUrl(_hubUrl, options: httpOptions)
        .withAutomaticReconnect(retryDelays: [0, 2000, 10000, 30000])
        .build();

    _connection!.on('ReceiveNotification', _onReceiveNotification);

    _connection!.onreconnecting(({Exception? error}) {
      debugPrint('[SignalR] Reconnecting: $error');
    });

    _connection!.onreconnected(({String? connectionId}) {
      debugPrint('[SignalR] Reconnected: $connectionId');
    });

    _connection!.onclose(({Exception? error}) async {
      debugPrint('[SignalR] Closed: $error');
      if (!_manuallyStopped) {
        await Future.delayed(const Duration(seconds: 5));
        if (!_manuallyStopped) await _tryStart();
      }
    });

    await _tryStart();
  }

  Future<void> _tryStart() async {
    try {
      await _connection?.start();
      debugPrint('[SignalR] Connected to notificationHub');
    } catch (e) {
      debugPrint('[SignalR] Start failed: $e');
    }
  }

  void _onReceiveNotification(List<Object?>? args) {
    if (args == null || args.isEmpty || args.first == null) return;

    final raw = args.first;
    if (raw is! Map) return;

    final data = raw.map((k, v) => MapEntry(k.toString(), v));

    final title = (data['title'] ?? data['Title'] ?? '').toString();
    final body = (data['message'] ?? data['Message'] ?? data['body'] ?? data['Body'] ?? '').toString();

    CheckpointNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: title,
      body: body,
    );

    final context = _navigatorKey?.currentContext;
    if (context != null) {
      try {
        Provider.of<NotificationProvider>(context, listen: false)
            .addSignalRNotification(data);
      } catch (e) {
        debugPrint('[SignalR] Failed to update NotificationProvider: $e');
      }
    }
  }

  Future<void> disconnect() async {
    _manuallyStopped = true;
    _connection?.off('ReceiveNotification');
    await _connection?.stop();
    _connection = null;
    debugPrint('[SignalR] Disconnected');
  }
}
