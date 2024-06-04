# Estructura de Carpetas del Proyecto

Este proyecto es una aplicación móvil desarrollada en Flutter que se centra en la administración de gatitos. La aplicación no utiliza ninguna librería externa y sigue una arquitectura de diseño dirigido por dominio (DDD).

# Características principales
 - Visualización de imágenes y detalles de gatitos.
 - Implementación de una arquitectura de diseño dirigido por dominio (DDD).
 - Interfaz de usuario intuitiva y fácil de usar.

# Pantallas
 - Home: En la pantalla principal se pueden apreciar dos escenarios, el primero es cuando aún no se ha guardado ningún gatito y el segundo es cuando ya se tiene uno o más gatitos creados. 
    - Escenario 1 (Sin gatos): En este podemos ver un mensaje corto y un botón que nos llevará al formulario para agregar un nuevo gatito.
    - Escenario 2 (Con gatos): En este podemos ver un listado de gatitos. Si presionamos sobre alguno de ellos nos llevará a una pantalla de detalles. Además de eso también podremos ver un botón en la parte inferior derecha que al presionarlo iremos al formulario para agregar un nuevo gatito.

 - Detalles: En la pantalla de detalles podemos ver información ampliada sobre un gato en especifico. Además de esto contamos con dos botones en la parte inferior.
    - Eliminar: Borrará el gatito y nos devolverá a la pantalla principal.
    - Editar: Nos redirigirá a la pantalla de edición, en la que tendremos un formulario para cambiar los datos del gatito.

 - Agregar/Modificar: En esta pantalla encontraremos un formulario donde podremos ingresar textos, interacturar con algunos sliders y adicionalmente podremos elegir una imagen para nuestro gatito. También contamos con un botón en la parte inferior que nos sirve para validar y terminar el proceso de creación/edición de nuestros gatos.


# Consideraciones importantes

    - El proyecto usa el patrón BLoC, pero no usa ninguna libreria para implementarlo, cuenta con una implementación local.
    - Las pantallas se renderizan mendiante un "StreamBuilder" y este es el que permite realizar los cambios de estado emitidos desde el bloc.
