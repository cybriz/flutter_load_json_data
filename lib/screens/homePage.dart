import 'package:flutter/material.dart';
import 'package:flutter_load_json_from_local/models/model.dart';
import 'package:flutter_load_json_from_local/service/service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AbilityListModel> _ability = List<AbilityListModel>();
  List<AbilityListModel> _abilityForDisplay = List<AbilityListModel>();

  @override
  void initState() {
    Service().fetchNotes().then((value) {
      setState(() {
        _ability.addAll(value);
        _abilityForDisplay = _ability;
      });
    });
    super.initState();
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _abilityForDisplay = _ability.where((note) {
              var noteTitle = note.name.toLowerCase();

              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index, size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
      child: Card(
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage:
                    NetworkImage(_abilityForDisplay[index].logoUrl),
                backgroundColor: Colors.transparent,
              ),
              Container(
                height: size.height * 0.1,
                // color: Colors.orange,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _abilityForDisplay[index].name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.6,
                      // color: Colors.orange,
                      child: Text(
                        _abilityForDisplay[index].description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Load Json Data"),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index == 0 ? _searchBar() : _listItem(index - 1, size);
          },
          itemCount: _abilityForDisplay.length + 1,
        ));
  }
}
