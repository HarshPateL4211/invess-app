import 'package:flutter/material.dart';
import 'package:api_app/services/api_service.dart';
import 'package:api_app/models/ipo_model.dart';
import 'package:api_app/core/routes.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool sortAscending = true;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return Colors.green;
      case "upcoming":
        return Colors.orange;
      case "closed":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _buildBoardBadge(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10),
      child: Row(
        children: [
          const Icon(Icons.check, size: 24, color: Color(0xFF00338B)),
          const SizedBox(width: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 62, 112),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF00338B)),
      ),
      child: Icon(icon, size: 22),
    );
  }

  int selectedTab = 1;

  //Building tops Tab

  Widget _buildTopTabs() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          _buildTabButton("Open", 0),
          _buildTabButton("Upcoming", 1),
          _buildTabButton("Closed", 2),
        ],
      ),
    );
  }

  //Individual Tab Button

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 0, 71, 129)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(221, 100, 100, 100),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Logo + Title
            Row(
              children: [Image.asset("assets/images/invess.png", height: 40)],
            ),

            /// Icons
            Row(
              children: [
                _buildIcon(Icons.notifications_none),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.setting);
                  },
                  child: _buildIcon(Icons.settings_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<IPOItem>>(
        future: ApiService.fetchIPOItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("API ERROR: ${snapshot.error}");
            return Center(
              child: Text(
                "Error:\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }

          var ipoList = snapshot.data!;

          var filteredList = ipoList.where((item) {
            final status = item.status.toLowerCase().trim();
            if (selectedTab == 0) return status == "open";
            if (selectedTab == 1) return status == "upcoming";
            return status == "closed";
          }).toList();
          filteredList.sort((a, b) {
            return sortAscending
                ? a.name.compareTo(b.name)
                : b.name.compareTo(a.name);
          });

          return Column(
            children: [
              _buildTopTabs(),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(top: 7, bottom: 7, right: 10),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildBoardBadge("MAINBOARD"),

                    const SizedBox(width: 10),

                    _buildBoardBadge("SME"),
                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sortAscending = !sortAscending;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Sort",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.swap_vert,
                            size: 24,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(right: 12, left: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.42,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Logo
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    "https://jainam-uat.ipoplus.in/Images/${item.logo}",
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/Meesho_logo.png",
                                        height: 55,
                                        width: 55,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),

                                /// Status Badge (Upcoming)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(item.status),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item.status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// ✅ Divider
                            Divider(thickness: 1, height: 1),

                            const SizedBox(height: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 62, 112),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    item.date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// ✅ Divider
                            const Divider(thickness: 1, height: 1),
                            const SizedBox(height: 10),

                            /// ✅ PRICE + LOT + ISSUE SIZE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoBlock("Price Range", item.price),
                                _buildInfoBlock("Lot Size", item.lotSize),
                                _buildInfoBlock("Issue Size", item.issueSize),
                              ],
                            ),

                            // const Spacer(),
                            const SizedBox(height: 10),

                            /// ✅ BUTTONS ROW
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00338B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      "Apply",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text("View Details"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
