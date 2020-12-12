# accepts an input filename, which is a CSV where each element is wrapped in double quotation marks
# The last element on each line is a file path. It should replace the directory with "C:\\autoimportinputfiles\",
# This performs this replacement for each line, then save as a new file
$inputFile = $args[0]
$baseInputFileName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
$outputFileName = $baseInputFileName + "_new.txt"
$inputFolder = [System.IO.Path]::GetDirectoryName($inputFile)

$outputPath = Join-Path -Path $inputFolder -ChildPath $outputFileName
$fixedPrefix = "C:\\autoimportinputfiles\"

# create empty array
$NewLines = @()

foreach ($line in [System.IO.File]::ReadLines($inputFile)) { 
    $splitLine = $line.Split(",")
    $oldPath = $splitLine[$splitLine.Count - 1]
    $oldPath = $oldPath -replace '["]'
    $imageFileName = Split-Path $oldPath -Leaf
    $newPath = Join-Path -Path $fixedPrefix -ChildPath $imageFileName
    $newPath = "`"$newPath`""

    $newSplitLine = $splitLine
    $newSplitLine[$newSplitLine.Count - 1] = $newPath
    $NewSplitLineCommas = $newSplitLine -join ","

    $NewLines += $NewSplitLineCommas
}
$NewLines | Out-File -FilePath $outputPath 
