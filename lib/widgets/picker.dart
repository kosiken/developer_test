import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:developer_test/constants/colors.dart';
import 'package:developer_test/widgets/button.dart';
import 'package:developer_test/widgets/typography.dart';

class KosyPicker<T> extends StatefulWidget {
  final T? value;
  final List<T> items;
  final void Function(T selectedVal) onChange;
  final double? height;
  final bool? dismissOnSelect;
  final MainAxisAlignment? mainAxisAlignment;

  const KosyPicker(
      {Key? key,
      required this.items,
      required this.onChange,
      this.mainAxisAlignment,
      this.value,
      this.height,
      this.dismissOnSelect})
      : super(key: key);
  @override
  _KosyPickerState<T> createState() => _KosyPickerState<T>();
}

class _KosyPickerState<T> extends State<KosyPicker<T>>
    with AfterLayoutMixin<KosyPicker<T>> {
  GlobalKey gkey = GlobalKey(debugLabel: "picker");

  double left = 0;
  double top = 0;
  double width = 200.0;

  @override
  late T selected;
  bool openModal = true;
  OverlayEntry? overlayEntry;
  void initState() {
    super.initState();

    setState(() {
      selected = widget.value ?? widget.items[0]!;
    });
  }

  Widget getModal() {
    // var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
            top: top - 20,
            left: left,
            child: Container(
                // width: size.width - 200,
                // height: size.height / 2,
                // constraints: BoxConstraints(maxHeight: 100, maxWidth: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: ShadowColor,
                        offset: Offset(0, 8),
                        spreadRadius: 2,
                        blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                height: widget.height ?? 400,
                width: width,
                child: ListView(
                  children: List.from(widget.items.map((e) => KosyWidgetButton(
                        child: Container(
                          width: 200,
                          child: KosyText(
                            e.toString().toUpperCase(),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 5),
                        ),
                        clickFunc: () {
                          setState(() {
                            selected = e;
                          });
                          widget.onChange(e);
                          var dismiss = widget.dismissOnSelect;
                          if (dismiss != null) {
                            if (dismiss) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          }
                        },
                      ))),
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: gkey,
      // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      // margin: EdgeInsets.symmetric(horizontal: 10),

      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: KosyWidgetButton(
          padding: false,
          child: Row(
            children: [
              KosyText(
                widget.value.toString(),
                color: TextEmphasisColor,
                bold: true,
              ),
              Icon(Icons.arrow_drop_down)
            ],
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          clickFunc: () {
            // if (overlayEntry == null) {
            //   overlayEntry = OverlayEntry(
            //       builder: (BuildContext context) {
            //         return getModal();
            //       },
            //       opaque: true);
            // }

            showDialog(
                useRootNavigator: true,
                barrierColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return getModal();
                });

            // Overlay.of(context)!.insert(overlayEntry!);
          },
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    RenderBox box = gkey.currentContext!.findRenderObject()! as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    top = position.dy + box.size.height - 40;
    // if(top > 300) {}
    width = box.size.width - 20;
    left = position.dx + 10;
  }
}
