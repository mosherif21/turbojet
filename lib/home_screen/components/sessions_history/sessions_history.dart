import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:turbo_jet/general/general_functions.dart';
import 'package:turbo_jet/home_screen/components/sessions_history/session_widget.dart';
import 'package:turbo_jet/home_screen/controllers/home_screen_controller.dart';

class SessionsHistory extends StatelessWidget {
  const SessionsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeScreenController.instance;
    final screenType = GetScreenType(context);
    final screenHeight = getScreenHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sessions History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Obx(
                () => SizedBox(
                  width:
                      controller.dateRangeOptions.keys.length > 6
                          ? controller.dateRangeOptions.keys
                                  .toList()
                                  .elementAt(
                                    controller.currentSelectedDate.value,
                                  )
                                  .contains('-')
                              ? 260
                              : 170
                          : 150,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items:
                          controller.dateRangeOptions.keys
                              .toList()
                              .map(
                                (String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    item,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: controller.dateRangeOptions.keys
                          .toList()
                          .elementAt(controller.currentSelectedDate.value),
                      onChanged:
                          (key) =>
                              key != null
                                  ? controller.applyPredefinedDateRange(
                                    key,
                                    context,
                                    controller.dateRangeOptions.keys
                                        .toList()
                                        .indexOf(key),
                                  )
                                  : controller.applyPredefinedDateRange(
                                    'Today',
                                    context,
                                    0,
                                  ),
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 40),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StretchingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                child: RefreshConfiguration(
                  headerTriggerDistance: 60,
                  maxOverScrollExtent: 20,
                  enableLoadingWhenFailed: true,
                  hideFooterWhenNotFull: true,
                  child: SmartRefresher(
                    enablePullDown: true,
                    header: ClassicHeader(
                      completeDuration: const Duration(milliseconds: 0),
                      releaseText: 'Release to refresh',
                      refreshingText: 'Refreshing',
                      idleText: 'Pull to refresh',
                      completeText: 'Refresh completed',
                      iconPos: IconPosition.left,
                      textStyle: const TextStyle(color: Colors.grey),
                      failedIcon: const Icon(Icons.error, color: Colors.grey),
                      completeIcon: const Icon(Icons.done, color: Colors.grey),
                      idleIcon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.grey,
                      ),
                      releaseIcon: const Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                    ),
                    controller: controller.sessionsRefreshController,
                    onRefresh: () => controller.onRefresh(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: AnimationLimiter(
                        child: Obx(
                          () =>
                              !controller.loadingSessions.value &&
                                      controller.sessionsHistoryList.isEmpty
                                  ? const NoSessionsWidget()
                                  : GridView.builder(
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              screenType.isPhone ? 1 : 3,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                          childAspectRatio: 2.5,
                                        ),
                                    itemCount:
                                        controller.loadingSessions.value
                                            ? 20
                                            : controller
                                                .sessionsHistoryList
                                                .length,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        columnCount: screenType.isPhone ? 1 : 3,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child:
                                                controller.loadingSessions.value
                                                    ? const LoadingSessionWidget()
                                                    : SessionWidget(
                                                      sessionDate: getOrderDateTime(
                                                        controller
                                                            .sessionsHistoryList[index]
                                                            .startTime!,
                                                      ),
                                                      onTap:
                                                          () => controller
                                                              .onSessionTap(
                                                                chosenIndex:
                                                                    index,
                                                                screenType:
                                                                    screenType,
                                                              ),
                                                      stoppingStatus:
                                                          controller
                                                              .sessionsHistoryList[index]
                                                              .status,
                                                    ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getOrderDateTime(DateTime dateTime) {
    return DateFormat('dd/MM • hh:mm a').format(dateTime);
  }
}
