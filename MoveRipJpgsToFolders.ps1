# param should be a filename with the format "rip20200827202300_005_4bae061085183114.jpg"
function Get-BatchName($jpgName) {
    $jpgSplit = $jpgName.Split('_')
    $batchName = $jpgSplit[0].Substring(3)
    return $batchName
}

function CreateFolderIfDoesNotExist($batchName) {
    $pathToCreate = Join-Path -Path . -ChildPath $batchName
    If(!(Test-Path $pathToCreate)) {
        $newBatchFolder = New-Item -Path . -Name $batchname -ItemType "directory"
        Write-Host "Created $pathToCreate" -ForegroundColor White -BackgroundColor DarkMagenta
    }
    return $pathToCreate
}

# My very first PowerShell script
$jpgsInFolder = Get-Childitem $Path -filter "*.jpg"
foreach ($jpg in $jpgsInFolder) {
    $batchname = Get-BatchName $jpg.Name
    $newFolder = CreateFolderIfDoesNotExist($batchname)
    Move-Item -Path $jpg -Destination $newFolder
}
