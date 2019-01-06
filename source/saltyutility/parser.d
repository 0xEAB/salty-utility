/+
                    Copyright 0xEAB 2016 - 2019.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.parser;

import std.algorithm : countUntil;
import std.ascii : isWhite;
import std.conv : to;
import std.functional : not;
import std.stdio : stderr;
import std.string : indexOf, startsWith, strip, stripLeft;
import std.utf : toUTF8, toUTF16;

struct Week
{
    Day[] days;
    string title;

    alias days this;
}

struct Day
{
    string name;
    string[] lunch;
    string[] lunchVeggie;
    string[] supper;
    string[] supperVeggie;
}

Week parse(Range)(Range text)
{
    Week output;
    Day day;
    ParserState parserState = ParserState.init_;

    ptrdiff_t offset2ndCol = -1;

    text.popFront();
    output.title = text.front.strip;
    text.popFront();

    while (!text.empty)
    {
        immutable string line = text.front;
        text.popFront();

        immutable string ln = line.stripLeft;

        switch (ln)
        {
        case "":
            continue;

            // dfmt off
        mixin(Case!"Montag");
        mixin(Case!"Dienstag");
        mixin(Case!"Mittwoch");
        mixin(Case!"Donnerstag");
        mixin(Case!"Freitag");
        // dfmt on

        default:
            immutable lineF16 = line.toUTF16;
            if (offset2ndCol == -1)
            {
                if (line.startsWith("Mittag:"))
                {
                    // there should be at least 5 spaces between the columns
                    // also 5 spaces should be enough to strain off typos (e.g. "a n _ _ a p p l e")
                    immutable endOf1stCol = lineF16.indexOf("     "w);

                    offset2ndCol = endOf1stCol + lineF16[endOf1stCol .. $].countUntil!(
                            not!isWhite)();
                    parserState = ParserState.lunch;
                }
                else
                {
                    stderr.writeln(
                            "Warning: Unknown single-column pattern skipped ("
                            ~ parserState.to!string ~ "): " ~ line);
                }
            }

            // when there's only 1 column it won't end at offset2ndCol
            immutable endOf1stCol = (lineF16.length <= offset2ndCol) ? lineF16.length : offset2ndCol;

            if (ln.startsWith("Änd")) // "Änderungen vorbehalten"
            {
                // (usually) end of document
                continue;
            }

            string carnism = void;

            immutable offsetLunch = lineF16.indexOf("Mittag:"w);
            if ((offsetLunch == 0) || ln.startsWith("Mittag:"))
            {
                parserState = ParserState.lunch;
                carnism = lineF16[(7 + offsetLunch) .. endOf1stCol].strip.toUTF8;
            }
            else
            {
                immutable offsetSupper = lineF16.indexOf("Abend:"w);
                if ((offsetSupper == 0) || ln.startsWith("Abend:"))
                {
                    parserState = ParserState.supper;

                    if (lineF16.length <= 6)
                    {
                        continue;
                    }
                    carnism = lineF16[(6 + offsetSupper) .. endOf1stCol].strip.toUTF8;
                }
                else
                {
                    carnism = lineF16[0 .. endOf1stCol].strip.toUTF8;
                }
            }

            if (carnism.length == 0)
            {
                // first column is empty
            }
            else
            {
                mixin(Add!("lunch", "supper", "carnism"));
            }

            // Veggie
            if (endOf1stCol == offset2ndCol)
            {
                string veggie = lineF16[offset2ndCol .. $].strip.toUTF8;
                mixin(Add!("lunchVeggie", "supperVeggie", "veggie"));
            }

            break;
        }
    }

    // add the last day to the list
    if (day != Day.init)
    {
        output ~= day;
        day = Day();
    }

    return output;
}

private:
enum ParserState
{
    init_,
    lunch,
    supper,
}

template Case(string day)
{
    const char[] Case = `case "` ~ day ~ `": if (day != Day.init) { output ~= day; day = Day(); } day.name = "`
        ~ day ~ `"; parserState = ParserState.init_; break;`;
}

template Add(string lunchProperty, string supperProperty, string dishVariable)
{
    // dfmt off
    const char[] Add = `if (!` ~ dishVariable ~ `[1 .. $].startsWith("nthält:")) {
        final switch (parserState) with (ParserState) {
            case lunch: day.` ~ lunchProperty ~ ` ~= ` ~ dishVariable ~ `; break;
            case supper: day.` ~ supperProperty ~ ` ~= ` ~ dishVariable ~ `; break;
            case init_: stderr.writeln("Warning: Possible dish appeared with no time-of-the-day specified: " ~ ` ~
                dishVariable ~ `); break;
        }}`;
    // dfmt on
}
