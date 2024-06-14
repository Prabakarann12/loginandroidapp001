import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SearchPage.dart';
import 'FindPageUni.dart';
import 'Drawerpageuni.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePageUni extends StatefulWidget {
  final int userId;

  const HomePageUni({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageUniState createState() => _HomePageUniState();
}

class _HomePageUniState extends State<HomePageUni> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  get userIdProfile => userIdProfile;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 4) { // Account button index
        _scaffoldKey.currentState?.openDrawer();
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindUniPage()),
        );
      } else if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePageUni(userId: widget.userId)),
        );
      }
    });
  }
  void _navigateToListView(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const NetworkPage();
        break;
      case 1:
        page = const ConcultantsPage();
        break;
      case 2:
        page = const AlumniPage();
        break;
      case 3:
        page = const SchoolPage();
        break;
      case 4:
        page = const CollegePage();
        break;
      default:
        page = const NetworkPage(); // Default page
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }


  Future<Map<String, dynamic>> fetchUserData(int id) async {
    final response = await http.get(Uri.parse(
        'https://syfer001testing.000webhostapp.com/cloneapi/showdataflutter02.php?id=$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Explore",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userData = snapshot.data!;
            final imageUrl = 'https://syfer001testing.000webhostapp.com/cloneapi/' +
                userData['file_path'];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "Discover programs",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: 2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // List of images or different content for each card
                                List<Map<String, dynamic>> cardContent = [
                                  {
                                    'image': 'https://syfer001testing.000webhostapp.com/cloneapi/savefile/homepgdp1.jpg',
                                    'title': 'School',
                                    'description': 'Description 1',
                                    'checklist': 'Check 1',
                                    'icon1': Icons.checklist,
                                    'icon1Text': 'Checklist 1',
                                    'icon2': Icons.star,
                                    'icon2Text': 'Top',
                                  },
                                  {
                                    'image': 'https://syfer001testing.000webhostapp.com/cloneapi/savefile/homepgdp2.jpg',
                                    'title': 'Documents',
                                    'description': 'Description 2',
                                    'checklist': 'Check 2',
                                    'icon1': Icons.picture_as_pdf,
                                    'icon1Text': 'PDF',
                                    'icon2': Icons.description,
                                    'icon2Text': 'Docs',
                                  },
                                ];

                                return Container(
                                  height: 230,
                                  width: 260,
                                  margin: EdgeInsets.all(19.5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15.0),
                                            child: Image.network(
                                              cardContent[index]['image']!,
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 55,
                                            left: 0,
                                            right: 110,
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    // Add your specific logic for each card here
                                                    switch (index) {
                                                      case 0:
                                                        print('Card 1 clicked');
                                                        break;
                                                      case 1:
                                                        print('Card 2 clicked');
                                                        break;
                                                    }
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                    side: BorderSide(color: Colors.black, width: 2),
                                                  ),
                                                  child: Text(
                                                    cardContent[index]['title']!,
                                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 10,
                                            child: Row(
                                              children: [
                                                Icon(cardContent[index]['icon1'], color: Colors.black),
                                                SizedBox(width: 5),
                                                Text(
                                                  cardContent[index]['icon1Text']!,
                                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 110,
                                            child: Row(
                                              children: [
                                                Icon(cardContent[index]['icon2'], color: Colors.black),
                                                SizedBox(width: 5),
                                                Text(
                                                  cardContent[index]['icon2Text']!,
                                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          ListTile(
                            title: Text("Connection"),
                          ),
                          SizedBox(
                            height: 105,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                List<String> imagePaths = [
                                  'assets/NetworkIcon.png',
                                  'assets/ConsultantsIcon.png',
                                  'assets/AluminiIcon.png',
                                  'assets/SchoolIcon.png',
                                  'assets/CollegeIcon.png'


                                ];

                                return InkWell(
                                  onTap: () => _navigateToListView(context, index),
                                  child: Container(
                                    width: 77.56,
                                    height: 77,
                                    margin: const EdgeInsets.all(13.65),
                                    child: Image.asset(
                                      imagePaths[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("My Profile"),
                          ),
                          Center(
                            child: Container(
                              height: 240 * 0.97,
                              width: 420 * 0.97,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        imageUrl,
                                        width: 87,
                                        height: 131,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Name: ${userData['first_name']} ${userData['last_name']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Email: ${userData['email']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'DOB: ${userData['dob']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Address: ${userData['address']}',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: MaterialButton(
                              minWidth: 150,
                              height: 45,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage()),
                                );
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Tutorials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      drawer: CustomDrawer(
        userDataFuture: fetchUserData(widget.userId),
      ),

    );
  }
}
class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/a.png',
      'assets/b.png',
      'assets/c.png',
      'assets/d.png',
      'assets/e.png',
      'assets/f.png',
      'assets/g.png',
      'assets/h.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Network',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                imagePaths[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text('Network Item $index'),
              subtitle: Text('This is a description for item $index.'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle card tap
              },
            ),
          );
        },
      ),
    );
  }
}

class ConcultantsPage extends StatelessWidget {
  const ConcultantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/a.png',
      'assets/b.png',
      'assets/c.png',
      'assets/d.png',
      'assets/e.png',
      'assets/f.png',
      'assets/g.png',
      'assets/h.png',
    ];

    List<String> titles = [
      'John wick',
      'Robert.j',
      'James Gunn',
      'Ricky tales',
      'Micky mose',
      'Pick War',
      'Leg piece',
      'Apple Mac',
    ];

    List<String> subtitles = [
      'mailto:jon.wick@gmail.com',
      'mailto:robert.j@gmail.com',
      'mailto:james.gunn@gmail.com',
      'mailto:ricky.tales@gmail.com',
      'mailto:micky.mose@gmail.com',
      'mailto:pick.war@gmail.com',
      'mailto:leg.piece@gmail.com',
      'mailto:apple.mac@gmail.com',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Concultants',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                imagePaths[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(titles[index]),
              subtitle: Text(subtitles[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Handle card tap
              },
            ),
          );
        },
      ),
    );
  }
}
class AlumniPage extends StatelessWidget {
  const AlumniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Alumni Item $index'),
          );
        },
      ),
    );
  }
}

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/mit.jpeg',
      'assets/icl.jpg',
      'assets/oxford-university.jpg',
      'assets/hu.jpg',
      'assets/uoc.jpeg',
      'assets/su.jpeg',
      'assets/eth.jpg',
      'assets/nus.jpg',
      'assets/ucl.jpg',
      'assets/ciot.jpeg',
    ];

    List<String> titles = [
      'Massachusetts Institute of Technology (MIT)',
      'Imperial College London',
      'University of Oxford',
      'Harvard University',
      'University of Cambridge',
      'Stanford University',
      'ETH Zurich (Swiss Federal Institute of Technology)',
      'National University of Singapore (NUS)',
      'University College London (UCL)',
      'California Institute of Technology (Caltech)',
    ];

    List<String> subtitles = [
      '77 Massachusetts Ave, Cambridge, MA 02139, United States',
      'South Kensington, London SW7 2BU, United Kingdom',
      'Oxford OX1 2JD, United Kingdom',
      'Cambridge, MA 02138, United States',
      'The Old Schools, Trinity Ln, Cambridge CB2 1TN, United Kingdom',
      '450 Serra Mall, Stanford, CA 94305, United States',
      'Rämistrasse 101, 8092 Zürich, Switzerland',
      '21 Lower Kent Ridge Rd, Singapore 119077',
      'Gower St, London WC1E 6BT, United Kingdom',
      '1200 E California Blvd, Pasadena, CA 91125, United States',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('School',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                imagePaths[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(titles[index]),
              subtitle: Text(subtitles[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                launchWebsite(index);
              },
            ),
          );
        },
      ),
    );
  }

  void launchWebsite(int index) async {
    List<String> websites = [
      'https://web.mit.edu',
      'https://www.imperial.ac.uk',
      'https://www.ox.ac.uk',
      'https://www.harvard.edu',
      'https://www.cam.ac.uk',
      'https://www.stanford.edu',
      'https://ethz.ch',
      'https://www.nus.edu.sg',
      'https://www.ucl.ac.uk',
      'https://www.caltech.edu',
    ];

    String url = websites[index];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CollegePage extends StatelessWidget {
  const CollegePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/mit.jpeg',
      'assets/icl.jpg',
      'assets/oxford-university.jpg',
      'assets/hu.jpg',
      'assets/uoc.jpeg',
      'assets/su.jpeg',
      'assets/eth.jpg',
      'assets/nus.jpg',
      'assets/ucl.jpg',
      'assets/ciot.jpeg',



    ];

    List<String> titles = [
      'Massachusetts Institute of Technology (MIT) ',
      'Imperial College London ',
      'University of Oxford ',
      'Harvard University ',
      'University of Cambridge',
      'Stanford University',
      'ETH Zurich (Swiss Federal Institute of Technology)',
      'National University of Singapore (NUS)',
      'UCL (University College London)',
      'California Institute of Technology (Caltech)',

    ];

    List<String> subtitles = [
      'United States ',
      'United Kingdom ',
      'United Kingdom ',
      'United States',
      'United Kingdom',
      'United States',
      'Switzerland  ',
      'Singapore ',
      'United Kingdom',
      'United States ',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('College',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black87,

      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                imagePaths[index],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(titles[index]),
              subtitle: Text(subtitles[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Handle card tap
              },
            ),
          );
        },
      ),
    );
  }
}



