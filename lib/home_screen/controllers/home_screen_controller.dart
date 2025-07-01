import 'dart:async';
import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:turbo_jet/general/app_init.dart';
import 'package:turbo_jet/general/constants.dart';
import 'package:turbo_jet/general/general_functions.dart';
import 'package:turbo_jet/home_screen/components/sessions_history/session_history_page.dart';

import '../components/models.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();
  final String espIp = "http://172.20.10.3";
  final combustionIn = 0.0.obs;
  final combustionOut = 0.0.obs;
  final exhaust = 0.0.obs;
  final turbine = 0.0.obs;
  final oilIn = 0.0.obs;
  final oilOut = 0.0.obs;
  final rpm = 0.0.obs;
  final pageIndex = 0.obs;
  late final PageController pageController;
  final isSessionRunning = false.obs;
  final isStartButtonSelected = false.obs;

  Timer? _timer;
  String? currentSessionId;

  final _firestore = FirebaseFirestore.instance;
  final RxMap<String, Map<String, DateTime>> dateRangeOptions =
      <String, Map<String, DateTime>>{}.obs;
  late DateTime? dateFrom;
  late DateTime? dateTo;
  RxList<EngineSessionModel> sessionsHistoryList = <EngineSessionModel>[].obs;
  StreamSubscription? sessionsListener;
  RxBool loadingSessions = false.obs;
  final RxInt currentSelectedDate = 0.obs;
  final sessionsRefreshController = RefreshController(initialRefresh: false);
  @override
  void onInit() {
    pageController = PageController(initialPage: 0, keepPage: true);
    _checkForRunningSession();
    final now = DateTime.now();
    dateFrom = DateTime(now.year, now.month, now.day);
    dateTo = DateTime(now.year, now.month, now.day, 23, 59, 59);
    _initializeDateRangeOptions();
    listenToSessionsHistory();
    super.onInit();
  }

  void _initializeDateRangeOptions() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final daysSinceSaturday = (now.weekday % 7);
    final startOfThisWeek = todayStart.subtract(
      Duration(days: daysSinceSaturday),
    );
    String customDateElementKey = '';
    Map<String, DateTime> customDateElementValue = {};
    if (dateRangeOptions.length > 6) {
      customDateElementKey = dateRangeOptions.keys.elementAt(6);
      customDateElementValue = dateRangeOptions[customDateElementKey]!;
      String dateFormatted = DateFormat('MMM dd, yyyy').format(dateFrom!);
      if (dateFrom!.day != dateTo!.day) {
        dateFormatted += ' - ${DateFormat('MMM dd, yyyy').format(dateTo!)}';
      }
      customDateElementKey = dateFormatted;
    }
    dateRangeOptions.assignAll({
      'Today': {"from": todayStart, "to": todayEnd},
      'Yesterday': {
        "from": todayStart.subtract(const Duration(days: 1)),
        "to": todayStart.subtract(const Duration(seconds: 1)),
      },
      'This week': {"from": startOfThisWeek, "to": todayEnd},
      'This month': {"from": DateTime(now.year, now.month, 1), "to": todayEnd},
      'This year': {"from": DateTime(now.year, 1, 1), "to": todayEnd},
      'Custom date': {"from": todayStart, "to": todayEnd},
    });
    if (customDateElementKey.trim().isNotEmpty) {
      dateRangeOptions[customDateElementKey] = customDateElementValue;
    }
  }

  void applyPredefinedDateRange(
    String key,
    BuildContext context,
    int index,
  ) async {
    if (currentSelectedDate.value != index) {
      try {
        if (key == 'Custom date') {
          final results = await showCalendarDatePicker2Dialog(
            dialogBackgroundColor: Colors.white,
            context: context,
            config: CalendarDatePicker2WithActionButtonsConfig(
              selectedDayHighlightColor: Colors.black,
              selectedRangeHighlightColor: Colors.grey.shade200,
              daySplashColor: Colors.grey.shade200,
              calendarType: CalendarDatePicker2Type.range,
            ),
            dialogSize: const Size(475, 375),
            borderRadius: BorderRadius.circular(15),
          );
          if (results != null) {
            if (results.first != null) {
              dateFrom = results.first!;
              dateTo = results.last!;
              String dateFormatted = DateFormat(
                'MMM dd, yyyy',
              ).format(dateFrom!);
              dateTo = DateTime(
                results.last!.year,
                results.last!.month,
                results.last!.day,
                23,
                59,
                59,
              );
              if (dateFrom!.day != dateTo!.day) {
                dateFormatted +=
                    ' - ${DateFormat('MMM dd, yyyy').format(dateTo!)}';
              }
              final dateKey = dateRangeOptions.keys.toList().elementAt(
                currentSelectedDate.value,
              );
              if (isDate(dateKey)) {
                dateRangeOptions.remove(dateKey);
              }
              dateRangeOptions[dateFormatted] = {
                "from": dateFrom!,
                "to": dateTo!,
              };
              currentSelectedDate.value = dateRangeOptions.length - 1;
              listenToSessionsHistory();
            }
          } else {
            resetDateFilter();
          }
        } else {
          final selectedRange = dateRangeOptions[key];
          if (selectedRange != null) {
            dateFrom = selectedRange["from"];
            dateTo = selectedRange["to"];
            listenToSessionsHistory();
            final dateKey = dateRangeOptions.keys.toList().elementAt(
              currentSelectedDate.value,
            );
            if (isDate(dateKey)) {
              dateRangeOptions.remove(dateKey);
            }
            currentSelectedDate.value = index;
          }
        }
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        resetDateFilter();
      }
    }
  }

  void resetDateFilter() {
    final dateKey = dateRangeOptions.keys.toList().elementAt(
      currentSelectedDate.value,
    );
    if (isDate(dateKey) && dateRangeOptions.containsKey(dateKey)) {
      dateRangeOptions.remove(dateKey);
    }
    final now = DateTime.now();
    dateFrom = DateTime(now.year, now.month, now.day);
    dateTo = DateTime(now.year, now.month, now.day, 23, 59, 59);
    currentSelectedDate.value = 0;
    listenToSessionsHistory();
  }

  bool isDate(String input) {
    final yearRegex = RegExp(r'\b(?:\d{4}|[٠-٩]{4})\b');
    final normalizedInput = input.replaceAllMapped(
      RegExp(r'[٠-٩]'),
      (match) => (match.group(0)!.codeUnitAt(0) - 0x0660).toString(),
    );
    return yearRegex.hasMatch(normalizedInput);
  }

  Future<void> _checkForRunningSession() async {
    try {
      final snapshot =
          await _firestore
              .collection('engine_sessions')
              .where('status', isEqualTo: 'running')
              .orderBy('start_time', descending: true)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        currentSessionId = snapshot.docs.first.id;
        isSessionRunning.value = true;
        _startFetching();
      }
    } catch (e) {
      if (kDebugMode) print("Failed to check running session: $e");
      showSnackBar(
        text: "Failed to check running session",
        snackBarType: SnackBarType.error,
      );
    }
  }

  Future<void> startEngine() async {
    try {
      final response = await http
          .post(Uri.parse('$espIp/start'))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        AppInit.player.setAsset(kStartupSounds).whenComplete(() {
          AppInit.player.play();
        });

        final sessionDoc = _firestore.collection('engine_sessions').doc();
        currentSessionId = sessionDoc.id;
        await sessionDoc.set({
          'start_time': FieldValue.serverTimestamp(),
          'status': 'running',
        });
        isSessionRunning.value = true;
        _startFetching();
      }
    } catch (e) {
      showSnackBar(
        text: "Failed to start engine",
        snackBarType: SnackBarType.error,
      );
      if (kDebugMode) print("Failed to start engine: $e");
    }
  }

  void onRefresh() {
    listenToSessionsHistory();
    sessionsRefreshController.refreshToIdle();
    sessionsRefreshController.resetNoData();
  }

  void _startFetching() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => fetchMetrics());
  }

  Future<void> fetchMetrics() async {
    try {
      final response = await http
          .get(Uri.parse('$espIp/metrics'))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200 && currentSessionId != null) {
        final data = jsonDecode(response.body);

        combustionIn.value = data['combustion_in'];
        combustionOut.value = data['combustion_out'];
        exhaust.value = data['exhaust'];
        turbine.value = data['turbine'];
        oilIn.value = data['oil_in'];
        oilOut.value = data['oil_out'];
        rpm.value = data['rpm'];

        await _firestore
            .collection('engine_sessions')
            .doc(currentSessionId)
            .update({
              'timestamp': FieldValue.serverTimestamp(),
              'combustion_in': combustionIn.value,
              'combustion_out': combustionOut.value,
              'exhaust': exhaust.value,
              'turbine': turbine.value,
              'oil_in': oilIn.value,
              'oil_out': oilOut.value,

              'rpm': rpm.value,
            });
      }
    } catch (e) {
      showSnackBar(
        text: "Failed to fetch metrics",
        snackBarType: SnackBarType.error,
      );
      if (kDebugMode) print("Failed to fetch metrics: $e");
    }
  }

  Future<void> stopEngine() async {
    try {
      final response = await http
          .post(Uri.parse('$espIp/stop'))
          .timeout(const Duration(seconds: 3));
      if (kDebugMode) print(response.body);
      if (response.statusCode == 200) {
        await _endSession('stopped');
      }
    } catch (e) {
      showSnackBar(
        text: "Failed to stop engine",
        snackBarType: SnackBarType.error,
      );
      if (kDebugMode) print("Failed to stop engine: $e");
    }
  }

  Future<void> emergencyStop() async {
    try {
      final response = await http
          .post(Uri.parse('$espIp/emergencyStop'))
          .timeout(const Duration(seconds: 3));
      if (kDebugMode) print(response.body);
      if (response.statusCode == 200) {
        await _endSession('emergency_stopped');
        isStartButtonSelected.value = false;
      }
    } catch (e) {
      showSnackBar(
        text: "Failed to emergency stop engine",
        snackBarType: SnackBarType.error,
      );
      if (kDebugMode) print("Failed to emergency stop engine: $e");
    }
  }

  Future<void> _endSession(String status) async {
    if (currentSessionId != null) {
      await _firestore
          .collection('engine_sessions')
          .doc(currentSessionId)
          .update({'end_time': FieldValue.serverTimestamp(), 'status': status});
      currentSessionId = null;
    }
    isSessionRunning.value = false;
    _timer?.cancel();
    _resetMetrics();
  }

  void listenToSessionsHistory() {
    try {
      loadingSessions.value = true;
      sessionsHistoryList.clear();
      sessionsListener?.cancel();

      final CollectionReference sessionsRef = FirebaseFirestore.instance
          .collection('engine_sessions');

      Query query = sessionsRef.where('status', isNotEqualTo: 'running');

      if (dateFrom != null) {
        query = query.where(
          'start_time',
          isGreaterThanOrEqualTo: Timestamp.fromDate(dateFrom!),
        );
      }
      if (dateTo != null) {
        query = query.where(
          'start_time',
          isLessThanOrEqualTo: Timestamp.fromDate(dateTo!),
        );
      }

      query = query.orderBy('start_time', descending: true);

      sessionsListener = query.snapshots().listen((snapshot) {
        final sessions =
            snapshot.docs.map((doc) {
              final sessionData = doc.data() as Map<String, dynamic>;
              return EngineSessionModel.fromFirestore(sessionData, doc.id);
            }).toList();

        sessionsHistoryList.value = sessions;
        loadingSessions.value = false;

        if (kDebugMode) print("Got sessions: ${sessionsHistoryList.length}");
      });
    } catch (e) {
      loadingSessions.value = false;
      if (kDebugMode) print("Error listening to session history: $e");
      showSnackBar(
        text: "Failed to load session history",
        snackBarType: SnackBarType.error,
      );
    }
  }

  @override
  void onClose() {
    sessionsListener?.cancel();
    sessionsRefreshController.dispose();
    super.onClose();
  }

  void _resetMetrics() {
    combustionIn.value = 0;
    combustionOut.value = 0;
    exhaust.value = 0;
    turbine.value = 0;
    oilIn.value = 0;
    oilOut.value = 0;

    rpm.value = 0;
  }

  void onSessionTap({
    required int chosenIndex,
    required GetScreenType screenType,
  }) {
    Get.to(
      () => SessionHistoryPage(
        sessionModel: sessionsHistoryList[chosenIndex],
        screenType: screenType,
      ),
      transition: getPageTransition(),
    );
  }
}
