@echo off
title Macroassembler AS
echo.
for /f %%i in ('time /T') do set datetime=%%i
echo [%datetime%]
REM echo.

echo Generating jump table...
jump-table.py
move instructions.asm src >nul
move jump-table.asm src >nul

echo Assembling...
..\..\..\AS\bin\asw src\main.asm -L -U -g -q -cpu 65C02 > asm.txt
python "remove escape.py" asm.txt
move src\*.lst . >nul
move src\*.map . >nul
move src\*.p . >nul

echo Filtering listing...
python "listing filter.py" main.lst filtered.lst
REM listing filter ignores first three lines. adjust so works here too?
echo dummy > listing.lst
echo dummy >> listing.lst
echo dummy >> listing.lst
type filtered.lst >> listing.lst

echo Generating hex file...
..\..\..\AS\bin\p2hex main.p -F Intel -l 32 -r $0000-$FFFF > hex.txt
echo :02FFFC0000C043 > prog.hex
type main.hex >> prog.hex

echo Copying...
copy listing.lst "..\..\..\projects\6502 emu\local copy\listing.lst" > nul
copy prog.hex "..\..\..\projects\6502 emu\local copy\prog.hex" > nul
break > "..\..\..\projects\6502 emu\main\keys.txt"

echo.
echo Done