..\..\..\..\AS\bin\asw test.asm -L -U -g -q -cpu 65C02 > asm.txt
..\..\..\..\AS\bin\p2hex test.p -F Intel -l 32 -r $0000-$FFFF > hex.txt