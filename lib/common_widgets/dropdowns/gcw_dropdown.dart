import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';

class GCWDropDown<T extends Object?> extends StatefulWidget {
  final void Function(T) onChanged;
  final List<GCWDropDownMenuItem> items;
  final T value;
  final DropdownButtonBuilder? selectedItemBuilder;
  final String? title;
  final bool alternativeColor;

  const GCWDropDown(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged,
      this.selectedItemBuilder,
      this.title,
      this.alternativeColor = false})
      : super(key: key);

  @override
  _GCWDropDownState createState() => _GCWDropDownState<T>();
}

class _GCWDropDownState<T extends Object?> extends State<GCWDropDown> {
  @override
  Widget build(BuildContext context) {
    ThemeColors colors = themeColors();

    var textStyle = gcwTextStyle();
    if (widget.alternativeColor) textStyle = textStyle.copyWith(color: colors.dialogText());

    return Row(
      children: [
        if (widget.title != null && widget.title!.isNotEmpty)
          Expanded(
              child: GCWText(
                text: widget.title! + ':',
              ),
              flex: 1),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                height: 39,
                margin: EdgeInsets.symmetric(vertical: DEFAULT_MARGIN),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ROUNDED_BORDER_RADIUS),
                  border: Border.all(
                      color: widget.alternativeColor ? colors.dialogText() : colors.accent(),
                      style: BorderStyle.solid,
                      width: 1.0),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: widget.alternativeColor ? colors.dialogText() : colors.accent(),
                  ),
                  value: widget.value ?? widget.items[0].value,
                  items: widget.items.map((item) {
                    return DropdownMenuItem(
                        value: item.value, child: item.child is Widget ? item.child as Widget : _buildMenuItemChild(item));
                  }).toList(),
                  onChanged: widget.onChanged,
                  style: textStyle,
                  selectedItemBuilder: widget.selectedItemBuilder ??
                      (context) {
                        return widget.items.map((item) {
                          return Align(
                            child: item.child is Widget
                                ? item.child as Widget
                                : Text(
                                    item.child.toString(),
                                    style: textStyle,
                                  ),
                            alignment: Alignment.centerLeft,
                          );
                        }).toList();
                      },
                ))),
            flex: 3)
      ],
    );
  }
}

//Note: No GCWText, since GCWText contains SelectableText which suppress clicks,
// and therefore generate non-selectable dropdown items (09/2020)
Widget _buildMenuItemChild(GCWDropDownMenuItem item) {
  if (item.subtitle == null || item.subtitle!.isEmpty) {
    return item.child is Widget
        ? item.child as Widget
        : Text(
            item.child.toString(),
            style: item.style ?? gcwTextStyle(),
          );
  } else {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          item.child.toString(),
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: item.style ?? gcwTextStyle(),
        ),
        Container(
            child: Text(
              item.subtitle.toString(),
              style: gcwDescriptionTextStyle(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN)),
      ]),
      padding: EdgeInsets.only(bottom: 10),
    );
  }
}

class GCWDropDownMenuItem {
  final Object value;
  final Object child;
  final String? subtitle;
  final TextStyle? style;

  const GCWDropDownMenuItem({required this.value, required this.child, this.subtitle, this.style});
}
