<# :
  @echo off
    powershell /nologo /noprofile /command ^
         "&{[ScriptBlock]::Create((cat """%~f0""") -join [Char[]]10).Invoke(@(&{$args}%*))}"
  exit /b
#>

Write-Host "Script para remoção do certificado expirado" -ForegroundColor Red
$store = new-object system.security.cryptography.x509certificates.x509Store 'Root','LocalMachine'
$store.Open('ReadWrite')
$certs = @(dir cert:\LocalMachine\Root | ? { $_.Subject -like '*DST*' })
Write-Host "Entrando nos certificados de raiz confiavel" -ForegroundColor White
foreach ($cert in $certs) 
{ 
    Write-Host "Certificado Localizado"
    $store.Remove($cert)
    Write-Host "Certificado Removido" -ForegroundColor Green
}
$store.close() 
Write-Host "Loja fechada..." -ForegroundColor White

$store = new-object system.security.cryptography.x509certificates.x509Store 'AuthRoot','LocalMachine'
$store.Open('ReadWrite')
$certs = @(dir cert:\LocalMachine\AuthRoot | ? { $_.Subject -like '*DST*' })
Write-Host "Entrando nos certificados de raiz terceira"
foreach ($cert in $certs) 
{ 
    Write-Host "Certificado Localizado"
    $store.Remove($cert)
    Write-Host "Certificado Removido" -ForegroundColor Green
}
$store.close() 
Write-Host "Segunda Loja fechada..."  -ForegroundColor White

Write-Host "Fim do script"

timeout /t 4 /nobreak

## brazilian - 15/08/2022
