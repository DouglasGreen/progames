/** <module> Play the pig game of dice.

Pig is a dice game where the object is to roll more than 100 points. A player loses the round if they roll a 1, called
a pig.

@author Douglas S. Green
@license GPL
*/
module(pig, [play/0]).

%! play.
play :-
    format("Type R to roll, H to hold, Q to quit.~n"),
    human(0, 0, 0).

%! computer(HumanScore:int, ComputerScore:int, Round:int)
% It's the computer's turn to play with the given total scores and the round score.
computer(HumanScore, ComputerScore, Round) :-
    (
        % The computer must always roll during the first round.
        Round = 0,
        ShouldRoll = true,
        !;
        % If the human is winning in the last round, the computer must keep on rolling.
        HumanScore >= 100,
        ComputerScore + Round =< HumanScore,
        ShouldRoll = true,
        !;
        % If the computer is winning in the last round, the computer must stop rolling.
        HumanScore >= 100,
        ComputerScore + Round > HumanScore,
        ShouldRoll = false,
        !;
        % Otherwise the computer should go to 10 and keep rolling 3/4 of the time.
        random_between(1, 4, R),
        (
            Round < 10,
            ShouldRoll = true;
            R > 3,
            ShouldRoll = true;
            R =< 3,
            ShouldRoll = false
        )
    ),
    (
        ShouldRoll,
        roll("The computer", Die, Round, NewRound),
        (
            Die = 1,
            (
                % Because the computer must keep on rolling when it's losing in the last round, it can only lose on a
                % pig.
                HumanScore >= 100,
                HumanScore >= ComputerScore,
                format("You win with a score of ~d to ~d!\n", [HumanScore, ComputerScore]);
                human(HumanScore, ComputerScore, 0)
            );
            Die \= 1,
            computer(HumanScore, ComputerScore, NewRound)
        );
        \+ ShouldRoll,
        NewComputerScore is ComputerScore + Round,
        format("The computer's score is ~d.\n", [NewComputerScore]),
        (
            NewComputerScore >= 100,
            NewComputerScore > HumanScore,
            format("The computer wins with a score of ~d to ~d!\n", [NewComputerScore, HumanScore]),
            !;
            human(HumanScore, NewComputerScore, 0)
        )
    ).

%! human(HumanScore:int, ComputerScore:int, Round:int)
% It's the human's turn to play with the given total scores and the round score.
human(HumanScore, ComputerScore, Round) :-
    get_single_char(Code),
    char_code(Char, Code),
    downcase_atom(Char, Low),
    (
        Low = 'r',
        roll("You", Die, Round, NewRound),
        (
            Die = 1,
            computer(HumanScore, ComputerScore, 0);
            Die \= 1,
            human(HumanScore, ComputerScore, NewRound)
        ),
        !;
        Low = 'h',
        NewHumanScore is HumanScore + Round,
        format("Your score is ~d.\n", [NewHumanScore]),
        computer(NewHumanScore, ComputerScore, 0),
        !;
        Low = 'q',
        writeln("Bye!"),
        !;
        human(HumanScore, ComputerScore, Round)
    ).

%! roll(Player:string, Die:int, Round:int, NewRound:int)
% The player rolls a die yielding a new round score. 
roll(Player, Die, Round, NewRound) :-
    random_between(1, 6, Die),
    (
        Die = 1,
        format("~w rolled a pig!\n", [Player]),
        NewRound = 0;
        Die \= 1,
        NewRound is Round + Die,
        format("~w rolled a ~d for a total of ~d.\n", [Player, Die, NewRound])
    ).
