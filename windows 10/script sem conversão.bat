<# :
  @echo off
    powershell /nologo /noprofile /command ^
         "&{[ScriptBlock]::Create((cat """%~f0""") -join [Char[]]10).Invoke(@(&{$args}%*))}"
  exit /b
#>
Write-Host
Write-Host *** Script para Remover - DST Root CA X3 - Brazilian ***, $args[0] -fo Red
Write-Host [~] Iniciando em 3 segundos..., $args[0] -fo Red
Write-Host
Start-Sleep -Milliseconds 3000

Get-ChildItem Cert:\LocalMachine\Root\dac9024f54d8f6df94935fb1732638ca6ad77c13 | Remove-Item
Write-Host [+] Certificado removido., $args[0] -fo Green
Start-Sleep -Milliseconds 3000

## brazilian - 19/05/2022