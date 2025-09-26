# Pokedex iOS

Aplicación iOS tipo Pokédex que consume la PokeAPI para listar y detallar Pokémon.

## ✨ Características
- Lista paginada de Pokémon
- Búsqueda por nombre
- Detalle con imagen, tipos y estadísticas
- Cache de imágenes
- Arquitectura modular (ver sección Arquitectura)

## 🧱 Arquitectura
## 🧩 Módulos del proyecto

> Basado en la estructura del repo (`Pokedex.xcodeproj` y carpeta `Pokedex`). Ajusta las rutas exactas según tu árbol de archivos.

- **Networking** (`Pokedex/Networking/`): Clientes de red, endpoints de PokeAPI, decodificación `Codable`.
- **Models** (`Pokedex/Models/`): Modelos `Pokemon`, `Type`, `Stat`, etc.
- **ImageCache** (`Pokedex/Services/ImageCache/`): Cache con `NSCache` y soporte para descarga/cancelación.
- **Services** (`Pokedex/Services/`): Casos de uso, orquestación de datos.
- **ViewModels (MVVM + Combine)** (`Pokedex/ViewModels/`): `@Published`, `AnyPublisher`, manejo de estados/cargas/errores.
- **Views/UI** (`Pokedex/Views/`): Pantallas de Lista, Detalle; celdas; componentes reutilizables.
- **Coordinators/Navegación** (`Pokedex/Navigation/`): Flujo entre Lista → Detalle.
- **Utils** (`Pokedex/Utils/`): Extensiones, helpers, constantes.
- **Resources** (`Pokedex/Resources/`): Assets, colores, fuentes, `Info.plist` y `xcassets`.

- **Patrón:** MVVM (Views + ViewModels + Services)
- **Capa de red:** URLSession (o equivalente)
- **Imagen/caché:** URLCache / NSCache
- **Inyección:** inicializadores
- **Reactivo:** Combine para manejo de publishers y subscribers

> _Ajusta esta sección a lo que realmente tengas en el código._

## 🛠 Requisitos
- Xcode 15+ (iOS 17 SDK recomendado)
- iOS 15.0+ (target sugerido)
- Swift 5.10+

## 🚀 Instrucciones de Instalación y Ejecución
1. Clona el repo:
   ```bash
   git clone git@github.com:amonteslarios/pokedex.git
   ```
2. Abre `Pokedex.xcodeproj` en Xcode.
3. Selecciona un simulador y `Run` (⌘R).

## 🔌 Configuración de entorno
- **API Base URL:** `https://pokeapi.co/api/v2/`
- Si usas llaves/entornos, documenta aquí variables en `xcconfig` o `Info.plist`.

## 🧪 Tests
- Ejecuta pruebas con `⌘U` (o desde el esquema de Tests).
- Añade pruebas de ViewModel y de capa de red con mocks.

## 📦 CI/CD (opcional)
- Workflow de GitHub Actions para build & tests en cada PR a `develop` y `main`.

## 🗺 Roadmap
- Favoritos offline
- Filtros por tipo
- Accesibilidad (VoiceOver, Dynamic Type)

## 🤝 Contribución
Consulta [`CONTRIBUTING.md`](CONTRIBUTING.md) y usa nuestras plantillas de PR/Issues.

## 📄 Licencia
MIT (o la que elijas) en `LICENSE`.


##  Decisiones Arquitectónicas Justificadas: 

- MVVM + SwiftUI + Combine: Separación clara entre presentación (Views) y lógica de presentación (ViewModels). Los ViewModels exponen estado reactivo vía @Published y AnyPublisher permitiendo el uso data binding. A su vez fue parte del requerimiento el uso de Models, Views y ViewModels así que la arquitectura o patron que se adaptaba a esa necesidad era MVVM

- Estado unificado de la pantalla (ViewState)
Un enum controla idle / loading / loaded / error, evitando estados inconsistentes y simplificando los flujos de UI/errores.

- Inyección de dependencias
Los ViewModels reciben PokemonAPIServiceProtocol para poder desacoplar UI de la capa conexion, habilita tests y cambios de backend sin tocar la UI.

- Navegación simple
Se usa NavigationStack (SwiftUI). La navegación no vive en el ViewModel; el ViewModel solo emite intenciones. Si la aplicación muta o crece también seria compatible con un Coordinator ligero.

- Estrategia de errores y resiliencia
Errores normalizados en el Service mostando mensajes de UI en el ViewModel.

## Optimizaciones Implementadas

###Paginación eficiente
Carga por páginas 20 a 50 items en este caso nos quedamos con 50 pokemones por llamado es una constante la cual puede ser modificada. El ViewModel solicita la siguiente página cuando el usuario se aproxima al final de la lista donde se implimento que cuando ya este en los 10 ultimos este pueda hacer el llamado a la API para poder sumar más información en la lista.

### Lazy Loading de imágenes
Las imágenes se solicitan solo cuando son visibles. Se cancela/rehúsa la carga al reciclar celdas, evitando trabajo inútil al hacer scroll rápido.

### Cache de imágenes en memoria
ImageCacheService guarda bitmaps por URL para evitar redescargas de imagenes.

### Trabajo pesado fuera del hilo principal
Decodificación JSON y transformaciones se realizan en background.

### Reuso de infraestructura
Reutilización de URLSession y JSONDecoder.

## Issues o Limitaciones Conocidos

### Sin persistencia de datos (Guardado en memoria)
Actualmente no se guardan datos en disco.
Al reiniciar la app, se vuelve a consultar la APP

### Imágenes de los pokemones pueden parpadear cuando uno hace scroll rápido
Con conexiones de redes de internet lentas puede notarse un parpadeo 

### Localización limitada
No uso de Localizable.Strings dentro del proyecto

###Limitaciones en la busqueda
Cuando uno quiere buscar un pokemon que no este cargado en la lista no vera contenido (Ejm: Buscar Chikorita al momento de iniciar el app)
Esto es debido a que la busqueda no se hace en tiempo real ya que se tienen limitaciones con la API.


##Screenshots de la Aplicación Funcionando

- Captura 1 (Muestra pantalla inicial Lista)

- Captura 2 (Muestra el detalle del pokemon Bullbasaur)

- Captura 3 (Muestra el detalle del pokemon Venusaur)

- Captura 4 (Muestra la lista filtrada por las letras "ch")

- Captura 5 (Muestra la lista hasta el pokemon 141)
