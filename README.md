# ✨ Reflecta Daily

> Tu espejo espiritual diario — impulsado por IA, guiado por fe.

**Reflecta Daily** es la primera herramienta de Reflecta AI, una plataforma diseñada para jóvenes cristianos que buscan crecer en disciplina, conocimiento y propósito.

---

## ¿Qué hace?

El usuario escribe o habla sobre su día, y la IA responde con:

- 🪞 **Reflexión profunda** personalizada
- 📖 **Versículo bíblico** relevante al momento
- 💡 **Insight espiritual** práctico
- 🎯 **Plan de acción** con 3 pasos concretos

---

## Creador

**Carlos Sandoval** — Escritor, creador de contenido y fundador de Reflecta AI.

> *"Si con una sola frase puedo tocar un corazón y acercarlo más a Dios, entonces estoy cumpliendo mi llamado."*

Autor de **Volver a Empezar** y mensajero con propósito. Inspirado en la Palabra de Dios, crea herramientas que combinan tecnología avanzada con valores bíblicos.

🌐 [reflecta.zone](https://reflecta.zone) · Desarrollado con IA · © 2026 Carlos Sandoval

---

## Stack Técnico

| Capa | Tecnología |
|---|---|
| Frontend | Flutter (Web + Mobile) |
| Backend | Firebase (Auth, Firestore) |
| Arquitectura | Clean Architecture |
| IA | Groq — llama-3.3-70b-versatile |
| Estado | Riverpod |
| Navegación | GoRouter |
| Entorno | GitHub Codespaces |

---

## Estructura del Proyecto

```
lib/
├── core/
│   ├── constants/      # Constantes globales
│   ├── errors/         # Failures tipados
│   ├── router/         # GoRouter + auth guard
│   └── theme/          # Colores navy + gold, Nunito
├── features/
│   ├── auth/           # Login Google + Email/Password
│   ├── about/          # Perfil del creador
│   ├── onboarding/     # Primera experiencia (v1.1)
│   └── daily_reflection/
│       ├── data/       # GroqService + Firestore
│       ├── domain/     # Entidades + repositorio abstracto
│       └── presentation/ # Pages + Riverpod providers
└── main.dart
```

---

## Cómo empezar (Codespace)

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Correr en web
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
```

---

## Variables de entorno (.env)

```env
GROQ_API_KEY=tu_key_de_groq
FIREBASE_API_KEY=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_PROJECT_ID=...
FIREBASE_STORAGE_BUCKET=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_APP_ID=...
```

---

## Branding

- **Colores:** Azul marino `#0D1B3E` + Dorado `#F5C842`
- **Tipografía:** Nunito
- **Dominio:** [reflecta.zone](https://reflecta.zone)
