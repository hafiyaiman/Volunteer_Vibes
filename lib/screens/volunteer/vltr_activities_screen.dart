import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    String _formatTimestamp(Timestamp timestamp) {
      DateTime date = timestamp.toDate();
      return DateFormat('dd-MM-yyyy')
          .format(date); // Change the format as needed
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Iconsax.search_normal_14, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ActivitySearch(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'By Organization'),
            Tab(text: 'Emergency Response'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // By Organization Tab Content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('activities')
                .doc('PI8A2mCR56iMUYKvlBp5')
                .collection('by_organizations')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text(data['title']),
                        subtitle: Text(
                            'Organizer: ${data['organizationName']}\nDetails: ${data['description']}\nDate: ${_formatTimestamp(data['start_date'])} to ${_formatTimestamp(data['end_date'])}\nTime: ${data['start_time']} to ${data['end_time']}\nLocation: ${data['street']}, ${data['city']}, ${data['country']}'),
                        onTap: () {},
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),

          // Emergency Response Tab Content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('activities')
                .doc('PI8A2mCR56iMUYKvlBp5')
                .collection('emergency_response')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title: Text(data['title']),
                        subtitle: Text(
                            'Organizer: ${data['organizationName']}\nDetails: ${data['description']}\nDate: ${_formatTimestamp(data['start_date'])} to ${_formatTimestamp(data['end_date'])}\nTime: ${data['start_time']} to ${data['end_time']}\nLocation: ${data['street']}, ${data['city']}, ${data['country']}'),
                        onTap: () {},
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ActivitySearch extends SearchDelegate<String> {
  ActivitySearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('activities').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final results =
            snapshot.data!.docs.where((doc) => doc['title'].contains(query));

        return ListView(
          children: results.map<Widget>((doc) {
            return Card(
              child: ListTile(
                title: Text(doc['title']),
                onTap: () {
                  close(context, doc['title']);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('activities').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final results =
            snapshot.data!.docs.where((doc) => doc['title'].contains(query));

        return ListView(
          children: results.map<Widget>((doc) {
            return Card(
              child: ListTile(
                title: Text(doc['title']),
                onTap: () {
                  query = doc['title'];
                  showResults(context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
