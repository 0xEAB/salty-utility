/+
                    Copyright 0xEAB 2016 - 2019.
     Distributed under the Boost Software License, Version 1.0.
        (See accompanying file LICENSE_1_0.txt or copy at
              https://www.boost.org/LICENSE_1_0.txt)
 +/
module saltyutility.emojitagger;

import std.string : toLower;
import emojid;

string tag(string dish)
{
    template Rule(string pattern, string tag)
    {
        const char[] Rule = `if (d.contains("` ~ pattern ~ `")){ return "` ~ tag ~ `"; }`;
    }

    template Rule2(string pattern, string tag)
    {
        const char[] Rule2 = `if (dish == "` ~ pattern ~ `"){ return "` ~ tag ~ `"; }`;
    }

    string d = dish.toLower;

    // most important
    mixin(Rule!("zucchini", FoodAndDrink.cucumber));
    mixin(Rule!("kürbis", Activities.jackOLantern));

    // soup
    mixin(Rule!("suppe", FoodAndDrink.potOfFood));
    mixin(Rule!("backerbsen", FoodAndDrink.potOfFood));
    mixin(Rule!("minestrone", FoodAndDrink.potOfFood));

    // lunch
    mixin(Rule!("toast", FoodAndDrink.sandwich)); // "Schinken-Käse-Toast"
    mixin(Rule!("baguette", FoodAndDrink.baguetteBread)); // "Käse-Knoblauch-Baguette"
    mixin(Rule!("stangerl", FoodAndDrink.baguetteBread));
    mixin(Rule!("burger", FoodAndDrink.hamburger));
    mixin(Rule!("spaghetti", FoodAndDrink.spaghetti));
    mixin(Rule!("bolognese", FoodAndDrink.spaghetti));
    mixin(Rule!("pasta", FoodAndDrink.spaghetti));
    mixin(Rule!("lasagne", FoodAndDrink.spaghetti));
    mixin(Rule!("chili", FoodAndDrink.hotPepper));
    mixin(Rule!("milch", FoodAndDrink.glassOfMilk));
    mixin(Rule!("grießkoch", FoodAndDrink.bowlWithSpoon));
    mixin(Rule!("grießauflauf", FoodAndDrink.moonCake));
    mixin(Rule!("fisch", AnimalsAndNature.fish));
    mixin(Rule!("lachs", AnimalsAndNature.fish));
    mixin(Rule!("pangasius", AnimalsAndNature.fish));
    mixin(Rule!("dorsch", AnimalsAndNature.fish));
    mixin(Rule!("hoki", AnimalsAndNature.fish));
    mixin(Rule!("kabeljau", AnimalsAndNature.fish));
    mixin(Rule!("chinesisch", Symbols.japanesePassingGradeButton));
    mixin(Rule!("pizza", FoodAndDrink.pizza));
    mixin(Rule!("pommes", FoodAndDrink.frenchFries));
    mixin(Rule!("knacker", FoodAndDrink.hotDog));
    mixin(Rule!("augsburger", FoodAndDrink.hotDog));
    mixin(Rule!("risotto", FoodAndDrink.cookedRice));
    mixin(Rule!("couscous", FoodAndDrink.cookedRice));
    mixin(Rule!("hirsetaler", FoodAndDrink.riceCracker));
    mixin(Rule!("gulasch", FoodAndDrink.shallowPanOfFood));
    mixin(Rule!("keule", FoodAndDrink.poultryLeg));
    mixin(Rule!("hühn", AnimalsAndNature.hatchingChick));
    mixin(Rule!("huhn", AnimalsAndNature.hatchingChick));
    mixin(Rule!("chicken", AnimalsAndNature.hatchingChick));
    mixin(Rule!("hendl", AnimalsAndNature.hatchingChick));
    mixin(Rule!("rind", AnimalsAndNature.cow));
    mixin(Rule!("tafelspitz", AnimalsAndNature.cow));
    mixin(Rule!("schwein", AnimalsAndNature.pig));
    mixin(Rule!("preiselbeer", FoodAndDrink.grapes));
    mixin(Rule!("reisfleisch", FoodAndDrink.curryRice));
    mixin(Rule!("faschierter braten", FoodAndDrink.curryRice));
    mixin(Rule!("faschierte laibchen", FoodAndDrink.curryRice));
    mixin(Rule!("geschnetzeltes", FoodAndDrink.curryRice));
    mixin(Rule!("fleisch", FoodAndDrink.cutOfMeat));
    mixin(Rule!("kotelett", FoodAndDrink.cutOfMeat));
    mixin(Rule!("surbraten", FoodAndDrink.cutOfMeat));
    mixin(Rule!("cevapcici", FoodAndDrink.hotDog));
    mixin(Rule!("schinken", FoodAndDrink.bacon));
    mixin(Rule!("xöchz", FoodAndDrink.bacon));
    mixin(Rule!("speck", FoodAndDrink.bacon));
    mixin(Rule!("pute", AnimalsAndNature.turkey));
    mixin(Rule!("schnitz", AnimalsAndNature.pig));
    mixin(Rule!("tofu", FoodAndDrink.oden));
    mixin(Rule!("reis", FoodAndDrink.cookedRice));
    mixin(Rule!("risipisi", FoodAndDrink.cookedRice));
    mixin(Rule!("risibisi", FoodAndDrink.cookedRice));
    mixin(Rule!("eintopf", FoodAndDrink.shallowPanOfFood));
    mixin(Rule!("sandwich", FoodAndDrink.sandwich));
    mixin(Rule!("schmarr", FoodAndDrink.pancakes));
    mixin(Rule!("fleckerl", FoodAndDrink.bentoBox));
    mixin(Rule!("frühlingsrolle", FoodAndDrink.burrito));
    mixin(Rule!("kroketten", TravelAndPlaces.rocket));
    mixin(Rule!("erdäpfel", FoodAndDrink.potato));
    mixin(Rule!("knödel", FoodAndDrink.dumpling));
    mixin(Rule!("rösti", FoodAndDrink.potato));
    mixin(Rule!("buchtel", FoodAndDrink.dumpling));
    mixin(Rule!("krapfen", FoodAndDrink.bagel));
    mixin(Rule!("butter", FoodAndDrink.glassOfMilk));
    mixin(Rule!("schwammerl", FoodAndDrink.mushroom));
    mixin(Rule!("pilz", FoodAndDrink.mushroom));
    mixin(Rule!("champignon", FoodAndDrink.mushroom));
    mixin(Rule!("brokkoli", FoodAndDrink.broccoli));
    mixin(Rule!("broccoli", FoodAndDrink.broccoli));
    mixin(Rule!("karfiol", FoodAndDrink.broccoli));
    mixin(Rule!("karotte", FoodAndDrink.carrot));
    mixin(Rule!("gurke", FoodAndDrink.cucumber));
    mixin(Rule!("paradeis", FoodAndDrink.tomato));
    mixin(Rule!("paprika", FoodAndDrink.hotPepper));
    mixin(Rule!("stern", TravelAndPlaces.glowingStar));
    mixin(Rule!("erbsen", FoodAndDrink.cucumber));
    mixin(Rule!("linsen", FoodAndDrink.cucumber));
    mixin(Rule!("humus", FoodAndDrink.cucumber));
    mixin(Rule!("rohkost", FoodAndDrink.cucumber));
    mixin(Rule!("fisole", AnimalsAndNature.seedling));
    mixin(Rule!("apfel", FoodAndDrink.redApple));
    mixin(Rule!("äpfel", FoodAndDrink.redApple));
    mixin(Rule!("traube", FoodAndDrink.grapes));
    mixin(Rule!("zwetschke", FoodAndDrink.grapes));
    mixin(Rule!("kirsch", FoodAndDrink.cherries));
    mixin(Rule!("pfirsich", FoodAndDrink.peach));
    mixin(Rule!("nektarine", FoodAndDrink.peach));
    mixin(Rule!("mandarine", FoodAndDrink.tangerine));
    mixin(Rule!("orange", FoodAndDrink.tangerine));
    mixin(Rule!("marille", FoodAndDrink.tangerine));
    mixin(Rule!("birne", FoodAndDrink.pear));
    mixin(Rule!("erdbeer", FoodAndDrink.strawberry));
    mixin(Rule!("banane", FoodAndDrink.banana));
    mixin(Rule!("ananas", FoodAndDrink.pineapple));
    mixin(Rule!("kiwi", FoodAndDrink.kiwiFruit));
    mixin(Rule!("melone", FoodAndDrink.watermelon));
    mixin(Rule!("pudding", FoodAndDrink.custard));
    mixin(Rule!("polenta", FoodAndDrink.earOfCorn));
    mixin(Rule!("croissant", FoodAndDrink.croissant));
    mixin(Rule!("plunder", FoodAndDrink.croissant));
    mixin(Rule!("muffin", FoodAndDrink.cupcake));
    mixin(Rule!("schwarzwurzel", Smileys.pileOfPoo));
    mixin(Rule!("zwiebel", FoodAndDrink.chestnut)); // Ev12
    //mixin(Rule!("knoblauch", FoodAndDrink.garlic)); // Ev12
    mixin(Rule!("zeller", FoodAndDrink.cucumber));
    mixin(Rule!("gemüse", FoodAndDrink.cucumber));
    mixin(Rule!("gnocchi", FoodAndDrink.dumpling));
    mixin(Rule!("joghurt", FoodAndDrink.glassOfMilk));
    mixin(Rule!("jogurt", FoodAndDrink.glassOfMilk));
    mixin(Rule!("pesto", AnimalsAndNature.seedling));
    mixin(Rule!("letscho", FoodAndDrink.cannedFood));
    mixin(Rule!("kresse", AnimalsAndNature.seedling));
    mixin(Rule!("spinat", AnimalsAndNature.leafFlutteringInWind));
    mixin(Rule!("kräuter", AnimalsAndNature.herb));
    mixin(Rule!("kraut", AnimalsAndNature.herb));
    mixin(Rule!("kernöl", Activities.jackOLantern));
    mixin(Rule!("öl", TravelAndPlaces.oilDrum));

    // supper
    if (!d.contains("dreier"))
    {
        mixin(Rule!("eier", FoodAndDrink.egg));
    }
    mixin(Rule!("osterei", FoodAndDrink.egg));
    mixin(Rule!("brot", FoodAndDrink.bread));
    mixin(Rule!("semmel", FoodAndDrink.bread));
    mixin(Rule!("semmerl", FoodAndDrink.bread));
    mixin(Rule!("gebäck", FoodAndDrink.bread));
    mixin(Rule!("kornspitz", FoodAndDrink.baguetteBread));
    mixin(Rule!("breze", FoodAndDrink.pretzel));
    mixin(Rule!("garnierung", Symbols.radioactive));
    mixin(Rule!("garnitur", Symbols.radioactive));
    mixin(Rule!("garniert", Symbols.radioactive));
    mixin(Rule!("gugelhupf", FoodAndDrink.moonCake));
    mixin(Rule!("rührei", FoodAndDrink.egg));
    mixin(Rule!("spiegelei", FoodAndDrink.cooking));
    mixin(Rule!("bergbaron", FoodAndDrink.cheeseWedge));
    mixin(Rule!("emmentaler", FoodAndDrink.cheeseWedge));
    mixin(Rule!("jerome", FoodAndDrink.cheeseWedge));
    mixin(Rule!("tomate", FoodAndDrink.tomato));
    mixin(Rule!("mozzarella", FoodAndDrink.cheeseWedge));
    mixin(Rule!("parmesan", FoodAndDrink.cheeseWedge));
    mixin(Rule!("bojar", FoodAndDrink.cheeseWedge));
    mixin(Rule!("feta", FoodAndDrink.cheeseWedge));
    mixin(Rule!("leberkäs", AnimalsAndNature.unicornFace));
    mixin(Rule!("frankfurter", FoodAndDrink.hotDog));
    mixin(Rule!("käsekrainer", FoodAndDrink.hotDog));
    mixin(Rule!("würst", FoodAndDrink.hotDog));
    mixin(Rule!("hot dog", FoodAndDrink.hotDog));
    mixin(Rule!("schweiz", Flags.flagSwitzerland));
    mixin(Rule!("wurstsalat", FoodAndDrink.stuffedFlatbread));
    mixin(Rule!("platte", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("wurst", FoodAndDrink.hotDog));
    mixin(Rule!("salami", FoodAndDrink.hotDog));
    mixin(Rule!("braunschweiger", FoodAndDrink.hotDog));
    mixin(Rule!("senf", AnimalsAndNature.sheafOfRice));
    mixin(Rule!("ketchup", FoodAndDrink.tomato));
    mixin(Rule!("kren", AnimalsAndNature.sheafOfRice));
    mixin(Rule!("käse", FoodAndDrink.cheeseWedge));
    mixin(Rule!("nudelsalat", FoodAndDrink.stuffedFlatbread));
    mixin(Rule!("nudel", FoodAndDrink.steamingBowl));
    mixin(Rule!("penne", FoodAndDrink.steamingBowl));
    mixin(Rule!("hörnchen", AnimalsAndNature.chipmunk));
    mixin(Rule!("spätzle", FoodAndDrink.steamingBowl));
    mixin(Rule!("spiralen", Objects.dna));
    mixin(Rule!("makkaroni", FoodAndDrink.steamingBowl));
    mixin(Rule!("hauerteller", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("jaus", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("liptauer", FoodAndDrink.forkAndKnife));
    mixin(Rule!("aufstrich", FoodAndDrink.forkAndKnife));
    mixin(Rule!("hummus", FoodAndDrink.forkAndKnife));
    mixin(Rule!("paste", FoodAndDrink.forkAndKnife));
    mixin(Rule!("zucker", TravelAndPlaces.fog));
    mixin(Rule!("zimt", TravelAndPlaces.fog));
    mixin(Rule!("kakao", TravelAndPlaces.fog));
    mixin(Rule!("mohn", TravelAndPlaces.fog));
    mixin(Rule!("topfen", FoodAndDrink.glassOfMilk));
    mixin(Rule!("heringschmaus", Smileys.faceVomiting));
    mixin(Rule!("griechisch", Flags.flagGreece));
    mixin(Rule!("französisch", Flags.flagFrance));
    mixin(Rule!("salat", FoodAndDrink.greenSalad));
    mixin(Rule!("nockerl", FoodAndDrink.dumpling));
    mixin(Rule!("biskuit", FoodAndDrink.cookie));
    mixin(Rule!("kuchen", FoodAndDrink.pie));
    mixin(Rule!("nuss", FoodAndDrink.peanuts));    
    mixin(Rule!("doughnut", FoodAndDrink.doughnut));
    mixin(Rule!("donut", FoodAndDrink.doughnut));
    mixin(Rule!("schoko", FoodAndDrink.chocolateBar));
    mixin(Rule!("schnitten", FoodAndDrink.chocolateBar));
    mixin(Rule!("schnitte", FoodAndDrink.pie));
    mixin(Rule!("strudel", FoodAndDrink.burrito));
    mixin(Rule!("rahm", FoodAndDrink.glassOfMilk));
    mixin(Rule!("sauce tartare", Smileys.sweatDroplets));
    mixin(Rule!("sugo", FoodAndDrink.cannedFood));
    mixin(Rule!("soß", Smileys.sweatDroplets));
    mixin(Rule!("eis", FoodAndDrink.softIceCream));
    mixin(Rule!("dip", TravelAndPlaces.droplet));
    mixin(Rule!("curry", FoodAndDrink.curryRice));
    mixin(Rule!("cocktail", FoodAndDrink.cocktailGlass));
    mixin(Rule!("kalt", TravelAndPlaces.snowflake));

    // "is" rules
    mixin(Rule2!("Ei", FoodAndDrink.egg));
    mixin(Rule2!("Püree", FoodAndDrink.potato));
    mixin(Rule2!("Wachauer Laberl", FoodAndDrink.bread));

    return null;
}

bool contains(string s, string pattern)
{
    import std.string : indexOf;

    pragma(inline, true);
    return (s.indexOf(pattern) >= 0);
}
