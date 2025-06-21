@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Running C Incunabula Greedy Solution
echo ========================================

:: Compile the C++ solution
echo Compiling c_incunabula_greedy.cpp...
g++ -std=c++17 -O2 -o ..\cpp_scripts\c_incunabula_greedy.exe ..\cpp_scripts\c_incunabula_greedy.cpp
if errorlevel 1 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)
echo Compilation successful!
echo.

:: Create output directory if it doesn't exist
if not exist "..\output\c_incunabula_greedy" mkdir "..\output\c_incunabula_greedy"

:: Set random seed
set SEED=101

:: Process each instance file
echo Processing instances...
for %%f in (..\instances\*.txt) do (
    set "filename=%%~nf"
    echo Processing: %%f
    echo   ^> Running algorithm with seed %SEED%...
    
    :: Run the algorithm and save output
    ..\cpp_scripts\c_incunabula_greedy.exe %SEED% < "%%f" > "..\output\c_incunabula_greedy\!filename!.out" 2> "..\output\c_incunabula_greedy\!filename!.log"
    
    if errorlevel 1 (
        echo   ^> ERROR: Algorithm failed for %%f
    ) else (
        echo   ^> SUCCESS: Output saved to ..\output\c_incunabula_greedy\!filename!.out
    )
    echo.
)

:: Clean up executable
del ..\cpp_scripts\c_incunabula_greedy.exe

echo ========================================
echo All instances processed!
echo Results saved in: output\c_incunabula_greedy\
echo ========================================
pause