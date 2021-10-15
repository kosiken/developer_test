import 'package:flutter/material.dart';
import 'package:developer_test/constants/colors.dart';
// import 'package:flutter/services.dart';

typedef KosyInputOnChangeCallback = void Function(String value);

class KosyInput extends StatefulWidget {
  final String value;
  final String placeholder;
  final TextInputType? inputType;
  final bool secure;
  final double margin;
  final int lines;
  final IconData? leftIcon;
  final bool? disabled;
  final int? maxLength;
  // _KosyInputState? state;
  final KosyInputOnChangeCallback onChange;
  late final _KosyInputState state;

  FocusNode get focusnode {
    return state.focusNode;
  }

  KosyInput(this.value,
      {Key? key,
      required this.onChange,
      this.inputType,
      this.secure = false,
      required this.placeholder,
      this.maxLength,
      this.margin = 0,
      this.lines = 1,
      this.leftIcon,
      this.disabled})
      : super(key: key) {}

  _KosyInputState createState() {
    state = _KosyInputState(value,
        placeholder: this.placeholder,
        onChange: onChange,
        inputType: inputType ?? TextInputType.text,
        secure: this.secure,
        margin: 10.0);
    return state;
  }

  // void shouldRelinquishFocus() {
  //   state!.shouldRelinquishFocus();
  // }
  TextEditingController get controller => state.controller;
  String getValue() {
    return value;
  }
}

class _KosyInputState extends State<KosyInput> {
  final TextInputType inputType;
  final String placeholder;
  late String value;
  final bool secure;
  late double margin;
  final TextEditingController controller = TextEditingController();
  Color color = TextInputBgColor;
  final FocusNode focusNode = FocusNode();
  final KosyInputOnChangeCallback onChange;
  _KosyInputState(this.value,
      {required this.onChange,
      required this.placeholder,
      required this.inputType,
      required this.secure,
      double? margin}) {
    //  focusNode = FocusNode();
    focusNode.addListener(_focusChangeColor);

    this.margin = margin ?? 0;
  }

  @override
  void initState() {
    super.initState();
    controller.text = value;
  }

  _focusChangeColor() {
    setState(() {
      color = focusNode.hasFocus ? TextInputFocusedBgColor : TextInputBgColor;
    });
  }

  shouldRelinquishFocus() {
    focusNode.unfocus();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.removeListener(_focusChangeColor);
    focusNode.dispose();
    super.dispose();
  }

  String get inputValue {
    return this.value;
  }

  Widget leftIcon() {
    if (widget.leftIcon == null)
      return SizedBox(
        width: 0,
      );
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Icon(
        widget.leftIcon,
        size: 20,
        color: Colors.grey,
      ),
    );
  }

  Widget build(BuildContext context) {
    controller.addListener(() {
      final String text = controller.text.toLowerCase();
      setState(() {
        value = text;
      });
    });

    final width = MediaQuery.of(context).size.width * 0.02;

    return Container(
        //,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        margin:
            EdgeInsets.symmetric(vertical: widget.margin, horizontal: width),
        child: Row(
          children: [
            leftIcon(),
            Expanded(
                child: Card(
                    elevation: 0.0,
                    color: this.color,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: TextField(
                          buildCounter: (BuildContext ctx,
                                  {required int currentLength,
                                  required bool isFocused,
                                  required int? maxLength}) =>
                              SizedBox(),
                          maxLength: widget.maxLength,
                          enabled: widget.disabled == null,
                          maxLines: widget.lines,
                          controller: controller,
                          obscureText: secure,
                          autofocus: false,
                          decoration: InputDecoration.collapsed(
                            hintText: placeholder,
                          ),
                          focusNode: focusNode,
                          keyboardType: inputType,
                          onChanged: (String val) {
                            setState(() {
                              value = val;

                              onChange(val);
                            });
                          },
                        )))),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ));
  }
}
