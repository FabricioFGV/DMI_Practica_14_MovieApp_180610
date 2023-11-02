//Creado por: Fabricio Guzman Vite
//Asignatura: Desarrollo Movil Integral
//Grado: 10 Grupo:A
//Docente: MTI. Marco Antonio Ramirez Hernandez
import 'package:flutter/material.dart';
import 'package:movieapp_180610/media_list.dart';
import 'package:movieapp_180610/common/MediaProvider.dart';
import 'package:movieapp_180610/model/Media.dart';
import 'package:movieapp_180610/media_list_item.dart';


class Home extends StatefulWidget {
  const Home(
      {super.key}); // Constructor de Home con un parámetro opcional llamado key.
  @override
  State<Home> createState() =>
      _HomeState(); // Define una clase que extiende StatefulWidget y proporciona un método para crear su estado interno.
}

class _HomeState extends State<Home> {
  // Define una clase que extiende State y representa el estado interno de Home.

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MediaPrvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController? _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;
  // Estilo de fuente personalizado
  final TextStyle customTextStyle = TextStyle(
    fontFamily: 'MiFuente', // Nombre de la fuente definido en pubspec.yaml
    fontSize: 16.0, // Tamaño de fuente deseado
    fontWeight: FontWeight
        .bold, // Puedes ajustar el peso de la fuente según tus preferencias
  );

  @override
  Widget build(BuildContext context) {
    // Crear una página Scaffold que contiene la estructura principal de la aplicación
    return new Scaffold(
      appBar: new AppBar(
        // Barra de navegación superior (AppBar) con un título y un botón de búsqueda
        title: new Text("MovieApp-180610"), // Título de la aplicación
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Acción a ejecutar cuando se presiona el botón de búsqueda
            },
          ),
        ],
      ),
      drawer: new Drawer(
        // Menú lateral (Drawer) que se despliega desde el borde izquierdo
        child: new ListView(children: <Widget>[
          new DrawerHeader(
            child: Center(
              child: Text(
                '',
                style: TextStyle(
                  backgroundColor: Colors.black38,
                  color: Colors.black38,
                  fontSize: 24,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/back.gif'), fit: BoxFit.cover)),
          ),
          new ListTile(
            title: new Text(
              "peliculas",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            selected: mediaType == MediaType.movie,
            trailing: new Icon(Icons.local_movies),

            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),

          // Separador en el menú
          new Divider(
            height: 5.0,
          ),

          // Elemento del menú "Television"
          new ListTile(
            title: new Text(
              "Television",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            trailing: new Icon(Icons.live_tv), // Icono de películas
            onTap: () {
              _changeMediaType(MediaType.show);
              Navigator.of(context).pop();
            }, // Icono de películas
          ),
          // Separador en el menú
          new Divider(
            height: 5.0,
          ),

          // Elemento del menú "Cerrar"
          new ListTile(
            title: new Text(
              "Cerrar",
              style:
                  customTextStyle, // Aplica el estilo de fuente personalizado
            ),
            trailing: new Icon(Icons.exit_to_app), // Icono de películas
            // Icono de televisión
            onTap: () => Navigator.of(context)
                .pop(), // Cierra el menú al tocar este elemento
          ),
        ]),
      ),
      body: PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        // Barra de navegación inferior (BottomNavigationBar) con iconos y etiquetas
        items: _obtenerIconos(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  // Método para obtener los elementos de la barra de navegación inferior
  List<BottomNavigationBarItem> _obtenerIconos() {
    return mediaType ==MediaType.show ? [ 
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),// Icono de pulgar hacia arriba
        label: ("populares"), // Etiqueta para la opción "populares"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),// Icono de actualización
        label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star), // Icono de estrella
        label: ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
      ),
    ]:
    [ 
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
        label: ("populares"), // Etiqueta para la opción "populares"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),// Icono de actualización
        label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),// Icono de estrella
        label: ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
      ),
    ]
    ;
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            new MediaList(movieProvider, "popular"),
            new MediaList(movieProvider, "upcoming"),
            new MediaList(movieProvider, "top_rated")
          ]
        : <Widget>[
            new MediaList(showProvider, "popular"),
            new MediaList(showProvider, "on_the_air"),
            new MediaList(showProvider, "top_rated")
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 2), curve: Curves.ease);
  }
}