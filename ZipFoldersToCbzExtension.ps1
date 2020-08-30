# this will remain unfinished for now since I don't feel like installing PowerShell 6+
# will just use 7-Zip
$folders = Get-ChildItem $Path -Directory
foreach ($folder in $folders) {
    $folderName = $folder.Name
    $destinationPath = Join-Path -Path . -ChildPath "$folderName.zip"
    $compress = @{
        Path = $folder
        CompressionLevel = "Fastest"
        DestinationPath = $destinationPath
    }
    # the -PassThru parameter lets it return a FileInfo object, but it's only in PowerShell 6+, which I don't have!
    $compressedFile = Compress-Archive @compress -PassThru
    # Here, I will want to rename it from .zip to .cbz

    Write-Host $destinationPath
}