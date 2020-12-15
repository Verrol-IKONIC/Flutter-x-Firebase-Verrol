part of 'pages.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    AddPage(),
    DataPage(),
    AccountPage()
  ];

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), title: Text('Add Data')),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Text('List Data')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('My Account')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lime[600],
        onTap: _onItemtapped,
      ),
    );
  }
}
