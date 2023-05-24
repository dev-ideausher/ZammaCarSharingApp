import 'package:get/get.dart';

import '../controllers/report_an_issue_controller.dart';

class ReportAnIssueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportAnIssueController>(
      () => ReportAnIssueController(),
    );
  }
}
