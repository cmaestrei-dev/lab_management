# 🧪 Lab Management System - Integration API

Este proyecto es una API RESTful desarrollada en **Ruby on Rails 8** y **PostgreSQL**, diseñada para gestionar y reportar incidencias en los laboratorios de la Universidad de Cartagena. 

El sistema ha sido construido bajo una arquitectura **Enterprise B2B** orientada a eventos, enfocada en la integración segura, resiliente y escalable con sistemas de terceros (como plataformas HRIS o ERPs).

---

## 🚀 Arquitectura y Características Principales

* **Seguridad (Bearer Token Authentication):** Endpoints protegidos mediante validación de tokens en tiempo constante (`secure_compare`) para prevenir ataques de *Timing* y accesos no autorizados.
* **Manejo de Errores Global Estructurado:** Intercepción centralizada de excepciones (`rescue_from`). La API nunca devuelve HTML; responde estandarizadamente en formato JSON con códigos HTTP precisos (`401 Unauthorized`, `404 Not Found`, `500 Internal Server Error`).
* **Paginación & Collection Wrapping:** Cumplimiento de directrices de diseño de APIs empresariales (estilo Microsoft REST). Las colecciones se devuelven en un objeto raíz con metadatos de navegación (`@count`, `@nextLink`) y límites estrictos para prevenir ataques de Denegación de Servicio (DoS).
* **Optimización de Consultas (Eager Loading):** Eliminación activa del problema de rendimiento N+1 utilizando `.includes()` en Active Record, delegando los JOINs pesados a PostgreSQL.
* **Arquitectura Orientada a Eventos (Webhooks Asíncronos):** Implementación de `ActiveJob` (Sidekiq/SolidQueue) que reacciona al ciclo de vida del modelo (`after_create_commit`) para enviar payloads JSON a servidores de terceros de forma asíncrona, implementando políticas de reintento (*Exponential Backoff*).

---

## 🗄️ Modelo de Datos (Esquema)

El ecosistema relacional está compuesto por 5 entidades principales, garantizando integridad referencial:
1. **Professor:** Docentes que reportan incidencias.
2. **Laboratory:** Espacios físicos que albergan los equipos.
3. **Computer:** Equipos asignados a un laboratorio.
4. **Component:** Partes específicas (Teclado, Mouse, etc.) que pertenecen a un computador.
5. **Report:** El núcleo transaccional. Registra el evento, asociando al Profesor, el Computador afectado y el Laboratorio.

---

## 🛠️ Instrucciones para Evaluadores Técnicos (DX)

### 1. Entorno de Producción
La API se encuentra desplegada y lista para ser consumida.
* **Base URL:** `https://lab-management-il0o.onrender.com`

### 2. Autenticación
Todas las peticiones deben incluir el header de autorización.
* **Header:** `Authorization: Bearer <TU_TOKEN_SECRETO>`

### 3. Ejemplos de Consumo (cURL)

**A. Obtener la primera página de reportes (Límite dinámico):**
Esta petición demuestra el uso de Eager Loading, trayendo la data anidada de computadores y laboratorios sin saturar la base de datos.
```bash
curl -H "Authorization: Bearer TU_TOKEN_SECRETO" "https://lab-management-il0o.onrender.com/api/v1/reports"
```
**B. Navegación por Paginación (@nextLink):**
```bash
curl -H "Authorization: Bearer TU_TOKEN_SECRETO" "https://lab-management-il0o.onrender.com/api/v1/reports?page=2&per_page=5"
```
**C. Prueba de Resiliencia (Manejo de Errores - 401 Unauthorized):**
```bash
curl -H "Authorization: Bearer TOKEN_FALSO" "https://lab-management-il0o.onrender.com/api/v1/reports"
```

---

## 🌱 Configuración Local y Semillas (Testing)

Para ejecutar el proyecto localmente y probar la integridad del sistema con datos realistas:

### Clonar el repositorio e instalar dependencias:
```bash
git clone https://github.com/cmaestrei-dev/lab_management.git

cd lab_management

bundle install
```

### Preparar y poblar la base de datos:
El proyecto incluye un script robusto que genera 5 Profesores, 3 Laboratorios, 15 Computadores, 30 Componentes y 35 Reportes para probar correctamente la paginación y los Webhooks.
```bash
rails db:create db:migrate db:seed
```

### Iniciar el servidor local:
```bash
rails server
```
