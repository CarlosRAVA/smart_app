import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_app/models/movie.dart';

class DetailScreen extends StatelessWidget {

  final Movie movie;
  const DetailScreen({super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          // FONDO CON EL COLOR DE LA PELICULA
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ movie.color1, movie.color2]
              )
            ),
          ),
          // DEGRADADO
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  scheme.surface.withValues(alpha: 0.75),
                  scheme.surface.withValues(alpha: 0.9),
                ]
              )
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 64, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // IMAGEN
                  FadeInLeft(
                    duration: Duration(milliseconds: 450),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 32,
                              offset: Offset(0, 16)
                            )
                          ]
                        ),
                        child: Image.network(
                          movie.posterUrl,
                          width: 280,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) 
                  ),

                  //TITULO, DESCRIPCION Y BOTONES
                  SizedBox(width: 50,),
                  Expanded(
                    child: FadeInUp(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5
                            ),
                          ),

                          //DESCRIPCION
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: scheme.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: scheme.primary.withValues(alpha: 0.5)
                                  )
                                ),
                                child: Text(
                                  movie.year,
                                  style: TextStyle(
                                    color: scheme.onSurface,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                  ),
                                  ),
                              ),
                              SizedBox(width: 20,),
                              Icon(Icons.star, color: Colors.amber, size: 18,),
                              SizedBox(width: 8,),
                              Text(movie.rating.toString(),
                                  style: TextStyle(
                                    color: scheme.onSurface,
                                    fontSize: 16
                                  ),
                              )
                            ],
                          ),

                          SizedBox(height: 24,),
                          SizedBox(
                            width: 560,
                            child: Text(
                              movie.description,
                              style: TextStyle(
                                color: scheme.onSurface.withValues(alpha: 0.85),
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(height: 32,),
                          Row(
                            children: [
                              _ActionButton(
                                icon: Icons.play_arrow,
                                label: 'Ver Trailer',
                                primary: true,
                                autofocus: true,
                                onPressed: () { },
                              ),

                              SizedBox(width: 16,),

                              _ActionButton(
                                icon: Icons.arrow_back,
                                label: 'Volver',
                                onPressed: () => context.pop(),
                              ),


                            ],
                          )
                        ],
                      )
                    )
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}

class _ActionButton extends StatefulWidget {

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool autofocus;
  final bool primary;
  
  const _ActionButton({
    required this.icon, 
    required this.label, 
    required this.onPressed, 
    this.autofocus = false, 
    this.primary = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = widget.primary
    ? scheme.primary
    : (_focused ? scheme.onSurface : scheme.surfaceContainerHighest);

    final fg = widget.primary
    ? scheme.onPrimary
    : (_focused ? scheme.surface : scheme.onSurface);

    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (value) => setState(() {_focused = value;}),
      onKeyEvent: (node, event) {
        if ( event is KeyDownEvent && 
              (event.logicalKey == LogicalKeyboardKey.enter || 
              event.logicalKey == LogicalKeyboardKey.select)) {
          widget.onPressed();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;  
      }, 
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _focused
              ? [
                BoxShadow(
                  color: bg.withValues(alpha: 0.5),
                  blurRadius: 16,
                  spreadRadius: 1
                )
              ]
              : []
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: fg),
              SizedBox(width: 8,),
              Text(
                widget.label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}