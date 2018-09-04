/+
                    Copyright 0xEAB 2016 - 2018.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.pdf;

import std.algorithm : each;
import std.exception : enforce;
import std.process;
import std.stdio : File;

alias ByLineCopy = typeof({ File a; return a.byLineCopy; }());

ByLineCopy getText(File pdf)
{
    auto txt = pipeProcess(["pdftotext", "-layout", "-", "-"], Redirect.stdin | Redirect.stdout);
    pdf.byLine.each!(l => txt.stdin.writeln(l));
    txt.stdin.flush();
    txt.stdin.close();

    return txt.stdout.byLineCopy;
}
