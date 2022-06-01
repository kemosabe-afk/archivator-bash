# Archivator/Extractor Script with Bash

The script can archive in [tar|tgz|tbz2|txz|7z|rar|zip] extensions, as well as extract them if the necessary packages are installed.

    Usage:          *./archivator.sh [-c|-x create|extract] [-d directory] [-f file]*

        -c create       Create an Archive [tar|tgz|tbz2|txz|7z|rar|zip].
        -x extract      Extract an Archive (Auto-Detects the Type of Archive).
        -d directory    Create/Extract to the Specific Directory.
        -f file         Input File to Archive/Extract.

    For Example:    *./archivator.sh -c tbz2 -d ~/ -f ./test.txt*  
                    *./archivator.sh -x -d ./ -f ~/test.txt.tar.bz2*