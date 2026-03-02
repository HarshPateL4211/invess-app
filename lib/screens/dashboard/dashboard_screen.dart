import 'package:flutter/material.dart';
// import 'package:api_app/services/api_service.dart';
import 'package:api_app/models/ipo_model.dart';
import 'package:api_app/core/routes.dart';
import 'package:api_app/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ✅ Bottom Navigation Index
  int _bottomIndex = 0;

  // ✅ IPO Tab Variables
  bool sortAscending = true;
  int selectedTab = 1;

  // ---------------- IPO UI ---------------- //

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
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
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

  Widget _buildTopTabs() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          _buildTabButton("Open", 0),
          _buildTabButton("Upcoming", 1),
          _buildTabButton("Closed", 2),
        ],
      ),
    );
  }

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
              fontSize: 18,
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

  Widget _buildIPOScreen() {
    final List<IPOItem> ipoList = [
      IPOItem(
        id: 1,
        name: "Tata Technologies",
        date: "15 - 18 Dec 2025",
        price: "₹450 - ₹500",
        lotSize: "30",
        issueSize: "₹1200 Cr",
        status: "Open",
        logo: "",
      ),
      IPOItem(
        id: 2,
        name: "Reliance Retail",
        date: "20 - 23 Dec 2025",
        price: "₹900 - ₹950",
        lotSize: "15",
        issueSize: "₹5000 Cr",
        status: "Upcoming",
        logo: "",
      ),
      IPOItem(
        id: 3,
        name: "OYO Rooms",
        date: "10 - 12 Dec 2025",
        price: "₹300 - ₹350",
        lotSize: "40",
        issueSize: "₹800 Cr",
        status: "Closed",
        logo: "",
      ),
    ];

    // FutureBuilder<List<IPOItem>>(
    // future: ApiService.fetchIPOItems(),
    // builder: (context, snapshot) {
    //   if (snapshot.connectionState == ConnectionState.waiting) {
    //     return const Center(child: CircularProgressIndicator());
    //   }

    //   if (snapshot.hasError) {
    //     return Center(child: Text("Error: ${snapshot.error}"));
    //   }

    //   if (!snapshot.hasData) {
    //     return const Center(child: Text("No Data"));
    //   }

    //   var ipoList = snapshot.data!;

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
        // Top Tabs
        _buildTopTabs(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(top: 7, bottom: 7, right: 10),
          child: Row(
            children: [
              _buildBoardBadge("MAINBOARD"),
              const SizedBox(width: 10),
              _buildBoardBadge("SME"),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => sortAscending = !sortAscending),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35, // Adjusted to fit with the new bottom bar
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://jainam-uat.ipoplus.in/Images/${item.logo}",
                              height: 55,
                              width: 55,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Image.asset(
                                "assets/images/Meesho_logo.png",
                                height: 55,
                                width: 55,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 1),
                      const SizedBox(height: 5),
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003E70),
                        ),
                      ),
                      Text(
                        item.date,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 1),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoBlock("Price Range", item.price),
                          _buildInfoBlock("Lot Size", item.lotSize),
                          _buildInfoBlock("Issue Size", item.issueSize),
                        ],
                      ),

                      // SizedBox(height: 5),
                      const Spacer(),
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
  }

  // ---------------- UI ---------------- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Image.asset("assets/images/invess.png", height: 40)],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.notification);
                  },
                  child: _buildIcon(Icons.notifications_none),
                ),
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

      body: IndexedStack(
        index: _bottomIndex,
        children: [
          _buildIPOScreen(), // ✅ now rebuilds properly
          const Center(child: Text("Unlisted Screen")),
          const ProfileScreen(),
          const Center(child: Text("Order Book Screen")),
          const Center(child: Text("Announcement Screen")),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            label: "IPO",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: "Unlisted",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "Order Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "Announcement",
          ),
        ],
      ),
    );
  }
}