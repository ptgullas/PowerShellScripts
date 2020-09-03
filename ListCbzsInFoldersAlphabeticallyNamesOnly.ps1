# get all *cbz files under current folder (& subfolders)
$cbzs = Get-ChildItem -Name -Recurse -Include *.cbz
# create empty array
[System.Collections.ArrayList]$cbzNames = @()

foreach ($cbz in $cbzs) {
    $cbzNameOnly = $cbz |Split-Path -Leaf
    $cbzNames += $cbzNameOnly
}

$sortedCbzNames = $cbzNames |Sort-Object
$sortedCbzNames | Out-File cbzsInTree.txt