SET HOST=localhost
REM SET HOST=10.0.0.64
SET REQUESTS=10000



:AspNet
SET PORT=55000
SET ID=aspnet
ab -n 1 "http://%HOST%:%PORT%/reset/full"
CALL :Benchmark

GOTO End

:Benchmark

SET URL=http://%HOST%:%PORT%

FOR %%A IN (json plaintext) DO ab -k -n %REQUESTS% -c 10 "%URL%/%%A" > results\raw_%REQUESTS%_10_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul
FOR %%A IN (json plaintext) DO ab -k -n %REQUESTS% -c 100 "%URL%/%%A" > results\raw_%REQUESTS%_100_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul
FOR %%A IN (json plaintext) DO ab -k -n %REQUESTS% -c 256 "%URL%/%%A" > results\raw_%REQUESTS%_256_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul
ab -k -n %REQUESTS% -c 1000 "%URL%/plaintext" > results\raw_10000_1000_plaintext_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul

FOR %%A IN (db queries fortunes updates) DO ab -k -n %REQUESTS% -c 10 "%URL%/%%A" > results\db_%REQUESTS%_10_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul
FOR %%A IN (db queries fortunes updates) DO ab -k -n %REQUESTS% -c 100 "%URL%/%%A" > results\db_%REQUESTS%_100_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul
FOR %%A IN (db queries fortunes updates) DO ab -k -n %REQUESTS% -c 256 "%URL%/%%A" > results\db_%REQUESTS%_256_%%A_%ID%.txt
ab -n 1 "http://%HOST%:%PORT%/reset/gc" > nul

GOTO :EOF

:End
