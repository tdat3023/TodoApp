import 'package:flutter/material.dart';

import 'completed.dart';
import 'duesoon.dart';
import 'today.dart';
import 'upcoming.dart';

class AllTasksBody extends StatefulWidget {
  const AllTasksBody({super.key});
  @override
  State<AllTasksBody> createState() => _AllTasksBodyState();
}

class _AllTasksBodyState extends State<AllTasksBody> {
  final List<String> categories = [
    'Today',
    'Upcoming',
    'DueSoon',
    'Completed',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          titleSpacing: 0.0,
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(20.0, 0.0, 0.0),
            child: const Text(
              "My Task",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          bottom: const TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'DueSoon',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Today(),
            Upcoming(),
            DueSoon(),
            Completed(),
          ],
        ),
      ),
    );
  }
}
        // Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   centerTitle: false,
        //   titleSpacing: 0.0,
        //   title: Transform(
        //     // you can forcefully translate values left side using Transform
        //     transform: Matrix4.translationValues(20.0, 0.0, 0.0),
        //     child: const Text(
        //       "My Task",
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        //  bottom: TabBar(
        //     controller: _tabController,
        //     tabs: <Widget>[
        //       Expanded(
        //         child: Container(
        //           padding: const EdgeInsets.all(10),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: const [
        //               Text(
        //                 'Today',
        //                 style: TextStyle(
        //                   fontSize: 13,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //               Text('Upcoming',
        //                   style: TextStyle(
        //                     fontSize: 13,
        //                     color: Colors.black,
        //                    )),
        //               Text('DueSoon',
        //                   style: TextStyle(
        //                     fontSize: 13,
        //                     color: Colors.black,
        //                   )),
        //               Text('Completed',
        //                   style: TextStyle(
        //                     fontSize: 13,
        //                     color: Colors.black,
        //                   )),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const Text(''),
        //       const Text(''),
        //       const Text(''),
        //     ],
        //   ),
        // ),
        //   body: Container(
        //     padding: const EdgeInsets.only(left: 20, right: 20),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             TextButton(
        //                 style: TextButton.styleFrom(
        //                   foregroundColor: Colors.white,
        //                   textStyle: const TextStyle(fontSize: 20),
        //                 ),
        //                 onPressed: () {},
        //                 child: const Text('Today',
        //                     style: TextStyle(color: Colors.black, fontSize: 15))),
        //             const Text('Today',
        //                 style: TextStyle(color: Colors.black, fontSize: 15)),
        //             const SizedBox(width: 10),
        //             const Text('Upcoming',
        //                 style: TextStyle(color: Colors.black, fontSize: 15)),
        //             const SizedBox(width: 10),
        //             const Text('DueSoon',
        //                 style: TextStyle(color: Colors.black, fontSize: 15)),
        //             const SizedBox(width: 10),
        //             const Text('Completed',
        //                 style: TextStyle(color: Colors.black, fontSize: 15)),
        //           ],
        //         ),
        //         Container(),
        //       ],
        //     ),
        //   ),
        // );


