function wsItemWidth {
    param (
        $item,
        $width,
        $criteria
    )
    $width = 'min-width: ' + $width + 'mm;">'
    if ($item.Contains($width)) {
        if (-Not $item.Contains($criteria)) {
            $extractedValue = [regex]::Match($item, "$width(.*?)</div>").Groups[1].Value
            $extractedValue = $extractedValue.Replace(',', '.')
            $extractedValue = $extractedValue.Replace('&#193;', "Á")
            $extractedValue = $extractedValue.Replace('&#201;', "É")
            $extractedValue = $extractedValue.Replace('&#205;', "Í")
            $extractedValue = $extractedValue.Replace('&#211;', "Ó")
            $extractedValue = $extractedValue.Replace('&#218;', "Ú")
            $extractedValue = $extractedValue.Replace('&#209;', "Ñ")
            $extractedValue = $extractedValue.Replace('&#225;', "á")
            $extractedValue = $extractedValue.Replace('&#233;', "é")
            $extractedValue = $extractedValue.Replace('&#237;', "í")
            $extractedValue = $extractedValue.Replace('&#243;', "ó")
            $extractedValue = $extractedValue.Replace('&#250;', "ú")
            $extractedValue = $extractedValue.Replace('&#241;', "ñ")
            return $extractedValue
        }
    }
}

function ws_data {
    param (
        $data
    )
    $firstString = 'id="ctl00_MainContent_rvConsulta_ctl13_ReportControl_ctl04" value="100" /><div style="display:none;">'
    $secondString = '</div><div id="ctl00_MainContent_rvConsulta_ctl13_NonReportContent" style="height:100%;width:100%;">'
    $pattern = "$firstString(.*?)$secondString"
    $result = [regex]::Match($data, $pattern).Groups[1].Value
    $arrayResponse = @()
    $fileFiltro = "$PSScriptRoot\files\filtro.html"
    SaveData $fileFiltro $result
    $dataFiltro = ReadData $fileFiltro
    $arrayDataFiltro = $dataFiltro -Split "cannotShrinkTextBoxInTablix"
    foreach ($item in $arrayDataFiltro) {
        $arrayCoords = @(
            #InfoBasica
            "41.95|Primer",
            "41.55|Segundo",
            "44.86|Primer",
            "47.44|Segundo",
            "28.45|Sexo",
            #Salud
            "45.17|Administradora",
            "44.27|R&#233;gimen",
            "23.24|Fecha" ,
            "26.09|Estado",
            "36.53|Tipo" ,
            "66.78|Departamento",
            #Pensiones
            "75.75|R&#233;gimen",
            "63.08|Administradora",
            "44.32|Fecha",
            "62.34|Estado",
            #Riesgos
            "70.57|Administradora",
            "26.22|Fecha",
            "24.44|Estado",
            "84.68|Actividad",
            "37.93|Labora",
            #CajaCompensacion
            "61.62|Administradora",
            "23.33|Fecha",
            "23.56|Estado",
            "53.56|Miembro",
            "39.12|Afiliado",
            "40.87|Labora")
        for ($i = 0; $i -lt $arrayCoords.Count; $i++) {   
            $coordsData = $arrayCoords[$i].Split('|')
            $coords = $coordsData[0]
            $checkStr = $coordsData[1]
            $itemFiltro = wsItemWidth $item $coords $checkStr
            if ($itemFiltro.Length -gt 0) {
                $arrayResponse += $itemFiltro
            }
        }
    }
    return $arrayResponse
}




