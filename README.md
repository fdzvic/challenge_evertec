# 🎬 Challenge Evertec

Aplicación móvil desarrollada en Flutter que permite a los usuarios explorar películas, ver detalles, guardar favoritas y gestionar su perfil.

La app consume la API pública de **TheMovieDB**, soporta autenticación con **Firebase**, persistencia local con **Drift**, manejo de estado con **Bloc/Cubit** y navegación con **GoRouter**.

---

## 🚀 Características principales

- 🔐 Login y registro con Firebase Authentication  
- 👤 Perfil de usuario con Firestore  
- 🎬 Listado de películas:
  - Now Playing
  - Populares
  - Top Rated
  - Upcoming
- 📄 Pantalla de detalle de película
- ❤️ Guardar películas favoritas (persistencia local con Drift)
- 🌐 Soporte offline para favoritos
- 🌙 Tema claro / oscuro persistido
- 🌍 Soporte multi-idioma (ES / EN)
- 📶 Detección de conectividad y recarga automática
- 🧪 Tests unitarios y de widgets

---

## 🧱 Arquitectura

El proyecto sigue **Clean Architecture**:

lib/
 ├── core/
 │    ├── database/
 │    ├── network/
 │    ├── router/
 │    └── utils/
 │
 ├── features/
 │    ├── auth/
 │    ├── movies/
 │    ├── favorites/
 │    ├── profile/
 │    └── home/

Capas

Presentation → UI, Cubits, Widgets

Domain → Entities, Repositories, UseCases

Data → DataSources, Models, Implementaciones


## 🛠 Tecnologías usadas

Flutter

Firebase Auth

Firestore

Drift (SQLite ORM)

BLoC / Cubit

GoRouter

Connectivity Plus

TheMovieDB API

## 🔑 Configuración del proyecto

### 1️⃣ Clonar repositorio

```bash
git clone https://github.com/fdzvic/challenge_evertec.git
cd challenge_evertec 
``` 
### 2️⃣ Configurar variables de entorno

Crear archivo .env en la raíz:

TMDB_API_KEY=TU_API_KEY_AQUI
TMDB_BASE_URL=https://api.themoviedb.org/3

nota: Escribeme si requieres el TMDB_API_KEY a mi correo electronico ing.vhfernandez@gmail.com

### 3️⃣ Instalar dependencias
flutter clean
flutter pub get

### 4️⃣ Ejecutar app
flutter run

## 👨‍💻 Autor

Víctor Fernández
Flutter Developer

correo: ing.vhfernandez@gmail.com
GitHub: https://github.com/fdzvic

## 📄 Licencia

Proyecto desarrollado con fines educativos y de evaluación técnica.