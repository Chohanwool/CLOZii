// core
import 'package:clozii/core/widgets/custom_choice_chips.dart';

// features
import 'package:clozii/features/post/core/enums/trade_type.dart';

// packages
import 'package:flutter/material.dart';

class TradeTypeSelector extends StatefulWidget {
  const TradeTypeSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final TradeType selected;
  final ValueChanged<TradeType> onSelected;

  @override
  State<TradeTypeSelector> createState() => _TradeTypeSelectorState();
}

class _TradeTypeSelectorState extends State<TradeTypeSelector> {
  late TradeType _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        CustomChoiceChips(
          label: 'For Sale',
          selected: _selected == TradeType.sell,
          onSelected: () {
            setState(() {
              _selected = TradeType.sell;
            });
            widget.onSelected.call(TradeType.sell);
          },
        ),
        CustomChoiceChips(
          label: 'For Share',
          selected: _selected == TradeType.share,
          onSelected: () {
            setState(() {
              _selected = TradeType.share;
            });
            widget.onSelected.call(TradeType.share);
          },
        ),
      ],
    );
  }
}
