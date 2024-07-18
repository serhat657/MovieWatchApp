import 'package:flutter/material.dart';

final TextStyle menuFonStyle = TextStyle(color: Colors.white, fontSize: 20);

class MenuDashBoard extends StatefulWidget {
  const MenuDashBoard({super.key});

  @override
  State<MenuDashBoard> createState() => _MenuDashBoardState();
}

class _MenuDashBoardState extends State<MenuDashBoard> with SingleTickerProviderStateMixin {

  late double screenHeight, screenWidth;
  bool isMenuOpen = false;
  late AnimationController _controller;
  late Animation<double> _scaleanimation;
  late Animation<double> _scaleMenuAnimation;
  late Animation<Offset> _menuoffsetAnimation;
  final Duration _duration = Duration(microseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleanimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuoffsetAnimation = Tween(begin: const Offset(-1,0), end: const Offset(0,0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 62, 62),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            create_menu(context),
            create_dashboard(context),
          ],
        ),
      )
    );
  }

  Widget create_menu(BuildContext context) {
    return SlideTransition(
      position: _menuoffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  TextButton.icon(
                    onPressed: null, 
                    icon: Icon(Icons.person, color: Colors.blue),
                    label: Text("MyProfile", style: menuFonStyle.copyWith(color: Colors.blue)),
                  ),
                  TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.message, color: Colors.green),
                    label: Text("Messages", style: menuFonStyle.copyWith(color: Colors.green)),
                  ),
                  TextButton.icon(
                    onPressed: null, 
                    icon: Icon(Icons.favorite, color: Colors.red),
                    label: Text("Favorites", style: menuFonStyle.copyWith(color: Colors.red)),
                  ),
                  TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.watch_later, color: Colors.orange),
                    label: Text("WatchList", style: menuFonStyle.copyWith(color: Colors.orange)),
                  ),
                  TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.settings, color: Colors.grey),
                    label: Text("Settings", style: menuFonStyle.copyWith(color: Colors.grey)),
                  ),                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget create_dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top:  0,
      bottom: 0,
      left: isMenuOpen ? 0.6 * screenWidth : 0,
      right: isMenuOpen ? -0.4 * screenWidth : 0,
      child: ScaleTransition(
        scale: _scaleanimation,
        child: Material(
          borderRadius: isMenuOpen ? BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: Color.fromARGB(255, 93, 88, 88),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if(isMenuOpen){
                              _controller.reverse();
                            }else{
                              _controller.forward();
                            }
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                        child: Icon(Icons.menu, color: Colors.white),
                      ),
                      Text("Stranger Things", style: TextStyle(color: Colors.white, fontSize: 24)),
                      Icon(Icons.hd_sharp, color: Colors.white),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal, 
                      children: <Widget>[
                        Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Image.network(
                            "https://l24.im/hpXS5c"
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Image.network(
                            "https://l24.im/sapq3"
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Image.network(
                            "https://l24.im/lRB1Pb"
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.0,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                    return ListTile(
                      leading: Icon(
                        Icons.movie_filter,
                        color: Colors.red.shade300,
                      ),
                      title: Text(
                        "Episode ${index+ 1}",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.add_to_queue_outlined,
                        color: Colors.blue.shade100
                      ),
                    );
                  }, separatorBuilder: (context, index){
                    return const Divider();
                  }, itemCount: (20))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

