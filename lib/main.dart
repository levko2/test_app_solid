import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_app_solid/reducer/app_reducer.dart';

import 'action/color_generator.dart';
import 'models/app_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData.light(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solid test"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Container(
          color: viewModel.bgColor,
          child: Center(
            child: BgGeneratorButton(viewModel),
          ),
        ),
      ),
    );
  }
}


class BgGeneratorButton extends StatelessWidget {
  final _ViewModel model;

  BgGeneratorButton(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Generate color"),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () => model.onGenerateBgColor(Colors.white),
    );
  }
}

class _ViewModel {
  final Color bgColor;
  final Function(Color) onGenerateBgColor;

  _ViewModel(
    this.bgColor,
    this.onGenerateBgColor,
  );

  factory _ViewModel.create(Store<AppState> store) {
    _onGenerateBgColor(Color body) {
      store.dispatch(ColorGenerationAction(body));
    }

    return _ViewModel(
      store.state.bgColor,
      _onGenerateBgColor,
    );
  }
}
