@echo off
cd tables
jump-table.py
copy instructions.asm ..\instructions.asm
copy jump-table.asm ..\jump-table.asm 
cd ..