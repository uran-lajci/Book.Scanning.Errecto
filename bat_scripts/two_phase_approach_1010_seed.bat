@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Running Two Phase Approach Solution
echo ========================================

:: Compile the C++ solution
echo Compiling two_phase_approach.cpp...
g++ -std=c++17 -O2 -o ..\cpp_scripts\two_phase_approach.exe ..\cpp_scripts\two_phase_approach.cpp
if errorlevel 1 (
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)
echo Compilation successful!
echo.

:: Create output directory if it doesn't exist
if not exist "..\output\two_phase_approach_1010_seed" mkdir "..\output\two_phase_approach_1010_seed"

:: Set random seed
set SEED=1010

:: Process each instance file
echo Processing instances...
echo NOTE: This algorithm uses local search optimization and may take longer to run...
echo.

for %%f in (..\instances\*.txt) do (
    set "filename=%%~nf"
    echo Processing: %%f
    echo   ^> Running two-phase algorithm with seed %SEED%...
    echo   ^> This may take several minutes depending on instance size...
    
    :: Get start time
    set start_time=!time!
    
    :: Run the algorithm and save output
    ..\cpp_scripts\two_phase_approach.exe  %SEED% < "%%f" > "..\output\two_phase_approach_1010_seed\!filename!.out" 2> "..\output\two_phase_approach_1010_seed\!filename!.log"
    
    :: Get end time
    set end_time=!time!
    
    if errorlevel 1 (
        echo   ^> ERROR: Algorithm failed for %%f
    ) else (
        echo   ^> SUCCESS: Output saved to ..\output\two_phase_approach_1010_seed\!filename!.out
        echo   ^> Runtime: !start_time! to !end_time!
    )
    echo.
)

:: Clean up executable
del ..\cpp_scripts\two_phase_approach.exe

echo ========================================
echo All instances processed!
echo Results saved in: ..\output\two_phase_approach_1010_seed\
echo ========================================
echo.
echo NOTE: Check the .log files for algorithm statistics and debug output
pause