import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/competition_model.dart';
import '../view_models/home_view_model.dart';

class CompetitionAddScreen extends StatefulWidget {
  const CompetitionAddScreen({Key? key}) : super(key: key);

  @override
  State<CompetitionAddScreen> createState() => _CompetitionAddScreenState();
}

class _CompetitionAddScreenState extends State<CompetitionAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleInputController = TextEditingController();
  final _categoryInputController = TextEditingController();
  final _descriptionInputController = TextEditingController();
  final _firstPlacePrizeInputController = TextEditingController();

  late HomeViewModel _homeViewModel;
  int maxPoints = 0;
  DateTime submissionDeadline = DateTime.now();
  int judgeId = 0;
  bool isFinished = false;

  @override
  void initState() {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
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
        initialDate: submissionDeadline,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != submissionDeadline) {
      setState(() {
        submissionDeadline = picked;
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
                    setState(() {
                      maxPoints = value.toInt();
                    });
                  },
                  max: 100,
                  value: maxPoints.toDouble(),
                ),
                Text(
                    "Selected date: ${DateFormat.yMd().format(submissionDeadline)}"),
                TextButton(
                  onPressed: () =>
                      _selectDate(context),
                  child: const Text('Select date'),
                ),
                OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var newComp = Competition.all(
                            judgeId: judgeId,
                            title: _titleInputController.text,
                            category: _categoryInputController.text,
                            maxPoints: maxPoints,
                            firstPlacePrize: _firstPlacePrizeInputController.text,
                            description: _descriptionInputController.text,
                            submissionDeadline: submissionDeadline,
                            isFinished: isFinished
                        );
                        _homeViewModel.add(newComp);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Create")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
