import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/models/picture.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final picturesProvider = FutureProvider<List<Picture>>((ref) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('pictures').select();
  final List<Picture> pictures = [];
  for (final row in response) {
    pictures.add(Picture.fromJson(row));
  }
  return pictures;
});

class CreatePictureNotifier extends AsyncNotifier<void> {
  @override
  build() {}

  Future<void> createPicture(String title, String image) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;
      await supabase.from('pictures').insert({'title': title, 'image': image});
    });
  }
}

final createPictureProvider =
    AsyncNotifierProvider<CreatePictureNotifier, void>(
      CreatePictureNotifier.new,
    );
