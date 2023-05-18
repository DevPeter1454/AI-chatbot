import 'package:ask_ai/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:ask_ai/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:ask_ai/ui/views/home/home_view.dart';
import 'package:ask_ai/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:ask_ai/ui/views/chat/chat_view.dart';
import 'package:ask_ai/services/api_service.dart';
import 'package:ask_ai/services/download_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    // MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: ChatView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),

    LazySingleton(classType: ApiService),
    LazySingleton(classType: DownloadService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
