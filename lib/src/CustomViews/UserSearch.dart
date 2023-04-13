import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Home_Views/UsersHome_View.dart';
import 'package:flutter/material.dart';

class SearchUsersScreen extends StatefulWidget {
  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/*  final _userService = UsersHome_View;
  final _searchController = TextEditingController();
  List<Usuario> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Buscar usuarios'),
    ),
    body: Column(
    children: [
    TextField(
    controller: _searchController,
    decoration: InputDecoration(
    hintText: 'Buscar usuario',
    contentPadding: EdgeInsets.all(10),
    ),
    onChanged: (query) async {
    //final results = await _userService.searchUsers();
    setState(() {
    _searchResults = results;
    });
    },
    ),
    Expanded(
    child: ListView.builder(
    itemCount: _searchResults.length,
    itemBuilder: (context, index) {
    final user = _searchResults[index];
    return ListTile(
    title: Text(user.name),
    onTap: () async {
    final user = await _userService*/
}