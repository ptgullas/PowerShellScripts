# I was using this script in my InfoPath-to-Power Apps Migration
# This searches multiple files looks for specific strings starting from the beginning of a line
# (mainly string beginning with a specific # of spaces), and then putting each word
# into a results file, underneath the name of the file that it was found in
# So if I was searching for "        lbl", it would find the word "lblHeaderfrmAwaitingOwnerResponse_AOR", 
# if it had 8 spaces before it at the start of a line, then save it in a results file.
####
# I was using it to find labels that were directly under the form so I could put them in
# DataCards
# Sample call:
# .\Extract-YamlWords.ps1 -SearchString "        lbl" -FolderPath ".\2026-06-12_GoldenMaster_b\Src" -OutputFile "Results.txt"
param (
    [Parameter(Mandatory=$true, HelpMessage="The string containing spaces followed by the word prefix, e.g., '        lbl'")]
    [string]$SearchString,
    
    [Parameter(Mandatory=$false, HelpMessage="The folder to search in. Defaults to current directory.")]
    [string]$FolderPath = ".",
    
    [Parameter(Mandatory=$false, HelpMessage="The file to save the results to. Defaults to 'ExtractedWords.txt'.")]
    [string]$OutputFile = "ExtractedWords.txt"
)

# Convert relative paths to absolute paths based on the current directory
$FolderPath = Resolve-Path $FolderPath
$OutputFilePath = Join-Path (Get-Location) $OutputFile

# Clear or create the output file
Out-File -FilePath $OutputFilePath -InputObject "" -Encoding utf8

# Find all .yaml files in the specified folder and subfolders
$files = Get-ChildItem -Path $FolderPath -Filter "*.yaml" -File -Recurse

$totalMatches = 0

foreach ($file in $files) {
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Escape the search string so regex doesn't interpret any special characters
    $escapedPrefix = [regex]::Escape($SearchString)
    
    # Match the exact search string at the VERY BEGINNING of a line.
    # (?m) enables multiline mode so '^' matches the start of a line.
    $pattern = '(?m)^' + $escapedPrefix + '\w*'
    $matches = [regex]::Matches($content, $pattern)
    
    if ($matches.Count -gt 0) {
        # Write the filename
        Add-Content -Path $OutputFilePath -Value $file.Name
        
        foreach ($match in $matches) {
            # Trim the leading spaces to just get the word itself
            $fullWord = $match.Value.TrimStart(" ")
            Add-Content -Path $OutputFilePath -Value $fullWord
            $totalMatches++
        }
        
        # Add a blank line for readability between files
        Add-Content -Path $OutputFilePath -Value ""
    }
}

Write-Host "Done. Found $totalMatches matches."
Write-Host "Results saved to: $OutputFilePath"
