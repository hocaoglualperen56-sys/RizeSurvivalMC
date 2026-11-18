@echo off
cd /d "%~dp0"
if not exist paper.jar (
  echo Once setup.ps1 dosyasini calistir.
  pause
  exit /b 1
)
java -Xms4G -Xmx6G -jar paper.jar --nogui
pause
