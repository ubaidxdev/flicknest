import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class ThemedSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const ThemedSearchBar({super.key, this.onChanged, this.hintText = 'Search'});

  @override
  State<ThemedSearchBar> createState() => _ThemedSearchBarState();
}

class _ThemedSearchBarState extends State<ThemedSearchBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      focusNode: _focusNode,
      hintText: widget.hintText,
      textInputAction: TextInputAction.search,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.9,
        minWidth: MediaQuery.sizeOf(context).width * 0.9,
        maxHeight: MediaQuery.sizeOf(context).width * 0.11,
        minHeight: MediaQuery.sizeOf(context).width * 0.11,
      ),
      side: WidgetStatePropertyAll(
        BorderSide(color: _focusNode.hasFocus ? AppColors.secondaryColor : AppColors.primaryColor),
      ),
      backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: _focusNode.hasFocus ? AppColors.secondaryColor : Colors.white,
          fontSize: 16,
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: _focusNode.hasFocus ? AppColors.secondaryColor : Colors.white,
          fontSize: 16,
        ),
      ),

      leading: Icon(
        Icons.search,
        color: _focusNode.hasFocus ? AppColors.secondaryColor : Colors.white,
      ),
      onChanged: widget.onChanged,
    );
  }
}
