
# Reto Flutter Gryffindor fase 1

Para la solución de este reto se realizó una pequeña app de creación y administración de gatitos.

El proyecto usa una arquitectura modular donde cada funcionalidad especifica se encuentra separada en un módulo (paquete) diferente. 

Todas las responsabilidades y comportamientos únicos y particulares de cada funcionalidad se encuentran bien segmentados en su propio paquete. Para las partes del proyecto que son transversales y de uso común de todos los módulos se crearon otros dos paquetes (commons / commons_ui) donde se encuentran encapsulados dichos comportamientos.

El proyecto usa inyección de depencias y todas las clases respetan el principio de inversión de la depencia.

Cada módulo cuenta con una stack de navegación propio y se encuentra completamente desligado del stack de navegación principal.

El stack de navegación principal cumple la función de unir los módulos entre si, pero a su vez se asegura que no existan dependencias entre modulos.

Cada modulo solo exporta de manera pública lo mínimo que necesita para funcionar.

Cada módulo tiene la misma estructura de carpetas:

- base
    - inyección_de_dependencias
- bloc
    - carpeta_para_cada_bloc
- models
- ui
    - screens
    - components
- utils

El proyecto usa una arquitectura combinada con el patron Bloc, Casos de uso y repositorios.

Y finalmente para sincronizar las dependencias entre modulos se usa la libreria "Melos". Dentro de la raíz del proyecto se encuentra el archivo melos.yaml donde estan definidas las dependencias comunes.