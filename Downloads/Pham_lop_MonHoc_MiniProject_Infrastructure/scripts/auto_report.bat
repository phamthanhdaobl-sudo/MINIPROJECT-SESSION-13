@echo off
setlocal
REM GreenTech log report generator. Run from repository root.
REM AUDIT: reads source and appends output only; no destructive delete commands.

set "LOG_FILE=data\log-he-thong.log"
set "OUT_DIR=backup"
set "OUT_FILE=%OUT_DIR%\bao-cao-su-co.txt"

if not exist "%LOG_FILE%" (
    echo [AUDIT-FAIL] Khong tim thay "%LOG_FILE%".
    exit /b 2
)
if not exist "%OUT_DIR%\" (
    mkdir "%OUT_DIR%"
    if errorlevel 1 (
        echo [AUDIT-FAIL] Khong tao duoc thu muc backup.
        exit /b 3
    )
)

>>"%OUT_FILE%" echo.
>>"%OUT_FILE%" echo ==================================================
>>"%OUT_FILE%" echo GREENTECH - BAO CAO SU CO HE THONG
>>"%OUT_FILE%" echo Thoi diem tao: %DATE% %TIME%
>>"%OUT_FILE%" echo Nguon: %LOG_FILE%
>>"%OUT_FILE%" echo Bo loc: CRITICAL hoac ERROR
>>"%OUT_FILE%" echo ==================================================

REM Stream input through findstr; /C patterns are OR matches.
type "%LOG_FILE%" | findstr /I /C:"CRITICAL" /C:"ERROR" >> "%OUT_FILE%"
if errorlevel 2 (
    echo [WARN] findstr gap loi. Kiem tra encoding va quyen truy cap.
    exit /b 4
)
echo [OK] Da noi ket qua vao "%OUT_FILE%".
echo [AUDIT] Khong co lenh xoa tep nao duoc thuc thi.
endlocal
exit /b 0
