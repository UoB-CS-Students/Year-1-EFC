@ECHO off
ECHO Deleting .pdf, .aux, .log, .gz and .toc files.

FOR /R %%i IN ("*.log") DO DEL "%%i"
FOR /R %%i IN ("*.aux") DO DEL "%%i"
FOR /R %%i IN ("*.toc") DO DEL "%%i"
FOR /R %%i IN ("*.gz") DO DEL "%%i"

ECHO Process complete.

PAUSE