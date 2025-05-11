import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatisticCard(
                title: "Itens Registrados",
                count: 1500,
                color: Colors.blue,
                icon: Icons.archive,
              ),
              StatisticCard(
                title: "Itens no Mês",
                count: 120,
                color: Colors.green,
                icon: Icons.calendar_today,
              ),
              StatisticCard(
                title: "Itens na Semana",
                count: 30,
                color: Colors.red,
                icon: Icons.calendar_view_week,
              ),
              StatisticCard(
                title: "Itens no Dia",
                count: 30,
                color: Colors.orange,
                icon: Icons.calendar_view_day,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(-2, 2),
                      ),
                    ],
                  ),
                  alignment: AlignmentDirectional.topStart,
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.location_pin, color: Colors.blue),
                          title: Text(
                            'Localização 1: 10 itens',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_pin, color: Colors.blue),
                          title: Text(
                            'Localização 2: 15 itens',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_pin, color: Colors.blue),
                          title: Text(
                            'Localização 3: 8 itens',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final int? count;
  final Color? color;
  final IconData? icon;

  StatisticCard({
    required this.title,
    this.count,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Add a slight elevation for modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        height: 200,
        width: 300,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align icons to the left
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 32.0, // Adjust icon size for balance
                ),
                SizedBox(width: 10.0), // Add spacing between icon and text
                Text(
                  title,
                  style: TextStyle(
                    color: Colors
                        .black87, // Use a darker color for better contrast
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold, // Add boldness for emphasis
                  ),
                ),
              ],
            ),
            Spacer(), // Add space for better vertical distribution
            Text(
              count.toString(),
              style: TextStyle(
                color: color,
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemData {
  final String month;
  final int count;

  ItemData({required this.month, required this.count});
}
