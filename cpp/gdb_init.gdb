# GDB initialization script for C++ learning
set confirm off
set debuginfod enabled on

# Break on your actual test functions, not GoogleTest internals
break _Z26singleModifierDeclarationsIiEKT_v
break _Z26singleModifierDeclarationsIjEKT_v
break createObjects

# Set up better display
set print pretty on
set print array on
set print array-indexes on

echo === GDB Ready for C++ Integer Debugging ===\n
echo Breakpoints set on your functions:\n
echo - singleModifierDeclarations<int>\n
echo - singleModifierDeclarations<unsigned>\n
echo - createObjects\n
echo \n
echo Useful commands:\n
echo (gdb) run\n
echo (gdb) continue\n
echo (gdb) print variable_name\n
echo (gdb) info locals\n
echo (gdb) step / next\n
echo ===============================================\n
