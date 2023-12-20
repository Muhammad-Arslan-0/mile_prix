import 'package:flutter/material.dart';
import 'package:mile_prix/provider/home_provider.dart';
import 'package:mile_prix/widget/order_tile.dart';
import 'package:provider/provider.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search Field
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffEBEBEB))),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: provider.searchController,
                  onChanged: (v) {
                    provider.onChangedSearch(v);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xffA8A8A8),
                      ),
                      contentPadding: EdgeInsets.all(15),
                      hintText: "Search Orders",
                      hintStyle: TextStyle(color: Color(0xffA8A8A8)),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 20),

              Consumer<HomeProvider>(builder: (context, provider, child) {
                return provider.showListViewItems.isEmpty
                    ? Center(
                        child: Text("No Data Found"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.showListViewItems.length,
                        primary: false,
                        itemBuilder: (context, index) {
                          final order = provider.showListViewItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: OrderTile(order: order, isFromMap: false),
                          );
                        });
              }),
              // Orders
            ],
          ),
        ),
      ),
    );
  }
}
