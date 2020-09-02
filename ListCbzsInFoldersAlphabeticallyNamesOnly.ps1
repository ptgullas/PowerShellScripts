$cbzs = Get-ChildItem -Name -Recurse -Include *.cbz
[System.Collections.ArrayList]$cbzNames = @()
foreach ($cbz in $cbzs) {
    $cbzNameOnly = $cbz |Split-Path -Leaf
    $cbzNames += $cbzNameOnly
}
$sortedCbzNames = $cbzNames |Sort-Object
$sortedCbzNames