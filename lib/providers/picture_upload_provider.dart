import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PictureUploadNotifier extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> uploadImage(File image, String fileName) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;
      await supabase.storage.from('images').upload(fileName, image);
    });
  }

  String getImageUrl(String fileName) {
    final supabase = Supabase.instance.client;
    final url = supabase.storage.from('images').getPublicUrl(fileName);
    return url;
  }
}

final pictureUploadProvider =
    AsyncNotifierProvider<PictureUploadNotifier, void>(
      PictureUploadNotifier.new,
    );
