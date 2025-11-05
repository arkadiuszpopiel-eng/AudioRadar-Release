@echo off
REM RUN_BUILD_ALL.cmd - pełna procedura: setup venv, zainstaluj deps, zbuduj paczkę release i uruchom prototyp
echo === AudioRadar - RUN_BUILD_ALL ===
if not exist .venv (
    echo Creating virtual environment...
    python -m venv .venv
    if errorlevel 1 (
        echo Błąd: nie udało się utworzyć virtualenv. Upewnij się, że Python 3.10+ jest zainstalowany i na PATH.
        pause
        exit /b 1
    )
)
call .venv\Scripts\activate
python -m pip install --upgrade pip
if exist requirements.txt (
    echo Installing Python dependencies...
    pip install -r requirements.txt
) else (
    echo Brak requirements.txt, pomijam instalację zależności.
)
echo Building release package...
python scripts/build_release.py
if errorlevel 1 (
    echo Błąd podczas pakowania release.
    pause
    exit /b 1
)
echo Uruchamiam prototyp realtime (src/example_realtime.py)
python src/example_realtime.py
echo Done.
pause
