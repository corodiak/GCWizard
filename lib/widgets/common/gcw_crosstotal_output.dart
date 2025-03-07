import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/crosstotals.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

enum CROSSTOTAL_INPUT_TYPE { LETTERS, NUMBERS }

class GCWCrosstotalOutput extends StatefulWidget {
  final List<int> values;
  final String text;
  final suppressSums;
  final CROSSTOTAL_INPUT_TYPE inputType;

  const GCWCrosstotalOutput(
      {this.text, this.values, Key key, this.suppressSums: false, this.inputType: CROSSTOTAL_INPUT_TYPE.LETTERS})
      : super(key: key);

  @override
  _GCWCrosstotalOutputState createState() => _GCWCrosstotalOutputState();
}

class _GCWCrosstotalOutputState extends State<GCWCrosstotalOutput> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[Container(height: 30), _buildCrosstotalContent(context)]);
  }

  Widget _buildCrosstotalContent(BuildContext context) {
    var text = widget.text;
    List<int> values = List.from(widget.values);

    var crosstotalValuesCommon = [
      widget.suppressSums
          ? null
          : [
              i18n(context, 'crosstotal_sum') +
                  (widget.inputType == CROSSTOTAL_INPUT_TYPE.LETTERS ? '\n(${i18n(context, 'common_wordvalue')})' : ''),
              sum(values)
            ],
      [i18n(context, 'crosstotal_sum_crosssum'), sumCrossSum(values)],
      [i18n(context, 'crosstotal_sum_crosssum_iterated'), sumCrossSumIterated(values)],
    ];

    var crosstotalValuesOthers;
    if (widget.inputType == CROSSTOTAL_INPUT_TYPE.NUMBERS)
      crosstotalValuesOthers = [
        widget.suppressSums ? null : [i18n(context, 'crosstotal_count_numbers'), countCharacters(values)],
      ];
    else
      crosstotalValuesOthers = [
        widget.suppressSums ? null : [i18n(context, 'crosstotal_count_characters'), countCharacters(values)],
        widget.suppressSums ? null : [i18n(context, 'crosstotal_count_letters'), countLetters(text)],
        widget.suppressSums ? null : [i18n(context, 'crosstotal_count_digits'), countDigits(text)]
      ];
    var crosstotalValuesBody = [
      widget.suppressSums ? null : [i18n(context, 'crosstotal_sum_alternated_back'), sumAlternatedBackward(values)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_sum_alternated_forward'), sumAlternatedForward(values)],
      [
        i18n(context, 'crosstotal_sum_crosssum_alternated_back'),
        sumCrossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')
      ],
      [
        i18n(context, 'crosstotal_sum_crosssum_alternated_forward'),
        sumCrossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')
      ],
      [i18n(context, 'crosstotal_crosssum'), crossSum(values)],
      [i18n(context, 'crosstotal_crosssum_iterated'), crossSumIterated(values)],
      [
        i18n(context, 'crosstotal_crosssum_alternated_back'),
        crossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')
      ],
      [
        i18n(context, 'crosstotal_crosssum_alternated_forward'),
        crossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')
      ],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_product'), product(values)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_product_alternated'), productAlternated(values)],
      [i18n(context, 'crosstotal_product_crosssum'), productCrossSum(values)],
      [i18n(context, 'crosstotal_product_crosssum_iterated'), productCrossSumIterated(values)],
      [
        i18n(context, 'crosstotal_product_crosssum_alternated_back'),
        productCrossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')
      ],
      [
        i18n(context, 'crosstotal_product_crosssum_alternated_forward'),
        productCrossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')
      ],
      [i18n(context, 'crosstotal_crossproduct'), crossProduct(values)],
      [i18n(context, 'crosstotal_crossproduct_iterated'), crossProductIterated(values)],
      [
        i18n(context, 'crosstotal_crossproduct_alternated'),
        crossProductAlternated(values) ?? i18n(context, 'common_notdefined')
      ],
    ];
    crosstotalValuesOthers.addAll(crosstotalValuesBody);

    return Column(
      children: [
        GCWTextDivider(text: i18n(context, 'crosstotal_commonsums'), suppressTopSpace: true),
        Column(
          children: columnedMultiLineOutput(context, crosstotalValuesCommon, flexValues: [2, 1]),
        ),
        GCWTextDivider(text: i18n(context, 'crosstotal_othersums')),
        Column(
          children: columnedMultiLineOutput(context, crosstotalValuesOthers, flexValues: [2, 1]),
        ),
      ],
    );

    return Column(children: columnedMultiLineOutput(context, crosstotalValuesOthers, flexValues: [2, 1]));
  }
}
