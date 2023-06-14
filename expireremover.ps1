Write-host "script para remover certificados expirados do windows (dst root ca x3)"
Write-Host "1 - para iniciar"
Write-Host "2 - para sair"
$escolha = Read-Host -Prompt "escolha: "
$hash = "DAC9024F54D8F6DF94935FB1732638CA6AD77C13" 
$serie = "44afb080d6a327ba893039862ef8406b"

if($escolha -eq "1") {
    Write-Host "procurando pelo certificado..."
    $achou = Get-ChildItem -Path Cert:\CurrentUser\AuthRoot\ | Where-Object {$_.Thumbprint -eq $hash}
    if($achou.Thumbprint -eq $hash) {
        Write-Host "certificado encontrado"
        $certificado = Get-Item (Get-ChildItem -Path Cert:\CurrentUser\AuthRoot\ | Where-Object {$_.Thumbprint -eq $hash}).PSPath
        Write-Host $certificado.Thumbprint
        Write-Host $certificado.SerialNumber
        Write-Host $certificado.Subject
        $escolha2 = Read-Host -Prompt "remover? y/n: "
        if($escolha2.Thumbprint -eq "y") {
            if ($certificado.Thumbprint -eq $hash) {
                if($certificado.SerialNumber -eq $serie) {
                    $certificado | Remove-Item
                    Write-Host "certificado removido com sucesso!"
                }
            } else {
                Write-Host "ocorreu um erro ao validar o hash."
            }
        } else {
            Write-Host "saindo..."
        }
    } else {
        Write-Host "o certificado não foi encontrado saindo."
    }
}