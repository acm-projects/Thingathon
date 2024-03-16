import 'package:flutter/material.dart';
import 'package:thingathon/components/bottom_navbar.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BufferWidget(),
      bottomNavigationBar: NavBar(),
    );
  }
}

class BufferWidget extends StatefulWidget {
  const BufferWidget({super.key});

  @override
  State<BufferWidget> createState() => _BufferWidgetState();
}

class _BufferWidgetState extends State<BufferWidget>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: _pageViewController,
        children: [],
      ),
    );
  }
}
