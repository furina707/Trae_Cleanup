@echo off
setlocal
set "TITLE=%~1"
set "MD_PATH=%~2"
set "COOKIES=%~3"
set "TOOL_DIR=%~dp0tools\csdn-publisher"
if "%TITLE%"=="" set "TITLE=Trae Cleanup Tool 发布"
if "%MD_PATH%"=="" set "MD_PATH=%~dp0PROMOTION.md"
pushd "%TOOL_DIR%"
node publish.js --title "%TITLE%" --md "%MD_PATH%" --cookies "%COOKIES%"
popd
endlocal
