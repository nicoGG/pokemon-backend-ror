
# Pokémon API

## Descripción

Esta API proporciona endpoints para gestionar Pokémon, realizar autenticación basada en JWT (JSON Web Token), y permite la captura y gestión de Pokémon. Además, la API ofrece funcionalidad para listar, capturar, liberar y mostrar Pokémon capturados.

## Tecnologías utilizadas

- **Ruby on Rails** (API)
- **JWT** para autenticación
- **PostgreSQL** para la base de datos
- **Rswag** para la documentación con Swagger

## Requisitos previos

Antes de ejecutar la API, asegúrate de tener instalados los siguientes componentes:

- Ruby 3.2.0 o superior
- Rails 7.0 o superior
- PostgreSQL
- Node.js y Yarn

## Instalación

1. **Clona el repositorio**:

   ```bash
   git clone git@github.com:nicoGG/pokemon-backend-ror.git
   cd pokemon-backend-ror
   ```

2. **Instala las dependencias**:

   ```bash
   bundle install
   yarn install
   ```

3. **Configura la base de datos**:

   Crea y migra la base de datos:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Credenciales de JWT**:

   Abre el archivo de credenciales de Rails y agrega la clave secreta para JWT:

   ```bash
   rails credentials:edit
   ```

   Luego, agrega lo siguiente al archivo `credentials.yml.enc`:

   ```yaml
   jwt_secret: 'tu_clave_secreta'
   ```

5. **Inicia el servidor**:

   ```bash
   rails s
   ```

## Endpoints de la API

### 1. **Autenticación**

#### `POST /login`

Este endpoint permite a los usuarios iniciar sesión y obtener un token JWT.

- **Ruta**: `/login`
- **Método**: `POST`
- **Cuerpo de la solicitud**:

  ```json
  {
    "username": "admin",
    "password": "admin"
  }
  ```

- **Respuesta exitosa** (200):

  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiJ9..."
  }
  ```

### 2. **Pokémon**

#### `GET /pokemons`

Este endpoint lista los Pokémon disponibles, permite la búsqueda por nombre o tipo, y también la paginación.

- **Ruta**: `/pokemons`
- **Método**: `GET`
- **Parámetros opcionales**:
  - `name`: Filtrar por nombre de Pokémon.
  - `type`: Filtrar por tipo de Pokémon (agua, fuego, tierra, etc.).
  - `page`: Número de página.

- **Respuesta exitosa** (200):

  ```json
  {
    "pokemons": [
      {
        "id": 1,
        "name": "bulbasaur",
        "types": ["grass", "poison"],
        "image": "url_de_imagen",
        "captured": false
      }
    ],
    "currentPage": 1,
    "totalPages": 8,
    "totalPokemons": 150
  }
  ```

#### `POST /pokemons/:id/capture`

Este endpoint captura un Pokémon. Solo puedes capturar hasta 6 Pokémon.

- **Ruta**: `/pokemons/:id/capture`
- **Método**: `POST`
- **Encabezado**: `Authorization: Bearer <tu_token_jwt>`
- **Respuesta exitosa** (200):

  ```json
  {
    "message": "Pokémon capturado exitosamente"
  }
  ```

#### `DELETE /pokemons/:id/release`

Este endpoint libera un Pokémon capturado.

- **Ruta**: `/pokemons/:id/release`
- **Método**: `DELETE`
- **Encabezado**: `Authorization: Bearer <tu_token_jwt>`
- **Respuesta exitosa** (200):

  ```json
  {
    "message": "Pokémon liberado exitosamente"
  }
  ```

#### `GET /pokemons/captured`

Este endpoint lista los Pokémon capturados.

- **Ruta**: `/pokemons/captured`
- **Método**: `GET`
- **Encabezado**: `Authorization: Bearer <tu_token_jwt>`
- **Respuesta exitosa** (200):

  ```json
  {
    "captured_pokemons": [
      {
        "id": 1,
        "name": "bulbasaur",
        "types": ["grass", "poison"],
        "image": "url_de_imagen",
        "captured": true,
        "captureDate": "2024-10-07T01:40:06.002Z"
      }
    ]
  }
  ```

### 3. **Importación de Pokémon**

#### `POST /pokemons/import`

Este endpoint importa los primeros 150 Pokémon desde la API de **PokeAPI** a la base de datos local.

- **Ruta**: `/pokemons/import`
- **Método**: `POST`
- **Encabezado**: `Authorization: Bearer <tu_token_jwt>`
- **Respuesta exitosa** (200):

  ```json
  {
    "message": "Importación exitosa de 150 Pokémon"
  }
  ```

## Seguridad

Esta API usa JWT para proteger los endpoints. Para acceder a los endpoints protegidos, debes proporcionar el token JWT en el encabezado `Authorization` en el formato `Bearer <tu_token_jwt>`.

### Ejemplo:

```bash
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

## Documentación de la API con Swagger

Puedes acceder a la documentación de la API generada con Swagger accediendo a:

```
http://localhost:3000/api-docs
```

## Ejecución de pruebas

Esta API utiliza RSpec para pruebas unitarias y de integración. Puedes ejecutar las pruebas con el siguiente comando:

```bash
bundle exec rspec
```

## Contribuir

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y haz un commit (`git commit -am 'Añadí una nueva funcionalidad'`).
4. Sube los cambios a tu fork (`git push origin feature/nueva-funcionalidad`).
5. Crea un Pull Request.

## Licencia

Este proyecto está bajo la Licencia MIT. Para más detalles, consulta el archivo `LICENSE`.
