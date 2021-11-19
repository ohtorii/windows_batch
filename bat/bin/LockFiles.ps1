foreach ($arg in $args) {
    if (-not(Test-Path $arg)){
        Write-Host 引数で指定されたファイルが存在しません
        Write-Host $arg
        exit 
    }
}

Write-Host "ファイルをロック中"
$files = @()
foreach ($arg in $args) {
    $file = [System.IO.File]::Open($arg,[System.IO.FileMode]::Open,[System.IO.FileAccess]::Read,[System.IO.FileShare]::None)
    $files += $file
    Write-Host [OK] $arg
}

Write-Host ""
Read-Host "続けるには Enter キーを押してください..." 

# UnLock
foreach($file in $files){
    $file.Close()
}

