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

## 🚀 Ejecución
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
