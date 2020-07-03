@echo off
set proj_name=%1
set proj_name_upper=%1
call :UpCase proj_name_upper
set proj_name_long=%2
mkdir %proj_name%
pushd %proj_name%
mkdir code
robocopy s:\example_project\code .\code /COPYALL /E > NUL
pushd code
echo. > %proj_name%.cpp
powershell -Command "(gc build.bat) -replace 'example.cpp', '%proj_name%.cpp' | Out-File -encoding ASCII build.bat"
powershell -Command "(gc project.4coder) -replace 'NAME ME', '%proj_name_long%' | Out-File -encoding ASCII project.4coder"
powershell -Command "(gc build.bat) -replace 'EXAMPLE', '%proj_name_upper%' | Out-File -encoding ASCII build.bat"
popd
popd

cd %proj_name%\code

:UpCase
:: Subroutine to convert a variable VALUE to all UPPER CASE. (FROM ROB VAN DER WOUDE)
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO CALL SET "%1=%%%1:%%~i%%"
GOTO:EOF
