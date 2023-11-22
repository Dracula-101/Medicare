import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomValuePicker extends StatefulWidget {
  final List<String> values;
  final String? firstValue, lastValue;
  final String? title;
  final double? height, width;
  const CustomValuePicker({
    super.key,
    required this.values,
    this.title,
    this.firstValue,
    this.lastValue,
    this.height,
    this.width,
  });

  @override
  State<CustomValuePicker> createState() => _CustomValuePickerState();
}

class _CustomValuePickerState extends State<CustomValuePicker> {
  String? _selectedItem;
  List<String>? allItems;
  @override
  Widget build(BuildContext context) {
    allItems = [
      if (widget.firstValue != null) widget.firstValue!,
      ...widget.values,
      if (widget.lastValue != null) widget.lastValue!,
    ];
    _selectedItem = allItems?[0];
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: widget.height ?? 300,
          width: widget.width ?? 250,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade200
                : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Text(
                  widget.title ?? 'Select a value',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: StatefulBuilder(builder: (context, setState) {
                  return CupertinoPicker(
                    itemExtent:
                        (Theme.of(context).textTheme.bodyMedium?.height ?? 20) +
                            10,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _selectedItem = allItems?[value];
                      });
                    },
                    children: [
                      for (var item in allItems ?? [])
                        Center(
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, null);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Text(
                          'Reset',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, _selectedItem);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Text(
                          'Ok',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
