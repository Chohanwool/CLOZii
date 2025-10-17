// features
import 'package:clozii/features/post/presentation/viewmodels/selected_image_view_model.dart';
import 'package:clozii/features/post_old/data/image_data.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageProvider =
    NotifierProvider<SelectedImageViewModel, Map<String, ImageData>>(
      SelectedImageViewModel.new,
    );
