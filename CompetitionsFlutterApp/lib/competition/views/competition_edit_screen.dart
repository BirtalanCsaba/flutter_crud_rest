import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercrud/competition/models/competition_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_models/home_view_model.dart';

class CompetitionEditScreen extends StatefulWidget {
  const CompetitionEditScreen({Key? key}) : super(key: key);

  @override
  State<CompetitionEditScreen> createState() => _CompetitionEditScreenState();
}

class _CompetitionEditScreenState extends State<CompetitionEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleInputController = TextEditingController();
  final _categoryInputController = TextEditingController();
  final _descriptionInputController = TextEditingController();
  final _firstPlacePrizeInputController = TextEditingController();

  late HomeViewModel _homeViewModel;
  Competition _competition = Competition();

  int maxPoints = 0;

  @override
  void initState() {
    _competition = Competition();
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final id = ModalRoute.of(context)!.settings.arguments as int?;
      if (mounted) {
        var competition = await _homeViewModel.findById(id);
        setState(() {
          _competition = competition;
          _titleInputController.value = TextEditingValue(text: _competition.title);
          _categoryInputController.value =
              TextEditingValue(text: _competition.category);
          _descriptionInputController.value =
              TextEditingValue(text: _competition.description);
          _firstPlacePrizeInputController.value =
              TextEditingValue(text: _competition.firstPlacePrize);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    _categoryInputController.dispose();
    _descriptionInputController.dispose();
    _firstPlacePrizeInputController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _competition.submissionDeadline,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _competition.submissionDeadline) {
      setState(() {
        _competition.submissionDeadline = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Create new competition",
                  style: TextStyle(fontSize: 30),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title required";
                    }
                    return null;
                  },
                  controller: _titleInputController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Category required";
                    }
                    return null;
                  },
                  controller: _categoryInputController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description required";
                    }
                    return null;
                  },
                  controller: _descriptionInputController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First place prize',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "First place prize required";
                    }
                    return null;
                  },
                  controller: _firstPlacePrizeInputController,
                ),
                Slider(
                  label: "Max points",
                  onChanged: (double value) {
                    _competition.maxPoints = value.toInt();
                    setState(() {
                      _competition.maxPoints = value.toInt();
                    });
                  },
                  max: 100,
                  value: _competition.maxPoints.toDouble(),
                ),
                Text(
                    "Selected date: ${DateFormat.yMd().format(_competition.submissionDeadline)}"),
                TextButton(
                  onPressed: () =>
                      _selectDate(context),
                  child: const Text('Select date'),
                ),
                OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var newComp = Competition.all(
                            judgeId: _competition.judgeId,
                            title: _titleInputController.text,
                            category: _categoryInputController.text,
                            maxPoints: _competition.maxPoints,
                            firstPlacePrize: _firstPlacePrizeInputController.text,
                            description: _descriptionInputController.text,
                            submissionDeadline: _competition.submissionDeadline,
                            isFinished: _competition.isFinished
                        );
                        newComp.id = _competition.id;
                        _homeViewModel.update(newComp);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Modify")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
