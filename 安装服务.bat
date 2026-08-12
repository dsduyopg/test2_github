@echo off
chcp 65001 >nul
set "NSSM=D:\linux\linus_heima\nssm\nssm.exe"
"%NSSM%" stop GitAutoSync_test2_github >nul 2>&1
"%NSSM%" remove GitAutoSync_test2_github confirm >nul 2>&1
"%NSSM%" install GitAutoSync_test2_github "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" "-NoProfile -ExecutionPolicy Bypass -File D:\linux\test2_github\git_sync_realtime_GitAutoSync_test2_github.ps1"
"%NSSM%" set GitAutoSync_test2_github ObjectName LocalSystem
"%NSSM%" set GitAutoSync_test2_github AppDirectory D:\linux\test2_github
"%NSSM%" set GitAutoSync_test2_github Start SERVICE_AUTO_START
"%NSSM%" set GitAutoSync_test2_github AppExit Default Restart
"%NSSM%" set GitAutoSync_test2_github AppRestartDelay 5000
"%NSSM%" set GitAutoSync_test2_github AppStdout D:\linux\test2_github\git_sync_service.log
"%NSSM%" set GitAutoSync_test2_github AppStderr D:\linux\test2_github\git_sync_service_err.log
"%NSSM%" set GitAutoSync_test2_github AppRotateFiles 1
"%NSSM%" set GitAutoSync_test2_github AppRotateBytes 1048576
"%NSSM%" set GitAutoSync_test2_github AppEnvironmentExtra GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=safe.directory GIT_CONFIG_VALUE_0=D:/linux/test2_github
"%NSSM%" start GitAutoSync_test2_github
echo.
pause
