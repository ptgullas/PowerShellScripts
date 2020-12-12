$ServerToConnect = "192.168.18.33"
$PortToConnect = "23"

$tcpConnection = New-Object System.Net.Sockets.TcpClient($ServerToConnect, $PortToConnect)
$tcpStream = $tcpConnection.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true

while ($tcpConnection.Connected) {
    while ($tcpStream.DataAvailable -or $reader.Peek() -ne -1 ) {
        $reader.ReadLine()
    }

    if ($tcpConnection.Connected) {
        Write-Host -NoNewline "prompt> "
        $command = Read-Host

        if ($command -eq "escape") {
            break
        }

        $writer.WriteLine($command) | Out-Null
        Start-Sleep -Milliseconds 10
    }
}

$reader.Close()
$writer.Close()
$tcpConnection.Close()