import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final data;
  final addFav;
  final isFav;

  NewsCard(this.data, this.addFav, this.isFav);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .15,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .2,
                child: IconButton(
                  onPressed: () {
                    widget.addFav(widget.data['id']);
                  },
                  icon: Icon(
                    widget.isFav ? Icons.favorite : Icons.favorite_border,
                    color: widget.isFav ? Color(0xffFF5751) : null,
                    size: MediaQuery.of(context).size.width * .1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.data['title'] != null)
                      Text(
                        widget.data['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    if (widget.data['summary'] != null)
                      Text(
                        widget.data['summary'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (widget.data['published'] != null)
                      Text(
                        widget.data['published'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
