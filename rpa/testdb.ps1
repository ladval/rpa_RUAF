$bodyExpedicion = @{
    "cedula" = $($dbData.$i).$cedula
}
$expedicionDate = Invoke-RestMethod -Uri "http://localhost/rpa_ruaf/procesos/expedicion" `
    -Method POST `
    -Body $bodyExpedicion 
$expedicionDate = $($expedicionDate.0).ANIFchExpedicion
$expedicionDate = $expedicionDate.Split('-')
$expedicionDate = "$($expedicionDate[2])/$($expedicionDate[1])/$($expedicionDate[0])"
$expedicionDate