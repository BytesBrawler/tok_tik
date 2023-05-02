import 'package:flutter/material.dart';
import 'package:tok_tik/utils/constants.dart';
import 'package:tok_tik/view/widgets/customAddIcon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  int pageidx=0;
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap:(index){
          setState(() {
            pageidx = index;
          });
        } ,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        currentIndex: pageidx,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home ,size: 25),
          label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search ,size: 25),
              label:'search'),
          BottomNavigationBarItem(icon: CustomAddIcon(),
              label:''),
          BottomNavigationBarItem(icon: Icon(Icons.message ,size: 25),
              label:'message'),
          BottomNavigationBarItem(icon: Icon(Icons.person ,size: 25),
              label:'profile'),

        ],

      ),
      body: pageindex[pageidx] ,
    );
  }
}
