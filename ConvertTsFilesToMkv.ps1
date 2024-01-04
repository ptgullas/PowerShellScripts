# Run this like so:
# .\ConvertTsFilesToMkv.ps1 'pathToFolder'
function Run-Ffmpeg($filePathWithoutExtension) {
    & 'C:\MiscApps\ffmpeg\bin\ffmpeg.exe' -i "${filePathWithoutExtension}.ts" -c copy "${filePathWithoutExtension}.mkv"
}

function Display-Filename($filenameWithoutExtension) {
    Write-Host "This is going to convert ${filenameWithoutExtension}.ts to ${filenameWithoutExtension}_output.mkv"
}

$myPath = $args[0]
Write-Host 'Starting!'
$tsFilesInFolder = Get-Childitem $myPath -filter "*.ts"
foreach ($tsFile in $tsFilesInFolder) {
    $filenameWithoutExtension = Split-Path $tsFile -LeafBase
    $filePathWithoutExtension = Join-Path -Path $myPath -ChildPath $filenameWithoutExtension
    Run-Ffmpeg($filePathWithoutExtension)
}