# PokedexTests

Este paquete contiene pruebas unitarias base para un proyecto iOS (SwiftUI + Combine) con PokéAPI.

## Estructura
- `MockURLProtocol.swift`: Interceptor de red para testear `URLSession` sin llamadas reales.
- `TestHelpers.swift`: Utilidades de Combine y helpers de sesión.
- `ModelsDecodingTests.swift`: Decodificación de respuestas de PokeAPI.
- `EndpointTests.swift`: Construcción de URLs (offset/limit).
- `NetworkClientTests.swift`: Cliente de red con `URLSession` + Combine (éxito/error).
- `ImageCacheTests.swift`: Pruebas de caché sencilla de imágenes/datos.
- `PokemonListViewModelTests.swift`: Prueba de ViewModel de listado con Combine.
- `PokemonDetailViewModelTests.swift`: Prueba de ViewModel de detalle con Combine.

## Integración
1. En Xcode, crea un Target de pruebas llamado **PokedexTests** si no existe.
2. Copia estos archivos dentro de ese target.
3. Reemplaza los tipos _stub_ por tus tipos reales (`PokeAPIClient`, `PokemonService`, `PokemonListViewModel`, `ImageCache`, etc.).
4. Asegura @testable import con el nombre correcto del módulo (`Pokedex`).

## Recomendaciones
- Usa `URLSessionConfiguration.protocolClasses` con `MockURLProtocol` para testear la capa de red.
- Para Combine, prueba publishers con `XCTestExpectation` y helpers.
- Mantén las pruebas deterministas (sin sleeps).
