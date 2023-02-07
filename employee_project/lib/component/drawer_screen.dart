import 'package:flutter/material.dart';
import '../const/operationNameLists.dart';

typedef onRegiontap = void Function(String region);

class DrawerScreen extends StatelessWidget {
  final onRegiontap onRegionTap;
  final String selectedRegion;

  DrawerScreen({
    Key? key,
    required this.onRegionTap,
    required this.selectedRegion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              '기기 종류',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ...operationNameLists
              .map((e) => ListTile(
                  tileColor: Colors.white,
                  // 선택이 된 상태에서의 타일 색상
                  selectedTileColor: Colors.teal,
                  // 선택이 된 상태에서의 글자 색상
                  selectedColor: Colors.white,
                  // 선택된 상태 조절 (선택된 색상 변경 유무)
                  selected: e == selectedRegion,
                  onTap: () {
                    onRegionTap(e);
                  },
                  title: Text(e)))
              .toList(),
        ],
      ),
    );
  }
}
