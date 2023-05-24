import 'package:get/get.dart';

import '../controllers/saved_cards_controller.dart';

class SavedCardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedCardsController>(
      () => SavedCardsController(),
    );
  }
}
