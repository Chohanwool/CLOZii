import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  FilterBar({super.key});

  final List<Widget> filterButtonLabels = [
    Row(
      children: [
        Text('Price'),
        const SizedBox(width: 4.0),
        Icon(CupertinoIcons.chevron_down, size: 16.0),
      ],
    ),
    Text('Shares'),
    Text('NearBy'),
    Text('Category'),
    Text('Shoes'),
    Text('Phone'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(filterButtonLabels.length, (index) {
            return Row(
              children: [
                // 버튼 앞에 여백 추가
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('tapped $index');
                    },
                    child: Container(
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(child: filterButtonLabels[index]),
                    ),
                  ),
                ),

                // 마지막 버튼 뒤에 여백 추가
                if (index == filterButtonLabels.length - 1)
                  const SizedBox(width: 12.0),
              ],
            );
          }),
        ),
      ),
    );
  }
}
