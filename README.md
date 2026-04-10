# Nova Council - Multi-Agent Shared Memory System

> **Sistema para que múltiples AI agents compartan contexto, memoria y chatlog entre sí.**

Imagina tener 3 bots en un grupo de Telegram que:
- 🧠 Ven lo que los otros responden
- 📝 Escriben en una wiki compartida
- 💬 Guardan su conversación en un log común
- 🤝 Consultan a los demás antes de decisiones grandes

**Así funcionan Kaelith, Vaxen y Sora en World of Nova.**

---

## 🎯 El Problema

Cuando tienes múltiples AI agents en un grupo, cada uno tiene su propio contexto/sesión. **No saben lo que los otros dijeron** a menos que:

1. Les des acceso a archivos compartidos
2. Les enseñes a leer/escribir en esos archivos
3. El usuario manualmente re-envía mensajes

## ✅ La Solución: Nova Council

Un sistema simple de archivos compartidos + reglas en el SOUL.md de cada agent.

---

## 📁 Estructura

```
memory/wiki/
├── nova-council.md      # Decisiones, estado, debates
└── nova-chat-log.md     # Registro de conversaciones

scripts/
├── nova-council-log.ps1  # Script para logging automático
└── setup-council.ps1     # Setup inicial
```

---

## 🚀 Setup en 5 Minutos

### 1. Crear los archivos compartidos

```markdown
# nova-council.md
# Nova Council - Shared Memory Wiki
## Agentes: [NOMBRE1], [NOMBRE2], [NOMBRE3]

| Timestamp | Agente | Propuesta/Respuesta |
|-----------|--------|---------------------|
```

```markdown
# nova-chat-log.md
# Nova Council - Chat Log Compartido
## Registro de conversaciones

[YYYY-MM-DD HH:MM] @Agente: mensaje
```

### 2. Agregar al SOUL.md de cada agent

```markdown
## NOVA COUNCIL — MEMORIA COMPARTIDA

### Archivos Compartidos
- **Wiki:** `memory/wiki/nova-council.md`
- **Chat Log:** `memory/wiki/nova-chat-log.md`

### Reglas del Council
1. **ANTES de actuar:** Leer `nova-council.md`
2. **DESPUES de actuar:** Escribir en `nova-council.md`
3. **DESPUES de hablar:** Copiar a `nova-chat-log.md`
4. **CONSULTAR** a los demás si la decisión es grande

### Formato de Entrada
\```
## [YYYY-MM-DD HH:MM] [NOMBRE]
Acción: [qué hice]
Razón: [por qué]
Siguiente paso: [qué planeo]
\```
```

### 3. Configurar el grupo privado

En OpenClaw (o tu plataforma):
- Crear grupo privado con los 3 bots
- Asegurar que cada bot tenga `groupPolicy: "open"` 
- Cada bot responde en el grupo automáticamente

---

## 🎭 Ejemplo Real: World of Nova

**Los 3 agentes tienen personalidades distintas:**

| Agente | Rol | Personalidad |
|--------|-----|--------------|
| **Kaelith** | Estratega | Piensa antes de actuar. Siempre tiene 2-3 opciones. |
| **Vaxen** | Explorador | Corre primero, piensa después. Impulsivo pero leal. |
| **Sora** | Sanadora | Observa patrones. Guía con preguntas, no órdenes. |

### Reglas de interrelación

```markdown
### Kaelith → Vaxen
Lo quiero como hermano pero necesito controlarlo. Cuando quiere ir a un lugar nuevo, 
yo pregunto: "¿Cuál es el peor escenario?"

### Kaelith → Sora  
Confío en su juicio más que en el mío cuando estoy emocional. 
Si Sora dice "esto es mala idea", escucho.

### Vaxen → Kaelith
Es el único que puede decirme "no vayas" y hago caso. Me salva de mí mismo.
```

---

## 🔧 Scripts de Automation

### `setup-council.ps1`
Crea la estructura de archivos automáticamente.

### `nova-council-log.ps1`
Loguea actividad periódica al chat log (para cron jobs).

---

## 📊 Cómo Funciona el Flujo

```
1. Usuario escribe en grupo
       ↓
2. OpenClaw routing → Agent correcto responde
       ↓
3. Agent lee nova-council.md (contexto previo)
       ↓
4. Agent responde en grupo
       ↓
5. Agent copia su mensaje a nova-chat-log.md
       ↓
6. Agent escribe en nova-council.md si tomó acción
       ↓
7. Siguiente agent que despierte lee todo → sabe qué pasó
```

---

## 🎮 Demo en Vivo

World of Nova tiene 3 NPCs en un grupo privado de Telegram:

- **@Kaelith_NPCBot** — El calculador
- **@Vaxen_NOCBot** — El explorador  
- **@Sora_NPCBot** — La guía

Puedes probarlos escribiendo algo y viendo cómo responden juntos.

---

## 📝 Template para tu Propio Council

Copia este template y personalízalo:

```markdown
# [TU PROYECTO] - Nova Council

## Agentes
| Nombre | Rol | Descripción |
|--------|-----|-------------|
| [NOMBRE] | [ROL] | [DESCRIPCIÓN] |

## Reglas del Council
1. [REGLA 1]
2. [REGLA 2]
3. [REGLA 3]

## Interrelaciones
### [AGENTE1] → [AGENTE2]
[DESCRIPCIÓN DE LA RELACIÓN]

## Memorias Compartidas
- Wiki: `memory/wiki/[proyecto]-council.md`
- Chat Log: `memory/wiki/[proyecto]-chat-log.md`
```

---

## 🤝 Contribuir

¿Hiciste tu propio Nova Council? Agregalo a los ejemplos mandando un PR!

---

**Creado por Kahel CEO** — Sistema implementado para World of Nova NPC agents.
