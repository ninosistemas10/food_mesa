import 'package:dashboard_bloc/app/presentation/categoria/widget/dropdown_item.dart';
import 'package:dashboard_bloc/app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class DropDownWidgetEdit extends StatefulWidget {
  final String label;
  final List<ItemDropdown> list;
  final Function onSelect;
  final double whidt;
  final double itemWidth;
  final bool error;
  final String? defaultValue;

  const DropDownWidgetEdit({
    Key? key,
    required this.label,
    required this.list,
    required this.onSelect,
    required this.whidt,
    required this.itemWidth,
    this.error = false,
    this.defaultValue,
  });

  @override
  State<DropDownWidgetEdit> createState() => _DropDownWidgetEditState();
}

class _DropDownWidgetEditState extends State<DropDownWidgetEdit> {
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
            width: widget.itemWidth,
            child: Text(item.label, style: TextStyle(color: widget.error ? AppColor.primaryColor : AppColor.white)),
          ),
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
  void initState() {
    super.initState();
    // Establecer el valor predeterminado si defaultValue no está definido
    selected = widget.list.firstWhereOrNull((item) => item.value == widget.defaultValue) ?? widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.whidt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selected != null)
            Text(
              widget.label,
              style: TextStyle(color: widget.error ? AppColor.primaryColor : AppColor.white),
            ),

          const SizedBox(height: 5),
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
                        selected != null ? (selected!.value == 'Activo' ? 'Activo' : 'Inactivo') : 'Seleccionar Estado',
                        style: TextStyle(color: selected != null ? AppColor.white : Colors.grey[800]),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: widget.error ? AppColor.primaryColor : AppColor.white),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
