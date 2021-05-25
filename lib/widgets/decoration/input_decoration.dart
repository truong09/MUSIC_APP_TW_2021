import 'package:flutter/material.dart';

var searchInputDecoration = new InputDecoration(
  prefixIcon: new Icon(Icons.search),
  hintText: "Nhập tên bài hát muốn tìm kiếm",
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.blue),
  ),
);
var tagSong = BoxDecoration(
    border: Border(bottom: BorderSide(width: 1, color: Colors.grey)));
