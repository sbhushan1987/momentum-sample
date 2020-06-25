import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

void main() {
  runApp(Momentum(
    child: MyApp(),
    controllers: [HomePageController()],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Momentum Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Momentum Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            MomentumBuilder(
              controllers: [HomePageController],
              builder: (context, snapshot) {
                int count = snapshot<HomePageModel>().count;
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            Momentum.controller<HomePageController>(context).incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomePageController extends MomentumController<HomePageModel> {
  HomePageModel model;
  @override
  HomePageModel init() {
    model = HomePageModel(
      this,
    );

    return model;
  }

  void incrementCounter() {
    var newValue = model.count + 1;
    model.update(newcount: newValue); // update widgets
  }
}

class HomePageModel extends MomentumModel<HomePageController> {
  final int count;
  HomePageModel(HomePageController controller, {this.count})
      : super(controller);

  @override
  void update({int newcount}) {
    HomePageModel(controller, count: newcount).updateMomentum();
  }
}
