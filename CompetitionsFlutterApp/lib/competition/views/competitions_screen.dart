import 'package:flutter/material.dart';
import 'package:fluttercrud/competition/view_models/home_view_model.dart';
import 'package:fluttercrud/competition/views/competitions_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _homeViewModel.fetchData();
      } on Exception catch(_) {
        showSnackBar(context, "Something went wrong");
      }
    });
    super.initState();
  }

  showSnackBar(BuildContext context, String text)
  {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 5),//default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAlertDialog(BuildContext context, VoidCallback onRemove) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () { Navigator.of(context).pop(); },
    );
    Widget continueButton = TextButton(
      child: const Text("Remove"),
      onPressed:  () {
        onRemove();
        Navigator.of(context).pop();
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Removing competition"),
      content: const Text("Are you sure you want to remove "
          "the selected competition?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/competitions/add");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "My Competitions",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<HomeViewModel>(builder: (_, model, child) {
                return CompetitionsList(model.competitions, (id) {
                  Navigator.pushNamed(context, "/competitions/edit",
                      arguments: id);
                }, (id) {
                  showAlertDialog(context, () {
                    if (id != null) {
                      _homeViewModel.delete(id);
                    }
                  });
                });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
