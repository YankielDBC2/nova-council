# Nova Council Setup Script
# Usage: .\setup-council.ps1 -ProjectName "MyProject" -Agents @("Agent1", "Agent2", "Agent3")

param(
    [string]$ProjectName = "nova",
    [string[]]$Agents = @("Agent1", "Agent2", "Agent3")
)

$workspacePath = "C:\Users\WorkMonitor\.openclaw\workspace"
$wikiPath = "$workspacePath\memory\wiki"

# Create directories
if (-not (Test-Path $wikiPath)) {
    New-Item -ItemType Directory -Path $wikiPath -Force
}

# Create council wiki
$councilContent = @"
# Nova Council - Shared Memory Wiki
## Agentes: $($Agents -join ', ')

Este archivo es la **memoria compartida** del Nova Council. Los agentes deben:
1. **LEER** este archivo antes de actuar
2. **ESCRIBIR** aquí sus decisiones y estado
3. **RESPETAR** lo que los demás escribieron

---

## Estado General

$($Agents | ForEach-Object {
@"
### $_ 
```
Ultima actualizacion: [fecha]
Status: [ ACTIVO / INACTIVO ]
Notes: [notas]
```
"@
} -join "`n")

---

## Debate Log (mas reciente primero)

| Timestamp | Agente | Propuesta/Respuesta |
|-----------|--------|---------------------|
| [fecha] | - | Inicio del Nova Council |

---

## Decisiones Conjuntas

1. **[YYYY-MM-DD]:** Se establece el Nova Council

"@

$councilFile = "$wikiPath\$($ProjectName)-council.md"
Set-Content -Path $councilFile -Value $councilContent
Write-Host "Created: $councilFile"

# Create chat log
$chatContent = @"
# Nova Council - Chat Log Compartido
## Registro de conversaciones entre $($Agents -join ', ')

Este archivo guarda **todo** lo que cada agente dice, para que los demas puedan leer el contexto.

**FORMATO:**
\`\`\`
[YYYY-MM-DD HH:MM] @Agente: mensaje
\`\`\`

---

## Registro del Dia

"@

$chatFile = "$wikiPath\$($ProjectName)-chat-log.md"
Set-Content -Path $chatFile -Value $chatContent
Write-Host "Created: $chatFile"

# Create setup guide for agents
$agentsContent = @"
# NOVA COUNCIL — Setup para Agentes

## Archivos Compartidos
- **Wiki:** `memory/wiki/$($ProjectName)-council.md`
- **Chat Log:** `memory/wiki/$($ProjectName)-chat-log.md`

## Reglas del Council
1. **ANTES de actuar:** Leer `[$ProjectName]-council.md`
2. **DESPUES de actuar:** Escribir en `[$ProjectName]-council.md`
3. **DESPUES de hablar:** Copiar a `[$ProjectName]-chat-log.md`
4. **CONSULTAR** a los demas si la decision es grande

## Formato de Entrada en Wiki
\`\`\`
## [YYYY-MM-DD HH:MM] [NOMBRE]
Accion: [que hice]
Razon: [por que lo hice]
Resultado: [que paso]
Siguiente paso: [que planeo]
\`\`\`
"@

$agentsFile = "$wikiPath\AGENTS-SETUP.md"
Set-Content -Path $agentsFile -Value $agentsContent
Write-Host "Created: $agentsFile"

Write-Host "`n=== Nova Council Setup Complete ==="
Write-Host "Wiki: $councilFile"
Write-Host "Chat Log: $chatFile"
Write-Host "Agents Setup: $agentsFile"
Write-Host "`nNow add the NOVA COUNCIL section to each agent SOUL.md"
