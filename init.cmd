@ECHO OFF
ECHO Copying git hooks...
robocopy githooks/ .git/hooks /NP /NDL /NJH /NJS /NS /XX /XO
ECHO Git hooks copied!