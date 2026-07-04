# ✨ Reflecta Daily
> Tu espejo espiritual diario — impulsado por IA, guiado por fe.

**Reflecta Daily** es la primera herramienta de Reflecta AI, una plataforma diseñada para jóvenes cristianos que buscan crecer en disciplina, conocimiento y propósito.

---

## 🌐 App en producción

**https://reflecta-daily.web.app** · **https://reflecta.zone** (propagando)

---

## ✝️ Creador

**Carlos Sandoval** — Escritor, creador de contenido y fundador de Reflecta AI.

> *"Si con una sola frase puedo tocar un corazón y acercarlo más a Dios, entonces estoy cumpliendo mi llamado."*

Autor de **Volver a Empezar**. Inspirado en la Palabra de Dios, crea herramientas que combinan tecnología avanzada con valores bíblicos.

🌐 [reflecta.zone](https://reflecta.zone) · Desarrollado con IA · © 2026 Carlos Sandoval

---

## ¿Qué hace?

El usuario escribe o habla sobre su día y la IA responde con:

- 🪞 **Reflexión profunda** personalizada
- 📖 **Versículo bíblico** relevante al momento
- 💡 **Insight espiritual** práctico
- 🎯 **Plan de acción** con 3 pasos concretos

---

## Stack Técnico

| Capa | Tecnología |
|---|---|
| Frontend | Flutter Web |
| Backend | Firebase (Auth, Firestore, Hosting) |
| Arquitectura | Clean Architecture |
| IA | Groq — llama-3.3-70b-versatile |
| Estado | Riverpod |
| Navegación | GoRouter |
| Voz | speech_to_text |
| Animaciones | flutter_animate |
| Entorno | GitHub Codespaces |

---

## Pantallas

| Pantalla | Descripción |
|---|---|
| Login | Google + Email/Password |
| Onboarding | Primera experiencia + nombre |
| Home | Saludo dinámico + racha real |
| Reflection | Textarea + dictado por voz |
| Result | 4 cards IA + guardar en Firestore |
| History | Historial con detalle en bottom sheet |
| Profile | Nombre, foto, racha, recordatorio |
| About | Perfil de Carlos Sandoval |

---

## Estructura
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── router/         # GoRouter + auth guard + onboarding guard
│   └── theme/          # Navy #0D1B3E + Gold #F5C842, Nunito
├── features/
│   ├── auth/           # Firebase Auth
│   ├── about/          # Perfil Carlos Sandoval
│   ├── onboarding/     # Primera experiencia
│   ├── profile/        # Perfil + racha real
│   ├── notifications/  # Recordatorio diario
│   ├── history/        # Historial de reflexiones
│   └── daily_reflection/
│       ├── data/       # GroqService + Firestore
│       ├── domain/     # Entidades + repositorio
│       └── presentation/
└── main.dart
---

## Variables de entorno (.env)

```env
GROQ_API_KEY=...
FIREBASE_API_KEY=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_PROJECT_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_APP_ID=...
```

---

## Comandos

```bash
# Desarrollo
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0

# Build producción
flutter build web --release --no-web-resources-cdn

# Deploy
firebase deploy --only hosting --token $FIREBASE_TOKEN
```

---

## Branding

- **Colores:** Azul marino `#0D1B3E` + Dorado `#F5C842`
- **Tipografía:** Nunito
- **Dominio:** [reflecta.zone](https://reflecta.zone)
- **Desarrollado con IA** · © 2026 Carlos Sandoval

