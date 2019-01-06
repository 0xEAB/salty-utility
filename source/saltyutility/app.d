/+
                    Copyright 0xEAB 2016 - 2019.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.app;

import core.memory : GC;
import std.exception : enforce;
import std.getopt : config, defaultGetoptPrinter, getopt, GetoptResult;
import std.file : exists;
import std.stdio;

import saltyutility.parser;
import saltyutility.pdf;
import saltyutility.output;

enum appName = "salty-utility";

int run(string[] args)
{
    bool optDisableGC;
    bool optPrintVersionInfo;
    bool optUseSQL;

    // dfmt off
    GetoptResult opt = getopt(
        args,
        config.passThrough,
        "nogc", "Disable the garbage collector (may lead to memory leaks)", &optDisableGC,
        "sql", "Use SQL output format", &optUseSQL,
        "version", "Display the version of this program.", &optPrintVersionInfo
    );
    // dfmt on

    if (opt.helpWanted)
    {
        printHelp(args[0], opt);
        return 0;
    }
    else if (optPrintVersionInfo)
    {
        printVersionInfo();
        return 0;
    }
    else if (args.length <= 2)
    {
        printHelp(args[0], opt);
        return 0;
    }

    if (optDisableGC)
    {
        GC.disable();
    }

    File input;
    File outpt;

    try
    {
        input = openFile!false(args[1]);
    }
    catch (Exception)
    {
        stderr.writeln("Failed to open input file: ", args[1]);
        return 1;
    }

    try
    {
        outpt = openFile!true(args[2]);
    }
    catch (Exception)
    {
        stderr.writeln("Failed to open output file: ", args[2]);
        return 1;
    }

    return run(input, outpt, optUseSQL);
}

File openFile(bool outputNotInput)(string file)
{
    if (file == "-")
    {
        static if (outputNotInput)
        {
            return stdout;
        }
        else
        {
            return stdin;
        }
    }

    static if (outputNotInput)
    {
        enum mode = "w";
    }
    else
    {
        file.exists.enforce();
        enum mode = "r";
    }

    return File(file, mode);
}

void printHelp(string args0, GetoptResult opt)
{
    defaultGetoptPrinter(appName ~ "\n\n  Usage:\n    " ~ args0
            ~ " [options] [menu.pdf] [target.txt]\n\n\nAvailable options:\n==================",
            opt.options);
}

void printVersionInfo()
{
    stdout.write(import("version.txt"));
}

int run(File input, File output, bool useSQL)
{
    import std.string : endsWith;

    Week w = (input.name.endsWith(".pdf")) ? input.getText.parse : input.byLineCopy.parse;

    if (useSQL || output.name.endsWith(".sql"))
    {
        print!(Format.SQL)(w, output);
    }
    else
    {
        print!(Format.text)(w, output);
    }
    return 0;
}
