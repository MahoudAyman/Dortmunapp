@echo off
set GIT=C:\src\flutter\bin\mingit\cmd\git.exe
%GIT% config user.name "Mahmoud Ayman"
%GIT% config user.email "mahmoudayman@example.com"
%GIT% add -A
%GIT% commit -m "feat: responsive adaptive flutter layout across mobile, tablet, and desktop"
%GIT% branch -M main
%GIT% remote remove origin 2>nul
%GIT% remote add origin https://github.com/MahoudAyman/Dortmunapp.git
%GIT% remote -v
