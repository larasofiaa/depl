import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenericNotifier extends StateNotifier<bool> {
 
  GenericNotifier() : super(false);

  _initialize()  {
    state = false;
  }

   setToGeneric() {
    state = true;
  }

   resetToGeneral() {
    state = false;
  }

}

final genericFlagProvider = StateNotifierProvider<GenericNotifier, bool>((ref) {
  final gfn = GenericNotifier();
  gfn._initialize();
  return gfn;
});