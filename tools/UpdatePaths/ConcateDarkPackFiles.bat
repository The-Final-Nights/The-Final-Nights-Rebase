@echo off
REM Run this one before you run the normal one so our update paths run first
type nul > merged.txt
FOR /R .\Scripts\DarkPack %%f IN (*) DO (type "%%f" >> merged.txt) && (echo. >> merged.txt)
