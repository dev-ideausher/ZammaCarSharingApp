import 'package:get/get.dart';

import '../controllers/document_type_list_controller.dart';

class DocumentTypeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentTypeListController>(
      () => DocumentTypeListController(),
    );
  }
}
