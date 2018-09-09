/+
                    Copyright 0xEAB 2016 - 2018.
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

    string d = dish.toLower;

    // most important
    mixin(Rule!("zucchini", FoodAndDrink.cucumber));
    mixin(Rule!("kürbis", Activities.jackOLantern));

    // soup
    mixin(Rule!("suppe", FoodAndDrink.potOfFood));
    mixin(Rule!("backerbsen", FoodAndDrink.potOfFood));

    // lunch
    mixin(Rule!("toast", FoodAndDrink.sandwich)); // "Schinken-Käse-Toast"
    mixin(Rule!("spaghetti", FoodAndDrink.spaghetti));
    mixin(Rule!("pasta", FoodAndDrink.spaghetti));
    mixin(Rule!("chili", FoodAndDrink.hotPepper));
    mixin(Rule!("milch", FoodAndDrink.glassOfMilk));
    mixin(Rule!("fisch", AnimalsAndNature.fish));
    mixin(Rule!("lachs", AnimalsAndNature.fish));
    mixin(Rule!("chinesisch", Symbols.japanesePassingGradeButton));
    mixin(Rule!("pizza", FoodAndDrink.pizza));
    mixin(Rule!("pommes", FoodAndDrink.frenchFries));
    mixin(Rule!("augsburger", FoodAndDrink.hotDog));
    mixin(Rule!("reis", FoodAndDrink.cookedRice));
    mixin(Rule!("risotto", FoodAndDrink.cookedRice));
    mixin(Rule!("couscous", FoodAndDrink.cookedRice));
    mixin(Rule!("keule", FoodAndDrink.poultryLeg));
    mixin(Rule!("hühn", AnimalsAndNature.hatchingChick));
    mixin(Rule!("huhn", AnimalsAndNature.hatchingChick));
    mixin(Rule!("rind", AnimalsAndNature.cow));
    mixin(Rule!("fleisch", FoodAndDrink.cutOfMeat));
    mixin(Rule!("schinken", FoodAndDrink.bacon));
    mixin(Rule!("schnitz", AnimalsAndNature.pig));
    mixin(Rule!("schmarr", FoodAndDrink.pancakes));
    mixin(Rule!("fleckerl", FoodAndDrink.bentoBox));
    mixin(Rule!("erdäpfel", FoodAndDrink.potato));
    mixin(Rule!("knödel", FoodAndDrink.dumpling));
    mixin(Rule!("butter", FoodAndDrink.glassOfMilk));
    mixin(Rule!("brokkoli", FoodAndDrink.broccoli));
    mixin(Rule!("broccoli", FoodAndDrink.broccoli));
    mixin(Rule!("karfiol", FoodAndDrink.broccoli));
    mixin(Rule!("karotte", FoodAndDrink.carrot));
    mixin(Rule!("paprika", FoodAndDrink.hotPepper));
    mixin(Rule!("stern", TravelAndPlaces.glowingStar));
    mixin(Rule!("rohkost", FoodAndDrink.cucumber));
    mixin(Rule!("apfel", FoodAndDrink.redApple));
    mixin(Rule!("traube", FoodAndDrink.grapes));
    mixin(Rule!("zwetschke", FoodAndDrink.grapes));
    mixin(Rule!("kirsch", FoodAndDrink.cherries));
    mixin(Rule!("pfirsich", FoodAndDrink.peach));
    mixin(Rule!("birne", FoodAndDrink.pear));
    mixin(Rule!("erdbeer", FoodAndDrink.strawberry));
    mixin(Rule!("banane", FoodAndDrink.banana));
    mixin(Rule!("ananas", FoodAndDrink.pineapple));
    mixin(Rule!("pudding", FoodAndDrink.custard));
    mixin(Rule!("eis", FoodAndDrink.softIceCream));
    mixin(Rule!("schwarzwurzel", Smileys.pileOfPoo));
    mixin(Rule!("zwiebel", FoodAndDrink.chestnut)); // Ev12
    mixin(Rule!("gemüse", FoodAndDrink.cucumber));
    mixin(Rule!("joghurt", FoodAndDrink.glassOfMilk));
    mixin(Rule!("pesto", AnimalsAndNature.seedling));
    mixin(Rule!("kresse", AnimalsAndNature.seedling));
    mixin(Rule!("kräuter", AnimalsAndNature.herb));
    mixin(Rule!("kernöl", Activities.jackOLantern));
    mixin(Rule!("öl", TravelAndPlaces.oilDrum));

    // supper
    mixin(Rule!("brot", FoodAndDrink.bread));
    mixin(Rule!("semmel", FoodAndDrink.bread));
    mixin(Rule!("semmerl", FoodAndDrink.bread));
    mixin(Rule!("garnierung", Symbols.radioactive));
    mixin(Rule!("garnitur", Symbols.radioactive));
    mixin(Rule!("garniert", Symbols.radioactive));
    mixin(Rule!("eier", FoodAndDrink.egg));
    mixin(Rule!("bergbaron", FoodAndDrink.cheeseWedge));
    mixin(Rule!("emmentaler", FoodAndDrink.cheeseWedge));
    mixin(Rule!("tomate", FoodAndDrink.tomato));
    mixin(Rule!("mozzarella", FoodAndDrink.cheeseWedge));
    mixin(Rule!("parmesan", FoodAndDrink.cheeseWedge));
    mixin(Rule!("bojar", FoodAndDrink.cheeseWedge));
    mixin(Rule!("leberkäs", AnimalsAndNature.unicornFace));
    mixin(Rule!("frankfurter", FoodAndDrink.hotDog));
    mixin(Rule!("würst", FoodAndDrink.hotDog));
    mixin(Rule!("wurstsalat", FoodAndDrink.stuffedFlatbread));
    mixin(Rule!("wurst", FoodAndDrink.hotDog));
    mixin(Rule!("salami", FoodAndDrink.hotDog));
    mixin(Rule!("braunschweiger", FoodAndDrink.hotDog));
    mixin(Rule!("senf", AnimalsAndNature.sheafOfRice));
    mixin(Rule!("ketchup", FoodAndDrink.tomato));
    mixin(Rule!("kren", AnimalsAndNature.sheafOfRice));
    mixin(Rule!("käse", FoodAndDrink.cheeseWedge));
    mixin(Rule!("nudelsalat", FoodAndDrink.stuffedFlatbread));
    mixin(Rule!("nudel", FoodAndDrink.steamingBowl));
    mixin(Rule!("hörnchen", AnimalsAndNature.chipmunk));
    mixin(Rule!("hauerteller", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("jaus", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("platte", FoodAndDrink.forkAndKnifeWithPlate));
    mixin(Rule!("aufstrich", FoodAndDrink.forkAndKnife));
    mixin(Rule!("pastete", FoodAndDrink.forkAndKnife));
    mixin(Rule!("kakao-zucker", TravelAndPlaces.fog));
    mixin(Rule!("salat", FoodAndDrink.greenSalad));
    mixin(Rule!("kuchen", FoodAndDrink.pie));
    mixin(Rule!("soß", Smileys.sweatDroplets));

    return null;
}

bool contains(string s, string pattern)
{
    import std.string : indexOf;

    pragma(inline, true);
    return (s.indexOf(pattern) >= 0);
}
