// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// package
import 'package:flutter/material.dart';

class MeetingPointSelector extends StatelessWidget {
  const MeetingPointSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: AppColors.black,
        child: Center(
          child: Text(
            'Google Map',
            style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
