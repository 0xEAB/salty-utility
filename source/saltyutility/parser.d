/+
                    Copyright 0xEAB 2016 - 2018.
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
        string line = text.front;
        text.popFront();

        string ln = line.stripLeft;

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
            if (offset2ndCol == -1)
            {
                if (line.startsWith("Mittag:"))
                {
                    // there should be at least 5 spaces between the columns
                    // also 5 spaces should be enough to strain off typos (e.g. "a n _ _ a p p l e")
                    immutable endOf1stCol = line.indexOf("     ");

                    offset2ndCol = endOf1stCol + line[endOf1stCol .. $].countUntil!(
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
            immutable endOf1stCol = (line.length <= offset2ndCol) ? line.length : offset2ndCol;

            if (ln.startsWith("Änd")) // "Änderungen vorbehalten"
            {
                // (usually) end of document
                continue;
            }

            string carnism = void;
            if (line.startsWith("Mittag:"))
            {
                parserState = ParserState.lunch;
                carnism = line[7 .. endOf1stCol].strip;
            }
            else if (line.startsWith("Abend:"))
            {
                parserState = ParserState.supper;

                if (line.length <= 6)
                {
                    continue;
                }
                carnism = line[6 .. endOf1stCol].strip;
            }
            else
            {
                carnism = line[0 .. endOf1stCol].strip;
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
                auto veggie = line[offset2ndCol .. $].strip;
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
        const char[] Add = `if (!` ~ dishVariable ~ `.startsWith("enthä")) { switch (parserState) with (ParserState) {
                case lunch: day.` ~ lunchProperty ~ ` ~= ` ~ dishVariable ~ `; break;
                case supper: day.` ~ supperProperty ~ ` ~= ` ~ dishVariable ~ `; break;
                default: assert(0, "Error: Dish appeared before day: " ~ ` ~ dishVariable ~ `); }}`;
        // dfmt on
}
