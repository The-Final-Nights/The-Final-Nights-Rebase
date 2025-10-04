@echo off
type nul > merged.txt
FOR /R .\bulk %%f IN (*) DO (type "%%f" >> merged.txt) && (echo. >> merged.txt)
