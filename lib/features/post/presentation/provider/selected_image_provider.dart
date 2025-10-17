// features
import 'package:clozii/features/post/presentation/states/image_data.dart';
import 'package:clozii/features/post/presentation/viewmodels/selected_image_view_model.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageProvider =
    NotifierProvider<SelectedImageViewModel, Map<String, ImageData>>(
      SelectedImageViewModel.new,
    );
