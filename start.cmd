@echo off
chcp 65001 >nul
title Theme Studio
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 goto NONODE

rem 把网站文件夹拖到本文件上即可；不拖则编辑当前目录
set "SITE=%~1"
if "%SITE%"=="" set "SITE=."

echo 网站目录：%SITE%
echo.
node "%~dp0editor.js" --site "%SITE%"
echo.
pause
exit /b 0

:NONODE
echo.
echo   没有找到 Node.js，请先安装： https://nodejs.org/zh-cn
echo.
start "" "https://nodejs.org/zh-cn"
pause
exit /b 1
