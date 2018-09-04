/+
                    Copyright 0xEAB 2016 - 2018.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.app;

import std.getopt : config, defaultGetoptPrinter, getopt, GetoptResult;
import std.stdio;

import saltyutility.emojitagger;
import saltyutility.languageprocessor;
import saltyutility.parser;
import saltyutility.pdf;

enum appName = "salt-parser";

int run(string[] args)
{
	bool optPrintVersionInfo;

	// dfmt off
	GetoptResult opt = getopt(
		args,
        config.passThrough,
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

	File input = (args[1] == "-") ? stdin : File(args[1], "r");
	File outpt = (args[2] == "-") ? stdout : File(args[2], "w");

	return run(input, outpt);
}

void printHelp(string args0, GetoptResult opt)
{
	defaultGetoptPrinter(appName ~ "\n\n  Usage:\n    " ~ args0
			~ " [options] [menu.pdf] [target.txt]\n\n\nAvailable options:\n==================",
			opt.options);
}

void printVersionInfo()
{
	stdout.writeln(import("version.txt"));
}

int run(File input, File output)
{
	Week w = input.getText.parse;
	output.writeln(w.title, "\n");

	foreach (Day day; w.days)
	{
		import emojid.animalsandnature : AnimalsAndNature;

		auto lunch = day.lunch.reArrange.fixTypos.improveReadability;
		auto lunchVeggie = day.lunchVeggie.reArrange.fixTypos.improveReadability;
		auto supper = day.supper.reArrange.fixTypos.improveReadability;
		auto supperVeggie = day.supperVeggie.reArrange.fixTypos.improveReadability;

		output.writeln(day.name ~ " z'Mittag:");
		foreach (dish; lunch)
		{
			output.writeln(dish.tag ~ "  " ~ dish);
		}

		output.writeln();
		foreach (dish; lunchVeggie.removeDoubles(lunch))
		{

			output.writeln("" ~ AnimalsAndNature.fourLeafClover, dish.tag ~ "  " ~ dish);
		}

		output.writeln("\n -------------------- \n\nZan Nochtmoi:");
		foreach (dish; supper)
		{
			output.writeln(dish.tag ~ "  " ~ dish);
		}

		output.writeln();
		foreach (dish; supperVeggie.removeDoubles(supper))
		{
			output.writeln("" ~ AnimalsAndNature.fourLeafClover, dish.tag ~ "  " ~ dish);
		}

		output.writeln("\n--------------------------------------------------\n");
	}

	output.writeln();
	output.flush();

	return 0;
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
