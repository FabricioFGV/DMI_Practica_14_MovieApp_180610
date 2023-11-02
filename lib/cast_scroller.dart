import 'package:flutter/material.dart';
import 'package:movieapp_180610/common/MediaProvider.dart';
import 'package:movieapp_180610/model/Cast.dart';

class CastController extends StatefulWidget {
  final MediaProvider provider;
  final int mediaId;
 
  CastController(this.provider, this.mediaId);

  @override
  State<CastController> createState() => new _CastControllerState();
}

class _CastControllerState extends State<CastController> {
  
  @override
  void initState() {
    super.initState();
    loadCast();
    
  }

   final List<Cast> _casts = [];
  void loadCast() async{
    var result = await widget.provider.fetchCast(widget.mediaId);
    setState(() {
        _casts.addAll(result);
      });
  }

  Widget _builderCast(BuildContext ctx, int index){
    var cast = _casts[index];
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(children: <Widget>[
        CircleAvatar(
          backgroundImage: new NetworkImage(
            cast.getCastUrl()
          ),
          radius: 40.0,
        ),
        Padding(padding: const EdgeInsets.only(top: 8.0),
        child: Text(cast.name),
        ),
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        SizedBox.fromSize(
          size: const Size.fromHeight(180.0),
          child: ListView.builder(
            itemCount: _casts.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0), 
            itemBuilder: _builderCast,
          ),
        ),
      ],
    );
  }
}