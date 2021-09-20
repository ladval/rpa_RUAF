
#Cantidad de peticiones
$Global:intentosRequest = 3
#Segundos entre intentos (Segundos)
$Global:intervaloRequest = 2
#TimeOut request (Segundos)
$Global:timeoutRequest = 7

############################################################################################################################################################
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.38"
$session.Cookies.Add((New-Object System.Net.Cookie("cookiesession1", "678B769COQRSTVWXZACEGHJKMOQR6F42", "/", "ruaf.sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("_ga", "GA1.3.717280511.1631197249", "/", ".sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gid", "GA1.3.1761455596.1631197249", "/", ".sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("ai_user", "gXwT9|2021-09-09T14:28:10.235Z", "/", "ruaf.sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("ASP.NET_SessionId", "rfczwed2oessut5xnfs5ezcx", "/", "ruaf.sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("__AntiXsrfToken", "01d0c1cf76bf41359e3990b97fccf3dc", "/", "ruaf.sispro.gov.co")))
$session.Cookies.Add((New-Object System.Net.Cookie("_gat_gtag_UA_114119674_1", "1", "/", ".sispro.gov.co")))
############################################################################################################################################################
function TerminosCondiciones {
    param (
        $session
    )
    $i = 0
    while ($true) {
        try {
            Write-Host "Cargando página de términos y condiciones RUAF" -ForegroundColor Green
            $fileTC = "$PSScriptRoot\files\TerminosCondiciones.html"
            $urlTC = "https://ruaf.sispro.gov.co/TerminosCondiciones.aspx"
            $requestTC = Invoke-WebRequest -Uri $urlTC -TimeoutSec $timeoutRequest `
                -WebSession $session
            SaveData $fileTC $($requestTC.Content)
            $arrayParamsTC = _ExtractBodyParams $($fileTC)
            return $arrayParamsTC
        }
        catch {
            $i = $i + 1
            if ($i -eq $intentosRequest) {
                Write-Host "Límite de intentos excedidos" -ForegroundColor Red
                Return $false
            }
            else {
                $ignition = Invoke-WebRequest -Uri $urlTC
                Write-Host "Reiniciando instancia: $($ignition.StatusDescription)" -ForegroundColor Gray
                $errorMessage = "ERROR[$_]`nIntento: $i"
                $errorMessage = $errorMessage -replace "`n", "" -replace "`r", ""
                Write-Host  $errorMessage -ForegroundColor Red
                Start-Sleep -s $intervaloRequest
            }
        }
    }
}
############################################################################################################################################################
function TerminosCondiciones_OK {
    param (
        $session,
        $params
    )

    $TC_viewState = $params[0]
    $TC_viewStateGenerator = $params[1]
    $TC_eventValidation = $params[2]
    $urlTC_OK = "https://ruaf.sispro.gov.co/TerminosCondiciones.aspx"
    $fileTC_OK = "$PSScriptRoot\files\TerminosCondicionesOK.html"
    $bodyCondiciones = @{
        '__EVENTTARGET'                      = ''
        '__EVENTARGUMENT'                    = ''
        '__VIEWSTATE'                        = $TC_viewState
        '__VIEWSTATEGENERATOR'               = $TC_viewStateGenerator
        '__EVENTVALIDATION'                  = $TC_eventValidation
        'ctl00$MainContent$RadioButtonList1' = '1'
        'ctl00$MainContent$btnEnviar'        = 'Enviar'
    }
    $i = 0
    while ($true) {
        try {
            Write-Host "Aceptando términos y condiciones" -ForegroundColor Green
            $requestTC_OK = Invoke-WebRequest -UseBasicParsing -Uri $urlTC_OK -TimeoutSec $timeoutRequest `
                -Method "POST" `
                -WebSession $session `
                -Headers @{
                "Sec-Fetch-Mode"  = "navigate"
                "Sec-Fetch-User"  = "?1"
                "Sec-Fetch-Dest"  = "document"
                "Referer"         = "https://ruaf.sispro.gov.co/TC.aspx"
                "Accept-Encoding" = "gzip, deflate, br"
                "Accept-Language" = "es,es-ES;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6,it;q=0.5"
            } `
                -ContentType "application/x-www-form-urlencoded" `
                -Body $bodyCondiciones
            SaveData $fileTC_OK $($requestTC_OK.Content)
            $arrayParamsTC_OK = _ExtractBodyParams $($fileTC_OK)
            return $arrayParamsTC_OK
        }
        catch {
            $i = $i + 1
            if ($i -eq $intentosRequest) {
                Write-Host "Límite de intentos excedidos" -ForegroundColor Red
                Return $false
            }
            else {
                $ignition = Invoke-WebRequest -Uri $urlTC_OK
                Write-Host "Reiniciando instancia: $($ignition.StatusDescription)" -ForegroundColor Gray
                $errorMessage = "ERROR[$_]`nIntento: $i"
                $errorMessage = $errorMessage -replace "`n", "" -replace "`r", ""
                Write-Host  $errorMessage -ForegroundColor Red
                Start-Sleep -s $intervaloRequest
            }
        }
    }
}
############################################################################################################################################################
function FiltroRuaf {
    param (
        $session,
        $TC_OK_Params,
        $idUsuario,
        $fechaExpedicion        
    )
    $filtro_viewState = $TC_OK_Params[0]
    $filtro_viewStateGenerator = $TC_OK_Params[1]
    $filtro_eventValidation = $TC_OK_Params[2]
    $fileFiltro = "$PSScriptRoot\files\filtro.html"
    $urlFiltro = "https://ruaf.sispro.gov.co/Filtro.aspx"
    $bodyFiltro = @{
        '__EVENTTARGET'                             = ''
        '__EVENTARGUMENT'                           = ''
        '__VIEWSTATE'                               = $filtro_viewState
        '__VIEWSTATEGENERATOR'                      = $filtro_viewStateGenerator
        '__EVENTVALIDATION'                         = $filtro_eventValidation
        'ctl00$MainContent$ddlTiposDocumentos'      = '5|CC'
        'ctl00$MainContent$txbNumeroIdentificacion' = $idUsuario
        'ctl00$MainContent$datepicker'              = $fechaExpedicion
        'ctl00$MainContent$btnConsultar'            = 'Consultar'
    }
    $i = 0
    while ($true) {
        try {
            Write-Host "Consultando usuario con c.c. $idUsuario y fecha expedición $fechaExpedicion" -ForegroundColor Green
            $requestFiltro = Invoke-WebRequest -UseBasicParsing -Uri $urlFiltro -TimeoutSec $timeoutRequest `
                -Method "POST" `
                -WebSession $session `
                -ContentType "application/x-www-form-urlencoded" `
                -Body $bodyFiltro
            SaveData $fileFiltro $($requestFiltro.Content)
            $filtroData = ReadData $fileFiltro
            Return $filtroData
        }
        catch {
            $i = $i + 1
            if ($i -eq $intentosRequest) {
                Write-Host "Límite de intentos excedidos" -ForegroundColor Red
                Return $false
            }
            else {
                $ignition = Invoke-WebRequest -Uri $urlFiltro
                Write-Host "Reiniciando instancia: $($ignition.StatusDescription)" -ForegroundColor Gray
                $errorMessage = "ERROR[$_]`nIntento: $i"
                $errorMessage = $errorMessage -replace "`n", "" -replace "`r", ""
                Write-Host  $errorMessage -ForegroundColor Red
                Start-Sleep -s $intervaloRequest
            }
        }
    }
}
############################################################################################################################################################
function uploadInfo() {
    param (
        $bodyResponse
    )
    Invoke-RestMethod -Uri "http://localhost/rpa_ruaf/procesos/actualizar" `
        -Method POST `
        -Body $bodyResponse
}
############################################################################################################################################################