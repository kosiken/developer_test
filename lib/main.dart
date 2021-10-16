import 'package:developer_test/controllers/json-placeholder-api.dart';
import 'package:developer_test/models/json-placeholder-response.dart';
import 'package:developer_test/screens/add-todo-screen.dart';
import 'package:developer_test/screens/edit-todo-screen.dart';
import 'package:developer_test/screens/json-placeholder-consumer.dart';
import 'package:developer_test/screens/todo-screen.dart';
import 'package:developer_test/screens/user-view-screen.dart';
import 'package:developer_test/screens/users-view-screen.dart';
import 'package:developer_test/screens/view-describeable.dart';
import 'package:developer_test/screens/view-jsonplaceholder-todo-screen.dart';
import 'package:developer_test/screens/view-todo-screen.dart';
import 'package:developer_test/state/state.dart';
import 'package:developer_test/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'debug.dart';
import 'models/todo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: _routes(),
        title: "Todoapp",
        theme: ThemeData(
            // appBarTheme: AppBarTheme(
            //   textTheme: TextTheme(title: AppBarTextStyle),
            ),
        initialRoute: "/",
        routes: {
          "/": (ctx) => TodoScreen(),
          "/add-todo": (ctx) => AddTodoScreen(),
          "/json-placeholder": (ctx) => JsonPlaceHolderScreen(),
          "/users": (ctx) => UsersViewScreen<JsonPlaceholderApiUser>(
                pathTogo: "/view-user",
                controller: JsonPlaceholderController<JsonPlaceholderApiUser>(
                    JsonPlaceholderApiUser.fromJSON, "/users"),
              ),
          "/todos": (ctx) => UsersViewScreen(
                pathTogo: "/view-jsph-todo",
                controller: JsonPlaceholderController<JsonPlaceholderApiTodo>(
                    JsonPlaceholderApiTodo.fromJSON, "/todos"),
              ),
          "/posts": (ctx) => UsersViewScreen(
                pathTogo: "/view-post",
                controller: JsonPlaceholderController<JsonPlaceholderApiPost>(
                    JsonPlaceholderApiPost.fromJSON, "/posts"),
              ),
          "/albums": (ctx) => UsersViewScreen(
                pathTogo: "/view-album",
                controller: JsonPlaceholderController<JsonPlaceholderApiAlbum>(
                    JsonPlaceholderApiAlbum.fromJSON, "/albums"),
              ),
          "/comments": (ctx) => UsersViewScreen(
                pathTogo: "/view-comment",
                controller:
                    JsonPlaceholderController<JsonPlaceholderApiComment>(
                        JsonPlaceholderApiComment.fromJSON, "/comments"),
              ),
          "/photos": (ctx) => UsersViewScreen(
                pathTogo: "/view-photo",
                controller: JsonPlaceholderController<JsonPlaceholderApiPhoto>(
                    JsonPlaceholderApiPhoto.fromJSON, "/photos"),
              ),
        });
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen = TodoScreen();
      switch (settings.name) {
        case "/view-todo":
          int todoId = settings.arguments! as int;
          screen = ViewTodoScreen(todoId: todoId);
          break;

        case "/edit-todo":
          Todo todo = settings.arguments! as Todo;
          screen = EditTodoScreen(todo: todo);
          break;

        case "/view-user":
          JsonPlaceholderApiUser user =
              settings.arguments! as JsonPlaceholderApiUser;
          screen = UserViewScreen(user: user);
          break;

        case "/view-jsph-todo":
          JsonPlaceholderApiTodo todo =
              settings.arguments! as JsonPlaceholderApiTodo;
          screen = ViewJPLHTodoScreen(todo: todo);
          break;
        case "/view-post":
          JsonPlaceholderApiPost object =
              settings.arguments! as JsonPlaceholderApiPost;
          screen = ViewDescribeableScreen<JsonPlaceholderApiPost>(
            object: object,
          );
          break;

        case "/view-comment":
          JsonPlaceholderApiComment object =
              settings.arguments! as JsonPlaceholderApiComment;
          screen = ViewDescribeableScreen<JsonPlaceholderApiComment>(
            object: object,
          );
          break;
        case "/view-album":
          JsonPlaceholderApiAlbum object =
              settings.arguments! as JsonPlaceholderApiAlbum;
          screen = ViewDescribeableScreen<JsonPlaceholderApiAlbum>(
            object: object,
          );
          break;

        case "/view-photo":
          JsonPlaceholderApiPhoto object =
              settings.arguments! as JsonPlaceholderApiPhoto;
          screen = ViewDescribeableScreen<JsonPlaceholderApiPhoto>(
            object: object,
          );
          break;
        default:
          Debug.log("Not supposed to reach here");
          break;
      }

      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            KosyInput("", onChange: (t) {}, placeholder: "Hello")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
