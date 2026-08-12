# 自动生成的安装脚本
$nssm   = 'D:\linux\linus_heima\nssm\nssm.exe'
$svc    = 'GitAutoSync_test2_github'
$script = 'D:\linux\test2_github\git_sync_realtime_GitAutoSync_test2_github.ps1'
$repo   = 'D:\linux\test2_github'
$logOut = Join-Path $repo 'git_sync_service.log'
$logErr = Join-Path $repo 'git_sync_service_err.log'
$safeDir = $repo -replace '\\', '/'

if (-not (Test-Path $nssm)) { Write-Host "[失败] 找不到 nssm: $nssm"; exit 1 }
& $nssm stop $svc 2>&1 | Out-Null
& $nssm remove $svc confirm 2>&1 | Out-Null
& $nssm install $svc "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" "-NoProfile -ExecutionPolicy Bypass -File $script"
if ($LASTEXITCODE -ne 0) { Write-Host "[失败] 安装服务出错"; exit 1 }
& $nssm set $svc DisplayName "Git Auto-Sync"
& $nssm set $svc Description "Watch $repo and auto-commit+push"
& $nssm set $svc ObjectName LocalSystem
& $nssm set $svc AppDirectory $repo
& $nssm set $svc Start SERVICE_AUTO_START
& $nssm set $svc AppExit Default Restart
& $nssm set $svc AppRestartDelay 5000
& $nssm set $svc AppStdout $logOut
& $nssm set $svc AppStderr $logErr
& $nssm set $svc AppRotateFiles 1
& $nssm set $svc AppRotateBytes 1048576
& $nssm set $svc AppEnvironmentExtra GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=safe.directory GIT_CONFIG_VALUE_0=$safeDir
& $nssm start $svc
if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] 服务已安装并启动: $svc"
} else {
    Write-Host "[失败] 启动服务失败"
}