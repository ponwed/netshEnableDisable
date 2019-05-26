# Functions
###########

function Enable {
    param (
        $Interface
    )

    netsh.exe wlan set autoconfig enabled=yes interface=$Interface
}

function Disable {
    param (
        $Interface
    )

    if (Test-Connection "192.168.1.1" -Count 1) {
        netsh.exe wlan set autoconfig enabled=no interface=$Interface
    }      
}

function GetStatusString {
    $Wlan = netsh.exe wlan show settings | Select-String 'Auto configuration'
    return [string]$Wlan
}

function GetEnabled {
    if ($(GetStatusString) -match 'enabled') {return $true} else {return $false}
}

function GetInterface {
    $Interface = $(GetStatusString) -match '".*"' | ForEach-Object {$Matches[0]}
    return $Interface
}

# Main
######

$Interface = GetInterface

while (!$(GetEnabled)) {
    Enable $Interface
    Start-Sleep -Seconds 5 # Give Windows enough time to connect to wifi before disabling again
}

Disable $Interface