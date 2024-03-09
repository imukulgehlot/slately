import 'package:flutter/material.dart';

import '../basic_features.dart';

class MultiSelectionChip extends StatefulWidget {
  final List<String> itemList;
  final List<String>? selectedItems;
  final Function? onSelectionChanged;
  final bool viewOnly;

  const MultiSelectionChip(
      {super.key,
      required this.itemList,
      this.onSelectionChanged,
      this.selectedItems,
      this.viewOnly = false} // +added
      );

  @override
  ProfessionSelectChipState createState() => ProfessionSelectChipState();
}

class ProfessionSelectChipState extends State<MultiSelectionChip> {
  late List<String> selectedItems;

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.itemList) {
      choices.add(GestureDetector(
        onTap: widget.viewOnly
            ? null
            : () {
                selectedItems.contains(item)
                    ? selectedItems.remove(item)
                    : selectedItems.add(item);
                if (widget.onSelectionChanged != null) {
                  setState(() {
                    widget.onSelectionChanged!(selectedItems);
                  });
                }
                // });
              },
        child: Container(
            margin: EdgeInsets.only(top: Dimensions.h10, right: Dimensions.w5),
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h18, horizontal: Dimensions.w21),
            //  height: 32,
            // padding: EdgeInsets.only(left: Dimensions.w12,right: Dimensions.w12),
            decoration: BoxDecoration(
              color: selectedItems.contains(item)
                  ? ColorConst.themeGreen
                  : ColorConst.textFieldColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.sp30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: Text(
                  item,
                  style: fontStyleSemiBold16.copyWith(
                      color: selectedItems.contains(item)
                          ? ColorConst.whiteColor
                          : null),
                )),
                SizedBox(
                  width: Dimensions.w4,
                ),
                selectedItems.contains(item)
                    ? const Icon(
                        Icons.done,
                        color: ColorConst.whiteColor,
                        size: 18,
                      )
                    : const SizedBox.shrink(),
              ],
            )),
      ));
    }
    return choices;
  }

  @override
  void initState() {
    selectedItems = widget.selectedItems ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: _buildChoiceList(),
    );
  }
}
