/+
                    Copyright 0xEAB 2016 - 2018.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.languageprocessor;

import core.memory : GC;
import std.algorithm : each, filter, map;
import std.ascii : toUpper;
import std.string : indexOf, join, replace, split, strip;

auto reArrange(string[] rawDishes)
{
    // this function will allocate quite a lot
    // disable the GC to speed things up
    GC.disable();
    scope (exit)
    {
        GC.enable();
    }

    // raw data has linebreaks based on PDF
    // remove them
    string[] list = [rawDishes.join(' ')];

    // split the list of dishes
    static foreach (s; separators)
    {
        { // new scope
            string[] ls;
            list.each!(l => ls ~= l.split(s));
            list = ls;
        }
    }

    return list.map!strip
        .filter!(s => s.length > 0);
}

auto fixTypos(Range)(Range dishes)
{
    // this function will allocate quite a lot
    // disable the GC to speed things up
    GC.disable();
    scope (exit)
    {
        GC.enable();
    }

    return dishes.map!(s => {
        static foreach (pair; typos)
        {
            s = s.replace(pair[0], pair[1]);
        }
        return s;
    }());
}

auto improveReadability(Range)(Range dishes)
{
    // this function will allocate quite a lot
    // disable the GC to speed things up
    GC.disable();
    scope (exit)
    {
        GC.enable();
    }

    auto afterSoup = dishes.map!(s2 => {
        char[] s = s2.dup;
        s = ((s.indexOf("cremesuppe") > 0) ? s.replace("cremesuppe",
            "-Cremesuppe") : s.replace("suppe", "-Suppe"));

        static foreach (pair; betterReadable)
        {
            s = s.replace(pair[0], pair[1]);
        }

        s[0] = s[0].toUpper;
        return s.idup;
    }());

    return afterSoup;
}

private:
// dfmt off
enum separators = [
    "mit",
    "und",
    ",",
];

enum typos = [
    ["  ", " "],
    [" - ", "-"],
    ["- ", "-"],
    ["Nuß", "Nuss"],
    ["crems", "cremes"],
];

enum betterReadable = [
    ["dip", "-Dip"],
    ["gemüse", "-Gemüse"],
    ["Grünem Salat", "grüner Salat"],
    ["Kakaozucker", "Kakao-Zucker"],
    ["Kartoffel", "Erdäpfel"],
    ["kuchen", "-Kuchen"],
    ["sauce", "soß"],
    ["Geselchtes", "Xöchz"],
    //["salat", "-Salat"],
];
