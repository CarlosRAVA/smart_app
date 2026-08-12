import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_app/models/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback onSelect;
  final bool autofocus;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onSelect,
    required this.autofocus
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {

    final primary = Theme.of(context).colorScheme.primary;

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (focused) => setState(() => _focused = focused),
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
        (
          event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.gameButtonA)) {
            widget.onSelect();
            return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: widget.onSelect,
        child: AnimatedScale(
          scale: _focused ? 1.06 : 1.0,
          duration: Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _focused ? Colors.white : Colors.transparent,
                width: 3
              ),
              boxShadow: _focused
                ? [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.4),
                      blurRadius: 24,
                      spreadRadius: 1
                    ),
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 12,
                      offset: Offset(0, 6)
                    )
                ]
                : [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(0, 4)
                    )
                ]
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                //Gradiente del contenedor 
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [ widget.movie.color1, widget.movie.color2 ]
                    )
                  ),
                ),

                //Imagen de la pelicula
                Image.network(
                  widget.movie.posterUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Icon(widget.movie.icon, size: 56, color: Colors.white70,),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(widget.movie.icon, size: 56, color: Colors.white70,),
                  ),
                ),

                // PUNTUACION
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 13,),
                        Text(
                          widget.movie.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  )
                ),

                // TITULO
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 28, 10, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      )
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 1.1
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }
}