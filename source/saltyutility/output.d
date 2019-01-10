/+
                    Copyright 0xEAB 2016 - 2019.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.output;

import std.stdio : File, stderr;

import saltyutility.emojitagger;
import saltyutility.languageprocessor;
import saltyutility.parser;

enum Format
{
    text,
    SQL,
}

void print(Format f)(Week w, File output)
{
    enum SQL = (f == Format.SQL);

    static if (SQL)
    {
        output.write("-- ");
    }

    output.writeln(w.title, "\n");

    static if (SQL)
    {
        import std.algorithm : countUntil;
        import std.ascii : isDigit;
        import std.conv : to;
        import std.datetime : Date, dur;
        import std.string : indexOf, stripRight;

        immutable idxTo = w.title.indexOf(" bis ");
        immutable idxStartDay = (idxTo - 6);
        immutable idxStartMonth = (idxTo - 3);
        immutable idxYear = (idxTo + 11);

        immutable year = w.title[idxYear .. (idxYear + 4)].to!int;
        immutable month = w.title[idxStartMonth .. (idxStartMonth + 2)].to!int;
        immutable day_ = w.title[idxStartDay .. (idxStartDay + 2)].to!int;
        Date date = Date(year, month, day_);
        auto oneDay = dur!"days"(1);
    }

    foreach (Day day; w.days)
    {
        import emojid.animalsandnature : AnimalsAndNature;

        auto lunch = day.lunch.reArrange.fixTypos.improveReadability;
        auto lunchVeggie = day.lunchVeggie.reArrange.fixTypos.improveReadability;
        auto supper = day.supper.reArrange.fixTypos.improveReadability;
        auto supperVeggie = day.supperVeggie.reArrange.fixTypos.improveReadability;

        static if (SQL)
        {
            output.writeln("INSERT INTO botcaster(announce, message) VALUES(");
            ubyte uMonth = ubyte(date.month);
            output.write('\'', date.year, '-', uMonth, '-', date.day, " 09:10:00',\n'");
        }

        output.write(day.name, " z’Mittag:");
        foreach (dish; lunch)
        {
            static if (SQL)
            {
                output.write(`\n`);
            }
            else
            {
                output.writeln();
            }
            output.write(dish.safeTag ~ "  " ~ dish);
        }

        static if (SQL)
        {
            output.write(`\n`);
        }
        else
        {
            output.writeln();
        }
        foreach (dish; lunchVeggie.removeDoubles(lunch))
        {
            static if (SQL)
            {
                output.write(`\n`);
            }
            else
            {
                output.writeln();
            }
            output.write("" ~ AnimalsAndNature.fourLeafClover, dish.safeTag ~ "  " ~ dish);
        }

        static if (SQL)
        {
            output.writeln("');");
        }

        output.writeln("\n -- ----------------- \n");

        static if (SQL)
        {
            output.writeln("INSERT INTO botcaster(announce, message) VALUES(");
            output.write('\'', date.year, '-', uMonth, '-', date.day, " 09:10:00',\n'");
        }

        output.write("Zan Nochtmoi:");
        foreach (dish; supper)
        {
            static if (SQL)
            {
                output.write(`\n`);
            }
            else
            {
                output.writeln();
            }
            output.write(dish.safeTag ~ "  " ~ dish);
        }

        static if (SQL)
        {
            output.write(`\n`);
        }
        else
        {
            output.writeln();
        }
        foreach (dish; supperVeggie.removeDoubles(supper))
        {
            static if (SQL)
            {
                output.write(`\n`);
            }
            else
            {
                output.writeln();
            }
            output.write("" ~ AnimalsAndNature.fourLeafClover, dish.safeTag ~ "  " ~ dish);
        }

        static if (SQL)
        {
            output.writeln("');");
            date += oneDay;
        }

        output.writeln("\n-- -----------------------------------------------\n");
    }

    output.writeln();
    output.flush();
}

string safeTag(string dish)
{
    string tag = dish.tag;

    if (tag is null)
    {
        stderr.writeln(`Warning: No suitable tag for "` ~ dish ~ `"`);
        return "";
    }

    return tag;
}

auto removeDoubles(Range)(Range veggie, Range carnism)
{
    import std.algorithm : filter;

    return veggie.filter!(d => {
        foreach (cd; carnism)
        {
            if (cd == d)
            {
                return false;
            }
        }
        return true;
    }());
}
