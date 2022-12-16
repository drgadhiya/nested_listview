import 'package:flutter/material.dart';
import 'package:nested_listview/Model/MovieDataModel.dart';
import 'package:nested_listview/Resources/StringResource.dart';

// ignore: must_be_immutable
class ListScreen extends StatefulWidget {
  List<MovieDataModel> arrCategory = [];

  ListScreen({Key? key, required this.arrCategory}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringResource.LIST),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.arrCategory.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(
                  widget.arrCategory[index].name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                leading: (widget.arrCategory[index].streamIcon!.isNotEmpty)
                    ? ClipOval(
                        child: Image.network(
                        widget.arrCategory[index].streamIcon!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              child: Text(widget.arrCategory[index].name![0]),
                            ),
                          );
                        },
                      ))
                    : SizedBox(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          child: Text(widget.arrCategory[index].name![0]),
                        ),
                      ),
              );
            }),
      ),
    );
  }
}
