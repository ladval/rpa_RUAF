[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 <# using TLS 1.2 is vitally important #>
."$PSScriptRoot\functions.ps1"
."$PSScriptRoot\webRequests.ps1"
."$PSScriptRoot\webScrapping.ps1"


function RUAF() {
    $dbData = Invoke-RestMethod -Uri "http://localhost/rpa_ruaf/procesos" -Method GET -ContentType "application/json"
    $dbDataObj = $dbData | Get-Member -MemberType NoteProperty
    for ($i = 0; $i -lt $dbDataObj.Count; $i++) {
        $TC_Params = TerminosCondiciones $session
        if ($TC_Params) {
            $TC_OK_Params = TerminosCondiciones_OK $session $TC_Params
            if ($TC_OK_Params) {
                $dataRuaf = FiltroRuaf $session $TC_OK_Params $($dbData.$i).cc $($dbData.$i).expedicion
                if ($dataRuaf) {
                    $data = ws_data $dataRuaf
                    if ($data.Length -gt 0) {
                        $response = dataToCSV $data
                        $status = 1
                    }
                    else {
                        $response = 'Sin resultados'
                        $status = 1
                    }
                }
                else {
                    $response = 'Tiempo de espera excedido:  Respuesta de consulta de datos RUAF'
                    $status = 0
                }
            }
            else {
                $response = 'Tiempo de espera excedido:  Aceptación de términos y condiciones RUAF'
                $status = 0
            }
        }
        else {
            $response = 'Tiempo de espera excedido:  Cargue de términos y condiciones RUAF'
            $status = 0
        }
        $bodyResponse = @{
            "id_usuario" = $($dbData.$i).uid
            "status"     = $status
            "response"   = $response
        }
        $uploadInfo = uploadInfo $bodyResponse 
        if ($uploadInfo -eq 1) {
            Write-Host "Datos actualizados correctamente"  -ForegroundColor Yellow   
        }
        else {
            Write-Host "Error actualizando datos. Por favor verificar `n $_"  -ForegroundColor DarkRed   
        }
    }
}



while ($true) {
    RUAF
    Start-Sleep -s 300
}