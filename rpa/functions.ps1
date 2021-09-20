





#Almacena información de la petición en un archivo
function SaveData {
    param (
        [string]$path,
        [string]$content
    )
    If (Test-Path -Path $path ) {
        # Remove-Item -Path $path 
        Start-Sleep -s 1
    }
    Set-Content -Path $path -Value $content
}

#Realiza la lectura de la información de un archivo
function ReadData {
    param (
        [string]$path
    )
    $content = Get-Content -Path $path
    return $content
}

function dataToCSV {
    param(
        $data
    )
    $csv_string = ""
    for ($i = 0; $i -lt $data.Count; $i++) {
        $csv_string += "$($data[$i]),"
    }
    $response = $csv_string.Substring(0, ($csv_string.Length - 1))
    return $response
}

#Extrae los valores token de cada segmento
function _ExtractBodyParams() {
    param (
        [string]$filePath
    )
    $content = ReadData $filePath
    Write-Host "[Ejecutando lectura de parámetros]" -ForegroundColor Yellow
    $IDs = @("__VIEWSTATE", "__VIEWSTATEGENERATOR", "__EVENTVALIDATION")
    $sIDS = @()
    for ($i = 0; $i -lt $IDs.Count; $i++) {
        $firstString = 'id="' + $($IDs[$i]) + '" value="'
        $secondString = '" />'
        $pattern = "$firstString(.*?)$secondString"
        $result = [regex]::Match($content, $pattern).Groups[1].Value
        $sIDS += $result
    }
    $viewState = $sIDS[0]
    $viewStateGenerator = $sIDS[1]
    $eventValidation = $sIDS[2]
    $response = @($viewState, $viewStateGenerator, $eventValidation)
    return $response
} 


