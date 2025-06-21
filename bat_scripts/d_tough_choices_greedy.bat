@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Running D Tough Choices Greedy Solution
echo ========================================

:: Compile the C++ solution
echo Compiling d_tough_choices_greedy.cpp...
g++ -std=c++17 -O2 -o ..\cpp_scripts\d_tough_choices_greedy.exe ..\cpp_scripts\d_tough_choices_greedy.cpp
if errorlevel 1 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)
echo Compilation successful!
echo.

:: Create output directory if it doesn't exist
if not exist "..\output\d_tough_choices_greedy" mkdir "..\output\d_tough_choices_greedy"

:: Set random seed
set SEED=42

:: Process each instance file
echo Processing instances...
for %%f in (..\instances\*.txt) do (
    set "filename=%%~nf"
    echo Processing: %%f
    echo   ^> Running algorithm with seed %SEED%...
    
    :: Run the algorithm and save output
    ..\cpp_scripts\d_tough_choices_greedy.exe %SEED% < "%%f" > "..\output\d_tough_choices_greedy\!filename!.out" 2> "..\output\d_tough_choices_greedy\!filename!.log"
    
    if errorlevel 1 (
        echo   ^> ERROR: Algorithm failed for %%f
    ) else (
        echo   ^> SUCCESS: Output saved to ..\output\d_tough_choices_greedy\!filename!.out
    )
    echo.
)

:: Clean up executable
del ..\cpp_scripts\d_tough_choices_greedy.exe

echo ========================================
echo All instances processed!
echo Results saved in: ..\output\d_tough_choices_greedy\
echo ========================================
pause