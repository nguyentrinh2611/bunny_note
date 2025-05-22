import 'package:flutter/material.dart';
import '../widgets/bubble_bottom_bar.dart';
import '../../../number_trivia/presentation/pages/number_trivia_page.dart';

import '../../../../app/presentation/widgets/screen.dart';
import '../../../tasks/presentation/pages/create_new_task_page.dart';
import '../../../tasks/presentation/widgets/task_list.dart';
import '../widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController(initialPage: 1);
  int? currentIndex = 0;

  void navigateToCreateNewTaskPage(BuildContext context) {
    Navigator.of(context).pushNamed(
      CreateNewTaskPage.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(builder: (context) {
      return Scaffold(
        drawer: const HomeDrawer(),
        appBar: _buildAppBar(currentIndex!),
        body: _buildBody(currentIndex!),
        floatingActionButton:
            _buildFloatingActionButton(context, currentIndex!),
        bottomNavigationBar: BubbleBottomBar(
          hasNotch: true,
          fabLocation: BubbleBottomBarFabLocation.end,
          opacity: .2,
          currentIndex: currentIndex,
          onTap: (int? index) {
            setState(() {
              currentIndex = index;
            });
          },
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          elevation: 8,
          tilesPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          items: const <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              showBadge: true,
              //badge: Text("1"),
              badgeColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home"),
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.deepPurple,
                ),
                title: Text("T Tasks")),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                ),
                title: Text("Number trivia")),
          ],
        ),
      );
    });
  }

  FloatingActionButton? _buildFloatingActionButton(
      BuildContext context, int currentIndex) {
    switch (currentIndex) {
      case 1:
        return FloatingActionButton(
          onPressed: () async {
            navigateToCreateNewTaskPage(context);
          },
          child: const Icon(Icons.create),
        );

      default:
        return FloatingActionButton(
          onPressed: () async {},
          child: const Icon(Icons.create),
        );
    }
  }

  AppBar _buildAppBar(int currentIndex) {
    late final Text text;
    switch (currentIndex) {
      case 0:
        text = const Text("Home");
        break;
      case 1:
        text = const Text("Today Tasks");
        break;
      default:
        text = const Text("Number trivia");
        break;
    }
    return AppBar(
      title: text,
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 1:
        return const TaskList();
      case 2:
        return const NumberTriviaPage();
      default:
        return const Scaffold(
          body: Center(
            child: Text(
              "Tính năng đang trong quá trìh phát triển",
            ),
          ),
        );
    }
  }
}
