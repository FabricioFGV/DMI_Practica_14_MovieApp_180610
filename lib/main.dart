//Creado por: Fabricio Guzman Vite
//Asignatura: Desarrollo Movil Integral
//Grado: 10 Grupo:A
//Docente: MTI. Marco Antonio Ramirez Hernandez
import 'package:flutter/material.dart';
import 'package:movieapp_180610/home.dart';
   
void main(){
  runApp(      
    new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme:  new ThemeData.dark(),
  ));
}