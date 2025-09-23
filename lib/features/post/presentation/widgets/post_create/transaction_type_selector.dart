import 'package:clozii/core/widgets/custom_choice_chips.dart';
import 'package:clozii/features/post/data/enums.dart';
import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatefulWidget {
  const TransactionTypeSelector({super.key, required this.onSelected});

  final ValueChanged<TransactionType> onSelected;

  @override
  State<TransactionTypeSelector> createState() =>
      _TransactionTypeSelectorState();
}

class _TransactionTypeSelectorState extends State<TransactionTypeSelector> {
  TransactionType _selected = TransactionType.sale;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        CustomChoiceChips(
          label: 'For Sale',
          selected: _selected == TransactionType.sale,
          onSelected: () {
            setState(() {
              _selected = TransactionType.sale;
            });
            widget.onSelected.call(TransactionType.sale);
          },
        ),
        CustomChoiceChips(
          label: 'For Share',
          selected: _selected == TransactionType.share,
          onSelected: () {
            setState(() {
              _selected = TransactionType.share;
            });
            widget.onSelected.call(TransactionType.share);
          },
        ),
      ],
    );
  }
}
