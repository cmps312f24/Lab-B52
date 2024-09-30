import 'package:flutter/material.dart';
import 'package:stadium_app/repo/stadium_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _showSearch = false;
  var repo = StadiumRepo();
  var _stadiums = [];

  @override
  void initState() {
    repo.getStadiums().then((stadiums) => {_stadiums = stadiums});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stadium App'),
        actions: [
          if (!_showSearch)
            IconButton(
                onPressed: () {
                  setState(() {
                    _showSearch = !_showSearch;
                  });
                },
                icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showSearch)
              TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showSearch = !_showSearch;
                          });
                        },
                        icon: const Icon(Icons.close))),
              ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Stadium Name : ${_stadiums[index].name}'),
                  subtitle: const Text('The subtitle part'),
                  trailing: const Icon(Icons.edit),
                  leading: Image.asset(
                      'assets/images/${_stadiums[index].imageName}.jpg'),
                );
              },
              itemCount: _stadiums.length,
            ))
          ],
        ),
      ),
    );
  }
}
