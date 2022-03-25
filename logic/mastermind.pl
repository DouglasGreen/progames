/** <module> An implementation of the board game Mastermind.

@author Douglas S. Green
@license GPL
@see https://en.wikipedia.org/wiki/Mastermind_(board_game)
*/
module(mastermind,
    [
        play/0
    ]).

%! play
% Play the game.
play :-
    write_instructions,
    peg_count(N),
    setup(ChosenColors, N),
    guess(ChosenColors).

%! count_color_matches(UserColors:list, ChosenColors:list, ColorMatches:int)
% Count the matches of color, including matches at the same location.
count_color_matches([UserColor|UserColors], ChosenColors, ColorMatches) :-
    append(Base, [UserColor|Other], ChosenColors),
    append(Base, Other, NewChosenColors),
    count_color_matches(UserColors, NewChosenColors, CM1),
    ColorMatches is CM1 + 1.
count_color_matches([UserColor|UserColors], ChosenColors, ColorMatches) :-
    \+ memberchk(UserColor, ChosenColors),
    count_color_matches(UserColors, ChosenColors, ColorMatches).
count_color_matches([], _, 0).

%! count_location_matches(UserColors:list, ChosenColors:list, LocationMatches:int)
% Count the matches of location/color.
count_location_matches([UserColor|UserColors], [ChosenColor|ChosenColors], LocationMatches) :-
    UserColor = ChosenColor,
    count_location_matches(UserColors, ChosenColors, LM1),
    LocationMatches is LM1 + 1.
count_location_matches([UserColor|UserColors], [ChosenColor|ChosenColors], LocationMatches) :-
    UserColor \= ChosenColor,
    count_location_matches(UserColors, ChosenColors, LocationMatches).
count_location_matches([], [], 0).

%! get_colors(UserChars:list, UserColors:list)
% Turn characters into color words
get_colors([UserChar|UserChars], [UserColor|UserColors]) :-
    peg_color(UserColor, UserChar),
    get_colors(UserChars, UserColors).
get_colors([], []).

%! handle_guess(ChosenColors:list, LowInput:string)
% Handle the alternative outcomes of a guess.
handle_guess(_, "q") :-
    writeln("Bye!").
handle_guess(ChosenColors, LowInput) :-
    peg_count(Len),
    \+ string_length(LowInput, Len),
    format("You must guess ~d colors.\n", Len),
    guess(ChosenColors).
handle_guess(ChosenColors, LowInput) :-
    peg_count(Len),
    string_chars(LowInput, UserChars),
    (
        get_colors(UserChars, UserColors);
        format("Color codes not recognized.\n"),
        guess(ChosenColors)
    ),
    count_location_matches(UserColors, ChosenColors, LocationMatches),
    (
        Len = LocationMatches,
        format("You guessed correctly!\n");
        count_color_matches(UserColors, ChosenColors, ColorMatches),

        % Remove the duplicates because we counted location matches twice.
        NetColorMatches is ColorMatches - LocationMatches,

        right_location(RL),
        right_color(RC),
        format("Result: ~d ~w, ~d ~w\n", [LocationMatches, RL, NetColorMatches, RC]),
        guess(ChosenColors)
    ).

%! pick_color(Color:atom)
% Pick a random peg color.
pick_color(Color) :-
    setof(AnyColor, AnyChar^peg_color(AnyColor, AnyChar), Colors),
    length(Colors, N),
    R is random(N),
    nth0(R, Colors, Color).

%! setup(ChosenColors:list, N:int)
% Set up the game with N pegs.
setup([ChosenColor|ChosenColors], N) :-
    N > 0,
    allow_repetition(true),
    pick_color(ChosenColor),
    N1 is N - 1,
    setup(ChosenColors, N1).
setup(ChosenColors, N) :-
    N > 0,
    allow_repetition(false),
    setof(AnyColor, AnyChar^peg_color(AnyColor, AnyChar), Colors),
    random_permutation(Colors, ShuffledColors),
    length(ChosenColors, N),
    append(ChosenColors, _, ShuffledColors).
setup([], 0).

%! write_instructions
% Write the instructions for the game.
write_instructions :-
    peg_count(N),
    format("There are ~d pegs to guess.\n", [N]),
    allow_repetition(AR),
    (
        AR,
        format("The peg colors are allowed to repeat.\n");
        \+ AR,
        format("The peg colors are all different.\n")
    ),
    format("The peg colors and the characters to represent them are:\n"),
    forall(peg_color(AnyColor, AnyChar), format("* ~w (~w)\n", [AnyColor, AnyChar])),
    right_location(RL),
    format("The color used when a peg is the right color and in the right location is: ~w\n", [RL]),
    right_color(RC),
    format("The color used when a peg is the right color but not in the right location is: ~w\n\n", [RC]),
    format("Input your guess of colors as a string of single letter codes, or Q to quit.\n").

%! guess(ChosenColors:list)
% Ask the user for their guess.
guess(ChosenColors) :-
    read_line_to_string(user_input, Input),
    string_lower(Input, LowInput),
    handle_guess(ChosenColors, LowInput).

%! allow_repetition(Repeat:bool)
% Set to true to allow peg colors to repeat.
allow_repetition(true).

%! peg_color(Color:atom, ColorChar:char)
% Add any peg colors you like here.
peg_color(blue, b).
peg_color(green, g).
peg_color(orange, o).
peg_color(purple, p).
peg_color(red, r).
peg_color(yellow, y).

%! peg_count(N:int)
% The number of pegs to use in the code.
peg_count(4).

%! right_color(Color:atom)
% Color to use when a peg is the right color.
right_color(white).

%! right_location(Color:atom)
% Color to use when a peg is the right color and in the right location.
right_location(black).
