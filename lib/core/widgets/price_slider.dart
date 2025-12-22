import 'package:clozii/core/utils/number_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceSlider extends StatefulWidget {
  const PriceSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
  });

  final double minValue;
  final double maxValue;

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  late RangeValues _values;
  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;
  late final FocusNode _minPriceFocusNode;
  late final FocusNode _maxPriceFocusNode;
  bool _showPriceExceedingMax = false;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.minValue, widget.maxValue);
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();
    _minPriceFocusNode = FocusNode();
    _maxPriceFocusNode = FocusNode();
    _minPriceFocusNode.addListener(_handleMinFocusChange);
    _maxPriceFocusNode.addListener(_handleMaxFocusChange);
    _syncPriceControllers();
  }

  @override
  void dispose() {
    _minPriceFocusNode.removeListener(_handleMinFocusChange);
    _maxPriceFocusNode.removeListener(_handleMaxFocusChange);
    _minPriceFocusNode.dispose();
    _maxPriceFocusNode.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _syncPriceControllers() {
    _minPriceController.text = formatPrice(_values.start.round());
    _maxPriceController.text = formatPrice(_values.end.round());
  }

  int? _tryParsePrice(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return int.tryParse(trimmed.replaceAll(',', ''));
  }

  void _setFormattedText(
    TextEditingController controller,
    int value,
  ) {
    final formatted = formatPrice(value);
    if (controller.text == formatted) {
      return;
    }
    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _handleMinFocusChange() {
    if (_minPriceFocusNode.hasFocus) {
      return;
    }
    if (_showPriceExceedingMax) {
      _syncPriceControllers();
      return;
    }
    final parsed = _tryParsePrice(_minPriceController.text);
    if (parsed == null) {
      final clamped = widget.minValue
          .toInt()
          .clamp(widget.minValue.toInt(), _values.end.round());
      setState(() {
        _values = RangeValues(
          clamped.toDouble(),
          _values.end,
        );
        _setFormattedText(
          _minPriceController,
          clamped,
        );
      });
      return;
    }
    final clamped = parsed.clamp(
      widget.minValue.toInt(),
      _values.end.round(),
    );
    setState(() {
      _values = RangeValues(
        clamped.toDouble(),
        _values.end,
      );
      _setFormattedText(
        _minPriceController,
        clamped,
      );
    });
  }

  void _handleMaxFocusChange() {
    if (_maxPriceFocusNode.hasFocus) {
      return;
    }
    if (_showPriceExceedingMax) {
      _syncPriceControllers();
      return;
    }
    final parsed = _tryParsePrice(_maxPriceController.text);
    if (parsed == null) {
      final clamped = _values.start.round();
      setState(() {
        _values = RangeValues(
          _values.start,
          clamped.toDouble(),
        );
        _setFormattedText(
          _maxPriceController,
          clamped,
        );
      });
      return;
    }
    final clamped = parsed.clamp(
      _values.start.round(),
      widget.maxValue.toInt(),
    );
    setState(() {
      _values = RangeValues(
        _values.start,
        clamped.toDouble(),
      );
      _setFormattedText(
        _maxPriceController,
        clamped,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = _showPriceExceedingMax;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RangeSlider(
          values: _values,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: 20,
          labels: RangeLabels(
            formatPrice(_values.start.round()),
            formatPrice(_values.end.round()),
          ),
          onChanged: isDisabled
              ? null
              : (newValues) {
                  setState(() {
                    _values = newValues;
                    _syncPriceControllers();
                  });
                },
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            const SizedBox(width: 20.0),
            Expanded(
              child: TextField(
                controller: _minPriceController,
                enabled: !isDisabled,
                keyboardType: TextInputType.number,
                focusNode: _minPriceFocusNode,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                inputFormatters: [
                  const _PriceInputFormatter(),
                ],
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Minimum',
                  prefixText: '₱',
                ),
                onChanged: isDisabled
                    ? null
                    : (value) {
                        final parsed = _tryParsePrice(value);
                        if (parsed == null) {
                          return;
                        }
                        if (parsed < widget.minValue.toInt() ||
                            parsed > _values.end.round()) {
                          return;
                        }
                        setState(() {
                          _values = RangeValues(
                            parsed.toDouble(),
                            _values.end,
                          );
                        });
                      },
              ),
            ),
            const SizedBox(width: 20.0),
            const Text('-'),
            const SizedBox(width: 20.0),
            Expanded(
              child: TextField(
                controller: _maxPriceController,
                enabled: !isDisabled,
                keyboardType: TextInputType.number,
                focusNode: _maxPriceFocusNode,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                inputFormatters: [
                  const _PriceInputFormatter(),
                ],
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'Maximum',
                  prefixText: '₱',
                ),
                onChanged: isDisabled
                    ? null
                    : (value) {
                        final parsed = _tryParsePrice(value);
                        if (parsed == null) {
                          return;
                        }
                        if (parsed < _values.start.round() ||
                            parsed > widget.maxValue.toInt()) {
                          return;
                        }
                        setState(() {
                          _values = RangeValues(
                            _values.start,
                            parsed.toDouble(),
                          );
                        });
                      },
              ),
            ),
            const SizedBox(width: 20.0),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              shape: const CircleBorder(),
              value: _showPriceExceedingMax,
              onChanged: (bool? value) {
                setState(() {
                  _showPriceExceedingMax = value ?? false;
                });
              },
            ),
            const Text('show items exceeding max price')
          ],
        ),
      ],
    );
  }
}

class _PriceInputFormatter extends TextInputFormatter {
  const _PriceInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    final formatted = formatPrice(int.parse(digits));
    final digitsLeft = _countDigitsBeforeSelection(
      newValue.text,
      newValue.selection.end,
    );
    final newCursor = _cursorForDigitIndex(formatted, digitsLeft);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }

  int _countDigitsBeforeSelection(String text, int selectionEnd) {
    final limit = selectionEnd.clamp(0, text.length);
    var count = 0;
    for (var i = 0; i < limit; i++) {
      if (_isDigit(text.codeUnitAt(i))) {
        count++;
      }
    }
    return count;
  }

  int _cursorForDigitIndex(String formatted, int digitsLeft) {
    if (digitsLeft <= 0) {
      return 0;
    }
    var count = 0;
    for (var i = 0; i < formatted.length; i++) {
      if (_isDigit(formatted.codeUnitAt(i))) {
        count++;
        if (count == digitsLeft) {
          return i + 1;
        }
      }
    }
    return formatted.length;
  }

  bool _isDigit(int codeUnit) {
    return codeUnit >= 48 && codeUnit <= 57;
  }
}
