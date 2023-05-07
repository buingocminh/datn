import 'package:datn/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  List<int> _listPlaceId = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10) ,
          child: SingleChildScrollView(
            child: Column(
              children: [
        
                ExpansionTile(
                  title: const Text(
                    "Lọc theo chủ đề",
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  tilePadding: EdgeInsets.zero,
                  children: [
                    ...context.read<AppState>().listPlaceType.map(
                      (e) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _listPlaceId.contains(e['id']), 
                        selected: _listPlaceId.contains(e['id']),
                        onChanged: (value) {
                          if(value == true && !_listPlaceId.contains(e['id'])) {
                            _listPlaceId.add(e['id']);
                          }
                          if(!(value ?? false)) {
                            _listPlaceId.remove(e["id"]);
                          }
                          setState(() {});
                        },
                        title: Text(
                          e['name'],
                          style: const TextStyle(
                            color: Colors.black
                          ),
                        ),
                      )
                    ).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _listPlaceId.clear();
                            });
                          }, 
                          child: Text("Bỏ chọn")
                        ),
                        const SizedBox(width: 10,),
                        ElevatedButton(
                          onPressed: () {}, 
                          child: Text("Lưu")
                        )
                      ],
                    )
                  ],
                ),
        
                DrawerButton(
                    const Icon(
                      Icons.logout,
                      size: 15,
                      color: Colors.black,
                    ), 
                    "Đăng nhập", 
                    () async {
                    }
                  ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final Widget icon;
  final String content;
  final VoidCallback callback;
  const DrawerButton(
    this.icon,
    this.content,
    this.callback,
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => callback(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 0, 15),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: icon,
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  content,
                  style: TextStyle(                  
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }
}
