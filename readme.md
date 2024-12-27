
# Band Names App - Full Stack Application (Flutter & Node.js with Socket.IO)

Este proyecto es una aplicación Full Stack desarrollada con Flutter para el frontend y Node.js para el backend, utilizando Socket.IO para la comunicación en tiempo real. La aplicación permite a los usuarios votar por sus bandas favoritas y ver gráficos actualizados en tiempo real.

## Funcionalidades

### Frontend (Flutter)

- Listado en tiempo real de las bandas disponibles.
- Función para agregar nuevas bandas.
- Votación en tiempo real por bandas.
- Visualización de los resultados mediante un gráfico circular dinámico.
- Reconexión automática en caso de pérdida de conexión al servidor.

### Backend (Node.js)

- WebSocket basado en Socket.IO para manejar conexiones en tiempo real.
- API para gestionar la lista de bandas y los votos.
- Generación de identificadores únicos para las bandas utilizando uuid.
- Configuración básica de entorno utilizando dotenv.

## Tecnologías Utilizadas

### Frontend

- **Flutter**: Framework para construir interfaces nativas.
- **Provider**: Gestión de estado.
- **Socket.IO Client**: Comunicación en tiempo real con el servidor.
- **Pie Chart**: Visualización de datos en gráficos circulares.

### Backend

- **Node.js**: Entorno de ejecución de JavaScript.
- **Express**: Framework para crear APIs RESTful.
- **Socket.IO**: Manejo de WebSockets para comunicación en tiempo real.
- **uuid**: Generación de identificadores únicos.
- **dotenv**: Manejo de variables de entorno.

## Requisitos Previos

- **Flutter SDK** instalado. (Se recomienda usar FVM para manejar versiones de Flutter).
- **Node.js** instalado. (Se recomienda usar NVM para manejar versiones de Node.js).
- **Git** instalado para clonar el repositorio.
- Conexión a internet para descargar dependencias.

## Instalación

### 1. Clonar el Repositorio

Clona el repositorio en tu máquina local:

```bash
git clone https://github.com/OdaFra/BandsNamesApp.git
cd BandsNamesApp
```

### 2. Configurar el Backend

Navega al directorio del backend y configura el servidor:

```bash
cd back_bands_names_app_node_socketIO
```

#### 2.1 Usar NVM para Instalar Node.js

Si no tienes NVM instalado, sigue las instrucciones de [NVM](https://github.com/nvm-sh/nvm).

Instala la versión de Node.js utilizada en el proyecto:

```bash
nvm install 16
nvm use 16
```

#### 2.2 Instalar Dependencias

Instala las dependencias necesarias:

```bash
npm install
```

#### 2.3 Configurar Variables de Entorno

Crea un archivo `.env` en el directorio backend y agrega las variables necesarias:

```env
PORT=3000
```

#### 2.4 Iniciar el Servidor

Inicia el servidor en modo desarrollo:

```bash
npm run start:dev
```

El servidor se ejecutará en [http://localhost:3000](http://localhost:3000).

### 3. Configurar el Frontend

Navega al directorio del frontend:

```bash
cd ../front_bands_names_app_flutter
```

#### 3.1 Usar FVM para Manejar la Versión de Flutter

Si no tienes FVM instalado, instálalo ejecutando:

```bash
dart pub global activate fvm
```

Instala la versión de Flutter especificada en el proyecto:

```bash
fvm install 2.17.1
fvm use 2.17.1
```

#### 3.2 Obtener las Dependencias de Flutter

Ejecuta el siguiente comando para descargar las dependencias:

```bash
fvm flutter pub get
```

#### 3.3 Ejecutar la Aplicación Flutter

Ejecuta el proyecto en un emulador o dispositivo físico:

```bash
fvm flutter run
```

## Estructura del Proyecto

### Frontend (Flutter)

El directorio del frontend incluye los siguientes archivos importantes:

- `lib/main.dart`: Punto de entrada de la aplicación.
- `lib/models/`: Modelos de datos utilizados en la aplicación.
- `lib/services/`: Gestión del estado de la aplicación utilizando Provider y Conexión al servidor Socket.IO.
- `lib/services/socket_service.dart`: Se debe agregar la ip del servidor donde se encuentra en back (aqui se puede utilizar .env como sugerencia).

### Backend (Node.js)

El directorio del backend incluye los siguientes archivos importantes:

- `index.js`: Punto de entrada del servidor.
- `models/Band.js`: Modelo para representar una banda.
- `sockets/socket.js`: Lógica de manejo de eventos de Socket.IO.
- `public/`: Visualizacion desde la web para la conexion del Socket.IO.

## Uso

1. **Inicia el servidor**: Asegúrate de que el backend esté en ejecución antes de iniciar la aplicación Flutter.

2. **Ejecuta el frontend**: Abre un emulador o conecta un dispositivo físico y ejecuta el comando:

```bash
fvm flutter run
```

3. **Interactúa con la aplicación**:
   - Agrega nuevas bandas desde el frontend.
   - Vota por tus bandas favoritas y observa cómo los datos se actualizan en tiempo real en todos los clientes conectados.

## Contáctame

No dudes en comunicarte conmigo si tienes alguna pregunta, comentario u oportunidad de colaboración:

- **Correo electrónico**: [osramirezf@gmail.com]
- **LinkedIn**: [[Perfil de LinkedIn](https://www.linkedin.com/in/oscar-ramirez-franco/)]
- **GitHub**: [[Perfil de GitHub](https://github.com/OdaFra)]
