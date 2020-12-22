import 'package:flutter/material.dart';
import 'package:timeplanner_mobile/constants/color.dart';

class TimetableTabs extends StatefulWidget {
  final int index;
  final int length;
  final bool isExamTime;
  final Function(int) onTap;
  final VoidCallback onAddTap;
  final VoidCallback onExamTap;
  final VoidCallback onSettingsTap;

  TimetableTabs(
      {this.index = 0,
      @required this.length,
      this.isExamTime = false,
      @required this.onTap,
      @required this.onExamTap,
      @required this.onAddTap,
      @required this.onSettingsTap});

  @override
  _TimetableTabsState createState() => _TimetableTabsState();
}

class _TimetableTabsState extends State<TimetableTabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    _index = widget.index;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  widget.length + 1, (i) => _buildTab(i, context)),
            ),
          ),
        ),
        _buildButton(Icons.add, widget.onAddTap),
        _buildButton(widget.isExamTime ? Icons.tablet : Icons.assignment,
            widget.onExamTap),
        _buildButton(Icons.settings, widget.onSettingsTap),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(4.0),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.0,
            ),
            child: Icon(
              icon,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int i, BuildContext context) {
    return Card(
      color: _index == i ? Colors.white : TAB_COLOR,
      margin: const EdgeInsets.only(left: 4.0, right: 6.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
          onTap: _index == i
              ? null
              : () {
                  setState(() {
                    _index = i;
                    widget.onTap(i);
                  });
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 9.0,
            ),
            child: Text(
              i == widget.length ? "+" : "시간표 ${i + 1}",
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ),
    );
  }
}
