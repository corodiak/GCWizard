import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWIntegerSpinner extends StatefulWidget {
  final Function onChanged;
  final title;
  final value;
  final min;
  final max;
  final controller;
  final SpinnerLayout layout;
  final focusNode;

  const GCWIntegerSpinner({
    Key key,
    this.onChanged,
    this.title,
    this.value: 0,
    this.min,
    this.max,
    this.controller,
    this.layout: SpinnerLayout.horizontal,
    this.focusNode
  }) : super(key: key);

  @override
  GCWIntegerSpinnerState createState() => GCWIntegerSpinnerState();
}

class GCWIntegerSpinnerState extends State<GCWIntegerSpinner> {
  var _controller;
  var _currentValue = 0;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      if (widget.value != null)
        _currentValue = widget.value;

      _controller = TextEditingController(text: _currentValue.toString());
    }
  }

  @override
  void dispose() {
    if (widget.controller == null)
      _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSpinner();
  }

  _decreaseValue() {
    setState(() {
      if (widget.min == null || _currentValue > widget.min)
        _currentValue--;

      _setCurrentValueAndEmitOnChange(setTextFieldText: true);
    });
  }

  _increaseValue() {
    setState(() {
      if (widget.max == null || _currentValue < widget.max)
        _currentValue++;

      _setCurrentValueAndEmitOnChange(setTextFieldText: true);
    });
  }

  Widget _buildTitle() {
    return widget.title == null ?  Container() :
      Expanded(
        child: GCWText(
          text: widget.title + ':'
        ),
        flex: 1
      );
  }

  Widget _buildTextField() {
    return GCWIntegerTextField(
      focusNode: widget.focusNode,
      min: widget.min,
      max: widget.max,
      controller: _controller,
      onChanged: (ret) {
        setState(() {
          _currentValue = ret['value'];
          _setCurrentValueAndEmitOnChange();
        });
      }
    );
  }

  Widget _buildSpinner() {
    if (widget.layout == SpinnerLayout.horizontal) {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  child: GCWIconButton(
                      iconData: Icons.remove,
                      onPressed: _decreaseValue
                  ),
                  margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
                  ),
                ),
                Expanded(
                  child: _buildTextField()
                ),
                Container(
                  child: GCWIconButton(
                      iconData: Icons.add,
                      onPressed: _increaseValue
                  ),
                  margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
                  ),
                )
              ],
            ),
            flex: 3
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GCWIconButton(
                  iconData: Icons.arrow_drop_up,
                  onPressed: _increaseValue
                ),
                _buildTextField(),
                GCWIconButton(
                  iconData: Icons.arrow_drop_down,
                  onPressed: _decreaseValue
                ),
              ],
            ),
            flex: 3
          ),
        ],
      );
    }
  }

  _setCurrentValueAndEmitOnChange({setTextFieldText: false}) {
    if (setTextFieldText)
      _controller.text = _currentValue.toString();

    widget.onChanged(_currentValue);
  }
}