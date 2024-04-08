import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


class DropDownWidgetAdd extends StatefulWidget {
  final String label;
  final List<ItemDropdown> list;
  final Function onSelect;
  final double whidt;
  final double itemWidht;
  final bool error;
 
  const DropDownWidgetAdd({super.key, 
    required this.label,
    required this.list, 
    required this.onSelect, 
    required this.whidt, 
    this.error = false, 
    required this.itemWidht,
    });

  @override
  State<DropDownWidgetAdd> createState() => _DropDownWidgetAddState();
}

class _DropDownWidgetAddState extends State<DropDownWidgetAdd> {
ItemDropdown? selected;

  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy + button.size.height, position.dx + button.size.width, position.dy + button.size.height * 2),
      items: widget.list.map((item) {
        return PopupMenuItem<ItemDropdown>(
          value: item,
          child: SizedBox(
            width: widget.itemWidht,
          child: Text(item.label, style: TextStyle(color: widget.error ? AppColor.primaryColor : AppColor.white))),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        widget.onSelect(value);
        setState(() {
          selected = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.whidt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selected != null) Text(widget.label, style: TextStyle(color: widget.error ? AppColor.lead : AppColor.white)),
          const SizedBox(height: 5.0),

          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _showMenu(context),
              child: Container(
              height: 50,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: widget.error ? AppColor.primaryColor : AppColor.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selected != null ? selected!.label : 'Estado',
                        style: TextStyle(
                          color: selected != null ? AppColor.lead : AppColor.lead,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: widget.error ? AppColor.primaryColor : AppColor.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}