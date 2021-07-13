import 'package:flutter/material.dart';
import 'package:flutter_task/Widgets/NewsCard.dart';
import 'package:provider/provider.dart';

import 'package:flutter_task/Provider/News.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsFeed;
  var id = '';
  int _selectedIndex = 0;

  var fav = [];
  late Future<String> _future;
  @override
  void initState() {
    // TODO: implement initState
    _future = _fetchData();

    super.initState();
  }

  Future<String> _fetchData() async {
    try {
      final provider = Provider.of<News>(context, listen: false);
      // if (widget.fetch) {
      var news = await provider.getNews();

      setState(() {
        newsFeed = news;
      });
      return 'Done';
    } catch (err) {
      return 'Error';
    }
  }

  String addFav(int id) {
    if (fav.contains(id)) {
      setState(() {
        fav.remove(id);
      });
    } else {
      setState(() {
        fav.add(id);
      });

    }

    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.data == 'Done') return HomeScreenWid(false);
          return HomeScreenWid(true);
        });
  }

  // ignore: non_constant_identifier_names
  Widget HomeScreenWid(bool _isLoading) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          color: Color(0xffEEEEEE),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color:
                      (_selectedIndex == 0) ? Color(0xff234193) : Colors.white,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width * .48,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.list,
                          color: (_selectedIndex != 0)
                              ? Colors.black
                              : Colors.white,
                          size: MediaQuery.of(context).size.width * .08,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        Text(
                          'News',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: (_selectedIndex != 0)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color:
                      (_selectedIndex == 0) ? Colors.white : Color(0xff234193),
                ),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: (_selectedIndex == 0)
                              ? Color(0xffFF5751)
                              : Colors.white,
                          size: MediaQuery.of(context).size.width * .08,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .02,
                        ),
                        Text(
                          'Favs',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: (_selectedIndex == 0)
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff234193),
                  ),
                ),
              if (!_isLoading)
                Flexible(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: newsFeed.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_selectedIndex == 1 &&
                            fav.contains(newsFeed[index]['id']))
                          return NewsCard(newsFeed[index], addFav, true);
                        if (_selectedIndex == 0 &&
                            !fav.contains(newsFeed[index]['id'])) {
                          return NewsCard(newsFeed[index], addFav, false);
                        }
                        return Container();
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
