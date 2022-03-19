/** <module> This hangman program provides word definitions to be more educational.

The definitions are taken from Wiktionary.

@author Douglas S. Green
@license GPL
@see https://en.wiktionary.org/wiki/Wiktionary:Main_Page
*/

%! play
% Play the game
play :-
    pick_word(Word, Cat, Def),
    string_chars(Word, WordChars),
    length(WordChars, WordLen),
    format("(~w) ~w\n\n", [Cat, Def]),
    make_guess(WordChars, WordLen, [], 6).

%! make_guess(WordChars:list, WordLen:int, Guesses:list, GuessCount:int)
% Make the current guess and determine if it's correct and if the user won or lost.
make_guess(WordChars, _, _, 0) :-
    string_chars(Word, WordChars),
    format("\n\nYou lose!\n\nThe word was: ~w\n\n", [Word]),
    !.
make_guess(WordChars, WordLen, Guesses, GuessCount) :-
    write_guess(GuessCount),
    get_single_char(Code),
    char_code(Char, Code),
    (
        memberchk(Char, WordChars),
        format("yes\n"),
        GuessCount1 is GuessCount,
        !;
        format("no\n"),
        GuessCount1 is GuessCount - 1
    ),
    append(Guesses, [Char], NewGuesses),
    writeln(NewGuesses),
    write_word(WordChars, NewGuesses, Win),
    (
        Win,
        format('\n\nYou win!\n'),
        !;
        make_guess(WordChars, WordLen, NewGuesses, GuessCount1)
    ).

%! write_word(Chars:list, NewGuesses:list, Win:bool)
% Write the current word with correct letters or blanks.
write_word([Char|Chars], NewGuesses, Win) :-
    memberchk(Char, NewGuesses),
    format('~w ', [Char]),
    write_word(Chars, NewGuesses, Win).
write_word([Char|Chars], NewGuesses, false) :-
    \+ memberchk(Char, NewGuesses),
    write('_ '),
    write_word(Chars, NewGuesses, false).
write_word([], _, Win) :-
    (
        var(Win),
        Win = true,
        !;
        Win = false
    ).

%! pick_word(Word:string, Cat:atom, Def:string)
% Pick a random word.
pick_word(Word, Cat, Def) :-
    setof((Word1, Cat1, Def1), word(Word1, Cat1, Def1), Words),
    length(Words, N),
    R is random(N),
    nth0(R, Words, (Word, Cat, Def)).

%! write_guess(GuessCount:int)
% Write how many guesses the user has left.
write_guess(GuessCount) :-
    (
        GuessCount = 1,
        Plural = "",
        !;
        Plural = "es"
    ),
    format("\nYou have ~d guess~w.\n", [GuessCount, Plural]).

%! word(Word:string, Cat:atom, Def:string)
% A list of words taken from Wiktionary.
word("abase", 'v.', "To lower, as in condition in life, office, rank, etc., so as to cause pain or hurt feelings; to degrade, to depress, to humble, to humiliate.").
word("abase", 'v.', "To lower in value, in particular by altering the content of alloys in coins; to debase.").
word("abbess", 'n.', "A female superior or governess of a nunnery, or convent of nuns, having the same authority over the nuns which the abbots have over the monks.").
word("abbess", 'n.', "A woman who runs a brothel; a woman employed by a prostitute to find clients.").
word("abbey", 'n.', "A monastery or society of people, secluded from the world and devoted to religion and celibacy, which is headed by an abbot or abbess; also, the monastic building or buildings.").
word("abbey", 'n.', "The church of a monastery.").
word("abbot", 'n.', "The pastor and/or administrator of an order, including minor and major orders starting with the minor order of porter.").
word("abbot", 'n.', "The superior or head of an abbey or monastery.").
word("abdicate", 'v.', "To relinquish or renounce a throne, or other high office or dignity; to renounce sovereignty.").
word("abdicate", 'v.', "To disclaim and expel from the family, as a father his child; to disown; to disinherit.").
word("abdomen", 'n.', "The cavity of the belly, which is lined by the peritoneum, and contains the viscera; often restricted in humans to the part between the diaphragm and the commencement of the pelvis, the remainder being called the pelvic cavity.").
word("abdomen", 'n.', "The belly, or that part of the body between the thorax and the pelvis, not including the back; or in some lower vertebrates, the portion between the cardiac and caudal regions.").
word("abdominal", 'n.', "A fish of the order Abdominales.").
word("abdominal", 'n.', "An abdominal muscle.").
word("abduction", 'n.', "The wrongful, and usually forcible, carrying off of a human being.").
word("abduction", 'n.', "Leading away; a carrying away.").
word("abed", 'adv.', "In bed, or on the bed; confined to bed.").
word("abed", 'adv.', "To childbed").
word("aberration", 'n.', "The convergence to different foci, by a lens or mirror, of rays of light emanating from one and the same point, or the deviation of such rays from a single focus; a defect in a focusing mechanism that prevents the intended focal point.").
word("aberration", 'n.', "The act of wandering; deviation from truth, moral rectitude; abnormal; divergence from the straight, correct, proper, normal, or from the natural state.").
word("abet", 'v.', "To incite; to assist or encourage by aid or countenance in crime.").
word("abet", 'v.', "To support, countenance, maintain, uphold, or aid (any good cause, opinion, or action); to maintain.").
word("abeyance", 'n.', "Expectancy; a condition when an ownership of real property is undetermined; lapse in succession of ownership of estate, or title.").
word("abeyance", 'n.', "Expectancy of a title, its right in existence but its exercise suspended.").
word("abhorrence", 'n.', "Extreme aversion or detestation; the feeling of utter dislike or loathing.").
word("abhorrence", 'n.', "A person or thing that is loathsome; a detested thing.").
word("abhorrent", 'adj.', "Detestable or repugnant.").
word("abhorrent", 'adj.', "Contrary to something; discordant.").
word("abidance", 'n.', "Adherence; compliance; conformity.").
word("abidance", 'n.', "The act of abiding or continuing; abode; stay; continuance; dwelling.").
word("abject", 'adj.', "Sunk to or existing in a low condition, state, or position.").
word("abject", 'adj.', "Cast down in spirit or hope; degraded; servile; grovelling; despicable; lacking courage; offered in a humble and often ingratiating spirit.").
word("abjure", 'v.', "To cause one to renounce or recant.").
word("abjure", 'v.', "To renounce upon oath; to forswear; to disavow.").
word("ablution", 'n.', "The act of washing something.").
word("ablution", 'n.', "The ritual consumption by the deacon or priest of leftover sacred wine of host after the Communion.").
word("abnegate", 'v.', "To deny (oneself something); to renounce or give up (a right, a power, a claim, a privilege, a convenience).").
word("abnegate", 'v.', "To relinquish; to surrender; to abjure.").
word("abnormal", 'adj.', "Not conforming to rule or system; deviating from the usual or normal type.").
word("abnormal", 'adj.', "Of or pertaining to that which is irregular, in particular, behaviour that deviates from norms of social propriety or accepted standards of mental health.").
word("abominable", 'adj.', "Worthy of, or causing, abhorrence, as a thing of evil omen; odious in the utmost degree; very hateful; detestable; loathsome; execrable.").
word("abominable", 'adj.', "Very bad or inferior.").
word("abominate", 'v.', "To feel disgust towards; to loathe or detest thoroughly; to hate in the highest degree, as if with religious dread.").
word("abominate", 'v.', "To dislike strongly.").
word("abomination", 'n.', "A state that excites detestation or abhorrence; pollution.").
word("abomination", 'n.', "The feeling of extreme disgust and hatred").
word("aboriginal", 'adj.', "First according to historical or scientific records; original; indigenous; primitive.").
word("aboriginal", 'adj.', "Living in a land before colonization by the Europeans.").
word("aborigines", 'n.', "The inhabitants of a location before colonization by the Europeans occurred.").
word("aborigines", 'n.', "The original people of a location, originally Greek and Roman.").
word("abrade", 'v.', "To rub or wear off; erode.").
word("abrade", 'v.', "To wear down or exhaust, as a person; irritate.").
word("abrasion", 'n.', "The substance thus rubbed off; debris.").
word("abrasion", 'n.', "The effect of mechanical erosion of rock, especially a river bed, by rock fragments scratching and scraping it.").
word("abridge", 'v.', "To shorten or contract by using fewer words, yet retaining the sense; to epitomize; to condense .").
word("abridge", 'v.', "To make shorter; to shorten in duration or extent.").
word("abridgment", 'n.', "Any of various brief statements of case law made before modern reporting of legal cases.").
word("abridgment", 'n.', "An epitome or compend, as of a book; a shortened or abridged form; an abbreviation.").
word("abrogate", 'v.', "To annul by an authoritative act; to abolish by the authority of the maker or her or his successor; to repeal; — applied to the repeal of laws, decrees, ordinances, the abolition of customs, etc.").
word("abrogate", 'v.', "To block a process or function.").
word("abrupt", 'adj.', "Having sudden transitions from one subject or state to another; unconnected; disjointed.").
word("abrupt", 'adj.', "Suddenly terminating, as if cut off; truncate.").
word("abscess", 'n.', "A cavity caused by tissue destruction, usually because of infection, filled with pus and surrounded by inflamed tissue.").
word("abscission", 'n.', "The act or process of cutting off.").
word("abscission", 'n.', "The state of being cut off.").
word("abscond", 'v.', "To flee, often secretly; to steal away, particularly to avoid arrest or prosecution.").
word("abscond", 'v.', "To conceal; to take away.").
word("absence", 'n.', "Failure to be present where one is expected, wanted, or needed; nonattendance; deficiency.").
word("absence", 'n.', "The period of someone being away.").
word("absolution", 'n.', "The forgiveness of sins, in a general sense.").
word("absolution", 'n.', "An acquittal, or sentence of a judge declaring an accused person innocent.").
word("absolve", 'v.', "To finish; to accomplish.").
word("absolve", 'v.', "To resolve; to explain; to solve.").
word("absorb", 'v.', "To suck up; to drink in; to imbibe, like a sponge or as the lacteals of the body; to chemically take in.").
word("absorb", 'v.', "To engulf, as in water; to swallow up.").
word("absorption", 'n.', "Entire engrossment or occupation of the mind.").
word("absorption", 'n.', "The act or process of absorbing or of being absorbed as,").
word("abstain", 'v.', "Refrain from (something or doing something); keep from doing, especially an indulgence.").
word("abstain", 'v.', "Hinder; keep back; withhold.").
word("abstemious", 'adj.', "Refraining from freely consuming food or strong drink; sparing in diet; abstinent, temperate.").
word("abstemious", 'adj.', "Marked by, or spent in, abstinence.").
word("abstinence", 'n.', "The practice of self-denial; self-restraint; forebearance from anything.").
word("abstinence", 'n.', "Self-denial; abstaining; or forebearance of anything.").
word("abstruse", 'adj.', "Difficult to comprehend or understand.").
word("abstruse", 'adj.', "Concealed or hidden out of the way; secret.").
word("absurd", 'adj.', "Contrary to reason or propriety; obviously and flatly opposed to manifest truth; inconsistent with the plain dictates of common sense; logically contradictory; nonsensical; ridiculous; silly.").
word("absurd", 'adj.', "Having no rational or orderly relationship to people's lives; meaningless; lacking order or value.").
word("abundant", 'adj.', "Fully sufficient; found in copious supply; in great quantity; overflowing.").
word("abundant", 'adj.', "Richly supplied; wealthy; possessing in great quantity.").
word("abusive", 'adj.', "Prone to treat someone badly by coarse, insulting words or other maltreatment; vituperative; reproachful; scurrilous.").
word("abusive", 'adj.', "Wrongly used; perverted; misapplied; unjust; illegal.").
word("abut", 'v.', "To touch by means of a mutual border, edge or end; to border on; to lie adjacent (to); to be contiguous (said of an area of land)").
word("abut", 'v.', "To lean against on one end; to end on, of a part of a building or wall.").
word("abyss", 'n.', "A bottomless or unfathomed depth, gulf, or chasm; hence, any deep, immeasurable; any void space.").
word("abyss", 'n.', "Hell; the bottomless pit; primeval chaos; a confined subterranean ocean.").
word("academic", 'adj.', "Having little practical use or value, as by being overly detailed, unengaging, or theoretical; having no practical importance.").
word("academic", 'adj.', "So scholarly as to be unaware of the outside world; lacking in worldliness.").
word("academician", 'n.', "A member or follower of an academy, or society for promoting science, art, or literature, such as the French Academy, or the Royal Academy of Arts.").
word("academician", 'n.', "A member (especially a senior one) of the faculty at a college or university; an academic.").
word("academy", 'n.', "A society of learned people united for the advancement of the arts and sciences, and literature, or some particular art or science.").
word("academy", 'n.', "An institution for the study of higher learning; a college or a university; typically a private school.").
word("accede", 'v.', "To agree or assent to a proposal or a view; to give way.").
word("accede", 'v.', "To become a party to an agreement or a treaty.").
word("accelerate", 'v.', "To cause to move faster; to quicken the motion of; to add to the speed of.").
word("accelerate", 'v.', "To become faster; to begin to move more quickly.").
word("accept", 'v.', "To receive something willingly.").
word("accept", 'v.', "To agree to pay.").
word("access", 'n.', "A way or means of approaching or entering; an entrance; a passage.").
word("access", 'n.', "An outburst of an emotion; a paroxysm; a fit of passion.").
word("accessible", 'adj.', "Capable of being used or seen.").
word("accessible", 'adj.', "Obtainable; to be got at.").
word("accession", 'n.', "The act of coming to or reaching a throne, an office, or dignity.").
word("accession", 'n.', "A coming to; the act of acceding and becoming joined").
word("accessory", 'n.', "Something that belongs to part of another main thing; something additional and subordinate, an attachment.").
word("accessory", 'n.', "An article that completes one's basic outfit, such as a scarf or gloves.").
word("acclaim", 'v.', "To shout; to call out.").
word("acclaim", 'v.', "To salute or praise with great approval; to compliment; to applaud; to welcome enthusiastically.").
word("accommodate", 'v.', "To change focal length in order to focus at a different distance.").
word("accommodate", 'v.', "To adapt oneself; to be conformable or adapted; become adjusted.").
word("accompaniment", 'n.', "A part, usually performed by instruments, that gives support or adds to the background in music, or adds for ornamentation; also, the harmony of a figured bass.").
word("accompaniment", 'n.', "That which accompanies; something that attends as a circumstance, or which is added to give greater completeness to the principal thing, or by way of ornament, or for the sake of symmetry.").
word("accompanist", 'n.', "The performer in music who takes the accompanying part.").
word("accompany", 'v.', "To go with or attend as a companion or associate; to keep company with; to go along with.").
word("accompany", 'v.', "To associate in a company; to keep company.").
word("accomplice", 'n.', "An associate in the commission of a crime; a participator in an offense, whether a principal or an accessory.").
word("accomplice", 'n.', "A cooperator.").
word("accomplish", 'v.', "To fill out a form").
word("accomplish", 'v.', "To gain; to obtain.").
word("accordion", 'n.', "A small, portable, keyed wind instrument, whose tones are generated by play of the wind from a squeezed bellows upon free metallic reeds.").
word("accordion", 'n.', "A vertical list of items that can be individually expanded and collapsed to reveal their contents.").
word("accost", 'v.', "To approach and speak to boldly or aggressively, as with a demand or request.").
word("accost", 'v.', "To speak to first; to address; to greet.").
word("account", 'n.', "A statement in general of reasons, causes, grounds, etc., explanatory of some event; a reason of an action to be done.").
word("account", 'n.', "A reckoning; computation; calculation; enumeration; a record of some reckoning.").
word("accouter", 'v.', "To furnish with dress or equipments, especially those for military service").
word("accredit", 'v.', "To put or bring into credit; to invest with credit or authority; to sanction.").
word("accredit", 'v.', "To send with letters credential, as an ambassador, envoy, or diplomatic agent; to authorize, as a messenger or delegate.").
word("accumulate", 'v.', "To gradually grow or increase in quantity or number.").
word("accumulate", 'v.', "To take a higher degree at the same time with a lower degree, or at a shorter interval than usual.").
word("accuracy", 'n.', "Exact conformity to truth, or to a rule or model; degree of conformity of a measure to a true or standard value.").
word("accuracy", 'n.', "The state of being accurate; being free from mistakes, this exemption arising from carefulness; exactness; correctness").
word("accurate", 'adj.', "Telling the truth or giving a true result; exact; not defective or faulty").
word("accurate", 'adj.', "Deviating only slightly or within acceptable limits.").
word("accursed", 'adj.', "Doomed to destruction or misery; cursed; anathematized.").
word("accursed", 'adj.', "Hateful; detestable, loathsome.").
word("accusation", 'n.', "A formal charge brought against a person in a court of law.").
word("accusation", 'n.', "An allegation.").
word("accusatory", 'adj.', "Pertaining to, or containing, an accusation.").
word("accuse", 'v.', "To charge with having committed a crime or offence").
word("accuse", 'v.', "To find fault with, blame, censure").
word("accustom", 'v.', "To make familiar by use; to cause to accept; to habituate, familiarize, or inure.").
word("accustom", 'v.', "To be wont.").
word("acerbity", 'n.', "Sourness of taste, with bitterness and astringency, like that of unripe fruit.").
word("acerbity", 'n.', "Harshness, bitterness, or severity").
word("acetate", 'n.', "Any salt or ester of acetic acid.").
word("acetate", 'n.', "A transparent sheet used for overlays.").
word("acetic", 'adj.', "Of, pertaining to, or producing vinegar").
word("acetic", 'adj.', "Of or pertaining to acetic acid or its derivatives").
word("ache", 'v.', "To suffer pain; to be the source of, or be in, pain, especially continued dull pain; to be distressed.").
word("ache", 'v.', "To cause someone or something to suffer pain.").
word("achromatic", 'adj.', "Uncolored; not absorbing color from a fluid; -- said of tissue").
word("achromatic", 'adj.', "Having only the diatonic notes of the scale; not modified by accidentals.").
word("acid", 'n.', "A sour substance.").
word("acidify", 'v.', "To neutralize alkalis.").
word("acidify", 'v.', "To sour; to embitter.").
word("acknowledge", 'v.', "To admit the knowledge of; to recognize as a fact or truth; to declare one's belief in").
word("acknowledge", 'v.', "To own as genuine or valid; to assent to (a legal instrument) to give it validity; to avow or admit in legal form.").
word("acknowledgment", 'n.', "A recognition as genuine or valid; an avowing or admission in legal form.").
word("acknowledgment", 'n.', "The act of recognizing in a particular character or relationship; recognition of existence, authority, truth, or genuineness.").
word("acme", 'n.', "A high point; the highest point of any range, the most developed stage of any process, or the culmination of any field or historical period.").
word("acme", 'n.', "A paragon; a person or thing representing such a high point.").
word("acoustic", 'adj.', "Pertaining to the sense of hearing, the organs of hearing, or the science of sounds.").
word("acoustic", 'adj.', "Naturally producing or produced by an instrument without electrical amplification.").
word("acquaint", 'v.', "To furnish or give experimental knowledge of; to make (one) know; to make familiar.").
word("acquaint", 'v.', "To familiarize; to accustom.").
word("acquiesce", 'v.', "To rest satisfied, or apparently satisfied, or to rest without opposition and discontent (usually implying previous opposition or discontent); to accept or consent by silence or by omitting to object.").
word("acquiesce", 'v.', "To concur upon conviction; to assent to; usually, to concur, not heartily but so far as to forbear opposition.").
word("acquiescence", 'n.', "A silent or passive assent or submission, or a submission with apparent content, distinguished from avowed consent on the one hand, and on the other, from opposition or open discontent; quiet satisfaction.").
word("acquiescence", 'n.', "Inaction, passivity, or neglect to take legal action when it is called for in order to assert, preserve, or safeguard a right, and which inaction implies the abandonment of said right.").
word("acquire", 'v.', "To gain, usually by one's own exertions; to get as one's own").
word("acquire", 'v.', "To sample signals and convert them into digital values.").
word("acquisition", 'n.', "The process of sampling signals that measure real world physical conditions and converting these signals into digital numeric values that can be manipulated by a computer.").
word("acquisition", 'n.', "The thing acquired or gained; a gain.").
word("acquit", 'v.', "To discharge, release, or set free from a burden, duty, liability, or obligation, or from an accusation or charge.").
word("acquit", 'v.', "To release, to rescue, to set free.").
word("acquittal", 'n.', "Payment of a debt or other obligation; reparations, amends.").
word("acquittal", 'n.', "A legal decision that someone is not guilty with which they have been charged, or the formal dismissal of a charge by some other legal process.").
word("acquittance", 'n.', "The release from a debt, or from some obligation or duty; exemption.").
word("acquittance", 'n.', "A writing which is evidence of a discharge; a receipt in full, which bars a further demand.").
word("acreage", 'n.', "An area of land measured in acres.").
word("acreage", 'n.', "Size, as measured in acres.").
word("acrid", 'adj.', "Sharp and harsh, or bitter and not to the taste.").
word("acrid", 'adj.', "Caustic; bitter; bitterly irritating.").
word("acrimonious", 'adj.', "Harsh and sharp, or bitter and not pleasant to the taste; acrid, pungent.").
word("acrimonious", 'adj.', "Angry, acid, and sharp in delivering argumentative replies; bitter, mean-spirited, sharp in language or tone.").
word("acrimony", 'n.', "A sharp and bitter hatred.").
word("actionable", 'adj.', "Affording grounds for legal action.").
word("actionable", 'adj.', "That can be acted on; that can be used as the basis for taking action.").
word("actuality", 'n.', "A short early motion picture.").
word("actuality", 'n.', "The state of existing; existence.").
word("actuary", 'n.', "A professional who calculates financial values associated with uncertain events subject to risk, such as insurance premiums or pension contributions.").
word("actuary", 'n.', "Registrar, clerk.").
word("actuate", 'v.', "To activate, or to put into motion; to animate.").
word("actuate", 'v.', "To incite to action; to motivate.").
word("acumen", 'n.', "Quickness of perception or discernment; penetration of mind; the faculty of nice discrimination.").
word("acumen", 'n.', "A bony, often sharp, protuberance, especially that of the ischium.").
word("acute", 'adj.', "Of a triangle: having all three interior angles measuring less than 90 degrees.").
word("acute", 'adj.', "Of an angle: less than 90 degrees.").
word("adamant", 'n.', "An imaginary rock or mineral of impenetrable hardness; a name given to the diamond and other substances of extreme hardness.").
word("adamant", 'n.', "An embodiment of impregnable hardness.").
word("addendum", 'n.', "The height by which the tooth of a gear projects beyond (outside for external, or inside for internal) the standard pitch circle or pitch line.").
word("addendum", 'n.', "Something to be added; especially text added as an appendix or supplement to a document.").
word("addle", 'v.', "To cause fertilised eggs to lose viability, by killing the developing embryo within through shaking, piercing, freezing or oiling, without breaking the shell.").
word("addle", 'v.', "To earn, earn by labor; earn money or one's living.").
word("adduce", 'v.', "To bring forward or offer, as an argument, passage, or consideration which bears on a statement or case; to cite; to allege.").
word("adhere", 'v.', "To stick fast or cleave, as a glutinous substance does; to become joined or united.").
word("adhere", 'v.', "To be consistent or coherent; to be in accordance; to agree.").
word("adherence", 'n.', "A close physical union of two objects.").
word("adherence", 'n.', "Faithful support for some cause.").
word("adherent", 'adj.', "Having the quality of clinging or sticking fast to something.").
word("adherent", 'adj.', "Attaching or pressing against a different organ.").
word("adhesion", 'n.', "Persistent attachment or loyalty.").
word("adhesion", 'n.', "The frictional grip on a surface, of wheels, shoes etc.").
word("adjacency", 'n.', "The quality of being adjacent, or near enough so as to touch.").
word("adjacent", 'n.', "Something that lies next to something else, especially the side of a right triangle that is neither the hypotenuse nor the opposite.").
word("adjudge", 'v.', "To deem or determine to be.").
word("adjudge", 'v.', "To declare to be.").
word("adjunct", 'n.', "A person associated with another, usually in a subordinate position; a colleague.").
word("adjunct", 'n.', "An appendage; something attached to something else in a subordinate capacity.").
word("adjuration", 'n.', "A solemn oath.").
word("adjuration", 'n.', "A grave warning.").
word("adjutant", 'adj.', "Assistant; who helps a higher-ranking officer.").
word("administrator", 'n.', "One who is responsible for software installation, management, information and maintenance of a computer or network").
word("administrator", 'n.', "One who administers affairs; one who directs, manages, executes, or dispenses, whether in civil, judicial, political, or ecclesiastical affairs; a manager").
word("admissible", 'adj.', "Describing a heuristic that never overestimates the cost of reaching a goal.").
word("admissible", 'adj.', "Capable or deserving to be admitted, accepted or allowed; allowable, permissible, acceptable.").
word("admittance", 'n.', "Permission to enter, the power or right of entrance.").
word("admittance", 'n.', "The act of admitting.").
word("admonish", 'v.', "To advise against wrongdoing; to caution; to warn against danger or an offense.").
word("admonish", 'v.', "To inform or notify of a fault; to rebuke gently or kindly, but seriously; to tell off.").
word("admonition", 'n.', "Gentle or friendly reproof; counseling against fault or oversight; warning.").
word("ado", 'n.', "Trouble; troublesome business; fuss, commotion").
word("adoration", 'n.', "The act of adoring; loving devotion or fascination.").
word("adoration", 'n.', "An act of religious worship.").
word("adroit", 'adj.', "Deft, dexterous, or skillful.").
word("adulterant", 'n.', "That which adulterates, or reduces the purity of something.").
word("adulterate", 'v.', "To make less valuable or spoil (something) by adding impurities or other substances.").
word("adulterate", 'v.', "To corrupt, to debase (someone or something).").
word("adumbrate", 'v.', "To give a vague outline.").
word("adumbrate", 'v.', "To obscure or overshadow.").
word("advent", 'n.', "Arrival; onset; a time when something first comes or appears").
word("adverse", 'adj.', "Opposed; contrary; opposing one's interests or desire.").
word("adverse", 'adj.', "Unfavorable; antagonistic in purpose or effect; hostile; actively opposing one's interests or wishes; contrary to one's welfare; acting against; working in an opposing direction.").
word("adversity", 'n.', "The state of adverse conditions; state of misfortune or calamity.").
word("adversity", 'n.', "An event that is adverse; calamity.").
word("advert", 'v.', "To call attention, refer.").
word("advert", 'v.', "To take notice, to pay attention.").
word("advertiser", 'n.', "A periodical in which advertisements can be published by individuals.").
word("advertiser", 'n.', "One who advertises.").
word("advisory", 'adj.', "Able to give advice.").
word("advisory", 'adj.', "Containing advice; advising.").
word("advocacy", 'n.', "The act of arguing in favour of, or supporting someone or something").
word("advocacy", 'n.', "The practice of supporting someone to make their voice heard").
word("advocate", 'n.', "Anyone who argues the case of another; an intercessor.").
word("advocate", 'n.', "A person who supports others to make their voices heard, or ideally for them to speak up for themselves.").
word("aerial", 'adj.', "Living or taking place in the air.").
word("aerial", 'adj.', "Pertaining to the air or atmosphere; atmospheric.").
word("aeronaut", 'n.', "A person who travels through the air in an airship or balloon.").
word("aeronautics", 'n.', "The design, construction, mathematics and mechanics of aircraft and other flying objects").
word("aeronautics", 'n.', "The theory and practice of aircraft navigation").
word("aerostat", 'n.', "An aircraft, such as a dirigible or balloon, that derives its lift from buoyancy rather than from wings or rotors.").
word("aerostat", 'n.', "A moored balloon flown in a semi-permanent manner, such as a border patrol monitoring balloon affixed at 18,000 feet (~6 km).").
word("aerostatics", 'n.', "The study of gases in equilibrium and of balloons or aircraft in varying atmospheric conditions").
word("affable", 'adj.', "Receiving others kindly and conversing with them in a free and friendly manner; friendly, courteous, sociable.").
word("affable", 'adj.', "Mild; benign.").
word("affect", 'v.', "To aim for, to try to obtain.").
word("affect", 'v.', "To burden (property) with a fixed charge or payment, or other condition or restriction.").
word("affectation", 'n.', "An attempt to assume or exhibit what is not natural or real; false display; artificial show.").
word("affectation", 'n.', "An unusual mannerism.").
word("affiliate", 'n.', "Someone or something, especially, a television station, that is associated with a larger, related organization, such as a television network; a member of a group of associated things.").
word("affirmative", 'adj.', "Pertaining to truth; asserting that something is; affirming").
word("affirmative", 'adj.', "Pertaining to any assertion or active confirmation that favors a particular result").
word("affix", 'v.', "To fix or fasten figuratively; with on or upon.").
word("affix", 'v.', "To attach.").
word("affluence", 'n.', "An abundant flow or supply.").
word("affluence", 'n.', "An abundance of wealth.").
word("affront", 'n.', "An open or intentional offense, slight, or insult.").
word("affront", 'n.', "A hostile encounter or meeting.").
word("afoot", 'adv.', "In motion; in action; astir; stirring; in progress.").
word("afoot", 'adv.', "On foot.").
word("aforesaid", 'adj.', "Previously stated; said or named before.").
word("afresh", 'adv.', "Anew; again; once more").
word("afterthought", 'n.', "A reflection after an act; a later or subsequent thought, action, or expedient.").
word("afterthought", 'n.', "Something additional to the original plan or concept.").
word("agglomerate", 'v.', "To wind or collect into a ball; hence, to gather into a mass or anything like a mass.").
word("aggrandize", 'v.', "To make great or greater in power, rank, honor, or wealth (applied to persons, countries, etc.).").
word("aggrandize", 'v.', "To make appear great or greater; to exalt.").
word("aggravate", 'v.', "To make (an offence) worse or more severe; to increase in offensiveness or heinousness.").
word("aggravate", 'v.', "To make worse; to exacerbate.").
word("aggravation", 'n.', "An extrinsic circumstance or accident which increases the guilt of a crime or the misery of a calamity.").
word("aggravation", 'n.', "The act of aggravating, or making worse; used of evils, natural or moral; the act of increasing in severity or heinousness; something additional to a crime or wrong and enhancing its guilt or injurious consequences.").
word("aggregate", 'n.', "A mass, assemblage, or sum of particulars; something consisting of elements but considered as a whole.").
word("aggregate", 'n.', "A mass formed by the union of homogeneous particles; – in distinction from a compound, formed by the union of heterogeneous particles.").
word("aggress", 'v.', "To commit the first act of hostility or offense against; to begin a quarrel or controversy with someone; to make an attack against someone.").
word("aggress", 'v.', "To set upon; to attack.").
word("aggression", 'n.', "The practice or habit of launching attacks.").
word("aggression", 'n.', "The act of initiating hostilities or invasion.").
word("aggrieve", 'v.', "To grieve; to lament.").
word("aggrieve", 'v.', "To cause someone to feel pain or sorrow to; to afflict").
word("aghast", 'adj.', "Terrified; struck with amazement; showing signs of terror or horror.").
word("agile", 'adj.', "Having the faculty of quick motion in the limbs; apt or ready to move").
word("agile", 'adj.', "Characterised by quick motion").
word("agitate", 'v.', "To set in motion; to actuate.").
word("agitate", 'v.', "To revolve in the mind, or view in all its aspects; to consider, to devise.").
word("agrarian", 'adj.', "Of, or relating to, the ownership, tenure and cultivation of land.").
word("agrarian", 'adj.', "Agricultural or rural.").
word("ailment", 'n.', "Something which ails one; a disease; sickness.").
word("airy", 'adj.', "Relating to the spirit or soul; delicate; graceful.").
word("airy", 'adj.', "Not based on reality; having no solid foundation").
word("akin", 'adj.', "}} Allied by nature; similar; partaking of the same properties; of the same kind.").
word("akin", 'adj.', "Of the same kin; related by blood.").
word("alabaster", 'n.', "A fine-grained white or lightly-tinted variety of gypsum, used ornamentally.").
word("alabaster", 'n.', "A variety of calcite, translucent and sometimes banded.").
word("alacrity", 'n.', "Eagerness; liveliness; enthusiasm.").
word("alacrity", 'n.', "Promptness; speed.").
word("albino", 'n.', "A person or animal congenitally lacking melanin pigmentation in the skin, eyes, and hair or feathers (or more rarely only in the eyes); one born with albinism.").
word("album", 'n.', "A book specially designed to keep photographs, stamps, or autographs.").
word("album", 'n.', "A jacket or cover for such a phonograph record.").
word("alchemy", 'n.', "The ancient search for a universal panacea, and of the philosopher's stone, that eventually developed into chemistry.").
word("alchemy", 'n.', "The causing of any sort of mysterious sudden transmutation.").
word("alcohol", 'n.', "Any of a class of organic compounds (such as ethanol) containing a hydroxyl functional group (-OH).").
word("alcohol", 'n.', "Any very fine powder.").
word("alcoholism", 'n.', "A chronic disease caused by compulsive and uncontrollable consumption of alcoholic beverages, leading to addiction and deterioration in health and social functioning.").
word("alcoholism", 'n.', "Acute alcohol poisoning.").
word("alcove", 'n.', "A small recessed area set off from a larger room.").
word("alcove", 'n.', "A shady retreat.").
word("alder", 'n.', "Any of several trees or shrubs of the genus Alnus, belonging to the birch family.").
word("alder", 'n.', "An alderman or alderwoman.").
word("alderman", 'n.', "A member of a municipal legislative body in a city or town.").
word("alderman", 'n.', "A half-crown coin; its value, 30 pence.").
word("aldermanship", 'n.', "The condition, position, or office of an alderman.").
word("alias", 'n.', "Another name; an assumed name.").
word("alias", 'n.', "An abbreviation that replaces a string of commands and thereby reduces typing when performing routine actions or tasks.").
word("alien", 'n.', "A person, animal, plant, or other thing which is from outside the family, group, organization, or territory under consideration.").
word("alien", 'n.', "A foreigner residing in a country.").
word("alienable", 'adj.', "Capable of being alienated, sold, or transferred to another").
word("alienate", 'v.', "To estrange; to withdraw affections or attention from; to make indifferent or averse, where love or friendship before subsisted.").
word("alienate", 'v.', "To convey or transfer to another, as title, property, or right; to part voluntarily with ownership of.").
word("alienation", 'n.', "Emotional isolation or dissociation.").
word("alienation", 'n.', "The transfer of property to another person.").
word("aliment", 'n.', "Nourishment, sustenance.").
word("aliment", 'n.', "Food.").
word("alkali", 'n.', "One of a class of caustic bases, such as soda, soda ash, caustic soda, potash, ammonia, and lithia, whose distinguishing peculiarities are solubility in alcohol and water, uniting with oils and fats to form soap, neutralizing and forming salts with acids, turning to brown several vegetable yellows, and changing reddened litmus to blue.").
word("alkali", 'n.', "Soluble mineral matter, other than common salt, contained in soils of natural waters.").
word("allay", 'v.', "To make worse by the introduction of inferior elements.").
word("allay", 'v.', "To make quiet or put at rest; to pacify or appease; to quell; to calm.").
word("allege", 'v.', "To make a claim as justification or proof; to make an assertion without proof.").
word("allege", 'v.', "To adduce (something) as a reason, excuse, support etc.").
word("allegory", 'n.', "A category that retains some of the structure of the category of binary relations between sets, representing a high-level generalisation of that category.").
word("allegory", 'n.', "A picture, book, or other form of communication using such representation.").
word("alleviate", 'v.', "To reduce or lessen the severity of a pain or difficulty .").
word("alley", 'n.', "A narrow street or passageway, especially one through the middle of a block giving access to the rear of lots or buildings.").
word("alley", 'n.', "A walk or passage in a garden or park, bordered by rows of trees or bushes.").
word("alliance", 'n.', "A union or connection of interests between families, states, parties, etc., especially between families by marriage and states by compact, treaty, or league.").
word("alliance", 'n.', "Any union resembling that of families or states; union by relationship in qualities; affinity.").
word("allot", 'v.', "To assign or designate as a task or for a purpose.").
word("allot", 'v.', "To distribute or apportion by (or as if by) lot.").
word("allotment", 'n.', "Something allotted; a share, part, or portion granted or distributed").
word("allotment", 'n.', "The act of allotting.").
word("allude", 'v.', "To refer to something indirectly or by suggestion.").
word("allusion", 'n.', "An indirect reference; a hint; a reference to something supposed to be known, but not explicitly mentioned").
word("alluvion", 'n.', "The increase in the area of land due to the deposition of sediment (alluvium) by a river.").
word("ally", 'n.', "A person, group, or state (etc) which is associated with another for a common cause; one united to another by treaty or common purpose; a confederate.").
word("ally", 'n.', "A person, group, concept (etc) which is associated with another as a helper; a supporter; an auxiliary.").
word("almanac", 'n.', "A book or table listing nautical, astronomical, astrological or other events for the year; sometimes, but not essentially, containing historical and statistical information.").
word("almanac", 'n.', "A GPS signal consisting of coarse orbit and status information for each satellite in the constellation.").
word("aloof", 'adv.', "At or from a distance, but within view, or at a small distance; apart; away.").
word("aloof", 'adv.', "Without sympathy; unfavorably.").
word("altar", 'n.', "Any (real or notional) place where something is worshipped or sacrificed to.").
word("altar", 'n.', "A table or similar flat-topped structure used for religious rites.").
word("alter", 'v.', "To become different.").
word("alter", 'v.', "To change the form or structure of.").
word("alteration", 'n.', "The state of being altered; a change made in the form or nature of a thing; changed condition.").
word("alteration", 'n.', "The act of altering or making different.").
word("altercate", 'v.', "To argue, quarrel or wrangle.").
word("alternate", 'n.', "A substitute; an alternative; one designated to take the place of another, if necessary, in performing some duty.").
word("alternate", 'n.', "Figures or tinctures that succeed each other by turns.").
word("alternative", 'n.', "One of several mutually exclusive things which can be chosen.").
word("alternative", 'n.', "The remaining option; something available after other possibilities have been exhausted.").
word("altitude", 'n.', "The angular distance of a heavenly body above our Earth's horizon.").
word("altitude", 'n.', "The absolute height of a location, usually measured from sea level.").
word("alto", 'n.', "A musical part or section higher than tenor and lower than soprano, formerly the part that performed a countermelody above the tenor or main melody.").
word("alto", 'n.', "A person or musical instrument that performs the alto part.").
word("altruism", 'n.', "Regard for others, both natural and moral without regard for oneself; devotion to the interests of others; brotherly kindness.").
word("altruism", 'n.', "Action or behaviour that benefits another or others at some cost to the performer.").
word("altruist", 'n.', "A person showing altruism.").
word("amalgam", 'n.', "An alloy containing mercury.").
word("amalgam", 'n.', "One of the ingredients in an alloy.").
word("amalgamate", 'v.', "To merge, to combine, to blend, to join.").
word("amalgamate", 'v.', "To make an alloy of a metal and mercury.").
word("amateur", 'adj.', "Showing a lack of professionalism, experience or talent.").
word("amateur", 'adj.', "Non-professional.").
word("amatory", 'adj.', "Of or relating to love, especially sexual love.").
word("ambidextrous", 'adj.', "Having equal ability in both hands; in particular, able to write equally well with both hands.").
word("ambidextrous", 'adj.', "Equally usable by left-handed and right-handed people .").
word("ambiguous", 'adj.', "Open to multiple interpretations.").
word("ambiguous", 'adj.', "Hesitant; uncertain; not taking sides.").
word("ambitious", 'adj.', "Very desirous").
word("ambitious", 'adj.', "Hard to achieve.").
word("ambrosial", 'adj.', "Succulently sweet or fragrant; balmy, divine.").
word("ambrosial", 'adj.', "Pertaining to or worthy of the gods.").
word("ambulance", 'n.', "An emergency vehicle designed for transporting seriously ill or injured people to a hospital.").
word("ambulance", 'n.', "A mobile field hospital.").
word("ambulate", 'v.', "To walk; to relocate oneself under the power of one's own legs.").
word("ambush", 'n.', "The act of concealing oneself and lying in wait to attack by surprise.").
word("ambush", 'n.', "The concealed position or state from which a surprise attack is launched.").
word("ameliorate", 'v.', "To make better, or improve, something perceived to be in a negative condition.").
word("ameliorate", 'v.', "To become better; improve.").
word("amenable", 'adj.', "Willing to comply; easily led.").
word("amenable", 'adj.', "Liable to be brought to account, to a charge or claim; responsible; accountable; answerable.").
word("amicable", 'adj.', "Showing friendliness or goodwill.").
word("amity", 'n.', "Friendship. The cooperative and supportive relationship between people, or animals. In this sense, the term connotes a relationship which involves mutual knowledge, esteem, affection, and respect along with a degree of rendering service to friends in times of need or crisis.").
word("amity", 'n.', "Mutual understanding and a peaceful relationship, especially between nations; peace; accord.").
word("amorous", 'adj.', "Inclined or having a propensity to love, or to sexual enjoyment.").
word("amorous", 'adj.', "Affected with love; in love; enamored.").
word("amorphous", 'adj.', "Lacking a definite form or clear shape.").
word("amorphous", 'adj.', "Being without definite character or nature.").
word("amour", 'n.', "Love, affection.").
word("amour", 'n.', "A love affair.").
word("ampere", 'n.', "A unit of electrical current, the standard base unit in the International System of Units; colloquially amp. Abbreviation: amp, Symbol: A").
word("ampersand", 'n.', "The symbol \"&\".").
word("amphibious", 'adj.', "Occurring on both land and water.").
word("amphibious", 'adj.', "Capable of functioning on land or in water.").
word("amphitheater", 'n.', "An open, outdoor theatre (which may be a theatre in the round, or have a stage with seating on only one side), especially one from the classical period of ancient Greece or Rome, or a modern venue of similar design.").
word("amplitude", 'n.', "The measure of something's size, especially in terms of width or breadth; largeness, magnitude.").
word("amplitude", 'n.', "The arc of the horizon between the true east or west point and the foot of the vertical circle passing through any star or object.").
word("amply", 'adv.', "In an ample manner.").
word("amputate", 'v.', "To surgically remove a part of the body, especially a limb.").
word("amputate", 'v.', "To cut off, to prune.").
word("amusement", 'n.', "An activity that is entertaining or amusing, such as dancing, gunning, or fishing.").
word("amusement", 'n.', "Entertainment.").
word("anachronism", 'n.', "A person or thing which seems to belong to a different time or period of time. .").
word("anachronism", 'n.', "A chronological mistake; the erroneous dating of an event, circumstance, or object.").
word("anagram", 'n.', "A word or phrase that is created by rearranging the letters of another word or phrase.").
word("analogous", 'adj.', "Having analogy; corresponding to something else; bearing some resemblance or proportion (often followed by \"to\".)").
word("analogous", 'adj.', "Functionally similar, but arising through convergent evolution rather than being homologous.").
word("analogy", 'n.', "The correspondence of a word or phrase with the genius of a language, as learned from the manner in which its words and phrases are ordinarily formed; similarity of derivative or inflectional processes.").
word("analogy", 'n.', "A relationship of resemblance or equivalence between two situations, people, or objects, especially when used as a basis for explanation or extrapolation.").
word("analyst", 'n.', "A practitioner of psychoanalysis.").
word("analyst", 'n.', "Someone who analyzes.").
word("analyze", 'v.', "To separate into the constituent parts, for the purpose of an examination of each separately.").
word("analyze", 'v.', "To resolve (anything complex) into its elements.").
word("anarchy", 'n.', "A chaotic and confusing absence of any form of political authority or government.").
word("anarchy", 'n.', "The state of a society being without authorities or an authoritative governing body.").
word("anathema", 'n.', "A ban or curse pronounced with religious solemnity by ecclesiastical authority, often accompanied by excommunication; something denounced as accursed.").
word("anathema", 'n.', "Something which is vehemently disliked by somebody.").
word("anatomy", 'n.', "The art of studying the different parts of any organized body, to discover their situation, structure, and economy.").
word("anatomy", 'n.', "The physical or functional organization of an organism, or part of it.").
word("ancestry", 'n.', "A series of ancestors or progenitors; lineage, or those who compose the line of natural descent.").
word("ancestry", 'n.', "Condition as to ancestors; ancestral lineage; hence, birth or honorable descent.").
word("anecdote", 'n.', "A short account of a real incident or person, often humorous or interesting.").
word("anecdote", 'n.', "A previously untold secret account of an incident.").
word("anemia", 'n.', "A medical condition in which the capacity of the blood to transport oxygen to the tissues is reduced, either because of too few red blood cells, or because of too little hemoglobin, resulting in pallor and fatigue.").
word("anemia", 'n.', "Ischemia.").
word("anemic", 'adj.', "Weak; listless; lacking power, vigor, vitality, or colorfulness.").
word("anemic", 'adj.', "Of, pertaining to, or suffering from anemia.").
word("anemometer", 'n.', "An instrument for measuring and recording the speed of the wind, a windmeter.").
word("anesthetic", 'adj.', "Insensate; unable to feel, or unconscious.").
word("anesthetic", 'adj.', "Causing anesthesia; reducing pain sensitivity.").
word("anew", 'adv.', "Again, once more; afresh, in a new way, newly.").
word("angelic", 'adj.', "Very sweet-natured or well-behaved.").
word("angelic", 'adj.', "Belonging to, or proceeding from, angels; resembling, characteristic of, or partaking of the nature of, an angel.").
word("anglophobia", 'n.', "The hatred or fear of England and anything English (or British).").
word("angular", 'adj.', "Sharp-cornered; pointed.").
word("angular", 'adj.', "Having an angle or angles; forming an angle or corner").
word("anhydrous", 'adj.', "Having little or no water.").
word("anhydrous", 'adj.', "Having no water of crystallization.").
word("animadversion", 'n.', "A criticism, a critical remark.").
word("animadversion", 'n.', "The state or characteristic of being animadversive.").
word("animadvert", 'v.', "To turn judicial attention (to); to criticise or punish.").
word("animadvert", 'v.', "To criticise, to censure.").
word("animalcule", 'n.', "A microscopic aquatic animal or protozoan.").
word("animalcule", 'n.', "A spermatozoon.").
word("animate", 'v.', "To impart motion or the appearance of motion to.").
word("animate", 'v.', "To give spirit or vigour to; to stimulate or enliven; to inspirit.").
word("animosity", 'n.', "Violent hatred leading to active opposition; active enmity; energetic dislike.").
word("annalist", 'n.', "A writer of annals; a chronicler; a historian.").
word("annals", 'n.', "A relation of events in chronological order, each event being recorded under the year in which it happened.").
word("annals", 'n.', "A periodic publication, containing records of discoveries, transactions of societies, etc.").
word("annex", 'v.', "To add something to another thing, especially territory; to incorporate.").
word("annex", 'v.', "To attach or connect, as a consequence, condition, etc.").
word("annihilate", 'v.', "To reduce to nothing, to destroy, to eradicate.").
word("annihilate", 'v.', "To treat as worthless, to vilify.").
word("annotate", 'v.', "To add annotation to.").
word("annual", 'adj.', "Happening once every year.").
word("annual", 'adj.', "Of, for, or relating to a whole year, often as a recurring cycle; determined or reckoned by the year; accumulating in the course of a year; performed, executed, or completed over the course of a year. See also .").
word("annuity", 'n.', "A right to receive amounts of money regularly over a certain fixed period, in perpetuity, or, especially, over the remaining life or lives of one or more beneficiaries.").
word("annunciation", 'n.', "The act of annunciating.").
word("anode", 'n.', "An electrode, of a cell or other electrically polarized device, through which a positive current of electricity flows inwards (and thus, electrons flow outwards). It can have either a negative or a positive voltage .").
word("anode", 'n.', "The electrode at which chemical oxidation of anions takes place, usually resulting in the erosion of metal from the electrode.").
word("anonymous", 'adj.', "Of unknown name; whose name is withheld").
word("anonymous", 'adj.', "Without any name acknowledged of a person responsible").
word("antagonism", 'n.', "A strong natural dislike or hatred; antipathy.").
word("antarctic", 'adj.', "Of, from, or pertaining to Antarctica and the south polar regions.").
word("ante", 'v.', "To make an investment in money, effort, or time before knowing one's chances.").
word("ante", 'v.', "To pay the ante in poker. Often used as ante up.").
word("antecede", 'v.', "To go before; to precede.").
word("antecede", 'v.', "To predate or antedate.").
word("antecedent", 'n.', "The first of two subsets of a sequent, consisting of all the sequent's formulae which are valuated as true.").
word("antecedent", 'n.', "Any thing that precedes another thing, especially the cause of the second thing.").
word("antechamber", 'n.', "A small room used as an entryway or reception area to a larger room.").
word("antedate", 'v.', "To assign a date to a document or action earlier than the actual date; to backdate.").
word("antedate", 'v.', "To occur before an event or time; to exist further back in time.").
word("antediluvian", 'adj.', "Pertaining or belonging to the time period prior to a great or destructive flood or deluge.").
word("antediluvian", 'adj.', "Pertaining or belonging to the time prior to Noah's Flood.").
word("antemeridian", 'adj.', "Of or relating to morning; that happens in the morning.").
word("antemundane", 'adj.', "Being or occurring prior to the creation of the world.").
word("antenatal", 'adj.', "Occurring or existing before birth").
word("anterior", 'adj.', "Coming before or earlier in time or development, prior to, preceding.").
word("anterior", 'adj.', "Nearer the forward end, especially in the front of the body; nearer the head or forepart of an animal.").
word("anteroom", 'n.', "A room before, or forming an entrance to, another; a waiting room.").
word("anthology", 'n.', "A collection of literary works, such as poems or short stories, especially a collection from various authors.").
word("anthology", 'n.', "A work or series containing various stories with no direct relation to one another.").
word("anthracite", 'n.', "A form of carbonized ancient plants; the hardest and cleanest-burning of all the coals.").
word("anthracite", 'n.', "A dark grey colour.").
word("anthropology", 'n.', "The holistic scientific and social study of humanity, mainly using ethnography as its method.").
word("anthropomorphous", 'adj.', "Resembling a human being.").
word("anthropomorphous", 'adj.', "Describing an animal or inanimate object using human characteristics; employing anthropomorphism.").
word("antic", 'n.', "A grotesque representation of a figure; a gargoyle.").
word("antic", 'n.', "A ludicrous gesture or act; ridiculous behaviour; caper.").
word("antichrist", 'n.', "One who works against the teachings of Christ.").
word("anticlimax", 'n.', "A failed or reverse climax.").
word("anticyclone", 'n.', "A system of winds that spiral out from a centre of high pressure").
word("antidote", 'n.', "A remedy to counteract the effects of poison (often followed by \"against,\" \"for,\" or \"to\").").
word("antidote", 'n.', "Something that counteracts or prevents something harmful.").
word("antilogy", 'n.', "A contradiction in related terms or ideas. Usually an inconsistency in syllogisms, of a person or group supposedly of one set of ideals.").
word("antipathize", 'v.', "To feel or show antipathy.").
word("antiphon", 'n.', "A devotional piece of music sung responsively.").
word("antiphon", 'n.', "A response or reply.").
word("antiphony", 'n.', "Alternate, or responsive singing by a choir split into two parts; a piece sung or chanted in this manner").
word("antiphony", 'n.', "Alternate, or responsive ideas or opinions; juxtaposition").
word("antipodes", 'n.', "The place on the diametrically opposite side of the earth from a given point.").
word("antipodes", 'n.', "The opposite of something.").
word("antiquary", 'n.', "A person who is knowledgeable of, or who collects antiques; an antiquarian.").
word("antiquary", 'n.', "An aficionado or student of antiquities, ancient artifacts, historic sites, ancient writings, or things of the past.").
word("antiquate", 'v.', "To cause to become old or obsolete.").
word("antique", 'adj.', "Belonging to former times, not modern, out of date, old-fashioned.").
word("antique", 'adj.', "Designating a style of type.").
word("antiseptic", 'n.', "Any substance that inhibits the growth and reproduction of microorganisms. Generally includes only those that are used on living objects (as opposed to disinfectants) and aren't transported by the lymphatic system to destroy bacteria in the body (as opposed to antibiotics).").
word("antislavery", 'adj.', "Opposed to the practice of slavery.").
word("antispasmodic", 'adj.', "Referring to something that suppresses spasms, generally a drug.").
word("antistrophe", 'n.', "In Greek choruses and dances, the returning of the chorus, exactly answering to a previous strophe or movement from right to left.").
word("antistrophe", 'n.', "The repetition of words in an inverse order.").
word("antitoxin", 'n.', "An antibody that is capable of neutralising specific toxins that are causative agents of disease.").
word("antonym", 'n.', "A word which has the opposite meaning of another word.").
word("anxious", 'adj.', "Earnestly desirous.").
word("anxious", 'adj.', "Nervous and worried.").
word("apathy", 'n.', "Lack of emotion or motivation; lack of interest or enthusiasm towards something; disinterest (in something).").
word("aperture", 'n.', "A small or narrow opening, gap, slit, or hole.").
word("aperture", 'n.', "A hole which restricts the diameter of the lightpath through one plane in an optical system.").
word("apex", 'n.', "The top of the food chain.").
word("apex", 'n.', "The highest or the greatest part of something, especially forming a point.").
word("aphorism", 'n.', "A concise, terse, laconic, or memorable expression of a general truth or principle.").
word("apiary", 'n.', "A place where bees and their hives are kept.").
word("apogee", 'n.', "The highest point.").
word("apogee", 'n.', "The point, in any trajectory of an object in space, where it is farthest from the Earth.").
word("apology", 'n.', "Anything provided as a substitute; a makeshift.").
word("apology", 'n.', "A formal justification, defence.").
word("apostasy", 'n.', "Specifically, the renunciation of one's religion or faith.").
word("apostasy", 'n.', "The renunciation of a belief or set of beliefs.").
word("apostate", 'adj.', "Guilty of apostasy.").
word("apostle", 'n.', "A pioneer or early advocate of a particular cause, prophet of a belief.").
word("apothecary", 'n.', "A glass jar similar to those once used for medicine.").
word("apothecary", 'n.', "A person who makes and provides/sells drugs and/or medicines.").
word("apotheosis", 'n.', "The fact or action of becoming or making into a god; deification.").
word("apotheosis", 'n.', "A glorified example or ideal; the apex or pinnacle (of a concept or belief).").
word("appall", 'v.', "To fill with horror; to dismay.").
word("appall", 'v.', "To grow faint; to become weak; to become dismayed or discouraged.").
word("apparent", 'adj.', "Clear or manifest to the understanding; plain; evident; obvious; known; palpable; indubitable.").
word("apparent", 'adj.', "Capable of being seen, or easily seen; open to view; visible to the eye, eyely; within sight or view.").
word("apparition", 'n.', "An unexpected, wonderful, or preternatural appearance; especially something such as a ghost or phantom.").
word("apparition", 'n.', "An act of becoming visible; appearance; visibility.").
word("appease", 'v.', "To make quiet; to calm; to reduce to a state of peace; to dispel (anger or hatred).").
word("appease", 'v.', "To come to terms with; to adapt to the demands of.").
word("appellate", 'adj.', "That can be (legally) appealed to, especially of a court that hears appeals of decisions by a lower court.").
word("appellation", 'n.', "A geographical indication for wine that describes its geographic origin.").
word("appellation", 'n.', "A name, title or designation.").
word("append", 'v.', "To hang or attach to, as by a string, so that the thing is suspended").
word("append", 'v.', "To add, as an accessory to the principal thing; to annex").
word("appertain", 'v.', "To belong to or be a part of, whether by right, nature, appointment, or custom; to relate to.").
word("appertain", 'v.', "To belong as a part, right, possession, attribute, etc..").
word("apposite", 'adj.', "Strikingly appropriate or relevant; well suited to the circumstance or in relation to something.").
word("apposite", 'adj.', "Related, homologous.").
word("apposition", 'n.', "A placing of two things side by side, or the fitting together of two things.").
word("apposition", 'n.', "A construction in which one noun or noun phrase is placed with another as an explanatory equivalent, both of them having the same syntactic function in the sentence.").
word("appraise", 'v.', "To determine the value or worth of something, particularly as a person appointed for this purpose.").
word("appraise", 'v.', "To judge the performance of someone, especially a worker.").
word("appreciable", 'adj.', "Large enough to be estimated; perceptible; considerable.").
word("apprehensible", 'adj.', "Which can be apprehended (usually in the sense of being understood).").
word("approbation", 'n.', "The act of approving; an assenting to the propriety of a thing with some degree of pleasure or satisfaction; approval, sanction, commendation or official recognition.").
word("appropriate", 'adj.', "Suitable to the social situation or to social respect or social discreetness; socially correct; socially discreet; well-mannered; proper.").
word("appropriate", 'adj.', "Suitable or fit; proper.").
word("aqueduct", 'n.', "An artificial channel that is constructed to convey water from one location to another.").
word("aqueduct", 'n.', "A structure carrying water over a river or depression, especially in regards to ancient aqueducts.").
word("aqueous", 'adj.', "Consisting mostly of water.").
word("arbiter", 'n.', "}} A person or object having the power of judging and determining, or ordaining, without control; one whose power of deciding and governing is not limited.").
word("arbiter", 'n.', "A person appointed, or chosen, by parties to determine a controversy between them; an arbitrator.").
word("arbitrary", 'adj.', "Not representative or symbolic; not iconic.").
word("arbitrary", 'adj.', "Any, out of all that are possible.").
word("arbitrate", 'v.', "To submit (a dispute) to such judgment").
word("arbitrate", 'v.', "To make a judgment (on a dispute) as an arbitrator or arbiter").
word("arbor", 'n.', "A grove of trees.").
word("arbor", 'n.', "An axis or shaft supporting a rotating part on a lathe.").
word("arboreal", 'adj.', "Living in or among trees.").
word("arboreal", 'adj.', "Covered or filled with trees.").
word("arborescent", 'adj.', "Like a tree; having a structure or appearance similar to that of a tree; branching.").
word("arborescent", 'adj.', "Marked by insistence on totalizing principles, binarism and dualism (as opposed to the rhizome theory).").
word("arboretum", 'n.', "A place where many varieties of tree are grown for research, educational, and ornamental purposes.").
word("arboriculture", 'n.', "The branch of horticulture concerned with the planting and growth of trees.").
word("arcade", 'n.', "A covered passage, usually with shops on both sides.").
word("arcade", 'n.', "An establishment that runs coin-operated games.").
word("archaeology", 'n.', "The study of the past by excavation and analysis of its material remains.").
word("archaic", 'adj.', "Of or characterized by antiquity; old-fashioned, quaint, antiquated.").
word("archaic", 'adj.', "No longer in ordinary use, though still used occasionally to give a sense of antiquity and are still likely to be understood by well educated speakers and are found in historical texts.").
word("archaism", 'n.', "An archaic word, style, etc.").
word("archaism", 'n.', "The adoption or imitation of archaic words or style.").
word("archangel", 'n.', "A powerful angel that leads many other angels, but is still loyal to a deity, and often seen as belonging to a particular archangelical rank or order within a greater hierarchy of angels. (Judeo-Christian examples: Gabriel, Michael, Raphael, Uriel).").
word("archbishop", 'n.', "A senior bishop who is in charge of an archdiocese, and presides over a group of dioceses called a 'province' (in Catholicism, Eastern Orthodoxy, Anglicanism, etc.)").
word("archdeacon", 'n.', "A senior administrative official in a diocese, just under the bishop, often in charge of an archdeaconry. As a title, it can be filled by either a deacon or priest.").
word("archetype", 'n.', "A .").
word("archetype", 'n.', "An original model of which all other similar concepts, objects, or persons are merely copied, derivative, emulated, or patterned; a prototype.").
word("archipelago", 'n.', "A group of islands.").
word("archipelago", 'n.', "The Aegean Sea.").
word("ardent", 'adj.', "(literary) Providing light or heat.").
word("ardent", 'adj.', "Full of ardor; expressing passion, spirit, or enthusiasm.").
word("ardor", 'n.', "Great warmth of feeling; fervor; passion.").
word("ardor", 'n.', "Intense heat.").
word("arid", 'adj.', "Describing a very dry climate. Typically defined as less than 25 cm or 10 inches of rainfall annually.").
word("arid", 'adj.', "Very dry.").
word("aristocracy", 'n.', "The nobility, or the hereditary ruling class.").
word("aristocracy", 'n.', "A class of people considered (not normally universally) superior to others").
word("aristocrat", 'n.', "One of the aristocracy, nobility, or people of rank in a community; one of a ruling class; a noble (originally in Revolutionary France).").
word("aristocrat", 'n.', "A proponent of aristocracy; an advocate of aristocratic government.").
word("armada", 'n.', "A large flock of anything.").
word("armada", 'n.', "Any large army or fleet of military vessels.").
word("armful", 'n.', "The amount an arm or arms can hold.").
word("aroma", 'n.', "A smell; especially a pleasant spicy or fragrant one.").
word("arraign", 'v.', "To call to account, or accuse, before the bar of reason, taste, or any other tribunal.").
word("arraign", 'v.', "To officially charge someone in a court of law.").
word("arrange", 'v.', "To prepare and adapt an already-written composition for presentation in other than its original form.").
word("arrange", 'v.', "To plan; to prepare in advance.").
word("arrangement", 'n.', "An adaptation of a piece of music for other instruments, or in another style.").
word("arrangement", 'n.', "A particular way in which items are organized.").
word("arrant", 'adj.', "Utter; complete (with a negative sense).").
word("arrear", 'n.', "Unpaid debt.").
word("arrear", 'n.', "That which is in the rear or behind.").
word("arrival", 'n.', "The attainment of an objective, especially as a result of effort.").
word("arrival", 'n.', "The fact of beginning to occur; the initial phase of something.").
word("arrogant", 'adj.', "Having excessive pride in oneself, often with contempt or disrespect for others.").
word("arrogate", 'v.', "To appropriate or lay claim to something for oneself without right.").
word("artesian well", 'n.', "An aquifer in which water rises to the surface under its own hydrostatic pressure.").
word("artesian well", 'n.', "A bore-hole in an artesian basin.").
word("artful", 'adj.', "Performed with, or characterized by, art or skill.").
word("artful", 'adj.', "Cunning; tending toward indirect dealings; crafty.").
word("artifice", 'n.', "A trick played out as an ingenious, but artful, ruse.").
word("artifice", 'n.', "A crafty but underhanded deception.").
word("artless", 'adj.', "Free of artificiality; natural.").
word("artless", 'adj.', "Having or displaying no guile, cunning, or deceit.").
word("ascendant", 'adj.', "Rising, moving upward.").
word("ascendant", 'adj.', "Surpassing or controlling.").
word("ascension", 'n.', "That which rises, as from distillation.").
word("ascension", 'n.', "The act of ascending; an ascent.").
word("ascent", 'n.', "The degree of elevation of an object, or the angle it makes with a horizontal line; inclination; rising grade.").
word("ascent", 'n.', "An eminence, hill, or high place.").
word("ascetic", 'adj.', "Characterized by rigorous self-denial or self-discipline; austere; abstinent; involving a withholding of physical pleasure.").
word("ascetic", 'adj.', "Of or relating to ascetics").
word("ascribe", 'v.', "To attribute a cause or characteristic to someone or something.").
word("ascribe", 'v.', "To attribute a book, painting or any work of art or literature to a writer or creator.").
word("asexual", 'adj.', "Lacking distinct sex, lacking sexual organs.").
word("asexual", 'adj.', "Nonsexual in nature, unmarked by sexual activity.").
word("ashen", 'adj.', "Ash-colored; pale; anemic, anaemic; appalled.").
word("ashen", 'adj.', "Made from the wood of the ash-tree.").
word("askance", 'adv.', "With disapproval, skepticism, or suspicion.").
word("askance", 'adv.', "Sideways; obliquely.").
word("asperity", 'n.', "The quality of being difficult or unpleasant to experience.").
word("asperity", 'n.', "The quality of having a rough or uneven surface.").
word("aspirant", 'n.', "Someone who aspires to high office, etc.").
word("aspiration", 'n.', "A burst of air that follows the release of some consonants.").
word("aspiration", 'n.', "The act of aspiring or ardently desiring; an ardent wish or desire, chiefly after what is elevated or spiritual (with common adjunct adpositions being to and of).").
word("aspire", 'v.', "To have a strong desire or ambition to achieve something.").
word("aspire", 'v.', "To go as high as, to reach the top of (something).").
word("assailant", 'n.', "A hostile critic or opponent.").
word("assailant", 'n.', "Someone who attacks or assails another violently, or criminally.").
word("assassin", 'n.', "Someone who intentionally kills a person, especially a professional who kills a public or political figure.").
word("assassin", 'n.', "A member of the Nizari Ismaili Muslim community of the Alamut Period.").
word("assassinate", 'v.', "To murder someone, especially an important person, by a sudden or obscure attack, especially for ideological or political reasons.").
word("assassinate", 'v.', "To harm, ruin, or defame severely or destroy by treachery, slander, libel, or obscure attack.").
word("assassination", 'n.', "The murder of a person, especially for political reasons or for personal gain.").
word("assay", 'n.', "The qualitative or quantitative chemical analysis of something.").
word("assay", 'n.', "The act or process of ascertaining the proportion of a particular metal in an ore or alloy; especially, the determination of the proportion of gold or silver in bullion or coin.").
word("assent", 'v.', "To agree to a proposal.").
word("assess", 'v.', "To calculate and demand (the tax money due) from a person or entity.").
word("assess", 'v.', "To determine, estimate or judge the value of; to evaluate").
word("assessor", 'n.', "A specialist who assists the court in determining a matter.").
word("assessor", 'n.', "A civil servant entrusted with checking the veracity of data and criteria used by a taxpayer to complete a tax return.").
word("assets", 'n.', "Any property or object of value that one possesses, usually considered as applicable to the payment of one's debts.").
word("assets", 'n.', "Any goods or property properly available for the payment of a bankrupt's or a deceased person's obligations or debts.").
word("assiduous", 'adj.', "Hard-working, diligent or regular (in attendance or work); industrious.").
word("assignee", 'n.', "One who is appointed to act or speak in place of another; an agent").
word("assignee", 'n.', "One to whom rights or property is being transferred").
word("assimilate", 'v.', "To be incorporated or absorbed into something.").
word("assimilate", 'v.', "To become similar.").
word("assonance", 'n.', "The repetition of similar or identical vowel sounds (though with different consonants), usually in literature or poetry.").
word("assonant", 'adj.', "Characterized by assonance; having successive similar vowel sounds.").
word("assonate", 'v.', "To correspond in (particularly vowel) sounds.").
word("assuage", 'v.', "To calm down, become less violent (of passion, hunger etc.); to subside, to abate.").
word("assuage", 'v.', "To lessen the intensity of, to mitigate or relieve (hunger, emotion, pain etc.).").
word("astringent", 'adj.', "Causing a dry or puckering mouthfeel; characteristic of foods with high tannin content, such as certain kinds of berries and citrus fruits.").
word("astringent", 'adj.', "Having the effect of drawing tissue together; styptic.").
word("astute", 'adj.', "Quickly and critically discerning.").
word("astute", 'adj.', "Shrewd or crafty.").
word("atheism", 'n.', "Rejection of belief that any deities exist (with or without a belief that no deities exist).").
word("atheism", 'n.', "Belief that no deities exist (sometimes including rejection of other religious beliefs).").
word("athirst", 'adj.', "Thirsty.").
word("athirst", 'adj.', "Eager or extremely desirous (for something).").
word("athwart", 'adv.', "From side to side; across, or over.").
word("athwart", 'adv.', "Across the path (of something).").
word("atomizer", 'n.', "An instrument for reducing a liquid to spray or vapor for disinfecting, cooling, medical use or perfume spraying.").
word("atone", 'v.', "To make reparation, compensation, amends or satisfaction for an offence, crime, mistake or deficiency.").
word("atone", 'v.', "To unite in making.").
word("atonement", 'n.', "Making amends to restore a damaged relationship; expiation.").
word("atonement", 'n.', "Reconciliation; restoration of friendly relations; concord.").
word("atrocious", 'adj.', "Frightful, evil, cruel, or monstrous.").
word("atrocious", 'adj.', "Offensive or heinous.").
word("atrocity", 'n.', "An extremely cruel act; a horrid act of injustice.").
word("atrocity", 'n.', "An object considered to be extremely unattractive or undesirable.").
word("attest", 'v.', "To affirm to be correct, true, or genuine.").
word("attest", 'v.', "To certify in an official capacity.").
word("auburn", 'adj.', "Of a reddish-brown colour.").
word("audacious", 'adj.', "Showing willingness to take bold risks; recklessly daring.").
word("audacious", 'adj.', "Impudent, insolent.").
word("audible", 'adj.', "Able to be heard.").
word("audition", 'n.', "An act of hearing; being heard.").
word("audition", 'n.', "The sense of hearing.").
word("auditory", 'adj.', "Of, or relating to hearing, or to the sense or organs of hearing.").
word("augment", 'v.', "To increase; to make larger or supplement.").
word("augment", 'v.', "To slow the tempo or meter, e.g. for a dramatic or stately passage.").
word("augur", 'v.', "To foretell events; to exhibit signs of future events; to indicate a favorable or an unfavorable outcome.").
word("aura", 'n.', "Telltale sensation experienced by some people with epilepsy before a seizure.").
word("aura", 'n.', "Distinctive atmosphere or quality associated with something.").
word("aural", 'adj.', "Of or pertaining to the ear.").
word("aural", 'adj.', "Of or pertaining to sound.").
word("auricle", 'n.', "Any appendage in the shape of an ear or earlobe.").
word("auricular", 'adj.', "Of or pertaining to the ear.").
word("auricular", 'adj.', "Pertaining to a style of ornamental decoration, originating in Northern Europe in the first half of the 17th century, that uses softly flowing abstract shapes in relief some of which bear a resemblance to the human ear; commonly used in silverware, picture frames, and architecture.").
word("auriferous", 'adj.', "Containing or producing gold; gold-bearing.").
word("aurora", 'n.', "An atmospheric phenomenon created by charged particles from the sun striking the upper atmosphere, creating coloured lights in the sky. It is usually named australis or borealis based on whether it is in the Southern or Northern Hemisphere respectively.").
word("auspice", 'n.', "Patronage or protection.").
word("auspice", 'n.', "An omen or a sign.").
word("austere", 'adj.', "Grim or severe in manner or appearance").
word("austere", 'adj.', "Lacking decoration; trivial; not extravagant or gaudy").
word("autarchy", 'n.', "A condition of absolute power.").
word("autarchy", 'n.', "Autocracy: absolute rule by a single person.").
word("authentic", 'adj.', "Of the same origin as claimed; genuine.").
word("authentic", 'adj.', "Conforming to reality and therefore worthy of trust, reliance, or belief.").
word("authenticity", 'n.', "The quality of being genuine or not corrupted from the original.").
word("authenticity", 'n.', "Truthfulness of origins, attributions, commitments, sincerity, and intentions.").
word("autobiography", 'n.', "A self-written biography; the story of one's own life.").
word("autobiography", 'n.', "Biographies of this kind regarded as a literary genre.").
word("autocracy", 'n.', "An instance of this government.").
word("autocracy", 'n.', "A form of government in which unlimited power is held by a single individual.").
word("autocrat", 'n.', "An absolute ruler with infinite power.").
word("automaton", 'n.', "The self-acting power of the muscular and nervous systems, by which movement is effected without intelligent determination.").
word("automaton", 'n.', "A toy in the form of a mechanical figure.").
word("autonomous", 'adj.', "Self-governing. Intelligent, sentient, self-aware, thinking, feeling, governing independently.").
word("autonomous", 'adj.', "Acting on one's own or independently; of a child, acting without being governed by parental or guardian rules.").
word("autonomy", 'n.', "The right or condition of self-government; freedom to act or function independently.").
word("autonomy", 'n.', "The capacity to make an informed, uncoerced decision.").
word("autopsy", 'n.', "An after-the-fact examination, especially of the causes of a failure.").
word("autopsy", 'n.', "A dissection performed on a cadaver to find possible cause(s) of death.").
word("autumnal", 'adj.', "Past the middle of life; in the third stage.").
word("autumnal", 'adj.', "Of or relating to autumn.").
word("auxiliary", 'n.', "A sailing vessel equipped with an engine.").
word("auxiliary", 'n.', "A marching band colorguard.").
word("avalanche", 'n.', "A large mass or body of snow and ice sliding swiftly down a mountain side, or falling down a precipice.").
word("avalanche", 'n.', "A fall of earth, rocks, etc., similar to that of an avalanche of snow or ice.").
word("avarice", 'n.', "Inordinate desire for some supposed good.").
word("avarice", 'n.', "Excessive or inordinate desire of gain; greed for wealth").
word("aver", 'v.', "To assert the truth of (something); to affirm (something) with confidence; to declare (something) in a positive manner.").
word("aver", 'v.', "To justify or prove (an allegation or plea that one has made).").
word("averse", 'adj.', "Having a repugnance or opposition of mind.").
word("averse", 'adj.', "Turned away or backward.").
word("aversion", 'n.', "Opposition or repugnance of mind; fixed dislike.").
word("aversion", 'n.', "An object of dislike or repugnance.").
word("avert", 'v.', "To turn aside or away.").
word("avert", 'v.', "To turn away.").
word("aviary", 'n.', "A house, enclosure, large cage, or other place for keeping birds confined; a birdhouse.").
word("avidity", 'n.', "Greediness; strong appetite.").
word("avidity", 'n.', "Eagerness; intenseness of desire.").
word("avocation", 'n.', "A calling away; a diversion.").
word("avocation", 'n.', "A hobby or recreational or leisure pursuit.").
word("avow", 'v.', "To declare openly and boldly, as something believed to be right; to own, acknowledge or confess frankly.").
word("avow", 'v.', "To bind or devote by a vow.").
word("awaken", 'v.', "To call to a sense of sin.").
word("awaken", 'v.', "To bring into action (something previously dormant); to stimulate.").
word("aye", 'adv.', "Ever, always").
word("azalea", 'n.', "A plant of the obsolete genus Azalea.").
word("azure", 'n.', "The clear blue colour of the sky; also, a pigment or dye of this colour.").
word("azure", 'n.', "Any of various Australasian lycaenid butterflies of the genus .").
word("bacterium", 'n.', "A single-celled organism with cell walls but no nucleus or organelles.").
word("badger", 'v.', "To pester, to annoy persistently; press.").
word("badger", 'v.', "To pass gas; to fart.").
word("baffle", 'v.', "To bewilder completely; to confuse or perplex.").
word("baffle", 'v.', "To foil; to thwart.").
word("bailiff", 'n.', "An officer of the court, particularly:").
word("bailiff", 'n.', "Any debt collector, regardless of his or her official status.").
word("baize", 'n.', "A thick, soft, usually woolen cloth resembling felt; often colored green and used for coverings on card tables, billiard and snooker tables, etc.").
word("baize", 'n.', "A coarse woolen with a long ; usually dyed in plain colors.").
word("bale", 'n.', "A rounded bundle or package of goods in a cloth cover, and corded for storage or transportation.").
word("bale", 'n.', "A bundle of compressed wool or hay, compacted for shipping and handling.").
word("baleful", 'adj.', "Portending evil; ominous.").
word("baleful", 'adj.', "Miserable, wretched, distressed, suffering.").
word("ballad", 'n.', "A kind of narrative poem, adapted for recitation or singing; especially, a sentimental or romantic poem in short stanzas.").
word("ballad", 'n.', "A slow romantic song.").
word("balsam", 'n.', "A soothing ointment.").
word("balsam", 'n.', "A sweet-smelling oil or resin derived from various plants.").
word("banal", 'adj.', "Common in a boring way, to the point of being predictable; containing nothing new or fresh.").
word("banal", 'adj.', "Relating to a type of feudal jurisdiction or service.").
word("barcarole", 'n.', "A Venetian folk song traditionally sung by gondoliers, often in or time with alternating strong and weak beats imitating a rowing motion.").
word("barcarole", 'n.', "A piece of music composed in imitation of such a song.").
word("barograph", 'n.', "A type of barometer that continuously records air pressure on a sheet or rotating drum").
word("barometer", 'n.', "An instrument for measuring atmospheric pressure.").
word("barometer", 'n.', "Anything used as a gauge or indicator.").
word("bask", 'v.', "To take great pleasure or satisfaction; to feel warmth or happiness. (This verb is usually followed by \"in\").").
word("bask", 'v.', "To bathe in warmth; to be exposed to pleasant heat.").
word("bass", 'adj.', "Of sound, a voice or an instrument, low in pitch or frequency.").
word("baste", 'v.', "To sew with long or loose stitches, as for temporary use, or in preparation for gathering the fabric.").
word("baste", 'v.', "To mark (sheep, etc.) with tar.").
word("baton", 'n.', "An object transferred by runners in a relay race.").
word("baton", 'n.', "An abatement in coats of arms to denote illegitimacy. (Also spelled batune, baston).").
word("battalion", 'n.', "An army unit having two or more companies, etc. and a headquarters. Traditionally forming part of a regiment.").
word("battalion", 'n.', "An army unit having two or more companies, etc. and a headquarters; forming part of a brigade.").
word("batten", 'n.', "A long strip of wood, metal, fibreglass etc., used for various purposes aboard ship, especially one inserted in a pocket sewn on the sail in order to keep the sail flat.").
word("batten", 'n.', "A thin strip of wood used in construction to hold members of a structure together or to provide a fixing point.").
word("batter", 'n.', "A beaten mixture of flour and liquid (usually egg and milk), used for baking (e.g. pancakes, cake, or Yorkshire pudding) or to coat food (e.g. fish) prior to frying").
word("batter", 'n.', "An incline on the outer face of a built wall.").
word("bauble", 'n.', "A club or sceptre carried by a jester.").
word("bauble", 'n.', "A cheap showy ornament piece of jewellery; a gewgaw.").
word("bawl", 'v.', "To wail; to give out a blaring cry.").
word("bawl", 'v.', "To shout or utter in a loud and intense manner.").
word("beatify", 'v.', "To pronounce or regard as happy, or supremely blessed, or as conferring happiness.").
word("beatify", 'v.', "To carry out the third of four steps in canonization, making someone a blessed.").
word("beatitude", 'n.', "Any one of the Biblical blessings given by Jesus in Matthew 5:3–12. E.g.: \"Blessed are the meek for they shall inherit the earth\"(Matthew 5:5).").
word("beatitude", 'n.', "Supreme, utmost bliss and happiness.").
word("beau", 'n.', "A man with a reputation for fine dress and etiquette; a dandy or fop.").
word("beau", 'n.', "A suitor of a lady.").
word("becalm", 'v.', "To make calm or still; make quiet; calm.").
word("becalm", 'v.', "To deprive (a ship) of wind, so that it cannot move (usually in passive).").
word("beck", 'v.', "To nod or motion with the head.").
word("bedaub", 'v.', "To ornament garishly; to overdecorate.").
word("bedaub", 'v.', "To smear upon; to soil.").
word("bedeck", 'v.', "To deck, ornament, or adorn; to grace.").
word("bedlam", 'n.', "A lunatic asylum; a madhouse.").
word("bedlam", 'n.', "A place or situation of chaotic uproar, and where confusion prevails.").
word("befog", 'v.', "To confuse, mystify (a person); to make less acute or perceptive, to cloud (a person’s faculties).").
word("befog", 'v.', "To envelop in fog or smoke.").
word("befriend", 'v.', "To act as a friend to, to assist.").
word("befriend", 'v.', "To become a friend of, to make friends with.").
word("beget", 'v.', "To bring forth.").
word("beget", 'v.', "To cause; to produce.").
word("begrudge", 'v.', "To grudge about or over; be envious or covetous.").
word("begrudge", 'v.', "To be reluctant").
word("belate", 'v.', "To impede; cause something to be late; delay; benight.").
word("belay", 'v.', "To make (a rope) fast by turning it around a fastening point such as a cleat or piton.").
word("belay", 'v.', "To lie in wait for in order to attack; block up or obstruct.").
word("belie", 'v.', "To mimic; to counterfeit.").
word("belie", 'v.', "To tell lies about.").
word("believe", 'v.', "To accept as true, particularly without absolute certainty (i.e., as opposed to knowing).").
word("believe", 'v.', "To opine, think, reckon.").
word("belittle", 'v.', "To knowingly say that something is smaller or less important than it actually is, especially as a way of showing contempt or deprecation.").
word("belle", 'n.', "An attractive woman.").
word("belle", 'n.', "A fellow gay man.").
word("bellicose", 'adj.', "Warlike in nature; aggressive; hostile.").
word("bellicose", 'adj.', "Showing or having the impulse to be combative.").
word("belligerent", 'adj.', "Eager to go to war, warlike.").
word("belligerent", 'adj.', "Acting violently towards others.").
word("bemoan", 'v.', "To be dismayed or worried about (someone), particularly because of their situation or what has happened to them.").
word("bemoan", 'v.', "To moan or complain about (something).").
word("benediction", 'n.', "A short invocation for help, blessing and guidance from God, said on behalf of another person or persons (sometimes at the end of a church worship service).").
word("benediction", 'n.', "In the Anglican church, the ceremony used to institute an abbot, analogous to the consecration of a bishop.").
word("benefactor", 'n.', "Somebody who gives a gift, often money to a charity.").
word("benefactor", 'n.', "Someone who performs good or noble deeds.").
word("benefice", 'n.', "Land granted to a priest in a church that has a source of income attached to it.").
word("benefice", 'n.', "An estate in lands; a fief.").
word("beneficent", 'adj.', "Given to acts that are kind, charitable, philanthropic or beneficial.").
word("beneficial", 'adj.', "Helpful or good to something or someone.").
word("beneficial", 'adj.', "Relating to a benefice.").
word("beneficiary", 'n.', "One who benefits from the payout of an insurance policy.").
word("beneficiary", 'n.', "One who benefits from the distribution, especially out of a trust or estate.").
word("benefit", 'n.', "An advantage; help or aid from something.").
word("benefit", 'n.', "An event such as a performance, given to raise funds for some cause.").
word("benevolence", 'n.', "An altruistic gift or act.").
word("benevolence", 'n.', "A kind of forced loan or contribution levied by kings without legal authority, first so called under Edward IV in 1473.").
word("benevolent", 'adj.', "Possessing or manifesting love for mankind.").
word("benevolent", 'adj.', "Altruistic, charitable, good, just and fair.").
word("benign", 'adj.', "Not posing any serious threat to health; not particularly aggressive or recurrent.").
word("benign", 'adj.', "(of a climate or environment) mild and favorable").
word("benignant", 'adj.', "Kind; gracious; favorable.").
word("benignity", 'n.', "The state of being benign.").
word("benignity", 'n.', "A benign act.").
word("benison", 'n.', "A blessing; benediction.").
word("bequeath", 'v.', "To give or leave by will; to give by testament.").
word("bequeath", 'v.', "To give; to offer; to commit.").
word("bereave", 'v.', "To destroy life; cut off.").
word("bereave", 'v.', "To take away by destroying, impairing, or spoiling; take away by violence.").
word("berth", 'n.', "A fixed bunk for sleeping (in caravans, trains, etc).").
word("berth", 'n.', "A room in which a number of the officers or ship's company mess and reside.").
word("beseech", 'v.', "To beg or implore").
word("beseech", 'v.', "To request or beg for").
word("beset", 'v.', "To attack or assail, especially from all sides.").
word("beset", 'v.', "Of a ship, to get trapped by ice.").
word("besmear", 'v.', "To smear over; smear all over; sully.").
word("bestial", 'adj.', "Beast-like").
word("bestrew", 'v.', "To strew anything upon; strew over or about; cover or partially cover with things strewn; cover with straw or strewing.").
word("bestrew", 'v.', "To strew or scatter about; throw or drop here and there.").
word("bestride", 'v.', "To be astride something, to stand over or sit on with legs on either side, especially to sit on a horse.").
word("bestride", 'v.', "To stride over, or across.}}").
word("bethink", 'v.', "To think (something or somebody) or (followed by clause); to remind oneself, to consider, to reflect upon.").
word("bethink", 'v.', "To determine, resolve.").
word("betide", 'v.', "Chiefly in the : to happen; to take place; to bechance, to befall.").
word("betide", 'v.', "Often used in a prediction (chiefly in 'woe betide') or a wish: to happen to (someone or something); to befall.").
word("betimes", 'adv.', "In good season or time; early, especially in the morning; seasonably.").
word("betimes", 'adv.', "In a short time, soon; quickly, forthwith.").
word("betroth", 'v.', "To promise to give in marriage.").
word("betroth", 'v.', "To promise to take (as a future spouse); to plight one's troth to.").
word("betrothal", 'n.', "The fact of being betrothed; a mutual promise, engagement, or contract for a future marriage between two people.").
word("betrothal", 'n.', "The act of betrothing.").
word("bevel", 'n.', "An edge that is canted, one that is not a 90-degree angle; a chamfer.").
word("bevel", 'n.', "A die used for cheating, having some sides slightly rounded instead of flat.").
word("bewilder", 'v.', "To confuse, disorientate, or puzzle someone, especially with many different choices.").
word("bibliography", 'n.', "A list of books or documents relevant to a particular subject or author.").
word("bibliography", 'n.', "A section of a written work containing citations, not quotations, to all the books referred to in the work.").
word("bibliomania", 'n.', "A passion for owning valuable books.").
word("bibliophile", 'n.', "One who loves books.").
word("bibliophile", 'n.', "One who collects books, not necessarily due to any interest in reading them.").
word("bibulous", 'adj.', "Given to or marked by the consumption of alcoholic drink.").
word("bibulous", 'adj.', "Very absorbent.").
word("bide", 'v.', "To wait for; to await.").
word("bide", 'v.', "To dwell or reside in a location; to abide.").
word("biennial", 'n.', "A plant that requires two years to complete its life-cycle, germinating and growing in its first year, then producing its flowers and fruit in its second year, after which it usually dies.").
word("biennial", 'n.', "An event that happens every two years.").
word("bier", 'n.', "A count of forty threads in the warp or chain of woollen cloth .").
word("bier", 'n.', "A litter to transport the corpse of a dead person.").
word("bigamist", 'n.', "One who practices bigamy.").
word("bigamy", 'n.', "The state of having two (legal or illegal) spouses simultaneously.").
word("bigamy", 'n.', "A second marriage after the death of a spouse.").
word("bight", 'n.', "An area of sea lying between two promontories, larger than a bay, wider than a gulf").
word("bight", 'n.', "A corner, bend, or angle; a hollow").
word("bilateral", 'adj.', "Having two sides.").
word("bilateral", 'adj.', "Involving both sides equally.").
word("bilingual", 'adj.', "Having the ability to speak two languages.").
word("bilingual", 'adj.', "Characterized by the use or presence of two languages.").
word("biograph", 'n.', "An early device to show moving pictures on a screen.").
word("biograph", 'n.', "A biographical essay.").
word("biography", 'n.', "A person's life story, especially one published.").
word("biography", 'n.', "The art of writing this kind of story.").
word("biology", 'n.', "The living organisms of a particular region.").
word("biology", 'n.', "The study of all life or living matter.").
word("biped", 'n.', "An animal, being or construction that goes about on two feet (or two legs).").
word("birthright", 'n.', "Something owed since birth, due to inheritance.").
word("bitterness", 'n.', "The quality of feeling bitter; acrimony, resentment; the quality of exhibiting such feelings.").
word("bitterness", 'n.', "Harsh cold.").
word("blaspheme", 'v.', "To speak of, or address, with impious irreverence; to revile impiously (anything sacred).").
word("blaspheme", 'v.', "To calumniate; to revile; to abuse.").
word("blatant", 'adj.', "Obvious, on show; unashamed; loudly obtrusive or offensive.").
word("blatant", 'adj.', "Bellowing; disagreeably clamorous; sounding loudly and harshly.").
word("blaze", 'n.', "A fire, especially a fast-burning fire producing a lot of flames and light.").
word("blaze", 'n.', "A bursting out, or active display of any quality.").
word("blazon", 'v.', "To make widely or generally known, to proclaim.").
word("blazon", 'v.', "To display conspicuously or publicly.").
word("bleak", 'adj.', "Unhappy; cheerless; miserable; emotionally desolate.").
word("bleak", 'adj.', "Desolate and exposed; swept by cold winds.").
word("blemish", 'n.', "A small flaw which spoils the appearance of something, a stain, a spot.").
word("blemish", 'n.', "A moral defect; a character flaw.").
word("blithe", 'adj.', "Casually careless or indifferent; showing a lack of concern.").
word("blithe", 'adj.', "Cheerful, happy.").
word("blithesome", 'adj.', "Happy or spriteful; carefree.").
word("blockade", 'n.', "Any form of formal isolation of something, especially with the force of law or arms.").
word("blockade", 'n.', "Preventing an opponent's pawn moving by placing a piece in front of it").
word("boatswain", 'n.', "The officer (or warrant officer) in charge of sails, rigging, anchors, cables etc. and all work on deck of a sailing ship.").
word("boatswain", 'n.', "The petty officer of a merchant ship who controls the work of other seamen.").
word("bodice", 'n.', "Underbodice: an undershirt for women, particularly a corset or other undershirt stiffened with whalebone.").
word("bodice", 'n.', "Blouse; any shirt for women, particularly the upper part of a two-piece dress or European folk costume.").
word("bodily", 'adj.', "Real; actual; put into execution.").
word("bodily", 'adj.', "Having a body or material form; physical; corporeal.").
word("boisterous", 'adj.', "Having or resembling animal exuberance.").
word("boisterous", 'adj.', "Full of energy; exuberant; noisy.").
word("bole", 'n.', "The trunk or stem of a tree.").
word("bole", 'n.', "An aperture with a shutter in the wall of a house, to admit air or light.").
word("bolero", 'n.', "A type of short, buttonless jacket or blouse, open or tied in front and ending at the diaphragm.").
word("bolero", 'n.', "A lively Spanish dance in 3/4 time; also an unrelated slower-tempo dance of Cuban origin, in 2/4 time.").
word("boll", 'n.', "The rounded seed-bearing capsule of a cotton or flax plant.").
word("boll", 'n.', "An old dry measure equal to six bushels.").
word("bolster", 'v.', "To brace, reinforce, secure, or support.").
word("bomb", 'n.', "An explosive device used or intended as a weapon.").
word("bomb", 'n.', "A cyclone whose central pressure drops at an average rate of at least one millibar per hour for at least 24 hours.").
word("bombard", 'v.', "To continuously attack something with bombs, artillery shells or other missiles or projectiles.").
word("bombard", 'v.', "To attack something or someone by directing objects at them.").
word("bombardier", 'n.', "A bomber crew member who sights and releases bombs.").
word("bombardier", 'n.', "A non-commissioned officer rank in artillery, equivalent to corporal. Abbreviated Bdr.").
word("bombast", 'n.', "High-sounding words; language above the dignity of the occasion; a pompous or ostentatious manner of writing or speaking.").
word("bombast", 'n.', "Cotton, or any soft, fibrous material, used as stuffing for garments; stuffing, padding.").
word("boorish", 'adj.', "Behaving as a boor; rough in manners.").
word("bore", 'v.', "To be pierced or penetrated by an instrument that cuts as it turns.").
word("borough", 'n.', "A town having a municipal corporation and certain traditional rights.").
word("borough", 'n.', "An administrative unit of a city which, under most circumstances according to state or national law, would be considered a larger or more powerful entity; most commonly used in American English to define the five counties that make up New York City.").
word("bosom", 'n.', "The breast or chest of a human (or sometimes of another animal).").
word("bosom", 'n.', "Any thing or place resembling the breast; a supporting surface; an inner recess; the interior.").
word("botanical", 'adj.', "Of or pertaining to botany; relating to the study of plants.").
word("botanize", 'v.', "To do the work of a botanist, as to inventory the plant life in an area and to collect plants for research purposes.").
word("botany", 'n.', "The scientific study of plants, a branch of biology. Typically those disciplines that involve the whole plant.").
word("botany", 'n.', "The plant life of a geographical area; flora.").
word("bountiful", 'adj.', "Having a quantity or amount that is generous or plentiful; ample.").
word("bowdlerize", 'v.', "To remove or alter those parts of a text considered offensive, vulgar, or otherwise unseemly.").
word("bowler", 'n.', "The pitcher.").
word("bowler", 'n.', "One who engages in the sport of bowling.").
word("boycott", 'v.', "To abstain, either as an individual or a group, from using, buying, or dealing with someone or some organization as an expression of protest.").
word("brae", 'n.', "Any hillside or slope.").
word("brae", 'n.', "The sloping bank of a river valley.").
word("braggart", 'n.', "Someone who constantly brags or boasts.").
word("brandish", 'v.', "To move or swing a weapon back and forth, particularly if demonstrating anger, threat or skill.").
word("brandish", 'v.', "To bear something with ostentatious show.").
word("bravado", 'n.', "A false show of courage.").
word("bravado", 'n.', "A swaggering show of defiance or courage.").
word("bray", 'n.', "The cry of an animal, now chiefly that of animals related to the ass or donkey, or the camel.").
word("bray", 'n.', "Any discordant, grating, or harsh sound.").
word("braze", 'v.', "To join two metal pieces, without melting them, using heat and diffusion of a jointing alloy of capillary thickness.").
word("braze", 'v.', "To burn or temper in fire.").
word("brazier", 'n.', "An upright standing or hanging metal bowl used for holding burning coal for a source of light or heat.").
word("brazier", 'n.', "A worker in brass.").
word("breach", 'n.', "A breaking or infraction of a law, or of any obligation or tie; violation; non-fulfillment").
word("breach", 'n.', "A difference in opinions, social class etc.").
word("breaker", 'n.', "A horsebreaker.").
word("breaker", 'n.', "The building in which such a machine is placed.").
word("breech", 'n.', "A garment whose purpose is to cover or clothe the buttocks.").
word("breech", 'n.', "The buttocks or backside.").
word("brethren", 'n.', "The body of members, especially of a fraternal, religious or military order.").
word("brevity", 'n.', "The quality of being brief in duration.").
word("brevity", 'n.', "A short piece of writing.").
word("bridle", 'n.', "The headgear with which a horse is directed and which carries a bit and reins.").
word("bridle", 'n.', "A length of line or cable attached to two parts of something to spread the force of a pull, as the rigging on a kite for attaching line.").
word("brigade", 'n.', "Military unit composed of several regiments (or battalions) and including soldiers from different arms of service.").
word("brigade", 'n.', "Coordinated online harassment, disruption or influencing, especially organized by an antagonistic website or community.").
word("brigadier", 'n.', "An army rank; an officer commanding a brigade.").
word("brigadier", 'n.', "A field officer of the highest grade, below general officers, NATO grade O7.").
word("brigand", 'n.', "An outlaw or bandit.").
word("brimstone", 'n.', "The sulfur / sulphur of Hell; Hell, damnation.").
word("brine", 'n.', "Salt water; water saturated or strongly impregnated with salt; a salt-and-water solution for pickling.").
word("brine", 'n.', "The sea or ocean; the water of the sea.").
word("bristle", 'n.', "The hairs or other filaments that make up a brush, broom, or similar item.").
word("bristle", 'n.', "A stiff or coarse hair.").
word("brittle", 'adj.', "Emotionally fragile, easily offended.").
word("brittle", 'adj.', "Not physically tough or tenacious; apt to break or crumble when bending.").
word("broach", 'v.', "To make a hole in, especially a cask of liquor, and put in a tap in order to draw the liquid.").
word("broach", 'v.', "To cause to turn sideways to oncoming waves, especially large or breaking waves (usually followed by to; also figurative).").
word("broadcast", 'adj.', "Cast or scattered widely in all directions; cast abroad.").
word("broadcast", 'adj.', "Relating to transmissions of messages or signals through radio waves or electronic means.").
word("brogan", 'n.', "A heavy working shoe; a brogue.").
word("brogue", 'n.', "A strong dialectal accent. In Ireland it used to be a term for Irish spoken with a strong English accent, but gradually changed to mean English spoken with a strong Irish accent as English control of Ireland gradually increased and Irish waned as the standard language.").
word("brogue", 'n.', "A strong Oxford shoe, with ornamental perforations and wing tips.").
word("brokerage", 'n.', "A business, firm, or company whose business is to act as a broker (e.g., stockbroker).").
word("brokerage", 'n.', "The commission paid to a broker.").
word("bromine", 'n.', "A nonmetallic chemical element (symbol Br) with an atomic number of 35; one of the halogens, it is a fuming red-brown liquid at room temperature.").
word("bromine", 'n.', "A bromine atom in a molecule").
word("bronchitis", 'n.', "An inflammation of the bronchi of the lungs, that causes the cilia of the bronchial epithelial cells to stop functioning.").
word("bronchitis", 'n.', "An occurrence of, a case (patient) of, or a type of bronchitis.").
word("bronchus", 'n.', "Either of two airways, which are primary branches of the trachea, leading directly into the lungs.").
word("brooch", 'n.', "A piece of ornamental jewellery having a pin allowing it to be fixed to garments worn on the upper body.").
word("brooch", 'n.', "A painting all of one colour, such as a sepia painting.").
word("brotherhood", 'n.', "An association for any purpose, such as a society of monks; a fraternity.").
word("brotherhood", 'n.', "People, or (poetically) things, of the same kind.").
word("browbeat", 'v.', "To bully in an intimidating, bossy, or supercilious way.").
word("brusque", 'adj.', "Rudely abrupt, unfriendly.").
word("buffoon", 'n.', "One who acts in a silly or ridiculous fashion; a clown or fool.").
word("buffoon", 'n.', "An unintentionally ridiculous person.").
word("buffoonery", 'n.', "The behaviour expected of a buffoon; foolishness, silliness.").
word("bulbous", 'adj.', "Having the shape of or resembling a bulb, bloated.").
word("bulbous", 'adj.', "Overweight and round in shape.").
word("bullock", 'n.', "A castrated bull; an ox.").
word("bullock", 'n.', "A young bull.").
word("bulrush", 'n.', "Any of several wetland plants, mostly in the family Cyperaceae (the sedges):").
word("bulwark", 'n.', "Any means of defence or security.").
word("bulwark", 'n.', "A defensive wall or rampart.").
word("bumper", 'n.', "A short ditty or jingle used to separate a show from the advertisements.").
word("bumper", 'n.', "Parts at the front and back of a vehicle which are meant to absorb the impact of a collision; fender.").
word("bumptious", 'adj.', "Obtrusively pushy; self-assertive to a pretentious extreme.").
word("bungle", 'v.', "To act or work incompetently; to fumble.").
word("bungle", 'v.', "To incompetently perform (a task); to ruin (something) through incompetent action; to botch up, to bumble.").
word("buoyancy", 'n.', "The ability of an object to stay afloat in a fluid.").
word("buoyancy", 'n.', "The upward force on a body immersed or partly immersed in a fluid.").
word("buoyant", 'adj.', "Involving or engaged in much successful trade or activity.").
word("buoyant", 'adj.', "Having buoyancy; able to float.").
word("bureau", 'n.', "A chest of drawers for clothes.").
word("bureau", 'n.', "An organization or office for collecting or providing information or news.").
word("bureaucracy", 'n.', "The body of officers and administrators, especially of a government.").
word("bureaucracy", 'n.', "Government by bureaus or their administrators or officers.").
word("burgess", 'n.', "A member of the , a legislative body in colonial America, established by the to provide civil rule in the colonies.").
word("burgess", 'n.', "A representative of a borough in the Parliament.").
word("burgher", 'n.', "A citizen of a borough or town, especially one belonging to the middle class.").
word("burgher", 'n.', "A prosperous member of the community; a middle class citizen (may connote complacency).").
word("burnish", 'v.', "To make (something) smooth or shiny by rubbing; to polish or shine (something)").
word("burnish", 'v.', "To shine forth; to brighten; to become smooth and glossy, as from swelling or filling out; hence, to grow large.").
word("bursar", 'n.', "The treasurer of a university, college or school.").
word("bursar", 'n.', "A student funded by a bursary.").
word("bustle", 'v.', "To teem or abound (usually followed by with); to exhibit an energetic and active abundance (of a thing).").
word("bustle", 'v.', "To push around, to importune.").
word("butt", 'v.', "To strike bluntly, particularly with the head.").
word("butt", 'v.', "To strike bluntly with the head.").
word("butte", 'n.', "An isolated hill with steep sides and a flat top.").
word("buttress", 'n.', "A brick or stone structure built against another structure to support it.").
word("buttress", 'n.', "Anything that serves to support something; a prop.").
word("cabal", 'n.', "A putative, secret organization of individuals gathered for a political purpose.").
word("cabal", 'n.', "An identifiable group within the tradition of Discordianism.").
word("cabalism", 'n.', "The activities of a cabal; secret plotting.").
word("cabinet", 'n.', "In parliamentary and some other systems of government, the group of ministers responsible for creating government policy and for overseeing the departments comprising the executive branch.").
word("cabinet", 'n.', "The upright assembly that houses a coin-operated arcade game, a cab.").
word("cacophony", 'n.', "A mix of discordant sounds; dissonance.").
word("cadaverous", 'adj.', "Corpselike; hinting of death; imitating a cadaver.").
word("cadence", 'n.', "The rhythm and sequence of a series of actions.").
word("cadence", 'n.', "The general inflection or modulation of the voice, or of any sound.").
word("cadenza", 'n.', "A part of a piece of music, such as a concerto, that is very decorative and is played by a single musician.").
word("caitiff", 'adj.', "Especially despicable; cowardly").
word("cajole", 'v.', "To persuade someone to do something which they are reluctant to do, especially by flattery or promises; to coax.").
word("cajolery", 'n.', "Cajolement").
word("calculable", 'adj.', "Able to be calculated.").
word("calculus", 'n.', "A stony concretion that forms in a bodily organ.").
word("calculus", 'n.', "Any formal system in which symbolic expressions are manipulated according to fixed rules.").
word("callosity", 'n.', "A callus").
word("callosity", 'n.', "A callous demeanour; insensitivity or hardheartedness").
word("callow", 'adj.', "Lacking color or firmness (of some kinds of insects or other arthropods, such as spiders, just after ecdysis); teneral.").
word("callow", 'adj.', "Of land: low-lying and liable to be submerged.").
word("calorie", 'n.', "The gram calorie or small calorie, a non-SI unit of energy, equivalent to approximately 4.2 joules. This unit was widely used in chemistry and physics, being the amount of energy needed to raise the temperature of 1 gram of water by 1&nbsp;°C.").
word("calorie", 'n.', "Kilogram calorie or large calorie. A unit of energy 1000 times larger than the gram calorie. It is equivalent to the gram kilocalorie, approximately 4.2 kilojoules.").
word("calumny", 'n.', "A false accusation or charge brought to tarnish another's reputation or standing.").
word("calumny", 'n.', "Falsifications or misrepresentations intended to disparage or discredit another.").
word("calvary", 'n.', "A life-size representation of the crucifixion of Jesus Christ on a piece of raised ground.").
word("calvary", 'n.', "A series of representations of Christ’s Passion in a church.").
word("came", 'n.', "A grooved strip of lead used to hold panes of glass together.").
word("cameo", 'n.', "A piece of jewelry, etc., carved in relief.").
word("cameo", 'n.', "A single very brief appearance, especially by a prominent celebrity in a movie or song.").
word("campaign", 'n.', "A series of operations undertaken to achieve a set goal.").
word("campaign", 'n.', "The period during which a blast furnace is continuously in operation.").
word("canary", 'adj.', "Of a light yellow colour.").
word("candid", 'adj.', "Straightforward, open and sincere.").
word("candid", 'adj.', "Not posed or rehearsed.").
word("candor", 'n.', "The state of being sincere and open in speech; honesty in expression.").
word("candor", 'n.', "Whiteness; brilliance; purity.").
word("canine", 'adj.', "Of or pertaining to mammalian teeth which are cuspids or fangs.").
word("canine", 'adj.', "Of, or pertaining to, a dog or dogs.").
word("canon", 'n.', "A religious law or body of law decreed by the church.").
word("canon", 'n.', "In monasteries, a book containing the rules of a religious order.").
word("cant", 'v.', "To preach in a singsong fashion, especially in a false or empty manner.").
word("cant", 'v.', "Of a blazon, to make a pun that references the bearer of a coat of arms.").
word("cantata", 'n.', "A vocal composition accompanied by instruments and generally containing more than one movement, typical of 17th and 18th century Italian music.").
word("canto", 'n.', "One of the chief divisions of a long poem; a book.").
word("canto", 'n.', "The treble or leading melody.").
word("cantonment", 'n.', "A town or village, or part of a town or village, assigned to a body of troops for quarters.").
word("cantonment", 'n.', "Temporary military living quarters.").
word("capacious", 'adj.', "Having a lot of space inside; roomy.").
word("capillary", 'n.', "Any of the small blood vessels (from 5 to 10 micrometres/micrometers (μm) in diameter) that connect arteries to veins (They are the smallest blood vessels in the body: they convey blood between the arterioles and venules).").
word("capillary", 'n.', "A narrow tube.b").
word("capitulate", 'v.', "To surrender; to end all resistance, to give up; to go along with or comply.").
word("capitulate", 'v.', "To draw up in chapters; to enumerate.").
word("caprice", 'n.', "An impulsive, seemingly unmotivated action, change of mind, or notion.").
word("caprice", 'n.', "An unpredictable or sudden condition, change, or series of changes.").
word("caption", 'n.', "A title or brief explanation attached to an illustration, cartoon, user interface element, etc.").
word("caption", 'n.', "A piece of text appearing on screen as a subtitle or other part of a film or broadcast, describing dialogue (and sometimes other sound) for viewers who cannot hear.").
word("captious", 'adj.', "Having a disposition to find fault unreasonably or to raise petty objections; cavilling, nitpicky.").
word("captious", 'adj.', "That captures; especially, (of an argument, words etc.) designed to capture or entrap in misleading arguments; sophistical.").
word("captivate", 'v.', "To attract and hold (someone's) interest and attention; to charm.").
word("captivate", 'v.', "To take prisoner; to capture; to subdue.").
word("carcass", 'n.', "The body of a dead animal.").
word("carcass", 'n.', "The body of a slaughtered animal, stripped of unwanted viscera, etc.").
word("cardiac", 'adj.', "Pertaining to the heart.").
word("cardiac", 'adj.', "Exciting action in the heart, through the medium of the stomach; cordial; stimulant.").
word("cardinal", 'adj.', "Of fundamental importance; crucial, pivotal.").
word("cardinal", 'adj.', "Describing a \"natural\" number used to indicate quantity (e.g., zero, one, two, three), as opposed to an ordinal number indicating relative position.").
word("caret", 'n.', "An indicator, often a blinking line or bar, indicating where the next insertion or other edit will take place. Also called a cursor.").
word("caret", 'n.', "A mark ⟨&nbsp; &nbsp;⟩ used by writers and proofreaders to indicate that something is to be inserted at that point.").
word("caricature", 'n.', "A pictorial representation of someone in which distinguishing features are exaggerated for comic effect.").
word("caricature", 'n.', "A grotesque misrepresentation.").
word("carnage", 'n.', "The corpses, gore, etc. that remain after a massacre.").
word("carnage", 'n.', "Death and destruction.").
word("carnal", 'adj.', "Of or relating to the body or flesh.").
word("carnal", 'adj.', "Relating to the physical and especially sexual appetites.").
word("carnivorous", 'adj.', "Predatory or flesh-eating.").
word("carnivorous", 'adj.', "Insectivorous: capable of trapping insects and absorbing nutrient from them.").
word("carouse", 'v.', "To engage in a noisy or drunken social gathering.").
word("carouse", 'v.', "To drink to excess.").
word("carrion", 'n.', "Dead flesh; carcasses.").
word("carrion", 'n.', "A contemptible or worthless person.").
word("cartilage", 'n.', "A usually translucent and somewhat elastic, dense, nonvascular connective tissue found in various forms in the larynx and respiratory tract, in structures such as the external ear, and in the articulating surfaces of joints. It composes most of the skeleton of vertebrate embryos, being replaced by bone during ossification in the higher vertebrates.").
word("cartilage", 'n.', "A particular structure made of cartilage.").
word("cartridge", 'n.', "A vessel which contains the ink or toner for a computer printer and can be easily replaced with another.").
word("cartridge", 'n.', "The package consisting of the bullet, primer, and casing containing gunpowder; a round of ammunition.").
word("caste", 'n.', "Any of the hereditary social classes and subclasses of South Asian societies.").
word("caste", 'n.', "A separate and fixed order or class of persons in society who chiefly associate with each other.").
word("castigate", 'v.', "To punish or reprimand someone severely.").
word("castigate", 'v.', "To execrate or condemn something in a harsh manner, especially by public criticism.").
word("casual", 'adj.', "Happening by chance.").
word("casual", 'adj.', "Coming without regularity; occasional or incidental.").
word("casualty", 'n.', "Specifically, a person who has been killed (not only injured) due to an accident or through an act of violence; a fatality.").
word("casualty", 'n.', "A person suffering from injuries or who has been killed due to an accident or through an act of violence.").
word("cataclysm", 'n.', "A great flood.").
word("cataclysm", 'n.', "A sudden and violent change in the earth's crust.").
word("cataract", 'n.', "A clouding of the lens in the eye leading to a decrease in vision.").
word("cataract", 'n.', "A flood of water.").
word("catastrophe", 'n.', "Any large and disastrous event of great significance.").
word("catastrophe", 'n.', "A type of bifurcation, where a system shifts between two stable states.").
word("cathode", 'n.', "An electrode, of a cell or other electrically polarized device, through which a positive current of electricity flows outwards (and thus, electrons flow inwards). It usually, but not always, has a positive voltage.").
word("cathode", 'n.', "The electrode at which chemical reduction of cations takes place, usually resulting in the deposition of metal onto the electrode.").
word("catholicism", 'n.', "Liberality of sentiment; breadth of view.").
word("catholicism", 'n.', "The state or quality of being catholic or universal; catholicity.").
word("catholicity", 'n.', "The quality of being catholic, universal or inclusive.").
word("catholicity", 'n.', "Catholicism.").
word("caucus", 'n.', "A grouping of all the members of a legislature from the same party.").
word("caucus", 'n.', "A usually preliminary meeting of party members to nominate candidates for public office or delegates to be sent a nominating convention, or to confer regarding policy.").
word("causal", 'adj.', "Of, relating to, or being a cause of something; causing").
word("caustic", 'adj.', "Sharp, bitter, cutting, biting, and sarcastic in a scathing way.").
word("caustic", 'adj.', "Capable of burning, corroding or destroying organic tissue.").
word("cauterize", 'v.', "To burn, sear, or freeze tissue using a hot iron, electric current or a caustic agent.").
word("cede", 'v.', "To give way.").
word("cede", 'v.', "To give up; yield to another.").
word("censor", 'n.', "An official responsible for the removal or suppression of objectionable material (for example, if obscene or likely to incite violence) or sensitive content in books, films, correspondence, and other media.").
word("censor", 'n.', "A high-ranking official who was responsible for the supervision of subordinate government officials.").
word("censorious", 'adj.', "Addicted to censure and scolding; apt to blame or condemn; severe in making remarks on others, or on their writings or manners.").
word("censorious", 'adj.', "Implying or expressing censure.").
word("census", 'n.', "An official count or enumeration of members of a population (not necessarily human), usually residents or citizens in a particular region, often done at regular intervals.").
word("census", 'n.', "Count, tally.").
word("centenary", 'adj.', "Relating to a hundred of anything.").
word("centenary", 'adj.', "Of, pertaining to, or completing a period of 100 years.").
word("centurion", 'n.', "A pilot in the United States Navy who has performed 100 night landings on an aircraft carrier.").
word("centurion", 'n.', "An officer of the ancient Roman army, in command of a century of soldiers.").
word("ceremonial", 'adj.', "Observant of ceremony, ritual, or social forms.").
word("ceremonial", 'adj.', "Of, relating to, or used in a ceremony.").
word("ceremonious", 'adj.', "Fond of ceremony, ritual or strict etiquette; punctilious").
word("ceremonious", 'adj.', "Characterized by ceremony or rigid formality").
word("cessation", 'n.', "A ceasing or discontinuance, for example of an action, whether temporary or final.").
word("cession", 'n.', "The giving up of rights, property etc. which one is entitled to.").
word("cession", 'n.', "That which is ceded.").
word("chagrin", 'n.', "Distress of mind caused by a failure of aims or plans, want of appreciation, mistakes etc; vexation or mortification.").
word("chagrin", 'n.', "A type of leather or skin with a rough surface.").
word("chameleon", 'adj.', "Describing something that changes color.").
word("chancery", 'n.', "In the United States, a court of equity; equity; proceeding in equity.").
word("chancery", 'n.', "The type of building that houses the offices and administration of a diocese; the offices of a diocese.").
word("chaos", 'n.', "Any state of disorder; a confused or amorphous mixture or conglomeration.").
word("chaos", 'n.', "A behaviour of iterative non-linear systems in which arbitrarily small variations in initial conditions become magnified over time.").
word("characteristic", 'n.', "A distinguishing feature of a person or thing.").
word("characteristic", 'n.', "The distinguishing features of a navigational light on a lighthouse etc by which it can be identified (colour, pattern of flashes etc.).").
word("characterize", 'v.', "To be typical of.").
word("characterize", 'v.', "To depict someone or something a particular way (often negative).").
word("charlatan", 'n.', "A mountebank, someone who addresses crowds in the street; , an itinerant seller of medicines or drugs.").
word("charlatan", 'n.', "A malicious trickster; a fake person, especially one who deceives for personal profit.").
word("chasm", 'n.', "A deep, steep-sided rift, gap or fissure; a gorge or abyss.").
word("chasm", 'n.', "A large difference of opinion.").
word("chasten", 'v.', "To render humble or restrained.").
word("chasten", 'v.', "To make chaste.").
word("chastise", 'v.', "To punish (someone), especially by corporal punishment.").
word("chastise", 'v.', "To castigate; to severely scold or censure (someone).").
word("chastity", 'n.', "The quality of being chaste: the state of abstaining from any sexual activity considered immoral; avoidance of sexual sins.").
word("chattel", 'n.', "Tangible, movable property.").
word("chattel", 'n.', "A slave.").
word("check", 'v.', "To pass or bounce the ball to an opponent from behind the three-point line and have the opponent pass or bounce it back to start play.").
word("check", 'v.', "To disrupt another player with the stick or body to obtain possession of the ball or puck.").
word("chiffon", 'n.', "Any purely ornamental accessory on a woman's dress, such as a bunch of ribbon, lace, etc.").
word("chiffon", 'n.', "A sheer silk or rayon fabric.").
word("chivalry", 'n.', "The ethical code of the knight prevalent in Medieval Europe, having such primary virtues as mercy towards the poor and oppressed, humility, honour, sacrifice, fear of God, faithfulness, courage and utmost graciousness and courtesy to ladies.").
word("chivalry", 'n.', "The fact or condition of being a knight; knightly skill, prowess.").
word("cholera", 'n.', "Any of several acute infectious diseases of humans and domestic animals, caused by certain strains of the Vibrio cholerae bacterium through ingestion of contaminated water or food, usually marked by severe gastrointestinal symptoms such as diarrhea, abdominal cramps, nausea, vomiting, and dehydration.").
word("choleric", 'adj.', "Showing or expressing anger.").
word("choleric", 'adj.', "(according to theories of the four humours or temperaments) Having a temperament characterized by an excess of choler; easily becoming angry.").
word("choral", 'adj.', "Of, relating to, written for, or performed by a choir or a chorus.").
word("christen", 'v.', "To douse or wet with blood, urine, tears, or other liquid.").
word("christen", 'v.', "To name.").
word("chromatic", 'adj.', "Relating to .").
word("chronology", 'n.', "The science of determining the order in which events occurred.").
word("chronology", 'n.', "An arrangement of events into chronological order; called a timeline when involving graphical elements.").
word("chronometer", 'n.', "A device for measuring time, such as a watch or clock.").
word("cipher", 'v.', "Of an organ pipe: to sound independent of the organ.").
word("cipher", 'v.', "To calculate.").
word("circulate", 'v.', "To spread or disseminate").
word("circulate", 'v.', "To become widely known").
word("circumference", 'n.', "The line that bounds a circle or other two-dimensional figure Category:en:Curves").
word("circumference", 'n.', "The length of such a line").
word("circumlocution", 'n.', "An instance of such usage; a roundabout expression, whether an inadvisable one or a necessary one.").
word("circumlocution", 'n.', "A roundabout or indirect way of speaking; thus:").
word("circumnavigate", 'v.', "To sail around the world.").
word("circumnavigate", 'v.', "To travel completely around somewhere or something, especially by sail.").
word("circumscribe", 'v.', "To draw a line around; to encircle.").
word("circumscribe", 'v.', "To limit narrowly; to restrict.").
word("circumspect", 'adj.', "Carefully aware of all circumstances; considerate of all that is pertinent.").
word("citadel", 'n.', "A strong fortress that sits high above a city.").
word("citadel", 'n.', "A stronghold or fortified place.").
word("cite", 'v.', "To quote; to repeat, as a passage from a book, or the words of another.").
word("cite", 'v.', "To summon officially or authoritatively to appear in court.").
word("claimant", 'n.', "One who claims; one who makes a claim.").
word("claimant", 'n.', "A person receiving money from the government, in a form of unemployment benefits, disability benefits or similar.").
word("clairvoyance", 'n.', "The power to see the future.").
word("clamorous", 'adj.', "Having especially (and often unpleasantly) bright or contrasting colours or patterns.").
word("clamorous", 'adj.', "Of or pertaining to clamor.").
word("clan", 'n.', "Any group defined by family ties with some sort of political unity.").
word("clan", 'n.', "A group of people all descended from a common ancestor, in fact or belief, especially when the exact genealogies are not known.").
word("clandestine", 'adj.', "Done or kept in secret, sometimes to conceal an illicit or improper purpose.").
word("clandestine", 'adj.', "Not recognized as a regular member.").
word("clarify", 'v.', "(of liquids, such as wine or syrup) To make clear or bright by freeing from feculent matter").
word("clarify", 'v.', "To make clear or easily understood; to explain in order to remove doubt or obscurity").
word("clarion", 'n.', "An organ stop consisting of pipes with reeds giving a high pitched note.").
word("clarion", 'n.', "A type of musical instrument resembling an organ.").
word("classify", 'v.', "To identify by or divide into classes; to categorize").
word("classify", 'v.', "To declare something a secret, especially a government secret").
word("clearance", 'n.', "The height or width of a tunnel, bridge or other passage, or the distance between a vehicle and the walls or roof of such passage; a gap, headroom.").
word("clearance", 'n.', "A sale of merchandise, especially at significantly reduced prices in order to make room for new merchandise or updated versions of the same merchandise.").
word("clemency", 'n.', "The gentle or kind exercise of power; leniency, mercy; compassion in judging or punishing.").
word("clemency", 'n.', "A pardon, commutation, or similar reduction, removal, or postponement of legal penalties by an executive officer of a state.").
word("clement", 'adj.', "Lenient or merciful; charitable.").
word("clement", 'adj.', "Mild .").
word("clothier", 'n.', "A person who makes or sells cloth or clothing.").
word("clumsy", 'adj.', "Awkward or inefficient in use or construction, difficult to handle or manage especially because of shape.").
word("clumsy", 'adj.', "Not elegant or well-planned, lacking tact or subtlety.").
word("coagulant", 'adj.', "That causes coagulation or that coagulates").
word("coagulate", 'v.', "To become congealed; to convert from a liquid to a semisolid mass.").
word("coagulate", 'v.', "To cause to congeal.").
word("coalescence", 'n.', "The merging of two segments into one.").
word("coalescence", 'n.', "The act of coalescing.").
word("coalition", 'n.', "A temporary group or union of organizations, usually formed for a particular advantage.").
word("coddle", 'v.', "To exercise excessive or damaging authority in an attempt to protect. To overprotect.").
word("coddle", 'v.', "To treat gently or with great care.").
word("codicil", 'n.', "An addition or supplement that explains, modifies, or revokes a will or part of one.").
word("codicil", 'n.', "An addition or supplement modifying any official document, such as a treaty.").
word("coerce", 'v.', "To force an attribute, normally of a data type, to take on the attribute of another data type.").
word("coerce", 'v.', "To restrain by force, especially by law or authority; to repress; to curb.").
word("coercion", 'n.', "Use of physical or moral force to compel a person to do something, or to abstain from doing something, thereby depriving that person of the exercise of free will.").
word("coercion", 'n.', "The process by which the meaning of a or other linguistic element is reinterpreted to match the grammatical .").
word("coercive", 'adj.', "Such that the ratio of |F(x)| to x approaches infinity as x approaches infinity.").
word("coercive", 'adj.', "Displaying a tendency or intent to coerce.").
word("cogent", 'adj.', "Appealing to the intellect or powers of reasoning.").
word("cogent", 'adj.', "Reasonable and convincing; based on evidence.").
word("cognate", 'adj.', "Allied by blood; kindred by birth; specifically related on the mother's side.").
word("cognate", 'adj.', "Of the same or a similar nature; of the same family; proceeding from the same stock or root.").
word("cognizant", 'adj.', "Aware; fully informed; having understanding of a fact").
word("cohere", 'v.', "To stick together physically, by adhesion.").
word("cohere", 'v.', "To be consistent as part of a group, or by common purpose.").
word("cohesion", 'n.', "Grammatical or lexical relationship between different parts of the same text.").
word("cohesion", 'n.', "Growing together of normally distinct parts of a plant.").
word("cohesive", 'adj.', "Having cohesion.").
word("coincide", 'v.', "To correspond, concur, or agree.").
word("coincide", 'v.', "To occupy exactly the same space.").
word("coincidence", 'n.', "Of events, the appearance of a meaningful connection when there is none.").
word("coincidence", 'n.', "A fixed point of a correspondence; a point of a variety corresponding to itself under a correspondence.").
word("coincident", 'adj.', "Occurring at the same time.").
word("coincident", 'adj.', "Being in the same location.").
word("collaborate", 'v.', "To voluntarily cooperate treasonably, as with an enemy occupation force in one's country.").
word("collaborate", 'v.', "To work together with others to achieve a common goal.").
word("collapse", 'v.', "To pass out and fall to the floor or ground, as from exhaustion or other illness; to faint.").
word("collapse", 'v.', "To break apart and fall down suddenly; to cave in.").
word("collapsible", 'adj.', "That can be collapsed.").
word("colleague", 'n.', "A fellow member of a profession, staff, academic faculty or other organization; an associate.").
word("collective", 'adj.', "Having plurality of origin or authority.").
word("collective", 'adj.', "Formed by gathering or collecting; gathered into a mass, sum, or body.").
word("collector", 'n.', "A compiler of books; one who collects scattered passages and puts them together in one book.").
word("collector", 'n.', "One holding a Bachelor of Arts in Oxford, formerly appointed to superintend some scholastic proceedings in Lent.").
word("collegian", 'n.', "An inmate of a prison.").
word("collegian", 'n.', "A student (or a former student) of a college").
word("collide", 'v.', "To impact directly, especially if violent.").
word("collide", 'v.', "To come into conflict, or be incompatible.").
word("collier", 'n.', "A person in the business or occupation of producing (digging or mining) coal or making charcoal or in its transporting or commerce.").
word("collier", 'n.', "A vessel carrying a bulk cargo of coal.").
word("collision", 'n.', "An instance of colliding.").
word("collision", 'n.', "Any event in which two or more bodies exert forces on each other in a relatively short time. In a collision, physical contact of two bodies is not necessary.").
word("colloquial", 'adj.', "Denoting a manner of speaking or writing that is characteristic of familiar conversation, of common parlance; informal.").
word("colloquial", 'adj.', "Of or pertaining to a conversation; conversational or chatty.").
word("colloquialism", 'n.', "Colloquial style of speaking.").
word("colloquialism", 'n.', "A colloquial word or phrase; a common spoken expression.").
word("colloquy", 'n.', "A conversation or dialogue.").
word("colloquy", 'n.', "A written discourse.").
word("collusion", 'n.', "A secret agreement for an illegal purpose; conspiracy.").
word("colossus", 'n.', "Somebody or something very greatly admired and respected.").
word("colossus", 'n.', "Any creature or thing of gigantic size.").
word("comely", 'adj.', "Suitable or becoming; proper; agreeable.").
word("comely", 'adj.', "Pleasing or attractive to the eye.").
word("comestible", 'adj.', "Suitable to be eaten; edible.").
word("comical", 'adj.', "Funny, whimsically amusing.").
word("comical", 'adj.', "Laughable; ridiculous.").
word("commemorate", 'v.', "To serve as a memorial to someone or something.").
word("commemorate", 'v.', "To honour the memory of someone or something with a ceremony or object.").
word("commentary", 'n.', "A series of comments or annotations; especially, a book of explanations or expositions on the whole or a part of some other work").
word("commentary", 'n.', "An oral relation of an event, especially broadcast by television or radio, as it occurs").
word("commingle", 'v.', "To become mixed or blended.").
word("commingle", 'v.', "To mix, to blend.").
word("commissariat", 'n.', "The department of an army that supplies provisions for the troops.").
word("commissariat", 'n.', "A territorial and governmental unit of Colombia at some points in its history.").
word("commission", 'v.', "To place an order for (often piece of art)").
word("commission", 'v.', "To put into active service").
word("commitment", 'n.', "The act of being locked away, such as in an institution for the mentally ill or in jail.").
word("commitment", 'n.', "The trait of sincerity and focused purpose.").
word("committal", 'n.', "The act of perpetrating an offence.").
word("committal", 'n.', "The act of entrusting something to someone.").
word("commodity", 'n.', "Anything movable (a good) that is bought and sold.").
word("commodity", 'n.', "Something useful or valuable.").
word("commotion", 'n.', "An agitated disturbance or a hubbub.").
word("commotion", 'n.', "A state of turbulent motion.").
word("commute", 'v.', "To exchange substantially; to abate but not abolish completely, a penalty, obligation, or payment in return for a great, single thing or an aggregate; to cash in; to lessen").
word("commute", 'v.', "To regularly travel from one's home to one's workplace or school, or vice versa.").
word("comparable", 'adj.', "Similar (to); like.").
word("comparable", 'adj.', "Constituting a pair in a particular partial order.").
word("comparative", 'adj.', "Approximated by comparison; relative.").
word("comparative", 'adj.', "Of or relating to comparison.").
word("comparison", 'n.', "A feature in the morphology or syntax of some languages whereby adjectives and adverbs are inflected to indicate the relative degree of the property they define exhibited by the word or phrase they modify or describe.").
word("comparison", 'n.', "An evaluation of the similarities and differences of one or more things relative to some other or each other.").
word("compensate", 'v.', "To adjust or adapt to a change, often a harm or deprivation.").
word("compensate", 'v.', "To do (something good) after (something bad) happens").
word("competence", 'n.', "The degree to which a rock is resistant to deformation or flow.").
word("competence", 'n.', "The legal authority to deal with a matter.").
word("competent", 'adj.', "Having sufficient skill, knowledge, ability, or qualifications.").
word("competent", 'adj.', "Adequate for the purpose").
word("competitive", 'adj.', "Inhibiting the action of an enzyme by binding with it").
word("competitive", 'adj.', "Cheap, especially used of quality products").
word("competitor", 'n.', "Partner, associate, one working with another toward a common goal.").
word("competitor", 'n.', "A participant in a competition, especially in athletics.").
word("complacence", 'n.', "Delight, pleasure.").
word("complacence", 'n.', "Being complacent; a feeling of contentment or satisfaction; complacency.").
word("complacent", 'adj.', "Uncritically satisfied with oneself or one's achievements; smug.").
word("complacent", 'adj.', "Apathetic with regard to an apparent need or problem.").
word("complaisance", 'n.', "The quality of being complaisant, amiable or agreeable.").
word("complaisant", 'adj.', "Willing to do what pleases others; obliging.").
word("complaisant", 'adj.', "Compliant.").
word("complement", 'v.', "To provide what the partner lacks and lack what the partner provides, thus forming part of a whole.").
word("complement", 'v.', "To complete, to bring to perfection, to make whole.").
word("complex", 'adj.', "A curve, polygon or other figure that crosses or intersects itself.").
word("complex", 'adj.', "Having the form a + bi, where a and b are real numbers and i is (by definition) the imaginary square root of −1.").
word("compliant", 'adj.', "Compatible with or following guidelines, specifications, rules, or laws.").
word("compliant", 'adj.', "Willing to comply; submissive; willing to do what someone wants.").
word("complicate", 'v.', "To involve in a convoluted matter.").
word("complicate", 'v.', "To make complex; to modify so as to make something intricate or difficult.").
word("complication", 'n.', "A person who doesn't fit in with the main scheme of things; an interloper.").
word("complication", 'n.', "A disease or diseases, or adventitious circumstances or conditions, coexistent with and modifying a primary disease, but not necessarily connected with it.").
word("complicity", 'n.', "The state of being complicit; involvement as a partner or accomplice, especially in a crime or other wrongdoing.").
word("complicity", 'n.', "Complexity. Oxford English Dictionary, 2nd ed., 1989.").
word("compliment", 'v.', "To pay a compliment (to someone); to express a favourable opinion (of someone).").
word("component", 'n.', "A smaller, self-contained part of a larger entity. Often refers to a manufactured object that is part of a larger device.").
word("comport", 'v.', "To be in agreement (with); to be of an accord.").
word("comport", 'v.', "To tolerate, bear, put up (with).").
word("composure", 'n.', "Calmness of mind or matter, self-possession.").
word("composure", 'n.', "A combination; a union; a bond.").
word("comprehensible", 'adj.', "Able to be comprehended.").
word("comprehension", 'n.', "Thorough understanding").
word("comprehension", 'n.', "The inclusion of nonconformists within the Church of England.").
word("comprehensive", 'adj.', "Broadly or completely covering; including a large proportion of something.").
word("compress", 'v.', "To make smaller; to press or squeeze together, or to make something occupy a smaller space or volume.").
word("compress", 'v.', "To make digital information smaller by encoding it using fewer bits.").
word("compressible", 'adj.', "Containing a circle that does not serve as the boundary of a disk that lies in the surface, but does serve as boundary of a disk that lies in the ambient manifold.").
word("compressible", 'adj.', "Able to be compressed").
word("compression", 'n.', "The deviation of a heavenly body from a spherical form.").
word("compression", 'n.', "The electronic process by which any sound's gain is automatically controlled.").
word("comprise", 'v.', "To contain or embrace.").
word("comprise", 'v.', "To include, contain, or be made up of, defining the minimum elements, whether essential or inessential to define an invention. In most jurisdictions, is , as in nonexhaustive, but may be presumed to be a close-ended listing in other jurisdictions.").
word("compulsion", 'n.', "An irrational need or irresistible urge to perform some action, often despite negative consequences.").
word("compulsion", 'n.', "The lawful use of violence (i.e. by the administration).").
word("compulsory", 'adj.', "Required; obligatory; mandatory.").
word("compulsory", 'adj.', "Having the power of compulsion; constraining.").
word("compunction", 'n.', "A pricking of conscience or a feeling of regret, especially one which is slight or fleeting.").
word("compute", 'v.', "To reckon, calculate").
word("compute", 'v.', "To make sense").
word("concede", 'v.', "To yield or suffer; to surrender; to grant").
word("concede", 'v.', "To admit to be true; to acknowledge.").
word("conceit", 'n.', "Opinion, (neutral) judgment.").
word("conceit", 'n.', "Esteem, favourable opinion.").
word("conceive", 'v.', "To develop an idea; to form in the mind; to plan; to devise; to originate.").
word("conceive", 'v.', "To generate or engender; to bring into being.").
word("concerto", 'n.', "A piece of music for one or more solo instruments and orchestra.").
word("concession", 'n.', "A gift freely given or act freely made as a token of respect or to curry favor.").
word("concession", 'n.', "The act of conceding.").
word("conciliate", 'v.', "To make calm and content, or regain the goodwill of; to placate.").
word("conciliate", 'v.', "To mediate in a dispute.").
word("conciliatory", 'adj.', "Willing to conciliate, or to make concessions.").
word("conclusive", 'adj.', "Providing an end to something; decisive.").
word("conclusive", 'adj.', "Pertaining to a conclusion.").
word("concord", 'n.', "A state of agreement; harmony; union.").
word("concord", 'n.', "An agreeable combination of tones simultaneously heard; a consonant chord; consonance; harmony.").
word("concordance", 'n.', "An alphabetical verbal index showing the places in the text of a book where each principal word may be found, with its immediate context in each place.").
word("concordance", 'n.', "Agreement; accordance; consonance.").
word("concur", 'v.', "To agree (in action or opinion); to have a common opinion; to coincide; to correspond.").
word("concur", 'v.', "To run together; to meet.").
word("concurrence", 'n.', "Agreement; concurring.").
word("concurrence", 'n.', "An instance of simultaneous occurrence.").
word("concurrent", 'adj.', "Acting in conjunction; agreeing in the same act or opinion; contributing to the same event or effect.").
word("concurrent", 'adj.', "Running alongside one another on parallel courses; moving together in space.").
word("concussion", 'n.', "An injury to part of the body, most especially the brain, caused by a violent blow, followed by loss of function.").
word("concussion", 'n.', "The unlawful forcing of another by threats of violence to yield up something of value.").
word("condensation", 'n.', "The reaction of two substances with the simultaneous loss of water or other small molecule.").
word("condensation", 'n.', "The conversion of a gas to a liquid.").
word("condense", 'v.', "To be transformed from a gaseous state into a liquid state.").
word("condense", 'v.', "To concentrate toward the essence by making more close, compact, or dense, thereby decreasing size or volume.").
word("condescend", 'v.', "To come down from one's superior position; to deign (to do something).").
word("condescend", 'v.', "To come down.").
word("condolence", 'n.', "An expression of comfort, support, or sympathy offered to the family and friends of somebody who has died.").
word("condolence", 'n.', "Comfort, support or sympathy.").
word("conduce", 'v.', "To contribute or lead to a specific result.").
word("conducive", 'adj.', "Tending to contribute to, encourage, or bring about some result.").
word("conductible", 'adj.', "Able to be conducted or transmitted.").
word("conductible", 'adj.', "Able to conduct (heat, electricity, etc.).").
word("conduit", 'n.', "A pipe or channel for conveying water etc.").
word("conduit", 'n.', "An investment vehicle that issues short-term commercial paper to finance long-term off-balance sheet bank assets.").
word("confectionery", 'n.', "Foodstuffs that taste very sweet, taken as a group; candies, sweetmeats and confections collectively.").
word("confectionery", 'n.', "The business or occupation of manufacturing confectionery; the skill or work of a confectioner.").
word("confederacy", 'n.', "A state where the sovereign constituent units delegate their authority to the centre. As opposed to a federation, where the central and regional governments are each equal and sovereign in their own sphere.").
word("confederacy", 'n.', "Specifically, an instance of a decentralized governing structure among the indigenous peoples of North America.").
word("confederate", 'n.', "An actor who participates in a psychological experiment pretending to be a subject but in actuality working for the researcher (also known as a \"stooge\").").
word("confederate", 'n.', "An accomplice in a plot.").
word("confer", 'v.', "To grant as a possession; to bestow.").
word("confer", 'v.', "To compare.").
word("conferee", 'n.', "A person on whom something is conferred or bestowed.").
word("conferee", 'n.', "A person who participates in a conference.").
word("confessor", 'n.', "A priest who hears confession and then gives absolution").
word("confessor", 'n.', "One who confesses to having done something wrong.").
word("confidant", 'n.', "A person in whom one can confide or share one's secrets: a friend.").
word("confide", 'v.', "To trust, have faith ('in').").
word("confide", 'v.', "To entrust (something) 'to' the responsibility of someone.").
word("confidence", 'n.', "A feeling of certainty; firm trust or belief; faith.").
word("confidence", 'n.', "Information held in secret; a piece of information shared but to thence be kept in secret.").
word("confident", 'adj.', "Self-assured, self-reliant, sure of oneself.").
word("confident", 'adj.', "Very sure of something; positive.").
word("confinement", 'n.', "Lying-in, time of giving birth.").
word("confinement", 'n.', "Lockdown").
word("confiscate", 'v.', "To use one's authority to lay claim to and separate a possession from its holder.").
word("conflagration", 'n.', "A large fire extending to many objects, or over a large space; a general burning.").
word("conflagration", 'n.', "A large-scale conflict.").
word("confluence", 'n.', "The act of combining that occurs where two rivers meet.").
word("confluence", 'n.', "The proportion of cells, in a culture medium, that adhere to each other.").
word("confluent", 'n.', "A stream uniting and flowing with another; a confluent stream.").
word("conformable", 'adj.', "Having the same shape or form; very similar.").
word("conformable", 'adj.', "Suitable; compliant.").
word("conformance", 'n.', "The act of conforming; conformity.").
word("conformation", 'n.', "Structure, the arrangement of parts of some thing; form; arrangement.").
word("conformation", 'n.', "The spatial arrangement of a group of atoms in a molecule as a result of rotation about a covalent bond which remains unbroken.").
word("conformity", 'n.', "The ideology of adhering to one standard or social uniformity.").
word("conformity", 'n.', "The state of things being similar or identical.").
word("confront", 'v.', "To come up against; to encounter.").
word("confront", 'v.', "To stand or meet facing, especially in competition, hostility or defiance; to come face to face with").
word("congeal", 'v.', "To coagulate, make curdled or semi-solid such as gel or jelly.").
word("congeal", 'v.', "To change from a liquid to solid state, perhaps due to cold; called to freeze in nontechnical usage.").
word("congenial", 'adj.', "Having the same or very similar nature, personality, tastes, habits or interests.").
word("congenial", 'adj.', "Friendly or sociable.").
word("congest", 'v.', "To hinder or block the passage of something moving, for example a fluid, mixture, traffic, people, etc. (due to an excess of this or due to a partial or complete obstruction), resulting in overfilling or overcrowding.").
word("congregate", 'v.', "To come together; to assemble; to meet.").
word("congregate", 'v.', "To collect into an assembly or assemblage; to bring into one place, or into a united body").
word("coniferous", 'adj.', "Bearing cones, as the pine and cypress.").
word("coniferous", 'adj.', "Of, or pertaining to, a conifer.").
word("conjecture", 'n.', "A statement or an idea which is unproven, but is thought to be true; a guess.").
word("conjecture", 'n.', "A statement likely to be true based on available evidence, but which has not been formally .").
word("conjoin", 'v.', "To unite, to join, to league.").
word("conjoin", 'v.', "To join together; to unite; to combine.").
word("conjugal", 'adj.', "Of or relating to marriage, or the relationship of spouses; connubial.").
word("conjugate", 'adj.', "United in pairs; yoked together; coupled.").
word("conjugate", 'adj.', "In single pairs; coupled.").
word("conjugation", 'n.', "The coming together of things; union.").
word("conjugation", 'n.', "The temporary fusion of organisms, especially as part of sexual reproduction").
word("conjunction", 'n.', "The act of joining, or condition of being joined.").
word("conjunction", 'n.', "The alignment of two bodies in the solar system such that they have the same longitude when seen from Earth.").
word("connive", 'v.', "Often followed by ' ': to pretend to be ignorant of something in order to escape blame; to ignore or overlook a fault deliberately.").
word("connive", 'v.', "To secretly cooperate with other people in order to commit a crime or other wrongdoing; to collude, to conspire.").
word("connoisseur", 'n.', "A specialist in a given field whose opinion is highly valued, especially in one of the fine arts or in matters of taste.").
word("connote", 'v.', "To signify beyond its literal or principal meaning.").
word("connote", 'v.', "To express without overt reference; to imply.").
word("connubial", 'adj.', "Of or relating to the state of being married.").
word("conquer", 'v.', "To acquire by force of arms, win in war; to become ruler of; to subjugate.").
word("conquer", 'v.', "To overcome an abstract obstacle.").
word("consanguineous", 'adj.', "Related by birth; descended from the same parent or ancestor.").
word("conscience", 'n.', "The moral sense of right and wrong, chiefly as it affects a person’s own behaviour and forms their attitude to their past actions.").
word("conscience", 'n.', "A personification of the moral sense of right and wrong, usually in the form of a person, a being or merely a voice that gives moral lessons and advices.").
word("conscientious", 'adj.', "Thorough, careful, or vigilant in one’s task performance.").
word("conscientious", 'adj.', "Influenced by conscience; governed by a strict regard to the dictates of conscience, or by the known or supposed rules of right and wrong (said of a person).").
word("conscious", 'adj.', "Aware of one's own existence; aware of one's own awareness.").
word("conscious", 'adj.', "Aware of, sensitive to; observing and noticing, or being strongly interested in or concerned about.").
word("conscript", 'v.', "To enrol(l) compulsorily; to draft; to induct.").
word("consecrate", 'v.', "To ordain as a bishop.").
word("consecrate", 'v.', "To declare something holy, or make it holy by some procedure.").
word("consecutive", 'adj.', "Following, in succession, without interruption").
word("consecutive", 'adj.', "Having some logical sequence").
word("consensus", 'n.', "A process of decision-making that seeks widespread agreement among group members.").
word("consensus", 'n.', "General agreement among the members of a given group or community, each of which exercises some discretion in decision-making and follow-up action.").
word("conservatism", 'n.', "A political philosophy that advocates traditional values.").
word("conservatism", 'n.', "A risk-averse attitude or approach.").
word("conservative", 'adj.', "Having power to preserve in a safe or entire state, or from loss, waste, or injury; preservative.").
word("conservative", 'adj.', "Tending to resist change or innovation.").
word("conservatory", 'n.', "A glass-walled and -roofed room in a house").
word("conservatory", 'n.', "A school of music or drama").
word("consign", 'v.', "To entrust to the care of another.").
word("consign", 'v.', "To assign; to devote; to set apart.").
word("consignee", 'n.', "The person to whom a shipment is to be delivered.").
word("consignee", 'n.', "One to whom anything is consigned or entrusted.").
word("consistency", 'n.', "Freedom from contradiction; the state of a system of axioms such that none of the propositions deduced from them are mutually contradictory.").
word("consistency", 'n.', "The degree of viscosity of something.").
word("console", 'v.', "To comfort (someone) in a time of grief, disappointment, etc.").
word("consolidate", 'v.', "To combine into a single unit; to group together or join.").
word("consolidate", 'v.', "To make stronger or more solid.").
word("consonance", 'n.', "Harmony; agreement; lack of discordance.").
word("consonance", 'n.', "The repetition of consonant sounds, but not vowels as in assonance.").
word("consonant", 'adj.', "Consistent, harmonious, compatible, or in agreement").
word("consonant", 'adj.', "Harmonizing together; accordant.").
word("consort", 'n.', "Association or partnership.").
word("consort", 'n.', "An informal, usually well-publicized sexual companion of a monarch, aristocrat, celebrity, etc.").
word("conspicuous", 'adj.', "Noticeable or attracting attention, especially if unattractive.").
word("conspicuous", 'adj.', "Obvious or easy to notice.").
word("conspirator", 'n.', "Part of a group that agree to do an unlawful or unethical act.").
word("conspirator", 'n.', "One of a group that acts in harmony; a person who is part of a conspiracy.").
word("conspire", 'v.', "To secretly plot or make plans together, often with the intention to bring bad or illegal results.").
word("conspire", 'v.', "To agree, to concur to one end.").
word("constable", 'n.', "An officer of a noble court in the Middle Ages, usually a senior army commander. (See also ).").
word("constable", 'n.', "An elected head of a parish (also known as a connétable)").
word("constellation", 'n.', "An image associated with a group of stars.").
word("constellation", 'n.', "An asterism, an arbitrary formation of stars perceived as a figure or pattern, or a division of the sky including it, especially one officially recognised by astronomers.").
word("consternation", 'n.', "Amazement or horror that confounds the faculties, and incapacitates for reflection; terror, combined with amazement; dismay.").
word("constituency", 'n.', "An interest group or fan base.").
word("constituency", 'n.', "The residents of such a district.").
word("constituent", 'n.', "A resident of an area represented by an elected official, particularly in relation to that official.").
word("constituent", 'n.', "One who appoints another to act for him as attorney in fact").
word("constrict", 'v.', "To narrow, especially by application of pressure.").
word("constrict", 'v.', "To limit or restrict.").
word("consul", 'n.', "An official residing in major foreign towns to represent and protect the interests of the merchants and citizens of his or her country.").
word("consul", 'n.', "Any of the three heads of government and state of France between 1799 and 1804.").
word("consulate", 'n.', "The business office of a consul; a minor embassy.").
word("consulate", 'n.', "The office of a consul, in its various senses.").
word("consummate", 'v.', "To bring (a task, project, goal etc.) to completion; to accomplish.").
word("consummate", 'v.', "To make (a marriage) complete by engaging in first sexual intercourse.").
word("consumption", 'n.', "The act of eating, drinking or using.").
word("consumption", 'n.', "The wasting away of the human body through disease.").
word("consumptive", 'adj.', "Relating to pulmonary tuberculosis.").
word("consumptive", 'adj.', "Having a tendency to consume; dissipating; destructive; wasteful.").
word("contagion", 'n.', "The spread or transmission of such a disease.").
word("contagion", 'n.', "The spread of anything likened to a contagious disease.").
word("contagious", 'adj.', "Having a disease that can be transmitted to another person.").
word("contagious", 'adj.', "Easily transmitted to others.").
word("contaminate", 'v.', "To infect, often with bad objects").
word("contaminate", 'v.', "To make unfit for use by the introduction of unwholesome or undesirable elements.").
word("contemplate", 'v.', "To consider as a possibility.").
word("contemplate", 'v.', "To look at on all sides or in all its aspects; to view or consider with continued attention; to regard with deliberate care; to meditate on; to study, ponder, or consider.").
word("contemporaneous", 'adj.', "Existing or created in the same period of time.").
word("contemporary", 'adj.', "From the same time period, coexistent in time; contemporaneous.").
word("contemporary", 'adj.', "Modern, of the present age (shorthand for ‘contemporary with the present’).").
word("contemptible", 'adj.', "Deserving contempt").
word("contemptuous", 'adj.', "Showing contempt; expressing disdain; showing a lack of respect.").
word("contender", 'n.', "Someone who competes with one or more other people.").
word("contender", 'n.', "Someone who has a viable chance of winning a competition.").
word("contiguity", 'n.', "A state in which two or more physical objects are physically touching one another or in which sections of a plane border on one another.").
word("contiguous", 'adj.', "Connected; touching; abutting.").
word("contiguous", 'adj.', "Adjacent; neighboring.").
word("continence", 'n.', "The voluntary control of urination and defecation.").
word("continence", 'n.', "Moderation or self-restraint, especially in sexual activity; abstinence.").
word("contingency", 'n.', "A possibility; something which may or may not happen. A chance occurrence, especially in finance, unexpected expenses.").
word("contingency", 'n.', "An amount of money which a party to a contract has to pay to the other party (usually the supplier of a major project to the client) if he or she does not fulfill the contract according to the specification.").
word("contingent", 'adj.', "Not logically necessarily true or false.").
word("contingent", 'adj.', "Possible or liable, but not certain to occur.").
word("continuance", 'n.', "An order issued by a court granting a postponement of a legal proceeding for a set period.").
word("continuance", 'n.', "The action of continuing.").
word("continuation", 'n.', "That which extends, increases, supplements, or carries on.").
word("continuation", 'n.', "A representation of an execution state of a program at a certain point in time, which may be used at a later time to resume the execution of the program from that point.").
word("continuity", 'n.', "A narrative device in episodic fiction where previous and/or future events in a series of stories are accounted for in present stories.").
word("continuity", 'n.', "Lack of interruption or disconnection; the quality of being continuous in space or time.").
word("continuous", 'adj.', "Without stopping; without a break, cessation, or interruption.").
word("continuous", 'adj.', "Not deviating or varying from uniformity; not interrupted; not joined or articulated.").
word("contort", 'v.', "To twist into or as if into a strained shape or expression.").
word("contort", 'v.', "To twist in a violent manner.").
word("contraband", 'n.', "A black slave during the American Civil War who had escaped to, or been captured by, Union forces.").
word("contraband", 'n.', "Goods which are prohibited from being traded, smuggled goods.").
word("contradiction", 'n.', "A proposition that is false for all values of its propositional variables or Boolean atoms.").
word("contradiction", 'n.', "A statement that contradicts itself, i.e., a statement that claims that the same thing is true and that it is false at the same time and in the same senses of the terms.").
word("contradictory", 'adj.', "That is diametrically opposed to something.").
word("contradictory", 'adj.', "Mutually exclusive.").
word("contraposition", 'n.', "Opposition; contrast.").
word("contraposition", 'n.', "The statement of the form \"if not Q then not P\", given the statement \"if P then Q\".").
word("contravene", 'v.', "To deny the truth of something.").
word("contravene", 'v.', "To act contrary to an order; to fail to conform to a regulation or obligation.").
word("contribution", 'n.', "Something given or offered that adds to a larger whole.").
word("contribution", 'n.', "An amount of money given toward something.").
word("contributor", 'n.', "A person who produces articles published in a newspaper, magazine, online publication, etc.").
word("contributor", 'n.', "A person who backs, supports or champions a cause, activity or institution.").
word("contrite", 'adj.', "Sincerely penitent or feeling regret or sorrow, especially for one’s own actions.").
word("contrite", 'adj.', "Thoroughly bruised or broken.").
word("contrivance", 'n.', "A means, such as an elaborate plan or strategy, to accomplish a certain objective.").
word("contrivance", 'n.', "Something overly artful or artificial.").
word("contrive", 'v.', "To invent by an exercise of ingenuity; to devise").
word("contrive", 'v.', "To invent, to make devices; to form designs especially by improvisation.").
word("control", 'v.', "To exercise influence over; to suggest or dictate the behavior of.").
word("control", 'v.', "To verify the accuracy of (something or someone, especially a financial account) by comparison with another account").
word("controller", 'n.', "The chief accounting officer which audits, and manages the financial affairs of a company or government; a comptroller.").
word("controller", 'n.', "The person who supervises and handles communication with an agent in the field.").
word("contumacious", 'adj.', "Contemptuous of authority; willfully disobedient; rebellious.").
word("contumacious", 'adj.', "Willfully disobedient to the summons or orders of a court.").
word("contumacy", 'n.', "Disobedience, resistance to authority.").
word("contuse", 'v.', "To injure without breaking the skin; to bruise.").
word("contusion", 'n.', "A wound, such as a bruise, in which the skin is not broken, often having broken blood vessels and discolouration.").
word("contusion", 'n.', "The act of bruising.").
word("convalesce", 'v.', "To recover health and strength gradually after sickness or weakness.").
word("convalescence", 'n.', "The period of time spent healing.").
word("convalescence", 'n.', "A gradual healing after illness or injury.").
word("convalescent", 'adj.', "Recovering one's health and strength after a period of illness").
word("convalescent", 'adj.', "Of convalescence or convalescents").
word("convene", 'v.', "To come together, as in one body or for a public purpose; to meet; to assemble.").
word("convene", 'v.', "To summon judicially to meet or appear.").
word("convenience", 'n.', "Any object that makes life more convenient; a helpful item.").
word("convenience", 'n.', "The quality of being convenient.").
word("converge", 'v.', "Of two or more entities, to approach each other; to get closer and closer.").
word("converge", 'v.', "Of an iterative process, to reach a stable end point.").
word("convergent", 'adj.', "Of a sequence in a metric space or a topological space; having a (finite, proper) limit.").
word("convergent", 'adj.', "That converges or focuses; converging").
word("conversant", 'adj.', "Familiar or acquainted by use or study; well-informed; versed.").
word("conversant", 'adj.', "Closely familiar; current; having frequent interaction.").
word("conversion", 'n.', "A software product converted from one platform to another.").
word("conversion", 'n.', "An online advertising performance metric representing a visitor performing whatever the intended result of an ad is defined to be.").
word("convertible", 'adj.', "Able to be converted, particularly:").
word("convex", 'adj.', "Curved or bowed outward like the outside of a bowl, circle, or sphere.").
word("convex", 'adj.', "Having no internal angles greater than 180 degrees.").
word("conveyance", 'n.', "A means of transporting, especially a vehicle.").
word("conveyance", 'n.', "An instrument transferring title of an object from one person or group of persons to another.").
word("convivial", 'adj.', "Having elements of a feast or of entertainment, especially when it comes to eating and drinking, with accompanying festivity").
word("convolution", 'n.', "A form of moving average.").
word("convolution", 'n.', "Any of the folds on the surface of the brain.").
word("convolve", 'v.', "To roll together, or one part on another").
word("convolve", 'v.', "To form the convolution of something with something else").
word("convoy", 'n.', "One or more merchant ships sailing in company to the same general destination under the protection of naval vessels.").
word("convoy", 'n.', "A group of vehicles travelling together for safety, especially one with an escort.").
word("convulse", 'v.', "To suffer violent involuntary contraction of the muscles, producing contortions of the body or limbs.").
word("convulse", 'v.', "To create great laughter.").
word("convulsion", 'n.', "An intense, paroxysmal, involuntary muscular contraction.").
word("convulsion", 'n.', "An uncontrolled fit, as of laughter; a paroxysm.").
word("copious", 'adj.', "Full of thought, information, or matter; exuberant in words, expression, or style.").
word("copious", 'adj.', "Having an abundant supply.").
word("coquette", 'n.', "A woman who flirts or plays with men's affections.").
word("coquette", 'n.', "Any hummingbird in the genus Lophornis").
word("cornice", 'n.', "A decorative element applied at the topmost part of the wall of a room, as with a crown molding.").
word("cornice", 'n.', "A horizontal architectural element of a building, projecting forward from the main walls, originally used as a means of directing rainwater away from the building's walls.").
word("cornucopia", 'n.', "A goat's horn endlessly overflowing with fruit, flowers and grain; or full of whatever its owner wanted: or, an image of a such a horn, either in two or three dimensions.").
word("cornucopia", 'n.', "A hollow horn- or cone-shaped object, filled with edible or useful things.").
word("corollary", 'n.', "A proposition which follows easily from the proof of another proposition.").
word("corollary", 'n.', "Something given beyond what is actually due; something added or superfluous.").
word("coronation", 'n.', "The act or solemnity of crowning a sovereign; the act of investing a prince with the insignia of royalty, on his succeeding to the sovereignty.").
word("coronation", 'n.', "A success in the face of little or no opposition.").
word("coronet", 'n.', "The ring of tissue between a horse's hoof and its leg.").
word("coronet", 'n.', "The traditional lowest regular commissioned officer rank in the cavalry.").
word("corporal", 'adj.', "Of or pertaining to the body, especially the human body; bodily.").
word("corporal", 'adj.', "Pertaining to the body (the thorax and abdomen), as distinguished from the head, limbs and wings, etc.").
word("corporate", 'adj.', "Unified into one body; collective.").
word("corporate", 'adj.', "Of or relating to a corporation.").
word("corporeal", 'adj.', "Material; tangible; physical.").
word("corporeal", 'adj.', "Pertaining to the body; bodily; corporal.").
word("corps", 'n.', "An organized group of people united by a common purpose.").
word("corps", 'n.', "A battlefield formation composed of two or more divisions.").
word("corpse", 'n.', "A human body in general, whether living or dead.").
word("corpse", 'n.', "A dead body.").
word("corpulent", 'adj.', "Large in body; fat; overweight.").
word("corpulent", 'adj.', "Physical, material, corporeal.").
word("corpuscle", 'n.', "A minute particle; an atom; a molecule.").
word("corpuscle", 'n.', "A protoplasmic animal cell; especially, such as float free, like blood, lymph, and pus corpuscles; or such as are embedded in an intercellular matrix, like connective tissue and cartilage corpuscles.").
word("correlate", 'v.', "To compare things and bring them into a relation having corresponding characteristics").
word("correlate", 'v.', "To be related by a correlation").
word("correlative", 'adj.', "Mutually related; corresponding.").
word("corrigible", 'adj.', "Able to be corrected or set right.").
word("corrigible", 'adj.', "Having power to correct.").
word("corroborate", 'v.', "To confirm or support something with additional evidence; to attest or vouch for.").
word("corroborate", 'v.', "To make strong; to strengthen.").
word("corroboration", 'n.', "The act of corroborating, strengthening, or confirming; addition of strength; confirmation").
word("corroboration", 'n.', "That which corroborates.").
word("corrode", 'v.', "To eat away bit by bit; to wear away or diminish by gradually separating or destroying small particles of, as by action of a strong acid or a caustic alkali.").
word("corrode", 'v.', "To consume; to wear away; to prey upon; to impair.").
word("corrosion", 'n.', "The gradual destruction or undermining of something.").
word("corrosion", 'n.', "Erosion by chemical action, especially oxidation.").
word("corrosive", 'n.', "That which has the quality of eating or wearing away gradually.").
word("corrosive", 'n.', "Any solid, liquid or gas capable of irreparably harming living tissues or damaging material on contact.").
word("corruptible", 'adj.', "Bribable, that can be bought").
word("corruptible", 'adj.', "Perishable, subject to decay").
word("corruption", 'n.', "Something originally good or pure that has turned evil or impure; a perversion.").
word("corruption", 'n.', "The act of changing, or of being changed, for the worse; departure from what is pure, simple, or correct.").
word("cosmetic", 'adj.', "External or superficial; pertaining only to the surface or appearance of something.").
word("cosmetic", 'adj.', "Imparting or improving beauty, particularly the beauty of the complexion.").
word("cosmic", 'adj.', "Rising or setting with the sun; not acronycal.").
word("cosmic", 'adj.', "Of or from or pertaining to the cosmos or universe.").
word("cosmogony", 'n.', "Any specific theory, model, myth, or other account of the origin of the universe.").
word("cosmogony", 'n.', "The study of the origin, and sometimes the development, of the universe or the solar system, in astrophysics, religion, and other fields.").
word("cosmography", 'n.', "The study of the size and geometry of the universe and changes in those with cosmic time.").
word("cosmography", 'n.', "The creation of maps of the universe.").
word("cosmology", 'n.', "A metaphysical study into the origin and nature of the universe.").
word("cosmology", 'n.', "A particular view (cultural or religious) of the structure and origin of the universe.").
word("cosmopolitan", 'adj.', "Composed of people from all over the world.").
word("cosmopolitan", 'adj.', "Inclusive; affecting the whole world.").
word("cosmopolitanism", 'n.', "The idea that all of humanity belongs to a single moral community.").
word("cosmos", 'n.', "An ordered, harmonious whole.").
word("cosmos", 'n.', "The universe.").
word("counteract", 'v.', "To deliberately act in opposition to, to thwart or frustrate").
word("counteract", 'v.', "To have a contrary or opposing effect or force on").
word("counterbalance", 'v.', "To match or equal in effect when applying opposing force").
word("counterbalance", 'v.', "To apply weight in order to balance an opposing weight.").
word("countercharge", 'v.', "To reverse the colors.").
word("counterfeit", 'adj.', "Assuming the appearance of something; deceitful; hypocritical.").
word("counterfeit", 'adj.', "False, especially of money; intended to deceive or carry appearance of being genuine.").
word("counterpart", 'n.', "Either of two parts that fit together, or complement one another.").
word("counterpart", 'n.', "Either half of a flattened fossil when the rock has split along the plane of the fossil.").
word("countervail", 'v.', "To compensate for.").
word("countervail", 'v.', "To have the same value or number as.").
word("countryman", 'n.', "A settled person, as opposed to a traveller.").
word("countryman", 'n.', "A country dweller, especially a follower of country pursuits.").
word("courageous", 'adj.', "Of a person, displaying or possessing courage.").
word("courageous", 'adj.', "Of an action, that requires courage.").
word("course", 'n.', "A sequence of events.").
word("course", 'n.', "A path that something or someone moves along.").
word("courser", 'n.', "Any of several species of bird in the genus Cursorius of the family Glareolidae.").
word("courser", 'n.', "A hunter.").
word("courtesy", 'n.', "A polite gesture or remark, especially as opposed to an obligation or standard practice.").
word("courtesy", 'n.', "The life interest that the surviving husband has in the real or heritable estate of his wife.").
word("covenant", 'n.', "A pact or binding agreement between two or more parties.").
word("covenant", 'n.', "An agreement to do or not do a particular thing.").
word("covert", 'adj.', "Secret, surreptitious, concealed.").
word("covert", 'adj.', "Hidden, covered over; overgrown, sheltered.").
word("covey", 'n.', "A brood of partridges, grouse, etc.").
word("covey", 'n.', "A group of 8–12 (or more) quail.").
word("cower", 'v.', "To crouch or cringe, or to avoid or shy away from something, in fear.").
word("cower", 'v.', "To crouch in general.").
word("coxswain", 'n.', "The member of a crew who steers the shell and coordinates the power and rhythm of the rowers.").
word("coxswain", 'n.', "In a ship's boat, the helmsman given charge of the boat's crew.").
word("crag", 'n.', "A rocky outcrop; a rugged steep cliff or rock.").
word("crag", 'n.', "A rough, broken fragment of rock.").
word("cranium", 'n.', "That part of the skull consisting of the bones enclosing the brain, but not including the bones of the face or jaw.").
word("cranium", 'n.', "The upper portion of the skull, including the neurocranium and facial bones, but not including the jawbone (mandible).").
word("crass", 'adj.', "Lacking finesse; crude and obvious.").
word("crass", 'adj.', "Coarse; crude; unrefined or insensitive; lacking discrimination").
word("craving", 'n.', "A strong desire; yearning.").
word("creak", 'n.', "The sound produced by anything that creaks; a creaking.").
word("creamery", 'n.', "A place where dairy products are prepared or sold.").
word("creamery", 'n.', "An ice cream parlour.").
word("creamy", 'adj.', "Of food or drink, having the rich taste or thick, smooth texture of cream, whether or not it actually contains cream.").
word("creamy", 'adj.', "Containing cream.").
word("credence", 'n.', "A subjective probability estimate of a belief or claim.").
word("credence", 'n.', "Acceptance of a belief or claim as true, especially on the basis of evidence.").
word("credible", 'adj.', "Believable or plausible.").
word("credible", 'adj.', "Authentic or convincing.").
word("credulous", 'adj.', "Excessively ready to believe things; gullible.").
word("credulous", 'adj.', "Believed too readily.").
word("creed", 'n.', "That which is believed; accepted doctrine, especially religious doctrine; a particular set of beliefs; any summary of principles or opinions professed or adhered to.").
word("creed", 'n.', "A reading or statement of belief that summarizes the faith it represents; a confession of faith for public use, especially one which is brief and comprehensive.").
word("crematory", 'adj.', "Pertaining to the act of cremating bodies.").
word("crevasse", 'n.', "A crack or fissure in a glacier or snowfield; a chasm.").
word("crevasse", 'n.', "Any cleft or fissure.").
word("crevice", 'n.', "A narrow crack or fissure, as in a rock or wall.").
word("criterion", 'n.', "A standard or test by which individual things or people may be compared and judged.").
word("critique", 'n.', "An essay in which another piece of work is criticised, reviewed, etc.").
word("critique", 'n.', "The art of criticism.").
word("crockery", 'n.', "Dishes, plates, and similar tableware collectively, usually made of some ceramic material, used for serving food on and eating from.").
word("crockery", 'n.', "Crocks or earthenware vessels, especially domestic utensils, collectively.").
word("crucible", 'n.', "A very difficult and trying experience, that acts as a refining or hardening process.").
word("crucible", 'n.', "A heat-resistant container in which metals are melted, usually at temperatures above 500°C, commonly made of graphite with clay as a binder.").
word("crusade", 'n.', "Any war instigated and blessed by the Church for alleged religious ends. Especially, papal sanctioned military campaigns against infidels or heretics.").
word("crusade", 'n.', "Any of the military expeditions undertaken by the Christians of Europe in the 11th to 13th centuries to reconquer the Levant from the Muslims.").
word("crustaceous", 'adj.', "Hard, thin and brittle.").
word("crustaceous", 'adj.', "Resembling a crustacean.").
word("cryptogram", 'n.', "A type of word puzzle in which text encoded by a simple cipher is to be decoded.").
word("cryptogram", 'n.', "Encrypted text.").
word("crystallize", 'v.', "To give something a definite or precise form").
word("crystallize", 'v.', "To take a definite form").
word("cudgel", 'n.', "A short heavy club with a rounded head used as a weapon.").
word("cudgel", 'n.', "Anything that can be used as a threat to force one's will on another.").
word("culinary", 'adj.', "Relating to the practice of cookery or the activity of cooking.").
word("culinary", 'adj.', "Of or relating to a kitchen.").
word("cull", 'v.', "To pick or take someone or something (from a larger group).").
word("cull", 'v.', "To select animals from a group and then kill them in order to reduce the numbers of the group in a controlled manner.").
word("culpable", 'adj.', "Meriting condemnation, censure or blame, especially as something wrong, harmful or injurious; blameworthy, guilty.").
word("culprit", 'n.', "The person or thing at fault for a problem or crime.").
word("culprit", 'n.', "A prisoner accused but not yet tried.").
word("culvert", 'n.', "A transverse channel under a road or railway for the draining of water.").
word("cupidity", 'n.', "Extreme greed, especially for wealth.").
word("curable", 'adj.', "Capable of being cured.").
word("curator", 'n.', "A person who manages, administers or organizes a collection, either independently or employed by a museum, library, archive or zoo.").
word("curator", 'n.', "One appointed to act as guardian of the estate of a person not legally competent to manage it, or of an absentee; a trustee.").
word("curio", 'n.', "A strange and interesting object; something that evokes curiosity.").
word("cursive", 'adj.', "Having successive letters joined together.").
word("cursive", 'adj.', "Of or relating to a grammatical aspect relating to an action that occurs in a straight line (in space or time).").
word("cursory", 'adj.', "Hasty or superficial").
word("cursory", 'adj.', "Careless or desultory").
word("curt", 'adj.', "Short or concise.").
word("curt", 'adj.', "Brief or terse, especially to the point of being rude.").
word("curtail", 'v.', "To cut short the tail of an animal").
word("curtail", 'v.', "To shorten or abridge the duration of something; to truncate.").
word("cycloid", 'adj.', "Thin and rounded, with smooth edges.").
word("cycloid", 'adj.', "Characterized by alternating high and low moods.").
word("cygnet", 'n.', "The young of a swan.").
word("cynical", 'adj.', "Showing contempt for accepted moral standards by one's actions.").
word("cynical", 'adj.', "Skeptical of the integrity, sincerity, or motives of others.").
word("cynicism", 'n.', "A skeptical, scornful or pessimistic comment or act.").
word("cynicism", 'n.', "A distrustful attitude.").
word("cynosure", 'n.', "Something that is the center of attention; an object that serves as a focal point of attraction and admiration.").
word("cynosure", 'n.', "That which serves to guide or direct; a guiding star.").
word("daring", 'adj.', "Courageous or showing bravery; doughty.").
word("daring", 'adj.', "Adventurous, willing to take on or look for risks; overbold.").
word("darkling", 'adv.', "In the dark; in obscurity.").
word("dastard", 'n.', "A malicious coward; a dishonorable sneak.").
word("datum", 'n.', "(plural: 'data') A measurement of something on a scale understood by both the recorder (a person or device) and the reader (another person or device). The scale is arbitrarily defined, such as from 1 to 10 by ones, 1 to 100 by 0.1, or simply true or false, on or off, yes, no, or maybe, etc.").
word("datum", 'n.', "(plural: 'data') A fact known from direct observation.").
word("dauntless", 'adj.', "Invulnerable to fear or intimidation.").
word("dearth", 'n.', "A period or condition when food is rare and hence expensive; famine.").
word("dearth", 'n.', "Scarcity; a lack or short supply.").
word("death's-head", 'n.', "A human skull, as symbol of death.").
word("death's-head", 'n.', "A kind of hawk moth with pale markings on the back of the thorax somewhat like a skull.").
word("debase", 'v.', "To lower in character, quality, or value; to degrade.").
word("debase", 'v.', "To lower in position or rank. Oxford English Dictionary, 2nd ed., 1989.").
word("debatable", 'adj.', "Open to debate; not fully proved or confirmed.").
word("debatable", 'adj.', "Able to be debated; up for discussion.").
word("debonair", 'adj.', "Gracious, courteous.").
word("debonair", 'adj.', "Charming, confident and carefully dressed.").
word("debut", 'n.', "A performer's first performance to the public, in sport, the arts or some other area.").
word("debut", 'n.', "The first public presentation of a theatrical play, motion picture, opera, musical composition, dance, or other performing arts piece.").
word("decagon", 'n.', "A polygon with ten sides and ten angles.").
word("decagram", 'n.', "A regular ten-pointed star shape.").
word("decamp", 'v.', "To disappear suddenly and secretly.").
word("decamp", 'v.', "To break up camp and move on.").
word("decapitate", 'v.', "To oust or destroy the leadership or ruling body of (a government etc.).").
word("decapitate", 'v.', "To remove the head of.").
word("decapod", 'adj.', "Having ten legs.").
word("decasyllable", 'n.', "A verse form having ten syllables in each line.").
word("deceit", 'n.', "An act of deceiving someone.").
word("deceit", 'n.', "An act or practice intended to deceive; a trick.").
word("deceitful", 'adj.', "Deceptive, two-faced.").
word("deceitful", 'adj.', "Deliberately misleading or cheating.").
word("deceive", 'v.', "To trick or mislead.").
word("decency", 'n.', "That which is proper or becoming.").
word("decency", 'n.', "The quality of being decent; propriety.").
word("decent", 'adj.', "Having a suitable conformity to basic moral standards; showing integrity, fairness, or other characteristics associated with moral uprightness.").
word("decent", 'adj.', "Sufficiently clothed or dressed to be seen.").
word("deciduous", 'adj.', "Describing a part that falls off, or is shed, at a particular time or stage of development.").
word("deciduous", 'adj.', "Of or pertaining to trees which lose their leaves in winter or the dry season.").
word("decimal", 'adj.', "Concerning numbers expressed in decimal or mathematical calculations performed using decimal.").
word("decimate", 'v.', "To destroy or remove one-tenth of anything.").
word("decimate", 'v.', "To reduce to one-tenth: to destroy or remove nine-tenths of anything.").
word("decipher", 'v.', "To read text that is almost illegible or obscure").
word("decipher", 'v.', "To decode or decrypt a code or cipher to plain text.").
word("declamation", 'n.', "The act or art of declaiming; rhetorical delivery; loud speaking in public.").
word("declamation", 'n.', "Pretentious rhetorical display, with more sound than sense.").
word("declamatory", 'adj.', "Pretentiously lofty in style; bombastic.").
word("declamatory", 'adj.', "Having the quality of a declamation.").
word("declarative", 'adj.', "Expressing truth.").
word("declarative", 'adj.', "Serving to declare; having the quality of a declaration.").
word("declension", 'n.', "The act of declining a word; the act of listing the of a noun, pronoun or adjective in order.").
word("declension", 'n.', "A way of categorizing nouns, pronouns, or adjectives according to the inflections they receive.").
word("decorate", 'v.', "To extend a method, etc. by attaching some further code item.").
word("decorate", 'v.', "To honor by providing a medal, ribbon, or other adornment.").
word("decorous", 'adj.', "Marked by proper behavior.").
word("decoy", 'n.', "A person or object meant to lure somebody into danger.").
word("decoy", 'n.', "A real or fake animal used by hunters to lure game.").
word("decrepit", 'adj.', "Weakened or worn out from age or wear.").
word("dedication", 'n.', "The deliberate or negligent surrender of all rights to property.").
word("dedication", 'n.', "A note addressed to a patron or friend, prefixed to a work of art as a token of respect, esteem, or affection.").
word("deduce", 'v.', "To reach (a conclusion) by applying rules of logic or other forms of reasoning to given premises or known facts.").
word("deduce", 'v.', "To be derived or obtained from some source.").
word("deface", 'v.', "To damage or vandalize something, especially a surface, in a visible or conspicuous manner.").
word("deface", 'v.', "To void or devalue; to nullify or degrade the face value of.").
word("defalcate", 'v.', "To misappropriate funds; to embezzle.").
word("defamation", 'n.', "The act of injuring another person's reputation by any slanderous communication, written or oral; the wrong of maliciously injuring the good name of another.").
word("defame", 'v.', "To disgrace; to bring into disrepute.").
word("defame", 'v.', "To harm or diminish the reputation of; to disparage.").
word("default", 'n.', "A failing or failure; omission of that which ought to be done; neglect to do what duty or law requires.").
word("default", 'n.', "The failure of a defendant to appear and answer a summons and complaint.").
word("defendant", 'n.', "In civil proceedings, the party responding to the complaint; one who is sued and called upon to make satisfaction for a wrong complained of by another.").
word("defendant", 'n.', "In criminal proceedings, the accused.").
word("defensible", 'adj.', "Capable of being justified").
word("defensible", 'adj.', "Capable of being defended against armed attack").
word("defensive", 'adj.', "Displaying an inordinate sensitivity to criticism or intrusion; oversensitive; thin-skinned.").
word("defensive", 'adj.', "Intended to deter attack.").
word("defer", 'v.', "To render, to offer.").
word("defer", 'v.', "After winning the opening coin toss, to postpone until the start of the second half a team's choice of whether to kick off or receive (and to allow the opposing team to make this choice at the start of the first half).").
word("deference", 'n.', "The willingness to carry out the wishes of others.").
word("deference", 'n.', "Great respect.").
word("defiant", 'adj.', "Boldly resisting opposition.").
word("defiant", 'adj.', "Defying.").
word("deficiency", 'n.', "An insufficiency, especially of something essential to health.").
word("deficiency", 'n.', "The codimension of a linear system in the corresponding complete linear system.").
word("deficient", 'adj.', "Of a number n, Having the sum of divisors σ(n) , or, equivalently, the sum of proper divisors (or aliquot sum) s(n) .").
word("deficient", 'adj.', "Insufficient or inadequate in amount.").
word("definite", 'adj.', "Designating an identified or immediately identifiable person or thing, or group of persons or things").
word("definite", 'adj.', "Free from any doubt.").
word("deflect", 'v.', "To deviate from its original path.").
word("deflect", 'v.', "To touch the ball, often unwittingly, after a shot or a sharp pass, thereby making it unpredictable for the other players.").
word("deforest", 'v.', "To clear (an area) of forest.").
word("deform", 'v.', "To become misshapen or changed in shape.").
word("deform", 'v.', "To alter the shape of by stress.").
word("deformity", 'n.', "An ugly or misshapen feature or characteristic.").
word("deformity", 'n.', "The state of being deformed.").
word("defraud", 'v.', "To deprive.").
word("defraud", 'v.', "To obtain money or property from (a person) by fraud; to swindle.").
word("defray", 'v.', "To pay for (something).").
word("defray", 'v.', "To pay or discharge (a debt, expense etc.); to meet (the cost of something).").
word("degeneracy", 'n.', "The ability of one part of the brain to take over another's function without being overexerted.").
word("degeneracy", 'n.', "The state of being degenerate .").
word("degenerate", 'v.', "To lose good or desirable qualities.").
word("degenerate", 'v.', "To cause to lose good or desirable qualities.").
word("degradation", 'n.', "Diminution or reduction of strength, efficacy, or value; degeneration; deterioration.").
word("degradation", 'n.', "A deleterious change in the chemical structure, physical properties or appearance of a material from natural or artificial exposure.").
word("degrade", 'v.', "To lower in value or social position.").
word("degrade", 'v.', "To reduce in quality or purity.").
word("dehydrate", 'v.', "To lose or remove water; to dry").
word("deify", 'v.', "To make a god of (something or someone).").
word("deify", 'v.', "To treat as worthy of worship; to regard as a deity.").
word("deign", 'v.', "To esteem worthy; to consider worth notice.").
word("deign", 'v.', "To condescend; to do despite a perceived affront to one's dignity.").
word("deist", 'n.', "A person who believes in deism.").
word("deity", 'n.', "A supernatural divine being; a god or goddess.").
word("deity", 'n.', ": the state, position, or fact of being a god.").
word("deject", 'v.', "To debase or humble.").
word("deject", 'v.', "To cast downward.").
word("dejection", 'n.', "A state of melancholy or depression; low spirits, the blues.").
word("dejection", 'n.', "A low condition; weakness; inability.").
word("delectable", 'adj.', "Highly pleasing; delightful, especially to any of the senses; delicious.").
word("delectation", 'n.', "Great pleasure; delight.").
word("deleterious", 'adj.', "Harmful often in a subtle or unexpected way.").
word("deleterious", 'adj.', "Having lower fitness.").
word("delicacy", 'n.', "Refinement in taste or discrimination.").
word("delicacy", 'n.', "Tact and propriety; the need for such tact.").
word("delineate", 'v.', "To sketch out, draw or trace an outline.").
word("delineate", 'v.', "To depict, represent with pictures.").
word("deliquesce", 'v.', "To become liquid by absorbing water from the atmosphere and dissolving in it.").
word("deliquesce", 'v.', "To melt and disappear.").
word("delirious", 'adj.', "Having uncontrolled excitement; ecstatic.").
word("delirious", 'adj.', "Being in the state of delirium.").
word("delude", 'v.', "To frustrate or disappoint.").
word("delude", 'v.', "To deceive into believing something which is false; to lead into error; to dupe.").
word("deluge", 'v.', "To flood with water.").
word("deluge", 'v.', "To overwhelm.").
word("delusion", 'n.', "A false belief that is resistant to confrontation with actual facts.").
word("delusion", 'n.', "A fixed, false belief, that will not change, despite evidence to the contrary.").
word("demagnetize", 'v.', "To erase the contents of a magnetic storage device.").
word("demagnetize", 'v.', "To make something nonmagnetic by removing its magnetic properties.").
word("demagogue", 'n.', "A political orator or leader who gains favor by pandering to or exciting the passions and prejudices of the audience rather than by using rational argument.").
word("demagogue", 'n.', "A leader of the people.").
word("demeanor", 'n.', "The social, non-verbal behaviours (such as body language and facial expressions) that are characteristic of a person.").
word("demented", 'adj.', "Insane or mentally ill.").
word("demented", 'adj.', "Crazy; ridiculous.").
word("demerit", 'n.', "A mark given for bad conduct to a person attending an educational institution or serving in the army.").
word("demerit", 'n.', "That which one merits or deserves, either of good or ill; desert.").
word("demise", 'n.', "Death.").
word("demise", 'n.', "The end of something, in a negative sense; downfall.").
word("demobilize", 'v.', "To disband troops, or remove them from a war footing.").
word("demobilize", 'v.', "To release someone from military duty, especially after a war.").
word("demolish", 'v.', "To destroy.").
word("demolish", 'v.', "To defeat or consume utterly (as a theory, belief or opponent).").
word("demonstrable", 'adj.', "Able to be demonstrated.").
word("demonstrate", 'v.', "To show, display, or present; to prove or make evident").
word("demonstrate", 'v.', "To show the steps taken to create a logical argument or equation.").
word("demonstrative", 'adj.', "Given to open displays of emotion").
word("demonstrative", 'adj.', "That specifies the thing or person referred to").
word("demonstrator", 'n.', "One who teaches anatomy from the dissected parts.").
word("demonstrator", 'n.', "One who demonstrates anything, or proves beyond doubt.").
word("demulcent", 'n.', "A soothing medication used to relieve pain in inflamed tissues.").
word("demurrage", 'n.', "The detention of a ship or other freight vehicle, during delayed loading or unloading").
word("demurrage", 'n.', "Compensation paid for such detention").
word("dendroid", 'adj.', "Resembling a shrub or tree.").
word("dendrology", 'n.', "The study of trees and other woody plants").
word("denizen", 'n.', "An inhabitant of a place; one who dwells in.").
word("denizen", 'n.', "A foreign word that has become naturalised in another language.").
word("denominate", 'v.', "To name; to designate.").
word("denominate", 'v.', "To express in a monetary unit.").
word("denomination", 'n.', "That by which anything is denominated or styled; an epithet; a name, designation, or title; especially, a general name indicating a class of like individuals.").
word("denomination", 'n.', "The act of naming or designating.").
word("denominator", 'n.', "The number or expression written below the line in a fraction (such as 2 in ½).").
word("denominator", 'n.', "One who gives a name to something.").
word("denote", 'v.', "To make overt.").
word("denote", 'v.', "To indicate; to mark.").
word("denounce", 'v.', "To criticize or speak out against (someone or something); to point out as deserving of reprehension, etc.; to openly accuse or condemn in a threatening manner; to invoke censure upon; to stigmatize; to blame.").
word("denounce", 'v.', "To make a formal or public accusation against; to inform against; to accuse.").
word("dentifrice", 'n.', "Toothpaste or any other substance, such as powder, for cleaning the teeth.").
word("denude", 'v.', "To divest of all covering; to make bare or naked; to strip.").
word("denunciation", 'n.', "An open declaration of personal fault.").
word("denunciation", 'n.', "That by which anything is denounced; threat of evil; public menace or accusation; arraignment.").
word("deplete", 'v.', "To reduce by destroying or consuming the vital powers of; to exhaust, as a country of its strength or resources, a treasury of money, etc.").
word("deplete", 'v.', "To empty or unload, as the vessels of the human system, by bloodletting or by medicine.").
word("deplorable", 'adj.', "To be felt sorrow for; worthy of compassion; lamentable.").
word("deplorable", 'adj.', "Deserving strong condemnation; shockingly bad, wretched.").
word("deplore", 'v.', "To regard as hopeless; to give up.").
word("deplore", 'v.', "To bewail; to weep bitterly over; to feel sorrow for.").
word("deponent", 'adj.', "Having passive form (that is, conjugating like the passive voice), but an active meaning. (Such verbs, originally reflexive, are considered to have laid aside their passive meanings.)").
word("depopulate", 'v.', "To remove the components from a circuit board.").
word("depopulate", 'v.', "To reduce the population of a region by disease, war, forced relocation etc.").
word("deport", 'v.', "To comport (oneself); to behave.").
word("deport", 'v.', "To evict, especially from a country.").
word("deportment", 'n.', "Apparent level of schooling or training.").
word("deportment", 'n.', "Bearing; manner of presenting oneself.").
word("deposition", 'n.', "The formal placement of relics in a church or shrine, and the feast day commemorating it.").
word("deposition", 'n.', "The process of taking sworn testimony out of court; the testimony so taken.").
word("depositor", 'n.', "A person who makes a deposit, especially a deposit of money in a bank").
word("depository", 'n.', "A place where something is deposited, as for storage, safekeeping or preservation; a repository.").
word("depository", 'n.', "A trustee; a depositary.").
word("deprave", 'v.', "To make bad or worse; to vitiate; to corrupt").
word("deprave", 'v.', "To speak ill of; to depreciate; to malign; to revile").
word("deprecate", 'v.', "To belittle or express disapproval of.").
word("deprecate", 'v.', "To declare something obsolescent; to recommend against a function, technique, command, etc. that still works but has been replaced.").
word("depreciate", 'v.', "To lessen in price or estimated value; to lower the worth of.").
word("depreciate", 'v.', "To decline in value over time.").
word("depreciation", 'n.', "The decline in value of assets.").
word("depreciation", 'n.', "The measurement of the decline in value of assets. Not to be confused with impairment, which is the measurement of the unplanned, extraordinary decline in value of assets.").
word("depress", 'v.', "To press down.").
word("depress", 'v.', "To bring down or humble; to abase (pride, etc.).").
word("depression", 'n.', "The act of lowering or pressing something down.").
word("depression", 'n.', "A lowering, in particular a reduction in a particular biological variable or the function of an organ, in contrast to elevation.").
word("depth", 'n.', "The deepest part").
word("depth", 'n.', "Lowness").
word("derelict", 'adj.', "Abandoned, forsaken; given up by the natural owner or guardian; (of a ship) abandoned at sea, dilapidated, neglected; (of a spacecraft) abandoned in outer space.").
word("derelict", 'adj.', "Lost; adrift; hence, wanting; careless; neglectful; unfaithful.").
word("deride", 'v.', "To harshly mock; ridicule.").
word("derisible", 'adj.', "Deserving .").
word("derision", 'n.', "Act of treating with disdain.").
word("derision", 'n.', "Something to be derided; a laughing stock.").
word("derivation", 'n.', "Forming a new word by changing the base of another word or by adding affixes to it.").
word("derivation", 'n.', "The act of receiving anything from a source; the act of procuring an effect from a cause, means, or condition, as profits from capital, conclusions or opinions from evidence.").
word("derivative", 'adj.', "Lacking originality.").
word("derivative", 'adj.', "Imitative of the work of someone else.").
word("derive", 'v.', "To create (a compound) from another by means of a reaction.").
word("derive", 'v.', "To turn the course of (water, etc.); to divert and distribute into subordinate channels.").
word("dermatology", 'n.', "The study of the skin and its diseases.").
word("derrick", 'n.', "A device that is used for lifting and moving large objects.").
word("derrick", 'n.', "A framework that is constructed over a mine or oil well for the purpose of boring or lowering pipes.").
word("descendant", 'n.', "One of the progeny of a specified person, at any distance of time or through any number of generations.").
word("descendant", 'n.', "A language that is descended from another.").
word("descent", 'n.', "A drop to a lower status or condition; decline.").
word("descent", 'n.', "A sloping passage or incline.").
word("descry", 'v.', "To discover (a distant or obscure object) by the eye; to espy; to discern or detect.").
word("descry", 'v.', "To discover: to disclose; to reveal.").
word("desert", 'v.', "To leave (anything that depends on one's presence to survive, exist, or succeed), especially when contrary to a promise or obligation; to abandon; to forsake.").
word("desert", 'v.', "To leave one's duty or post, especially to leave a military or naval unit without permission.").
word("desiccant", 'n.', "A substance (such as calcium oxide or silica gel) that is used as a drying agent because of its high affinity for water.").
word("designate", 'v.', "To mark out and make known; to point out; to indicate; to show; to distinguish by marks or description").
word("designate", 'v.', "To call by a distinctive title; to name.").
word("desist", 'v.', "To cease to proceed or act; to stop .").
word("desistance", 'n.', "The act or state of desisting; cessation.").
word("despair", 'n.', "Loss of hope; utter hopelessness; complete despondency.").
word("despair", 'n.', "That which causes despair.").
word("desperado", 'n.', "A bold outlaw, especially one from southern portions of the Wild West.").
word("desperado", 'n.', "A piece that seems determined to give itself up, typically to bring about stalemate or perpetual check.").
word("desperate", 'adj.', "Being filled with, or in a state of despair; hopeless.").
word("desperate", 'adj.', "Beyond hope; causing despair; extremely perilous; irretrievable.").
word("despicable", 'adj.', "Fit or deserving to be despised; contemptible; mean").
word("despond", 'v.', "To give up the will, courage, or spirit; to become dejected, lose heart.").
word("despondent", 'adj.', "In low spirits from loss of hope or courage.").
word("despot", 'n.', "A ruler with absolute power; a tyrant.").
word("despotism", 'n.', "Government by a singular authority, either a single person or tight-knit group, which rules with absolute power, especially in a cruel and oppressive way.").
word("destitute", 'adj.', "Lacking money; poor, impoverished").
word("destitute", 'adj.', "Lacking something; devoid").
word("desultory", 'adj.', "Out of course; by the way; not connected with the subject.").
word("desultory", 'adj.', "Jumping, or passing, from one thing or subject to another, without order, planning, or rational connection; lacking logical sequence.").
word("deter", 'v.', "To distract someone from something.").
word("deter", 'v.', "To persuade someone not to do something; to discourage.").
word("deteriorate", 'v.', "To grow worse; to be impaired in quality; to degenerate.").
word("deteriorate", 'v.', "To make worse; to make inferior in quality or value; to impair.").
word("determinate", 'adj.', "Distinct, clearly defined.").
word("determinate", 'adj.', "Fixed, set, unvarying.").
word("determination", 'n.', "The quality of mind which reaches definite conclusions; decision of character; resoluteness.").
word("determination", 'n.', "The act of defining a concept or notion by giving its essential constituents.").
word("deterrent", 'adj.', "Serving to deter, preventing something from happening.").
word("detest", 'v.', "To dislike (someone or something) intensely; to loathe.").
word("detest", 'v.', "To witness against; to denounce; to condemn.").
word("detract", 'v.', "To take away; to withdraw or remove.").
word("detract", 'v.', "To take credit or reputation from; to defame or decry.").
word("detriment", 'n.', "A charge made to students and barristers for incidental repairs of the rooms they occupy.").
word("detriment", 'n.', "Harm, hurt, damage.").
word("detrude", 'v.', "To push downwards with force").
word("deviate", 'v.', "To go off course from; to change course; to change plans.").
word("deviate", 'v.', "To fall outside of, or part from, some norm; to stray.").
word("devilry", 'n.', "An act of such mischief, wickedness, cruelty, or witchcraft.").
word("devilry", 'n.', "Mischief.").
word("deviltry", 'n.', "Devilry.").
word("devious", 'adj.', "Cunning or deceiving, not straightforward or honest, not frank").
word("devious", 'adj.', "Roundabout, circuitous, deviating from the direct or ordinary route").
word("devise", 'v.', "To form a scheme; to lay a plan; to contrive; to consider.").
word("devise", 'v.', "To imagine; to guess.").
word("devout", 'adj.', "Devoted to religion or to religious feelings and duties; pious; extremely religious.").
word("devout", 'adj.', "Warmly devoted; hearty; sincere; earnest.").
word("dexterity", 'n.', "Skill in performing tasks, especially with the hands.").
word("diabolic", 'adj.', "Showing wickedness typical of a devil.").
word("diabolic", 'adj.', "Extremely evil or cruel.").
word("diacritical", 'adj.', "Capable of distinguishing or of making a distinction.").
word("diacritical", 'adj.', "Of, pertaining to, or serving as a diacritic").
word("diagnose", 'v.', "To determine the cause of a problem.").
word("diagnose", 'v.', "To determine which disease is causing a sick person's signs and symptoms; to find the diagnosis.").
word("diagnosis", 'n.', "The identification of the nature and cause of something (of any nature).").
word("diagnosis", 'n.', "The identification of the nature and cause of an illness.").
word("dialect", 'n.', "A variant form of the vocalizations of a bird species restricted to a certain area or population.").
word("dialect", 'n.', "A lect (often a or language) as part of a group or family of languages, especially if they are viewed as a single language, or if contrasted with a standardized idiom that is considered the 'true' form of the language (for example, Cantonese as contrasted with Mandarin Chinese, or Bavarian as contrasted with Standard German).").
word("dialectician", 'n.', "Someone skilled in dialectics: someone able to arrive at logical conclusions through reasoned argument.").
word("dialectician", 'n.', "Someone knowledgable about dialects.").
word("dialogue", 'n.', "A conversation or other form of discourse between two or more individuals.").
word("dialogue", 'n.', "In a dramatic or literary presentation, the verbal parts of the script or text; the verbalizations of the actors or characters.").
word("diaphanous", 'adj.', "Of a fine, almost transparent, texture; gossamer; light and insubstantial.").
word("diaphanous", 'adj.', "Transparent or translucent; allowing light to pass through; capable of being seen through.").
word("diatomic", 'adj.', "Consisting of two atoms.").
word("diatomic", 'adj.', "Of or relating to diatoms.").
word("diatribe", 'n.', "An abusive, bitter, attack or criticism: denunciation.").
word("diatribe", 'n.', "A speech or writing which bitterly denounces something.").
word("dictum", 'n.', "A judicial opinion expressed by judges on points that do not necessarily arise in the case, and are not involved in it.").
word("dictum", 'n.', "An arbitrament or award.").
word("didactic", 'adj.', "Teaching from textbooks rather than laboratory demonstration and clinical application.").
word("didactic", 'adj.', "Instructive or intended to teach or demonstrate, especially with regard to morality.").
word("difference", 'n.', "The set of elements that are in one set but not another.").
word("difference", 'n.', "Significant change in or effect on a situation or state.").
word("differentia", 'n.', "A distinguishing feature which marks a species off from other members of the same genus.").
word("differential", 'adj.', "Dependent on, or making a difference; distinctive").
word("differential", 'adj.', "Having differences in speed or direction of motion").
word("differentiate", 'v.', "To show, or be the distinction between two things.").
word("differentiate", 'v.', "To modify, or be modified.").
word("diffidence", 'n.', "Mistrust, distrust, lack of confidence in someone or something.").
word("diffidence", 'n.', "The state of being diffident, timid or shy; reticence or self-effacement.").
word("diffident", 'adj.', "Lacking confidence in others; distrustful.").
word("diffident", 'adj.', "Lacking self-confidence; timid; modest").
word("diffusible", 'adj.', "Able to be diffused").
word("diffusion", 'n.', "The movement of water vapor from regions of high concentration (high water vapor pressure) toward regions of lower concentration.").
word("diffusion", 'n.', "The spread of cultural or linguistic practices, or social institutions, in one or more communities.").
word("dignitary", 'n.', "An important or influential person, or one of high rank or position.").
word("digraph", 'n.', "A two-character sequence used to enter a single conceptual character.").
word("digraph", 'n.', "A pair of letters, especially a pair representing a single phoneme.").
word("digress", 'v.', "To step or turn aside; to deviate; to swerve; especially, to turn aside from the main subject of attention, or course of argument, in writing or speaking.").
word("digress", 'v.', "To turn aside from the right path; to transgress; to offend.").
word("dilate", 'v.', "To speak largely and copiously; to dwell in narration; to enlarge; with \"on\" or \"upon\".").
word("dilate", 'v.', "To become wider or larger; to expand.").
word("dilatory", 'adj.', "Intentionally delaying (someone or something), intended to cause delay, gain time, or defer decision.").
word("dilatory", 'adj.', "Slow or tardy.").
word("dilemma", 'n.', "A circumstance in which a choice must be made between two or more alternatives that seem equally undesirable.").
word("dilemma", 'n.', "Offering to an opponent a choice between two (equally unfavorable) alternatives.").
word("dilettante", 'n.', "An amateur, someone who dabbles in a field out of casual interest rather than as a profession or serious interest.").
word("dilettante", 'n.', "A person with a general but superficial interest in any art or a branch of knowledge.").
word("diligence", 'n.', "The qualities of a hard worker, including conscientiousness, determination, and perseverance.").
word("diligence", 'n.', "Steady application; industry; careful work involving long-term effort.").
word("dilute", 'v.', "To cause the value of individual shares or the stake of a shareholder to decrease by increasing the total number of shares.").
word("dilute", 'v.', "To become attenuated, thin, or weak.").
word("diminution", 'n.', "A lessening, decrease or reduction.").
word("diminution", 'n.', "A compositional technique where the composer shortens the melody by shortening its note values.").
word("dimly", 'adv.', "In a dim manner; not clearly.").
word("diphthong", 'n.', "A complex vowel sound that begins with the sound of one vowel and ends with the sound of another vowel, in the same syllable.").
word("diphthong", 'n.', "A vowel digraph or ligature.").
word("diplomacy", 'n.', "The art and practice of conducting international relations by negotiating alliances, treaties, agreements etc., bilaterally or multilaterally, between states and sometimes international organizations, or even between polities with varying status, such as those of monarchs and their princely vassals.").
word("diplomacy", 'n.', "Tact and subtle skill in dealing with people so as to avoid or settle hostility.").
word("diplomat", 'n.', "A person, such as an ambassador, who is accredited to represent a government officially in its relations with other governments or international organisations").
word("diplomat", 'n.', "Someone who uses skill and tact in dealing with other people").
word("diplomatic", 'adj.', "Describing a publication of a text which follows a single basic manuscript, but with variants in other manuscripts noted in the critical apparatus").
word("diplomatic", 'adj.', "Concerning the relationships between the governments of countries.").
word("diplomatist", 'n.', "A diplomat").
word("disagree", 'v.', "To fail to agree; to have a different opinion or belief.").
word("disagree", 'v.', "To fail to conform or correspond with.").
word("disallow", 'v.', "To reject as invalid, untrue, or improper").
word("disallow", 'v.', "To refuse to allow").
word("disappear", 'v.', "To make vanish; especially, to abduct and murder surreptitiously for political reasons.").
word("disappear", 'v.', "To go missing; to become a missing person.").
word("disappoint", 'v.', "To fail to meet (an expectation); to fail to fulfil (a hope).").
word("disappoint", 'v.', "To deprive (someone of something expected or hoped for).").
word("disapprove", 'v.', "To have or express an unfavorable opinion.").
word("disapprove", 'v.', "To condemn; to consider wrong or inappropriate; used with of.").
word("disarm", 'v.', "To deprive of weapons; to deprive of the means of attack or defense; to render defenseless.").
word("disarm", 'v.', "To reduce one's own military forces.").
word("disarrange", 'v.', "To undo the arrangement of; to disorder; to derange.").
word("disavow", 'v.', "To strongly and solemnly refuse to own or acknowledge; to deny responsibility for, approbation of, and the like.").
word("disavow", 'v.', "To deny; to show the contrary of; to deny legitimacy or achievement of any kind.").
word("disavowal", 'n.', "A denial of knowledge, relationship, and/or responsibility towards something (or someone).").
word("disbeliever", 'n.', "One who disbelieves; one who does not believe.").
word("disburden", 'v.', "To free from a source of mental trouble.").
word("disburden", 'v.', "To rid of a burden; to free from a load carried; to unload.").
word("disburse", 'v.', "To pay out, expend; usually from a public fund or treasury.").
word("discard", 'v.', "To throw away, to reject.").
word("discard", 'v.', "To dismiss from employment, confidence, or favour; to discharge.").
word("discernible", 'adj.', "Possible to discern; detectable or derivable by use of the senses or the intellect.").
word("disciple", 'n.', "A person who learns from another, especially one who then teaches others.").
word("disciple", 'n.', "An active follower or adherent of someone, or some philosophy etc.").
word("disciplinary", 'adj.', "For the purpose of imposing punishment.").
word("disciplinary", 'adj.', "Of or relating to an academic field of study.").
word("discipline", 'v.', "To impose order on someone.").
word("discipline", 'v.', "To punish someone in order to (re)gain control.").
word("disclaim", 'v.', "To renounce all claim to; to deny ownership of or responsibility for; to disown; to disavow; to reject.").
word("disclaim", 'v.', "To relinquish or deny having a claim; to disavow another's claim; to decline accepting, as an estate, interest, or office").
word("discolor", 'v.', "To change or lose color.").
word("discomfit", 'v.', "To defeat completely; to rout.").
word("discomfit", 'v.', "To embarrass (someone) greatly; to confuse; to perplex; to disconcert.").
word("discomfort", 'n.', "Something that disturbs one’s comfort; an annoyance.").
word("discomfort", 'n.', "Mental or bodily distress.").
word("disconnect", 'v.', "To sever or interrupt a connection.").
word("disconnect", 'v.', "Of a person, to become detached or withdrawn.").
word("disconsolate", 'adj.', "Seemingly beyond consolation; inconsolable.").
word("disconsolate", 'adj.', "Cheerless, dreary.").
word("discontinuance", 'n.', "The occurrence of something being discontinued; a cessation; an incomplete ending.").
word("discord", 'n.', "Any harsh noise, or confused mingling of sounds.").
word("discord", 'n.', "Lack of concord, agreement or harmony.").
word("discountenance", 'v.', "To abash, embarrass or disconcert.").
word("discountenance", 'v.', "To have an unfavorable opinion of; to deprecate or disapprove of.").
word("discover", 'v.', "To find or learn something for the first time.").
word("discover", 'v.', "To create by moving a piece out of another piece's line of attack.").
word("discredit", 'v.', "To harm the good reputation of a person; to cause an idea or piece of evidence to seem false or unreliable.").
word("discreet", 'adj.', "Not drawing attention, anger or challenge; inconspicuous.").
word("discreet", 'adj.', "Respectful of privacy or secrecy; exercising caution in order to avoid causing embarrassment; quiet; diplomatic.").
word("discrepant", 'adj.', "Showing difference; inconsistent, dissimilar.").
word("discriminate", 'v.', "To set apart as being different; to mark as different; to separate from another by discerning differences; to distinguish.").
word("discriminate", 'v.', "To make decisions based on prejudice.").
word("discursive", 'adj.', "Tending to digress from the main point; rambling.").
word("discursive", 'adj.', "Using reason and argument rather than intuition.").
word("discussion", 'n.', "Conversation or debate concerning a particular topic.").
word("discussion", 'n.', "Text giving further detail on a subject.").
word("disenfranchise", 'v.', "To deprive someone of a franchise, generally of the right to vote.").
word("disengage", 'v.', "To release or loosen from something that binds, entangles, holds, or interlocks.").
word("disfigure", 'v.', "To change the appearance of something/someone to the negative.").
word("dishabille", 'n.', "A loose, negligent dress.").
word("dishabille", 'n.', "Extreme casual or disorderly dress, for example, with the shirt-tail out, sleeves unbuttoned, etc.").
word("dishonest", 'adj.', "Not honest.").
word("dishonest", 'adj.', "Interfering with honesty.").
word("disillusion", 'v.', "To free or deprive of illusion; to disenchant.").
word("disinfect", 'v.', "To sterilize by the use of cleaning agent.").
word("disinfectant", 'n.', "A substance that kills germs and/or viruses.").
word("disinherit", 'v.', "To exclude from inheritance; to disown.").
word("disinterested", 'adj.', "Having no stake or interest in the outcome; free of bias, impartial.").
word("disinterested", 'adj.', "Uninterested, lacking interest.").
word("disjunctive", 'adj.', "Not used in immediate conjunction with the verb of which the pronoun is the subject.").
word("disjunctive", 'adj.', "Tending to disjoin; separating.").
word("dislocate", 'v.', "To put something out of its usual place.").
word("dislocate", 'v.', "To (accidentally) dislodge a skeletal bone from its joint.").
word("dismissal", 'n.', "Deprivation of office; the fact or process of being fired from employment or stripped of rank.").
word("dismissal", 'n.', "The final blessing said by a priest or minister at the end of a religious service.").
word("dismount", 'v.', "To throw (cannon) off their carriages.").
word("dismount", 'v.', "To (cause to) get off (something).").
word("disobedience", 'n.', "Refusal to obey.").
word("disobedient", 'adj.', "Not obedient.").
word("disown", 'v.', "To refuse to own, or to refuse to acknowledge one’s own.").
word("disown", 'v.', "To repudiate any connection to; to renounce.").
word("disparage", 'v.', "To dishonor by a comparison with what is inferior; to lower in rank or estimation by actions or words; to speak slightingly of; to depreciate; to undervalue.").
word("disparage", 'v.', "To match unequally; to degrade or dishonor.").
word("disparity", 'n.', "Incongruity.").
word("disparity", 'n.', "The state of being unequal; difference.").
word("dispel", 'v.', "To drive away or cause to vanish by scattering.").
word("dispel", 'v.', "To remove (fears, doubts, objections etc.) by proving them unjustified.").
word("dispensation", 'n.', "The distribution of good and evil by God to man.").
word("dispensation", 'n.', "The relaxation of a law in a particular case; permission to do something forbidden, or to omit doing something enjoined; exemption.").
word("displace", 'v.', "To put out of place; to disarrange.").
word("displace", 'v.', "To supplant, or take the place of something or someone; to substitute.").
word("dispossess", 'v.', "To deprive someone of the possession of land, especially by evicting them.").
word("dispossess", 'v.', "To deprive someone of possession in general.").
word("disputation", 'n.', "A rhetorical exercise in which parties reason in opposition to each other on some question proposed.").
word("disputation", 'n.', "The act of disputing; a dispute or argument").
word("disqualify", 'v.', "To exclude from consideration by the explicit revocation of a previous qualification.").
word("disqualify", 'v.', "To make ineligible for something.").
word("disquiet", 'v.', "To make (someone or something) worried or anxious.").
word("disregard", 'v.', "To ignore; pay no attention to.").
word("disreputable", 'adj.', "Not respectable, lacking repute; discreditable.").
word("disrepute", 'n.', "Loss or want of reputation; ill character.").
word("disrobe", 'v.', "To undress oneself.").
word("disrobe", 'v.', "To undress someone or something.").
word("disrupt", 'v.', "To interrupt or impede.").
word("disrupt", 'v.', "To throw into confusion or disorder.").
word("dissatisfy", 'v.', "To fail to satisfy; to displease.").
word("dissect", 'v.', "To study an 's anatomy by ting it apart; to perform a necropsy or an autopsy.").
word("dissect", 'v.', "To separate s, s, and so on without cutting into them or disrupting their .").
word("dissection", 'n.', "A minute and detailed examination or analysis").
word("dissection", 'n.', "The act of dissecting, or something dissected").
word("dissemble", 'v.', "To deliberately ignore something; to pretend not to notice.").
word("dissemble", 'v.', "To falsely hide one's opinions or feelings.").
word("disseminate", 'v.', "To sow and scatter principles, ideas, opinions, etc, or concrete things, for growth and propagation, like seeds.").
word("disseminate", 'v.', "To become widespread.").
word("dissension", 'n.', "Strong disagreement; a contention or quarrel; discord.").
word("dissension", 'n.', "An act of expressing dissent, especially spoken.").
word("dissent", 'n.', "An act of disagreeing with, or deviating from, the views and opinions of those holding authority.").
word("dissent", 'n.', "Disagreement with the ideas, doctrines, decrees, etc. of a political party, government or religion.").
word("dissentient", 'n.', "A dissenter.").
word("dissentious", 'adj.', "Marked by dissensions; contentious").
word("dissentious", 'adj.', "Dissenting").
word("dissertation", 'n.', "A formal exposition of a subject, especially a research paper that students write in order to complete the requirements for a doctoral degree; a thesis.").
word("dissertation", 'n.', "A lengthy lecture on a subject; a treatise; a discourse; a sermon.").
word("disservice", 'n.', "Service that results in harm; an (intentionally or unintentionally) unhelpful, harmful action.").
word("dissever", 'v.', "To divide into separate parts.").
word("dissever", 'v.', "To separate; to split apart.").
word("dissimilar", 'adj.', "Not similar; unalike; different").
word("dissipate", 'v.', "To vanish by dispersion.").
word("dissipate", 'v.', "To drive away, disperse.").
word("dissipation", 'n.', "A dissolute course of life, in which health, money, etc., are squandered in pursuit of pleasure; profuseness in immoral indulgence, as late hours, riotous living, etc.; dissoluteness.").
word("dissipation", 'n.', "A trifle which wastes time or distracts attention.").
word("dissolute", 'adj.', "Recklessly abandoned to sensual pleasures.").
word("dissolute", 'adj.', "Unrestrained by morality.").
word("dissolution", 'n.', "The termination of an organized body or legislative assembly, especially a formal dismissal.").
word("dissolution", 'n.', "Disintegration, or decomposition into fragments.").
word("dissolve", 'v.', "To disintegrate chemically into a solution by immersion into a liquid or gas.").
word("dissolve", 'v.', "To shift from one shot to another by having the former fade out as the latter fades in.").
word("dissonance", 'n.', "A harsh, discordant combination of sounds.").
word("dissonance", 'n.', "A state of disagreement or conflict.").
word("dissonant", 'adj.', "Exhibiting dissonance; not agreeing or harmonizing.").
word("dissuade", 'v.', "To convince not to try or do.").
word("dissuasion", 'n.', "The act or an instance of dissuading").
word("distemper", 'n.', "A disorder of the humours of the body; a disease.").
word("distemper", 'n.', "A viral disease of animals, such as dogs and cats, characterised by fever, coughing and catarrh.").
word("distend", 'v.', "To extend; to stretch out; to spread out.").
word("distend", 'v.', "To extend or expand, as from internal pressure; to swell").
word("distensible", 'adj.', "Capable of swelling or stretching.").
word("distention", 'n.', "The act of distending.").
word("distill", 'v.', "To be manifested gently or gradually.").
word("distill", 'v.', "To drip or be wet with.").
word("distillation", 'n.', "The separation of more volatile parts of a substance from less volatile ones by evaporation and condensation.").
word("distillation", 'n.', "The act of falling in drops, or the act of pouring out in drops.").
word("distiller", 'n.', "A company whose business is distilling, especially one that manufactures alcoholic spirits or liquor.").
word("distiller", 'n.', "A device or apparatus that distills, a condenser; a still.").
word("distinction", 'n.', "Specifically, a feature that causes someone or something to stand out as being better; a mark of honour, rank, eminence or excellence; being distinguished.").
word("distinction", 'n.', "The act of distinguishing, discriminating; discrimination.").
word("distort", 'v.', "To give a false or misleading account of").
word("distort", 'v.', "To become misshapen.").
word("distrain", 'v.', "To pull off, tear apart.").
word("distrain", 'v.', "To seize somebody's property in place of, or to force, payment of a debt.").
word("distrainor", 'n.', "One who distrains; the party distraining goods or chattels.").
word("distraught", 'adj.', "Mad; insane.").
word("distraught", 'adj.', "Deeply hurt, saddened, or worried; incapacitated by distress.").
word("distrust", 'n.', "Lack of trust or confidence.").
word("disunion", 'n.', "Separation of a union").
word("disyllable", 'n.', "A word comprising two syllables.").
word("diurnal", 'adj.', "Published daily.").
word("diurnal", 'adj.', "Having a daily cycle that is completed every 24 hours, usually referring to tasks, processes, tides, or sunrise to sunset; circadian.").
word("divagation", 'n.', "Straying off from a course or way.").
word("divagation", 'n.', "Incoherent or wandering speech and thought.").
word("divergent", 'adj.', "Disagreeing from something given; differing.").
word("divergent", 'adj.', "Of a series, not converging; not approaching a limit.").
word("diverse", 'adj.', "Capable of various forms; multiform.").
word("diverse", 'adj.', "Composed of people with a variety of different demographic characteristics in terms of, for example, ethnicity, gender, sexual orientation, socioeconomic status, etc., and having a sizeable representation of people that are minorities in a given area.").
word("diversion", 'n.', "A hobby; an activity that distracts the mind.").
word("diversion", 'n.', "Removal of water via a canal.").
word("diversity", 'n.', "Equal-opportunity inclusion.").
word("diversity", 'n.', "A variety; diverse types or examples.").
word("divert", 'v.', "To turn aside; to digress.").
word("divert", 'v.', "To turn aside from a course.").
word("divest", 'v.', "To strip, deprive, or dispossess (someone) of something (such as a right, passion, privilege, or prejudice).").
word("divest", 'v.', "To sell off or be rid of through sale, especially of a subsidiary.").
word("divination", 'n.', "The apparent art of discovering secrets or the future by preternatural means.").
word("divination", 'n.', "An indication of what is to come in the future or what is secret; a prediction.").
word("divinity", 'n.', "The state, position, or fact of being a god or God. [from 14th c.]").
word("divinity", 'n.', "The study of religion or religions.").
word("divisible", 'adj.', "Capable of being divided or split.").
word("divisible", 'adj.', "Of an integer, that, when divided by another integer, leaves no remainder.").
word("divisor", 'n.', "A number or expression that another is to be divided by.").
word("divisor", 'n.', "An integer that divides another integer an integral number of times.").
word("divulge", 'v.', "To make public or known; to communicate to the public; to tell (information, especially a secret) so that it may become generally known").
word("divulge", 'v.', "To indicate publicly; to proclaim.").
word("divulgence", 'n.', "The act of divulging.").
word("divulgence", 'n.', "Something that is divulged.").
word("docile", 'adj.', "Yielding to control or supervision, direction, or management.").
word("docile", 'adj.', "Ready to accept instruction or direction; obedient; subservient.").
word("docket", 'n.', "A short entry of the proceedings of a court; the register containing them; the office containing the register.").
word("docket", 'n.', "An agenda of things to be done.").
word("doe", 'n.', "A female deer; also used of similar animals such as antelope, (less commonly goat as nanny is also used).").
word("doe", 'n.', "A female hare.").
word("dogma", 'n.', "A doctrine (or set of doctrines) relating to matters such as morality and faith, set forth authoritatively by a religious organization or leader.").
word("dogma", 'n.', "An authoritative principle, belief or statement of opinion, especially one considered to be absolutely true and indisputable, regardless of evidence or without evidence to support it.").
word("dogmatic", 'adj.', "Adhering only to principles which are true a priori, rather than truths based on evidence or deduction.").
word("dogmatic", 'adj.', "Asserting dogmas or beliefs in a superior or arrogant way; opinionated, dictatorial.").
word("dogmatize", 'v.', "To treat something as dogma.").
word("dogmatize", 'v.', "To speak or write dogmatically.").
word("doleful", 'adj.', "Filled with grief, mournful, bringing feelings of sadness.").
word("dolesome", 'adj.', "Doleful; dismal; gloomy").
word("dolorous", 'adj.', "Solemnly or ponderously sad.").
word("domain", 'n.', "A field or sphere of activity, influence or expertise.").
word("domain", 'n.', "An open and connected set in some topology. For example, the interval (0,1) as a subset of the real numbers.").
word("domesticity", 'n.', "Life at home with one's family.").
word("domesticity", 'n.', "Affection for the home and its material comforts.").
word("domicile", 'n.', "A residence at a particular place accompanied with an intention to remain there for an unlimited time; a residence accepted as a final abode.").
word("domicile", 'n.', "A home or residence.").
word("dominance", 'n.', "Being in a position of power, authority or ascendancy over others.").
word("dominance", 'n.', "The property of a gene such that it suppresses the expression of its allele.").
word("dominant", 'adj.', "Ruling; governing; prevailing").
word("dominant", 'adj.', "Predominant, common, prevalent, of greatest importance.").
word("dominate", 'v.', "To exert an overwhelming guiding influence over something or someone").
word("dominate", 'v.', "To enjoy a commanding position in some field").
word("domination", 'n.', "The exercise of power in ruling; sovereignty; authority; government.").
word("domination", 'n.', "A fetish characterized by control/power over and discipline of one's sexual partner.").
word("domineer", 'v.', "To rule over or control arbitrarily or arrogantly; to tyrannize.").
word("donate", 'v.', "To make a donation; to give away something of value to support or contribute towards a cause or for the benefit of another.").
word("donator", 'n.', "(Rare) Donor, one who donates.").
word("donee", 'n.', "Someone who receives a gift from a donor.").
word("donor", 'n.', "One who makes a donation.").
word("donor", 'n.', "A group or molecule that donates either a radical, electrons or a moiety in a chemical reaction. Compare acceptor.").
word("dormant", 'adj.', "Inactive, sleeping, asleep, suspended.").
word("dormant", 'adj.', "In a sleeping posture; distinguished from .").
word("doublet", 'n.', "One of two or more different words in a language derived from the same etymological root but having different phonological forms (e.g., and in French or and in English).").
word("doublet", 'n.', "A pair of two similar or equal things; couple.").
word("doubly", 'adv.', "In two ways").
word("doubly", 'adv.', "With duplicity").
word("dowry", 'n.', "Payment, such as property or money, paid by the bride's family to the groom or his family at the time of marriage. Gary Ferraro & Susan Andreatta, Cultural Anthropology, 8th edn. (Belmont, Cal: Wadsworth, 2010), 223.").
word("dowry", 'n.', "Payment by the groom or his family to the bride's family: bride price.").
word("drachma", 'n.', "An Ancient Greek weight of about 66.5 grains, or 4.3 grams.").
word("drachma", 'n.', "The currency of Greece in ancient times and again from 1832 until 2001, with the symbol ₯, since replaced by the euro.").
word("dragnet", 'n.', "A net dragged across the bottom of a body of water.").
word("dragnet", 'n.', "Heightened efforts by law-enforcement personnel to capture suspects.").
word("dragoon", 'n.', "A horse soldier; a cavalryman, who uses a horse for mobility, but fights dismounted.").
word("dragoon", 'n.', "A variety of pigeon.").
word("drainage", 'n.', "A natural or artificial removal of fluid from a given area by its draining away.").
word("drainage", 'n.', "A system of drains.").
word("dramatize", 'v.', "To adapt a literary work so that it can be performed in the theatre, or on radio or television").
word("dramatize", 'v.', "To present something in a dramatic or melodramatic manner").
word("drastic", 'adj.', "Acting rapidly or violently.").
word("drastic", 'adj.', "Having a strong or far-reaching effect; extreme, severe.").
word("drought", 'n.', "A period of unusually low rainfall, longer and more severe than a dry spell.").
word("drought", 'n.', "A longer than expected term without success, particularly in sport.").
word("drowsy", 'adj.', "Causing someone to fall sleep or feel sleepy; lulling; soporific.").
word("drowsy", 'adj.', "Inclined to drowse; heavy with sleepiness").
word("drudgery", 'n.', "Exhausting, menial, and tedious work.").
word("dubious", 'adj.', "Arousing doubt; questionable; open to suspicion.").
word("dubious", 'adj.', "In disbelief; wavering, uncertain, or hesitating in opinion; inclined to doubt; undecided.").
word("duckling", 'n.', "A young duck.").
word("ductile", 'adj.', "Capable of being pulled or stretched into thin wire by mechanical force without breaking.").
word("ductile", 'adj.', "Molded easily into a new form.").
word("duet", 'n.', "A musical composition in two parts, each performed by a single voice (singer, instrument or univoce ensemble).").
word("duet", 'n.', "A pair or couple, especially one that is harmonious or elegant.").
word("dun", 'v.', "To ask or beset a debtor for payment.").
word("dun", 'v.', "To cure, as codfish, by laying them, after salting, in a pile in a dark place, covered with saltgrass or a similar substance.").
word("duplex", 'adj.', "Double, made up of two parts.").
word("duplex", 'adj.', "Having horizons with contrasting textures.").
word("duplicity", 'n.', "Intentional deceptiveness; double-dealing.").
word("durance", 'n.', "Imprisonment; forced confinement.").
word("durance", 'n.', "Endurance.").
word("duration", 'n.', "The time taken for the current situation to end, especially the current war").
word("duration", 'n.', "An amount of time or a particular time interval.").
word("duteous", 'adj.', "Obsequious; submissively obedient.").
word("duteous", 'adj.', "Dutiful").
word("dutiable", 'adj.', "On which duty must be paid when imported or sold.").
word("dutiful", 'adj.', "Pertaining to one's duty; demonstrative of one's sense of duty.").
word("dutiful", 'adj.', "Accepting of one's legal or moral obligations and willing to do them well, and without complaint.").
word("dwindle", 'v.', "To decrease, shrink, diminish, reduce in size or intensity.").
word("dwindle", 'v.', "To break up or disperse.").
word("dyne", 'n.', "A unit of force in the CGS system; the force required to accelerate a mass of one gram by one centimetre per second per second. Symbol: dyn.").
word("earnest", 'adj.', "Intent; focused; showing a lot of concentration.").
word("earnest", 'adj.', "Serious; weighty; of a serious, weighty, or important nature; important.").
word("earthenware", 'n.', "An opaque, semi-porous ceramic made from clay and other compounds.").
word("eatable", 'adj.', "Able to be eaten; edible.").
word("ebullient", 'adj.', "Boiling or agitated as if boiling.").
word("ebullient", 'adj.', "Enthusiastic; high-spirited.").
word("eccentric", 'adj.', "Having a different center; not concentric.").
word("eccentric", 'adj.', "Having different goals or motives.").
word("eccentricity", 'n.', "The ratio, constant for any particular conic section, of the distance of a point from the focus to its distance from the directrix.").
word("eccentricity", 'n.', "The quality of being eccentric or odd; any eccentric behaviour.").
word("eclipse", 'n.', "Especially, an alignment whereby a planetary object (for example, the Moon) comes between the Sun and another planetary object (for example, the Earth), resulting in a shadow being cast by the middle planetary object onto the other planetary object.").
word("eclipse", 'n.', "An alignment of astronomical objects whereby one object comes between the observer (or notional observer) and another object, thus obscuring the latter.").
word("economize", 'v.', "To use frugally.").
word("economize", 'v.', "To practice being economical (by using things sparingly or in moderation, and by avoiding waste or extravagance).").
word("ecstasy", 'n.', "A trance, frenzy, or rapture associated with mystic or prophetic exaltation.").
word("ecstasy", 'n.', "A state of emotion so intense that a person is carried beyond rational thought and self-control.").
word("ecstatic", 'adj.', "Extremely happy.").
word("ecstatic", 'adj.', "Feeling or characterized by ecstasy.").
word("edible", 'adj.', "Capable of being eaten without harm; suitable for consumption; innocuous to humans.").
word("edible", 'adj.', "Capable of being eaten without disgust.").
word("edict", 'n.', "A proclamation of law or other authoritative command.").
word("edify", 'v.', "To instruct or improve morally or intellectually.").
word("edify", 'v.', "To build, construct.").
word("editorial", 'n.', "An article in a publication giving the opinion of its editors on a given topic or current event.").
word("editorial", 'n.', "A similar commentary on radio or television.").
word("educe", 'v.', "To draw out or bring forth from some basic or potential state; to elicit, to develop.").
word("educe", 'v.', "To isolate (a substance) from a compound; to extract.").
word("efface", 'v.', "Of the cervix during pregnancy, to thin and stretch in preparation for labor.").
word("efface", 'v.', "To make oneself inobtrusive as if due to modesty or diffidence.").
word("effect", 'n.', "Reality; actual meaning; fact, as distinguished from mere appearance.").
word("effect", 'n.', "Consequence intended; purpose; meaning; general intent; with to.").
word("effective", 'adj.', "Efficient, serviceable, or operative, available for useful work.").
word("effective", 'adj.', "Having no negative coefficients.").
word("effectual", 'adj.', "Producing the intended result; entirely adequate.").
word("effeminacy", 'n.', "The quality of being effeminate.").
word("effeminate", 'adj.', "Womanly; tender, affectionate, caring.").
word("effeminate", 'adj.', "Exhibiting behaviour or mannerisms considered typical of a female; unmasculine.").
word("effervesce", 'v.', "To escape from solution in a liquid in the form of bubbles.").
word("effervesce", 'v.', "To emit small bubbles of dissolved gas; to froth or fizz.").
word("effervescent", 'adj.', "Giving off bubbles; fizzy.").
word("effervescent", 'adj.', "Vivacious and enthusiastic.").
word("effete", 'adj.', "Of substances, quantities etc: exhausted, spent, worn-out.").
word("effete", 'adj.', "Affected, overrefined").
word("efficacious", 'adj.', "Effective; possessing efficacy.").
word("efficacy", 'n.', "Ability to produce a desired effect under ideal testing conditions.").
word("efficacy", 'n.', "Degree of ability to produce a desired effect.").
word("efficiency", 'n.', "The extent to which a resource, is used for the intended purpose; the ratio of useful work to energy expended.").
word("efficiency", 'n.', "The quality of producing an effect or effects.").
word("efficient", 'adj.', "Making good, thorough, or careful use of resources; not consuming extra. Especially, making good use of time or energy").
word("efficient", 'adj.', "Expressing the proportion of consumed energy that was successfully used in a process; the ratio of useful output to total input").
word("efflorescence", 'n.', "The production of flowers.").
word("efflorescence", 'n.', "The formation of a powdery surface on crystals, as a hydrate is converted to anhydrous form by losing loosely bound water of crystallization to the atmosphere.").
word("efflorescent", 'adj.', "Bursting into flower.").
word("efflorescent", 'adj.', "Growing at a rapid rate; flourishing.").
word("effluvium", 'n.', "A gaseous or vaporous emission, especially a foul-smelling one.").
word("effluvium", 'n.', "A condition causing the shedding of hair.").
word("effrontery", 'n.', "An act of insolent and shameless audacity.").
word("effrontery", 'n.', "Insolent and shameless audacity.").
word("effulgence", 'n.', "A state of being bright and radiant, splendor, brilliance.").
word("effuse", 'v.', "To pour out like a stream or freely; to cause to exude; to shed.").
word("effuse", 'v.', "To gush; to be excitedly talkative and enthusiastic about something.").
word("effusion", 'n.', "An outpouring of speech or emotion.").
word("effusion", 'n.', "A liquid outpouring.").
word("egoism", 'n.', "The belief that moral behavior should be directed toward one's self-interest only.").
word("egoism", 'n.', "The tendency to think selfishly with exclusive self-interest in mind.").
word("egoist", 'n.', "An egotist .").
word("egoist", 'n.', "An advocate of egoism.").
word("egotism", 'n.', "Egoism .").
word("egotism", 'n.', "A belief that one is superior to or more important than others.").
word("egotist", 'n.', "A person who believes in his or her own importance or superiority.").
word("egotist", 'n.', "An egoist .").
word("egregious", 'adj.', "Conspicuous, exceptional, outstanding; usually in a negative sense.").
word("egregious", 'adj.', "Outrageously bad; shocking.").
word("egress", 'n.', "An exit or way out.").
word("egress", 'n.', "The process of exiting or leaving.").
word("eject", 'v.', "To compel (a sports player) to leave the field because of inappropriate behaviour.").
word("eject", 'v.', "To come out of a machine.").
word("elapse", 'v.', "To pass or move by.").
word("elasticity", 'n.', "The property by virtue of which a material deformed under load can regain its original dimensions when unloaded").
word("elasticity", 'n.', "The ratio of the relative change in a function's output with respect to the relative change in its input, for infinitesimal changes at a certain point.").
word("electrolysis", 'n.', "The chemical change produced by passing an electric current through a conducting solution or a molten salt.").
word("electrolysis", 'n.', "The destruction of hair roots by means of an electric current.").
word("electrotype", 'n.', "A plate, made by electroplating a mold, such as used in letterpress printing").
word("elegy", 'n.', "A mournful or plaintive poem; a funeral song; a poem of lamentation.").
word("elegy", 'n.', "A composition of mournful character.").
word("element", 'n.', "One of the simplest or essential parts or principles of which anything consists, or upon which the constitution or fundamental powers of anything are based.").
word("element", 'n.', "A component in electrical equipment, often in the form of a coil, having a high resistance, thereby generating heat when a current is passed through it.").
word("elicit", 'v.', "To evoke, educe (emotions, feelings, responses, etc.); to generate, obtain, or provoke as a response or answer.").
word("elicit", 'v.', "To draw out, bring out, bring forth (something latent); to obtain information from someone or something.").
word("eligible", 'adj.', "Allowed to and meeting the necessary conditions required to participate in or be chosen for something").
word("eligible", 'adj.', "Worthy of being chosen (for marriage)").
word("eliminate", 'v.', "To kill (a person or animal).").
word("eliminate", 'v.', "To excrete (waste products).").
word("elocution", 'n.', "The art of public speaking with expert control of gesture and voice, etc.").
word("eloquent", 'adj.', "Effective in expressing meaning by speech").
word("eloquent", 'adj.', "Fluently persuasive and articulate").
word("elucidate", 'v.', "To make clear; to clarify; to shed light upon.").
word("elude", 'v.', "To evade or escape from (someone or something), especially by using cunning or skill.").
word("elude", 'v.', "To shake off (a pursuer); to give someone the slip.").
word("elusion", 'n.', "The act of eluding.").
word("emaciate", 'v.', "To become extremely thin or wasted.").
word("emaciate", 'v.', "To make extremely thin or wasted.").
word("emanate", 'v.', "To come from a source; issue from.").
word("emanate", 'v.', "To send or give out; manifest.").
word("emancipate", 'v.', "To set free from the power of another; to liberate; as:").
word("emancipate", 'v.', "To free from any controlling influence, especially from anything which exerts undue or evil influence").
word("embargo", 'n.', "A ban on trade with another country.").
word("embargo", 'n.', "A heavy burden or severe constraint on action or expenditure.").
word("embark", 'v.', "To engage, enlist, or invest (as persons, money, etc.) in any affair.").
word("embark", 'v.', "To get on a boat or ship or (outside the USA) an aeroplane.").
word("embarrass", 'v.', "To perplex mentally; confuse, disconcert; catch off guard.").
word("embarrass", 'v.', "To involve in difficulties concerning money matters; to encumber with debt; to beset with urgent claims or demands.").
word("embellish", 'v.', "To make more beautiful and attractive by adding ornamentation; to decorate.").
word("embellish", 'v.', "To make something sound or look better or more acceptable than it is in reality; to distort, to embroider.").
word("embezzle", 'v.', "To steal or misappropriate money that one has been trusted with, especially to steal money from the organisation for which one works.").
word("emblazon", 'v.', "To draw (a coat of arms).").
word("emblazon", 'v.', "To celebrate or extol as with deeds or merit.").
word("emblem", 'n.', "A representative symbol, such as a trademark or logo.").
word("emblem", 'n.', "A picture accompanied with a motto, a set of verses, etc. intended as a moral lesson or meditation.").
word("embody", 'v.', "To represent in a physical or concrete form; to incarnate or personify.").
word("embody", 'v.', "To comprise or include as part of a cohesive whole; to be made up of.").
word("embolden", 'v.', "To render (someone) bolder or more courageous.").
word("embolden", 'v.', "To format text in boldface.").
word("embolism", 'n.', "An obstruction or occlusion of an artery by an embolus, that is by a blood clot, air bubble or other matter that has been transported by the blood stream.").
word("embolism", 'n.', "The insertion or intercalation of days into the calendar in order to correct the error arising from the difference between the civil year and the solar year.").
word("embroil", 'v.', "To draw into a situation; to cause to be involved.").
word("embroil", 'v.', "To implicate in confusion; to complicate; to jumble.").
word("emerge", 'v.', "To come out of a situation, object or a liquid.").
word("emerge", 'v.', "To come into view.").
word("emergence", 'n.', "The act of rising out of a fluid, or coming forth from envelopment or concealment, or of rising into view; sudden uprising or appearance.").
word("emergence", 'n.', "In particular: the arising of emergent structure in complex systems.").
word("emergent", 'adj.', "Having properties as a whole that are more complex than the properties contributed by each of the components individually.").
word("emergent", 'adj.', "Having gameplay that arises from its mechanics, rather than a linear storyline.").
word("emeritus", 'adj.', "Retired, but retaining an honorific version of a previous title.").
word("emigrant", 'n.', "Someone who leaves a country to settle in a new country.").
word("emigrant", 'n.', "Any of various pierid butterflies of the genus . Also called a migrant.").
word("emigrate", 'v.', "To leave the country in which one lives, especially one's native country, in order to reside elsewhere.").
word("eminence", 'n.', "An elevated land area or a hill.").
word("eminence", 'n.', "Someone of high rank, reputation or social status.").
word("eminent", 'adj.', "Distinguished, important, noteworthy.").
word("eminent", 'adj.', "High, lofty.").
word("emit", 'v.', "To send out or give off").
word("emphasis", 'n.', "Special attention or prominence given to something.").
word("emphasis", 'n.', "Special weight or forcefulness given to something considered important.").
word("emphasize", 'v.', "To stress, give emphasis or extra weight to (something).").
word("emphatic", 'adj.', "Belonging to a set of English tense forms comprising the auxiliary verb do + an infinitive without to.").
word("emphatic", 'adj.', "Belonging to a series of obstruent consonants in several Afro-Asiatic languages that are distinguished by a guttural (co-)articulation.").
word("employee", 'n.', "An individual who provides labor to a company or another person.").
word("employer", 'n.', "A person, firm or other entity which pays for or hires the services of another person.").
word("emporium", 'n.', "A shop that offers a wide variety of goods for sale; a department store; a shop specializing in particular goods.").
word("emporium", 'n.', "A city or region which is a major trading centre; also, a place within a city for commerce and trading; a marketplace.").
word("empower", 'v.', "To give permission, power, or the legal right to do something.").
word("empower", 'v.', "To give someone more confidence and/or strength to do something, often by enabling them to increase their control over their own life or situation.").
word("emulate", 'v.', "To copy or imitate, especially a person.").
word("emulate", 'v.', "Of a program or device: to imitate another program or device").
word("enact", 'v.', "To make (a bill) into law").
word("enact", 'v.', "To act the part of; to play").
word("enamor", 'v.', "To cause to be in love.").
word("enamor", 'v.', "To captivate.").
word("encamp", 'v.', "To form into a camp.").
word("encamp", 'v.', "To establish a camp or temporary shelter.").
word("encomium", 'n.', "Warm praise, especially a formal expression of such praise; a tribute.").
word("encomium", 'n.', "A genre of literature that included five elements: prologue, birth and upbringing, acts of the person's life, comparisons used to praise the subject, and an epilogue.").
word("encompass", 'v.', "To form a circle around; to encircle.").
word("encompass", 'v.', "To include completely; to describe fully or comprehensively.").
word("encore", 'n.', "A call or demand (as by continued applause) for a repeat performance.").
word("encore", 'n.', "A brief extra performance, done after the main performance is complete.").
word("encourage", 'v.', "To mentally support; to motivate, give courage, hope or spirit.").
word("encourage", 'v.', "To foster, give help or patronage").
word("encroach", 'v.', "To seize, appropriate").
word("encroach", 'v.', "To intrude unrightfully on someone else’s rights or territory").
word("encumber", 'v.', "To restrict or block something with a hindrance or impediment").
word("encumber", 'v.', "To load down something with a burden").
word("encyclical", 'adj.', "Intended for general circulation.").
word("encyclopedia", 'n.', "A comprehensive reference work (often spanning several printed volumes) with articles (usually arranged in alphabetical order, or sometimes arranged by category) on a range of subjects, sometimes general, sometimes limited to a particular field.").
word("encyclopedia", 'n.', "The circle of arts and sciences; a comprehensive summary of knowledge, or of a branch of knowledge.").
word("endanger", 'v.', "To incur the hazard of; to risk; to run the risk of.").
word("endanger", 'v.', "To put (someone or something) in danger; to risk causing harm to.").
word("endear", 'v.', "To make (someone) dear or precious.").
word("endear", 'v.', "To stress (something) as important; to exaggerate.").
word("endemic", 'adj.', "Peculiar to a particular area or region; not found in other places.").
word("endemic", 'adj.', "Native to a particular area or culture; originating where it occurs.").
word("endue", 'v.', "To put on (a piece of clothing); to clothe (someone something).").
word("endue", 'v.', "To invest (someone) a given quality, property etc.; to endow.").
word("endurable", 'adj.', "Able to be endured; tolerable; bearable.").
word("endurable", 'adj.', "Capable of enduring; likely to endure; durable.").
word("endurance", 'n.', "The length of time that a ship's rations will supply").
word("endurance", 'n.', "The measure of a person's stamina or persistence.").
word("energetic", 'adj.', "Having powerful effects; efficacious, potent.").
word("energetic", 'adj.', "Characterised by force or vigour; full of energy; lively, vigorous.").
word("enervate", 'v.', "To partially or completely remove a nerve.").
word("enervate", 'v.', "To weaken morally or mentally.").
word("enfeeble", 'v.', "To make feeble.").
word("enfranchise", 'v.', "To grant the franchise to an entity, specifically:").
word("engender", 'v.', "To assume form; to come into existence; to be caused or produced.").
word("engender", 'v.', "To give existence to, to produce (living creatures).").
word("engrave", 'v.', "To carve text or symbols into (something), usually for the purposes of identification or art.").
word("engrave", 'v.', "To put in a grave, to bury.").
word("engross", 'v.', "To completely engage the attention of.").
word("engross", 'v.', "To amass.").
word("enhance", 'v.', "To augment or make something greater.").
word("enhance", 'v.', "To improve something by adding features.").
word("enigma", 'n.', "A riddle, or a difficult problem.").
word("enigma", 'n.', "Something or someone puzzling, mysterious or inexplicable.").
word("enjoin", 'v.', "To lay upon, as an order or command; to give an injunction to; to direct with authority; to order; to charge.").
word("enjoin", 'v.', "To prohibit or restrain by a judicial order or decree; to put an injunction on.").
word("enkindle", 'v.', "To kindle; to arouse or evoke.").
word("enlighten", 'v.', "To make something clear to (someone); to give knowledge or understanding to.").
word("enlighten", 'v.', "To supply with light.").
word("enlist", 'v.', "To voluntarily join a cause or organization, especially military service.").
word("enlist", 'v.', "To enter on a list; to enroll; to register.").
word("enmity", 'n.', "A state or feeling of opposition, hostility, hatred or animosity.").
word("enmity", 'n.', "The quality of being an enemy; hostile or unfriendly disposition.").
word("ennoble", 'v.', "To bestow with nobility, honour or grace.").
word("ennoble", 'v.', "To perform on a fabric the industrial processes of dry-cleaning, printing and embossing, and sizing and finishing.").
word("enormity", 'n.', "A breach of law or morality; a transgression, an act of evil or wickedness.").
word("enormity", 'n.', "Deviation from what is normal or standard; irregularity, abnormality.").
word("enormous", 'adj.', "Extremely large; greatly exceeding the common size, extent, etc.").
word("enormous", 'adj.', "Deviating from the norm; unusual, extraordinary.").
word("enrage", 'v.', "To become angry or wild.").
word("enrage", 'v.', "To provoke to madness, to make insane.").
word("enrapture", 'v.', "To fill with great delight or joy; to fascinate or captivate.").
word("enshrine", 'v.', "To enclose (a sacred relic etc.) in a shrine or chest.").
word("enshrine", 'v.', "To protect an idea, ideal, or philosophy within an official law or treaty").
word("ensnare", 'v.', "To entangle; to enmesh.").
word("ensnare", 'v.', "To entrap; to catch in a snare or trap.").
word("entail", 'v.', "To appoint hereditary possessor.").
word("entail", 'v.', "To cut or carve in an ornamental way.").
word("entangle", 'v.', "To involve in such complications as to render extrication difficult").
word("entangle", 'v.', "To involve in difficulties or embarrassments; to embarrass, puzzle, or distract by adverse or perplexing circumstances, interests, demands, etc.; to hamper; to bewilder.").
word("enthrall", 'v.', "To hold spellbound.").
word("enthrall", 'v.', "To make subservient.").
word("enthrone", 'v.', "To help a candidate to the succession of a monarchy (as a kingmaker does), or by extension in any other major organisation.").
word("enthrone", 'v.', "To put on the throne in a formal installation ceremony called enthronement, equivalent to (and often combined with) coronation and/or other ceremonies of investiture").
word("enthuse", 'v.', "To cause (someone) to feel enthusiasm or to be enthusiastic").
word("enthuse", 'v.', "To show enthusiasm").
word("enthusiastic", 'adj.', "With zealous fervor; excited, motivated.").
word("entirety", 'n.', "The whole; the complete or amount.").
word("entomology", 'n.', "The scientific study of insects, and of other arthropods (and occasionally other invertebrates).").
word("entrails", 'n.', "The internal organs of an animal, especially the intestines.").
word("entrails", 'n.', "The seat of the emotions.").
word("entreaty", 'n.', "A treatment; reception; entertainment.").
word("entreaty", 'n.', "The act of entreating or beseeching; a strong petition; pressing solicitation; begging.").
word("entrench", 'v.', "To become completely absorbed in and fully accept one's beliefs, even in the face of evidence against it and refusing to be reasoned with.").
word("entrench", 'v.', "To invade; to encroach; to infringe or trespass; to enter on, and take possession of, that which belongs to another; usually followed by on or upon.").
word("entwine", 'v.', "To twist or twine around something (or one another).").
word("enumerate", 'v.', "To determine the amount of.").
word("enumerate", 'v.', "To specify each member of a sequence individually in incrementing order.").
word("epic", 'n.', "In software development, a large or extended user story.").
word("epic", 'n.', "An extended narrative poem in elevated or dignified language, celebrating the feats of a deity, demigod (heroic epic), other legend or traditional hero.").
word("epicure", 'n.', "A person who takes particular pleasure in fine food and drink.").
word("epicurean", 'adj.', "Pursuing pleasure, especially in reference to food or comfort.").
word("epicurean", 'adj.', "Devoted to luxurious living.").
word("epicycle", 'n.', "A small circle whose centre is on the circumference of a larger circle; in Ptolemaic astronomy it was seen as the basis of revolution of the \"seven planets\", given a fixed central Earth.").
word("epicycle", 'n.', "Any circle whose circumference rolls around that of another circle, thus creating a hypocycloid or epicycloid. Category:en:Curves").
word("epicycloid", 'n.', "The locus of a point on the circumference of a circle that rolls without slipping on the circumference of another circle. Category:en:Curves").
word("epidemic", 'n.', "A widespread disease that affects many individuals in a population.").
word("epidemic", 'n.', "The spreading of an idea or belief amongst a population.").
word("epidermis", 'n.', "The outer, protective layer of the skin of vertebrates, covering the dermis").
word("epidermis", 'n.', "The similar outer layer of cells in invertebrates and plants").
word("epigram", 'n.', "An inscription in stone.").
word("epigram", 'n.', "A short, witty or pithy poem.").
word("epilogue", 'n.', "A brief oration or script at the end of a literary piece; an afterword").
word("epilogue", 'n.', "A short speech, spoken directly at the audience at the end of a play").
word("epiphany", 'n.', "A manifestation or appearance of a divine or superhuman being.").
word("epiphany", 'n.', "An illuminating realization or discovery, often resulting in a personal feeling of elation, awe, or wonder.").
word("episode", 'n.', "An incident, action, or time period standing out by itself, but more or less connected with a complete series of events.").
word("episode", 'n.', "An instalment of a drama told in parts, as in a TV series.").
word("epitaph", 'n.', "An inscription on a gravestone in memory of the deceased.").
word("epitaph", 'n.', "A poem or other short text written in memory of a deceased person.").
word("epithet", 'n.', "One of many formulaic words or phrases used in the Iliad and Odyssey to characterize a person, a group of people, or a thing.").
word("epithet", 'n.', "A word in the scientific name of a taxon following the name of the genus or species. This applies only to formal names of plants, fungi and bacteria. In formal names of animals the corresponding term is the specific name.").
word("epitome", 'n.', "A representative example.").
word("epitome", 'n.', "A brief summary of a text.").
word("epizootic", 'adj.', "Containing fossils.").
word("epizootic", 'adj.', "Relating to epizoa; epizoic.").
word("epoch", 'n.', "A precise instant of time that is used as a point of reference.").
word("epoch", 'n.', "A precise instant of time that is used as a point of reference (e.g., January 1, 1970, 00:00:00 UTC).").
word("epode", 'n.', "A kind of lyric poem, invented by , in which a longer verse is followed by a shorter one.").
word("epode", 'n.', "The after song; the part of a lyric ode which follows the strophe and antistrophe.").
word("equalize", 'v.', "Said of a morphism: to pre-compose with each of a parallel pair of morphisms so as to yield the same composite morphism.").
word("equalize", 'v.', "To adjust the balance between frequency components within an electronic signal.").
word("equanimity", 'n.', "The state of being calm, stable and composed, especially under stress.").
word("equestrian", 'adj.', "Of horseback riding or horseback riders.").
word("equestrian", 'adj.', "Of or relating to the ancient Roman class of equites.").
word("equilibrium", 'n.', "The condition of a system in which competing influences are balanced, resulting in no net change.").
word("equilibrium", 'n.', "The state of a reaction in which the rates of the forward and reverse reactions are the same.").
word("equitable", 'adj.', "Relating to the general principles of justice that correct or supplement the provisions of the law.").
word("equitable", 'adj.', "Fair, just, or impartial.").
word("equity", 'n.', "Fairness, impartiality, or justice as determined in light of \"natural law\" or \"natural right\".").
word("equivalent", 'adj.', "Similar or identical in value, meaning or effect; virtually equal.").
word("equivalent", 'adj.', "Equal in measure but not admitting of superposition; applied to magnitudes.").
word("equivocal", 'adj.', "Capable of being ascribed to different motives, or of signifying opposite feelings, purposes, or characters; deserving to be suspected.").
word("equivocal", 'adj.', "Having two or more equally applicable meanings; capable of double or multiple interpretation.").
word("equivocate", 'v.', "To speak using double meaning; to speak ambiguously, unclearly or doubtfully, with intent to deceive").
word("equivocate", 'v.', "To render equivocal or ambiguous.").
word("eradicate", 'v.', "To destroy completely; to reduce to nothing radically; to put an end to; to extirpate.").
word("eradicate", 'v.', "To pull up by the roots; to uproot.").
word("errant", 'adj.', "Wandering; roving around.").
word("errant", 'adj.', "Straying from the proper course or standard, or outside established limits.").
word("erratic", 'adj.', "Deviating from normal opinions or actions; eccentric; odd.").
word("erratic", 'adj.', "Unsteady, random; prone to unexpected changes; not consistent.").
word("erroneous", 'adj.', "Containing an error; inaccurate.").
word("erroneous", 'adj.', "Derived from an error.").
word("erudite", 'adj.', "Learned, scholarly, with emphasis on knowledge gained from books.").
word("erudition", 'n.', "The refinement, polish and knowledge that education confers.").
word("erudition", 'n.', "Profound knowledge acquired from learning and scholarship.").
word("eschew", 'v.', "To avoid; to shun, to shy away from.").
word("espy", 'v.', "To examine and keep watch upon; to watch; to observe.").
word("espy", 'v.', "To look or search narrowly; to look about; to watch; to take notice; to spy.").
word("esquire", 'n.', "A gentleman who attends or escorts a lady in public.").
word("esquire", 'n.', "A squire; a youth who in the hopes of becoming a knight attended upon a knight").
word("essence", 'n.', "The true nature of anything, not accidental or illusory.").
word("essence", 'n.', "The inherent nature of a thing or idea.").
word("estimable", 'adj.', "Worthy of esteem; admirable.").
word("estimable", 'adj.', "Valuable.").
word("estrange", 'v.', "To remove from an accustomed place or set of associations.").
word("estrange", 'v.', "To cause to feel less close or friendly; alienate. To cease contact with (particularly of a family member or spouse, especially in form ).").
word("estuary", 'n.', "A coastal water body where ocean tides and river water merge, resulting in a brackish water zone.").
word("estuary", 'n.', "An ocean inlet also fed by fresh river water.").
word("eugenic", 'adj.', "Relating or adapting to production of good offspring.").
word("eugenic", 'adj.', "Of or relating to eugenics.").
word("eulogize", 'v.', "To praise, celebrate or pay homage to (someone), especially in an eloquent formal eulogy.").
word("eulogy", 'n.', "An oration to honor a deceased person, usually at a funeral.").
word("eulogy", 'n.', "Speaking highly of someone or something; the act of praising or commending someone or something.").
word("euphemism", 'n.', "The use of a word or phrase to replace another with one that is considered less offensive, blunt or vulgar than the word or phrase which it replaces.").
word("euphemism", 'n.', "A word or phrase that is used to replace another in this way.").
word("euphonious", 'adj.', "Of sounds, especially speech: demonstrating or possessing euphony; agreeable to the ear; pleasant-sounding.").
word("euphony", 'n.', "A pronunciation of letters and syllables which is pleasing to the ear.").
word("euphony", 'n.', "Pleasant phonetic quality of certain words.").
word("evade", 'v.', "To get away from by cunning; to avoid using dexterity, subterfuge, address, or ingenuity; to cleverly escape from").
word("evade", 'v.', "To attempt to escape; to practice artifice or sophistry, for the purpose of eluding.").
word("evanesce", 'v.', "To transition from the solid state to gaseous state without ever becoming a liquid").
word("evanesce", 'v.', "To disappear into a mist or dissipate in vapor").
word("evanescent", 'adj.', "Ephemeral, fleeting, momentary.").
word("evanescent", 'adj.', "Barely there; almost imperceptible.").
word("evangelical", 'adj.', "Pertaining to the gospel(s) of the Christian New Testament.").
word("evangelical", 'adj.', "Pertaining to the doctrines or teachings of the Christian gospel or Christianity in general.").
word("evangelist", 'n.', "An itinerant or special preacher, especially a revivalist, who conducts services in different cities or locations, now often televised.").
word("evangelist", 'n.', "A person who first brought the gospel to a city or region.").
word("evasion", 'n.', "The act of eluding or evading or avoiding, particularly the pressure of an argument, accusation, charge, or interrogation; artful means of eluding.").
word("eventual", 'adj.', "Finally resulting or occurring (after a period of time); inevitable.").
word("eventual", 'adj.', "Possible, potential.").
word("evert", 'v.', "To turn inside out (like a pocket being emptied) or outwards.").
word("evert", 'v.', "To move (someone or something) out of the way.").
word("evict", 'v.', "To expel (one or more people) from their property; to force (one or more people) to move out.").
word("evidential", 'adj.', "Of or providing evidence.").
word("evince", 'v.', "To show or demonstrate clearly; to manifest.").
word("evoke", 'v.', "To call out; to draw out or bring forth.").
word("evoke", 'v.', "To cause the manifestation of something (emotion, picture, etc.) in someone's mind or imagination.").
word("evolution", 'n.', "Process of development.").
word("evolution", 'n.', "A change of position.").
word("evolve", 'v.', "To give off (gas, such as oxygen or carbon dioxide during a reaction).").
word("evolve", 'v.', "To cause something to change or transform.").
word("exacerbate", 'v.', "To make worse (a problem, bad situation, negative feeling, etc.); aggravate; exasperate.").
word("exaggerate", 'v.', "To overstate, to describe more than is fact.").
word("exasperate", 'v.', "To tax the patience of; irk, frustrate, vex, provoke, annoy; to make angry.").
word("excavate", 'v.', "To remove part of (something) by scooping or digging it out.").
word("excavate", 'v.', "To uncover (something) by digging.").
word("exceed", 'v.', "To go beyond (some limit); to surpass; to be longer than.").
word("exceed", 'v.', "To predominate.").
word("excel", 'v.', "To be much better than others.").
word("excel", 'v.', "To surpass someone or something; to be better or do better than someone or something.").
word("excellence", 'n.', "An excellent or valuable quality; something at which any someone excels; a virtue.").
word("excellence", 'n.', "The quality of being excellent; brilliance").
word("excellency", 'n.', "The quality of being excellent.").
word("excellent", 'adj.', "Exceptionally good of its kind.").
word("excellent", 'adj.', "Of higher or the highest quality; splendid.").
word("excerpt", 'n.', "A clip, snippet, passage or extract from a larger work such as a news article, a film, or a literary composition.").
word("excess", 'n.', "The state of surpassing or going beyond a limit; the state of being beyond sufficiency, necessity, or duty; more than what is usual or proper.").
word("excess", 'n.', "A condition on an insurance policy by which the insured pays for a part of the claim.").
word("excitable", 'adj.', "Easily excited").
word("excitable", 'adj.', "Able to be promoted to an excited state").
word("excitation", 'n.', "The activity produced in an organ, tissue, or part, such as a nerve cell, as a result of stimulation").
word("excitation", 'n.', "The act of exciting or putting in motion; the act of rousing up or awakening.").
word("exclamation", 'n.', "A word expressing outcry; an interjection").
word("exclamation", 'n.', "A loud calling or crying out, for example as in surprise, pain, grief, joy, anger, etc.").
word("exclude", 'v.', "To bar (someone or something) from entering; to keep out.").
word("exclude", 'v.', "To expel; to put out.").
word("exclusion", 'n.', "An item not covered by an insurance policy.").
word("exclusion", 'n.', "The act of pushing or forcing something out.").
word("excrescence", 'n.', "A disfiguring or unwanted mark or adjunct.").
word("excrescence", 'n.', "Something, usually abnormal, which grows out of something else.").
word("excretion", 'n.', "The process of removing or ejecting material that has no further utility, especially from the body; the act of excreting.").
word("excretion", 'n.', "Something excreted in that manner, especially urine or feces.").
word("excruciate", 'v.', "To inflict intense pain or mental distress on (someone); to torture.").
word("excursion", 'n.', "A brief recreational trip; a journey out of the usual way.").
word("excursion", 'n.', "An occurrence where an aircraft runs off the end or side of a runway or taxiway, usally during takeoff, landing, or taxi.").
word("excusable", 'adj.', "Possible to excuse").
word("execrable", 'adj.', "Of the poorest quality.").
word("execrable", 'adj.', "Hateful.").
word("execration", 'n.', "An act or instance of cursing; a curse dictated by violent feelings of hatred; an imprecation; an expression of utter detestation.").
word("execration", 'n.', "That which is execrated; a detested thing.").
word("executor", 'n.', "Someone appointed by a testator to administer a will; an administrator.").
word("executor", 'n.', "A person who carries out some task.").
word("exegesis", 'n.', "A critical explanation or interpretation of a text, especially a religious text.").
word("exemplar", 'n.', "A handwritten manuscript used by a scribe to make a handwritten copy; the original copy of what gets multiply reproduced in a copy machine.").
word("exemplar", 'n.', "A pattern after which others should be made; an archetype.").
word("exemplary", 'adj.', "Of such high quality that it should serve as an example to be imitated; ideal, perfect.").
word("exemplary", 'adj.', "Providing an example or illustration.").
word("exemplify", 'v.', "To show or illustrate by example.").
word("exemplify", 'v.', "To be an instance of or serve as an example.").
word("exempt", 'adj.', "Free from a duty or obligation.").
word("exempt", 'adj.', "Cut off; set apart.").
word("exert", 'v.', "To make use of, to apply, especially of something non-material.").
word("exert", 'v.', "To put in vigorous action.").
word("exhale", 'v.', "To expel air from the lungs through the nose or mouth by action of the diaphragm, to breathe out.").
word("exhale", 'v.', "To pass off in the form of vapour; to emerge.").
word("exhaust", 'v.', "To empty by drawing or letting out the contents").
word("exhaust", 'v.', "To use up; to deplete, drain or expend wholly, or until the supply comes to an end").
word("exhaustible", 'adj.', "Capable of being exhausted.").
word("exhaustion", 'n.', "The removal (by percolation etc) of an active medicinal constituent from plant material.").
word("exhaustion", 'n.', "The point of complete depletion, of the state of being used up.").
word("exhaustive", 'adj.', "Fully comprehensive").
word("exhaustive", 'adj.', "Including every possible element").
word("exhilarate", 'v.', "To cheer, to cheer up, to gladden, to make happy.").
word("exhilarate", 'v.', "To excite, to thrill.").
word("exhume", 'v.', "To dig out of the ground; to take out of a place of burial; to disinter.").
word("exhume", 'v.', "To uncover; to bring to light.").
word("exigency", 'n.', "An urgent situation, one requiring extreme effort or attention.").
word("exigency", 'n.', "The demands or requirements of a situation.").
word("exigent", 'adj.', "Urgent; pressing; needing immediate action.").
word("exigent", 'adj.', "Demanding; requiring great effort.").
word("existence", 'n.', "The state of being, existing, or occurring; beinghood.").
word("existence", 'n.', "Empirical reality; the substance of the physical universe. (Dictionary of Philosophy; 1968)").
word("exit", 'n.', "A way out.").
word("exit", 'n.', "An act of going out or going away, or leaving; a departure.").
word("exodus", 'n.', "A sudden departure of a large number of people.").
word("exonerate", 'v.', "To free (someone) from accusation or blame.").
word("exonerate", 'v.', "To free (someone) from an obligation, responsibility or task.").
word("exorbitance", 'n.', "A large excess.").
word("exorbitance", 'n.', "The state or characteristic of being exorbitant.").
word("exorbitant", 'adj.', "Exceeding proper limits; excessive or unduly high; extravagant.").
word("exorcise", 'v.', "To drive out (an evil spirit) from a person, place or thing, especially by an incantation or prayer.").
word("exorcise", 'v.', "To rid (a person, place or thing) of an evil spirit.").
word("exotic", 'adj.', "Foreign, especially in an exciting way.").
word("exotic", 'adj.', "Non-native to the ecosystem.").
word("expand", 'v.', "To increase the extent, number, volume or scope of (something).").
word("expand", 'v.', "To increase in extent, number, volume or scope.").
word("expanse", 'n.', "An amount of spread or stretch.").
word("expanse", 'n.', "A wide stretch, usually of sea, sky, or land.").
word("expansion", 'n.', "An act, process, or instance of expanding.").
word("expatriate", 'v.', "To banish; to drive or force (a person) from his own country; to make an exile of.").
word("expatriate", 'v.', "To withdraw from one’s native country.").
word("expect", 'v.', "To predict or believe that something will happen").
word("expect", 'v.', "To be pregnant, to consider a baby due.").
word("expectancy", 'n.', "Expectation or anticipation; the state of expecting something.").
word("expectancy", 'n.', "The state of being expected.").
word("expectorate", 'v.', "To cough up fluid from the lungs.").
word("expectorate", 'v.', "To spit.").
word("expediency", 'n.', "Pursuit of the course of action that brings the desired effect even if it is unjust or unprincipled.").
word("expediency", 'n.', "The quality of being fit or suitable to effect some desired end or the purpose intended; suitability for particular circumstance or situation.").
word("expedient", 'adj.', "Affording short-term benefit, often at the expense of the long-term.").
word("expedient", 'adj.', "Governed by self-interest, often short-term self-interest.").
word("expedite", 'v.', "To accelerate the progress of.").
word("expedite", 'v.', "To perform (a task) fast and efficiently.").
word("expeditious", 'adj.', "Fast, prompt, speedy.").
word("expeditious", 'adj.', "Completed or done with efficiency and speed; facilitating speed.").
word("expend", 'v.', "To spend, disburse").
word("expend", 'v.', "To consume, exhaust").
word("expense", 'n.', "The elimination or consumption of something, sometimes with the notion of loss or damage to the thing eliminated.").
word("expense", 'n.', "A spending or consuming, often a disbursement of funds.").
word("expiate", 'v.', "To make amends or pay the penalty for.").
word("expiate", 'v.', "To atone or make reparation for.").
word("explicate", 'v.', "To explain meticulously or in great detail.").
word("explicit", 'adj.', "Very specific, clear, or detailed.").
word("explicit", 'adj.', "Containing material (e.g. language or film footage) that might be deemed offensive or graphic.").
word("explode", 'v.', "To blast, to blow up, to burst, to detonate, to go off.").
word("explode", 'v.', "To break (a delimited string of text) into several smaller strings by removing the separators.").
word("explosion", 'n.', "A sudden outburst.").
word("explosion", 'n.', "A violent release of energy (sometimes mechanical, nuclear, or chemical.)").
word("explosive", 'adj.', "Easily driven to anger, usually with reference to a person.").
word("explosive", 'adj.', "Shocking; startling.").
word("exposition", 'n.', "The opening section of a movement in sonata form; the opening section of a fugue.").
word("exposition", 'n.', "An event at which goods, artwork and cultural displays are exhibited for the public to view.").
word("expository", 'adj.', "Serving to explain, explicate, or elucidate; expositive; of or relating to exposition.").
word("expostulate", 'v.', "To protest or remonstrate; to reason earnestly with a person on some impropriety of conduct.").
word("exposure", 'n.', "The amount of sun, wind etc. experienced by a particular site.").
word("exposure", 'n.', "Details of the time and f-number used.").
word("expressive", 'adj.', "Effectively conveying thought or feeling.").
word("expulsion", 'n.', "The act of expelling or the state of being expelled.").
word("extant", 'adj.', "Still in existence.").
word("extant", 'adj.', "Currently existing; not having disappeared.").
word("extemporaneous", 'adj.', "With inadequate preparation or without advance thought; offhand.").
word("extempore", 'adv.', "Without preparation; extemporaneously.").
word("extensible", 'adj.', "Capable of being extended.").
word("extension", 'n.', "The operation of stretching a broken bone so as to bring the fragments into the same straight line.").
word("extension", 'n.', "The act of extending; a stretching out; enlargement in length, breadth, or time; an increase").
word("extensive", 'adj.', "Having a combined system entropy that equals the sum of the entropies of the independent systems.").
word("extensive", 'adj.', "Considerable in amount.").
word("extensor", 'n.', "A muscle whose contraction extends or straightens a limb or body part.").
word("extenuate", 'v.', "To make thin or slender; to draw out so as to lessen the thickness.").
word("extenuate", 'v.', "To lower or degrade; to detract from.").
word("exterior", 'n.', "The outside part, parts or surface of something.").
word("exterior", 'n.', "Foreign lands.").
word("external", 'n.', "The exterior; outward features or appearances.").
word("external", 'n.', "A variable that is defined in the source code but whose value comes from some external source.").
word("extinct", 'adj.', "No longer in existence; having died out.").
word("extinct", 'adj.', "No longer used; obsolete, discontinued.").
word("extinguish", 'v.', "To die out.").
word("extinguish", 'v.', "To destroy or abolish something").
word("extol", 'v.', "To praise; to make high.").
word("extort", 'v.', "To take or seize from an unwilling person by physical force, menace, duress, torture, or any undue or illegal exercise of power or ingenuity.").
word("extort", 'v.', "To twist outwards.").
word("extortion", 'n.', "The practice of extorting money or other property by the use of force or threats.").
word("extradite", 'v.', "To remove a person from one state to another by legal process.").
word("extradition", 'n.', "A formal process by which a criminal suspect held by one government is handed over to another government for trial or, if the suspect has already been tried and found guilty, to serve his or her sentence.").
word("extrajudicial", 'adj.', "Out of or beyond the power or authority of a court or judge; beyond jurisdiction.").
word("extrajudicial", 'adj.', "Carried out without legal authority.").
word("extraneous", 'adj.', "Not belonging to, or dependent upon, a thing; without or beyond a thing; foreign").
word("extraneous", 'adj.', "Not essential or intrinsic").
word("extraordinary", 'adj.', "Not ordinary; exceptional; unusual.").
word("extraordinary", 'adj.', "Remarkably good.").
word("extravagance", 'n.', "Excessive or superfluous expenditure of money.").
word("extravagance", 'n.', "Prodigality, as of anger, love, expression, imagination, or demands.").
word("extravagant", 'adj.', "Profuse in expenditure; prodigal; wasteful.").
word("extravagant", 'adj.', "Exceeding the bounds of something; roving; hence, foreign.").
word("extremist", 'n.', "A person who holds extreme views, especially one who advocates such views; a radical or fanatic.").
word("extremity", 'n.', "A .").
word("extremity", 'n.', "A hand or foot.").
word("extricate", 'v.', "To free from intricacies or perplexity").
word("extricate", 'v.', "To free, disengage, loosen, or untangle.").
word("extrude", 'v.', "To push or thrust out.").
word("extrude", 'v.', "To expel; to drive off.").
word("exuberance", 'n.', "An overflowing quantity; superfluousness.").
word("exuberance", 'n.', "An instance of exuberant behaviour.").
word("exuberant", 'adj.', "Abundant, luxuriant.").
word("exuberant", 'adj.', "Very high-spirited; extremely energetic and enthusiastic.").
word("fabricate", 'v.', "To invent and form; to forge; to devise falsely.").
word("fabricate", 'v.', "To cut up an animal as preparation for cooking, particularly used in reference to fowl.").
word("fabulous", 'adj.', "Characteristic of fables; marvelous, extraordinary, incredible.").
word("fabulous", 'adj.', "Of or relating to fable, myth or legend.").
word("facet", 'n.', "Any one of the flat surfaces cut into a gem.").
word("facet", 'n.', "The narrow plane surface between flutings of a column; a fillet.").
word("facetious", 'adj.', "Pleasantly humorous; jocular.").
word("facetious", 'adj.', "Treating serious issues with (often deliberately) inappropriate humour; flippant.").
word("facial", 'adj.', "Of or affecting the face.").
word("facial", 'adj.', "Concerned with or used in improving the appearance of the face.").
word("facile", 'adj.', "Amiable, flexible, easy to get along with.").
word("facile", 'adj.', "Easy, now especially in a disparaging sense; contemptibly easy.").
word("facilitate", 'v.', "To make easy or easier.").
word("facilitate", 'v.', "To preside over (a meeting, a seminar).").
word("facility", 'n.', "The fact of being easy, or easily done; absence of difficulty, simplicity.").
word("facility", 'n.', "A condition of mental weakness less than idiocy, but enough to make a person easily persuaded to do something against their better interest.").
word("facsimile", 'n.', "Reproduction in the exact form as the original.").
word("facsimile", 'n.', "A fax, a machine for making and sending copies of printed material and images via radio or telephone network.").
word("faction", 'n.', "A form of literature, film etc., that treats real people or events as if they were fiction; a mix of fact and fiction").
word("faction", 'n.', "A group of people, especially within a political organization, which expresses a shared belief or opinion different from people who are not part of the group.").
word("factious", 'adj.', "Given to or characterized by discordance or insubordination.").
word("factious", 'adj.', "Of, pertaining to, or caused by factions.").
word("fallacious", 'adj.', "Deceptive or misleading.").
word("fallacious", 'adj.', "Characterized by fallacy; false or mistaken.").
word("fallacy", 'n.', "Deceptive or false appearance; that which misleads the eye or the mind.").
word("fallacy", 'n.', "An argument, or apparent argument, which professes to be decisive of the matter at issue, while in reality it is not. A specious argument.").
word("fallible", 'adj.', "Capable of making mistakes or being wrong.").
word("fallow", 'n.', "The ploughing or tilling of land, without sowing it for a season.").
word("fallow", 'n.', "Ground ploughed and harrowed but left unseeded for one year.").
word("famish", 'v.', "To suffer extreme hunger or thirst, so as to be exhausted in strength, or to nearly perish.").
word("famish", 'v.', "To suffer extremity from deprivation of anything essential or necessary.").
word("fanatic", 'n.', "A person who is zealously enthusiastic for some cause, especially in religion.").
word("fancier", 'n.', "One who fancies; a person with a special interest, attraction or liking for something.").
word("fancier", 'n.', "A person who breeds or grows a particular animal or plant for points of excellence.").
word("fanciless", 'adj.', "Having no fancy; without ideas or imagination.").
word("fastidious", 'adj.', "Difficult to please; quick to find fault.").
word("fastidious", 'adj.', "Excessively particular, demanding, or fussy about details, especially about tidiness and cleanliness.").
word("fathom", 'n.', "An English unit of length for water depth notionally based upon the width of grown man's outstretched arms but standardized as 6 feet (about 1.8 m).").
word("fathom", 'n.', "Various similar units in other systems.").
word("fatuous", 'adj.', "Obnoxiously stupid, vacantly silly, content in one's foolishness.").
word("faulty", 'adj.', "Having or displaying faults; not perfect; not adequate or acceptable.").
word("faulty", 'adj.', "At fault, to blame; guilty.").
word("faun", 'n.', "A woodland creature with pointed ears, legs, and short horns of a goat and a fondness for unrestrained revelry.").
word("faun", 'n.', "Any of various nymphalid butterflies of the genus .").
word("fawn", 'n.', "A young deer.").
word("fawn", 'n.', "The young of an animal; a whelp.").
word("fealty", 'n.', "Fidelity to one's lord or master; the feudal obligation by which the tenant or vassal was bound to be faithful to his lord.").
word("fealty", 'n.', "The oath by which this obligation was assumed.").
word("feasible", 'adj.', "Able to be done in practice.").
word("federate", 'v.', "To unite in a federation.").
word("feint", 'n.', "A movement made to confuse the opponent; a dummy.").
word("feint", 'n.', "An offensive movement resembling an attack in all but its continuance.").
word("felicitate", 'v.', "To congratulate.").
word("felicity", 'n.', "Something that is either a source of happiness or particularly apt.").
word("felicity", 'n.', "Happiness; an instance of this.").
word("felon", 'n.', "A bacterial infection at the end of a finger or toe.").
word("felon", 'n.', "A wicked person.").
word("felonious", 'adj.', "Done with intent to commit a crime.").
word("felonious", 'adj.', "Of, relating to, being, or having the quality of felony").
word("felony", 'n.', "A serious criminal offense, which, under United States federal law, is punishable by imprisonment for a term exceeding one year or by death.").
word("feminine", 'adj.', "Of or pertaining to the female gender; womanly.").
word("feminine", 'adj.', "Of or pertaining to the female sex; biologically female, not male.").
word("fernery", 'n.', "A specialized garden for the cultivation and display of ferns.").
word("fernery", 'n.', "An area naturally abundant in ferns.").
word("ferocious", 'adj.', "Marked by extreme and violent energy.").
word("ferocious", 'adj.', "Extreme or intense.").
word("ferocity", 'n.', "The condition of being ferocious.").
word("fervent", 'adj.', "Exhibiting particular enthusiasm, zeal, conviction, persistence, or belief.").
word("fervent", 'adj.', "Glowing, burning, very hot.").
word("fervid", 'adj.', "Intensely hot, emotional, or zealous.").
word("fervor", 'n.', "An intense, heated emotion; passion, ardor.").
word("fervor", 'n.', "A passionate enthusiasm for some cause.").
word("festal", 'adj.', "Festive, relating to a festival or feast").
word("festive", 'adj.', "In the mood to celebrate.").
word("festive", 'adj.', "Having the atmosphere, decoration, or attitude of a festival, holiday, or celebration.").
word("fete", 'n.', "A festival open to the public, the proceeds from which are often given to charity.").
word("fete", 'n.', "A feast, celebration or carnival.").
word("fetus", 'n.', "A human embryo after the eighth week of gestation.").
word("fetus", 'n.', "An unborn or unhatched vertebrate showing signs of the mature animal.").
word("feudal", 'adj.', "Of, or relating to feudalism.").
word("feudalism", 'n.', "A social system based on personal ownership of resources and personal fealty between a suzerain (lord) and a vassal (subject). Defining characteristics are direct ownership of resources, personal loyalty, and a hierarchical social structure reinforced by religion.").
word("fez", 'n.', "A felt hat in the shape of a truncated cone, having a flat top with a tassel attached.").
word("fiasco", 'n.', "A ludicrous or humiliating situation. Some effort that went quite wrong.").
word("fiasco", 'n.', "A sudden or unexpected failure.").
word("fickle", 'adj.', "Quick to change one’s opinion or allegiance; insincere; not loyal or reliable.").
word("fickle", 'adj.', "Changeable.").
word("fictitious", 'adj.', "Invented; contrived.").
word("fidelity", 'n.', "Loyalty to one's spouse or partner, including abstention from cheating or extramarital affairs.").
word("fidelity", 'n.', "The degree to which a system accurately reproduces an input.").
word("fiducial", 'adj.', "Based on having trust.").
word("fiducial", 'adj.', "Accepted as a fixed basis of reference.").
word("fief", 'n.', "An estate held by a person on condition of providing military service to a superior.").
word("fief", 'n.', "An area of dominion, especially in a corporate or governmental bureaucracy.").
word("filibuster", 'n.', "A mercenary soldier; a freebooter; specifically, a mercenary who travelled illegally in an organized group from the United States to a country in Central America or the in the mid-19th century seeking economic and political benefits through armed force.").
word("filibuster", 'n.', "A tactic (such as giving long, often irrelevant speeches) employed to delay the proceedings of, or the making of a decision by, a legislative body, particularly the United States Senate.").
word("finale", 'n.', "The chronological conclusion of a series of narrative works.").
word("finale", 'n.', "The grand end of something, especially a show or piece of music.").
word("finality", 'n.', "The state of being final; the condition from which no further changes occur.").
word("finally", 'adv.', "At the end or conclusion; ultimately.").
word("finally", 'adv.', "To finish (with); lastly (in the present).").
word("financial", 'adj.', "Having dues and fees paid up to date for a club or society.").
word("financial", 'adj.', "Related to finances.").
word("financier", 'n.', "A light, spongy teacake, usually based on almond flour or flavoring.").
word("financier", 'n.', "A traditional French (Ragoût a la Financière) or Piemontese (Finanziera alla piemontese) rich sauce or ragout, made with coxcomb, wattles, cock's testicles, chicken livers and a variety of other ingredients.").
word("finery", 'n.', "A charcoal hearth or furnace for the conversion of cast iron into wrought iron, or into iron suitable for puddling.").
word("finery", 'n.', "Ornament; decoration; especially, excessive decoration; showy clothes; jewels.").
word("finesse", 'n.', "In bridge, whist, etc.: a technique which allows one to win a trick, usually by playing a card when it is thought that a card that can beat it is held by another player whose turn is over.").
word("finesse", 'n.', "An adroit manoeuvre.").
word("finite", 'adj.', "Having an end or limit; constrained by bounds; whose number of elements is a natural number.").
word("finite", 'adj.', "Limited by (i.e. inflected for) person or number.").
word("fiscal", 'adj.', "Related to the of a , , or , particularly to government spending and revenue.").
word("fiscal", 'adj.', "Pertaining to and money in general; .").
word("fishmonger", 'n.', "A person who sells fish.").
word("fishmonger", 'n.', "A pimp.").
word("fissure", 'n.', "A long, narrow crack or opening made by breaking or splitting, especially in rock or earth.").
word("fissure", 'n.', "A break or slit in tissue usually at the junction of skin and mucous membrane.").
word("fitful", 'adj.', "Characterized by sudden bursts of activity with periods of inactivity in between; intermittent, irregular, unsteady.").
word("fitful", 'adj.', "Characterized by fits (convulsions or seizures).").
word("fixture", 'n.', "Something that is fixed in place, especially a permanent appliance or other item of personal property that is considered part of a house and is sold with it; compare fitting, furnishing.").
word("fixture", 'n.', "A work-holding or support device used in the manufacturing industry.").
word("flagrant", 'adj.', "Obvious and offensive; blatant; scandalous.").
word("flagrant", 'adj.', "On fire; flaming.").
word("flamboyant", 'adj.', "Of a blade: forged in a wavy, undulating pattern, like a or a kris.").
word("flamboyant", 'adj.', "Showy, bold or audacious in behaviour, appearance, etc.").
word("flatulence", 'n.', "The release of such gas; breaking wind.").
word("flatulence", 'n.', "The state of having gas, often smelly, trapped (and when released, frequently with noise) in the digestive system of a human and some other animals; wind; and when released, a flatus, a fart.").
word("fledgling", 'n.', "A young bird which has just developed its flight feathers (notably wings).").
word("fledgling", 'n.', "An immature, naïve or inexperienced person.").
word("flexible", 'adj.', "Capable of being flexed or bent without breaking; able to be turned or twisted without breaking.").
word("flexible", 'adj.', "Capable or being adapted or molded in some way.").
word("flimsy", 'adj.', "Weak; ill-founded.").
word("flimsy", 'adj.', "Likely to bend or break under pressure.").
word("flippant", 'adj.', "Showing disrespect through a casual attitude, levity, and a lack of due seriousness; pert.").
word("flippant", 'adj.', "Glib; speaking with ease and rapidity").
word("floe", 'n.', "A low, flat mass of floating ice.").
word("flora", 'n.', "Plants considered as a group, especially those of a particular country, region, time, etc.").
word("flora", 'n.', "A book describing the plants of a country, region, time, etc.").
word("floral", 'adj.', "Of, pertaining to, or connected with flowers.").
word("floral", 'adj.', "Portraying flowers, especially in a stylized way.").
word("florid", 'adj.', "Having a rosy or pale red colour; ruddy.").
word("florid", 'adj.', "In a blatant, vivid, or highly disorganized state.").
word("florist", 'n.', "A person who studies or writes about flowers.").
word("florist", 'n.', "A person who sells flowers.").
word("fluctuate", 'v.', "To vary irregularly; to swing.").
word("fluctuate", 'v.', "To cause to vary irregularly.").
word("fluctuation", 'n.', "A motion like that of waves; a moving in this and that direction.").
word("fluctuation", 'n.', "In medicine, a wave-like motion or undulation of a fluid in a natural or abnormal cavity (e.g. pus in an abscess), which is felt during palpation or percussion.").
word("flue", 'n.', "A pipe or duct that carries gaseous combustion products away from the point of combustion (such as a furnace).").
word("flue", 'n.', "An enclosed passageway in which to direct air or other gaseous current along.").
word("fluent", 'adj.', "Able to use a language accurately, rapidly, and confidently – in a flowing way.").
word("fluent", 'adj.', "That flows; flowing, liquid.").
word("flux", 'n.', "A state of ongoing change.").
word("flux", 'n.', "A chemical agent for cleaning metal prior to soldering or welding.").
word("foggy", 'adj.', "Obscured by mist or fog; unclear; hazy").
word("foggy", 'adj.', "Being, covered with, or pertaining to").
word("foible", 'n.', "A weakness or failing of character.").
word("foible", 'n.', "Part of a sword between the middle and the point, weaker than the forte.").
word("foist", 'v.', "To pass off as genuine or worthy.").
word("foist", 'v.', "To force another to accept especially by stealth or deceit.").
word("foliage", 'n.', "The leaves of plants.").
word("foliage", 'n.', "An architectural ornament representing foliage.").
word("folio", 'n.', "A page of a book, that is, one side of a leaf of a book.").
word("folio", 'n.', "A page in an account book; sometimes, two opposite pages bearing the same serial number.").
word("fondle", 'v.', "To touch or stroke lovingly.").
word("fondle", 'v.', "To grasp.").
word("foolery", 'n.', "Foolish behaviour or speech.").
word("foppery", 'n.', "The dress or actions of a fop.").
word("foppery", 'n.', "Stupidity.").
word("foppish", 'adj.', "Like a fop, a man overly concerned with his appearance; vain and showy.").
word("forbearance", 'n.', "A refraining from the enforcement of something (as a debt, right, or obligation) that is due.").
word("forbearance", 'n.', "Patient self-control; restraint and tolerance under provocation.").
word("forby", 'adv.', "Past; by; beyond.").
word("forby", 'adv.', "Uncommonly; exceptionally.").
word("forcible", 'adj.', "(rare or obsolete) Having (physical) force, forceful.").
word("forcible", 'adj.', "Able to be forced.").
word("forebode", 'v.', "To be prescient of (some ill or misfortune); to have an inward conviction of, as of a calamity which is about to happen; to augur despondingly.").
word("forebode", 'v.', "To predict a future event; to hint at something that will happen (especially as a literary device).").
word("forecast", 'v.', "To estimate how something will be in the future.").
word("forecast", 'v.', "To contrive or plan beforehand.").
word("forecastle", 'n.', "A raised part of the upper deck at the front of a ship.").
word("forecastle", 'n.', "Crew's quarters located at the forward part of a ship.").
word("foreclose", 'v.', "To cut off (a mortgager) by a judgment of court from the power of redeeming the mortgaged premises.").
word("foreclose", 'v.', "To repossess a mortgaged property whose owner has failed to make the necessary payments; used with on.").
word("forecourt", 'n.', "The area in front of a petrol station where the petrol pumps are situated.").
word("forecourt", 'n.', "Any open area in front of a building.").
word("forefather", 'n.', "Ancestor").
word("forefather", 'n.', "Cultural ancestor; one who originated an idea or tradition.").
word("forego", 'v.', "To precede, to go before.").
word("forego", 'v.', "; to abandon, to relinquish").
word("foreground", 'n.', "The elements of an image which lie closest to the picture plane.").
word("foreground", 'n.', "The subject of an image, often depicted at the bottom in a two-dimensional work.").
word("forehead", 'n.', "The part of the face above the eyebrows and below the hairline.").
word("forehead", 'n.', "The upper part of a mobile phone, above the screen.").
word("foreign", 'adj.', "Originating from, characteristic of, belonging to, or being a citizen of a country or place other than the one under discussion.").
word("foreign", 'adj.', "From a different one of the states of the United States, as of a state of residence or incorporation.").
word("foreigner", 'n.', "A private job run by an employee at a trade factory rather than going through the business.").
word("foreigner", 'n.', "A person from a foreign country.").
word("forejudge", 'v.', "To judge beforehand; prejudge.").
word("foreknowledge", 'n.', "Knowing beforehand; foresight, precognition, prescience.").
word("foreman", 'n.', "A black (slave) assistant to the white overseer who managed field hands.").
word("foreman", 'n.', "The leader of a work crew.").
word("foreordain", 'v.', "To predestine or preordain.").
word("foreordination", 'n.', "Previous ordination or appointment; predetermination; predestination.").
word("forepeak", 'n.', "The part of the hold of a ship within the angle of the bow").
word("forerun", 'v.', "To run in front.").
word("forerun", 'v.', "To precede; to forecast or foreshadow.").
word("foresail", 'n.', "A square fore-and-aft sail set on the foremast, but behind it, on a schooner or other similar vessel.").
word("foresail", 'n.', "The lowest (and usually the largest) square sail hung on the foremast").
word("foresee", 'v.', "To be able to see beforehand: to anticipate; predict.").
word("foresee", 'v.', "To provide.").
word("foresight", 'n.', "A bearing taken forwards towards a new object").
word("foresight", 'n.', "The front sight on a rifle or similar weapon").
word("foretell", 'v.', "To predict; to tell (the future) before it occurs; to prophesy.").
word("foretell", 'v.', "To tell (a person) of the future.").
word("forethought", 'n.', "Thinking beforehand or in advance, planning; prior or previous consideration; premeditation.").
word("forethought", 'n.', "Anticipation.").
word("forfeit", 'v.', "To suffer the loss of something by wrongdoing or non-compliance").
word("forfeit", 'v.', "To lose a contest, game, match, or other form of competition by voluntary withdrawal, by failing to attend or participate, or by violation of the rules").
word("forfend", 'v.', "To prohibit; to forbid; to avert.").
word("forgery", 'n.', "An invention, creation.").
word("forgery", 'n.', "That which is forged, fabricated, falsely devised or counterfeited.").
word("forgo", 'v.', "To do without, to abandon, to renounce.").
word("forgo", 'v.', "To let pass, to leave alone, to let go.").
word("formation", 'n.', "The process of influencing or guiding a person to a deeper understanding of a particular vocation.").
word("formation", 'n.', "Something possessing structure or form.").
word("formidable", 'adj.', "Difficult to defeat or overcome.").
word("formidable", 'adj.', "Causing fear, dread, awe, or discouragement as a result of size, strength, or some other impressive feature; commanding respect; causing wonder or astonishment.").
word("formula", 'n.', "A plan or method for dealing with a problem or for achieving a result.").
word("formula", 'n.', "A symbolic expression of the structure of a compound.").
word("forswear", 'v.', "To renounce or deny something, especially under oath.").
word("forswear", 'v.', "To commit perjury; to break an oath.").
word("forte", 'n.', "The strong part of a sword blade, close to the hilt.").
word("forte", 'n.', "A strength or talent.").
word("forth", 'adv.', "Out into view; from a particular place or position.").
word("forth", 'adv.', "Beyond a (certain) boundary; away; abroad; out.").
word("forthright", 'adv.', "Straight forward, in a straight direction.").
word("forthright", 'adv.', "Swiftly.").
word("fortify", 'v.', "To increase the defenses of; to strengthen and secure by military works; to render defensible against an attack by hostile forces.").
word("fortify", 'v.', "To add spirits to wine to increase the alcohol content.").
word("fortitude", 'n.', "Mental or emotional strength that enables courage in the face of adversity.").
word("fortitude", 'n.', "Physical strength.").
word("fracture", 'n.', "An instance of breaking, a place where something has broken.").
word("fracture", 'n.', "A break in bone or cartilage.").
word("fragile", 'adj.', "Easily broken or destroyed, and thus often of subtle or intricate structure.").
word("fragile", 'adj.', "Feeling weak or easily disturbed as a result of illness.").
word("frailty", 'n.', "A fault proceeding from weakness; foible; sin of infirmity.").
word("frailty", 'n.', "The condition quality of being frail, physically, mentally, or morally; weakness of resolution; liability to be deceived.").
word("frankincense", 'n.', "A type of incense obtained from the tree.").
word("frantic", 'adj.', "In a state of panic, worry, frenzy or rush.").
word("frantic", 'adj.', "Extremely energetic").
word("fraternal", 'adj.', "Of or pertaining to a or .").
word("fraternal", 'adj.', "Platonic or .").
word("fraudulence", 'n.', "The condition of being fraudulent; deceitfulness.").
word("fraudulent", 'adj.', "Dishonest; based on fraud or deception.").
word("fraudulent", 'adj.', "False, phony.").
word("fray", 'v.', "To (cause to) unravel; used particularly for the edge of something made of cloth, or the end of a rope.").
word("fray", 'v.', "To bear the expense of; to defray.").
word("free trade", 'n.', "International trade without government interference, especially from tariffs or duties on imports.").
word("freemason", 'n.', "A member of a guild of skilled itinerant masons during the Middle Ages and early modern times.").
word("freethinker", 'n.', "A person who has formed his or her opinions using reason and rational enquiry; somebody who has rejected dogma, especially with regard to religion.").
word("frequency", 'n.', "The rate of occurrence of anything; the relationship between incidence and time period.").
word("frequency", 'n.', "The quotient of the number of times n a periodic phenomenon occurs over the time t in which it occurs: f = n / t .").
word("fresco", 'n.', "A cool, refreshing state of the air; coolness, duskiness, shade.").
word("fresco", 'n.', "An artwork made by applying water-based pigment to wet or fresh lime mortar or plaster.").
word("freshness", 'n.', "The state or quality of being fresh.").
word("fretful", 'adj.', "Irritable, bad-tempered, grumpy or peevish.").
word("fretful", 'adj.', "Unable to relax; fidgety or restless.").
word("frightful", 'adj.', "Full of something causing fright, whether").
word("frightful", 'adj.', "Full of fright, whether").
word("frigid", 'adj.', "Very cold; lacking warmth; icy.").
word("frigid", 'adj.', "Chilly in manner; lacking affection or zeal; impassive.").
word("frigidarium", 'n.', "In Ancient Roman baths, a room with a bath of cold water.").
word("frivolity", 'n.', "Frivolous act").
word("frivolity", 'n.', "State of being frivolous").
word("frivolous", 'adj.', "Of little weight or importance; not worth notice; slight.").
word("frivolous", 'adj.', ", especially at an inappropriate time or in an inappropriate manner.").
word("frizz", 'v.', "To form into little burs, knobs, or tufts, as the nap of cloth.").
word("frizz", 'v.', "To make (leather) soft and of even thickness by rubbing, as with pumice stone or a blunt instrument.").
word("frizzle", 'v.', "To curl or crisp, as hair; to frizz; to crinkle.").
word("frizzle", 'v.', "To fry something until crisp and curled.").
word("frolicsome", 'adj.', "Characterised or marked by frolicking; playful.").
word("frontier", 'n.', "The part of a country which borders or faces another country or unsettled region.").
word("frontier", 'n.', "The most advanced or recent version of something; leading edge.").
word("frugal", 'adj.', "Avoiding unnecessary expenditure either of money or of anything else which is to be used or consumed; avoiding waste.").
word("fruition", 'n.', "The fulfillment of something worked for.").
word("fruition", 'n.', "The enjoyment derived from a possession.").
word("fugacious", 'adj.', "Fleeting, fading quickly, transient.").
word("fulcrum", 'n.', "The support about which a lever pivots.").
word("fulcrum", 'n.', "A crux or pivot; a central point.").
word("fulminate", 'v.', "To strike with lightning; to cause to explode.").
word("fulminate", 'v.', "To make a verbal attack.").
word("fulsome", 'adj.', "Offensive to good taste, tactless, overzealous, excessive.").
word("fulsome", 'adj.', "Excessively flattering (connoting insincerity).").
word("fumigate", 'v.', "To disinfect, purify, or rid of vermin with the fumes of certain chemicals.").
word("functionary", 'n.', "A paper-pusher, bean counter.").
word("functionary", 'n.', "A person employed as an official in a bureaucracy (usually corporate or governmental) who holds limited authority and primarily serves to carry out a simple function for which discretion is not required.").
word("fundamental", 'adj.', "Pertaining to the foundation or basis; serving for the foundation.").
word("fundamental", 'adj.', "Essential, as an element, principle, or law; important; original; elementary.").
word("fungible", 'adj.', "Able to be substituted for something of equal value or utility.").
word("fungous", 'adj.', "Of or containing a spongy, abnormal excrescence.").
word("fungous", 'adj.', "Of or pertaining to fungi; fungal.").
word("fungus", 'n.', "Any member of the kingdom Fungi; a eukaryotic organism typically having chitin cell walls but no chlorophyll or plastids. Fungi may be unicellular or multicellular.").
word("fungus", 'n.', "A spongy, abnormal excrescence, such as excessive granulation tissue formed in a wound.").
word("furbish", 'v.', "To polish or burnish.").
word("furbish", 'v.', "To renovate or recondition.").
word("furlong", 'n.', "A unit of length equal to 220 yards, mile, or 201.168 meters, now only used in measuring distances in horse racing.").
word("furlough", 'n.', "A leave of absence or vacation.").
word("furlough", 'n.', "A period of unpaid time off, used by an employer to reduce costs.").
word("furrier", 'n.', "A person who sells, makes, repairs, alters, cleans, or otherwise deals in clothing made of fur.").
word("furrier", 'n.', "A person who secures accommodation for an army.").
word("further", 'adj.', "More distant; relatively distant.").
word("further", 'adj.', "More, additional.").
word("furtherance", 'n.', "Advancement or progress.").
word("furtherance", 'n.', "Promotion.").
word("furtive", 'adj.', "Exhibiting guilty or evasive secrecy.").
word("furtive", 'adj.', "Stealthy.").
word("fuse", 'v.', "To melt together; to blend; to mix indistinguishably.").
word("fuse", 'v.', "To form a bicyclic compound from two similar or different types of ring such that two or more atoms are shared between the resulting rings").
word("fusible", 'adj.', "Able to be fused or melted.").
word("futile", 'adj.', "Incapable of producing results; doomed not to be successful; not worth attempting.").
word("futurist", 'n.', "One who studies and predicts possible futures.").
word("futurist", 'n.', "An adherent to the principles of the artistic movement of futurism.").
word("gaiety", 'n.', "Merrymaking or festivity.").
word("gaiety", 'n.', "The state of being happy or merry.").
word("gaily", 'adv.', "Merrily.").
word("gaily", 'adv.', "Showily.").
word("gait", 'n.', "One of the different ways in which a horse can move, either naturally or as a result of training.").
word("gait", 'n.', "Manner of walking or stepping; bearing or carriage while moving.").
word("gallant", 'adj.', "Polite and attentive to ladies; courteous to women; chivalrous.").
word("gallant", 'adj.', "Brave, valiant.").
word("galore", 'adj.', "In abundance.").
word("galvanic", 'adj.', "Of a current that is not alternating, as opposed to faradic.").
word("galvanic", 'adj.', "Of or pertaining to galvanism; electric.").
word("galvanism", 'n.', "The chemical generation of electricity.").
word("galvanism", 'n.', "The therapeutic use of electricity.").
word("galvanize", 'v.', "To coat with a thin layer of metal by electrochemical means.").
word("galvanize", 'v.', "To coat with rust-resistant zinc.").
word("gamble", 'v.', "To take a risk, with the potential of a positive outcome.").
word("gamble", 'v.', "To interact with equipment at a casino").
word("gambol", 'n.', "An instance of more general frisking or frolicking.").
word("gambol", 'n.', "An instance of running or skipping about playfully.").
word("gamester", 'n.', "A gambler.").
word("gamester", 'n.', "A person who plays games.").
word("gamut", 'n.', "All the colours that can be presented by a device such as a monitor or printer.").
word("gamut", 'n.', "A (normally) complete range.").
word("garnish", 'v.', "To ornament with something placed around it.").
word("garnish", 'v.', "To decorate with ornaments; to adorn; to embellish.").
word("garrison", 'n.', "A military unit, nominally headed by a colonel, equivalent to a USAF support wing, or an army regiment.").
word("garrison", 'n.', "The troops stationed at such a post.").
word("garrote", 'v.', "To execute by strangulation").
word("garrote", 'v.', "To kill using a garrote").
word("garrulous", 'adj.', "Excessively or tiresomely talkative.").
word("garrulous", 'adj.', "Excessively wordy and rambling.").
word("gaseous", 'adj.', "Relating to, or existing as gas .").
word("gaseous", 'adj.', "Of a liquid containing bubbles: gassy.").
word("gastric", 'adj.', "Of or relating to the stomach.").
word("gastritis", 'n.', "Inflammation of the lining of the stomach, characterised by nausea, loss of appetite, and upper abdominal discomfort or pain.").
word("gastronomy", 'n.', "The art of preparing and eating good food.").
word("gastronomy", 'n.', "The study of the relationship between food and culture.").
word("gauge", 'n.', "A measure; a standard of measure; an instrument to determine dimensions, distance, or capacity; a standard").
word("gauge", 'n.', "Any instrument for ascertaining or regulating the level, state, dimensions or forms of things").
word("gendarme", 'n.', "A policeman.").
word("gendarme", 'n.', "A rock pinnacle on a mountain ridge.").
word("genealogist", 'n.', "A person who studies or practises genealogy, an expert in genealogy.").
word("genealogy", 'n.', "The descent of a person, family, or group from an ancestor or ancestors; lineage or pedigree.").
word("genealogy", 'n.', "The study, and formal recording of such descents.").
word("generality", 'n.', "The quality of being general.").
word("generality", 'n.', "The population in general.").
word("generalize", 'v.', "To spread throughout the body and become systemic.").
word("generalize", 'v.', "To derive or deduce (a general concept or principle) from particular facts.").
word("generally", 'adv.', "As a rule; usually.").
word("generally", 'adv.', "Without reference to specific details.").
word("generate", 'v.', "To produce as a result of a chemical or physical process.").
word("generate", 'v.', "To procreate, beget.").
word("generic", 'adj.', "Written so as to operate on any data type, the type required being passed as a parameter.").
word("generic", 'adj.', "Having coordinates that are algebraically independent over the base field.").
word("generosity", 'n.', "The trait of being abundant, more than adequate.").
word("generosity", 'n.', "The trait of being willing to donate money, time or resources.").
word("genesis", 'n.', "The origin, start, or point at which something comes into being.").
word("geniality", 'n.', "The quality of being genial; friendly cheerfulness; warmth of disposition and manners.").
word("genital", 'adj.', "Of, or relating to biological reproduction.").
word("genital", 'adj.', "Of, or relating to psychosexual development during puberty.").
word("genitive", 'adj.', "Of or pertaining to that case (as the second case of Latin and Greek nouns) which expresses a quality, origin or possession. It corresponds to the possessive case in English.").
word("genteel", 'adj.', "Affectedly proper or refined; somewhat prudish refinement; excessively polite.").
word("genteel", 'adj.', "Polite and well-mannered.").
word("gentile", 'adj.', "Of a part of speech such as an adjective, noun or verb: relating to a particular city, nation or country.").
word("gentile", 'adj.', "Non-Jewish.").
word("geology", 'n.', "The science that studies the structure of the earth (or other planets), together with its origin and development, especially by examination of its rocks.").
word("geology", 'n.', "The geological structure of a region.").
word("germane", 'adj.', "Related to a topic of discussion or consideration.").
word("germinate", 'v.', "Of a seed, to begin to grow, to sprout roots and leaves.").
word("germinate", 'v.', "To cause to grow; to produce.").
word("gestation", 'n.', "The period of time during which an infant animal or human physically develops inside the mother's body until it is born.").
word("gestation", 'n.', "The process of development of a plan or idea.").
word("gesticulate", 'v.', "To make gestures or motions, as in speaking.").
word("gesticulate", 'v.', "To say or express through gestures.").
word("gesture", 'n.', "A motion made with a pointing device, or on a touchscreen, that is recognised by the system as a command.").
word("gesture", 'n.', "An act or a remark that serves as a formality or as a sign of attitude.").
word("ghastly", 'adj.', "Extremely bad.").
word("ghastly", 'adj.', "Like a ghost in appearance; death-like; pale; pallid; dismal.").
word("giddy", 'adj.', "Dizzy, feeling dizzy or unsteady and as if about to fall down.").
word("giddy", 'adj.', "Frivolous, impulsive, inconsistent, changeable.").
word("gigantic", 'adj.', "In the manner of a giant.").
word("gigantic", 'adj.', "Very large.").
word("giver", 'n.', "One who gives; a donor or contributor.").
word("glacial", 'adj.', "Having the appearance of ice.").
word("glacial", 'adj.', "Cold and icy.").
word("glacier", 'n.', "A large body of ice which flows under its own mass, usually downhill.").
word("gladden", 'v.', "To become more glad in one's disposition.").
word("gladden", 'v.', "To cause (something) to become more glad.").
word("glazier", 'n.', "One who glazes; a craftsman who works with glass, fitting windows, etc.").
word("glimmer", 'n.', "A faint light; a dim glow.").
word("glimmer", 'n.', "A flash of light.").
word("glimpse", 'n.', "A brief look, glance, or peek.").
word("glimpse", 'n.', "A faint idea; an inkling.").
word("globose", 'adj.', "Having a globular form.").
word("globular", 'adj.', "Roughly spherical in shape.").
word("globular", 'adj.', "Comprising globules.").
word("glorious", 'adj.', "Bright or shining;").
word("glorious", 'adj.', "Excellent, wonderful; delightful.").
word("glutinous", 'adj.', "Glue-like, sticky, viscid.").
word("glutinous", 'adj.', "Containing gluten.").
word("gluttonous", 'adj.', "Given to excessive eating; prone to overeating.").
word("gluttonous", 'adj.', "Greedy.").
word("gnash", 'v.', "To grind (one's teeth) in pain or in anger.").
word("gnash", 'v.', "To grind between the teeth.").
word("gosling", 'n.', "A young goose.").
word("gosling", 'n.', "A inexperienced and immature, or foolish and naive, young person.").
word("gossamer", 'adj.', "Tenuous, light, filmy or delicate.").
word("gourd", 'n.', "Any of the trailing or climbing vines producing fruit with a hard rind or shell, from the genera Lagenaria and Cucurbita (in Cucurbitaceae).").
word("gourd", 'n.', "Loaded dice.").
word("gourmand", 'n.', "A person given to excess in the consumption of food and drink; a greedy or ravenous eater.").
word("gourmand", 'n.', "A person who appreciates good food.").
word("graceless", 'adj.', "Without the grace of God.").
word("graceless", 'adj.', "Without grace.").
word("gradation", 'n.', "Any degree or relative position in an order or series.").
word("gradation", 'n.', "A passing by small degrees from one tone or shade, as of color, to another.").
word("gradient", 'adj.', "Moving by steps; walking.").
word("gradient", 'adj.', "Adapted for walking, as the feet of certain birds.").
word("granary", 'n.', "A storage facility for grain or sometimes animal feed.").
word("granary", 'n.', "A fertile, grain-growing region.").
word("grandeur", 'n.', "Nobility (state of being noble).").
word("grandeur", 'n.', "The state of being grand or splendid; magnificence.").
word("grandiloquent", 'adj.', "Given to using language in a showy way by using an excessive number of difficult words to impress others; bombastic; turgid").
word("grandiose", 'adj.', "Large and impressive, in size, scope or extent.").
word("grandiose", 'adj.', "Pompous or pretentious.").
word("grantee", 'n.', "The person to whom something is granted.").
word("grantor", 'n.', "A person who grants something.").
word("granular", 'adj.', "Grainy").
word("granular", 'adj.', "Consisting of, or resembling, granules or grains").
word("granulate", 'v.', "To collect or be formed into grains.").
word("granulate", 'v.', "To segment into tiny grains or particles.").
word("granule", 'n.', "A tiny grain, a small particle.").
word("granule", 'n.', "A small structure in a cell.").
word("grapple", 'v.', "To seize something and hold it firmly.").
word("grapple", 'v.', "To wrestle or tussle.").
word("gratification", 'n.', "A feeling of pleasure; satisfaction").
word("gratification", 'n.', "A reward; a gratuity.").
word("gratify", 'v.', "To please.").
word("gratify", 'v.', "To make content; to satisfy.").
word("gratuitous", 'adj.', "Given freely; unearned.").
word("gratuitous", 'adj.', "Unjustified or unnecessary; not called for by the circumstances").
word("gratuity", 'n.', "An additional payment given freely as thanks for service.").
word("gratuity", 'n.', ", in contexts where such additional payments have been made obligatory.").
word("gravity", 'n.', "The state or condition of having weight; weight; heaviness.").
word("gravity", 'n.', "The lowness of a note.").
word("gregarious", 'adj.', "Growing in open clusters or colonies; not matted together.").
word("gregarious", 'adj.', "Pertaining to a flock or crowd.").
word("grenadier", 'n.', "Any of various deep-sea fish of the family Macrouridae that have a large head and body and a long tapering tail; a rattail.").
word("grenadier", 'n.', "Either of two red and black libellulid dragonflies, and , of Asia and Australia.").
word("grief", 'n.', "Emotional pain, generally arising from misfortune, significant personal loss, bereavement, misconduct of oneself or others, etc.; sorrow; sadness.").
word("grief", 'n.', "Cause or instance of sorrow or pain; that which afflicts or distresses; trial.").
word("grievance", 'n.', "A wrong or hardship suffered, which is the grounds of a complaint.").
word("grievance", 'n.', "A complaint or annoyance.").
word("grievous", 'adj.', "Serious, grave, dire or dangerous.").
word("grievous", 'adj.', "Causing grief, pain or sorrow.").
word("grimace", 'n.', "A contorted facial expression, often expressing contempt or pain.").
word("grimace", 'n.', "Affectation, pretence.").
word("grindstone", 'n.', "An abrasive wheel for sharpening, polishing or grinding.").
word("grisly", 'adj.', "Horrifyingly repellent; gruesome, terrifying.").
word("grotesque", 'adj.', "Disgusting or otherwise viscerally revolting.").
word("grotesque", 'adj.', "Distorted and unnatural in shape or size; abnormal and hideous.").
word("grotto", 'n.', "A small cave.").
word("grotto", 'n.', "A local organization of cavers that typically organizes trips to caves and provides information and training for caving; a caving club.").
word("ground", 'n.', "The surface of the Earth, as opposed to the sky or water or underground.").
word("ground", 'n.', "The plain surface upon which the figures of an artistic composition are set.").
word("guess", 'n.', "A prediction about the outcome of something, typically made without factual evidence or support.").
word("guile", 'n.', "Deceptiveness, deceit, fraud, duplicity, dishonesty.").
word("guileless", 'adj.', "Free from guile; honest but naive.").
word("guinea", 'n.', "A gold coin originally worth twenty shillings; later (from 1717 until the adoption of decimal currency) standardised at a value of twenty-one shillings.").
word("guinea", 'n.', "A person of Italian descent.").
word("guise", 'n.', "External appearance in manner or dress; appropriate indication or expression; garb; shape.").
word("guise", 'n.', "Misleading appearance; cover, cloak.").
word("gullible", 'adj.', "Easily deceived or duped; naive, easily cheated or fooled.").
word("gumption", 'n.', "Common sense, initiative, resourcefulness.").
word("gumption", 'n.', "Boldness of enterprise; aggressiveness or initiative.").
word("gusto", 'n.', "Enthusiasm; enjoyment, vigor.").
word("guy", 'n.', "A support to secure or steady something prone to shift its position or be carried away (e.g. the mast of a ship or a suspension-bridge).").
word("guy", 'n.', "Thing, unit.").
word("guzzle", 'v.', "To drink or eat quickly, voraciously, or to excess; to gulp down; to swallow greedily, continually, or with gusto.").
word("guzzle", 'v.', "To consume anything quickly, greedily, or to excess, as if with insatiable thirst.").
word("gynecocracy", 'n.', "Government or rule by women, or a society with such leadership.").
word("gynecology", 'n.', "The study of, or the branch of medicine specializing in, the medical problems of women, especially disorders of the reproductive organs.").
word("gyrate", 'v.', "To revolve round a central point; to move spirally about an axis, as a tornado; to revolve.").
word("gyroscope", 'n.', "An apparatus composed of a wheel which spins inside of a frame (gimbal) and causes the balancing of the frame in any direction or position. In the form of a gyroscopic stabilizer, used to help keep aircraft and ships steady.").
word("habitable", 'adj.', "Safe and comfortable, where humans, or other animals, can live; fit for habitation.").
word("habitant", 'n.', "Inhabitant, dweller.").
word("habitant", 'n.', "A member of habitation colony at Stadacona founded by Samuel de Champlain, where Quebec City now lies").
word("habitual", 'adj.', "Pertaining to an action performed customarily, ordinarily, or usually.").
word("habitual", 'adj.', "Regular or usual.").
word("habitude", 'n.', "An associate; an acquaintance; someone with whom one is familiar.").
word("habitude", 'n.', "Behaviour or manner of existence in relation to something else; relation; respect.").
word("hackney", 'v.', "To make uninteresting or trite by frequent use.").
word("hackney", 'v.', "To use as a hackney.").
word("haggard", 'adj.', "Looking exhausted, worried, or poor in condition").
word("haggard", 'adj.', "Wild or untamed").
word("halcyon", 'adj.', "Calm, undisturbed, peaceful, serene.").
word("halcyon", 'adj.', "Pertaining to the halcyon or kingfisher.").
word("hale", 'adj.', "Sound, entire, healthy; robust, not impaired.").
word("handwriting", 'n.', "Text that was written by hand.").
word("handwriting", 'n.', "The characteristic writing of a particular person.").
word("harangue", 'n.', "A tirade, harsh scolding or rant, whether spoken or written.").
word("harangue", 'n.', "An impassioned, disputatious public speech.").
word("harass", 'v.', "To trouble (someone, or a group of people) through repeated military-style attacks.").
word("harass", 'v.', "Often followed by 'out': to fatigue or tire (someone) with exhausting and repeated efforts.").
word("harbinger", 'n.', "One who provides lodgings; especially, the officer of the English royal household who formerly preceded the court when travelling, to provide and prepare lodgings.").
word("harbinger", 'n.', "A person or thing that foreshadows or foretells the coming of someone or something.").
word("hardihood", 'n.', "Excessive boldness; foolish daring; offensive assurance.").
word("hardihood", 'n.', "Unyielding boldness and daring; firmness in doing something that exposes one to difficulty, danger, or calamity; intrepidness.").
word("harmonious", 'adj.', "Showing accord in feeling or action.").
word("harmonious", 'adj.', "Having components pleasingly or appropriately combined.").
word("havoc", 'n.', "Widespread devastation, destruction").
word("havoc", 'n.', "Mayhem").
word("hawthorn", 'n.', "Any of various shrubs and small trees of the genus Crataegus having small, apple-like fruits and thorny branches").
word("hazard", 'n.', "An obstacle or other feature which causes risk or danger; originally in sports, and now applied more generally.").
word("hazard", 'n.', "The chance of suffering harm; danger, peril, risk of loss.").
word("head first", 'adv.', "With the head first or foremost.").
word("heartrending", 'adj.', "That causes great grief, anguish or distress.").
word("heartrending", 'adj.', "That elicits deep sympathy.").
word("heedless", 'adj.', "Unaware; without noticing; careless; inattentive.").
word("heifer", 'n.', "A young female cow, one over one year old but which has not calved.").
word("heifer", 'n.', "A girl or young woman.").
word("heinous", 'adj.', "Totally reprehensible.").
word("hemorrhage", 'n.', "A heavy release of blood within or from the body.").
word("henchman", 'n.', "A loyal and trusted follower or subordinate.").
word("henchman", 'n.', "An assistant member of a criminal gang.").
word("henpeck", 'v.', "To nag persistently.").
word("heptagon", 'n.', "A polygon with seven sides and seven angles.").
word("heptarchy", 'n.', "A group of seven states, especially those in Anglo-Saxon Britain.").
word("heptarchy", 'n.', "A government of seven people.").
word("herbaceous", 'adj.', "Feeding on herbs and soft plants.").
word("herbaceous", 'adj.', "Not woody, lacking lignified tissues.").
word("herbarium", 'n.', "A collection of dried plants or parts of plants.").
word("herbarium", 'n.', "A building or institution where such a collection is kept.").
word("herbivorous", 'adj.', "Feeding chiefly on plants.").
word("hereditary", 'adj.', "Of a disease or trait: passed from a parent to offspring in the genes").
word("hereditary", 'adj.', "Of a title, honor or right: legally granted to somebody's descendant after that person's death.").
word("heredity", 'n.', "Hereditary transmission of the physical and genetic qualities of parents to their offspring; the biological law by which living beings tend to repeat their characteristics in their descendants.").
word("heresy", 'n.', "A doctrine held by a member of a religion at variance with established religious beliefs").
word("heresy", 'n.', "A controversial or unorthodox opinion held by a member of a group, as in politics, philosophy or science.").
word("heretic", 'n.', "Someone who believes contrary to the fundamental tenets of a religion they claim to belong to.").
word("heretic", 'n.', "Someone who does not conform to generally accepted beliefs or practices").
word("heritage", 'n.', "A birthright; the status acquired by birth, especially of but not exclusive to the firstborn.").
word("heritage", 'n.', "A tradition; a practice or set of values that is passed down from preceding generations through families or through institutional memory.").
word("hernia", 'n.', "A disorder in which a part of the body protrudes abnormally through a tear or opening in an adjacent part, especially of the abdomen.").
word("hesitancy", 'n.', "A pausing or halting before beginning a task, often as a result of some fear or uncertainty about the outcome.").
word("hesitant", 'adj.', "Tending to hesitate, wait, or proceed with caution or reservation.").
word("hesitation", 'n.', "Doubt; vacillation.").
word("hesitation", 'n.', "A faltering in speech; stammering.").
word("heterodox", 'adj.', "Of or pertaining to creeds, beliefs, or teachings, especially religious ones, that are different from orthodoxy, or the norm, but not sufficiently different to be called heretical.").
word("heterogeneity", 'n.', "A composition of diverse parts.").
word("heterogeneity", 'n.', "The quality of a substance which is not uniform.").
word("heterogeneous", 'adj.', "Visibly consisting of different components.").
word("heterogeneous", 'adj.', "Incommensurable because of different kinds.").
word("heteromorphic", 'adj.', "Differing in size or structure from the normal").
word("heteromorphic", 'adj.', "Having different forms in different stages of the life cycle").
word("hexagon", 'n.', "A polygon with six sides and six angles.").
word("hexangular", 'adj.', "Having six angles or corners.").
word("hexapod", 'adj.', "Having six feet, six-footed; belonging to the subphylum Hexapoda; hexapodous.").
word("hiatus", 'n.', "An interruption, break or pause.").
word("hiatus", 'n.', "A syllable break between two vowels, without an intervening consonant. (Compare .)").
word("hibernal", 'adj.', "Of or pertaining to winter; brumal or hiemal").
word("hideous", 'adj.', "Extremely or shockingly ugly.").
word("hideous", 'adj.', "Hateful; shocking.").
word("hilarious", 'adj.', "Very funny; causing great merriment and laughter.").
word("hilarious", 'adj.', "Full of hilarity; merry.").
word("hillock", 'n.', "A small hill.").
word("hinder", 'v.', "To make difficult to accomplish; to act as an obstacle; to frustrate.").
word("hinder", 'v.', "To delay or impede; to keep back, to prevent.").
word("hindrance", 'n.', "The state or act of hindering something").
word("hindrance", 'n.', "Something which hinders: something that holds back or causes problems with something else.").
word("hirsute", 'adj.', "Covered in hair or bristles; hairy.").
word("hoard", 'v.', "To amass, usually for one's own private collection.").
word("hoarse", 'adj.', "Having a dry, harsh tone to the voice, as a result of a sore throat, age, emotion, etc.").
word("homage", 'n.', "A demonstration of respect, such as towards an individual after their retirement or death").
word("homage", 'n.', "In feudalism, the formal oath of a vassal to honor his or her lord's rights.").
word("homogeneity", 'n.', "The condition of being homogeneous").
word("homogeneous", 'adj.', "Having the same composition throughout; of uniform make-up.").
word("homogeneous", 'adj.', "Of the same kind; alike, similar.").
word("homologous", 'adj.', "Showing a degree of correspondence or similarity.").
word("homonym", 'n.', "A word that both sounds and is spelled the same as another word.").
word("homonym", 'n.', "A name for a taxon that is identical in spelling to another name that belongs to a different taxon.").
word("homophone", 'n.', "A word which is pronounced the same as another word but differs in spelling or meaning or origin.").
word("homophone", 'n.', "A letter or group of letters which are pronounced the same as another letter or group of letters.").
word("honorarium", 'n.', "Compensation for services that do not have a predetermined value.").
word("hoodwink", 'v.', "To close the eyes.").
word("hoodwink", 'v.', "To cover the eyes with, or as if with, a hood; to blindfold.").
word("horde", 'n.', "A wandering troop or gang; especially, a clan or tribe of a nomadic people (originally Tatars) migrating from place to place for the sake of pasturage, plunder, etc.; a predatory multitude.").
word("horde", 'n.', "A large number of people or things.").
word("hosiery", 'n.', "Undergarments worn on the legs, such as socks, stockings, and pantyhose.").
word("hosiery", 'n.', "A shop selling such undergarments.").
word("hospitable", 'adj.', "Cordial and generous towards guests").
word("hospitable", 'adj.', "Receptive and open-minded").
word("hospitality", 'n.', "The act or service of welcoming, receiving, hosting, or entertaining guests; an appropriate attitude of openness, respect, and generosity toward guests.").
word("hospitality", 'n.', "The food, drink, and entertainment given to customers by a company or organization or provided to visitors by a private host.").
word("hostility", 'n.', "A hostile action, especially a military action. See for specific plural definition.").
word("hostility", 'n.', "The state of being hostile.").
word("huckster", 'n.', "A peddler or hawker, who sells small items, either door-to-door, from a stall or in the street.").
word("huckster", 'n.', "One who deceptively sells fraudulent products.").
word("humane", 'adj.', "Having or showing concern for the pain or suffering of another; compassionate.").
word("humane", 'adj.', "Pertaining to branches of learning concerned with human affairs or the humanities, especially classical literature or rhetoric.").
word("humanitarian", 'n.', "A person concerned with people's welfare; a do-gooder or philanthropist.").
word("humanitarian", 'n.', "One who believes that Jesus Christ is fully human and not divine.").
word("humanize", 'v.', "To make sympathetic or relatable.").
word("humanize", 'v.', "To make human; to give or cause to have the fundamental properties of a human.").
word("humbug", 'n.', "Anything complicated, offensive, troublesome, unpleasant or worrying; a misunderstanding, especially if trivial.").
word("humbug", 'n.', "A type of hard sweet (candy), usually peppermint flavoured with a striped pattern.").
word("humiliate", 'v.', "To cause to be ashamed; to injure the dignity and self-respect of.").
word("humiliate", 'v.', "To make humble; to lower in condition or status.").
word("hussar", 'n.', "A member of the light cavalry of any of several European armies.").
word("hussar", 'n.', "A member of the national cavalry of Hungary, Croatia and Poland.").
word("hustle", 'v.', "To be a prostitute, to exchange use of one's body for sexual purposes for money.").
word("hustle", 'v.', "To play deliberately badly at a game or sport in an attempt to encourage players to challenge.").
word("hybrid", 'adj.', "Consisting of diverse 'hybridized' components.").
word("hydra", 'n.', "A complex, multifarious problem or situation that cannot be solved easily and rapidly.").
word("hydra", 'n.', "A dragon-like creature with many heads and the ability to regrow them when maimed.").
word("hydraulic", 'adj.', "Pertaining to water.").
word("hydraulic", 'adj.', "Related to, or operated by, hydraulics.").
word("hydrodynamics", 'n.', "The scientific study of fluids in motion.").
word("hydroelectric", 'adj.', "That generates electricity by converting the energy of moving water, or of steam escaping under high pressure").
word("hydroelectric", 'adj.', "Of or relating to the electricity so produced").
word("hydromechanics", 'n.', "Fluid mechanics, especially when dealing with water").
word("hydrometer", 'n.', "An instrument that floats in a liquid and measures its specific gravity on a scale.").
word("hydrostatics", 'n.', "The scientific study of fluids at rest, especially when under pressure.").
word("hydrous", 'adj.', "Containing combined water; hydrated.").
word("hygiene", 'n.', "The science of health, its promotion and preservation.").
word("hygiene", 'n.', "Those conditions and practices that promote and preserve health.").
word("hypercritical", 'adj.', "Meticulously or excessively critical.").
word("hypnosis", 'n.', "A trancelike state, artificially induced, in which a person has a heightened suggestibility, and in which suppressed memories may be experienced.").
word("hypnosis", 'n.', "The art or skill of hypnotism.").
word("hypnotic", 'adj.', "Inducing sleep; soporific.").
word("hypnotic", 'adj.', "Of, or relating to hypnosis or hypnotism.").
word("hypnotism", 'n.', "The art of inducing hypnosis.").
word("hypnotize", 'v.', "To induce a state of hypnosis in.").
word("hypocrisy", 'n.', "An instance of any or all of the above.").
word("hypocrisy", 'n.', "The claim or pretense of having beliefs, standards, qualities, behaviours, virtues, motivations, etc. which one does not really have.").
word("hypocrite", 'n.', "Someone who practices hypocrisy, who pretends to hold beliefs, or whose actions are not consistent with their claimed beliefs.").
word("hypodermic", 'adj.', "Of, or relating to the hypodermis, the layer beneath the dermis").
word("hypotenuse", 'n.', "The side of a right triangle opposite the right angle.").
word("hypothesis", 'n.', "An assumption taken to be true for the purpose of argument or investigation.").
word("hypothesis", 'n.', "The antecedent of a conditional statement.").
word("hysteria", 'n.', "Any disorder of women with some psychiatric symptoms without other diagnosis, ascribed to uterine influences on the female body, lack of pregnancy, or lack of sex.").
word("hysteria", 'n.', "Behavior exhibiting excessive or uncontrollable emotion, such as fear or panic.").
word("ichthyic", 'adj.', "Of, pertaining to, or like fish; piscine.").
word("ichthyology", 'n.', "The branch of zoology devoted to the study of fish.").
word("icily", 'adv.', "In the manner of ice; with a cold or chilling effect.").
word("icily", 'adv.', "In an uncaring or coolly angry manner.").
word("iciness", 'n.', "The state or quality of being icy or very cold; frigidity.").
word("icon", 'n.', "An image, symbol, picture, or other representation usually as an object of religious devotion.").
word("icon", 'n.', "A person or thing that is the best example of a certain profession or some doing.").
word("iconoclast", 'n.', "One who destroys religious images or icons, especially an opponent of the Orthodox Church in the 8th and 9th centuries, or a Puritan during the European Reformation.").
word("iconoclast", 'n.', "One who attacks cherished beliefs.").
word("idealize", 'v.', "To conceive or form an ideal.").
word("idealize", 'v.', "To regard something as ideal.").
word("idiom", 'n.', "An established phrasal expression whose meaning may not be deducible from the literal meanings of its component words.").
word("idiom", 'n.', "A manner of speaking, a mode of expression peculiar to a language, person, or group of people.").
word("idiosyncrasy", 'n.', "A language or behaviour that is particular to an individual or group.").
word("idiosyncrasy", 'n.', "A peculiar individual reaction to a generally innocuous substance or factor.").
word("idolize", 'v.', "To make an idol of, or to worship as an idol.").
word("idolize", 'v.', "To adore excessively; to revere immoderately.").
word("ignoble", 'adj.', "Not a true or \"noble\" falcon; said of certain hawks, such as the goshawk.").
word("ignoble", 'adj.', "Not honorable; base.").
word("ignominious", 'adj.', "Marked by great dishonor, shame, disgrace or humiliation; shameful, disgraceful").
word("illegal", 'adj.', "Contrary to or forbidden by law, especially criminal law.").
word("illegal", 'adj.', "Totally fictitious, and often issued on behalf of a non-existent territory or country.").
word("illegible", 'adj.', "Not clear enough to be read; unreadable; not legible or decipherable.").
word("illegitimate", 'adj.', "Not conforming to known principles, or established or accepted rules or standards.").
word("illegitimate", 'adj.', "Not sanctioned by marriage.").
word("illiberal", 'adj.', "Ungenerous, stingy.").
word("illiberal", 'adj.', "Narrow-minded; bigoted.").
word("illicit", 'adj.', "Unlawful.").
word("illicit", 'adj.', "Breaking social norms.").
word("illimitable", 'adj.', "Impervious to limitation, without limit.").
word("illiterate", 'adj.', "Having less than an expected standard of familiarity with language and literature, or having little formal education.").
word("illiterate", 'adj.', "Not conforming to prescribed standards of speech or writing.").
word("illogical", 'adj.', "Contrary to logic; lacking sense or sound reasoning.").
word("illuminant", 'n.', "Something that illuminates.").
word("illuminate", 'v.', "To decorate something with lights.").
word("illuminate", 'v.', "To glow; to light up.").
word("illumine", 'v.', "To light up.").
word("illumine", 'v.', "To illuminate (something).").
word("illusion", 'n.', "Anything that seems to be something that it is not.").
word("illusion", 'n.', "A misapprehension; a belief in something that is in fact not true.").
word("illusive", 'adj.', "Subject to or pertaining to an illusion, often used in the sense of an unrealistic expectation or an unreachable goal or outcome.").
word("illusory", 'adj.', "Resulting from an illusion; deceptive, imaginary, unreal").
word("imaginable", 'adj.', "Able to be imagined; conceivable").
word("imaginary", 'adj.', "Existing only in the imagination.").
word("imaginary", 'adj.', "Having no real part; that part of a complex number which is a multiple of \sqrt{-1} (called imaginary unit).").
word("imbibe", 'v.', "To drink (used frequently of alcoholic beverages).").
word("imbibe", 'v.', "To take in; absorb.").
word("imbroglio", 'n.', "A complicated situation; an entanglement.").
word("imbrue", 'v.', "To stain (in, with, blood, slaughter, etc.).").
word("imitation", 'n.', "A copy or simulation; something that is not the real thing.").
word("imitation", 'n.', "The act of imitating.").
word("imitator", 'n.', "A person who imitates or apes another.").
word("immaculate", 'adj.', "Having no blemish or stain; clean, clear, pure, spotless, undefiled.").
word("immaculate", 'adj.', "Lacking blotches, spots, or other markings; spotless, unspotted.").
word("immaterial", 'adj.', "Having no matter or substance.").
word("immaterial", 'adj.', "So insubstantial as to be irrelevant.").
word("immature", 'adj.', "Not fully formed or developed; not grown.").
word("immature", 'adj.', "Occurring before the proper time; untimely, premature (especially of death).").
word("immeasurable", 'adj.', "Impossible to measure").
word("immeasurable", 'adj.', "Vast").
word("immense", 'adj.', "Huge, gigantic, very large.").
word("immense", 'adj.', "Supremely good.").
word("immerse", 'v.', "To involve or engage deeply.").
word("immerse", 'v.', "To place within a fluid (generally a liquid, but also a gas).").
word("immersion", 'n.', "The disappearance of a celestial body, by passing either behind another, as in the occultation of a star, or into its shadow, as in the eclipse of a satellite.").
word("immersion", 'n.', "A form of foreign-language teaching where the language is used intensively to teach other subjects to a student.").
word("immigrant", 'n.', "A non-native person who comes to a country from another country in order to permanently settle there.").
word("immigrant", 'n.', "A plant or animal that establishes itself in an area where it previously did not exist.").
word("immigrate", 'v.', "To move into a foreign country to stay permanently.").
word("imminence", 'n.', "The state or condition of being about to happen; imminent quality.").
word("imminent", 'adj.', "About to happen, occur, or take place very soon, especially of something which won't last long.").
word("immiscible", 'adj.', "Of two or more liquids that are not mutually soluble: unmixable.").
word("immoral", 'adj.', "Not moral; inconsistent with rectitude, purity, or good morals; contrary to conscience or the divine law.").
word("immortalize", 'v.', "To remove the effects of normal apoptosis.").
word("immovable", 'adj.', "Steadfast in purpose or intention; unalterable, unyielding").
word("immovable", 'adj.', "Incapable of being physically moved; fixed").
word("immune", 'adj.', "Exempt; not subject to.").
word("immune", 'adj.', "Not vulnerable.").
word("immutable", 'adj.', "Unable to be changed without exception.").
word("immutable", 'adj.', "Not able to be altered in the memory after its value is set initially.").
word("impair", 'v.', "To grow worse; to deteriorate.").
word("impair", 'v.', "To weaken; to affect negatively; to have a diminishing effect on.").
word("impalpable", 'adj.', "Not able to be perceived by the senses (especially by touch); intangible or insubstantial.").
word("impalpable", 'adj.', "Not easily grasped or understood.").
word("impartial", 'adj.', "Treating all parties, rivals, or disputants equally; not partial; not biased").
word("impassable", 'adj.', "Incapable of being passed over, crossed, or negotiated.").
word("impassable", 'adj.', "Incapable of being overcome or surmounted.").
word("impassible", 'adj.', "Incapable of suffering injury or detriment.").
word("impassible", 'adj.', "Unable to suffer, or feel pain.").
word("impassive", 'adj.', "Having, or revealing, no emotion.").
word("impassive", 'adj.', "Still or motionless.").
word("impatience", 'n.', "The quality of being impatient; lacking patience; restlessness and intolerance of delays; anxiety and eagerness, especially to begin something.").
word("impeccable", 'adj.', "Incapable of wrongdoing or sin; immaculate").
word("impeccable", 'adj.', "Perfect, without faults, flaws or errors").
word("impecunious", 'adj.', "Lacking money").
word("impede", 'v.', "To get in the way of; to hinder.").
word("impel", 'v.', "To urge a person; to press on; to incite to action or motion via intrinsic motivation.").
word("impel", 'v.', "To drive forward; to propel an object, to provide an impetus for motion or action.").
word("impend", 'v.', "To threaten to happen; to be about to happen, to be imminent.").
word("impend", 'v.', "To hang or be suspended (something); to overhang.").
word("imperative", 'adj.', "Expressing a command; authoritatively or absolutely directive.").
word("imperative", 'adj.', "Essential; crucial; extremely important.").
word("imperceptible", 'adj.', "Not perceptible, not detectable, too small in magnitude to be observed").
word("imperfectible", 'adj.', "Incapable of being made perfect.").
word("imperil", 'v.', "To risk or hazard.").
word("imperil", 'v.', "To put into peril; to place in danger.").
word("imperious", 'adj.', "Domineering, arrogant, or overbearing.").
word("imperious", 'adj.', "Urgent.").
word("impermissible", 'adj.', "Not permissible; not to be permitted or allowed").
word("impersonal", 'adj.', "Not having a subject, or having a third person pronoun without an antecedent.").
word("impersonal", 'adj.', "Not personal; not representing a person; not having personality.").
word("impersonate", 'v.', "To pretend to be (a different person); to assume the identity of.").
word("impersonate", 'v.', "To operate with the permissions of a different user account.").
word("impersuadable", 'adj.', "Not to be persuaded; obstinate; unyielding.").
word("impertinence", 'n.', "Insolence; impudence.").
word("impertinence", 'n.', "Lack of pertinence; irrelevance.").
word("imperturbable", 'adj.', "Calm and collected, even under pressure.").
word("imperturbable", 'adj.', "Not easily perturbed, upset or excited.").
word("impervious", 'adj.', "Immune to damage or effect.").
word("impervious", 'adj.', "Unaffected or unable to be affected by something.").
word("impetuosity", 'n.', "Vehemence; furiousness of temper.").
word("impetuosity", 'n.', "The quality of making rash or arbitrary decisions, especially in an impulsive or forceful manner.").
word("impetuous", 'adj.', "Making arbitrary decisions, especially in an impulsive and forceful manner.").
word("impetuous", 'adj.', "Characterized by sudden violence or vehemence.").
word("impetus", 'n.', "The force or energy associated with a moving body; a stimulus.").
word("impetus", 'n.', "An activity in response to a stimulus.").
word("impiety", 'n.', "The lack of respect for a god or something sacred.").
word("impiety", 'n.', "An impious act.").
word("impious", 'adj.', "Lacking reverence or respect, especially towards a god.").
word("impious", 'adj.', "Not pious.").
word("implausible", 'adj.', "Not plausible; unlikely; dubious.").
word("impliable", 'adj.', "Capable of being implied.").
word("impliable", 'adj.', "Not pliable; inflexible; unyielding").
word("implicate", 'v.', "To show to be connected or involved in an unfavorable or criminal way.").
word("implicate", 'v.', "To imply, to have as a necessary consequence or accompaniment.").
word("implicit", 'adj.', "Having no reservations or doubts; unquestioning or unconditional; usually said of faith or trust.").
word("implicit", 'adj.', "Contained in the essential nature of something but not openly shown").
word("imply", 'v.', "To enfold, entangle.").
word("imply", 'v.', "To hint; to insinuate; to suggest tacitly and avoid a direct statement").
word("impolitic", 'adj.', "Not in accordance with good policy.").
word("importation", 'n.', "The act or an instance of carrying or conveying, especially into some system, place, area or country.").
word("importation", 'n.', "The act or an instance of importing.").
word("importunate", 'adj.', "Persistent or pressing, often annoyingly so.").
word("importunate", 'adj.', "Given to importunate demands, greedily or thoughtlessly demanding.").
word("importune", 'v.', "To harass with persistent requests.").
word("importune", 'v.', "To approach to offer one's services as a prostitute, or otherwise make improper proposals.").
word("impotent", 'adj.', "Lacking physical strength or vigor; weak").
word("impotent", 'adj.', "Incapable of sexual intercourse, often because of an inability to achieve or sustain an erection").
word("impoverish", 'v.', "To make poor.").
word("impoverish", 'v.', "To become poor.").
word("impracticable", 'adj.', "Not practicable; impossible or difficult in practice").
word("impracticable", 'adj.', "Unmanageable").
word("impregnable", 'adj.', "Too strong to be defeated or overcome; invincible.").
word("impregnable", 'adj.', "Of a fortress or other fortified place: able to withstand all attacks; impenetrable, inconquerable, unvanquishable.").
word("impregnate", 'v.', "To become pregnant.").
word("impregnate", 'v.', "To cause to become pregnant.").
word("impromptu", 'n.', "Any composition, musical or otherwise, that is created on the spot without preparation.").
word("impromptu", 'n.', "A short musical composition for an informal occasion often with the character of improvisation and usually to be played solo.").
word("improper", 'adj.', "Not specific or appropriate to individuals; general; common.").
word("improper", 'adj.', "Not in keeping with conventional mores or good manners; indecent or immodest").
word("impropriety", 'n.', "The condition of being improper.").
word("impropriety", 'n.', "Improper language.").
word("improvident", 'adj.', "Incautious; prone to rashness").
word("improvident", 'adj.', "Failing to provide for the future; reckless").
word("improvise", 'v.', "To make something up or invent it as one goes on; to proceed guided only by imagination, instinct, and guesswork rather than by a careful plan.").
word("imprudent", 'adj.', "Not prudent; lacking prudence or discretion; indiscreet; injudicious; not paying attention to the consequences of one's actions").
word("impudence", 'n.', "Impudent language, conduct or behavior.").
word("impudence", 'n.', "The quality of being impudent, not showing due respect.").
word("impugn", 'v.', "To assault, attack.").
word("impugn", 'v.', "To verbally assault, especially to argue against an opinion, motive, or action; to question the truth or validity of.").
word("impulsion", 'n.', "The act of impelling or driving onward, or the state of being impelled; the sudden or momentary agency of a body in motion on another body; also, the impelling force, or impulse.").
word("impulsion", 'n.', "Influence acting unexpectedly or temporarily on the mind; sudden motive or influence; impulse.").
word("impulsive", 'adj.', "Having the power of driving or impelling; giving an impulse; moving; impellent.").
word("impulsive", 'adj.', "Actuated by impulse or by transient feelings; inclined to make rapid decisions without due consideration.").
word("impunity", 'n.', "Freedom from punishment or retribution; security from any reprisal or injurious consequences of an action, behaviour etc.").
word("impunity", 'n.', "Exemption from punishment.").
word("impure", 'adj.', "Not pure").
word("impute", 'v.', "To attribute or ascribe (responsibility or fault) to a cause or source.").
word("impute", 'v.', "To attribute or credit to.").
word("inaccessible", 'adj.', "Not able to be accessed; out of reach; inconvenient.").
word("inaccessible", 'adj.', "Not able to be reached; unattainable.").
word("inaccurate", 'adj.', "Mistaken or incorrect; not accurate.").
word("inactive", 'adj.', "Relatively inert.").
word("inactive", 'adj.', "Not active, temporarily or permanently.").
word("inadequate", 'adj.', "Not adequate; not fit for the purpose").
word("inadmissible", 'adj.', "Not admissible, especially that cannot be admitted as evidence at a trial.").
word("inadvertent", 'adj.', "Not intentional; not on purpose; not conscious.").
word("inadvertent", 'adj.', "Inattentive.").
word("inadvisable", 'adj.', "Unwise; not recommended; not prudent; not to be advised").
word("inane", 'adj.', "Lacking sense or meaning (often to the point of boredom or annoyance)").
word("inane", 'adj.', "Purposeless; pointless").
word("inanimate", 'adj.', "Not being, and never having been alive, especially not like humans and animals.").
word("inanimate", 'adj.', "Not animate.").
word("inapprehensible", 'adj.', "That cannot be apprehended; not apprehensible to or graspable by either body or mind.").
word("inapt", 'adj.', "Unapt").
word("inarticulate", 'adj.', "Speechless").
word("inarticulate", 'adj.', "Not articulated in normal words.").
word("inaudible", 'adj.', "Unable to be heard or not loud enough to be heard.").
word("inborn", 'adj.', "Innate, possessed by an organism at birth.").
word("inborn", 'adj.', "Inherited or hereditary.").
word("inbred", 'adj.', "Bred within; innate.").
word("inbred", 'adj.', "Describing a strain produced through successive generations of inbreeding resulting in a population of genetically identical individuals which are homozygous at all genetic loci.").
word("incandescence", 'n.', "The emission of visible light by a hot body").
word("incandescence", 'n.', "The light so emitted").
word("incandescent", 'adj.', "Emitting light as a result of being heated").
word("incandescent", 'adj.', "Showing intense emotion, as of a performance, etc.").
word("incapacitate", 'v.', "To make someone ineligible; to disqualify.").
word("incapacitate", 'v.', "To make someone or something incapable of doing something; to disable.").
word("incapacity", 'n.', "The lack of a capacity; an inability.").
word("incapacity", 'n.', "Legal disqualification.").
word("incarcerate", 'v.', "To lock away; to imprison, especially for breaking the law.").
word("incarcerate", 'v.', "To confine; to shut up or enclose; to hem in.").
word("incendiary", 'n.', "One who excites or inflames factions into quarrels.").
word("incendiary", 'n.', "One who maliciously sets fires.").
word("incentive", 'n.', "Something that motivates, rouses, or encourages.").
word("incentive", 'n.', "A bonus or reward, often monetary, to work harder.").
word("inception", 'n.', "The creation or beginning of something; the establishment.").
word("inception", 'n.', "A layering, nesting or recursion of something.").
word("inceptive", 'adj.', "Aspectually inflected to show that the action is beginning.").
word("inceptive", 'adj.', "Beginning; of or relating to inception.").
word("incessant", 'adj.', "Without pause or stop; not ending, especially to the point of annoyance.").
word("inchmeal", 'adv.', "Gradually, little by little (an inch at a time)").
word("inchoate", 'adj.', "Chaotic, disordered, confused; also, incoherent, rambling.").
word("inchoate", 'adj.', "Recently started but not fully formed yet; just begun; only elementary or immature.").
word("inchoative", 'n.', "An inchoative construction.").
word("incidence", 'n.', "The act of something happening; occurrence.").
word("incidence", 'n.', "A measure of the rate of new occurrence of a given medical condition in a population within a specified period of time.").
word("incident", 'n.', "An event that causes or may cause an interruption or a crisis, such as a workplace illness or a software error.").
word("incident", 'n.', "An event or occurrence.").
word("incidentally", 'adv.', "By chance; in an unplanned way.").
word("incidentally", 'adv.', "Parenthetically, by the way.").
word("incinerate", 'v.', "To destroy by burning").
word("incipience", 'n.', "A beginning, or first stage.").
word("incipient", 'adj.', "In an initial stage; beginning, starting, coming into existence.").
word("incisor", 'n.', "A narrow-edged tooth at the front of the mouth of mammals, between the canines and adapted for cutting; in humans there are four in each jaw.").
word("incite", 'v.', "To stir up or excite; to rouse or goad into action.").
word("incitement", 'n.', "A call to act; encouragement to act, often in an illegal fashion.").
word("incoercible", 'adj.', "Not to be coerced; incapable of being compelled or forced.").
word("incoercible", 'adj.', "Not capable of being reduced to liquid form by pressure.").
word("incoherence", 'n.', "Thinking or speech that is so disorganized that it is essentially inapprehensible to others.").
word("incoherence", 'n.', "Something incoherent; something that does not make logical sense or is not logically connected.").
word("incoherent", 'adj.', "Not coherent.").
word("incombustible", 'adj.', "Not capable of catching fire and burning; not flammable.").
word("incomparable", 'adj.', "So much better than another as to be beyond comparison; matchless or unsurpassed.").
word("incomparable", 'adj.', "Not able to be compared.").
word("incompatible", 'adj.', "Of two things: that cannot coexist; not congruous because of differences; unable to function together due to dissimilarities.").
word("incompatible", 'adj.', "Incapable of being together without mutual reaction or decomposition, as certain medicines.").
word("incompetence", 'n.', "Inability to perform; lack of competence; ineptitude.").
word("incompetent", 'adj.', "Unskilled; lacking the degree of ability that would normally be expected.").
word("incompetent", 'adj.', "Not resistant to deformation or flow.").
word("incomplete", 'adj.', "Of a flower, wanting any of the usual floral organs.").
word("incomplete", 'adj.', "Not complete; not finished").
word("incomprehensible", 'adj.', "Impossible or very difficult to understand.").
word("incompressible", 'adj.', "Having a divergence equal to zero.").
word("incompressible", 'adj.', "Not compressible.").
word("inconceivable", 'adj.', "Unable to be conceived or imagined; unbelievable.").
word("incongruous", 'adj.', "Of two numbers, with respect to a third, such that their difference can not be divided by it without a remainder.").
word("incongruous", 'adj.', "Not similar or congruent; not matching or fitting in.").
word("inconsequential", 'adj.', "Having no consequence; not consequential; of little importance.").
word("inconsequential", 'adj.', "Not logically following from the premises.").
word("inconsiderable", 'adj.', "Too unimportant to be worthy of attention.").
word("inconsistent", 'adj.', "Not consistent:").
word("inconstant", 'adj.', "Not constant; wavering.").
word("inconstant", 'adj.', "Unfaithful to a lover.").
word("incontrovertible", 'adj.', "Not capable of being denied, challenged, or disputed; closed to questioning.").
word("inconvenient", 'adj.', "Not convenient").
word("indefensible", 'adj.', "Incapable of being explained").
word("indefensible", 'adj.', "Incapable of being justified or excused").
word("indefinitely", 'adv.', "In a manner that is not definite.").
word("indefinitely", 'adv.', "For a long time, with no defined end.").
word("indelible", 'adj.', "Having the quality of being difficult to delete, remove, wash away, blot out, or efface.").
word("indelible", 'adj.', "Incapable of being canceled, lost, or forgotten.").
word("indescribable", 'adj.', "Exceeding all description.").
word("indescribable", 'adj.', "Impossible (or very difficult) to describe.").
word("indestructible", 'adj.', "Not destructible; incapable of decomposition or of being destroyed; invincible.").
word("indicant", 'adj.', "Serving to point out, as a remedy; indicating.").
word("indicator", 'n.', "The needle or dial on such a meter.").
word("indicator", 'n.', "A measure, such as unemployment rate, which can be used to predict economic trends.").
word("indict", 'v.', "To accuse of wrongdoing; charge.").
word("indict", 'v.', "To make a formal accusation or indictment for a crime against (a party) by the findings of a jury, especially a grand jury.").
word("indigence", 'n.', "Extreme poverty or destitution").
word("indigenous", 'adj.', "Born or originating in, native to a land or region, especially before an intrusion.").
word("indigenous", 'adj.', "Innate, inborn.").
word("indigent", 'adj.', "Poor; destitute; in need.").
word("indigent", 'adj.', "Utterly lacking or in need of something specified.").
word("indigestible", 'adj.', "Difficult or impossible to digest.").
word("indigestible", 'adj.', "Difficult to accept; unpalatable.").
word("indigestion", 'n.', "A condition of heartburn, nausea, etc. most often caused by eating too quickly.").
word("indignant", 'adj.', "Showing anger or indignation, especially at something unjust or wrong.").
word("indignity", 'n.', "Degradation, debasement or humiliation").
word("indignity", 'n.', "An affront to one's dignity or pride").
word("indiscernible", 'adj.', "Not capable of being discerned, of being perceived.").
word("indiscernible", 'adj.', "Not capable of being distinguished from something else.").
word("indiscreet", 'adj.', "Not discreet; lacking in discretion.").
word("indiscriminate", 'adj.', "Without care or making distinctions, thoughtless.").
word("indispensable", 'adj.', "Absolutely necessary or requisite; that one cannot do without.").
word("indispensable", 'adj.', "Not admitting ecclesiastical dispensation; not subject to release or exemption; that cannot be allowed by bending the canonical rules.").
word("indistinct", 'adj.', "Hazy or vague").
word("indistinct", 'adj.', "Not clearly defined or not having a sharp outline; faint or dim").
word("indivertible", 'adj.', "Not to be diverted or turned aside.").
word("indivisible", 'adj.', "Incapable of being divided; atomic.").
word("indivisible", 'adj.', "Incapable of being divided by a specific integer without leaving a remainder.").
word("indolence", 'n.', "Habitual laziness or sloth.").
word("indolent", 'adj.', "Habitually lazy, procrastinating, or resistant to physical labor").
word("indolent", 'adj.', "Causing little or no physical pain; progressing slowly; inactive (of an ulcer, etc.)").
word("indomitable", 'adj.', "Incapable of being subdued, overcome, or vanquished.").
word("induct", 'v.', "To bring in as a member; to make a part of.").
word("induct", 'v.', "To introduce; to bring in.").
word("indulgence", 'n.', "A pardon or release from the expectation of punishment in purgatory, after the sinner has been granted absolution.").
word("indulgence", 'n.', "Catering to someone's every desire").
word("indulgent", 'adj.', "Disposed or prone to indulge, humor, gratify, or yield to one's own or another's desires, etc., or to be compliant, lenient, or forbearing;").
word("inebriate", 'v.', "To cause to be drunk; to intoxicate.").
word("inebriate", 'v.', "To become drunk.").
word("inedible", 'adj.', "Not edible; not appropriate, worthy, or safe to eat").
word("ineffable", 'adj.', "Beyond expression in words; unspeakable.").
word("ineffable", 'adj.', "Forbidden to be uttered; taboo.").
word("inefficiency", 'n.', "Lack of efficiency or effectiveness.").
word("inefficient", 'adj.', "Incapable of, or indisposed to, effective action; habitually slack or unproductive; effecting little or nothing").
word("inefficient", 'adj.', "Not efficient; not producing the effect intended or desired; inefficacious").
word("ineligible", 'adj.', "Not eligible; forbidden to do something.").
word("inept", 'adj.', "Not able to do something; not proficient; displaying incompetence.").
word("inept", 'adj.', "Unfit; unsuitable.").
word("inert", 'adj.', "Unable to move or act; inanimate.").
word("inert", 'adj.', "Having no therapeutic action.").
word("inestimable", 'adj.', "Not able to be estimated; not able to be calculated, computed or comprehended, as because of great scale, degree or magnitude.").
word("inevitable", 'adj.', "Impossible to avoid or prevent.").
word("inevitable", 'adj.', "Predictable, or always happening.").
word("inexcusable", 'adj.', "Not excusable").
word("inexhaustible", 'adj.', "Impossible to exhaust; unlimited.").
word("inexorable", 'adj.', "Unable to be persuaded; relentless; unrelenting.").
word("inexorable", 'adj.', "Adamant; severe.").
word("inexpedient", 'adj.', "Not expedient; not tending to promote a purpose; not tending to the end desired; unsuitable to time and place").
word("inexpensive", 'adj.', "Low in price").
word("inexperience", 'n.', "A lack of experience.").
word("inexplicable", 'adj.', "Impossible to explain; not easily accounted for.").
word("inexpressible", 'adj.', "Unable to be expressed; not able to be put into words.").
word("inextensible", 'adj.', "Not capable of being extended.").
word("infallible", 'adj.', "Without fault or weakness; incapable of error or fallacy.").
word("infallible", 'adj.', "Certain to produce the intended effect, sure.").
word("infamous", 'adj.', "Having a bad reputation; disreputable; notorious; unpleasant or evil; widely known, especially for something scornful.").
word("infamous", 'adj.', "Subject to a judicial punishment that deprived the infamous person of certain rights; this included a prohibition against holding public office, exercising the franchise, receiving a public pension, serving on a jury, or giving testimony in a court of law.").
word("infamy", 'n.', "A reprehensible occurrence or situation.").
word("infamy", 'n.', "A reputation as being evil.").
word("inference", 'n.', "That which is inferred; a truth or proposition drawn from another which is admitted or supposed to be true; a conclusion; a deduction.").
word("inference", 'n.', "The act or process of inferring by deduction or induction.").
word("infernal", 'adj.', "Of or relating to hell, or the world of the dead; hellish.").
word("infernal", 'adj.', "Diabolical or fiendish.").
word("infest", 'v.', "To invade a host plant or animal.").
word("infest", 'v.', "To inhabit a place in unpleasantly large numbers; to plague, harass.").
word("infidel", 'n.', "One who does not believe in a certain principle.").
word("infidel", 'n.', "One who does not believe in a certain religion.").
word("infidelity", 'n.', "Lack of religious belief.").
word("infidelity", 'n.', "Unfaithfulness in a marriage or an intimate relationship: practice or instance of having a sexual or romantic affair with someone other than one's spouse, without the consent of the spouse.").
word("infinite", 'adj.', "Indefinably large, countlessly great; immense.").
word("infinite", 'adj.', "Boundless, endless, without end or limits; innumerable.").
word("infinity", 'n.', "An idealised point which is said to be approached by sequences of values whose magnitudes increase without bound.").
word("infinity", 'n.', "Endlessness, unlimitedness, absence of a beginning, end or limits to size.").
word("infirm", 'adj.', "Weak or ill, not in good health.").
word("infirm", 'adj.', "Irresolute; weak of mind or will.").
word("infirmary", 'n.', "A place where sick or injured people are cared for, especially a small hospital; sickhouse.").
word("infirmary", 'n.', "A clinic or dispensary within another institution.").
word("infirmity", 'n.', "A moral weakness or defect").
word("infirmity", 'n.', "Feebleness, frailty or ailment, especially due to old age.").
word("inflammable", 'adj.', "Capable of burning; easily set on fire.").
word("inflammable", 'adj.', "Incapable of burning; not easily set on fire.").
word("inflammation", 'n.', "A condition of any part of the body, consisting of congestion of the blood vessels, with obstruction of the blood current, and growth of morbid tissue. It is manifested outwardly by redness and swelling, attended with heat and pain.").
word("inflammation", 'n.', "The act of inflaming, kindling, or setting on fire.").
word("inflexible", 'adj.', "Not flexible; not capable of bending or being bent.").
word("inflexible", 'adj.', "Not able to be changed or adapted to circumstances.").
word("influence", 'n.', "An action exerted by a person or thing with such power on another to cause change.").
word("influence", 'n.', "The power to affect, control or manipulate something or someone; the ability to change the development of fluctuating things such as conduct, thoughts or decisions.").
word("influential", 'adj.', "Having or exerting influence.").
word("influx", 'n.', "A flow inward or into something; a coming in.").
word("influx", 'n.', "That which flows or comes in.").
word("infrequent", 'adj.', "Not frequent; not happening frequently.").
word("infringe", 'v.', "Break or violate a treaty, a law, a right etc.").
word("infringe", 'v.', "Break in or encroach on something.").
word("infuse", 'v.', "To pour in, as a liquid; to pour (into or upon); to shed.").
word("infuse", 'v.', "To instill as a quality.").
word("infusion", 'n.', "The act of installing a quality into a person.").
word("infusion", 'n.', "The act of steeping or soaking a substance in liquid so as to extract medicinal or herbal qualities.").
word("ingenious", 'adj.', "Characterized by genius; cleverly done or contrived.").
word("ingenious", 'adj.', "Witty; showing originality or sagacity").
word("ingenuity", 'n.', "The ability to solve difficult problems, often in original, clever, and inventive ways.").
word("ingenuity", 'n.', "Ingenuousness; honesty, straightforwardness").
word("ingenuous", 'adj.', "Straightforward, candid, open, and frank.").
word("ingenuous", 'adj.', "Unable to mask one's feelings.").
word("inglorious", 'adj.', "Not famous; obscure.").
word("inglorious", 'adj.', "Ignominious; disgraceful.").
word("ingratiate", 'v.', "To bring oneself into favour with someone by flattering or trying to please him or her.").
word("ingratiate", 'v.', "}} To recommend; to render easy or agreeable.").
word("ingratitude", 'n.', "A lack or absence of gratitude; thanklessness.").
word("ingredient", 'n.', "One of the substances present in a mixture, especially food.").
word("inherence", 'n.', "The state of being inherent or permanently present in something; indwelling.").
word("inherent", 'adj.', "Naturally as part or consequence of something.").
word("inhibit", 'v.', "To hold in or hold back; to keep in check; restrain.").
word("inhibit", 'v.', "To recuse.").
word("inhospitable", 'adj.', "Not inclined to hospitality; unfriendly.").
word("inhospitable", 'adj.', "Not offering shelter; barren or forbidding.").
word("inhuman", 'adj.', "Transcending or different than what is human.").
word("inhuman", 'adj.', "Of or pertaining to inhumanity and the indifferently cruel, sadistic or barbaric behavior it brings.").
word("inhume", 'v.', "To bury in a grave.").
word("inimical", 'adj.', "Harmful in effect.").
word("inimical", 'adj.', "Unfriendly, hostile.").
word("iniquity", 'n.', "An act of great injustice or unfairness; a sinful or wicked act; an unconscionable deed.").
word("iniquity", 'n.', "Deviation from what is right; gross injustice, sin, wickedness.").
word("initiate", 'v.', "To confer membership on; especially, to admit to a secret order with mysterious rites or ceremonies.").
word("initiate", 'v.', "To instruct in the rudiments or principles; to introduce.").
word("inject", 'v.', "To introduce (code) into an existing program or its memory space, often without tight integration and sometimes through a security vulnerability.").
word("inject", 'v.', "To introduce (something) suddenly or violently.").
word("injunction", 'n.', "That which is enjoined; such as an order, mandate, decree, command, precept").
word("injunction", 'n.', "The act of enjoining; the act of directing, commanding, or prohibiting.").
word("inkling", 'n.', "Often preceded by forms of 'to get' or 'to have': an imprecise idea or slight knowledge of something; a suspicion.").
word("inkling", 'n.', "Usually preceded by forms of 'to give': a slight hint, implication, or suggestion given.").
word("inland", 'adj.', "Within the land; relatively remote from the ocean or from open water; interior.").
word("inland", 'adj.', "Confined to a country or state; domestic; not foreign.").
word("inlet", 'n.', "A body of water let into a coast, such as a bay, cove, fjord or estuary.").
word("inlet", 'n.', "A passage that leads into a cavity.").
word("inmost", 'adj.', "The very deepest within; farthest from the surface or external part; innermost").
word("innocuous", 'adj.', "Harmless; producing no ill effect.").
word("innocuous", 'adj.', "Inoffensive; unprovocative; not exceptional.").
word("innovate", 'v.', "To introduce something new to a particular environment; to do something new.").
word("innovate", 'v.', "To introduce (something) as new.").
word("innuendo", 'n.', "A derogatory hint or reference to a person or thing. An implication, intimation or insinuation.").
word("innuendo", 'n.', "Part of a pleading in cases of libel and slander, pointing out what and who was meant by the libellous matter or description.").
word("innumerable", 'adj.', "Not capable of being counted, enumerated, or numbered, hence, indefinitely numerous; of great number.").
word("inoffensive", 'adj.', "Not offensive").
word("inoffensive", 'adj.', "Harmless").
word("inopportune", 'adj.', "Happening/occurring at an inconvenient or inappropriate time.").
word("inopportune", 'adj.', "Unsuitable for some particular purpose.").
word("inquire", 'v.', "To ask (about something).").
word("inquire", 'v.', "To call; to name.").
word("inquisition", 'n.', "An investigation or inquiry into the truth of some matter").
word("inquisition", 'n.', "The finding of a jury, especially such a finding under a writ of inquiry.").
word("inquisitive", 'adj.', "Too curious; overly interested; nosy.").
word("inquisitive", 'adj.', "Eager to acquire knowledge.").
word("inquisitor", 'n.', "A person who inquires, especially searchingly or ruthlessly.").
word("inquisitor", 'n.', "An official of the ecclesiastical court of the Inquisition.").
word("inroad", 'n.', "Often followed by 'in', 'into', or 'on': initial progress made toward accomplishing a goal or solving a problem.").
word("inroad", 'n.', "An advance into enemy territory, an attempted invasion; an encroachment, an incursion.").
word("insatiable", 'adj.', "Not satiable; incapable of being satisfied or appeased; very greedy").
word("inscribe", 'v.', "To write or cut (words) onto (something, especially a hard surface, or a book to be given to another person); to engrave.").
word("inscribe", 'v.', "To draw a circle, sphere, etc. inside a polygon, polyhedron, etc. and tangent to all its sides.").
word("inscrutable", 'adj.', "Difficult or impossible to comprehend, fathom or interpret.").
word("insecure", 'adj.', "Not comfortable or confident in oneself or in certain situations.").
word("insecure", 'adj.', "Not secure.").
word("insensible", 'adj.', "Incapable of emotional feeling; callous; apathetic.").
word("insensible", 'adj.', "Incapable of mental feeling; indifferent.").
word("insentient", 'adj.', "Having no consciousness or animation; not sentient.").
word("insentient", 'adj.', "Insensitive, indifferent.").
word("inseparable", 'adj.', "Unable to be separated; bound together permanently.").
word("insidious", 'adj.', "Intending to entrap; alluring but harmful.").
word("insidious", 'adj.', "Producing harm in a stealthy, often gradual, manner.").
word("insight", 'n.', "An extended understanding of a subject resulting from identification of relationships and behaviors within a model, context, or scenario.").
word("insight", 'n.', "A sight or view of the interior of anything; a deep inspection or view; introspection; frequently used with into.").
word("insignificance", 'n.', "The state of being insignificant").
word("insignificant", 'adj.', "Not significant; not important, inconsequential, or having no noticeable effect.").
word("insignificant", 'adj.', "Without meaning; not signifying anything.").
word("insinuate", 'v.', "To creep, wind, or flow into; to enter gently, slowly, or imperceptibly, as into crevices.").
word("insinuate", 'v.', "To hint; to suggest tacitly (usually something bad) while avoiding a direct statement.").
word("insipid", 'adj.', "Flat; lacking character or definition.").
word("insipid", 'adj.', "Unappetizingly flavorless.").
word("insistence", 'n.', "An urgent demand.").
word("insistence", 'n.', "The forcing of an attack through the parry, using strength.").
word("insistent", 'adj.', "Urgent in dwelling upon anything; persistent in urging or maintaining.").
word("insistent", 'adj.', "Extorting attention or notice; coercively staring or prominent; vivid; intense.").
word("insolence", 'n.', "Arrogant conduct; insulting, bold behaviour or attitude.").
word("insolence", 'n.', "The quality of being unusual or novel.").
word("insolent", 'adj.', "Insulting in manner or words, particularly in an arrogant or insubordinate manner.").
word("insolent", 'adj.', "Rude.").
word("insomnia", 'n.', "A sleeping disorder that is known for its symptoms of unrest and the inability to sleep.").
word("inspector", 'n.', "A police officer ranking below superintendent.").
word("inspector", 'n.', "A software tool used to examine something.").
word("instance", 'n.', "A case offered as an exemplification or a precedent; an illustrative example.").
word("instance", 'n.', "A dungeon or other area that is duplicated for each player, or each party of players, that enters it, so that each player or party has a private copy of the area, isolated from other players.").
word("instant", 'n.', "A very short period of time; a moment.").
word("instant", 'n.', "A single, usually precise, point in time.").
word("instantaneous", 'adj.', "Occurring, arising, or functioning without any delay; happening within an imperceptibly brief period of time.").
word("instigate", 'v.', "To goad or urge (a person) forward, especially to wicked actions; to provoke").
word("instigate", 'v.', "To incite; to bring about by urging or encouraging").
word("instigator", 'n.', "A person who intentionally instigates, incites, or starts something, especially one that creates trouble.").
word("instill", 'v.', "To cause a quality to become part of someone's nature.").
word("instill", 'v.', "To pour in (medicine, for example) drop by drop.").
word("instructive", 'adj.', "Conveying knowledge, information or instruction.").
word("insufficiency", 'n.', "The lack of sufficiency; a shortage or inadequacy.").
word("insufficient", 'adj.', "Not sufficient; of a type or kind that does not suffice, that does not satisfy requirements or needs.").
word("insufficient", 'adj.', "Not sufficient; lacking competent power or ability; unqualified, unequal, unfit.").
word("insular", 'adj.', "Of, pertaining to, being, or resembling an island or islands.").
word("insular", 'adj.', "Situated on an island.").
word("insulate", 'v.', "To separate, detach, or isolate.").
word("insulate", 'v.', "To separate a body or material from others, e.g. by non-conductors to prevent the transfer of electricity, heat, etc.").
word("insuperable", 'adj.', "Impossible to achieve or overcome or be negotiated.").
word("insuperable", 'adj.', "Overwhelming or insurmountable.").
word("insuppressible", 'adj.', "That cannot be suppressed.").
word("insurgence", 'n.', "An uprising or rebellion; an insurrection.").
word("insurgent", 'n.', "One of several people who take up arms against the local state authority; a participant in insurgency.").
word("insurrection", 'n.', "The action of part or all of a national population violently rising up against the government or other authority; an instance of this; a revolt, an uprising; specifically, one that is at an initial stage or limited in nature.").
word("intangible", 'adj.', "Incapable of being perceived by the senses; incorporeal.").
word("integrity", 'n.', "Steadfast adherence to a strict moral or ethical code.").
word("integrity", 'n.', "The quality or condition of being complete; pure").
word("intellect", 'n.', "The capacity of that faculty (in a particular person).").
word("intellect", 'n.', "The faculty of thinking, judging, abstract reasoning, and conceptual understanding; the cognitive faculty.").
word("intellectual", 'adj.', "Endowed with intellect; having a keen sense of understanding; having the capacity for higher forms of knowledge or thought; characterized by intelligence or cleverness").
word("intellectual", 'adj.', "Relating to the understanding; treating of the mind.").
word("intelligence", 'n.', "Capacity of mind, especially to understand principles, truths, facts or meanings, acquire knowledge, and apply it to practice; the ability to comprehend and learn.").
word("intelligence", 'n.', "A political or military department, agency or unit designed to gather information, usually secret, about the enemy or about hostile activities.").
word("intelligible", 'adj.', "Capable of being understood; clear to the mind.").
word("intemperance", 'n.', "Lack of moderation or temperance; excess.").
word("intemperance", 'n.', "Drunkenness or gluttony.").
word("intension", 'n.', "A straining, stretching, or bending; the state of being strained.").
word("intension", 'n.', "Any property or quality connoted by a word, phrase or other symbol, contrasted with actual instances in the real world to which the term applies.").
word("intensive", 'adj.', "Serving to give force or emphasis.").
word("intensive", 'adj.', "Demanding; requiring a great amount of work etc.").
word("intention", 'n.', "The goal or purpose behind a specific action or set of actions.").
word("intention", 'n.', "The object toward which the thoughts are directed; end; aim.").
word("interact", 'v.', "To act upon each other.").
word("intercede", 'v.', "To act as a mediator in a dispute; to arbitrate or mediate.").
word("intercede", 'v.', "To pass between; to intervene.").
word("intercept", 'v.', "To gain possession of (the ball) in a ball game").
word("intercept", 'v.', "An aeronautical action in which a fighter approaches a suspicious aircraft to escort it away from a prohibited area, or approaches an enemy aircraft to shoot it down.").
word("intercession", 'n.', "A prayer to God on behalf of another person.").
word("intercession", 'n.', "The act of intervening or mediating between two parties.").
word("intercessor", 'n.', "A bishop who acts during a vacancy in a see.").
word("intercessor", 'n.', "A middleman, intermediary").
word("interdict", 'n.', "A papal decree prohibiting the administration of the sacraments from a political entity under the power of a single person (e.g., a king or an oligarchy with similar powers). Extreme unction/Anointing of the Sick is excepted.").
word("interdict", 'n.', "An injunction.").
word("interim", 'n.', "A transitional or temporary period between other events.").
word("interlocutor", 'n.', "A person who takes part in dialogue or conversation.").
word("interlocutor", 'n.', "A man in the middle of the line in a minstrel show who questions the end men and acts as leader.").
word("interlude", 'n.', "An entertainment between the acts of a play.").
word("interlude", 'n.', "A short piece put between the parts of a longer composition.").
word("intermediate", 'adj.', "Being between two extremes, or in the middle of a range.").
word("interminable", 'adj.', "Existing or occurring without interruption or end; ceaseless, unending.").
word("intermission", 'n.', "A break between two performances or sessions, such as at a concert, play, seminar, or religious assembly.").
word("intermit", 'v.', "To interrupt, to stop or cease temporarily or periodically; to suspend.").
word("intermittent", 'adj.', "Stopping and starting, occuring, or presenting at intervals; coming after a particular time span.").
word("intermittent", 'adj.', "Existing only for certain seasons; that is, being dry for part of the year.").
word("interpolation", 'n.', "The process of estimating the value of a function at a point from its values at nearby points.").
word("interpolation", 'n.', "That which is introduced or inserted; in contexts of of centuries-old texts, especially something foreign or spurious.").
word("interpose", 'v.', "To insert something (or oneself) between other things.").
word("interpose", 'v.', "To be inserted between parts or things; to come between.").
word("interposition", 'n.', "The act of interposing, or the state of being interposed; a being, placing, or coming between; mediation.").
word("interposition", 'n.', "The thing interposed.").
word("interpreter", 'n.', "One who conveys what a user of one language is saying or signing, in real time or shortly after that person has finished communicating, to a user of a different language.").
word("interpreter", 'n.', "A program that executes another program written in a high-level language by reading the instructions in real time rather than by compiling it in advance.").
word("interrogate", 'v.', "To question or quiz, especially in a thorough and/or aggressive manner").
word("interrogate", 'v.', "To examine critically.").
word("interrogative", 'adj.', "Pertaining to inquiry; questioning").
word("interrogative", 'adj.', "Asking or denoting a question: as, an interrogative phrase, pronoun, or point.").
word("interrogatory", 'n.', "A formal question submitted to opposing party to answer, generally governed by court rule.").
word("interrogatory", 'n.', "A question; an interrogation.").
word("interrupt", 'v.', "To divide; to separate; to break the monotony of.").
word("interrupt", 'v.', "To assert to (a computer) that an exceptional condition must be handled.").
word("intersect", 'v.', "To cut into or between; to cut or cross mutually; to divide into parts.").
word("intersect", 'v.', "Of two sets, to have at least one element in common.").
word("intervale", 'n.', "An alluvial terrace or plain.").
word("intervene", 'v.', "To say (something) in the middle of a conversation or discussion between other people, or to respond to a situation involving other people.").
word("intervene", 'v.', "To come between, or to be between, persons or things.").
word("intestacy", 'n.', "The state of being intestate, or of dying without having made a valid will.").
word("intestate", 'adj.', "Without a valid will indicating whom to leave one's estate to after death.").
word("intestate", 'adj.', "Not devised or bequeathed; not disposed of by will.").
word("intestine", 'n.', "The alimentary canal of an animal through which food passes after having passed all stomachs.").
word("intestine", 'n.', "One of certain subdivisions of this part of the alimentary canal, such as the small or large intestine in human beings.").
word("intimacy", 'n.', "Feeling or atmosphere of closeness and openness towards someone else, not necessarily involving sexuality.").
word("intimacy", 'n.', "Intimate detail, (item of) intimate information.").
word("intimidate", 'v.', "To make timid or afraid; to cause to feel fear or nervousness; to deter, especially by threats of violence").
word("intolerable", 'adj.', "Extremely offensive or insulting.").
word("intolerable", 'adj.', "Not tolerable; not capable of being borne or endured").
word("intolerance", 'n.', "Extreme sensitivity to a food or drug; allergy.").
word("intolerance", 'n.', "The state of being intolerant.").
word("intolerant", 'adj.', "Not tolerant; close-minded about new or different ideas; indisposed to tolerate contrary opinions or beliefs; impatient of dissent or opposition; denying or refusing the right of private opinion or choice in others; inclined to persecute or suppress dissent.").
word("intolerant", 'adj.', "Unable or indisposed to tolerate, endure or bear.").
word("intoxicant", 'n.', "Poison.").
word("intoxicant", 'n.', "Something which intoxicates; an intoxicating agent").
word("intoxicate", 'v.', "To excite to enthusiasm or madness.").
word("intoxicate", 'v.', "To stupefy by doping with chemical substances such as alcohol.").
word("intracellular", 'adj.', "Inside or within a cell.").
word("intramural", 'adj.', "Within the substance of the walls of an organ.").
word("intramural", 'adj.', "Within the walls; within one institution, particularly a school.").
word("intrepid", 'adj.', "Fearless; bold; brave.").
word("intricacy", 'n.', "Perplexity").
word("intricacy", 'n.', "Something which is intricate or complex.").
word("intricate", 'adj.', "Having a great deal of fine detail or complexity.").
word("intrigue", 'n.', "A complicated or clandestine plot or scheme intended to effect some purpose by secret artifice; conspiracy; stratagem.").
word("intrigue", 'n.', "Clandestine intercourse between persons; illicit intimacy; a liaison or affair.").
word("intrinsic", 'adj.', "Innate, inherent, inseparable from the thing itself, essential.").
word("intrinsic", 'adj.', "Situated, produced, secreted in, or coming from inside an organ, tissue, muscle or member.").
word("introductory", 'adj.', "Introducing; giving a preview or idea of.").
word("introgression", 'n.', "The movement of a gene from one species to another.").
word("intromit", 'v.', "To intermeddle with the effects or goods of another.").
word("intromit", 'v.', "To allow to pass in; to admit.").
word("introspect", 'v.', "To look into.").
word("introspect", 'v.', "To engage in introspection.").
word("introspection", 'n.', "A looking inward; specifically, the act or process of self-examination, or inspection of one's own thoughts and feelings; the cognition which the mind has of its own acts and states").
word("introversion", 'n.', "A turning inward, particularly:").
word("introvert", 'v.', "To turn inwards.").
word("intrude", 'v.', "To thrust oneself in; to come or enter without invitation, permission, or welcome; to encroach; to trespass.").
word("intrude", 'v.', "To force in.").
word("intrusion", 'n.', "Magma forced into other rock formations; the rock formed when such magma solidifies.").
word("intrusion", 'n.', "A structure that lies within a historic district but is nonhistoric and irrelevant to the district.").
word("intuition", 'n.', "A perceptive insight gained by the use of this faculty.").
word("intuition", 'n.', "Immediate cognition without the use of conscious rational processes.").
word("inundate", 'v.', "To cover with large amounts of water; to flood.").
word("inundate", 'v.', "To overwhelm.").
word("inundation", 'n.', "An overflowing or superfluous abundance; a flood; a great influx").
word("inundation", 'n.', "The act of inundating; an overflow; a flood; a rising and spreading of water over grounds.").
word("inure", 'v.', "To take effect, to be operative.").
word("inure", 'v.', "To cause someone to become accustomed to something that requires prolonged or repeated tolerance of one or more unpleasantries.").
word("invalid", 'adj.', "Not valid; not true, correct, acceptable or appropriate.").
word("invalid", 'adj.', "Suffering from disability or illness.").
word("invalid", 'n.', "A person who is confined to home or bed because of illness, disability or injury; one who is too sick or weak to care for themselves.").
word("invalid", 'n.', "A disabled member of the armed forces; one unfit for active duty due to injury.").
word("invalidate", 'v.', "To make or declare (an argument, statement, or theory) unsound or erroneous; disprove.").
word("invalidate", 'v.', "To make invalid. Especially applied to contract law.").
word("invaluable", 'adj.', "Of great value; costly, precious, priceless.").
word("invaluable", 'adj.', "Beyond calculable or appraisable value; of inestimable worth").
word("invariable", 'adj.', "Not variable; unalterable; uniform; always having the same value.").
word("invariable", 'adj.', "That cannot undergo inflection, conjugation or declension.").
word("invasion", 'n.', "A military action consisting of armed forces of one geopolitical entity entering territory controlled by another such entity, generally with the objective of conquering territory or altering the established government.").
word("invasion", 'n.', "The spread of cancer cells, bacteries and such to the organism.").
word("invective", 'n.', "Something spoken or written, intended to cast shame, disgrace, censure, or reproach on another.").
word("invective", 'n.', "A harsh or reproachful accusation.").
word("inveigh", 'v.', "Or occasionally , formerly also with , , }} To complain loudly, to give voice to one's censure or criticism").
word("inveigh", 'v.', "To draw in or away; to entice, inveigle.").
word("inventive", 'adj.', "Purposefully fictive").
word("inventive", 'adj.', "Of, or relating to invention; pertaining to the act of devising new mechanisms or processes.").
word("inverse", 'adj.', "Opposite in effect, nature or order.").
word("inverse", 'adj.', "Reverse, opposite in order.").
word("inversion", 'n.', "Deviation from standard word order by putting the predicate before the subject. It takes place in questions with auxiliary verbs and in normal, affirmative clauses beginning with a negative particle, for the purpose of emphasis.").
word("inversion", 'n.', "The flipping of a melody or contrapuntal line so that high notes become low and vice versa; the reversal of a pitch contour.").
word("invert", 'v.', "To turn (something) upside down or inside out; to place in a contrary order or direction.").
word("invert", 'v.', "To move (the root note of a chord) up or down an octave, resulting in a change in pitch.").
word("investigator", 'n.', "One who investigates.").
word("investor", 'n.', "A person who invests money in order to make a profit.").
word("inveterate", 'adj.', "Having had a habit for a long time").
word("inveterate", 'adj.', "Firmly established from having been around for a long time; of long standing").
word("invidious", 'adj.', "Causing ill will, envy, or offense.").
word("invidious", 'adj.', "Envious, jealous.").
word("invigorate", 'v.', "To heighten or intensify.").
word("invigorate", 'v.', "To give life or energy to.").
word("invincible", 'adj.', "Impossible to defeat, destroy or kill; too powerful to be defeated or overcome.").
word("inviolable", 'adj.', "Incapable of being injured or invaded; indestructible.").
word("inviolable", 'adj.', "Not susceptible to violence, or of being profaned, corrupted, or dishonoured.").
word("invoke", 'v.', "To call upon (a person, a god) for help, assistance or guidance.").
word("invoke", 'v.', "To cause (a program or subroutine) to execute.").
word("involuntary", 'adj.', "Not voluntary or willing; contrary or opposed to explicit will or desire; unwilling.").
word("involuntary", 'adj.', "Without intention; unintentional.").
word("involution", 'n.', "A complicated grammatical construction.").
word("involution", 'n.', "Entanglement; a spiralling inwards; intricacy.").
word("involve", 'v.', "To connect with something as a natural or logical consequence or effect; to include necessarily; to imply.").
word("involve", 'v.', "To complicate or make intricate.").
word("invulnerable", 'adj.', "Incapable of being injured; not vulnerable.").
word("invulnerable", 'adj.', "Unanswerable; irrefutable").
word("inwardly", 'adv.', "Completely, fully.").
word("inwardly", 'adv.', "In an inward manner; to or toward the inside or to oneself.").
word("iota", 'n.', "The ninth letter of the Greek alphabet.").
word("iota", 'n.', "A jot; a very small, insignificant quantity.").
word("irascible", 'adj.', "Easily provoked to outbursts of anger; irritable.").
word("irate", 'adj.', "Extremely angry; wrathful; enraged.").
word("ire", 'n.', "Great anger; wrath; keen resentment.").
word("ire", 'n.', "Iron.").
word("iridescence", 'n.', "Any shimmer of glittering and changeable colors.").
word("iridescence", 'n.', "The condition or state of being iridescent; exhibition of colors like those of the rainbow; a prismatic play of color.").
word("iridescent", 'adj.', "Producing a display of lustrous, rainbow-like colors; prismatic.").
word("iridescent", 'adj.', "Brilliant, lustrous, or colorful.").
word("irk", 'v.', "To irritate; annoy; bother").
word("irksome", 'adj.', "Marked by irritation or annoyance; disagreeable; troublesome by reason of long continuance or repetition").
word("irony", 'n.', "The state of two usually unrelated entities, parties, actions, etc. being related through a common connection in an uncommon way.").
word("irony", 'n.', "{{cite-journal").
word("irradiance", 'n.', "The radiant power received by unit area of surface").
word("irradiance", 'n.', "That which irradiates or is irradiated; lustre; splendour; brilliancy.").
word("irradiate", 'v.', "To animate by heat or light.").
word("irradiate", 'v.', "To enlighten intellectually; to illuminate.").
word("irrational", 'adj.', "Not rational; unfounded or nonsensical.").
word("irrational", 'adj.', "Of a real number, that cannot be written as the ratio of two integers.").
word("irreducible", 'adj.', "Not able to be reduced or lessened.").
word("irreducible", 'adj.', "Not containing a sphere of codimension 1 that is not the boundary of a ball.").
word("irrefragable", 'adj.', "Which cannot or should not be broken; indestructible.").
word("irrefragable", 'adj.', "Which cannot be refuted; clearly right, incontrovertible, indisputable, irrefutable.").
word("irrefrangible", 'adj.', "Not to be broken or transgressed against; inviolable.").
word("irrefrangible", 'adj.', "Incapable of being refracted.").
word("irrelevant", 'adj.', "Not relevant, as:").
word("irreligious", 'adj.', "Contrary to religious beliefs and practices.").
word("irreligious", 'adj.', "Having no relation to religion.").
word("irreparable", 'adj.', "Incapable of being repaired, amended, cured or rectified; unrepairable.").
word("irrepressible", 'adj.', "Not containable or controllable.").
word("irrepressible", 'adj.', "Especially high-spirited, outspoken, or insistent.").
word("irresistible", 'adj.', "Compellingly attractive.").
word("irresistible", 'adj.', "Impossible to resist.").
word("irresponsible", 'adj.', "Lacking a sense of responsibility; performed or acting as though without responsibility; negligent.").
word("irresponsible", 'adj.', "Not responsible; exempt from legal responsibility, not to be held accountable.").
word("irreverence", 'n.', "The state or quality of being irreverent; want of proper reverence; disregard of the authority and character of a superior.").
word("irreverent", 'adj.', "Lacking respect; not having or not showing respect for or seriousness towards something that is usually treated with respect; going against conventional precepts.").
word("irreverential", 'adj.', "Not reverential.").
word("irreversible", 'adj.', "Incapable of being reversed, recalled, repealed, or annulled.").
word("irreversible", 'adj.', "Incapable of being reversed or turned about or back; incapable of being made to run backward.").
word("irrigate", 'v.', "To supply (farmland) with water, by building ditches, pipes, etc.").
word("irrigate", 'v.', "To clean (a wound) with a fluid.").
word("irritable", 'adj.', "Easily exasperated or excited.").
word("irritable", 'adj.', "Responsive to stimuli.").
word("irritancy", 'n.', "The state or quality of being null and void; invalidity").
word("irritancy", 'n.', "The quality of being irritant or irritating.").
word("irritant", 'n.', "A source of irritation.").
word("irritant", 'n.', "Any medication designed to cause irritation").
word("irritate", 'v.', "To provoke impatience, anger, or displeasure in.").
word("irritate", 'v.', "To induce pain in (all or part of a body or organism).").
word("irruption", 'n.', "An abrupt increase of an animal population.").
word("irruption", 'n.', "An abrupt increase in the size of a movement or organization.").
word("isle", 'n.', "A (small) island, compare with .").
word("islet", 'n.', "An isolated piece of tissue that has a specific function").
word("islet", 'n.', "A small island").
word("isobar", 'n.', "A set of points or conditions at constant pressure.").
word("isobar", 'n.', "Either of two nuclides of different elements having the same mass number.").
word("isochronous", 'adj.', "Of or pertaining to data associated with time sensitive application.").
word("isochronous", 'adj.', "Of or pertaining to the use of clocks derived from the same clock reference.").
word("isolate", 'v.', "To separate a pure strain of bacteria etc. from a mixed culture.").
word("isolate", 'v.', "To set apart or cut off from others.").
word("isothermal", 'adj.', "Of or pertaining to a process that takes place at constant temperature").
word("isothermal", 'adj.', "Of or pertaining to an isotherm").
word("itinerant", 'adj.', "Habitually travelling from place to place.").
word("itinerary", 'n.', "An account or record of a journey.").
word("itinerary", 'n.', "A written schedule of activities for a vacation or road trip.").
word("itinerate", 'v.', "To travel from place to place, especially to preach or lecture.").
word("jargon", 'n.', "Speech or language that is incomprehensible or unintelligible; gibberish.").
word("jargon", 'n.', "A technical terminology unique to a particular subject.").
word("jaundice", 'n.', "A morbid condition, characterized by yellowness of the eyes, skin, and urine.").
word("jaundice", 'n.', "A feeling of bitterness, resentment or jealousy.").
word("jeopardize", 'v.', "To put in jeopardy, to threaten.").
word("jingo", 'n.', "One who supports policy favouring war.").
word("jocose", 'adj.', "Given to jesting; habitually jolly").
word("jocose", 'adj.', "Playful; characterized by joking").
word("jocular", 'adj.', "Humorous, amusing or joking.").
word("joggle", 'n.', "A notch or tooth in the joining surface of any piece of building material to prevent slipping.").
word("joggle", 'n.', "A step formed in material by two adjacent reverse bends.").
word("journalize", 'v.', "To write in a journal; to keep a journal.").
word("journalize", 'v.', "To record in a journal.").
word("joust", 'v.', "To engage in mock combat on horseback, as two knights in the lists; to tilt.").
word("joust", 'v.', "To engage in verbal sparring over an important issue. (used of two people, both of whom participate more or less equally)").
word("jovial", 'adj.', "Cheerful and good-humoured; jolly, merry.").
word("jovial", 'adj.', "Pertaining to the astrological influence of the planet Jupiter; having the characteristics of a person under such influence (see sense 1).").
word("jubilation", 'n.', "A triumphant shouting; rejoicing; exultation.").
word("judgment", 'n.', "The final award; the last sentence.").
word("judgment", 'n.', "The conclusion or result of judging; an opinion; a decision.").
word("judicature", 'n.', "The administration of justice by judges and courts; judicial process.").
word("judicature", 'n.', "The office or authority of a judge; jurisdiction.").
word("judicial", 'adj.', "Of or relating to the administration of justice.").
word("judicial", 'adj.', "Specified by a civil bill court under the terms of the Land Law (Ireland) Act, 1881").
word("judiciary", 'n.', "The collective body of judges, justices, etc.").
word("judiciary", 'n.', "The court system, inclusive of clerical staff, etc.").
word("judicious", 'adj.', "Having, characterized by, or done with good judgment or sound thinking.").
word("juggle", 'v.', "To handle or manage many tasks at once.").
word("juggle", 'v.', "To deceive by trick or artifice.").
word("jugglery", 'n.', "An instance of such trickery or deception.").
word("jugglery", 'n.', "The art of a juggler (i.e. trickery or deception).").
word("jugular", 'adj.', "Relating to, or located near, the neck or throat.").
word("jugular", 'adj.', "Having ventral fins attached under the throat.").
word("juicy", 'adj.', "Strong, painful.").
word("juicy", 'adj.', "Exciting; titillating.").
word("junction", 'n.', "The act of joining, or the state of being joined.").
word("junction", 'n.', "The boundary between two physically different materials, especially between conductors, semiconductors, or metals.").
word("juncture", 'n.', "The manner of moving (transition) or mode of relationship between two consecutive sounds; a suprasegmental phonemic cue, by which a listener can distinguish between two otherwise identical sequences of sounds that have different meanings.").
word("juncture", 'n.', "A critical moment in time.").
word("junta", 'n.', "A council, convention, tribunal or assembly; especially, the grand council of state in Spain.").
word("junta", 'n.', "The ruling council of a military dictatorship.").
word("juridical", 'adj.', "Pertaining to the law or rule of law, legal; judicial, related to the administration of justice (as to jurisprudence, or to the function of a judge or court).").
word("jurisdiction", 'n.', "The power or right to exercise authority.").
word("jurisdiction", 'n.', "The power, right, or authority to interpret and apply the law.").
word("jurisprudence", 'n.', "The theoretical study of law.").
word("juror", 'n.', "A member of a jury.").
word("justification", 'n.', "The forgiveness of sin.").
word("justification", 'n.', "A reason, explanation, or excuse which provides convincing, morally acceptable support for behavior or for a belief or occurrence.").
word("juvenile", 'adj.', "Characteristic of youth or immaturity; childish.").
word("juvenile", 'adj.', "Young; not fully developed.").
word("juxtapose", 'v.', "To place side by side, especially for contrast or comparison.").
word("keepsake", 'n.', "Some object given by a person and retained in memory of something or someone; something kept for sentimental or nostalgic reasons.").
word("keepsake", 'n.', "Specifically, a type of literary album popular in the nineteenth-century, containing scraps of poetry and prose, and engravings.").
word("kerchief", 'n.', "A piece of cloth used to cover the head; a bandana.").
word("kernel", 'n.', "The set of members of a fuzzy set that are fully included (i.e., whose grade of membership is 1).").
word("kernel", 'n.', "A single seed or grain, especially of corn or wheat.").
word("kiln", 'n.', "An oven or furnace or a heated chamber, for the purpose of hardening, burning, calcining or drying anything; for example, firing ceramics, curing or preserving tobacco, or drying grain.").
word("kiloliter", 'n.', "One thousand liters.").
word("kilometer", 'n.', "In the USA.").
word("kilowatt", 'n.', "One thousand (10 3 ) watts.").
word("kimono", 'n.', "A long robe-like garment in Western fashion, which may be open at the front, loosely inspired by the Japanese garment.").
word("kimono", 'n.', "A traditional Japanese T-shaped, wrapped-front garment with square sleeves and a rectangular body, now generally worn only on formal occasions.").
word("kingling", 'n.', "A kinglet; a petty king or ruler.").
word("kingship", 'n.', "The dignity, rank or office of a king; the state of being a king.").
word("kingship", 'n.', "A monarchy.").
word("knavery", 'n.', "An unprincipled action; deceit.").
word("knavery", 'n.', "The antics or tricks of a knave; boyish mischief.").
word("knead", 'v.', "To work and press into a mass, usually with the hands; especially, to work, as by repeated pressure with the knuckles, into a well mixed mass, the materials of bread, cake, etc.").
word("knead", 'v.', "To make an alternating pressing motion with the two front paws.").
word("knighthood", 'n.', "An honour whereby one is made into a knight, and one can thereafter be called \"Sir\"").
word("knighthood", 'n.', "The knights collectively, the body of knights.").
word("laborious", 'adj.', "Requiring much physical effort; toilsome.").
word("laborious", 'adj.', "Mentally difficult; painstaking.").
word("labyrinth", 'n.', "Any of various satyrine butterflies of the genus").
word("labyrinth", 'n.', "A maze-like structure built by Daedalus in Knossos, containing the Minotaur").
word("lacerate", 'v.', "To tear, rip or wound.").
word("lacerate", 'v.', "To defeat thoroughly; to thrash.").
word("lackadaisical", 'adj.', "Lazy; slothful; indolent.").
word("lackadaisical", 'adj.', "Showing no interest, vigor, determination, or enthusiasm.").
word("lactation", 'n.', "The secretion of milk from the mammary gland of a female mammal.").
word("lactation", 'n.', "The process of providing the milk to the young; breastfeeding.").
word("lacteal", 'adj.', "Relating to milk.").
word("lacteal", 'adj.', "Relating to milk production.").
word("lactic", 'adj.', "Of, relating to, or derived from milk").
word("lactic", 'adj.', "That produces lactic acid").
word("laddie", 'n.', "A small boy.").
word("ladle", 'n.', "A deep-bowled spoon with a long, usually curved, handle.").
word("ladle", 'n.', "A container used in a foundry to transport and pour out molten metal.").
word("laggard", 'adj.', "(animal husbandry) Not growing as quickly as the rest of the flock or herd.").
word("laggard", 'adj.', "Lagging behind; taking more time than the others in a group.").
word("landholder", 'n.', "A person who owns land.").
word("landlord", 'n.', "A shark, imagined as the owner of the surf to be avoided.").
word("landlord", 'n.', "The owner or manager of a public house.").
word("landmark", 'n.', "An object that marks the boundary of a piece of land (usually a stone, or a tree).").
word("landmark", 'n.', "A major event or discovery.").
word("landscape", 'n.', "A picture representing a real or imaginary scene by land or sea, the main subject being the general aspect of nature, as fields, hills, forests, water, etc.").
word("landscape", 'n.', "A portion of land or territory which the eye can comprehend in a single view, including all the objects it contains.").
word("languid", 'adj.', "Of time, relaxed and pleasant; unstressful.").
word("languid", 'adj.', "Lacking enthusiasm, energy, or strength; droop or flagging from weakness, fatigue, or lack of energy").
word("languor", 'n.', "Sorrow; suffering; also, enfeebling disease or illness; an instance of this.").
word("languor", 'n.', "Dullness, sluggishness; lack of vigour; stagnation.").
word("lapse", 'n.', "An interval of time between events.").
word("lapse", 'n.', "A common-law rule that if the person to whom property is willed were to die before the testator, then the gift would be ineffective.").
word("lascivious", 'adj.', "Wanton; lewd, driven by lust, lustful.").
word("lassie", 'n.', "A young girl, a lass, especially one seen as a sweetheart.").
word("latency", 'n.', "A stage in Sigmund Freud's psychoanalytic theory of the psychosexual development of children where children become asexual until their sexual desires come back at puberty.").
word("latency", 'n.', "A delay, a period between the initiation of something and the occurrence.").
word("latent", 'adj.', "Remaining in an inactive or hidden phase; dormant.").
word("latent", 'adj.', "Lying dormant or hidden until circumstances are suitable for development or manifestation.").
word("later", 'adv.', "Afterward in time (used with than when comparing with another time).").
word("later", 'adv.', "At some unspecified time in the future.").
word("lateral", 'adj.', "To the side; of or pertaining to the side.").
word("lateral", 'adj.', "Pertaining to sounds generated by partially blocking the egress of the airstream with the tip of the tongue touching the alveolar ridge, leaving space on one or both sides of the occlusion for air passage.").
word("latish", 'adj.', "Somewhat late").
word("lattice", 'n.', "A flat panel constructed with widely-spaced crossed thin strips of wood or other material, commonly used as a garden trellis.").
word("lattice", 'n.', "A bearing with vertical and horizontal bands that cross each other.").
word("laud", 'v.', "To praise; to glorify.").
word("laudable", 'adj.', "Worthy of being lauded; praiseworthy; commendable").
word("laudable", 'adj.', "Healthy; salubrious; having a disposition to promote healing").
word("laudation", 'n.', "The act of lauding; high praise or commendation.").
word("laudatory", 'adj.', "Of or pertaining to praise, or the expression of praise.").
word("laureate", 'adj.', "Crowned, or decked, with laurel.").
word("lave", 'v.', "To wash.").
word("lave", 'v.', "To hang or flap down.").
word("lawgiver", 'n.', "Any lawmaker.").
word("lawgiver", 'n.', "One who provides laws to a society.").
word("lawmaker", 'n.', "One who makes or enacts laws.").
word("lax", 'adj.', "Loose; not tight or taut.").
word("lax", 'adj.', "Lenient and allowing for deviation; not strict.").
word("laxative", 'adj.', "Having the effect of moving the bowels, or aiding digestion and preventing constipation.").
word("lea", 'n.', "An open field, meadow.").
word("lea", 'n.', "Any of several measures of yarn; for linen, 300 yards; for cotton, 120 yards.").
word("leaflet", 'n.', "A small sheet of paper containing information, used for dissemination of said information, often an advertisement.").
word("leaflet", 'n.', "A flap of a valve of a heart or blood vessel.").
word("leaven", 'v.', "To cause to rise by fermentation.").
word("leaven", 'v.', "To rise or become larger.").
word("legacy", 'n.', "The descendant of an alumnus.").
word("legacy", 'n.', "Something inherited from a predecessor or the past.").
word("legalize", 'v.', "To make legal or permit under law. Either by decriminalising something that has been illegal or by specifically permitting it.").
word("legging", 'n.', "A covering, usually of leather, worn from knee to ankle.").
word("legging", 'n.', "Tight fitting leg coverings worn, for example, to gym.").
word("legible", 'adj.', "Clear enough to be read; readable, particularly of handwriting.").
word("legible", 'adj.', "Written or phrased so as to be easy to understand.").
word("legionary", 'n.', "A member of a legion, such as the American Legion, or of any organization containing the term legion in its title (e.g. the French Foreign Legion).").
word("legionary", 'n.', "A soldier belonging to a legion; a professional soldier of the ancient Roman army.").
word("legislate", 'v.', "To pass laws (including the amending or repeal of existing laws).").
word("legislative", 'adj.', "Making, or having the power to make, a law or laws; lawmaking").
word("legislator", 'n.', "Someone who creates or enacts laws").
word("legitimacy", 'n.', "Lawfulness of birth or origin; directness of descent as affecting the royal succession.").
word("legitimacy", 'n.', "The quality or state of being legitimate or valid; validity.").
word("legitimate", 'adj.', "In accordance with the law or established legal forms and requirements.").
word("legitimate", 'adj.', "Conforming to known principles, or established or accepted rules or standards; valid.").
word("leisure", 'n.', "Time at one's command, free from engagement; convenient opportunity; hence, convenience; ease.").
word("leisure", 'n.', "Free time, time free from work or duties.").
word("leniency", 'n.', "The quality of mercy or forgiveness, especially in the assignment of punishment as in a court case.").
word("leniency", 'n.', "An act of being lenient.").
word("lenient", 'adj.', "Lax; not strict; tolerant of dissent or deviation").
word("leonine", 'adj.', "Of, pertaining to, or characteristic of a lion.").
word("lethargy", 'n.', "A state of extreme torpor or apathy, especially with lack of emotion, energy or enthusiasm; sluggishness, laziness.").
word("lethargy", 'n.', "A condition characterized by extreme fatigue or drowsiness, deep unresponsiveness, or prolonged sleep patterns.").
word("levee", 'n.', "The act of rising; getting up, especially in the morning after rest.").
word("levee", 'n.', "The border of an irrigated field.").
word("lever", 'n.', "A rigid piece which is capable of turning about one point, or axis (the fulcrum), and in which are two or more other points where forces are applied; &mdash; used for transmitting and modifying force and motion.").
word("lever", 'n.', "An arm on a rock shaft, to give motion to the shaft or to obtain motion from it.").
word("leviathan", 'n.', "A vast sea monster of tremendous strength, described as the most powerful and dangerous creature in the ocean.").
word("leviathan", 'n.', "The political state, especially a domineering and totalitarian one as theorized by .").
word("levity", 'n.', "Lightness of manner or speech, frivolity; lack of appropriate seriousness; inclination to make a joke of serious matters.").
word("levity", 'n.', "A lighthearted or frivolous act.").
word("levy", 'v.', "To raise; to collect; said of troops, to form into an army by enrollment, conscription. etc.").
word("levy", 'v.', "To impose (a tax or fine) to collect monies due, or to confiscate property.").
word("lewd", 'adj.', "Base, vile, reprehensible.").
word("lewd", 'adj.', "Lascivious, sexually promiscuous, rude.").
word("lexicographer", 'n.', "One who writes or compiles a dictionary").
word("lexicography", 'n.', "The art or craft of compiling, writing, and editing dictionaries.").
word("lexicography", 'n.', "The scholarly discipline of analysing and describing the semantic, syntagmatic and paradigmatic relationships within the lexicon (vocabulary) of a language and developing theories of dictionary components and structures linking the data in dictionaries.").
word("lexicon", 'n.', "Any dictionary.").
word("lexicon", 'n.', "A dictionary of Classical Greek, Hebrew, Latin, or Aramaic.").
word("liable", 'adj.', "Bound or obliged in law or equity; responsible; answerable.").
word("liable", 'adj.', "Exposed to a certain contingency or causality, more or less probable.").
word("libel", 'n.', "Any defamatory writing; a lampoon; a satire.").
word("libel", 'n.', "A written or pictorial false statement which unjustly seeks to damage someone's reputation.").
word("liberalism", 'n.', "Any political movement founded on the autonomy and personal freedom of the individual, progress and reform, and government by law with the consent of the governed.").
word("liberalism", 'n.', "The quality of being liberal.").
word("liberate", 'v.', "To set free, to make or allow to be free, particularly").
word("liberate", 'v.', "To acquire from another by theft or force: to steal, to rob.").
word("licentious", 'adj.', "Lacking restraint, or ignoring societal standards, particularly in sexual conduct.").
word("licentious", 'adj.', "Disregarding accepted rules.").
word("licit", 'adj.', "Not forbidden by formal or informal rules.").
word("licit", 'adj.', "Explicitly established or constituted by law.").
word("liege", 'adj.', "Serving an independent sovereign or master; bound by a feudal tenure; obliged to be faithful and loyal to a superior, such as a vassal to his lord; faithful.}}").
word("liege", 'adj.', "Sovereign; independent; having authority or right to allegiance.").
word("lien", 'n.', "A right to take possession of a debtor’s property as security until a debt or duty is discharged.").
word("lien", 'n.', "A tendon.").
word("lieu", 'n.', "A place or stead; See in lieu or in lieu of").
word("lifelike", 'adj.', "Like a living being, resembling life, giving an accurate representation").
word("lifelong", 'adj.', "Extending for the entire duration of life.").
word("lifetime", 'n.', "The duration of the life of someone or something.").
word("lifetime", 'n.', "A long period of time.").
word("ligament", 'n.', "A band of strong tissue that connects bones to other bones.").
word("ligament", 'n.', "That which binds or acts as a ligament.").
word("ligature", 'n.', "The act of tying or binding something.").
word("ligature", 'n.', "A thread or wire used to remove tumours, etc.").
word("ligneous", 'adj.', "Of, or resembling wood; woody.").
word("ligneous", 'adj.', "Containing lignin or xylem.").
word("likelihood", 'n.', "The probability of a specified outcome; the chance of something happening; probability; the state or degree of being probable.").
word("likelihood", 'n.', "Appearance, show, sign, expression.").
word("likely", 'adj.', "Plausible; within the realm of credibility").
word("likely", 'adj.', "Appropriate, suitable; believable; having a good potential").
word("liking", 'n.', "Approval.").
word("liking", 'n.', "A like; a predilection.").
word("limitation", 'n.', "A restriction; a boundary, real or metaphorical, caused by some thing or some circumstance.").
word("limitation", 'n.', "A time period after which some legal action may no longer be brought.").
word("linear", 'adj.', "Of or relating to a class of polynomial of the form y = ax + b . Category:en:Polynomials").
word("linear", 'adj.', "Long and narrow, with nearly parallel sides.").
word("liner", 'n.', "The pamphlet which is contained inside an album of music or movie").
word("liner", 'n.', "A slab on which small pieces of marble, tile, etc., are fastened for grinding.").
word("lingo", 'n.', "Language, especially language peculiar to a particular group, field, or region; jargon or a dialect.").
word("lingua", 'n.', "A median process of the labium, at the underside of the mouth in insects, and serving as a tongue.").
word("lingual", 'adj.', "Related to, near, or on the side toward the tongue.").
word("lingual", 'adj.', "Related to language or linguistics.").
word("linguist", 'n.', "A person skilled in languages.").
word("linguist", 'n.', "A human translator; an interpreter, especially in the armed forces.").
word("linguistics", 'n.', "The scientific study of language.").
word("liniment", 'n.', "A topical medical preparation intended to be rubbed into the skin with friction, as for example to relieve symptoms of arthritis.").
word("liquefacient", 'adj.', "That liquefies.").
word("liquefy", 'v.', "|transitive}} To distort and warp an image.").
word("liquefy", 'v.', "To become .").
word("liqueur", 'n.', "A flavoured alcoholic beverage that is usually very sweet and contains a high percentage of alcohol. Cordials are a type of liqueur manufactured using the infusion process as opposed to the essence and distillation processes.").
word("liquidate", 'v.', "To determine by agreement or by litigation the precise amount of (indebtedness); to make the amount of (a debt) clear and certain.").
word("liquidate", 'v.', "To settle (a debt) by paying the outstanding amount.").
word("liquor", 'n.', "Strong alcoholic drink derived from fermentation and distillation; more broadly, any alcoholic drink.").
word("liquor", 'n.', "A parsley sauce commonly served with traditional pies and mash.").
word("listless", 'adj.', "Lacking energy, enthusiasm, or liveliness.").
word("literacy", 'n.', "The ability to read and write.").
word("literacy", 'n.', "The ability to understand and evaluate something.").
word("literal", 'adj.', "Following the letter or exact words; not free; not taking liberties").
word("literal", 'adj.', "Exactly as stated; read or understood without additional interpretation; according to the letter or verbal expression; real; not figurative or metaphorical.").
word("literature", 'n.', "The collected creative writing of a nation, people, group or culture.").
word("literature", 'n.', "The body of all written works.").
word("lithe", 'adj.', "Capable of being easily bent; flexible.").
word("lithe", 'adj.', "Adaptable.").
word("lithesome", 'adj.', "Characterised or marked by litheness; pliant, limber, nimble, lissome.").
word("lithograph", 'n.', "A printed image produced by lithography.").
word("lithotype", 'n.', "An etched stone surface for printing, having the design in relief.").
word("lithotype", 'n.', "A print made from such a surface.").
word("litigant", 'n.', "A party suing or being sued in a lawsuit, or otherwise calling upon the judicial process to determine the outcome of a suit.").
word("litigate", 'v.', "To go to law; to carry on a lawsuit.").
word("litigate", 'v.', "To dispute; to fight over.").
word("litigious", 'adj.', "Inclined to engage in lawsuits.").
word("litigious", 'adj.', "Argumentative or combative.").
word("littoral", 'adj.', "Of or relating to the shore, especially the seashore.").
word("liturgy", 'n.', "A predetermined or prescribed set of rituals that are performed, usually by a religion.").
word("liturgy", 'n.', "An official worship service of the Christian church.").
word("livelihood", 'n.', "A means of providing the necessities of life for oneself (for example, a job or income).").
word("livelihood", 'n.', "The course of someone's life; a person's lifetime, or their manner of living; conduct, behaviour.").
word("livid", 'adj.', "Having a dark, bluish appearance.").
word("livid", 'adj.', "So angry that one turns pale; very angry; furious.").
word("loam", 'n.', "A type of soil; an earthy mixture of sand, silt and clay, with organic matter to which its fertility is chiefly due.").
word("loam", 'n.', "A mixture of sand, clay, and other materials, used in making moulds for large castings, often without a pattern.").
word("loath", 'adj.', "Averse, disinclined; reluctant, unwilling.").
word("loath", 'adj.', "Angry, hostile.").
word("loathe", 'v.', "To detest, hate, or revile (someone or something).").
word("locative", 'adj.', "Indicating place, or the place where, or wherein.").
word("loch", 'n.', "A lake.").
word("loch", 'n.', "A bay or arm of the sea.").
word("locomotion", 'n.', "The ability to move from place to place, or the act of doing so.").
word("locomotion", 'n.', "Self-powered motion by which a whole organism changes its location through walking, running, jumping, crawling, swimming or flying.").
word("lode", 'n.', "A vein of metallic ore that lies within definite boundaries, or within a fissure.").
word("lode", 'n.', "A rich source of supply.").
word("lodgment", 'n.', "The occupation of a position by a besieging party, and the works thrown up to maintain it.").
word("lodgment", 'n.', "The act of lodging or depositing.").
word("logic", 'n.', "A formal or informal language together with a deductive system or a model-theoretic semantics.").
word("logic", 'n.', "The mathematical study of relationships between rigorously defined concepts and of mathematical proof of statements.").
word("logical", 'adj.', "Non-physical or conceptual yet underpinned by something physical or actual.").
word("logical", 'adj.', "Reasonable.").
word("logician", 'n.', "A person who studies or teaches logic.").
word("loiterer", 'n.', "One who loiters, one who lingers or hangs around.").
word("loneliness", 'n.', "A desire to be alone; disposition to solitude.").
word("loneliness", 'n.', "A feeling of depression resulting from being alone or from having no companions.").
word("longevity", 'n.', "The quality of being long-lasting, especially of life.").
word("longevity", 'n.', "Duration over time; persistence.").
word("loot", 'v.', ", to seize by violence particularly during the capture of a city during war or after successful combat.").
word("loot", 'v.', ", to steal something from someone by violence or threat of violence.").
word("loquacious", 'adj.', "Talkative; chatty.").
word("lordling", 'n.', "An unimportant or petty lord.").
word("lordling", 'n.', "A young lord.").
word("lough", 'n.', "A lake or long, narrow inlet, especially in Ireland.").
word("lough", 'n.', "Lake, pool").
word("louse", 'n.', "A small parasitic wingless insect of the order Psocodea.").
word("louse", 'n.', "A contemptible person; one who is deceitful or causes harm.").
word("lovable", 'adj.', "Inspiring or deserving love or affection.").
word("lowly", 'adv.', "At low pitch or volume.").
word("lowly", 'adv.', "In a low condition; meanly.").
word("lucid", 'adj.', "Mentally rational; sane").
word("lucid", 'adj.', "Bright, luminous, translucent or transparent").
word("lucrative", 'adj.', "Producing a surplus; profitable.").
word("lucrative", 'adj.', "Of a target: worth attacking; whose destruction is militarily useful.").
word("ludicrous", 'adj.', "Amusing by being plainly incongruous or absurd.").
word("ludicrous", 'adj.', "Idiotic or unthinkable, often to the point of being funny.").
word("luminary", 'n.', "A body that gives light; especially, one of the heavenly bodies.").
word("luminary", 'n.', "One who is an inspiration to others; one who has achieved success in one's chosen field; a leading light.").
word("luminescence", 'n.', "Any emission of light that cannot be attributed merely to the temperature of the emitting body.").
word("luminescent", 'adj.', "Emitting light by luminescence.").
word("luminosity", 'n.', "The rate at which a star radiates energy in all directions").
word("luminosity", 'n.', "The state of being luminous, or a luminous object; brilliance or radiance").
word("luminous", 'adj.', "Emitting light; glowing brightly.").
word("luminous", 'adj.', "Brightly illuminated.").
word("lunacy", 'n.', "Something deeply misguided.").
word("lunacy", 'n.', "The state of being mad, insanity").
word("lunar", 'adj.', "Of or pertaining to silver (which was symbolically associated with the Moon by alchemists).").
word("lunar", 'adj.', "Of or pertaining to travel through space between the Earth and the Moon, or exploration and scientific investigation of the Moon.").
word("lunatic", 'n.', "An insane person.").
word("lune", 'n.', "A concave figure formed by the intersection of the arcs of two circles on a plane, or on a sphere the intersection between two great semicircles.").
word("lune", 'n.', "Anything crescent-shaped.").
word("lurid", 'adj.', "Ghastly, pale, wan in appearance.").
word("lurid", 'adj.', "Having a colour tinged with purple, yellow, and grey.").
word("luscious", 'adj.', "Sweet and pleasant; delicious.").
word("luscious", 'adj.', "Obscene.").
word("lustrous", 'adj.', "As if shining with a brilliant light; radiant.").
word("lustrous", 'adj.', "Having a glow or lustre.").
word("luxuriance", 'n.', "The property of being luxuriant.").
word("luxuriant", 'adj.', "Abundant in growth or detail.").
word("luxuriate", 'v.', "To be luxuriant; to grow exuberantly.").
word("luxuriate", 'v.', "To enjoy luxury, to indulge.").
word("lying", 'n.', "An act of telling a lie or falsehood.").
word("lying", 'n.', "The act of one who lies, or keeps low to the ground.").
word("lyre", 'n.', "An ancient stringed musical instrument (a yoke lute chordophone) of Greek origin, consisting of two arms extending from a body to a crossbar (a yoke), and strings, parallel to the soundboard, connecting the body to the yoke.").
word("lyre", 'n.', "A composer of lyric poetry.").
word("lyric", 'adj.', "Of, or relating to a type of poetry (such as a sonnet or ode) that expresses subjective thoughts and feelings, often in a songlike style").
word("lyric", 'adj.', "Having a light singing voice of modest range").
word("macadamize", 'v.', "To cover, as a road, or street, with small, broken stones, so as to form a smooth, hard, convex surface.").
word("machinery", 'n.', "The collective parts of something which allow it to function.").
word("machinery", 'n.', "The working parts of a machine as a group.").
word("machinist", 'n.', "One skilled in the use of machine tools for fashioning metal parts or tools out of metal.").
word("machinist", 'n.', "A constructor of machines and engines; one versed in the principles of machines.").
word("macrocosm", 'n.', "A complex structure, such as a society, considered as a single entity that contains numerous similar, smaller-scale structures.").
word("macrocosm", 'n.', "The universe.").
word("madden", 'v.', "To make insane; to inflame with passion.").
word("madden", 'v.', "To become furious.").
word("madonna", 'n.', "A one-footed lien-to-tail trick, where the front foot is taken off and kicked out straight down behind the board.").
word("magician", 'n.', "A performer of tricks or an escapologist or an illusionist.").
word("magician", 'n.', "A person who astounds; an enigma.").
word("magisterial", 'adj.', "Befitting the status or skill of a magister or master; authoritative, masterly.").
word("magisterial", 'adj.', "Of or pertaining to a master, magistrate, the magisterium, or one in authority.").
word("magistracy", 'n.', "The dignity or office of a magistrate.").
word("magistracy", 'n.', "The collective body of magistrates.").
word("magnanimous", 'adj.', "Noble and generous in spirit.").
word("magnate", 'n.', "A person of rank, influence or distinction in any sphere.").
word("magnate", 'n.', "Powerful industrialist; captain of industry.").
word("magnet", 'n.', "A person or thing that attracts what is denoted by the preceding noun.").
word("magnet", 'n.', "A piece of material that attracts some metals by magnetism.").
word("magnetize", 'v.', "To attract, allure or entice; to captivate or entrance.").
word("magnetize", 'v.', "To hypnotize using mesmerism.").
word("magnificence", 'n.', "Grandeur, brilliance, lavishness or splendor").
word("magnificence", 'n.', "The act of doing what is magnificent; the state or quality of being magnificent.").
word("magnificent", 'adj.', "Grand or noble in action.").
word("magnificent", 'adj.', "Grand, elegant or splendid in appearance.").
word("magnitude", 'n.', "The absolute or relative size, extent or importance of something.").
word("magnitude", 'n.', "A number, assigned to something, such that it may be compared to others numerically").
word("maharaja", 'n.', "A Hindu monarch ranking above a raja, an emperor.").
word("maidenhood", 'n.', "Freshness; newness.").
word("maidenhood", 'n.', "A woman's virginity or maidenhead.").
word("maintain", 'v.', "To support (someone), to back up or assist (someone) in an action.").
word("maintain", 'v.', "To keep up; to preserve; to uphold (a state, condition etc.).").
word("maintenance", 'n.', "The natural process which keeps an organism alive.").
word("maintenance", 'n.', "Money required or spent to provide for the needs of a person or a family.").
word("maize", 'n.', "Corn; a type of grain of the species Zea mays.").
word("makeup", 'n.', "Cosmetics; colorants and other substances applied to the skin to alter its appearance.").
word("makeup", 'n.', "An item's composition.").
word("malady", 'n.', "Any ailment or disease of the body; especially, a lingering or deep-seated disorder.").
word("malady", 'n.', "A moral or mental defect or disorder.").
word("malaria", 'n.', "Supposed poisonous air arising from marshy districts, once thought to cause fever.").
word("malaria", 'n.', "A disease spread by mosquito, in which a protozoan, Plasmodium, multiplies in blood every few days.").
word("malcontent", 'n.', "A state of discontentment or dissatisfaction; something that causes discontent.").
word("malcontent", 'n.', "A person who is not satisfied with current conditions; a discontented person, a rebel.").
word("malediction", 'n.', "A curse.").
word("malediction", 'n.', "Evil speech.").
word("malefactor", 'n.', "A criminal or felon.").
word("malefactor", 'n.', "An evildoer.").
word("maleficent", 'adj.', "Harmful or evil in intent or effect.").
word("malevolence", 'n.', "Behavior exhibiting a hostile attitude.").
word("malevolence", 'n.', "Hostile attitude or feeling.").
word("malevolent", 'adj.', "Having or displaying ill will; wishing harm on others.").
word("malevolent", 'adj.', "Having an evil or harmful influence.").
word("malign", 'v.', "To make defamatory statements about; to slander or traduce.").
word("malign", 'v.', "To treat with malice; to show hatred toward; to abuse; to wrong.").
word("malignant", 'adj.', "Tending to produce death; threatening a fatal issue.").
word("malignant", 'adj.', "Harmful, malevolent, injurious.").
word("malleable", 'adj.', "Able to be hammered into thin sheets; capable of being extended or shaped by beating with a hammer, or by the pressure of rollers.").
word("malleable", 'adj.', "In which an adversary can alter a ciphertext such that it decrypts to a related plaintext").
word("mallet", 'n.', "A type of hammer with a larger-than-usual head made of wood, rubber or similar non-iron material, used by woodworkers for driving a tool, such as a chisel. A kind of maul.").
word("mallet", 'n.', "A small hammer-like tool used for playing certain musical instruments.").
word("maltreat", 'v.', "To treat badly, to abuse.").
word("mandate", 'n.', "An official or authoritative command; an order or injunction; a commission; a judicial precept; an authorization.").
word("mandate", 'n.', "The authority to do something, as granted to a politician by the electorate.").
word("mandatory", 'adj.', "Obligatory; required or commanded by authority.").
word("mandatory", 'adj.', "Of, being or relating to a mandate.").
word("mane", 'n.', "Longer hair growth on back of neck of an animal, especially a horse or lion").
word("mane", 'n.', "Long or thick hair of a person's head.").
word("maneuver", 'v.', "To move (something, or oneself) carefully, and often with difficulty, into a certain position.").
word("maneuver", 'v.', "To intrigue, manipulate, plot, scheme").
word("mania", 'n.', "Violent derangement of mind; madness; insanity.").
word("mania", 'n.', "The state of abnormally elevated or irritable mood, arousal, and/or energy levels.").
word("maniac", 'n.', "A fanatic, a person with an obsession.").
word("maniac", 'n.', "An insane person, especially one who suffers from a mania.").
word("manifesto", 'n.', "A public declaration of principles, policies, or intentions, especially that of a political party.").
word("manlike", 'adj.', "Of or characteristic of grown men, as opposed to women or children; macho, mannish, virile.").
word("manlike", 'adj.', "Of or relating to a human being; anthropoid, anthropomorphous.").
word("manliness", 'n.', "The quality of being manly; the set of qualities, traits and abilities considered appropriate to men (as opposed to women or children); similarity to a man.").
word("manliness", 'n.', "Humanity, the quality of being human").
word("mannerism", 'n.', "A noticeable personal habit, a verbal or other (often, but not necessarily unconscious) habitual behavior peculiar to an individual.").
word("mannerism", 'n.', "In literature, an ostentatious and unnatural style of the second half of the sixteenth century. In the contemporary criticism, described as a negation of the classicist equilibrium, pre-Baroque, and deforming expressiveness.").
word("manor", 'n.', "The lord's residence and seat of control in such a district.").
word("manor", 'n.', "A district over which a feudal lord could exercise certain rights and privileges in medieval western Europe.").
word("mantel", 'n.', "The shelf above a fireplace which may be also a structural support for the masonry of the chimney.").
word("mantel", 'n.', "A maneuver to surmount a ledge, involving pushing down on the ledge to bring up the body. Also called a mantelshelf.").
word("mantle", 'n.', "Anything that covers or conceals something else; a cloak.").
word("mantle", 'n.', "The zone of hot gases around a flame.").
word("manufacturer", 'n.', "A person or company that manufactures").
word("manumission", 'n.', "Release from slavery or other legally sanctioned servitude; the giving of freedom; the act of manumitting.").
word("manumit", 'v.', "To release from slavery, to free.").
word("marine", 'adj.', "Relating to or connected with the sea (in operation, scope, etc.), especially as pertains to shipping, a navy, or naval forces.").
word("marine", 'adj.', "Belonging to or characteristic of the sea; existing or found in the sea; formed or produced by the sea.").
word("maritime", 'adj.', "Bordering on the sea; living near the seacoast; coastal.").
word("maritime", 'adj.', "Relating to or connected with the sea or its uses (as navigation, commerce, etc.).").
word("maroon", 'v.', "To abandon in a remote, desolate place, as on a desert island.").
word("martial", 'adj.', "Characteristic of or befitting a warrior; having a military bearing; soldierly.").
word("martial", 'adj.', "Connected with or relating to armed forces or the profession of arms or military life.").
word("martyrdom", 'n.', "The condition of a martyr; the death of a martyr; the suffering of death on account of adherence to the Christian faith, or to any cause.").
word("martyrdom", 'n.', "Extreme suffering, affliction; torment; torture, especially without reason.").
word("marvel", 'v.', "To become filled with wonderment or admiration; to be amazed at something.").
word("marvel", 'v.', "To cause to marvel or be surprised.").
word("masonry", 'n.', "The craft, institution, or mysteries of Freemasons; Freemasonry.").
word("masonry", 'n.', "The art or occupation of a mason.").
word("masquerade", 'n.', "An assembly or party of people wearing (usually elaborate or fanciful) masks and costumes, and amusing themselves with dancing, conversation, or other diversions.").
word("masquerade", 'n.', "A Spanish entertainment or military exercise in which squadrons of horses charge at each other, the riders fighting with bucklers and canes.").
word("massacre", 'n.', "The killing of a considerable number where little or no resistance can be made, with indiscriminate violence, without necessity, and contrary to civilized norms.").
word("massacre", 'n.', "Any overwhelming defeat, as in a game or sport.").
word("massive", 'adj.', "Very large or bulky and heavy and solid.").
word("massive", 'adj.', "Having any mass.").
word("masterpiece", 'n.', "A work created in order to qualify as a master craftsman and member of a guild.").
word("masterpiece", 'n.', "A piece of work that has been given much critical praise, especially one that is considered the greatest work of a person's career.").
word("mastery", 'n.', "Superiority in war or competition; victory; triumph; preeminence.").
word("mastery", 'n.', "A contest for superiority.").
word("material", 'n.', "The substance that something is made or composed of.").
word("material", 'n.', "Matter which may be shaped or manipulated, particularly in making something.").
word("materialize", 'v.', "To cause to take physical form, or to cause an object to appear.").
word("materialize", 'v.', "To take physical form, to appear seemingly from nowhere.").
word("maternal", 'adj.', "Of or pertaining to a mother; having the characteristics of a mother; motherly.").
word("maternal", 'adj.', "Related through the mother, or her side of the family.").
word("matinee", 'n.', "A showing of a movie, sporting event, or theatrical performance in the morning or afternoon.").
word("matinee", 'n.', "A woman's dress to be worn in the morning or before dinner.").
word("matricide", 'n.', "The killing of one's mother.").
word("matricide", 'n.', "A person who kills his or her mother.").
word("matrimony", 'n.', "The ceremony of marriage.").
word("matrimony", 'n.', "Marriage; the state of being married.").
word("matrix", 'n.', "The cavity or mold in which anything is formed.").
word("matrix", 'n.', "The five simple colours (black, white, blue, red, and yellow) from which all the others are formed.").
word("matter of fact", 'n.', "Something completely true").
word("matter of fact", 'n.', "A fact").
word("maudlin", 'adj.', "Affectionate or sentimental in an effusive, tearful, or foolish manner, especially because of drunkenness.").
word("maudlin", 'adj.', "Tearful, lachrymose.").
word("mausoleum", 'n.', "A large stately tomb or a building housing such a tomb or several tombs.").
word("mausoleum", 'n.', "A gloomy, usually large room or building.").
word("mawkish", 'adj.', "Sickening or insipid in taste or smell.").
word("mawkish", 'adj.', "Excessively or falsely sentimental; showing a sickly excess of sentiment.").
word("maxim", 'n.', "A self-evident axiom or premise; a pithy expression of a general principle or rule.").
word("maxim", 'n.', "A precept; a succinct statement or observation of a rule of conduct or moral teaching.").
word("maze", 'n.', "A labyrinth; a puzzle consisting of a complicated network of paths or passages, the aim of which is to find one's way through.").
word("maze", 'n.', "Confusion of thought; state of bewilderment.").
word("mead", 'n.', "An alcoholic drink fermented from honey and water.").
word("mead", 'n.', "A drink composed of syrup of sarsaparilla or other flavouring extract, and water, and sometimes charged with carbon dioxide.").
word("meager", 'adj.', "Having little flesh; lean; thin.").
word("meager", 'adj.', "Poor, deficient or inferior in amount, quality or extent").
word("meander", 'v.', "To wind or turn in a course or passage; to be intricate.").
word("meander", 'v.', "To wind, turn, or twist; to make flexuous.").
word("mechanics", 'n.', "The branch of physics that deals with the action of forces on material objects with mass").
word("mechanics", 'n.', "The design and construction of machines.").
word("medallion", 'n.', "A large medal, usually decorative.").
word("medallion", 'n.', "A usually round or oval frame (often made of stucco) containing a decoration.").
word("meddlesome", 'adj.', "Characterised or marked by meddling; inclined or having a tendency to meddle or interfere in other people's business.").
word("medial", 'adj.', "Situated in or near the middle; not at either end.").
word("medial", 'adj.', "Of or pertaining to a mean or average.").
word("mediate", 'v.', "To intervene between conflicting parties in order to resolve differences or bring about a settlement.").
word("mediate", 'v.', "To resolve differences, or to bring about a settlement, between conflicting parties.").
word("medicine", 'n.', "Among the Native Americans, any object supposed to give control over natural or magical forces, to act as a protective charm, or to cause healing.").
word("medicine", 'n.', "The study of the cause, diagnosis, prognosis and treatment of disease or illness.").
word("medieval", 'adj.', "Of or relating to the Middle Ages, the period from approximately 500 to 1500 AD.").
word("medieval", 'adj.', "Having characteristics associated with the Middle Ages in popular, modern cultural perception:").
word("mediocre", 'adj.', "Having no peculiar or outstanding features; not extraordinary, special, exceptional, or great; of medium quality, almost always with a negative connotation .").
word("meditation", 'n.', "A contemplative discourse, often on a religious or philosophical subject.").
word("meditation", 'n.', "Careful and thorough thought.").
word("medley", 'n.', "A collection of related songs played or mixed together as a single piece.").
word("medley", 'n.', "A competitive swimming event that combines the four strokes of butterfly, backstroke, breaststroke, and freestyle.").
word("meliorate", 'v.', "To make better; to improve; to solve a problem.").
word("meliorate", 'v.', "To become better.").
word("mellifluous", 'adj.', "Sweet, smooth and musical; pleasant to hear (generally used of a person's voice, tone or writing style).").
word("mellifluous", 'adj.', "Flowing like honey.").
word("melodious", 'adj.', "Having a pleasant melody or sound; tuneful.").
word("melodrama", 'n.', "A drama abounding in romantic sentiment and agonizing situations, with a musical accompaniment only in parts which are especially thrilling or pathetic. In opera, a passage in which the orchestra plays a somewhat descriptive accompaniment, while the actor speaks").
word("melodrama", 'n.', "Any situation or action which is blown out of proportion.").
word("memento", 'n.', "A keepsake; an object kept as a reminder of a place or event.").
word("memorable", 'adj.', "Worthy to be remembered; very important or remarkable.").
word("menace", 'n.', "The act of threatening.").
word("menace", 'n.', "A perceived threat or danger.").
word("menagerie", 'n.', "A collection of live wild animals as an exhibition historically associated with the aristocracy and considered a precursor of modern zoos.").
word("menagerie", 'n.', "The enclosure where they are kept.").
word("mendacious", 'adj.', "(of a person) Lying, untruthful or dishonest.").
word("mendacious", 'adj.', "(of a statement, etc) False or untrue.").
word("mendicant", 'n.', "A pauper who lives by begging.").
word("mendicant", 'n.', "A religious friar, forbidden to own personal property, who begs for a living.").
word("mentality", 'n.', "A mindset; a way of thinking; a set of beliefs.").
word("mentality", 'n.', "The characteristics of a mind described as a system of distinctive structures and processes based in biology, language, or culture, etc.; a mental system.").
word("mentor", 'n.', "A wise and trusted counselor or teacher").
word("mercantile", 'adj.', "Concerned with the exchange of goods for profit.").
word("mercantile", 'adj.', "Of or relating to mercantilism.").
word("mercenary", 'adj.', "Motivated by private gain.").
word("merciful", 'adj.', "Showing mercy.").
word("merciless", 'adj.', "Showing no mercy; cruel and pitiless.").
word("meretricious", 'adj.', "Tastelessly gaudy; superficially attractive but having in reality no value or substance; falsely alluring.").
word("meretricious", 'adj.', "Involving unlawful sexual connection or lack of consent by at least one party (said of a romantic relationship).").
word("mesmerize", 'v.', "To spellbind; to enthrall.").
word("mesmerize", 'v.', "To exercise mesmerism on; to affect another person, such as to heal or soothe, through the use of animal magnetism.").
word("metal", 'n.', "Molten glass that is to be blown or moulded to form objects .").
word("metal", 'n.', "Chemical elements or alloys, and the mines where their ores come from.").
word("metallurgy", 'n.', "The science of metals; their extraction from ores, purification and alloying, heat treatment, and working.").
word("metamorphosis", 'n.', "A change in the form and often habits of an animal after the embryonic stage during normal development. (e.g. the transformation of a caterpillar into a butterfly or a tadpole into a frog.)").
word("metamorphosis", 'n.', "A transformation, such as one performed by magic.").
word("metaphor", 'n.', "The use of a word or phrase to refer to something other than its literal meaning, invoking an implicit similarity between the thing described and what is denoted by the word or phrase.").
word("metaphor", 'n.', "The use of an everyday object or concept to represent an underlying facet of the computer and thus aid users in performing tasks.").
word("metaphysical", 'adj.', "Immaterial, supersensual, not physical (more properly, \"beyond\" that which is physical).").
word("metaphysical", 'adj.', "Being an adherent of the philosophy of metaphysics.").
word("metaphysician", 'n.', "A philosopher who specializes in the scholarly study of metaphysics.").
word("metaphysics", 'n.', "The view or theory of a particular philosopher or school of thinkers concerning the first principles which describe or explain all that is.").
word("metaphysics", 'n.', "The branch of philosophy which studies fundamental principles intended to describe or explain all that is, and which are not themselves explained by anything more fundamental; the study of first principles; the study of being insofar as it is being (ens in quantum ens).").
word("mete", 'v.', "To measure.").
word("mete", 'v.', "To dispense, measure (out), allot (especially punishment, reward etc.).").
word("metempsychosis", 'n.', "Transmigration of the soul, especially its reincarnation after death.").
word("meticulous", 'adj.', "Timid, fearful, overly cautious.").
word("meticulous", 'adj.', "Characterized by very precise, conscientious attention to details.").
word("metonymy", 'n.', "The use of a single characteristic or part of an object, concept or phenomenon to identify the entire object, concept, phenomenon or a related object.").
word("metonymy", 'n.', "A metonym.").
word("metric", 'adj.', "Of or relating to distance.").
word("metric", 'adj.', "Of or relating to the meter of a piece of music.").
word("metronome", 'n.', "A device, containing an inverted pendulum, used to mark time by means of regular ticks at adjustable intervals; an electronic equivalent that emits flashes.").
word("metropolis", 'n.', "The mother (founding) polis (city state) of a colony.").
word("metropolis", 'n.', "A large, busy city, especially as the main city in an area or country or as distinguished from surrounding rural areas.").
word("metropolitan", 'adj.', "Of, or pertaining to, a metropolis or other large urban settlement.").
word("metropolitan", 'adj.', "Of or pertaining to the parent state of a colony or territory, or the home country, e.g. metropolitan France").
word("mettle", 'n.', "A quality of endurance and courage.").
word("mettle", 'n.', "Good temperament and character.").
word("mettlesome", 'adj.', "Marked by mettle or bravery; courageous.").
word("microcosm", 'n.', "Human nature or the human body as representative of the wider universe; man considered as a miniature counterpart of divine or universal nature.").
word("microcosm", 'n.', "A smaller system which is seen as representative a larger one.").
word("micrometer", 'n.', "A device used to measure distance very precisely but within a limited range, especially depth, thickness, and diameter.").
word("micrometer", 'n.', "An SI/MKS unit of measure, the length of one millionth of a meter. Symbols: µm, um, rm.").
word("microphone", 'n.', "A device (transducer) used to convert sound waves into a varying electric current; normally fed into an amplifier and either recorded or broadcast.").
word("microscope", 'n.', "An optical instrument used for observing small objects.").
word("microscope", 'n.', "Any instrument for imaging very small objects (such as an electron microscope).").
word("microscopic", 'adj.', "Able to see extremely minute objects.").
word("microscopic", 'adj.', "Carried out with great attention to detail.").
word("microscopy", 'n.', "The study of microscopes, their design and manufacture.").
word("microscopy", 'n.', "The use of microscopes.").
word("midsummer", 'n.', "The middle of summer.").
word("midsummer", 'n.', "The first day of summer").
word("midwife", 'n.', "A person, usually a woman, who is trained to assist women in childbirth, but who is not a physician.").
word("midwife", 'n.', "Someone who assists in bringing about some result or project.").
word("mien", 'n.', "Demeanor; facial expression or attitude, especially one which is intended by its bearer.").
word("mien", 'n.', "A specific facial expression.").
word("migrant", 'adj.', "Migratory.").
word("migrate", 'v.', "To change habitations across a border; to move from one country or political region to another.").
word("migrate", 'v.', "To relocate periodically from one region to another, usually according to the seasons.").
word("migratory", 'adj.', "Roving; wandering; nomadic.").
word("migratory", 'adj.', "Migrating.").
word("mileage", 'n.', "The total distance travelled in miles or in air miles.").
word("mileage", 'n.', "An allowance for travel expenses at a specified rate per mile.").
word("militant", 'adj.', "Aggressively supporting of a political or social cause; adamant, combative.").
word("militant", 'adj.', "Fighting or disposed to fight; belligerent, warlike.").
word("militarism", 'n.', "An ideology which claims that the military is the foundation of a society's security, and thereby its most important aspect.").
word("militarism", 'n.', "A focus on, or excessive use of, military force.").
word("militate", 'v.', "To give force or effect toward; to influence.").
word("militate", 'v.', "To fight.").
word("militia", 'n.', "An army of trained civilians, which may be an official reserve army, called upon in time of need, the entire able-bodied population of a state which may also be called upon, or a private force not under government control.").
word("militia", 'n.', ": the national police force of certain countries (e.g. Belarus).").
word("millet", 'n.', "Any of a group of various types of grass or its grains used as food, widely cultivated in the developing world.").
word("millet", 'n.', "A semi-autonomous confessional community under the Ottoman Empire, especially a non-Muslim one.").
word("mimic", 'v.', "To imitate, especially in order to ridicule.").
word("mimic", 'v.', "To take on the appearance of another, for protection or camouflage.").
word("miniature", 'adj.', "Smaller than normal.").
word("minimize", 'v.', "To make (something) smaller or as small as possible; shrink; reduce.").
word("minimize", 'v.', "To remove (a window) from the main display area, collapsing it to an icon or caption.").
word("minion", 'n.', "A loyal servant of another, usually a more powerful being.").
word("minion", 'n.', "A loved one; one highly esteemed and favoured.").
word("ministration", 'n.', "The act of ministering.").
word("ministry", 'n.', "The clergy of nonapostolic Protestant churches.").
word("ministry", 'n.', "Work of a spiritual or charitable nature.").
word("minority", 'n.', "A group of people seen as distinct who are subordinated and discriminated against in a society.").
word("minority", 'n.', "Any subgroup that does not form a numerical majority.").
word("minute", 'adj.', "Very careful and exact, giving small details.").
word("minute", 'adj.', "Very small.").
word("minutia", 'n.', "A minor detail, often of negligible importance.").
word("minutia", 'n.', "Any of the point features on fingerprints used for matching, usually endings and bifurcations of ridges.").
word("mirage", 'n.', "An optical phenomenon in which light is refracted through a layer of hot air close to the ground, often giving the illusion of a body of water.").
word("mirage", 'n.', "An illusion.").
word("misadventure", 'n.', "An accidental mishap or misfortune.").
word("misanthropic", 'adj.', "Hating or disliking mankind.").
word("misanthropy", 'n.', "Hatred or dislike of people or mankind.").
word("misapprehend", 'v.', "To interpret incorrectly; to misunderstand.").
word("misbehave", 'v.', "To act or behave in an inappropriate, improper, incorrect, or unexpected manner.").
word("misbehavior", 'n.', "Action or conduct that is inappropriate, improper, incorrect, or unexpected.").
word("mischievous", 'adj.', "Troublesome, cheeky, badly behaved.").
word("mischievous", 'adj.', "Causing mischief; injurious.").
word("miscount", 'v.', "To count incorrectly.").
word("miscreant", 'n.', "One not restrained by moral principles; an unscrupulous villain.").
word("miscreant", 'n.', "One who has behaved badly, or illegally.").
word("misdeed", 'n.', "That which was done that should not have been, ranging from any sin or moral offense to various degrees of crime.").
word("misdemeanor", 'n.', "A crime usually punishable upon conviction by a small fine or by a short term of imprisonment. In the USA, misdemeanants usually are incarcerated in county jail for less than one year, but felons usually are incarcerated in state or federal prison for more than one year. Crimes which are punishable by large fines or by longer imprisonment are sometimes called felonies.").
word("miser", 'n.', "A kind of earth auger, typically large-bored and often hand-operated.").
word("miser", 'n.', "A person who hoards money rather than spending it; one who is cheap or extremely parsimonious.").
word("mishap", 'n.', "Evil accident; ill luck; misfortune; mischance.").
word("mishap", 'n.', "An accident, mistake, or problem.").
word("misinterpret", 'v.', "To make an incorrect interpretation; to misunderstand.").
word("mislay", 'v.', "To leave or lay something in the wrong place and then forget where one put it.").
word("mismanage", 'v.', "To behave, in a management capacity, in a manner which is inept, incompetent, or dishonest.").
word("mismanage", 'v.', "To manage an area of responsibility in a way which is inept, incompetent, or dishonest.").
word("misnomer", 'n.', "Something asserted not to be true; a myth or mistaken belief").
word("misnomer", 'n.', "A term that is misleading, even if it may not be incorrect.").
word("misogamy", 'n.', "Hatred of or opposition to marriage").
word("misogyny", 'n.', "Hatred of, contempt for, or prejudice against women.").
word("misplace", 'v.', "To put something in the wrong location.").
word("misplace", 'v.', "To apply one's talents inappropriately.").
word("misrepresent", 'v.', "To represent falsely; to inaccurately portray something.").
word("misrule", 'v.', "To rule badly; to misgovern.").
word("misrule", 'v.', "Of a trial judge, to make a bad decision in court.").
word("missal", 'n.', "A book containing the prayers and responses needed when celebrating the Roman Catholic Mass throughout the year.").
word("missal", 'n.', "A prayer book.").
word("missile", 'n.', "Any object used as a weapon by being thrown or fired through the air, such as stone, arrow or bullet.").
word("missile", 'n.', "A self-propelled projectile whose trajectory can be adjusted after it is launched.").
word("missive", 'n.', "A written message; a letter, note or memo.").
word("missive", 'n.', "Letters sent between two parties in which one makes an offer and the other accepts it.").
word("mistrust", 'v.', "To be wary, suspicious or doubtful of (something or someone).").
word("mistrust", 'v.', "To be suspicious.").
word("misty", 'adj.', "With tears in the eyes; dewy-eyed.").
word("misty", 'adj.', "Dim; vague; obscure.").
word("misunderstand", 'v.', "To understand incorrectly, while believing one has understood correctly.").
word("misuse", 'v.', "To abuse verbally, to insult.").
word("misuse", 'v.', "To rape (a woman); later more generally, to sexually abuse (someone).").
word("mite", 'n.', "A small coin formerly circulated in England, rated at about a third of a farthing.").
word("mite", 'n.', "A small or naughty person, or one people take pity on; rascal.").
word("mitigate", 'v.', "To reduce, lessen, or decrease; to make less severe or easier to bear.").
word("mitigate", 'v.', "To downplay.").
word("mnemonics", 'n.', "The study of techniques for remembering anything more easily.").
word("moat", 'n.', "A circular lowland between a resurgent dome and the walls of the caldera surrounding it.").
word("moat", 'n.', "A deep, wide defensive ditch, normally filled with water, surrounding a fortified habitation.").
word("mobocracy", 'n.', "Rule or control by the mob (or by the mass of ordinary people); a mob as a politically powerful force.").
word("moccasin", 'n.', "A traditional Native North American shoe, usually without a heel or sole, made of a piece of deerskin or other soft leather turned up at the edges which are either stitched together at the top of the shoe, or sewn to a vamp (a piece covering the top of the foot).").
word("moccasin", 'n.', "A modern shoe with either a low or no heel resembling a traditional Native American moccasin in that the leather forming the sides of the shoe is stitched at the top.").
word("mockery", 'n.', "Something so lacking in necessary qualities as to inspire ridicule; a laughing-stock.").
word("mockery", 'n.', "The action of mocking; ridicule, derision.").
word("moderation", 'n.', "An instance of moderating: bringing something away from extremes, especially in a beneficial way").
word("moderation", 'n.', "The process of moderating a discussion").
word("moderator", 'n.', "A device used to deaden some of the noise from a firearm, although not to the same extent as a suppressor or silencer.").
word("moderator", 'n.', "The person who presides over a synod of a Presbyterian Church").
word("modernity", 'n.', "The quality of being modern or contemporary.").
word("modernity", 'n.', "Quality of being of the modern period of contemporary historiography.").
word("modernize", 'v.', "To make (something old or outdated) up to date, or modern in style or function by adding or changing equipment, designs, etc.").
word("modernize", 'v.', "To become modern in appearance, or adopt modern ways").
word("modification", 'n.', "The act of making a change to something while keeping its essential character intact; an alteration or adjustment.").
word("modification", 'n.', "A change to an organism as a result of its environment that is not transmissable to offspring.").
word("modify", 'v.', "To qualify the meaning of.").
word("modify", 'v.', "To change part of.").
word("modish", 'adj.', "Conforming with fashion or style.").
word("modish", 'adj.', "In the current mode.").
word("modulate", 'v.', "To change the pitch, intensity or tone of one's voice or of a musical instrument").
word("modulate", 'v.', "To vary the amplitude, frequency or phase of a carrier wave in proportion to the amplitude etc of a source wave (such as speech or music)").
word("mollify", 'v.', "To appease (anger), pacify, gain the good will of.").
word("mollify", 'v.', "To ease a burden, particularly worry; make less painful; to comfort.").
word("momentary", 'adj.', "Ephemeral or relatively short-lived.").
word("momentary", 'adj.', "Happening at every moment; perpetual.").
word("momentous", 'adj.', "Outstanding in importance, of great consequence.").
word("momentum", 'n.', "Of a body in motion: the tendency of a body to maintain its inertial motion; the product of its mass and velocity, or the vector sum of the products of its masses and velocities.").
word("momentum", 'n.', "The impetus, either of a body in motion, or of an idea or course of events; a moment.").
word("monarchy", 'n.', "A form of government where sovereignty is embodied by a single ruler in a state and his high aristocracy representing their separate divided lands within the state and their low aristocracy representing their separate divided fiefs.").
word("monarchy", 'n.', "A government in which sovereignty is embodied within a single, today usually hereditary head of state (whether as a figurehead or as a powerful ruler).").
word("monastery", 'n.', "Building for housing monks or others who have taken religious vows").
word("monetary", 'adj.', "Of, pertaining to, or consisting of money.").
word("mongrel", 'n.', "A thuggish, obnoxious, or contemptible person; a pitiable person.").
word("mongrel", 'n.', "Someone or something of mixed kind or uncertain origin, especially a dog.").
word("monition", 'n.', "A caution or warning.").
word("monition", 'n.', "A sign of impending danger; an omen.").
word("monitory", 'n.', "A written letter giving admonition").
word("monogamy", 'n.', "The practice of being married to one person as opposed to multiple.").
word("monogamy", 'n.', "A form of sexual bonding involving a permanent pair bond between two beings.").
word("monogram", 'n.', "A design composed of one or more letters, often intertwined, used as an identifying mark of an individual or institution.").
word("monogram", 'n.', "A sentence consisting of only one line, or an epigram consisting of only one verse, of poetry.").
word("monograph", 'n.', "A scholarly book or a treatise on a single subject or a group of related subjects, usually written by one person.").
word("monolith", 'n.', "A large, single block of stone which is a natural feature; or a block of stone or other similar material used in architecture and sculpture, especially one carved into a monument in ancient times.").
word("monolith", 'n.', "Anything massive, uniform, and unmovable, especially a towering and impersonal cultural, political, or social organization or structure.").
word("monologue", 'n.', "A long speech by one person in a play; sometimes a soliloquy; other times spoken to other characters.").
word("monologue", 'n.', "A long series of comic stories and jokes as an entertainment.").
word("monomania", 'n.', "A pathological obsession with one person, thing or idea.").
word("monomania", 'n.', "Excessive interest or concentration on a singular object or subject.").
word("monopoly", 'n.', "A situation, by legal privilege or other agreement, in which solely one party (company, cartel etc.) exclusively provides a particular product or service, dominating that market and generally exerting powerful control over it.").
word("monopoly", 'n.', "An exclusive control over the trade or production of a commodity or service through exclusive possession.").
word("monosyllable", 'n.', "A word of one syllable.").
word("monotone", 'n.', "A piece of writing in one strain throughout.").
word("monotone", 'n.', "A single unvaried tone of speech or a sound.").
word("monotonous", 'adj.', "Tedious, repetitious, or lacking in variety.").
word("monotonous", 'adj.', "Having an unvarying pitch or tone.").
word("monotony", 'n.', "Tedium as a result of repetition or a lack of variety.").
word("monotony", 'n.', "The quality of having an unvarying tone or pitch.").
word("monsieur", 'n.', "A man, especially a French gentleman.").
word("monstrosity", 'n.', "An organism showing abnormal development or deformity.").
word("monstrosity", 'n.', "A monstrous person, thing, or act.").
word("moonbeam", 'n.', "Any of various Australasian lycaenid butterflies of the genus .").
word("moonbeam", 'n.', "(definition needed)").
word("morale", 'n.', "The capacity of people to maintain belief in an institution or a goal, or even in oneself and others.").
word("moralist", 'n.', "One who bases all decisions on perceived morals, especially one who enforces them with censorship.").
word("moralist", 'n.', "A teacher of morals; a person who studies morality; a moral philosopher.").
word("morality", 'n.', "A lesson or pronouncement which contains advice about proper behavior.").
word("morality", 'n.', "A particular theory concerning the grounds and nature of rightness, wrongness, good, and evil.").
word("moralize", 'v.', "To render moral; to correct the morals of; to give the appearance of morality to.").
word("moralize", 'v.', "To make moral reflections (on, upon, about or over something); to regard acts and events as involving a moral.").
word("moratorium", 'n.', "An authorization to a debtor, permitting temporary suspension of payments.").
word("moratorium", 'n.', "A suspension of an ongoing activity.").
word("morbid", 'adj.', "Taking an interest in unhealthy or unwholesome subjects such as death, decay, disease.").
word("morbid", 'adj.', "Of, or relating to disease.").
word("mordacious", 'adj.', "Prone to biting, aggressive (of an animal etc.).").
word("mordacious", 'adj.', "Biting, causing a physical bite or sting; corrosive").
word("mordant", 'adj.', "Having or showing a sharp or critical quality").
word("mordant", 'adj.', "Serving to fix a dye to a fibre.").
word("moribund", 'adj.', "Almost obsolete, nearing an end.").
word("moribund", 'adj.', "Approaching death; about to die; dying; expiring.").
word("morose", 'adj.', "Sullen, gloomy; showing a brooding ill humour.").
word("morphology", 'n.', "A description of the form and structure of something.").
word("morphology", 'n.', "The form and structure of something.").
word("motley", 'adj.', "Comprising greatly varied elements, to the point of incongruity.").
word("motley", 'adj.', "Having many colours; variegated.").
word("motto", 'n.', "A sentence, phrase, or word, prefixed to an essay, discourse, chapter, canto, or the like, suggestive of its subject matter; a short, suggestive expression of a guiding principle; a maxim.").
word("motto", 'n.', "A sentence, phrase, or word, forming part of an heraldic achievement.").
word("mountaineer", 'n.', "A person who climbs mountains for sport or pleasure.").
word("mountaineer", 'n.', "A person who lives in a mountainous area (often with the connotation that such people are outlaws or uncivilized).").
word("mountainous", 'adj.', "Very difficult.").
word("mountainous", 'adj.', "Inhabiting mountains; barbarous.").
word("mouthful", 'n.', "A tirade of abusive language.").
word("mouthful", 'n.', "Something difficult to pronounce or say.").
word("muddle", 'v.', "To cloud or stupefy; to render stupid with liquor; to intoxicate partially.").
word("muddle", 'v.', "To waste or misuse, as one does who is stupid or intoxicated.").
word("muffle", 'v.', "To prevent seeing, or hearing, or speaking, by wraps bound about the head; to blindfold; to deafen.").
word("muffle", 'v.', "To wrap up or cover (a source of noise) in order to deaden the sound.").
word("mulatto", 'n.', "A person of mixed black and white descent, especially a person with one black and one white parent or two mulatto parents.").
word("muleteer", 'n.', "A mule driver.").
word("multiform", 'adj.', "Having more than one shape or appearance.").
word("multiplicity", 'n.', "The number of values for which a given condition holds.").
word("multiplicity", 'n.', "The number of instances that can occur on a given end of a relationship, including 0..1, 1, 0..* or *, and 1..*.").
word("mundane", 'adj.', "Pertaining to the Universe, cosmos or physical reality, as opposed to the spiritual world.").
word("mundane", 'adj.', "Worldly, earthly, profane, vulgar as opposed to heavenly.").
word("municipal", 'adj.', "Of or pertaining to the internal affairs of a nation.").
word("municipal", 'adj.', "Of or pertaining to a municipality (a city or a corporation having the right of administering local government).").
word("municipality", 'n.', "A district with a government that typically encloses no other governed districts; a borough, city, or incorporated town or village.").
word("municipality", 'n.', "The governing body of such a district.").
word("munificence", 'n.', "Means of defence; fortification.").
word("munificence", 'n.', "The quality of being munificent; generosity.").
word("munificent", 'adj.', "Very generous; lavish.").
word("munificent", 'adj.', "Very liberal in giving or bestowing.").
word("muster", 'n.', "Showing.").
word("mutation", 'n.', "Any heritable change of the base-pair sequence of genetic material.").
word("mutation", 'n.', "Any alteration or change.").
word("mutilate", 'v.', "To destroy beyond recognition.").
word("mutilate", 'v.', "To physically harm as to impair use, notably by cutting off or otherwise disabling a vital part, such as a limb.").
word("mutiny", 'n.', "An organized rebellion against a legally constituted authority, especially by seamen against their officers.").
word("mutiny", 'n.', "Violent commotion; tumult; strife.").
word("myriad", 'n.', "A countless number or multitude (of specified things)").
word("myriad", 'n.', "Ten thousand; 10,000").
word("mystic", 'n.', "Someone who practices mysticism.").
word("mystification", 'n.', "A mystifying thing.").
word("mystification", 'n.', "The act of mystifying or the condition of being mystified.").
word("myth", 'n.', "A commonly-held but false belief, a common misconception; a fictitious or imaginary person or thing; a popular conception about a real person or event which exaggerates or idealizes reality.").
word("myth", 'n.', "A traditional story which embodies a belief regarding some fact or phenomenon of experience, and in which often the forces of nature and of the soul are personified; a sacred narrative regarding a god, a hero, the origin of the world or of a people, etc.").
word("mythology", 'n.', "A similar body of myths concerning an event, person or institution.").
word("mythology", 'n.', "The collection of myths of a people, concerning the origin of the people, history, deities, ancestors and heroes.").
word("nameless", 'adj.', "Not having a name; unnamed.").
word("nameless", 'adj.', "Whose name is unknown; unidentified or obscure; anonymous.").
word("naphtha", 'n.', "Any of a wide variety of aliphatic or aromatic liquid hydrocarbon mixtures distilled from petroleum or coal tar, especially as used in solvents or petrol.").
word("naphtha", 'n.', "Naturally occurring liquid petroleum.").
word("narcissus", 'n.', "Any of several bulbous flowering plants, of the genus Narcissus, having white or yellow cup- or trumpet-shaped flowers, notably the daffodil").
word("narcissus", 'n.', "A beautiful young man, like the mythological Greek Narcissus").
word("narrate", 'v.', "To give an account.").
word("narrate", 'v.', "To relate (a story or series of events) in speech or writing.").
word("narration", 'n.', "The act of recounting or relating in order the particulars of some action, occurrence, or affair; a narrating.").
word("narration", 'n.', "That which is narrated or recounted; an orderly recital of the details and particulars of some transaction or event, or of a series of transactions or events; a story or narrative.").
word("narrative", 'n.', "The systematic recitation of an event or series of events.").
word("narrative", 'n.', "A representation of an event or story in a way to promote a certain point of view.").
word("narrator", 'n.', "One who narrates or tells stories.").
word("narrator", 'n.', "The person providing the voice-over in a documentary.").
word("nasal", 'adj.', "Having a sound imparted by means of the nose; and specifically, made by lowering the soft palate, in some cases with closure of the oral passage, the voice thus issuing (wholly or partially) through the nose, as in the consonants m, n, ng.").
word("nasal", 'adj.', "Of or pertaining to the nose or to the nasion.").
word("natal", 'adj.', "Of or relating to birth.").
word("natal", 'adj.', "Of or relating to the buttocks.").
word("nationality", 'n.', "A people sharing a common origin, culture and/or language, and possibly constituting a nation-state.").
word("nationality", 'n.', "National origin or identity; legal membership of a particular nation or state, by origin, birth, naturalization, ownership, allegiance or otherwise.").
word("naturally", 'adv.', "Surely or without any doubt.").
word("naturally", 'adv.', "Inherently or by nature.").
word("nausea", 'n.', "A feeling of illness or discomfort in the digestive system, usually characterized by a strong urge to vomit.").
word("nausea", 'n.', "Strong dislike or disgust.").
word("nauseate", 'v.', "To be disgusted by (something).").
word("nauseate", 'v.', "To disgust.").
word("nauseous", 'adj.', "Causing nausea; sickening or disgusting.").
word("nauseous", 'adj.', "Inclined to nausea; sickly, squeamish.").
word("nautical", 'adj.', "Relating to or involving ships or shipping or navigation or seamen.").
word("naval", 'adj.', "Of or relating to ships in general.").
word("naval", 'adj.', "Of or relating to a navy.").
word("navel", 'n.', "The indentation or bump remaining in the abdomen of mammals where the umbilical cord was attached before birth.").
word("navel", 'n.', "The central part or point of anything; the middle.").
word("navigable", 'adj.', "Steerable, dirigible.").
word("navigable", 'adj.', "Capable of being navigated; deep enough and wide enough to afford passage to vessels.").
word("navigate", 'v.', "To travel over water in a ship; to sail.").
word("navigate", 'v.', "To move between web pages, menus, etc. by means of hyperlinks, mouse clicks, or any other mechanism.").
word("nebula", 'n.', "A white spot or slight opacity of the cornea.").
word("nebula", 'n.', "A cloud in outer space consisting of gas or dust (e.g. a cloud formed after a star explodes).").
word("necessary", 'adj.', "Required, essential, whether logically inescapable or needed in order to achieve a desired result or avoid some penalty.").
word("necessary", 'adj.', "Determined, involuntary: acting from compulsion rather than free will.").
word("necessitate", 'v.', "To make necessary; to behove; to require (something) to be brought about.").
word("necessity", 'n.', "Indispensable requirements (of life).").
word("necessity", 'n.', "Something which makes an act or an event unavoidable; an irresistible force; overruling power.").
word("necrology", 'n.', "A listing of people who have died during a specific period of time.").
word("necrology", 'n.', "A church register containing the names of those connected with the church who have died.").
word("necromancer", 'n.', "A person who practices or performs necromancy.").
word("necropolis", 'n.', "An ancient site used for burying the dead, particularly if consisting of elaborate grave monuments.").
word("necropolis", 'n.', "A cemetery; especially a large one in or near a city.").
word("necrosis", 'n.', "The localized death of cells or tissues through injury, disease, or the interruption of blood supply.").
word("nectar", 'n.', "Any delicious drink, now especially a type of sweetened fruit juice.").
word("nectar", 'n.', "The sweet liquid secreted by flowers to attract pollinating insects and birds.").
word("nectarine", 'n.', "A cultivar of the peach distinguished by its skin being smooth, not fuzzy.").
word("nectarine", 'n.', "A nectar-like liquid medicine.").
word("needlework", 'n.', "The product of such art or process.").
word("needlework", 'n.', "The occupation or employment of a person skilled in embroidery, needlepoint, etc.").
word("needy", 'adj.', "Desiring constant affirmation; lacking self-confidence.").
word("needy", 'adj.', "In need; poor.").
word("nefarious", 'adj.', "Sinful, villainous, criminal, or wicked, especially when noteworthy or notorious for such characteristics.").
word("negate", 'v.', "To deny the existence, evidence, or truth of; to contradict.").
word("negate", 'v.', "To nullify or cause to be ineffective.").
word("negation", 'n.', "A proposition which is the contradictory of another proposition and which can be obtained from that other proposition by the appropriately placed addition/insertion of the word \"not\". (Or, in symbolic logic, by prepending that proposition with the symbol for the logical operator \"not\".)").
word("negation", 'n.', "The act of negating something.").
word("neglectful", 'adj.', "Tending to neglect; failing to take care of matters which require attention.").
word("negligence", 'n.', "The breach of a duty of care: the failure to exercise a standard of care that a reasonable person would have in a similar situation.").
word("negligence", 'n.', "The tort whereby a duty of reasonable care was breached, causing damage: any conduct short of intentional or reckless action that falls below the legal standard for preventing unreasonable injury.").
word("negligent", 'adj.', "Careless or inattentive.").
word("negligent", 'adj.', "Culpable due to negligence.").
word("negligible", 'adj.', "Able to be neglected, ignored or excluded from consideration; too small or unimportant to be of concern.").
word("nemesis", 'n.', "A person or character who specifically brings about the downfall of another person or character.").
word("nemesis", 'n.', "A punishment or defeat that is deserved and cannot be avoided.").
word("neocracy", 'n.', "Government by the new or inexperienced.").
word("neolithic", 'adj.', "Hopelessly outdated").
word("neology", 'n.', "The study or art of neologizing (creating new words).").
word("neology", 'n.', "The holding of novel or rational religious views.").
word("neopaganism", 'n.', "A modern or revived form of paganism; modern pagan religion.").
word("nestle", 'v.', "To settle oneself comfortably and snugly.").
word("nestle", 'v.', "Of a bird: to look after its young.").
word("nettle", 'v.', "To pique, irritate, vex or provoke.").
word("nettle", 'v.', "Of the nettle plant and similar physical causes, to sting, causing a rash in someone.").
word("network", 'n.', "A directory of people maintained for their advancement").
word("network", 'n.', "Any interconnected group or system").
word("neural", 'adj.', "Of, or relating to the nerves, neurons or the nervous system.").
word("neural", 'adj.', "Modelled on the arrangement of neurons in the brain.").
word("neurology", 'n.', "The branch of medicine that deals with the disorders of nervous system including the brain and spinal cord of the central nervous system and the nerves, muscles, and neuromuscular junction of the peripheral nervous system.").
word("neurology", 'n.', "Focal neurologic signs; focal neurologic deficits.").
word("neuter", 'adj.', "Having a form which is not masculine nor feminine; or having a form which is not of common gender.").
word("neuter", 'adj.', "Sexless, nonsexual.").
word("neutral", 'adj.', "Favouring neither the supporting nor opposing viewpoint of a topic of debate; unbiased.").
word("neutral", 'adj.', "Neither positive nor negative; possessing no charge or equivalent positive and negative charge such that there is no imbalance.").
word("niggardly", 'adj.', "Withholding for the sake of meanness; stingy, miserly.").
word("nihilist", 'n.', "An absolute skeptic; a person who believes in the truth of nothing.").
word("nihilist", 'n.', "A person who accepts or champions nihilism.").
word("nil", 'n.', "Nothing; zero.").
word("nil", 'n.', "A score of zero").
word("nimble", 'adj.', "Quick and light in movement or action.").
word("nimble", 'adj.', "Quick-witted and alert.").
word("nit", 'n.', "The egg of a louse.").
word("nit", 'n.', "A head louse regardless of its age.").
word("nocturnal", 'adj.', "Primarily active during the night.").
word("nocturnal", 'adj.', "Taking place at night, nightly.").
word("noiseless", 'adj.', "Producing no noise; without noise.").
word("noisome", 'adj.', "Offensive to the senses; disgusting, unpleasant, nauseous, especially having an undesirable smell.").
word("noisome", 'adj.', "Hurtful or noxious to health; unwholesome, insalubrious.").
word("noisy", 'adj.', "Unpleasant-looking and causing unwanted attention").
word("noisy", 'adj.', "Full of noise.").
word("nomic", 'adj.', "Customary; ordinary; applied to the usual spelling of a language, in distinction from strictly phonetic methods.").
word("nomic", 'adj.', "Relating to a law").
word("nominal", 'adj.', "Assigned to or bearing a person's name.").
word("nominal", 'adj.', "Existing in name only.").
word("nominate", 'v.', "To name someone as a candidate for a particular role or position, including that of an office.").
word("nominate", 'v.', "To entitle, confer a name upon.").
word("nomination", 'n.', "An act or instance of nominating.").
word("nomination", 'n.', "A device or means by which a person or thing is nominated.").
word("nominee", 'n.', "A person to whom the holder of a copyhold estate surrenders their interest.").
word("nominee", 'n.', "A person named, or designated, by another, to any office, duty, or position; one nominated, or proposed, by others for office or for election to office.").
word("nonchalance", 'n.', "Indifference, unconcern; carelessness; coolness; disregard, detachment.").
word("nondescript", 'adj.', "Without distinguishing qualities or characteristics.").
word("nondescript", 'adj.', "Not described (in the academic literature).").
word("nonentity", 'n.', "An unimportant or insignificant person").
word("nonentity", 'n.', ": the state of not existing; nonexistence").
word("nonpareil", 'n.', "The size of type between ruby and emerald (or, in the United States, between agate and minion), standardized as 6-point; a slug of this size.").
word("nonpareil", 'n.', "A person or thing that has no equal; a paragon.").
word("norm", 'n.', "A rule that is imposed by regulations and/or socially enforced by members of a community.").
word("norm", 'n.', "A high level of performance in a chess tournament, several of which are required for a player to receive a title.").
word("normalcy", 'n.', "The state of being normal; the fact of being normal; normality.").
word("nostrum", 'n.', "A medicine or remedy in conventional use which has not been proven to have any desirable medical effects.").
word("nostrum", 'n.', "An ineffective but favorite remedy for a problem, usually involving political action.").
word("noticeable", 'adj.', "Worthy of note; significant.").
word("noticeable", 'adj.', "Capable of being seen or noticed.").
word("notorious", 'adj.', "Widely known, especially for something negative; infamous.").
word("novice", 'n.', "A beginner; one who is not very familiar or experienced in a particular subject.").
word("novice", 'n.', "A new member of a religious order accepted on a conditional basis, prior to confirmation.").
word("nowadays", 'adv.', "At the present time; in the current era.").
word("nowhere", 'adv.', "In no place.").
word("nowhere", 'adv.', "To no place.").
word("noxious", 'adj.', "Harmful; injurious.").
word("nuance", 'n.', "Subtlety or fine detail.").
word("nuance", 'n.', "A minor distinction.").
word("nucleus", 'n.', "The core, central part of something, around which other elements are assembled.").
word("nucleus", 'n.', "An initial part or version that will receive additions.").
word("nude", 'adj.', "Not valid; void.").
word("nude", 'adj.', "Without clothing or other covering of the skin; without clothing on the genitals or female nipples.").
word("nugatory", 'adj.', "Having no force, inoperative, ineffectual.").
word("nugatory", 'adj.', "Ineffective, invalid or futile.").
word("nuisance", 'n.', "Anything harmful or offensive to the community or to a member of it, for which a legal remedy exists.").
word("nuisance", 'n.', "A person or thing causing annoyance or inconvenience.").
word("numeration", 'n.', "The act of counting or numbering things; enumeration.").
word("numeration", 'n.', "Any system of giving names to numbers.").
word("numerical", 'adj.', "Of or pertaining to numbers").
word("numerical", 'adj.', "The same in number; hence, identically the same; identical.").
word("nunnery", 'n.', "A place of residence for nuns; a convent").
word("nunnery", 'n.', "A brothel").
word("nuptial", 'adj.', "Of or pertaining to wedding and marriage.").
word("nuptial", 'adj.', "Capable, or characteristic, of breeding.").
word("nurture", 'n.', "The act of nourishing or nursing; tender care").
word("nurture", 'n.', "The environmental influences that contribute to the development of an individual (as opposed to \"nature\").").
word("nutriment", 'n.', "A source of nourishment; food.").
word("nutriment", 'n.', "Something that promotes growth or development; a nutrient.").
word("nutritive", 'adj.', "Of or pertaining to nutrition.").
word("nutritive", 'adj.', "Nourishing, nutritional.").
word("oaken", 'adj.', "Made from the wood of the oak tree. Also in metaphorical uses, suggesting robustness.").
word("oakum", 'n.', "The coarse portion separated from flax or hemp in hackling.").
word("oakum", 'n.', "A material, consisting of tarred fibres, used to caulk or pack joints in plumbing, masonry, and wooden shipbuilding.").
word("obdurate", 'adj.', "Physically hardened, toughened.").
word("obdurate", 'adj.', "Stubbornly persistent, generally in wrongdoing; refusing to reform or repent.").
word("obelisk", 'n.', "A tall, square, tapered, stone monolith topped with a pyramidal point, frequently used as a monument.").
word("obese", 'adj.', "Extremely overweight, especially: weighing more than 20% (for men) or 25% (for women) over their ideal weight determined by height and build; or, having a body mass index over 30 kg/m 2 .").
word("obesity", 'n.', "The state of being obese due to an excess of body fat.").
word("obituary", 'adj.', "Relating to the death of a person.").
word("objective", 'adj.', "Based on observed facts; without subjective assessment.").
word("objective", 'adj.', "Not influenced by the emotions or prejudices.").
word("objector", 'n.', "A person who objects to something.").
word("obligate", 'v.', "To commit (money, for example) in order to fulfill an obligation.").
word("obligate", 'v.', "To bind, compel, constrain, or oblige by a social, legal, or moral tie.").
word("obligatory", 'adj.', "Imposing obligation, legally, morally, or otherwise; binding; mandatory.").
word("obligatory", 'adj.', "Requiring a matter or obligation.").
word("oblique", 'adj.', "Not direct in descent; not following the line of father and son; collateral.").
word("oblique", 'adj.', "Not erect or perpendicular; not parallel to, or at right angles from, the base").
word("obliterate", 'v.', "To remove completely, leaving no trace; to wipe out; to destroy.").
word("oblivion", 'n.', "The state of being completely forgotten, of being reduced to a state of non-existence, extinction, or nothingness, incl. through war and destruction. for an area like hell, a wasteland.").
word("oblivion", 'n.', "The state of forgetting completely, of being oblivious, unconscious, unaware, as when sleeping, drunk, or dead.").
word("oblong", 'adj.', "Having a length and width that are different; not square or circular.").
word("oblong", 'adj.', "Roughly rectangular or elliptical.").
word("obnoxious", 'adj.', "Extremely unpleasant or offensive; very annoying, odious or contemptible.").
word("obnoxious", 'adj.', "Exposing to harm or injury.").
word("obsequies", 'n.', "Funeral rites.").
word("obsequious", 'adj.', "Excessively eager and attentive to please or to obey instructions; fawning, subservient, servile.").
word("obsequious", 'adj.', "Obedient; compliant with someone else's orders or wishes.").
word("observance", 'n.', "The custom of celebrating a holiday or similar occasion.").
word("observance", 'n.', "The practice of complying with a law, custom, command or rule.").
word("observant", 'adj.', "Alert and paying close attention; watchful.").
word("observant", 'adj.', "Diligently attentive in observing a law, custom, duty or principle; regardful; mindful.").
word("observatory", 'n.', "A lookout").
word("observatory", 'n.', "A place where stars, planets and other celestial bodies are observed, usually through a telescope; also place for observing meteorological or other natural phenomena.").
word("obsolescence", 'n.', "The state of being obsolete—no longer in use; gone into disuse; disused or neglected.").
word("obsolescence", 'n.', "The process of becoming obsolete, outmoded or out of date.").
word("obsolescent", 'adj.', "In the process of becoming obsolete, but not obsolete yet.").
word("obsolete", 'adj.', "No longer in use; gone into disuse; disused or neglected (often in favour of something newer).").
word("obsolete", 'adj.', "Imperfectly developed; not very distinct.").
word("obstetrician", 'n.', "A physician who specializes in childbirth.").
word("obstetrics", 'n.', "The care of women during and after pregnancy").
word("obstinacy", 'n.', "The state, or an act, of stubbornness or doggedness.").
word("obstreperous", 'adj.', "Attended by, or making, a loud and tumultuous noise; boisterous.").
word("obstreperous", 'adj.', "Stubbornly defiant; disobedient; resistant to authority or control, whether in a noisy manner or not.").
word("obstruct", 'v.', "To block or fill (a passage) with obstacles or an obstacle.").
word("obstruct", 'v.', "To get in the way of so as to hide from sight.").
word("obstruction", 'n.', "Something which obstructs or impedes, either intentionally or unintentionally").
word("obstruction", 'n.', "The act of obstructing, or state of being obstructed.").
word("obtrude", 'v.', "To become apparent in an unwelcome way, to be forcibly imposed; to jut in, to intrude.").
word("obtrude", 'v.', "To proffer (something) by force; to impose (something) someone or some area.").
word("obtrusive", 'adj.', "Sticking out; protruding.").
word("obtrusive", 'adj.', "Pushy.").
word("obvert", 'v.', "To turn so as to show another side.").
word("obvert", 'v.', "To turn towards the front.").
word("obviate", 'v.', "To avoid (a future problem or difficult situation).").
word("obviate", 'v.', "To anticipate and prevent or bypass (something which would otherwise have been necessary or required).").
word("occasion", 'n.', "An occurrence or state of affairs which causes some event or reaction; a motive or reason.").
word("occasion", 'n.', "A particular happening; an instance or time when something occurred.").
word("occident", 'n.', "The Western world; the part of the world excluding Asia").
word("occident", 'n.', "The part of the horizon where the sun last appears in the evening; that part of the earth towards the sunset; the west.").
word("occlude", 'v.', "To absorb, as a gas by a metal.").
word("occlude", 'v.', "To obstruct, cover, or otherwise block (an opening, a portion of an image, etc.).").
word("occult", 'adj.', "Secret; hidden from general knowledge; undetected.").
word("occult", 'adj.', "Esoteric.").
word("occupant", 'n.', "The owner or tenant of a property.").
word("occupant", 'n.', "A person who occupies an office or a position.").
word("occurrence", 'n.', "An actual instance when a situation occurs; an event or happening.").
word("occurrence", 'n.', "The lexical aspect (aktionsart) of verbs or predicates that change in or over time.").
word("octagon", 'n.', "A polygon with eight sides and eight angles.").
word("octagon", 'n.', "Often in the form ' ': the arena for mixed martial arts.").
word("octave", 'n.', "An interval of twelve semitones spanning eight degrees of the diatonic scale, representing a doubling or halving in pitch frequency.").
word("octave", 'n.', "Any of a number of coherent-noise functions of differing frequency that are added together to form Perlin noise.").
word("octavo", 'n.', "A sheet of paper 7 to 10 inches (= 17.78 to 25.4 cm) high and 4.5 to 6 inches (= 11.43 to 15.24 cm) wide, the size varying with the large original sheet used to create it. It is made by folding the original sheet three times to produce eight leaves.").
word("octavo", 'n.', "A book of octavo pages.").
word("octogenarian", 'adj.', "Being between the age of 80 and 89, inclusive").
word("octogenarian", 'adj.', "Of or relating to an octogenarian").
word("ocular", 'adj.', "Of, or relating to the eye, or the sense of sight").
word("ocular", 'adj.', "Seen by, or seeing with, the eye; visual.").
word("oculist", 'n.', "An ophthalmologist").
word("oculist", 'n.', "An optometrist").
word("oddity", 'n.', "An odd or strange thing or opinion.").
word("oddity", 'n.', "Strangeness.").
word("ode", 'n.', "A short poetical composition proper to be set to music or sung; a lyric poem; especially, now, a poem characterized by sustained noble sentiment and appropriate dignity of style.").
word("odious", 'adj.', "Arousing or meriting strong dislike, aversion, or intense displeasure.").
word("odium", 'n.', "The quality that provokes hatred; offensiveness.").
word("odium", 'n.', "Hatred; dislike.").
word("odoriferous", 'adj.', "Having an odor or fragrance.").
word("odorous", 'adj.', "Having a distinctive odor.").
word("off", 'adj.', "Less than normal, in temperament or in result.").
word("off", 'adj.', "Started on the way.").
word("offhand", 'adv.', "Right away, immediately, without thinking about it.").
word("offhand", 'adv.', "In an manner.").
word("officiate", 'v.', "To serve as umpire or referee.").
word("officiate", 'v.', "To perform the functions of some office.").
word("officious", 'adj.', "Offensively intrusive or interfering in offering advice and services.").
word("officious", 'adj.', "Obliging, attentive, eager to please.").
word("offshoot", 'n.', "That which shoots off or separates from a main stem or branch of a plant.").
word("offshoot", 'n.', "That which develops from something else.").
word("ogre", 'n.', "A type of brutish giant from folk tales that eats human flesh.").
word("ogre", 'n.', "A brutish man reminiscent of the mythical ogre.").
word("ointment", 'n.', "A substance used to anoint, as in religious rituals.").
word("ointment", 'n.', "A viscous preparation of oils and/or fats, usually containing medication, used as a treatment or as an emollient.").
word("olfactory", 'adj.', "Concerning the sense of smell.").
word("ominous", 'adj.', "Of or pertaining to an omen or to omens; being or exhibiting an omen; significant.").
word("ominous", 'adj.', "Specifically, giving indication of a coming ill; being an evil omen").
word("omission", 'n.', "Something not done or neglected.").
word("omission", 'n.', "An instance of those acts, or the thing left out thereby; something deleted or left out.").
word("omnipotence", 'n.', "Unlimited power; commonly attributed to a deity or deities.").
word("omnipotent", 'adj.', "Having unlimited power, force or authority.").
word("omnipotent", 'adj.', "Describing a cell (especially a stem cell) that is capable of developing into any type of cell or forming any type of tissue (also called a totipotent cell). See also pluripotent.").
word("omniscience", 'n.', "The capacity to know everything.").
word("omniscient", 'adj.', "Having total knowledge.").
word("omnivorous", 'adj.', "Having an interest in a variety of subjects.").
word("omnivorous", 'adj.', "All-consuming.").
word("onerous", 'adj.', "Imposing or constituting a physical, mental, or figurative load which can be borne only with effort; burdensome.").
word("onrush", 'n.', "A forceful rush or flow forward.").
word("onrush", 'n.', "An aggressive assault.").
word("onset", 'n.', "An attack; an assault especially of an army.").
word("onset", 'n.', "The beginning of a musical note or other sound, in which the amplitude rises from zero to an initial peak.").
word("onslaught", 'n.', "A fierce attack.").
word("onslaught", 'n.', "A large number of people or things resembling an attack.").
word("onus", 'n.', "Responsibility; burden.").
word("onus", 'n.', "A legal obligation.").
word("opalescence", 'n.', "The milky iridescent appearance of a dense transparent medium when it is illuminated by polychromatic visible radiation (such as sunlight) due to local fluctuations in its density and therefore in its refractive index").
word("opalescence", 'n.', "The state of being opalescent").
word("opaque", 'adj.', "Allowing little light to pass through, not translucent or transparent.").
word("opaque", 'adj.', "Neither reflecting nor emitting light.").
word("operate", 'v.', "To perform some manual act upon a human body in a methodical manner, and usually with instruments, with a view to restore soundness or health, as in amputation, lithotomy, etc.").
word("operate", 'v.', "To act or produce effect on the mind; to exert moral power or influence.").
word("operative", 'adj.', "Having the power of acting; hence, exerting force, physical or moral; active in the production of effects.").
word("operative", 'adj.', "Producing the appropriate or designed effect; efficacious.").
word("operator", 'n.', "A person who is adept at making deals or getting results, especially one who uses questionable methods.").
word("operator", 'n.', "The game of Chinese whispers.").
word("operetta", 'n.', "A lighter version of opera with a frivolous story and spoken dialogue.").
word("opinion", 'n.', "A belief, judgment or perspective that a person has formed, either through objective or subjective reasoning, about a topic, issue, person or thing.").
word("opinion", 'n.', "The formal decision, or expression of views, of a judge, an umpire, a doctor, or other party officially called upon to consider and decide upon a matter or point submitted.").
word("opponent", 'n.', "One who opposes another; one who works or takes a position against someone or something; one who attempts to stop the progress of someone or something.").
word("opportune", 'adj.', "At a convenient or advantageous time.").
word("opportune", 'adj.', "Suitable for some particular purpose.").
word("opportunist", 'n.', "Someone who takes advantage of any opportunity to advance their own situation, placing expediency above principle.").
word("opportunity", 'n.', "A chance for advancement, progress or profit.").
word("opportunity", 'n.', "A favorable circumstance or occasion.").
word("opposite", 'adj.', "Extremely different; inconsistent; contrary; repugnant; antagonistic.").
word("opposite", 'adj.', "Facing in the other direction.").
word("opprobrium", 'n.', "Scornful reproach or contempt.").
word("opprobrium", 'n.', "A cause of shame or disgrace.").
word("optic", 'n.', "An eye.").
word("optic", 'n.', "A measuring device with a small window, attached to an upside-down bottle, used to dispense alcoholic drinks in a bar.").
word("optician", 'n.', "A person who makes or dispenses lenses, spectacles.").
word("optician", 'n.', "A person who sells lenses, spectacles etc.").
word("optics", 'n.', "The physics of light and vision.").
word("optics", 'n.', "The light-related aspects of a device.").
word("optimism", 'n.', "The doctrine that this world is the best of all possible worlds").
word("optimism", 'n.', "A tendency to expect the best, or at least, a favourable outcome").
word("option", 'n.', "The freedom or right to choose.").
word("option", 'n.', "A contract giving the holder the right to buy or sell an asset at a set strike price; can apply to financial market transactions, or to ordinary transactions for tangible assets such as a residence or automobile.").
word("optometry", 'n.', "The art and science of vision and eye care.").
word("opulence", 'n.', "Abundance, bounty, profusion").
word("opulence", 'n.', "Ostentatious display of wealth and luxury; plushness.").
word("opulent", 'adj.', "Luxuriant, and ostentatiously magnificent.").
word("opulent", 'adj.', "Rich, sumptuous and extravagant.").
word("oral", 'adj.', "Relating to the mouth.").
word("oral", 'adj.', "Spoken rather than written.").
word("orate", 'v.', "To speak passionately; to preach for or against something.").
word("orate", 'v.', "To speak formally; to give a speech.").
word("oration", 'n.', "A formal, often ceremonial speech.").
word("oration", 'n.', "A specific form of short, solemn prayer said by the president of the liturgical celebration on behalf of the people.").
word("orator", 'n.', "Someone sent to speak for someone else; an envoy, a messenger.").
word("orator", 'n.', "A skilled and eloquent public speaker.").
word("oratorio", 'n.', "A musical composition, often based on a religious theme; similar to opera but with no costume, scenery or acting.").
word("oratory", 'n.', "The art of public speaking, especially in a formal, expressive, or forceful manner.").
word("oratory", 'n.', "Eloquence; the quality of artistry and persuasiveness in speech or writing.").
word("ordeal", 'n.', "A trial in which the accused was subjected to a dangerous test (such as ducking in water), divine authority deciding the guilt of the accused.").
word("ordeal", 'n.', "A painful or trying experience.").
word("ordinal", 'n.', "A book used in the ordination of Anglican ministers, or in certain Roman Catholic services").
word("ordinal", 'n.', "An ordinal number such as first, second and third.").
word("ordination", 'n.', "The ceremony in which a priest is consecrated, considered a sacrament in the Catholic and Orthodox churches.").
word("ordination", 'n.', "The act of ordaining or the state of being ordained.").
word("ordnance", 'n.', "Military equipment, especially weapons and ammunition.").
word("ordnance", 'n.', "Artillery.").
word("orgy", 'n.', "A gathering of people to engage in group sex.").
word("orgy", 'n.', "Excessive indulgence in a specified activity.").
word("origin", 'n.', "The point at which the axes of a coordinate system intersect.").
word("origin", 'n.', "The beginning of something.").
word("original", 'adj.', "First in a series or copies/versions").
word("original", 'adj.', "Pioneering").
word("originate", 'v.', "To cause (someone or something) to be; to bring (someone or something) into existence; to produce or initiate a person or thing.").
word("originate", 'v.', "To come into existence; to have origin or beginning; to spring, be derived ( , ).").
word("ornate", 'adj.', "Finely finished, as a style of composition.").
word("ornate", 'adj.', "Flashy, flowery or showy").
word("orthodox", 'adj.', "Conforming to the accepted, established, or traditional doctrines of a given faith, religion, or ideology.").
word("orthodox", 'adj.', "Adhering to whatever is customary, traditional, or generally accepted.").
word("orthodoxy", 'n.', "Conformity to established and accepted beliefs (usually of religions).").
word("orthodoxy", 'n.', "Correctness in doctrine and belief.").
word("orthogonal", 'adj.', "Of two objects, at right angles; perpendicular to each other.").
word("orthogonal", 'adj.', "Of two or more aspects of a problem, able to be treated separately.").
word("orthopedic", 'adj.', "Of, or relating to orthopedics.").
word("orthopedist", 'n.', "A surgeon who specializes in orthopedics.").
word("oscillate", 'v.', "To swing back and forth, especially if with a regular rhythm.").
word("oscillate", 'v.', "To vary above and below a mean value.").
word("osculate", 'v.', "To kiss someone or something.").
word("osculate", 'v.', "To form a connecting link between two genera.").
word("ossify", 'v.', "To transform (or cause to transform) from a softer animal substance into bone; particularly the processes of growth in humans and animals.").
word("ossify", 'v.', "To become (or cause to become) inflexible and rigid in habits or opinions.").
word("ostentation", 'n.', "Ambitious display; vain show; display intended to excite admiration or applause.").
word("ostentation", 'n.', "A show or spectacle.").
word("ostracism", 'n.', "Temporary exclusion from a community or society.").
word("ostracism", 'n.', "In ancient Athens (and some other cities), the temporary banishment by popular vote of a citizen considered dangerous to the state.").
word("ostracize", 'v.', "To exclude a person from a community or from society by not communicating with them or by refusing to acknowledge their presence; to refuse to associate with or talk to; to shun.").
word("ostracize", 'v.', "To ban a person from a city for five or ten years through the procedure of ostracism.").
word("ought", 'v.', "Indicating duty or obligation.").
word("ought", 'v.', "Indicating advisability or prudence.").
word("oust", 'v.', "To expel; to remove.").
word("outbreak", 'n.', "An eruption; the sudden appearance of a rash, disease, etc.").
word("outbreak", 'n.', "An outburst or sudden eruption, especially of violence and mischief.").
word("outburst", 'n.', "A sudden, often violent expression of emotion or activity.").
word("outcast", 'n.', "One that has been excluded from a society or system, a pariah.").
word("outcast", 'n.', "The amount of increase in bulk of grain in malting.").
word("outcry", 'n.', "A loud cry or uproar.").
word("outcry", 'n.', "An auction.").
word("outdo", 'v.', "To excel; go beyond in performance; surpass.").
word("outlandish", 'adj.', "Bizarre; strange.").
word("outlandish", 'adj.', "Foreign; alien.").
word("outlast", 'v.', "To live, last or remain longer than.").
word("outlaw", 'n.', "A criminal who is excluded from normal legal rights; one who can be killed at will without legal penalty.").
word("outlaw", 'n.', "An in-law: a relative by marriage.").
word("outlive", 'v.', "To live longer than; continue to live after the death of; overlive; survive.").
word("outlive", 'v.', "To live longer; continue to live.").
word("outpost", 'n.', "A military post stationed at a distance from the main body of troops.").
word("outpost", 'n.', "The body of troops manning such a post.").
word("outrage", 'n.', "An offensive, immoral or indecent act.").
word("outrage", 'n.', "An excessively violent or vicious attack; an atrocity.").
word("outrageous", 'adj.', "Transgressing reasonable limits; extravagant, immoderate.").
word("outrageous", 'adj.', "Violating morality or decency; provoking indignation or affront.").
word("outreach", 'v.', "To go too far.").
word("outreach", 'v.', "To provide charitable or religious services to people who would otherwise not have access to those services.").
word("outride", 'v.', "To ride a horse, bicycle, etc. better than (someone); to surpass in riding.").
word("outride", 'v.', "To ride out (e.g. a storm).").
word("outrigger", 'n.', "Any of various projecting beams or spars that provide support for a sailing ship's mast.").
word("outrigger", 'n.', "A long thin timber, pontoon, or other float attached parallel to a canoe or boat by projecting struts as a means of preventing tipping or capsizing.").
word("outright", 'adv.', "Wholly, completely and entirely.").
word("outright", 'adv.', "With no outstanding conditions.").
word("outskirt", 'n.', "A more remote part of a town or city; the periphery, environs; a suburb.").
word("outstretch", 'v.', "To extend by stretching").
word("outstrip", 'v.', "To move more quickly than (someone or something) so as to outrun or leave it behind.").
word("outstrip", 'v.', "To exceed or overstep (a boundary or limit); to transgress.").
word("outweigh", 'v.', "To exceed in importance or value.").
word("outweigh", 'v.', "To exceed in weight or mass.").
word("overdo", 'v.', "To give (someone or something) too much work; to require too much effort or strength of (someone); to use up too much of (something).").
word("overdo", 'v.', "To do more than (someone); to do (something) to a greater extent.").
word("overdose", 'n.', "An excessive and dangerous dose of a drug.").
word("overeat", 'v.', "To eat too much.").
word("overeat", 'v.', "To surfeit with eating.").
word("overhang", 'n.', "That portion of the roof structure that extends beyond the exterior walls of a building.").
word("overhang", 'n.', "A fatty roll of pubis flab that hangs over one's genitals; a FUPA.").
word("overleap", 'v.', "To make too much effort in leaping; to leap too far.").
word("overleap", 'v.', "To leap over, to jump over, to cross by jumping.").
word("overlord", 'n.', "In the English feudal system, a lord of a manor who had subinfeudated a particular manor, estate or fee, to a tenant.").
word("overlord", 'n.', "A ruler of other rulers.").
word("overpass", 'v.', "To pass above something, as when flying or moving on a higher road.").
word("overpass", 'v.', "To disregard, skip, or miss something.").
word("overpay", 'v.', "To pay too much.").
word("overpay", 'v.', "To be more than an ample reward for.").
word("overpower", 'v.', "To subdue someone by superior force.").
word("overpower", 'v.', "To excel or exceed in power; to cause to yield; to subdue.").
word("overproduction", 'n.', "The production of more of a commodity than can be used or sold.").
word("overreach", 'v.', "Of a horse: to strike the heel of a forefoot with the toe of a hindfoot.").
word("overreach", 'v.', "To sail on one tack farther than is necessary.").
word("overrun", 'v.', "To infest, swarm over, flow over.").
word("overrun", 'v.', "To abuse or oppress, as if by treading upon.").
word("oversee", 'v.', "To inspect, examine").
word("oversee", 'v.', "To observe secretly or unintentionally.").
word("overseer", 'n.', "A critic.").
word("overseer", 'n.', "One who oversees or supervises.").
word("overshadow", 'v.', "To obscure something by casting a shadow.").
word("overshadow", 'v.', "To dominate something and make it seem insignificant.").
word("overstride", 'v.', "To run or walk with an overly long stride").
word("overstride", 'v.', "To stride (or to stand) over something").
word("overthrow", 'v.', "To bring about the downfall of (a government, etc.), especially by force.").
word("overthrow", 'v.', "To throw (something) so that it goes too far.").
word("overtone", 'n.', "A tone whose frequency is an integer multiple of another; a member of the harmonic series.").
word("overtone", 'n.', "An implicit message (in a film, book, verbal discussion or similar) perceived as overwhelming the explicit message.").
word("overture", 'n.', "A motion placed before a legislative body, such as the General Assembly of the Church of Scotland.").
word("overture", 'n.', "An opening; a recess or chamber.").
word("overweight", 'n.', "A security or class of securities in which one has a heavy concentration.").
word("overweight", 'n.', "An excess of weight.").
word("pacify", 'v.', "To bring peace to (a place or situation), by ending war, fighting, violence, anger or agitation.").
word("pacify", 'v.', "To appease (someone).").
word("packet", 'n.', "A specimen envelope containing small, dried plants or containing parts of plants when attached to a larger sheet.").
word("packet", 'n.', "A large amount of money.").
word("pact", 'n.', "An agreement; a compact; a covenant.").
word("pact", 'n.', "An agreement between two or more nations").
word("pagan", 'n.', "A person not adhering to a main world religion; a follower of a pantheistic or nature-worshipping religion.").
word("pagan", 'n.', "An uncivilized or unsocialized person.").
word("pageant", 'n.', "An elaborate public display, especially a parade in historical or traditional costume.").
word("pageant", 'n.', "A spectacular ceremony.").
word("palate", 'n.', "The roof of the mouth, separating the cavities of the mouth and nose in vertebrates.").
word("palate", 'n.', "Taste or flavour, especially with reference to wine or other alcoholic drinks.").
word("palatial", 'adj.', "On a grand scale; with very rich furnishings.").
word("palatial", 'adj.', "Of or relating to a palace.").
word("paleontology", 'n.', "Study of the forms of life existing in prehistoric or geologic times, especially as represented by fossils.").
word("palette", 'n.', "A plate against which a person presses their chest to give force to a hand-operated drill.").
word("palette", 'n.', "A thin board on which a painter lays and mixes colours.").
word("palinode", 'n.', "An ode or other poem in which the author retracts something said in an earlier poem; a recantation.").
word("pall", 'v.', "To become dull, insipid, tasteless, or vapid; to lose life, spirit, strength, or taste.").
word("pall", 'v.', "To make vapid or insipid; to make lifeless or spiritless; to dull, to weaken.").
word("palliate", 'v.', "To lessen the severity of; to extenuate, moderate, qualify.").
word("palliate", 'v.', "To placate or mollify.").
word("pallid", 'adj.', "Appearing weak, pale or wan.").
word("palsy", 'n.', "Complete or partial muscle paralysis of a body part, often accompanied by a loss of feeling and uncontrolled body movements such as shaking.").
word("paly", 'adj.', "Vertically striped").
word("paly", 'adj.', "Pale; lacking colour").
word("pamphlet", 'n.', "A small, brief printed work, consisting either of a folded sheet of paper, or several sheets bound together into a booklet with only a paper cover, formerly containing literary compositions, newsletters, and newspapers, but now chiefly informational matter.").
word("pamphlet", 'n.', "Such a work containing political material or discussing matters of controversy.").
word("pamphleteer", 'v.', "To publish and distribute pamphlets as a form of propaganda.").
word("panacea", 'n.', "A remedy believed to cure all disease and prolong life that was originally sought by alchemists; a cure-all.").
word("panacea", 'n.', "The plant allheal (Valeriana officinalis), believed to cure all ills.").
word("pandemic", 'adj.', "Of a disease: epidemic over a wide geographical area and affecting a large proportion of the population; also, of or pertaining to a disease of this nature.").
word("pandemic", 'adj.', "General, widespread.").
word("pandemonium", 'n.', "An outburst; loud, riotous uproar, especially of a crowd.").
word("pandemonium", 'n.', "Chaos; tumultuous or lawless violence.").
word("panegyric", 'n.', "A formal speech or opus publicly praising someone or something.").
word("panegyric", 'n.', "Someone who writes or delivers such a speech.").
word("panel", 'n.', "An individual frame or drawing in a comic.").
word("panel", 'n.', "A portion of a framed structure between adjacent posts or struts, as in a bridge truss.").
word("panic", 'n.', "Overwhelming fear or fright, often affecting groups of people or animals; an instance of this; a fright, a scare.").
word("panic", 'n.', "The edible grain obtained from one of the above plants.").
word("panoply", 'n.', "A complete set of armour.").
word("panoply", 'n.', "A broad or full range or complete set.").
word("panorama", 'n.', "A picture or series of pictures representing a continuous scene.").
word("panorama", 'n.', "An unbroken view of an entire surrounding area.").
word("pantheism", 'n.', "The belief in all gods; omnitheism.").
word("pantheism", 'n.', "The belief that the Universe is in some sense divine and should be revered. Pantheism identifies the universe with God but denies any personality or transcendence of such a God.").
word("pantheon", 'n.', "All the gods of a particular people or religion, particularly the ancient Greek gods residing on Olympus, considered as a group.").
word("pantheon", 'n.', "A temple dedicated to all the gods.").
word("pantomime", 'n.', "Gesturing without speaking; dumb-show, mime.").
word("pantomime", 'n.', "A traditional theatrical entertainment, originally based on the commedia dell'arte, but later aimed mostly at children and involving physical comedy, topical jokes, call and response, and fairy-tale plots.").
word("pantoscope", 'n.', "A very wide-angled photographic lens.").
word("pantoscope", 'n.', "A panoramic camera.").
word("papacy", 'n.', "The office of the pope.").
word("papacy", 'n.', "The period of a particular pope's reign.").
word("papyrus", 'n.', "A scroll or document written on papyrus.").
word("papyrus", 'n.', "A plant (Cyperus papyrus) in the sedge family, native to the Nile river valley, paper reed.").
word("parable", 'n.', "A short narrative illustrating a lesson (usually religious/moral) by comparison or analogy.").
word("paradox", 'n.', "A statement which is difficult to believe, or which goes against general belief.").
word("paradox", 'n.', "An apparently self-contradictory statement, which can only be true if it is false, and vice versa.").
word("paragon", 'n.', "A person of preeminent qualities, who acts as a pattern or model for others.").
word("paragon", 'n.', "A flawless diamond of at least 100 carats.").
word("parallel", 'v.', "Of a process etc: To be analogous to something else.").
word("parallel", 'v.', "To compare or liken something to something else.").
word("parallelism", 'n.', "The state of being in agreement or similarity; resemblance, correspondence, analogy.").
word("parallelism", 'n.', "Similarity of features between two species resulting from their having taken similar evolutionary paths following their initial divergence from a common ancestor.").
word("paralysis", 'n.', "The complete loss of voluntary control of part of a person's body, such as one or more limbs.").
word("paralysis", 'n.', "A state of being unable to act.").
word("paralyze", 'v.', "To render unable to function properly.").
word("paralyze", 'v.', "To render unable to move; to immobilize.").
word("paramount", 'adj.', "Of the highest importance.").
word("paramount", 'adj.', "Highest, supreme; also, chief, leading, pre-eminent.").
word("paramour", 'n.', "An illicit lover, either male or female.").
word("paramour", 'n.', "The Virgin Mary or Jesus Christ (when addressed by a person of the opposite sex).").
word("paraphernalia", 'n.', "Miscellaneous items, especially the set of equipment required for a particular activity.").
word("paraphernalia", 'n.', "Things a married woman owns, such as clothing and jewellery, apart from her dowry.").
word("paraphrase", 'v.', "To restate something as, or to compose a paraphrase.").
word("pare", 'v.', "To remove the outer covering or skin of something with a cutting device, typically a knife.").
word("pare", 'v.', "To trim the hoof of a horse.").
word("parentage", 'n.', "The social quality of one's class in society.").
word("parentage", 'n.', "The identity and nature of one's parents, and in particular, the legitimacy of one's birth.").
word("pariah", 'n.', "A person who is rejected from society or home; an outcast.").
word("pariah", 'n.', "A member of one of the oppressed social castes in India.").
word("parish", 'n.', "An administrative subdivision in the U.S. state of Louisiana that is equivalent to a county in other U.S. states.").
word("parish", 'n.', "An ecclesiastical society, usually not bounded by territorial limits, but composed of those persons who choose to unite under the charge of a particular priest, clergyman, or minister; also, loosely, the territory in which the members of a congregation live.").
word("parity", 'n.', "The number of times a sow has farrowed.").
word("parity", 'n.', "The number of delivered pregnancies reaching viable gestational age, usually between 20-28 weeks").
word("parlance", 'n.', "A certain way of speaking, of using words, especially when it comes to those with a particular job or interest.").
word("parlance", 'n.', "Speech, discussion or debate.").
word("parley", 'v.', "To have a discussion, especially one between enemies.").
word("parliament", 'n.', "In many countries, the legislative branch of government, a deliberative assembly or set of assemblies whose elected or appointed members meet to debate the major political issues of the day, make, amend, and repeal laws, authorize the executive branch of government to spend money, and in some cases exercise judicial powers; a legislature.").
word("parliament", 'n.', "A gathering of birds, especially rooks or owls.").
word("parlor", 'n.', "The living room of a house, or a room for entertaining guests; a room for talking; a sitting-room or drawing room").
word("parlor", 'n.', "The apartment in a monastery or nunnery where the residents are permitted to meet and converse with each other or with visitors from the outside.").
word("parody", 'v.', "To make a parody of something.").
word("paronymous", 'adj.', "Having the same root or derivation; conjugate.").
word("paronymous", 'adj.', "Having a similar sound, but different orthography and different meaning.").
word("paroxysm", 'n.', "A random or sudden outburst (of activity).").
word("paroxysm", 'n.', "A sudden recurrence of a disease, such as a seizure or a coughing fit.").
word("parricide", 'n.', "The killing of a relative, especially a parent.").
word("parricide", 'n.', "The killing of a ruler, or other authority figure; treason.").
word("parse", 'v.', "To resolve (a sentence, etc.) into its elements, pointing out the several parts of speech, and their relation to each other by agreement or government; to analyze and describe grammatically.").
word("parse", 'v.', "To split (a file or other input) into pieces of data that can be easily manipulated or stored.").
word("parsimonious", 'adj.', "Exhibiting parsimony; sparing in the expenditure of money; frugal to excess.").
word("parsimonious", 'adj.', "Using a minimal number of assumptions, steps, or conjectures.").
word("partible", 'adj.', "Pertaining to property that can be divided between heirs on inheritance, or to an inheritance system based on such division.").
word("partible", 'adj.', "Divisible, able to be divided or partitioned.").
word("participant", 'n.', "One who participates.").
word("participate", 'v.', "To join in, to take part, to involve oneself ( something).").
word("participate", 'v.', "To share, share in (something).").
word("partisan", 'adj.', "Adherent to a party or faction; especially, having the character of blind, passionate, or unreasonable adherence to a party.").
word("partisan", 'adj.', "Serving as commander or member of a body of detached light troops.").
word("partition", 'n.', "An action which divides a thing into parts, or separates one thing from another.").
word("partition", 'n.', "That which divides or separates; that by which different things, or distinct parts of the same thing, are separated; boundary; dividing line or space.").
word("passible", 'adj.', "Capable of suffering injury or detriment.").
word("passible", 'adj.', "Able to suffer, or feel pain.").
word("passive", 'adj.', "Being subjected to an action without producing a reaction.").
word("passive", 'adj.', "Taking no action.").
word("pastoral", 'adj.', "Relating to rural life and scenes, in particular of poetry.").
word("pastoral", 'adj.', "Of or pertaining to shepherds or herders of other livestock").
word("paternal", 'adj.', "Of or pertaining to one's father, his genes, his relatives, or his side of a family").
word("paternal", 'adj.', "Acting as a father").
word("paternity", 'n.', "Fatherhood, being a father").
word("paternity", 'n.', "Parental descent from a father").
word("pathos", 'n.', "In theology and existentialist ethics following and , a deep and abiding commitment of the heart, as in the notion of \"finding your passion\" as an important aspect of a fully lived, engaged life.").
word("pathos", 'n.', "A writer or speaker's attempt to persuade an audience through appeals involving the use of strong emotions such as pity.").
word("patriarch", 'n.', "In Biblical contexts, a male leader of a family, tribe or ethnic group, especially one of the twelve sons of Jacob (considered to have created the twelve tribes of Israel) or (in plural) Abraham, Isaac and Jacob.").
word("patriarch", 'n.', "The highest form of bishop, in the ancient world having authority over other bishops in the province but now generally as an honorary title; in Roman Catholicism, considered a bishop second only to the Pope in rank.").
word("patrician", 'adj.', "Of, pertaining to, or appropriate to, a person of high birth; noble; not plebeian.").
word("patrimony", 'n.', "A right or estate inherited from one's father; or, in a larger sense, from any male ancestor.").
word("patrimony", 'n.', "Formerly, a church estate or endowment.").
word("patriotism", 'n.', "Love of one's country; devotion to the welfare of one's compatriots; passion which inspires one to serve one's country.").
word("patriotism", 'n.', "The desire to compete with other nations; nationalism.").
word("patronize", 'v.', "To assume a tone of unjustified superiority toward; to talk down to, to treat condescendingly.").
word("patronize", 'v.', "To make oneself a customer of a business, especially a regular customer.").
word("patronymic", 'adj.', "Derived from one's father.").
word("patronymic", 'adj.', "Derived from one's ancestors.").
word("patter", 'v.', "To make irregularly repeated sounds of low-to-moderate magnitude and lower-than-average pitch.").
word("patter", 'v.', "To speak glibly and rapidly, as does an auctioneer or a sports commentator.").
word("paucity", 'n.', "Fewness in number; too few.").
word("paucity", 'n.', "A smallness in size or amount that is insufficient; meagerness, dearth.").
word("pauper", 'n.', "One living on or eligible for public charity.").
word("pauper", 'n.', "One who is extremely poor.").
word("pauperism", 'n.', "The state of being a pauper; poverty.").
word("pavilion", 'n.', "A light roofed structure used as a shelter in a public place.").
word("pavilion", 'n.', "A structure, sometimes temporary, erected to house exhibits at a fair, etc.").
word("payee", 'n.', "One to whom money is paid.").
word("peaceable", 'adj.', "Favouring peace rather than conflict; not aggressive, tending to avoid violence (of people, actions etc.).").
word("peaceable", 'adj.', "Characterized by peace; peaceful, tranquil.").
word("peaceful", 'adj.', "Not at war or disturbed by strife or turmoil.").
word("peaceful", 'adj.', "Motionless and calm.").
word("peccable", 'adj.', "Liable to sin; subject to transgress the divine law.").
word("peccadillo", 'n.', "A small flaw or sin.").
word("peccadillo", 'n.', "A petty offense.").
word("peccant", 'adj.', "Sinful.").
word("peccant", 'adj.', "Wrong; defective; faulty.").
word("pectoral", 'adj.', "Of or pertaining to the breast, or chest.").
word("pectoral", 'adj.', "Relating to, or good for, diseases of the chest or lungs.").
word("pecuniary", 'adj.', "Of, or relating to, money; monetary, financial.").
word("pedagogics", 'n.', "The science or art of teaching; pedagogy.").
word("pedagogue", 'n.', "A slave who led the master's children to school, and had the charge of them generally.").
word("pedagogue", 'n.', "A pedant; one who by teaching has become overly formal or pedantic in his or her ways; one who has the manner of a teacher.").
word("pedagogy", 'n.', "The activities of educating, teaching or instructing.").
word("pedagogy", 'n.', "The profession of teaching.").
word("pedal", 'n.', "A lever operated by one's foot that is used to control or power a machine or mechanism, such as a bicycle or piano").
word("pedal", 'n.', "An effects unit, especially one designed to be activated by being stepped on.").
word("pedant", 'n.', "A person who is overly concerned with formal rules and trivial points of learning.").
word("pedant", 'n.', "A person who emphasizes their knowledge through strict adherence to rules of vocabulary and grammar.").
word("peddle", 'v.', "To sell things, especially door to door or in insignificant quantities.").
word("peddle", 'v.', "To sell illegal narcotics.").
word("peddler", 'n.', "An itinerant seller of small goods.").
word("peddler", 'n.', "A fake-news disseminator; A conspiracy-theory propagator.").
word("pedestal", 'n.', "The base or foot of a column, statue, vase, lamp.").
word("pedestal", 'n.', "An iron socket, or support, for the foot of a brace at the end of a truss where it rests on a pier.").
word("pedestrian", 'n.', "A walker; one who walks or goes on foot, as opposed to one who uses a vehicle.").
word("pedestrian", 'n.', "An expert or professional walker or runner; one who performs feats of walking or running.").
word("pediatrics", 'n.', "The branch of medicine that deals with the treatment of children.").
word("pedigree", 'n.', "A chart, list, or record of ancestors, to show breeding, especially distinguished breeding.").
word("pedigree", 'n.', "A person's ancestral history; ancestry, lineage.").
word("peerage", 'n.', "A book listing such people and their families.").
word("peerage", 'n.', "Peers as a group; the titled nobility or aristocracy.").
word("peerless", 'adj.', "Without peer or equal; unparalleled, nonpareil. Of the highest quality, best.").
word("peevish", 'adj.', "Easily annoyed, especially by things that are not important; irritable, querulous.").
word("peevish", 'adj.', "Characterized by or exhibiting petty bad temper, bad-tempered, moody, cross.").
word("pellucid", 'adj.', "Allowing the passage of light; transparent.").
word("pellucid", 'adj.', "Easily understood; clear.").
word("penalty", 'n.', "A disadvantageous consequence of a previous event.").
word("penalty", 'n.', "A punishment for violating rules of procedure.").
word("penance", 'n.', "A voluntary self-imposed punishment for a sinful act or wrongdoing. It may be intended to serve as reparation for the act.").
word("penance", 'n.', "Any instrument of self-punishment.").
word("penchant", 'n.', "Taste, liking, or inclination (for).").
word("penchant", 'n.', "A card game resembling bezique.").
word("pendant", 'n.', "A short rope hanging down, used to attach hooks for tackles; a pennant.").
word("pendant", 'n.', "A piece of jewellery which hangs down as an ornament, especially worn on a chain around the neck.").
word("pendulous", 'adj.', "Hanging as if from a support").
word("pendulous", 'adj.', "Having branches etc. that bend downwards; drooping or weeping").
word("pendulum", 'n.', "A body suspended from a fixed support so that it swings freely back and forth under the influence of gravity, commonly used to regulate various devices such as clocks.").
word("pendulum", 'n.', "A watch's guard-ring by which it is attached to a chain.").
word("penetrable", 'adj.', "Capable of being penetrated, entered, or pierced. Also figuratively.").
word("penetrate", 'v.', "To enter into; to make way into the interior of; to pierce.").
word("penetrate", 'v.', "To insert the penis into an opening, such as a vagina, mouth or anus.").
word("penetration", 'n.', "Specifically, the insertion of the penis (or similar object) during sexual intercourse.").
word("penetration", 'n.', "A number or fraction that represents how many cards/decks will be dealt before shuffling, in contrast to the total number of cards/decks in play.").
word("peninsular", 'adj.', "Exhibiting a narrow provincialism; parochial.").
word("peninsular", 'adj.', "Of, pertaining to, resembling, or connected with a peninsula.").
word("penitence", 'n.', "The of being ; a of or for doing or .").
word("penitential", 'adj.', "Pertaining to penance or penitence").
word("pennant", 'n.', "A flag normally used by naval vessels to represent a special condition.").
word("pennant", 'n.', "Either of two species of libellulid dragonfly of the genus , of the tropics and subtropics.").
word("pension", 'n.', "A regular allowance paid to support a royal favourite, or as patronage of an artist or scholar.").
word("pension", 'n.', "A boarding house or small hotel, especially in continental Europe, which typically offers lodging and certain meals and services.").
word("pentad", 'n.', "A group or series of five things.").
word("pentad", 'n.', "A mean average value of temperature, etc., taken every five days.").
word("pentagon", 'n.', "A polygon with five sides and five angles.").
word("pentagon", 'n.', "A fort with five bastions.").
word("pentagram", 'n.', "The shape of a five-pointed star constructed of five intersecting lines meeting at the vertices, such that a central pentagon and five surrounding isosceles triangles are formed; often with magical connotations; a 5/2 (or 5/3) star polygon.").
word("pentahedron", 'n.', "A solid geometric figure with five faces.").
word("pentameter", 'n.', "A line in a poem having five metrical feet.").
word("pentameter", 'n.', "Poetic metre in which each line has five feet.").
word("pentathlon", 'n.', "An ancient athletics discipline, featuring five events: stadion, wrestling, long jump, javelin and discus").
word("pentathlon", 'n.', "; A 20th-century athletics discipline for women, the women's counterpart of the men's , the predecessor to the women's , featuring five events: hurdles, shot put, high jump, long jump, and a run").
word("pentavalent", 'adj.', "Having an atomic valence of 5.").
word("pentavalent", 'adj.', "Having a vaccine valence of 5.").
word("penultimate", 'adj.', "Relating to or denoting an element of a related collection of curves that is arbitrarily close to a degenerate form.").
word("penultimate", 'adj.', "Next to last, second to last; immediately preceding the end of a sequence, list, etc.").
word("penurious", 'adj.', "Impoverished; wanting for money.").
word("penurious", 'adj.', "Not bountiful; thin; scant.").
word("penury", 'n.', "Extreme want; poverty; destitution.").
word("penury", 'n.', "A lack of something; a dearth.").
word("perambulate", 'v.', "To walk about, roam or stroll.").
word("perambulate", 'v.', "To inspect (an area) on foot.").
word("perceive", 'v.', "To become aware of, through the physical senses or by thinking; to see; to understand.").
word("perceptible", 'adj.', "Able to be perceived, sensed, or discerned.").
word("perception", 'n.', "The organisation, identification and interpretation of sensory information.").
word("perception", 'n.', "That which is detected by the five senses; not necessarily understood (imagine looking through fog, trying to understand if you see a small dog or a cat); also that which is detected within consciousness as a thought, intuition, deduction, etc.").
word("percipience", 'n.', "The state or condition of being highly perceptive, as if in an almost hypnotic or telepathic state.").
word("percipience", 'n.', "Perception").
word("percipient", 'n.', "One who has perceived a paranormal event.").
word("percipient", 'n.', "One who perceives something.").
word("percolate", 'v.', "To pass a liquid through a porous substance; to filter.").
word("percolate", 'v.', "To spread slowly or gradually; to slowly become noticed or realised.").
word("percolator", 'n.', "A device used to brew coffee by passing boiling water through coffee grounds").
word("percolator", 'n.', "A pharmaceutical apparatus for producing an extract from a drug by percolation.").
word("percussion", 'n.', "The collision of two bodies in order to produce a sound.").
word("percussion", 'n.', "The tapping of the body as an aid to medical diagnosis.").
word("peremptory", 'adj.', "Precluding debate or expostulation; not admitting of question or appeal").
word("peremptory", 'adj.', "Accepting no refusal or disagreement; imperious, dictatorial.").
word("perennial", 'adj.', "Lasting or remaining active throughout the year, or all the time.").
word("perennial", 'adj.', "Having a life cycle of more than two years.").
word("perfectible", 'adj.', "Able to be perfected; capable of perfection.").
word("perfidy", 'n.', "A state or act of deceit.").
word("perfidy", 'n.', "A state or act of violating faith or allegiance; violation of a promise or vow, or of trust").
word("perforate", 'v.', "To make a line of holes in (a thin material) to allow separation at the line.").
word("perforate", 'v.', "To pierce; to penetrate.").
word("perform", 'v.', "To do (something) in front of an audience, such as acting or music, often in order to entertain.").
word("perform", 'v.', "To behave theatrically so as to give the impression of (a quality, character trait, etc.); to feign.").
word("perfumery", 'n.', "The manufacture of perfume.").
word("perfumery", 'n.', "A factory where perfume is made.").
word("perfunctory", 'adj.', "Done only or merely to conform to a minimal standard or to fulfill a protocol or presumptive duty .").
word("perfunctory", 'adj.', "Performed in a careless or indifferent manner as a thing of rote.").
word("perhaps", 'adv.', "By chance.").
word("perigee", 'n.', "The point, in any trajectory of an object in space, where it is closest to the Earth.").
word("perigee", 'n.', "The point, in an orbit about any planet, that is closest to the planet: the periapsis of any satellite.").
word("periodicity", 'n.', "The quality of a function with a repeated set of values at regular intervals.").
word("periodicity", 'n.', "The quality of being periodic; tendency to recur at regular intervals.").
word("peripatetic", 'adj.', "Tending to walk about.").
word("peripatetic", 'adj.', "Constantly travelling.").
word("perjure", 'v.', "To knowingly and willfully make a false statement of witness while in court.").
word("perjure", 'v.', "To make a false oath to; to deceive by oaths and protestations.").
word("perjury", 'n.', "The deliberate giving of false or misleading testimony under oath.").
word("permanence", 'n.', "The reciprocal of magnetic inductance.").
word("permanence", 'n.', "The state of being permanent.").
word("permanent", 'adj.', "Lasting for an indefinitely long time.").
word("permanent", 'adj.', "Without end, eternal.").
word("permeate", 'v.', "To enter and spread through; to pervade.").
word("permeate", 'v.', "To pass through the pores or interstices of; to penetrate and pass through without causing rupture or displacement; applied especially to fluids which pass through substances of loose texture").
word("permissible", 'adj.', "Permitted.").
word("permutation", 'n.', "One of the ways something exists, or the ways a set of objects can be ordered.").
word("permutation", 'n.', "An ordering of a finite set of distinct elements.").
word("pernicious", 'adj.', "Causing death or injury; deadly.").
word("pernicious", 'adj.', "Causing much harm in a subtle way.").
word("perpendicular", 'adj.', "Exactly upright; extending in a straight line toward the centre of the earth, etc.").
word("perpendicular", 'adj.', "At or forming a right angle (to something).").
word("perpetrator", 'n.', "One who perpetrates; especially, one who commits an offence or crime.").
word("perpetuate", 'v.', "To make perpetual; to preserve from extinction or oblivion.").
word("perpetuate", 'v.', "To prolong the existence of.").
word("perquisite", 'n.', "Any monetary or other incidental benefit beyond salary.").
word("perquisite", 'n.', "A privilege or possession held or claimed exclusively by a certain person, group or class.").
word("persecution", 'n.', "A program or campaign to subjugate or eliminate a specific group of people, often based on race, religion, sexuality, or social beliefs.").
word("persecution", 'n.', "The act of persecuting.").
word("perseverance", 'n.', "Continuing in a course of action without regard to discouragement, opposition or previous failure.").
word("persevere", 'v.', "To stay constant; to continue in a certain state; to remain.").
word("persevere", 'v.', "To persist steadfastly in pursuit of an undertaking, task, journey, or goal, even if hindered by distraction, difficulty, obstacles, or discouragement.").
word("persiflage", 'n.', "Good-natured banter; raillery.").
word("persiflage", 'n.', "Frivolous, lighthearted discussion of a topic.").
word("persist", 'v.', "To continue to exist.").
word("persist", 'v.', "To continue to be; to remain.").
word("persistence", 'n.', "The number of times an operation can be iteratively applied to a number before it reaches a permanently constant state.").
word("persistence", 'n.', "Of data, the property of continuing to exist after the termination of the program.").
word("personage", 'n.', "The creation of corporate persons named after living people.").
word("personage", 'n.', "A person, especially one who is famous or important.").
word("personal", 'adj.', "Dealing with subjects about which one wishes (or people usually wish) to maintain privacy or discretion; not for public view; sensitive, intimate.").
word("personal", 'adj.', "Of or pertaining to a particular person; relating to, or affecting, an individual, or each of many individuals; peculiar or proper to private concerns; not public or general").
word("personality", 'n.', "A set of non-physical psychological and social qualities that make one person distinct from another.").
word("personality", 'n.', "A set of qualities that make something distinctive or interesting.").
word("personnel", 'n.', "Employees; office staff.").
word("personnel", 'n.', "A human resources department.").
word("perspective", 'n.', "The choice of a single angle or point of view from which to sense, categorize, measure or codify experience.").
word("perspective", 'n.', "The appearance of depth in objects, especially as perceived using binocular vision.").
word("perspicacious", 'adj.', "Of acute discernment; having keen insight; mentally perceptive.").
word("perspicacious", 'adj.', "Able to physically see clearly; quick-sighted; sharp-sighted.").
word("perspicacity", 'n.', "Acute discernment or understanding; insight.").
word("perspicacity", 'n.', "The human faculty or power to mentally grasp or understand clearly.").
word("perspicuous", 'adj.', "Clearly expressed, easy to understand; lucid.").
word("perspicuous", 'adj.', "Of a language or notation, such as that of formal propositional calculus: where the process of inference from premises to conclusion is explicitly laid out.").
word("perspiration", 'n.', "A saline fluid secreted by the sweat glands; sweat.").
word("perspiration", 'n.', "Hard work.").
word("perspire", 'v.', "To be evacuated or excreted, or to exude, through the pores of the skin.").
word("perspire", 'v.', "To emit (sweat or perspiration) through the skin's pores.").
word("persuadable", 'adj.', "Able to be persuaded or convinced.").
word("persuade", 'v.', "To convince of by argument, or by reasons offered or suggested from reflection, etc.; to cause to believe (something).").
word("persuade", 'v.', "To successfully convince (someone) to agree to, accept, or do something, usually through reasoning and verbal influence.").
word("pertinacious", 'adj.', "Holding tenaciously to an opinion or purpose.").
word("pertinacious", 'adj.', "Stubbornly resolute or tenacious.").
word("pertinacity", 'n.', "The state or characteristic of being pertinacious.").
word("pertinent", 'adj.', "Important with regard to (a subject or matter); pertaining; relevant.").
word("perturb", 'v.', "To disturb; to bother or unsettle.").
word("perturb", 'v.', "To modify the motion of a body by exerting a gravitational force.").
word("perturbation", 'n.', "Variation in an orbit due to the influence of external bodies").
word("perturbation", 'n.', "A small change in a physical system, or more broadly any definable system (such as a biological or economic system)").
word("perusal", 'n.', "The act of perusing; studying something carefully.").
word("pervade", 'v.', "To be in every part of; to spread through.").
word("pervasion", 'n.', "The act of pervading; permeation, suffusion").
word("pervasive", 'adj.', "Manifested throughout; pervading, permeating, penetrating or affecting everything.").
word("perverse", 'adj.', "Turned aside while against something, splitting off from a thing.").
word("perverse", 'adj.', "Obstinately in the wrong; stubborn; intractable").
word("perversion", 'n.', "Distortion or corruption of the original course, meaning, or state of something.").
word("perversion", 'n.', "A sexual practice considered abnormal; sexual deviance.").
word("perversity", 'n.', "A perverse act.").
word("perversity", 'n.', "The quality of being perverse.").
word("pervert", 'n.', "A person whose sexual habits are not considered acceptable.").
word("pervert", 'n.', "One who has been perverted; one who has turned to error; one who has turned to a twisted sense of values or morals.").
word("pervious", 'adj.', "Admitting passage; capable of being penetrated by another body or substance; permeable.").
word("pervious", 'adj.', "Capable of being penetrated, or seen through, by physical or mental vision.").
word("pestilence", 'n.', "Any epidemic disease that is highly contagious, infectious, virulent and devastating.").
word("pestilence", 'n.', "Anything harmful to morals or public order.").
word("pestilent", 'adj.', "Harmful to morals or public order.").
word("pestilent", 'adj.', "Highly injurious or destructive to life: deadly.").
word("pestilential", 'adj.', "Having a harmful moral effect (especially one that is believed to spread in the manner of pestilence).").
word("pestilential", 'adj.', "Causing irritation or annoyance.").
word("peter", 'v.', "To dwindle; to trail off; to diminish to nothing.").
word("petrify", 'v.', "To become stone, or of a stony hardness, as organic matter by calcareous deposits.").
word("petrify", 'v.', "To harden organic matter by permeating with water and depositing dissolved minerals.").
word("petulance", 'n.', "Childish impatience or sulkiness; testiness.").
word("petulance", 'n.', "An insolent remark or act.").
word("petulant", 'adj.', "Childishly irritable.").
word("petulant", 'adj.', "Forward; pert; insolent; wanton.").
word("pharmacopoeia", 'n.', "An official book describing medicines or other pharmacological substances, especially their use, preparation, and regulation.").
word("pharmacopoeia", 'n.', "A collection of drugs.").
word("pharmacy", 'n.', "A place where prescription drugs are dispensed; a dispensary.").
word("pharmacy", 'n.', "The science of medicinal substances comprising pharmaceutics, pharmaceutical chemistry, pharmacology, phytochemistry and forensics.").
word("phenomenal", 'adj.', "Very remarkable; highly extraordinary; amazing.").
word("phenomenal", 'adj.', "Of or pertaining to the appearance of the world, as opposed to the ultimate nature of the world as it is in itself.").
word("phenomenon", 'n.', "A thing or being, event or process, perceptible through senses; or a fact or occurrence thereof.").
word("phenomenon", 'n.', "A fact or event considered very unusual, curious, or astonishing by those who witness it.").
word("philander", 'v.', "To woo women; to play the male flirt.").
word("philanthropic", 'adj.', "Of or pertaining to philanthropy; characterized by philanthropy; loving or helping mankind").
word("philanthropist", 'n.', "A person or institution who seeks to improve the world, especially by monetary gifts.").
word("philanthropist", 'n.', "A person who loves humankind in general.").
word("philanthropy", 'n.', "Benevolent altruism with the intention of increasing the well-being of humankind.").
word("philanthropy", 'n.', "A charitable foundation.").
word("philately", 'n.', "The study of postage stamps, postal routes, postal history, etc.").
word("philately", 'n.', "Stamp collecting.").
word("philharmonic", 'adj.', "Appreciative of music, but especially to its performance").
word("philogynist", 'n.', "Someone who is fond of women as a group").
word("philologist", 'n.', "A person devoted to general learning and literature. Brown, Lesley. The New shorter Oxford English dictionary on historical principles, pub. Clarendon Oxford 1993 isbn0-19-861271-0").
word("philologist", 'n.', "A person devoted to classical scholarship.").
word("philology", 'n.', "The humanistic study of language.").
word("philology", 'n.', "Love and study of learning and literature, broadly speaking. Brown, Lesley. The New shorter Oxford English dictionary on historical principles pub. Clarendon Oxford 1993 isbn0-19-861271-0").
word("philosophize", 'v.', "To ponder or reason out philosophically.").
word("philosophy", 'n.', "The love of wisdom.").
word("philosophy", 'n.', "A calm and thoughtful demeanor; calmness of temper.").
word("phlegmatic", 'adj.', "Not easily excited to action or passion; calm; sluggish.").
word("phlegmatic", 'adj.', "Generating, causing, or full of phlegm.").
word("phonetic", 'adj.', "Relating to the sounds of spoken language.").
word("phonetic", 'adj.', "Relating to phones (as opposed to phonemes)").
word("phonic", 'adj.', "Of or pertaining to sound; of the nature of sound; acoustic.").
word("phonogram", 'n.', "A character or symbol (grapheme) that represents a sound, as opposed to logograms and determinatives.").
word("phonogram", 'n.', "An audio recording, regardless of physical format.").
word("phonology", 'n.', "The study of the way sounds function in languages, including phonemes, syllable structure, stress, accent, intonation, and which sounds are distinctive units within a language.").
word("phonology", 'n.', "The way sounds function within a given language; a phonological system.").
word("phosphorescence", 'n.', "The emission of light without any perceptible heat; the quality of being phosphorescent.").
word("photoelectric", 'adj.', "Of or relating to the electric effects of electromagnetic radiation, especially the ejection of an electron from a surface by a photon.").
word("photometer", 'n.', "Any of several instruments used to measure various aspects of the intensity of light.").
word("photometry", 'n.', "The measurement of the intensity and spectrum of light from stars.").
word("photometry", 'n.', "The measurement of various aspects of light, especially its intensity.").
word("physicist", 'n.', "A person whose occupation specializes in the science of physics, especially at a professional level.").
word("physicist", 'n.', "A believer in the theory that the fundamental phenomena of life are to be explained upon purely chemical and physical principles (opposed to ).").
word("physics", 'n.', "The branch of science concerned with the study of the properties and interactions of space, time, matter and energy.").
word("physics", 'n.', "The physical aspects of a phenomenon or a system, especially those studied scientifically.").
word("physiocracy", 'n.', "The teachings of physiocrats.").
word("physiognomy", 'n.', "The art or pseudoscience of deducing the predominant temper and other characteristic qualities of the mind from the outward appearance, especially from the features of the face.").
word("physiognomy", 'n.', "The general appearance or aspect of a thing, without reference to its scientific characteristics.").
word("physiography", 'n.', "The descriptive part of a natural science as distinguished from the explanatory or theoretical part.").
word("physiography", 'n.', "The subfield of geography that studies physical patterns and processes of the Earth. It aims to understand the forces that produce and change rocks, oceans, weather, and global flora and fauna patterns.").
word("physiology", 'n.', "The study and description of natural objects; natural science.").
word("physiology", 'n.', "A branch of biology that deals with the functions and activities of life or of living matter (as organs, tissues, or cells) and of the physical and chemical phenomena involved.").
word("physique", 'n.', "The trained muscular structure of a person's body.").
word("physique", 'n.', "The natural constitution, or physical structure, of a person.").
word("picayune", 'adj.', "Of little consequence; small and of little importance; petty, trivial.").
word("picayune", 'adj.', "Childishly spiteful; tending to go on about unimportant things; small-minded.").
word("piccolo", 'n.', "A bottle of champagne containing 0.1875 litres of fluid, one quarter the volume of a standard bottle.").
word("piccolo", 'n.', "A waiter’s assistant in a hotel or restaurant.").
word("piece", 'n.', "A part of a larger whole, usually in such a form that it is able to be separated from other parts.").
word("piece", 'n.', "One of the figures used in playing chess, specifically a higher-value figure as distinguished from a pawn; by extension, a similar counter etc. in other games.").
word("piecemeal", 'adv.', "Piece by piece; in small amounts, stages, or degrees.").
word("piecemeal", 'adv.', "Into pieces or parts.").
word("pillage", 'n.', "The spoils of war.").
word("pillage", 'n.', "The act of pillaging.").
word("pillory", 'n.', "A framework on a post, with holes for the hands and head, used as a means of punishment and humiliation.").
word("pincers", 'n.', "A gripping tool, pivoted like a pair of scissors, but with blunt jaws.").
word("pincers", 'n.', "The front claws of crustaceans such as lobsters.").
word("pinnacle", 'n.', "An all-time high; a point of greatest achievement or success.").
word("pinnacle", 'n.', "A tall, sharp and craggy rock or mountain.").
word("pioneer", 'n.', "A person or other entity who is first or among the earliest in any field of inquiry, enterprise, or progress.").
word("pioneer", 'n.', "One who goes before, as into the wilderness, preparing the way for others to follow.").
word("pious", 'adj.', "Insisting on or making a show of one's own virtue, especially in comparison to others; sanctimonious, condescending, judgmental.").
word("pious", 'adj.', "Of or pertaining to piety, exhibiting piety, devout, godfearing.").
word("piteous", 'adj.', "Provoking pity, compassion, or sympathy.").
word("piteous", 'adj.', "Showing compassion.").
word("pitiable", 'adj.', "That deserves, evokes or can be given pity; pitiful.").
word("pitiful", 'adj.', "Of an amount or number: very small.").
word("pitiful", 'adj.', "So appalling or sad that one feels or should feel sorry for it; eliciting pity.").
word("pitiless", 'adj.', "Having no kindly feelings; unkind").
word("pitiless", 'adj.', "Having, or showing, no pity; merciless, ruthless").
word("pittance", 'n.', "A small allowance of food and drink; a scanty meal.").
word("pittance", 'n.', "A meagre allowance of money or wages.").
word("placate", 'v.', "To calm; to bring peace to; to influence someone who was furious to the point that they become content or at least no longer irate.").
word("placid", 'adj.', "Calm and quiet; peaceful; tranquil").
word("plagiarism", 'n.', "Text or other work resulting from this act.").
word("plagiarism", 'n.', "Copying of another person's ideas, text or other creative work, and presenting it as one's own, especially without permission; plagiarizing.").
word("planisphere", 'n.', "Any of several charts of the celestial sphere having an overlay or window that may be adjusted to show the stars visible at a particular time, or from a particular place").
word("planisphere", 'n.', "Any representation of part of a sphere on a plane surface").
word("plasticity", 'n.', "The property of a solid body whereby it undergoes a permanent change in shape or size when subjected to a stress exceeding a particular value (the yield value)").
word("plasticity", 'n.', "The quality or state of being plastic.").
word("platitude", 'n.', "An often-quoted saying that is supposed to be meaningful but has become unoriginal or hackneyed through overuse; a cliché.").
word("platitude", 'n.', "A claim that is trivially true, to the point of being uninteresting.").
word("plaudit", 'n.', "A mark or expression of ; bestowed.").
word("plausible", 'adj.', "Seemingly or apparently valid, likely, or acceptable; conceivably true or likely").
word("plausible", 'adj.', "Worthy of being applauded; praiseworthy; commendable; ready.").
word("playful", 'adj.', "Funny, humorous, jesting, frolicsome.").
word("playful", 'adj.', "Experimental.").
word("playwright", 'n.', "A writer and creator of theatrical plays.").
word("plea", 'n.', "That which is alleged by a party in support of his cause.").
word("plea", 'n.', "An appeal, petition, urgent prayer or entreaty.").
word("pleasant", 'adj.', "Facetious, joking.").
word("pleasant", 'adj.', "Giving pleasure; pleasing in manner.").
word("pleasurable", 'adj.', "That gives pleasure").
word("plebeian", 'adj.', "Of or concerning the common people.").
word("plebeian", 'adj.', "Common, particularly vulgar, crude, coarse, uncultured.").
word("pledgee", 'n.', "Someone who receives a pledge").
word("plenary", 'adj.', "Complete; full; entire; absolute.").
word("plenary", 'adj.', "Fully attended; for everyone's attendance.").
word("plenipotentiary", 'n.', "A person invested with full powers, especially as the diplomatic agent of a sovereign state, (originally) charged with handling a certain matter.").
word("plenitude", 'n.', "An abundance; a full supply.").
word("plenitude", 'n.', "Fullness; completeness.").
word("plenteous", 'adj.', "In plenty; abundant.").
word("plenteous", 'adj.', "Having plenty; abounding; rich.").
word("plumb", 'n.', "A little mass of lead, or the like, attached to a line, and used by builders, etc., to indicate a vertical direction.").
word("plumb", 'n.', "A weight on the end of a long line, used by sailors to determine the depth of water.").
word("plummet", 'n.', "A piece of lead formerly used by school children to rule paper for writing (that is, to mark with rules, with lines)").
word("plummet", 'n.', "A piece of lead attached to a line, used in sounding the depth of water, a plumb bob or a plumb line").
word("pluperfect", 'adj.', "Pertaining to action completed before or at the same time as another.").
word("plural", 'adj.', "Consisting of or containing more than one of something.").
word("plural", 'adj.', "In systems of number, not singular or not singular or dual.").
word("plurality", 'n.', "A number of votes for a single candidate or position which is greater than the number of votes gained by any other single candidate or position voted for, but which is less than a majority of valid votes cast.").
word("plurality", 'n.', "A number or part of a whole which is greater than any other number or part, but not necessarily a majority.").
word("plutocracy", 'n.', "A controlling class of the wealthy.").
word("plutocracy", 'n.', "Government by the wealthy.").
word("pneumatic", 'adj.', "Of, relating to, or resembling air or other gases").
word("pneumatic", 'adj.', "Powered by, or filled with, compressed air").
word("poesy", 'n.', "A poem.").
word("poesy", 'n.', "The class of literature comprising poems.").
word("poetaster", 'n.', "An unskilled poet.").
word("poetic", 'adj.', "Connecting to the soul of the beholder.").
word("poetic", 'adj.', "Relating to poetry.").
word("poetics", 'n.', "The theory of poetry, or of literature in general.").
word("poignancy", 'n.', "The quality of being poignant").
word("poignant", 'adj.', "Evoking strong mental sensation, to the point of distress; emotionally moving.").
word("poignant", 'adj.', "Piquant, pungent.").
word("poise", 'n.', "A state of balance, equilibrium or stability.").
word("poise", 'n.', "A condition of hovering, or being suspended.").
word("polar", 'adj.', "Of a coordinate system, specifying the location of a point in a plane by using a radius and an angle.").
word("polar", 'adj.', "Of, relating to, measured from, or referred to a geographic pole (the North Pole or South Pole); within the Arctic or Antarctic circles.").
word("polemics", 'n.', "The art or practice of making arguments or controversies.").
word("polemics", 'n.', "The refutation of errors in theological doctrine.").
word("pollen", 'n.', "Fine powder in general, fine flour. (16th-century usage documented by the OED.)").
word("pollen", 'n.', "A fine granular substance produced in flowers. Technically a collective term for pollen grains (microspores) produced in the anthers of flowering plants. (This specific usage dating from mid 18th century.)").
word("pollute", 'v.', "To violate sexually; to debauch; to dishonour.").
word("pollute", 'v.', "To corrupt or profane").
word("polyarchy", 'n.', "A government in which power is invested in multiple people.").
word("polycracy", 'n.', "A dynasty within a democracy; Government by a clan or relatives of self-elected rulers amid a democratic process").
word("polycracy", 'n.', "A tyrannic regime within a democracy").
word("polygamy", 'n.', "The condition of having more than one spouse or marriage partner at one time.").
word("polygamy", 'n.', "The state or habit of having more than one sexual mate.").
word("polyglot", 'adj.', "Of a person: speaking, or versed in, many languages; multilingual.").
word("polyglot", 'adj.', "Containing, or made up of, several languages; specifically, of a book (especially a bible): having text translated into several languages.").
word("polygon", 'n.', "A figure comprising vertices and (not necessarily straight) edges, alternatingly.").
word("polygon", 'n.', "A plane figure bounded by edges that are all straight lines.").
word("polyhedron", 'n.', "A solid figure with many flat faces and straight edges.").
word("polyhedron", 'n.', "A polyscope, or multiplying glass.").
word("polytechnic", 'adj.', "That teaches applied arts, sciences, technology, engineering and other academic subjects").
word("polytheism", 'n.', "The belief in the existence of multiple gods.").
word("pommel", 'v.', "To pound or beat.").
word("pomposity", 'n.', "The quality of being pompous; self-importance.").
word("pompous", 'adj.', "Affectedly grand, solemn or self-important.").
word("ponder", 'v.', "To weigh.").
word("ponder", 'v.', "To wonder, think of deeply.").
word("ponderous", 'adj.', "Clumsy, unwieldy, or slow, especially due to weight.").
word("ponderous", 'adj.', "Heavy, massive, weighty.").
word("pontiff", 'n.', "A bishop of the early Church; now specifically, the Pope.").
word("pontiff", 'n.', "Any chief figure or leader of a religion.").
word("populace", 'n.', "The common people of a nation.").
word("populace", 'n.', "The inhabitants of a nation.").
word("populous", 'adj.', "Crowded with people.").
word("populous", 'adj.', "Spoken by a large number of people.").
word("portend", 'v.', "To signify; to denote.").
word("portend", 'v.', "To serve as a warning or omen of.").
word("portent", 'n.', "Something that portends an event about to occur, especially an unfortunate or evil event; an omen.").
word("portent", 'n.', "A portending; significance").
word("portfolio", 'n.', "A case for carrying papers, drawings, photographs, maps and other flat documents.").
word("portfolio", 'n.', "The post and the responsibilities of a cabinet minister or other head of a government department.").
word("posit", 'v.', "Propose for consideration or study; to suggest.").
word("posit", 'v.', "Assume the existence of; to postulate.").
word("position", 'n.', "A place on the playing field, together with a set of duties, assigned to a player.").
word("position", 'n.', "An amount of securities, commodities, or other financial instruments held by a person, firm or institution.").
word("positive", 'adj.', "Derived from an object by itself; not dependent on changing circumstances or relations.").
word("positive", 'adj.', "Fully assured in opinion.").
word("posse", 'n.', "A group of (especially young) people seen as constituting a peer group or band of associates; a gang, a group of friends.").
word("posse", 'n.', "A group or company of people, originally especially one having hostile intent; a throng, a crowd.").
word("possession", 'n.', "Control or occupancy of something for which one does not necessarily have private property rights.").
word("possession", 'n.', "Something that is owned.").
word("possessive", 'adj.', "Of or pertaining to ownership or possession.").
word("possessive", 'adj.', "Unwilling to yield possession of.").
word("possessor", 'n.', "Agent noun of possess; one who possesses").
word("possible", 'adj.', "Capable of being done or achieved; feasible.").
word("possible", 'adj.', "Being considered, e.g. for a position.").
word("postdate", 'v.', "To affix a date to after the event.").
word("postdate", 'v.', "To assign an effective date to a document or action later than the actual date").
word("posterior", 'n.', "The hinder parts of the body.").
word("posterior", 'n.', "The probability that a hypothesis is true (calculated by Bayes' theorem).").
word("postgraduate", 'adj.', "Of studies which take place after having successfully completed a degree course.").
word("postscript", 'n.', "An addendum to a letter, added after the author's signature.").
word("postscript", 'n.', "An addition to a story, play, etc. after its completion.").
word("potency", 'n.', "Power").
word("potency", 'n.', "Strength").
word("potent", 'adj.', "Powerfully effective.").
word("potent", 'adj.', "Very powerful or effective.").
word("potentate", 'n.', "A powerful polity or institution.").
word("potentate", 'n.', "A powerful leader; a monarch; a ruler.").
word("potential", 'n.', "Currently unrealized ability (with the most common adposition being to)").
word("potential", 'n.', "The work (energy) required to move a reference particle from a reference location to a specified location in the presence of a force field, for example to bring a unit positive electric charge from an infinite distance to a specified point against an electric field.").
word("potion", 'n.', "A small portion or dose of a liquid which is medicinal, poisonous, or magical.").
word("powerless", 'adj.', "Lacking legal authority.").
word("powerless", 'adj.', "Lacking sufficient power or strength.").
word("practicable", 'adj.', "Capable of being accomplished; feasible.").
word("practicable", 'adj.', "Available for use; accessible or employable.").
word("prate", 'v.', "To talk much and to little purpose; to be loquacious; to speak foolishly.").
word("prattle", 'v.', "To speak incessantly and in an inconsequential or childish manner; to babble.").
word("preamble", 'n.', "A short preliminary statement or remark, especially an explanatory introduction to a formal document or statute.").
word("preamble", 'n.', "A syncword.").
word("precarious", 'adj.', "Dangerously insecure or unstable; perilous.").
word("precarious", 'adj.', "Relating to incipient caries.").
word("precaution", 'n.', "Previous caution or care; caution previously employed to prevent misfortune or to secure good").
word("precaution", 'n.', "A measure taken beforehand to ward off evil or secure good or success; a precautionary act.").
word("precede", 'v.', "To go before, go in front of.").
word("precede", 'v.', "To have higher rank than (someone or something else).").
word("precedence", 'n.', "The state of preceding in importance or priority.").
word("precedence", 'n.', "Precedent.").
word("precedent", 'n.', "An act in the past which may be used as an example to help decide the outcome of similar instances in the future.").
word("precedent", 'n.', "The aforementioned (thing).").
word("precedential", 'adj.', "Having the force of precedent.").
word("precession", 'n.', "The wobbling motion of the axis of a spinning body when there is an external force acting on the axis.").
word("precession", 'n.', "The slow gyration of the earth's axis around the pole of the ecliptic, caused mainly by the gravitational torque of the sun and moon.").
word("precipice", 'n.', "A very steep cliff.").
word("precipice", 'n.', "The brink of a dangerous situation.").
word("precipitant", 'adj.', "That falls headlong, or causes a headlong fall.").
word("precipitant", 'adj.', "Rash or impulsive.").
word("precipitate", 'v.', "To come out of a liquid solution into solid form.").
word("precipitate", 'v.', "To separate a substance out of a liquid solution into solid form.").
word("precise", 'adj.', "Exact, accurate").
word("precise", 'adj.', "Adhering too much to rules; prim or punctilious").
word("precision", 'n.', "The ability of a measurement to be reproduced consistently.").
word("precision", 'n.', "The number of significant digits to which a value may be measured reliably.").
word("preclude", 'v.', "Remove the possibility of; ; prevent or exclude; to make .").
word("precocious", 'adj.', "Characterized by exceptionally early development or maturity.").
word("precocious", 'adj.', "Exhibiting advanced skills and aptitudes at an abnormally early age.").
word("precursor", 'n.', "One of the compounds that participates in the chemical reaction that produces another compound.").
word("precursor", 'n.', "That which precurses: a forerunner, predecessor, or indicator of approaching events.").
word("predatory", 'adj.', "Living by preying on other living animals.").
word("predatory", 'adj.', "Exploiting or victimizing others for personal gain.").
word("predecessor", 'n.', "One who precedes; one who has preceded another in any state, position, office, etc.; one whom another follows or comes after, in any office or position.").
word("predecessor", 'n.', "A model or type of machinery or device which precedes the current one. Usually used to describe an earlier, outdated model.").
word("predicament", 'n.', "An unfortunate or trying position or condition.").
word("predicament", 'n.', "A definite class, state or condition.").
word("predicate", 'v.', "To assert or state as an attribute or quality of something.").
word("predicate", 'v.', "To base (on); to assert on the grounds of.").
word("predict", 'v.', "To imply.").
word("predict", 'v.', "To make a prediction: to forecast, foretell, or estimate a future event on the basis of knowledge and reasoning; to prophesy a future event on the basis of mystical knowledge or power.").
word("prediction", 'n.', "A statement of what will happen in the future.").
word("prediction", 'n.', "A probability estimation based on statistical methods.").
word("predominance", 'n.', "The condition or state of being predominant; ascendancy, domination, preeminence, preponderance.").
word("predominant", 'adj.', "Significant or important; dominant.").
word("predominant", 'adj.', "Common or widespread; prevalent.").
word("predominate", 'v.', "To be prominent; to loom large; to be the chief component of a whole.").
word("predominate", 'v.', "To dominate, have control, or succeed by superior numbers or size.").
word("preeminence", 'n.', "High importance; superiority.").
word("preeminence", 'n.', "The status of being preeminent, dominant or ascendant.").
word("preempt", 'v.', "To displace or take the place of (by having higher precedence, etc).").
word("preempt", 'v.', "To prevent or beat to the punch, to forestall an expected occurrence by acting first.").
word("preemption", 'n.', "The purchase of something before it is offered for sale to others.").
word("preemption", 'n.', "The purchase of public land by the occupant.").
word("preengage", 'v.', "To engage previously.").
word("preestablish", 'v.', "To establish beforehand.").
word("preexist", 'v.', "To exist before something else.").
word("preexistence", 'n.', "The existence of a soul in a previous embodiment.").
word("preexistence", 'n.', "The condition of having existed prior to the current time.").
word("preface", 'n.', "The beginning or introductory portion that comes before the main text of a document or book.").
word("preface", 'n.', "An introduction, or series of preliminary remarks.").
word("prefatory", 'adj.', "Serving as a preface or prelude; introductory, preliminary.").
word("prefer", 'v.', "To put forward for acceptance; to introduce, recommend ( ).").
word("prefer", 'v.', "To be in the habit of choosing something rather than something else; to favor; to like better.").
word("preferable", 'adj.', "Better than some other option; preferred.").
word("preference", 'n.', "The option to so select, and the one selected.").
word("preference", 'n.', "The selection of one thing or person over others (with the main adposition being \"for\" in relation to the thing or person, but possibly also \"of\")").
word("preferential", 'adj.', "Of or relating to the showing or giving of preference.").
word("preferential", 'adj.', "Of or relating to a voting system in which the voters are allowed to indicate on their ballots their preference (usually their first and second choices) between two or more candidates, so that if no candidate receives a majority of first choices the one receiving the greatest number of first and second choices together is the winner.").
word("preferment", 'n.', "A mixture of flour, water and yeast that is allowed to ferment prior to another baking process").
word("preferment", 'n.', "A position (especially in the Church of England) that provides profit or prestige.").
word("prefix", 'v.', "To put or fix before, or at the beginning of something; to place at the start.").
word("prefix", 'v.', "To determine beforehand; to set in advance.").
word("prehensible", 'adj.', "Capable of being seized.").
word("prehensile", 'adj.', "Able to take hold of and clasp objects; adapted for grasping especially by wrapping around an object.").
word("prehension", 'n.', "The act of grasping or gripping, especially with the hands.").
word("prejudice", 'n.', "An adverse judgment or opinion formed beforehand or without knowledge of the facts.").
word("prejudice", 'n.', "Any preconceived opinion or feeling, whether positive or negative.").
word("prelacy", 'n.', "A church government or organisation administered by prelates.").
word("prelacy", 'n.', "The office of a prelate.").
word("prelate", 'n.', "A clergyman of high rank and authority, having jurisdiction over an area or a group of people; normally a bishop.").
word("prelude", 'n.', "A short, free-form piece of music, originally one serving as an introduction to a longer and more complex piece; later, starting with the Romantic period, generally a stand-alone piece.").
word("prelude", 'n.', "A standard module or library of subroutines and functions to be imported, generally by default, into a program.").
word("premature", 'adj.', "Occurring before a state of readiness or maturity has arrived.").
word("premature", 'adj.', "Taking place earlier than anticipated, prepared for, or desired.").
word("premier", 'adj.', "Foremost; first or highest in quality or degree.").
word("premier", 'adj.', "Most ancient.").
word("premise", 'n.', "Any of the first propositions of a syllogism, from which the conclusion is deduced.").
word("premise", 'n.', "A proposition antecedently supposed or proved; something previously stated or assumed as the basis of further argument; a condition; a supposition.").
word("premonition", 'n.', "A clairvoyant or clairaudient experience, such as a dream, which resonates with some event in the future.").
word("premonition", 'n.', "A strong intuition that something is about to happen (usually something negative, but not exclusively).").
word("preoccupation", 'n.', "The act of occupying something before someone else.").
word("preoccupation", 'n.', "The state of being preoccupied or an idea that preoccupies the mind; enthrallment.").
word("preoccupy", 'v.', "To worry or concern (someone) so as to distract them.").
word("preoccupy", 'v.', "To distract; to occupy or draw attention elsewhere.").
word("preordain", 'v.', "To determine the fate of something in advance.").
word("preparation", 'n.', "The previous introduction, as an integral part of a chord, of a note continued into a succeeding dissonance.").
word("preparation", 'n.', "Devotional exercises introducing an office.").
word("preparatory", 'adj.', "Of or pertaining to preparation, having the purpose of making something or someone ready, preparative.").
word("preponderant", 'adj.', "Having greater or the greatest weight, quantity, importance or force.").
word("preponderate", 'v.', "To exceed in weight or influence; hence, to predominate").
word("preponderate", 'v.', "To outweigh; to be heavier than; to exceed in weight").
word("prepossession", 'n.', "A preconceived opinion, or previous impression; bias, prejudice.").
word("prepossession", 'n.', "Preoccupation; having possession beforehand.").
word("preposterous", 'adj.', "Absurd, or contrary to common sense.").
word("prerogative", 'adj.', "Having a hereditary or official right or privilege.").
word("prerogative", 'adj.', "Characterized by lawless state actions (refers to the prerogative state)").
word("presage", 'v.', "To predict or foretell something.").
word("presage", 'v.', "To make a prediction.").
word("prescience", 'n.', "Knowledge of events before they take place; foresight; foreknowledge.").
word("prescient", 'adj.', "Exhibiting or possessing prescience: having knowledge of, or seemingly able to correctly predict, events before they take place.").
word("prescript", 'adj.', "Directed; prescribed.").
word("prescriptible", 'adj.', "Subject to prescription.").
word("prescription", 'n.', "A written order from an authorized medical practitioner for provision of a medicine or other treatment, such as the specific lenses needed for a pair of glasses.").
word("prescription", 'n.', "Any plan of treatment or planned treatment.").
word("presentient", 'adj.', "Not yet having achieved sentience.").
word("presentient", 'adj.', "Having a presentiment.").
word("presentiment", 'n.', "A premonition; a feeling that something, often of undesirable nature, is going to happen.").
word("presentment", 'n.', "The official notice (formerly required to be given in court) of the surrender of a copyhold estate.").
word("presentment", 'n.', "A formal complaint submitted to a bishop or archdeacon.").
word("preservation", 'n.', "The act of preserving; care to preserve; act of keeping from destruction, decay or any ill.").
word("preservation", 'n.', "The state of being preserved, how something has survived.").
word("presumption", 'n.', "The belief of something based upon reasonable evidence, or upon something known to be true").
word("presumption", 'n.', "An inference that a trier of fact is either permitted or required to draw under certain factual circumstances (as prescribed by statute or case law) unless the party against whom the inference is drawn is able to rebut it with admissible, competent evidence.").
word("presumptuous", 'adj.', "Going beyond what is right, proper, or appropriate because of an excess of self-confidence or arrogance.").
word("pretension", 'n.', "A claim or aspiration to a particular status or quality.").
word("pretension", 'n.', "Pretentiousness.").
word("pretentious", 'adj.', "Marked by an unwarranted claim to importance or distinction.").
word("pretentious", 'adj.', "Intended to impress others.").
word("preternatural", 'adj.', "Beyond or not conforming to what is natural or according to the regular course of things; strange.").
word("preternatural", 'adj.', "Having an existence outside of the natural world.").
word("pretext", 'n.', "A false, contrived, or assumed purpose or reason; a pretense.").
word("prevalence", 'n.', "The total number of cases of a disease in a given statistical population at a given time, divided by the number of individuals in that population.").
word("prevalence", 'n.', "The quality or condition of being prevalent; wide extension or spread.").
word("prevalent", 'adj.', "Superior in frequency or dominant.").
word("prevalent", 'adj.', "Widespread or preferred.").
word("prevaricate", 'v.', "To undertake something falsely and deceitfully, with the purpose of defeating or destroying it.").
word("prevaricate", 'v.', "To shift or turn from direct speech or behaviour; to deviate from the truth; to evade the truth; to waffle or be (intentionally) ambiguous.").
word("prevention", 'n.', "Any measure intended to limit health-related risks (such as information campaigns, vaccination, early diagnosis etc.).").
word("prevention", 'n.', "Precaution; forethought.").
word("prickle", 'v.', "To feel a prickle.").
word("prickle", 'v.', "To cause (someone) to feel a prickle; to prick.").
word("priggish", 'adj.', "Like a prig.").
word("prim", 'adj.', "Formal; precise; affectedly neat or nice").
word("prim", 'adj.', "Prudish, straight-laced").
word("prima", 'adj.', "Most important").
word("primer", 'n.', "A prayer or devotional book intended for laity, initially an abridgment of the breviary and manual including the hours of the Virgin Mary, 15 gradual and 7 penitential psalms, the litany, the placebo and dirige forming the office of the dead, and the commendations.").
word("primer", 'n.', "A children's book intended to teach literacy: how to read, write, and spell.").
word("primeval", 'adj.', "Belonging to the first ages.").
word("primeval", 'adj.', "Primary; original.").
word("primitive", 'adj.', "Of or pertaining to the beginning or origin, or to early times; original; primordial; primeval; first.").
word("primitive", 'adj.', "Of or pertaining to or harking back to a former time; old-fashioned; characterized by simplicity.").
word("principal", 'adj.', "Primary; most important; first level in importance.").
word("principal", 'adj.', "Of or relating to a prince; princely.").
word("principality", 'n.', "The state of being a prince or ruler; sovereignty, absolute authority.").
word("principality", 'n.', "A spiritual being, specifically in Christian angelology, the fifth level of angels, ranked above powers and below dominions.").
word("principle", 'n.', "A fundamental assumption or guiding belief.").
word("principle", 'n.', "A source, or origin; that from which anything proceeds; fundamental substance or energy; primordial substance; ultimate element, or cause.").
word("priory", 'n.', "A monastery or convent governed by a prior or prioress.").
word("pristine", 'adj.', "Primitive, pertaining to the earliest state of something.").
word("pristine", 'adj.', "Perfect.").
word("privateer", 'n.', "An officer or any other member of the crew of such a ship; a government-sanctioned pirate.").
word("privateer", 'n.', "A privately owned warship that had official sanction to attack enemy ships and take possession of their cargo.").
word("privilege", 'n.', "A particular benefit, advantage, or favor; a right or immunity enjoyed by some but not others; a prerogative, preferential treatment.").
word("privilege", 'n.', "A right or immunity enjoyed by a legislative body or its members.").
word("privity", 'n.', "A relationship between parties seen as being a result of their mutual interest or participation in a given transaction, e.g. contract, estate, etc.").
word("privity", 'n.', "The genitals.").
word("privy", 'adj.', "With knowledge of; party to; let in on.").
word("privy", 'adj.', "Secret, hidden, concealed.").
word("probation", 'n.', "The act of testing; proof").
word("probation", 'n.', "A type of sentence where convicted criminals are allowed to continue living in the community but will automatically be sent to jail if they violate certain conditions").
word("probe", 'v.', "To explore, investigate, or question").
word("probe", 'v.', "To insert a probe into.").
word("probity", 'n.', "Integrity, especially of the quality of having strong moral principles; decency and honesty.").
word("procedure", 'n.', "The set of established forms or methods of an organized body for accomplishing a certain task or tasks.").
word("procedure", 'n.', "A series of small tasks or steps taken to accomplish an end.").
word("proceed", 'v.', "To go on in an orderly or regulated manner; to begin and carry on a series of acts or measures; to act methodically").
word("proceed", 'v.', "To be applicable or effective; to be valid.").
word("proclamation", 'n.', "A statement which is proclaimed; formal public announcement.").
word("procrastinate", 'v.', "To put off; to delay (something).").
word("procrastinate", 'v.', "To delay taking action; to wait until later.").
word("procrastination", 'n.', "The act of postponing, delaying or putting off, especially habitually or intentionally.").
word("proctor", 'n.', "One appointed to collect alms for those who could not go out to beg for themselves, such as lepers and the bedridden.").
word("proctor", 'n.', "A legal practitioner in ecclesiastical and some other courts.").
word("prodigal", 'n.', "A prodigal person, a spendthrift.").
word("prodigious", 'adj.', "Very big in size or quantity; colossal, gigantic, huge.").
word("prodigious", 'adj.', "Extraordinarily amazing or exciting.").
word("prodigy", 'n.', "An amazing or marvellous thing; a wonder.").
word("prodigy", 'n.', "An extraordinary thing seen as an omen; a portent.").
word("productive", 'adj.', "Yielding good or useful results; constructive.").
word("productive", 'adj.', "Of, or relating to the creation of goods or services.").
word("profession", 'n.', "The practitioners of such an occupation collectively.").
word("profession", 'n.', "A declaration of belief, faith or one's opinion, whether genuine or pretended.").
word("professor", 'n.', "A teacher or faculty member at a college or university regardless of formal rank.").
word("professor", 'n.', "The puppeteer who performs a Punch and Judy show; a Punchman.").
word("proffer", 'v.', "To offer for acceptance; to propose to give; to make a tender of.").
word("proffer", 'v.', "To attempt or essay of one's own accord; to undertake or propose to undertake.").
word("proficiency", 'n.', "Ability, skill, competence.").
word("proficient", 'adj.', "Good at something; skilled; fluent; practiced, especially in relation to a task or skill.").
word("profile", 'n.', "A smoothed (e.g., troweled or brushed) vertical surface of an excavation showing evidence of at least one feature or diagnostic specimen; the graphic recording of such as by sketching, photographing, etc.").
word("profile", 'n.', "A section of any member, made at right angles with its main lines, showing the exact shape of mouldings etc.").
word("profiteer", 'n.', "One who makes an unreasonable profit not justified by cost or risk, a rent-seeker.").
word("profligacy", 'n.', "Shameless and immoral behaviour.").
word("profligacy", 'n.', "Careless wastefulness.").
word("profligate", 'adj.', "Immoral; abandoned to vice.").
word("profligate", 'adj.', "Inclined to waste resources or behave extravagantly.").
word("profuse", 'adj.', "Abundant or generous to the point of excess.").
word("progeny", 'n.', "Offspring or descendants considered as a group.").
word("progeny", 'n.', "A result of a creative effort.").
word("progression", 'n.', "The act of moving forward or proceeding in a course; motion onward.").
word("progression", 'n.', "The act of moving from one thing to another.").
word("prohibition", 'n.', "A period of time when specific socially disapproved consumables are considered controlled substances.").
word("prohibition", 'n.', "An act of prohibiting, forbidding, disallowing, or proscribing something.").
word("prohibitionist", 'n.', "A person who agrees with, or advocates a prohibition, especially the outlawing of the sale of alcoholic beverages").
word("prohibitory", 'adj.', "That serves to prohibit or forbid").
word("projection", 'n.', "The crisis or decisive point of any process, especially a culinary process.").
word("projection", 'n.', "Any of several systems of intersecting lines that allow the curved surface of the earth to be represented on a flat surface. The set of mathematics used to calculate coordinate positions.").
word("proletarian", 'n.', "A member of the proletariat.").
word("prolific", 'adj.', "Fertile; producing offspring or fruit in abundance — applied to plants producing fruit, animals producing young, etc.").
word("prolific", 'adj.', "Similarly producing results or performing deeds in abundance").
word("prolix", 'adj.', "Tediously lengthy; dwelling on trivial details.").
word("prolix", 'adj.', "Long; having great length.").
word("prologue", 'n.', "A speech or section used as an introduction, especially to a play or novel.").
word("prologue", 'n.', "An individual time trial before a stage race, used to determine which rider wears the leader's jersey on the first stage.").
word("prolong", 'v.', "To lengthen in time; to extend the duration of").
word("prolong", 'v.', "To extend in space or length.").
word("promenade", 'v.', "To walk for amusement, show, or exercise.").
word("promenade", 'v.', "To perform the stylized walk of a square dance.").
word("prominence", 'n.', "A bulge: something that bulges out or is protuberant or projects from a form.").
word("prominence", 'n.', "A gaseous projection, often loop-shaped, springing from the surface of the Sun or a star.").
word("prominent", 'adj.', "Likely to attract attention from its size or position; conspicuous").
word("prominent", 'adj.', "Standing out, or projecting; jutting; protuberant").
word("promiscuous", 'adj.', "Made up of various disparate elements mixed together; of disorderly composition.").
word("promiscuous", 'adj.', "The mode in which an NIC gathers all network traffic instead of getting only the traffic intended for it.").
word("promissory", 'adj.', "Stipulating the future actions required of the parties to an insurance policy or other business agreement.").
word("promissory", 'adj.', "Containing or consisting of a promise.").
word("promontory", 'n.', "A high point of land extending into a body of water, headland; cliff.").
word("promontory", 'n.', "A projecting part of the body.").
word("promoter", 'n.', "An accelerator of catalysis that is not itself a catalyst.").
word("promoter", 'n.', "The section of DNA that controls the initiation of RNA transcription as a product of a gene.").
word("promulgate", 'v.', "To make known or public.").
word("promulgate", 'v.', "To put into effect as a regulation.").
word("propaganda", 'n.', "A concerted set of messages aimed at influencing the opinions or behavior of large numbers of people.").
word("propagate", 'v.', "To spread from person to person; to extend the knowledge of; to originate and spread; to carry from place to place; to disseminate").
word("propagate", 'v.', "To cause to spread to extend; to impel or continue forward in space").
word("propel", 'v.', "To provide an impetus for motion or physical action, to cause to move in a certain direction; to drive forward.").
word("propel", 'v.', "To provide an impetus for non-physical change, to make to arrive to a certain situation or result.").
word("propeller", 'n.', "One who, or that which, propels.").
word("propeller", 'n.', "A mechanical device with evenly-shaped blades that turn on a shaft to push against air or water, especially one used to propel an aircraft or boat.").
word("prophecy", 'n.', "The public interpretation of Scripture.").
word("prophecy", 'n.', "A prediction, especially one made by a prophet or under divine inspiration.").
word("prophesy", 'v.', "To predict, to foretell (with or without divine inspiration).").
word("prophesy", 'v.', "To speak out on the Bible as an expression of holy inspiration; to preach.").
word("propitious", 'adj.', "Favorably disposed towards someone.").
word("propitious", 'adj.', "Characteristic of a good omen.").
word("proportionate", 'adj.', "Harmonious and symmetrical.").
word("proportionate", 'adj.', "In proportion; proportional; commensurable.").
word("propriety", 'n.', "The fact of possessing something; ownership.").
word("propriety", 'n.', "Suitability, fitness; the quality of being appropriate.").
word("propulsion", 'n.', "The action of driving or pushing, typically forward or onward; a propulsive force or impulse.").
word("prosaic", 'adj.', "Straightforward; matter-of-fact; lacking the feeling or elegance of poetry.").
word("prosaic", 'adj.', "Overly plain, simple or commonplace, to the point of being boring.").
word("proscenium", 'n.', "The stage area between the curtain and the orchestra.").
word("proscenium", 'n.', "The row of columns at the front the scene building, at first directly behind the circular orchestra but later upon a stage.").
word("proscribe", 'v.', "To banish or exclude.").
word("proscribe", 'v.', "To forbid or prohibit.").
word("proscription", 'n.', "Decree of condemnation toward one or more persons, especially in the Roman antiquity.").
word("proscription", 'n.', "A decree or law that prohibits.").
word("proselyte", 'n.', "One who has converted to a religion or doctrine, especially a gentile converted to Judaism.").
word("prosody", 'n.', "The study of poetic meter; the patterns of sounds and rhythms in verse.").
word("prosody", 'n.', "The study of rhythm, intonation, stress, and related attributes in speech.").
word("prospector", 'n.', "A person who explores or prospects an area in search of mineral deposits, such as gold.").
word("prospectus", 'n.', "A document which describes a proposed endeavor (venture, undertaking), such as a literary work (which one proposes to write).").
word("prospectus", 'n.', "A booklet or other document giving details of a share offer for the benefit of investors.").
word("prostrate", 'adj.', "Trailing on the ground; procumbent.").
word("prostrate", 'adj.', "Lying flat, face-down.").
word("protagonist", 'n.', "The main character, or one of the main characters, in any story, such as a literary work or drama.").
word("protagonist", 'n.', "A leading person in a contest; a principal performer.").
word("protection", 'n.', "Immunity from harm, obtained by illegal payments, as bribery or extortion.").
word("protection", 'n.', "A document serving as a guarantee against harm or interference; a passport.").
word("protective", 'adj.', "Serving, intended or wishing to protect").
word("protector", 'n.', "A cardinal, from one of the more considerable Roman Catholic nations, who looks after the interests of his people at Rome; also, a cardinal who has the same relation to a college, religious order, etc.").
word("protector", 'n.', "One who prevents interference.").
word("protestant", 'n.', "One who protests; a protester.").
word("protocol", 'n.', "The minutes, or official record, of a negotiation or transaction; especially a document drawn up officially which forms the legal basis for subsequent agreements based on it.").
word("protocol", 'n.', "An official record of a diplomatic meeting or negotiation; later specifically, a draft document setting out agreements to be signed into force by a subsequent formal treaty.").
word("protomartyr", 'n.', "Any of the first Christian martyrs.").
word("protoplasm", 'n.', "The entire contents of a cell comprising the nucleus and the cytoplasm. It is a semi-fluid, transparent substance which is the living matter of plant and animal cells.").
word("prototype", 'n.', "An original form or object which is a basis for other forms or objects (particularly manufactured items), or for its generalizations and models.").
word("prototype", 'n.', "An instance of a category or a concept that combines its most representative attributes.").
word("protract", 'v.', "To draw out; to extend, especially in duration.").
word("protract", 'v.', "To put off to a distant time; to delay; to defer.").
word("protrude", 'v.', "To thrust forward; to drive or force along.").
word("protrude", 'v.', "To extend from, above or beyond a surface or boundary; to bulge outward; to stick out.").
word("protrusion", 'n.', "The act of protruding.").
word("protrusion", 'n.', "The state of being protruded.").
word("protuberance", 'n.', "A bulge, knob, swelling, spine or anything that protrudes.").
word("protuberant", 'adj.', "Swelling or bulging outward.").
word("protuberate", 'v.', "To cause to bulge outward.").
word("protuberate", 'v.', "To bulge outward, producing a rounded protuberance.").
word("proverb", 'n.', "A striking or paradoxical assertion; an obscure saying; an enigma; a parable.").
word("proverb", 'n.', "A familiar illustration; a subject of contemptuous reference.").
word("provident", 'adj.', "Possessing, exercising, or demonstrating great care and consideration for the future.").
word("provident", 'adj.', "Showing care in the use of something (especially money or provisions), so as to avoid wasting it.").
word("providential", 'adj.', "Pertaining to divine providence.").
word("providential", 'adj.', "Fortunate, as if occurring through the intervention of Providence.").
word("provincial", 'adj.', "Narrow; illiberal.").
word("provincial", 'adj.', "Limited in outlook; narrow.").
word("proviso", 'n.', "A conditional provision to an agreement.").
word("provocation", 'n.', "The second step in OPQRST regarding the investigation of what makes the symptoms MOI or NOI improve or deteriorate.").
word("provocation", 'n.', "The act of provoking, inciting or annoying someone into doing something").
word("prowess", 'n.', "Skillfulness and manual ability; adroitness or dexterity.").
word("prowess", 'n.', "Distinguished bravery or courage, especially in battle; heroism.").
word("proximately", 'adv.', "In a proximate manner, position, or degree; immediately.").
word("proxy", 'n.', "A measurement of one physical quantity that is used as an indicator of the value of another").
word("proxy", 'n.', "An agent or substitute authorized to act for another person.").
word("prudence", 'n.', "Economy; frugality.").
word("prudence", 'n.', "The quality or state of being prudent; wisdom in the way of caution and provision; discretion; carefulness").
word("prudential", 'adj.', "Advisory; superintending or executive.").
word("prudential", 'adj.', "Characterised by the use of prudence; arising from careful thought or deliberation.").
word("prudery", 'n.', "The condition of being prudish; prudishness").
word("prudery", 'n.', "Prudish behaviour").
word("prurient", 'adj.', "Uneasy with desire; itching; especially, having a lascivious anxiety or propensity; lustful.").
word("prurient", 'adj.', "Arousing or appealing to sexual desire.").
word("pseudonym", 'n.', "A fictitious name (more literally, a false name), as those used by writers and movie stars.").
word("pseudonymity", 'n.', "The state of being pseudonymous, of hiding one's true identity behind a pseudonym.").
word("psychiatry", 'n.', "The branch of medicine that subjectively diagnoses, treats, and studies mental disorders and behavioural conditions.").
word("psychic", 'adj.', "Relating to the psyche or mind, or to mental activity in general.").
word("psychic", 'adj.', "Relating to or having the abilities of a psychic.").
word("psychopathic", 'adj.', "Exhibiting the behaviors and personality traits of a psychopath.").
word("psychotherapy", 'n.', "The treatment of people diagnosed with mental and emotional disorders using dialogue and a variety of psychological techniques.").
word("pudgy", 'adj.', "Fat, overweight (pertaining particularly to children), plump; chubby.").
word("puerile", 'adj.', "Childish; trifling; silly.").
word("puerile", 'adj.', "Characteristic of, or pertaining to, a boy or boys; compare .").
word("pugnacious", 'adj.', "Naturally aggressive or hostile; combative; belligerent; bellicose.").
word("puissant", 'adj.', "Powerful, mighty, having authority.").
word("pulmonary", 'adj.', "Pertaining to, having, or affecting the lungs.").
word("punctilious", 'adj.', "Strictly attentive to detail; meticulous or fastidious, particularly to codes or conventions.").
word("punctilious", 'adj.', "Precise or scrupulous; finicky or nitpicky.").
word("punctual", 'adj.', "Prompt; on time.").
word("punctual", 'adj.', "Existing as a point or series of points").
word("pungency", 'n.', "A foul odor.").
word("pungency", 'n.', "The state of being pungent.").
word("pungent", 'adj.', "Having a strong odor that stings the nose, said especially of acidic or spicy substances.").
word("pungent", 'adj.', "Having a strong taste that stings the tongue, said especially of hot (spicy) food, which has a strong and sharp or bitter taste.").
word("punitive", 'adj.', "Inflicting punishment; punishing.").
word("pupilage", 'n.', "The period during which one is a pupil").
word("pupilage", 'n.', "The condition of being a pupil").
word("purgatory", 'n.', "Any situation where suffering is endured, particularly as part of a process of redemption.").
word("purl", 'v.', "To flow with a murmuring sound in swirls and eddies.").
word("purl", 'v.', "To upset, to spin, capsize, fall heavily, fall headlong.").
word("purloin", 'v.', "To take the property of another, often in breach of trust; to appropriate wrongfully; to steal.").
word("purloin", 'v.', "To commit theft; to thieve.").
word("purport", 'n.', "Disguise; covering").
word("purport", 'n.', "Import, intention or purpose").
word("purveyor", 'n.', "Someone who supplies what is needed, especially food.").
word("purveyor", 'n.', "An officer who provided provisions for the king's household.").
word("pusillanimous", 'adj.', "Showing ignoble cowardice, or contemptible timidity.").
word("putrescent", 'adj.', "Becoming putrid; putrefying.").
word("pyre", 'n.', "A funeral pile; a combustible heap on which corpses are burned.").
word("pyre", 'n.', "Any heap or pile of combustibles.").
word("pyromania", 'n.', "A compulsive disorder characterized by obsession with fire or uncontrollable urges to start fires.").
word("pyrotechnic", 'adj.', "Of or relating to fireworks.").
word("pyrotechnic", 'adj.', "Of or relating to the use of fire in chemistry or metallurgy.").
word("pyx", 'n.', "A small, usually round container used to hold the , especially when bringing communion to the sick or others unable to attend Mass.").
word("pyx", 'n.', "A box used in a mint as a place to deposit sample coins intended to have the fineness of their metal and their weight tested before the coins are issued to the public.").
word("quackery", 'n.', "An instance of practicing fraudulent medicine.").
word("quackery", 'n.', "The practice of fraudulent medicine, usually in order to make money or for ego gratification and power; health fraud.").
word("quadrate", 'v.', "To square.").
word("quadrate", 'v.', "To adjust (a gun) on its carriage.").
word("quadruple", 'v.', "To multiply by four.").
word("quadruple", 'v.', "To increase by a factor of four.").
word("qualification", 'n.', "The act or process of qualifying for a position, achievement etc.").
word("qualification", 'n.', "An ability or attribute that aids someone's chances of qualifying for something; specifically, completed professional training.").
word("qualify", 'v.', "To modify, limit, restrict or moderate something; especially to add conditions or requirements for an assertion to be true.").
word("qualify", 'v.', "To certify or license someone for something.").
word("qualm", 'n.', "A feeling of apprehension, doubt, fear etc.").
word("qualm", 'n.', "A calamity or disaster.").
word("quandary", 'n.', "A state of not knowing what to decide; a state of difficulty or perplexity; a state of uncertainty, hesitation or puzzlement.").
word("quandary", 'n.', "A dilemma, a difficult decision or choice.").
word("quantity", 'n.', "Property of a phenomenon, body, or substance, where the property has a magnitude that can be expressed as number and a reference.").
word("quantity", 'n.', "A fundamental, generic term used when referring to the measurement (count, amount) of a scalar, vector, number of items or to some other way of denominating the value of a collection or group of items.").
word("quarantine", 'n.', "A certain period of time during which a person is isolated to determine whether they've been infected with a contagious disease.").
word("quarantine", 'n.', "A sanitary measure to prevent the spread of a contagious plague by isolating those believed or feared to be infected.").
word("quarrelsome", 'adj.', "Argumentative; fond of or prone to quarreling.").
word("quarter", 'n.', "A section (of a population), especially one having a particular set of values or interests.").
word("quarter", 'n.', "A fourth part of something.").
word("quarterly", 'adj.', "(of a coat of arms) Divided into four parts crosswise.").
word("quarterly", 'adj.', "Occurring once every quarter year (three months).").
word("quartet", 'n.', "A music composition in four parts, each performed by a single voice or instrument.").
word("quartet", 'n.', "Any group of four, especially people.").
word("quarto", 'n.', "A size of paper (7.5\"-10\" x 10\"-12.5\" or 190-254 x 254-312 mm). Formed by folding and cutting one of several standard sizes of paper (15\"-20\" x 20\"-25\" or 381-508 x 508-635 mm) twice to form 4 leaves (eight sides).").
word("quarto", 'n.', "A book size, corresponding to the paper size.").
word("quay", 'n.', "A stone or concrete structure on navigable water used for loading and unloading vessels; a wharf.").
word("querulous", 'adj.', "Often complaining; suggesting a complaint in expression; fretful, whining.").
word("query", 'v.', "To ask, inquire.").
word("query", 'v.', "To pass a set of instructions to a database to retrieve information from it.").
word("queue", 'n.', "A line of people, vehicles or other objects, in which one at the front end is dealt with first, the one behind is dealt with next, and so on, and which newcomers join at the opposite end (the back).").
word("queue", 'n.', "A waiting list or other means of organizing people or objects into a first-come-first-served order.").
word("quibble", 'n.', "An objection or argument based on an ambiguity of wording or similar trivial circumstance; a minor complaint.").
word("quibble", 'n.', "A pun.").
word("quiescence", 'n.', "Being at rest, quiet, still, inactive or motionless.").
word("quiescence", 'n.', "In insects, a temporary slowing down of metabolism and development in response to adverse environmental conditions, which, unlike diapause, does not involve physiological changes.").
word("quiescent", 'adj.', "Inactive, quiet, at rest.").
word("quiescent", 'adj.', "Not sounded; silent.").
word("quiet", 'adj.', "With little or no sound; free of disturbing noise.").
word("quiet", 'adj.', "Not busy, of low quantity.").
word("quietus", 'n.', "Final settlement (e.g., of a debt).").
word("quietus", 'n.', "Death.").
word("quintessence", 'n.', "The essence of a thing in its purest and most concentrated form.").
word("quintessence", 'n.', "A thing that is the most perfect example of its type; the most perfect embodiment of something; epitome, prototype.").
word("quintet", 'n.', "A composition (a type of chamber music) in five parts (typically each a singer or instrumentalist, sometimes several musicians)").
word("quintet", 'n.', "A group of five musicians, fit to play such a piece of music together").
word("quixotic", 'adj.', "Possessing or acting with the desire to do noble and romantic deeds, without thought of realism and practicality; exceedingly idealistic.").
word("quixotic", 'adj.', "Like Don Quixote; romantic to extravagance; absurdly chivalric; apt to be deluded.").
word("rabid", 'adj.', "Very extreme, unreasonable, or fanatical in opinion; excessively zealous.").
word("rabid", 'adj.', "Affected with rabies.").
word("racy", 'adj.', "Exciting to the mind by a strong or distinctive character of thought or language; peculiar and piquant; fresh and lively.").
word("racy", 'adj.', "Having a strong flavor indicating origin; of distinct characteristic taste; tasting of the soil.").
word("radiance", 'n.', "The quality of being radiant, shining, bright or splendid.").
word("radiance", 'n.', "The flux of radiation emitted per unit solid angle in a given direction by a unit area of a source.").
word("radiate", 'v.', "To manifest oneself in a glowing manner.").
word("radiate", 'v.', "To come out or proceed in rays or waves.").
word("radical", 'n.', "In Semitic languages, any one of the set of consonants (typically three) that make up a root.").
word("radical", 'n.', "Given an ideal I in a commutative ring R, another ideal, denoted Rad(I) or \sqrt{I} , such that an element x ∈ R is in Rad(I) if, for some positive integer n, x n  ∈ I; equivalently, the intersection of all prime ideals containing I.").
word("radix", 'n.', "The number of distinct symbols used to represent numbers in a particular base, as ten for decimal.").
word("radix", 'n.', "A primitive word, from which other words may be derived.").
word("raillery", 'n.', "Good-natured ridicule, jest or banter.").
word("ramify", 'v.', "To divide into branches or subdivisions.").
word("ramify", 'v.', "To spread or diversify into multiple fields or categories.").
word("ramose", 'adj.', "Having branches; branching").
word("rampant", 'adj.', "Unrestrained or unchecked, usually in a negative manner.").
word("rampant", 'adj.', "Tilted, said of an arch with one side higher than the other, or a vault whose two abutments are located on an inclined plane.").
word("rampart", 'n.', "A defensive mound of earth or a wall with a broad top and usually a stone parapet; a wall-like ridge of earth, stones or debris; an embankment for defensive purpose.").
word("rampart", 'n.', "That which defends against intrusion from outside; a protection.").
word("rancor", 'n.', "A feeling of long-lasting ire for another, sometimes to the point of hatred, over a perceived wrongdoing; bitterness.").
word("rancor", 'n.', "Rancidity, rankness.").
word("rankle", 'v.', "To cause irritation or deep bitterness.").
word("rankle", 'v.', "To fester.").
word("rapacious", 'adj.', "Given to taking by force or plundering; aggressively greedy.").
word("rapacious", 'adj.', "Subsisting off live prey.").
word("rapid", 'adj.', "Needing only a brief exposure time. (of a lens, plate, film, etc.)").
word("rapid", 'adj.', "Steep, changing altitude quickly. (of a slope)").
word("rapine", 'n.', "The seizure of someone's property by force; pillage, plunder.").
word("rapt", 'adj.', "Very interested, involved in something, absorbed, transfixed; fascinated or engrossed.").
word("rapt", 'adj.', "Enthusiatic; ecstatic, elated, happy.").
word("raptorial", 'adj.', "Like or resembling a raptor; seizing or plundering, like a bird of prey.").
word("ration", 'v.', "To portion out (especially during a shortage of supply); to limit access to.").
word("ration", 'v.', "To restrict (an activity etc.)").
word("rationalism", 'n.', "Elaboration of theories by use of reason alone without appeal to experience, such as in mathematical systems.").
word("rationalism", 'n.', "A view that the fundamental method for problem solving is through reason and experience rather than faith, inspiration, revelation, intuition or authority.").
word("raucous", 'adj.', "Harsh and rough-sounding.").
word("raucous", 'adj.', "Disorderly and boisterous.").
word("ravage", 'v.', "To pillage or sack something, to lay waste to something.").
word("ravage", 'v.', "To wreak destruction.").
word("ravenous", 'adj.', "Very hungry.").
word("ravenous", 'adj.', "Grasping; characterized by strong desires.").
word("ravine", 'n.', "A deep narrow valley or gorge in the earth's surface worn by running water.").
word("reaction", 'n.', "An action or statement in response to a stimulus or other event.").
word("reaction", 'n.', "A transformation in which one or more substances is converted into another by combination or decomposition.").
word("reactionary", 'adj.', "Anti-progressive; favoring a return to an imagined \"golden age\" of the past.").
word("reactionary", 'adj.', "Of, pertaining to, participating in or inducing a chemical reaction.").
word("readily", 'adv.', "Without impediment, easily.").
word("readily", 'adv.', "Without unwillingness or hesitation; showing readiness.").
word("readjust", 'v.', "To adjust again").
word("ready", 'adj.', "Prepared for immediate action or use.").
word("ready", 'adj.', "Not slow or hesitating; quick in action or perception of any kind.").
word("realism", 'n.', "A doctrine that universals are real—they exist and are distinct from the particulars that instantiate them.").
word("realism", 'n.', "A concern for fact or reality and rejection of the impractical and visionary.").
word("rearrange", 'v.', "To change the order or arrangement of (one or more items).").
word("reassure", 'v.', "To assure anew; to restore confidence to; to free from fear or self-doubt.").
word("reassure", 'v.', "To reinsure.").
word("rebellious", 'adj.', "Showing rebellion.").
word("rebuff", 'n.', "A sudden resistance or refusal.").
word("rebuff", 'n.', "Repercussion, or beating back.").
word("rebuild", 'v.', "To build again or anew.").
word("rebut", 'v.', "To deny the truth of something, especially by presenting arguments that disprove it.").
word("rebut", 'v.', "To drive back or beat back; to repulse.").
word("recant", 'v.', "To give a new cant (slant, angle) to something, in particular railway track on a curve.").
word("recant", 'v.', "To withdraw or repudiate a statement or opinion formerly expressed, especially formally and publicly.").
word("recapitulate", 'v.', "To summarize or repeat in concise form.").
word("recapitulate", 'v.', "To reproduce or closely resemble (as in structure or function).").
word("recapture", 'v.', "To capture something for a second or subsequent time, especially after a loss.").
word("recede", 'v.', "To cede back; to grant or yield again to a former possessor.").
word("recede", 'v.', "To move back; to retreat; to withdraw.").
word("receivable", 'adj.', "Capable of being received, especially of a debt, from the perspective of the creditor.").
word("receptive", 'adj.', "Capable of receiving something.").
word("receptive", 'adj.', "Ready to receive something, especially new concepts or ideas.").
word("recessive", 'adj.', "Able to be masked by a dominant allele or trait.").
word("recessive", 'adj.', "Going back; receding.").
word("recidivist", 'n.', "One who falls back into prior habits, especially criminal habits.").
word("reciprocal", 'adj.', "Of a feeling, action or such: mutual, uniformly felt or done by each party towards the other or others; two-way.").
word("reciprocal", 'adj.', "Mutually interchangeable.").
word("reciprocate", 'v.', "To exchange two things, with both parties giving one thing and taking another thing.").
word("reciprocate", 'v.', "To move backwards and forwards, like a piston.").
word("reciprocity", 'n.', "A relation of mutual dependence or action or influence.").
word("reciprocity", 'n.', "The responses of individuals to the actions of others.").
word("recitation", 'n.', "(music) A part of a song's lyrics that is spoken rather than sung.").
word("recitation", 'n.', "A regularly scheduled class, in a school, in which discussion occurs of the material covered in a parallel lecture.").
word("reck", 'v.', "To concern, to be important or earnest.").
word("reck", 'v.', "To think.").
word("reckless", 'adj.', "Careless or heedless; headstrong or rash.").
word("reckless", 'adj.', "Indifferent to danger or the consequences.").
word("reclaim", 'v.', "To appeal from the Lord Ordinary to the inner house of the Court of Session.").
word("reclaim", 'v.', "To bring back a term into acceptable usage, usually of a slur, and usually by the group that was once targeted by that slur.").
word("recline", 'v.', "To put oneself in a resting position.").
word("recline", 'v.', "To cause to lean back; to bend back.").
word("recluse", 'n.', "A person who lives in self-imposed isolation or seclusion from the world, especially for religious purposes; a hermit").
word("recluse", 'n.', "The place where a recluse dwells; a place of isolation or seclusion").
word("reclusory", 'n.', "The habitation of a recluse; a hermitage.").
word("recognizance", 'n.', "A form of bail; a promise made by the accused to the court that they will attend all required judicial proceedings and will not engage in further illegal activity or other prohibited conduct as set by the court.").
word("recognizance", 'n.', "Acknowledgment of a person or thing; avowal; profession; recognition.").
word("recognize", 'v.', "To match (something or someone which one currently perceives) to a memory of some previous encounter with the same person or thing.").
word("recognize", 'v.', "To acknowledge or consider (as being a certain thing or having a certain quality or property).").
word("recoil", 'v.', "To pull back, especially in disgust, horror or astonishment.").
word("recoil", 'v.', "To retreat before an opponent.").
word("recollect", 'v.', "To recall; to collect one's thoughts again, especially about past events.").
word("recollect", 'v.', "To collect (things) together again.").
word("reconcilable", 'adj.', "Capable of being reconciled.").
word("reconnoiter", 'v.', "To perform a reconnaissance (of an area; an enemy position); to scout with the aim of acquiring information.").
word("reconsider", 'v.', "To consider a matter again.").
word("reconstruct", 'v.', "To construct again; to restore.").
word("reconstruct", 'v.', "To attempt to understand an event by recreating or talking through the circumstances.").
word("recourse", 'n.', "The act of seeking assistance or advice.").
word("recourse", 'n.', "A coursing back, or coursing again; renewed course; return; retreat; recurrence.").
word("recover", 'v.', "To get better, to regain health or prosperity.").
word("recover", 'v.', "To regain one's composure, balance etc.").
word("recreant", 'n.', "Somebody who is recreant, who yields in combat; a coward or traitor.").
word("recreate", 'v.', "To give new life, energy or encouragement (to); to refresh, enliven.").
word("recreate", 'v.', "To create anew.").
word("recrudescence", 'n.', "The condition or state being recrudescent; the condition of something (often undesirable) breaking out again, or re-emerging after temporary abatement or suppression.").
word("recrudescence", 'n.', "The production of a fresh shoot from a ripened spike.").
word("recrudescent", 'adj.', "Growing raw, sore, or painful again.").
word("recrudescent", 'adj.', "Breaking out again or reemerging after temporary abatement or suppression.").
word("recurrent", 'adj.', "Running back toward its origin.").
word("recurrent", 'adj.', "Non-transient.").
word("redemption", 'n.', "The recovery, for a fee, of a pawned article.").
word("redemption", 'n.', "The act of redeeming or something redeemed.").
word("redolence", 'n.', "An evocative fragrance.").
word("redolence", 'n.', "The quality of being redolent.").
word("redolent", 'adj.', "Having the smell of the article in question.").
word("redolent", 'adj.', "Fragrant or aromatic; having a sweet scent.").
word("redoubtable", 'adj.', "Eliciting respect or fear; imposing; awe-inspiring.").
word("redoubtable", 'adj.', "Valiant.").
word("redound", 'n.', "A coming back, as an effect or consequence; a return.").
word("redress", 'v.', "To make amends or compensation to; to relieve of anything unjust or oppressive; to bestow relief upon.").
word("redress", 'v.', "To put in order again; to set right; to revise.").
word("reducible", 'adj.', "Containing a sphere of codimension 1 that is not the boundary of a ball.").
word("reducible", 'adj.', "Able to be factored into smaller integers; composite.").
word("redundance", 'n.', "Redundancy.").
word("redundant", 'adj.', "Duplicating or able to duplicate the function of another component of a system, providing backup in the event the other component fails.").
word("redundant", 'adj.', "Superfluous; exceeding what is necessary, no longer needed.").
word("reestablish", 'v.', "To restore to a previously operational state.").
word("reestablish", 'v.', "To establish again.").
word("refer", 'v.', "To submit to (another person or group) for consideration; to send or direct elsewhere.").
word("refer", 'v.', "To direct the attention of.").
word("referee", 'n.', "An umpire or judge; an official who makes sure the rules are followed during a game.").
word("referee", 'n.', "An expert who judges the manuscript of an article or book to decide if it should be published.").
word("referrer", 'n.', "A person who refers another.").
word("referrer", 'n.', "The URL from which a user agent was referred to another URL.").
word("refinery", 'n.', "A building, or a mass of machinery, used to produce refined products such as sugar, oil, or metals.").
word("reflectible", 'adj.', "Capable of being reflected or thrown back; reflexible.").
word("reflection", 'n.', "The property of a propagated wave being thrown back from a surface (such as a mirror).").
word("reflection", 'n.', "The folding of a part; a fold.").
word("reflector", 'n.', "One who reflects on something; one who thinks or considers at length.").
word("reflector", 'n.', "Something which reflects heat, light or sound, especially something having a reflecting surface.").
word("reflexible", 'adj.', "Capable of being reflected, or thrown back.").
word("reform", 'n.', "The change of something that is defective, broken, inefficient or otherwise negative, in order to correct or improve it").
word("reformer", 'n.', "A device which converts hydrocarbons into a hydrogen-rich mixture of gases.").
word("reformer", 'n.', "One who reforms, or who works for reform.").
word("refract", 'v.', "To change direction as a result of entering a different medium").
word("refract", 'v.', "To cause (light) to change direction as a result of entering a different medium.").
word("refractory", 'adj.', "Obstinate and unruly; strongly opposed to something.").
word("refractory", 'adj.', "Difficult to treat.").
word("refragable", 'adj.', "Capable of being refuted; refutable.").
word("refringency", 'n.', "The power of a substance to refract a ray.").
word("refringent", 'adj.', "That refracts; refractive").
word("refusal", 'n.', "Depth or point at which well or borehole drilling cannot continue.").
word("refusal", 'n.', "The act of refusing.").
word("refute", 'v.', "To prove (something) to be false or incorrect.").
word("refute", 'v.', "To deny the truth or correctness of (something).").
word("regale", 'v.', "To please or entertain (someone).").
word("regale", 'v.', "To entertain with something that delights; to gratify; to refresh.").
word("regalia", 'n.', "The emblems, symbols, or paraphernalia indicative of royalty or any other sovereign status; such as a crown, orb, sceptre or sword.").
word("regalia", 'n.', "Traditional dress and accessories of North American Indigenous nations worn for ritual purposes.").
word("regality", 'n.', "Royalty; sovereignty; sovereign jurisdiction.").
word("regenerate", 'v.', "Of a water softener: to flush out the minerals extracted from the water supply.").
word("regenerate", 'v.', "To become reconstructed.").
word("regent", 'n.', "One who rules in place of the monarch, especially because the monarch is too young, absent, or disabled.").
word("regent", 'n.', "A member of governing board of a college or university; also a governor of the Smithsonian Institute in Washington DC.").
word("regicide", 'n.', "The killing of a king.").
word("regicide", 'n.', "One who kills a king.").
word("regime", 'n.', "A period of rule.").
word("regime", 'n.', "A division of a Mafia crime family, led by a caporegime.").
word("regimen", 'n.', "A syntactical relation between words, as when one depends on another and is regulated by it in respect to case or mood; government.").
word("regimen", 'n.', "Any regulation or remedy which is intended to produce beneficial effects by gradual operation.").
word("regiment", 'n.', "A unit of armed troops under the command of an officer, and consisting of several smaller units; now specifically, usually composed of two or more battalions.").
word("regiment", 'n.', "Rule or governance over a person, place etc.; government, authority.").
word("regnant", 'adj.', "Of a monarch, ruling in one's one right; often contrasted with and").
word("regnant", 'adj.', "Dominant; holding sway; having particular power or influence.").
word("regress", 'v.', "To interrogate a person in a state of trance about forgotten elements of their past.").
word("regress", 'v.', "To move from east to west.").
word("regretful", 'adj.', "Full of feelings of regret, indulging in regrets.").
word("regretful", 'adj.', "Sorrowful about what has been lost or done.").
word("rehabilitate", 'v.', "To restore or repair (a vehicle, building); to make habitable or usable again.").
word("rehabilitate", 'v.', "To restore (someone) to their former state, reputation, possessions, status etc.").
word("reign", 'v.', "To exercise sovereign power, to rule as a monarch.").
word("reign", 'v.', "To be a dominant quality of a place or situation; to prevail, predominate, rule.").
word("reimburse", 'v.', "To compensate with payment; especially, to repay money spent on one's behalf.").
word("rein", 'n.', "A strap or rope attached to a bridle or bit, used to control a horse, animal or young child.").
word("rein", 'n.', "The inward impulses; the affections and passions, formerly supposed to be located in the area of the kidneys.").
word("reinstate", 'v.', "To restore to a former position or rank.").
word("reinstate", 'v.', "To bring back into use or existence; resurrect.").
word("reiterate", 'v.', "To say or do (something) repeatedly.").
word("reiterate", 'v.', "To say or do (something) for a second time, such as for emphasis.").
word("rejoin", 'v.', "To join again; to unite after separation.").
word("rejoin", 'v.', "To come, or go, again into the presence of; to join the company of again.").
word("rejuvenate", 'v.', "To render young again.").
word("rejuvenate", 'v.', "To give new energy or vigour to; to revitalise.").
word("rejuvenescence", 'n.', "A renewal of youthful characteristics or vitality.").
word("rejuvenescence", 'n.', "The escape of the protoplasm of a cell and its conversion into a cell of a different character, as in certain algae.").
word("relapse", 'v.', "To recur; to worsen, be aggravated .").
word("relapse", 'v.', "To return to a vice, especially self-harm or alcoholism, failing to maintain abstinence.").
word("relegate", 'v.', "Consign or assign.").
word("relegate", 'v.', "Exile, banish, remove, or send away.").
word("relent", 'v.', "To become less rigid or hard; to soften; to yield, for example by dissolving or melting").
word("relent", 'v.', "To give in or be swayed; to become less hard, harsh, or cruel; to show clemency.").
word("relevant", 'adj.', "Not out of date; current.").
word("relevant", 'adj.', "Related, connected, or pertinent to a topic.").
word("reliance", 'n.', "The act of relying (on or in someone or something); trust.").
word("reliance", 'n.', "Anything on which to rely; ground of trust.").
word("reliant", 'adj.', "Having reliance on somebody or something.").
word("relinquish", 'v.', "To give up, abandon or retire from something. To trade away.").
word("relinquish", 'v.', "To accept to give up, withdraw etc.").
word("reliquary", 'n.', "A container to hold or display religious relics.").
word("reliquary", 'n.', "An object that sustains the memory of past people or events.").
word("relish", 'v.', "To taste or eat with pleasure, to like the flavor of").
word("relish", 'v.', "To taste; to have a specified taste or flavour.").
word("reluctance", 'n.', "Unwillingness to do something.").
word("reluctance", 'n.', "Hesitancy in taking some action.").
word("reluctant", 'adj.', "Not wanting to take some action; unwilling.").
word("reluctant", 'adj.', "Opposing; offering resistance (to).").
word("remembrance", 'n.', "The act of remembering; a holding in mind, or bringing to mind; recollection.").
word("remembrance", 'n.', "The state of being remembered, or held in mind; memory, recollection.").
word("reminiscence", 'n.', "An act of remembering long-past experiences, especially positive or pleasant ones, often fondly.").
word("reminiscence", 'n.', "A mental image thus remembered.").
word("reminiscent", 'adj.', "Tending to bring some memory etc. to mind }}").
word("reminiscent", 'adj.', "Suggestive of an earlier event or times").
word("remiss", 'adj.', "At fault; failing to fulfill responsibility, duty, or obligations.").
word("remiss", 'adj.', "Not energetic or exact in duty or business; careless; tardy; slack; hence, lacking earnestness or activity; languid; slow.").
word("remission", 'n.', "A pardon of a sin; the forgiveness of an offence, or relinquishment of a (legal) claim or a debt.").
word("remission", 'n.', "A lessening of amount due, as in either money or work, or intensity of a thing.").
word("remodel", 'v.', "To change the appearance, layout, or furnishings of.").
word("remonstrance", 'n.', "A remonstration; disapproval; a formal, usually written, objection or protest.").
word("remonstrant", 'adj.', "Inclined or tending to remonstrate; expostulatory; urging reasons in opposition to something.").
word("remonstrate", 'v.', "To state or plead as an objection, formal protest, or expression of disapproval.").
word("remonstrate", 'v.', "To object; to express disapproval ( , ).").
word("remunerate", 'v.', "To compensate; to pay.").
word("remuneration", 'n.', "A recompense for a loss; compensation.").
word("remuneration", 'n.', "A payment for work done; wages, salary, emolument.").
word("renaissance", 'n.', "A rebirth or revival.").
word("rendezvous", 'n.', "A place appointed for a meeting, or at which persons customarily meet.").
word("rendezvous", 'n.', "The appointed place for troops, or for the ships of a fleet, to assemble; also, a place for enlistment.").
word("rendition", 'n.', "An interpretation or performance of an artwork, especially a musical score or musical work.").
word("rendition", 'n.', "A given visual reproduction of something.").
word("renovate", 'v.', "To renew; to revamp something to make it look new again.").
word("renovate", 'v.', "To restore to freshness or vigor.").
word("renunciation", 'n.', "The resignation of an ecclesiastical office").
word("renunciation", 'n.', "The act of rejecting or renouncing something as invalid").
word("reorganize", 'v.', "To organize something again, or in a different manner").
word("reorganize", 'v.', "To undergo a reorganization").
word("reparable", 'adj.', "Able to be repaired.").
word("reparation", 'n.', "The act of renewing, restoring, etc., or the state of being renewed or repaired.").
word("reparation", 'n.', "A payment of time, effort or money to compensate for past transgression(s).").
word("repartee", 'n.', "A swift, witty reply, especially one that is amusing.").
word("repartee", 'n.', "Skill in replying swiftly and wittily.").
word("repeal", 'v.', "To recall; to summon (a person) again; to bring (a person) back from exile or banishment.").
word("repeal", 'v.', "To cancel, invalidate, annul.").
word("repel", 'v.', "To ward off (a malignant influence, attack etc.).").
word("repel", 'v.', "To drive back (an assailant, advancing force etc.).").
word("repellent", 'adj.', "Tending or able to repel; driving back.").
word("repellent", 'adj.', "Resistant or impervious to something.").
word("repentance", 'n.', "A feeling of regret or remorse for doing wrong or sinning.").
word("repentance", 'n.', "The condition of being penitent.").
word("repertory", 'n.', "A collection of things, or a place where such a collection is kept").
word("repertory", 'n.', "A specific set of works that a company performs").
word("repetition", 'n.', "The act or an instance of repeating or being repeated.").
word("repetition", 'n.', ": The act of performing a single, controlled exercise motion. A group of repetitions is a set.").
word("repine", 'v.', "To complain; to regret.").
word("repine", 'v.', "To fail; to wane.").
word("replenish", 'v.', "To fill up; to complete; to supply fully.").
word("replenish", 'v.', "To refill; to renew; to supply again or to add a fresh quantity to.").
word("replete", 'adj.', "Gorged, filled to near the point of bursting, especially with food or drink.").
word("replete", 'adj.', "Abounding.").
word("replica", 'n.', "A copy made at a smaller scale than the original.").
word("replica", 'n.', "An exact copy.").
word("repository", 'n.', "A location for storage, often for safety or preservation.").
word("reprehend", 'v.', "To criticize, to reprove").
word("reprehensible", 'adj.', "Blameworthy, censurable, guilty.").
word("reprehensible", 'adj.', "Deserving of reprehension.").
word("reprehension", 'n.', "The act, or an expression, of criticism, censure or condemnation; reprimand").
word("repress", 'v.', "To check; to keep back.").
word("repress", 'v.', "To press again.").
word("repressible", 'adj.', "Capable of being repressed, of being controlled, of being suppressed or limited.").
word("reprieve", 'v.', "To cancel or postpone the punishment of someone, especially an execution.").
word("reprieve", 'v.', "To abandon or postpone plans to close, withdraw or abolish (something).").
word("reprimand", 'v.', "To reprove in a formal or official way.").
word("reprisal", 'n.', "The act of taking something from an enemy by way of retaliation or indemnity.").
word("reprisal", 'n.', "An act of retaliation.").
word("reprobate", 'n.', "One rejected by God; a sinful person.").
word("reprobate", 'n.', "An individual with low morals or principles.").
word("reproduce", 'v.', "To produce an image or copy of.").
word("reproduce", 'v.', "To generate or propagate offspring or organisms sexually or asexually.").
word("reproduction", 'n.', "The act of making copies.").
word("reproduction", 'n.', "A copy of something, as in a piece of art; a duplicate.").
word("reproof", 'n.', "An act or instance of reproving or of reprobating; a rebuke, a reproach, an admonition.").
word("repudiate", 'v.', "To refuse to have anything to do with; to disown.").
word("repudiate", 'v.', "To refuse to pay or honor (a debt).").
word("repugnance", 'n.', "Extreme aversion, repulsion.").
word("repugnance", 'n.', "Contradiction, inconsistency, incompatibility, incongruity; an instance of such.").
word("repugnant", 'adj.', "Offensive or repulsive; arousing disgust or aversion.").
word("repugnant", 'adj.', "Opposed or in conflict.").
word("repulse", 'n.', "The act of repulsing or the state of being repulsed").
word("repulse", 'n.', "Refusal, rejection or repulsion").
word("repulsive", 'adj.', "Cold, reserved, forbidding").
word("repulsive", 'adj.', "Having the capacity to repel").
word("repute", 'v.', "To attribute or credit something to something; to impute.").
word("repute", 'v.', "To consider, think, esteem, reckon (a person or thing) to be, or as being, something").
word("requiem", 'n.', "A large or dangerous shark, specifically, a member of the family Carcharhinidae.").
word("requiem", 'n.', "A mass (especially Catholic) to honor and remember a dead person.").
word("requisite", 'adj.', "Essential, indispensable, required.").
word("requital", 'n.', "Compensation for loss or damage; amends.").
word("requital", 'n.', "Retaliation or reprisal; vengeance.").
word("requite", 'v.', "To return (usually something figurative) that has been given; to repay; to recompense").
word("requite", 'v.', "To retaliate.").
word("rescind", 'v.', "To repeal, annul, or declare void; to take (something such as a rule or contract) out of effect.").
word("rescind", 'v.', "To cut away or off.").
word("reseat", 'v.', "To sit down again.").
word("reseat", 'v.', "To fit (something, especially a valve) back into its place.").
word("resemblance", 'n.', "A comparison; a simile.").
word("resemblance", 'n.', "Probability; verisimilitude.").
word("resent", 'v.', "To express displeasure or indignation at.").
word("resent", 'v.', "To give forth an odor; to smell; to savor.").
word("reservoir", 'n.', "A species that acts as host to a zoonosis when it is not causing acute illness in other susceptible species.").
word("reservoir", 'n.', "A large natural or artificial lake used as a source of water supply.").
word("residue", 'n.', "Whatever property or effects are left in an estate after payment of all debts, other charges and deduction of what is specifically bequeathed by the testator.").
word("residue", 'n.', "Whatever remains after something else has been removed.").
word("resilience", 'n.', "The positive capacity of an organizational system or company to adapt and return to equilibrium due to the consequences of a crisis or failure caused by any type of disruption, including: an outage, natural disasters, man-made disasters, terrorism, or similar (particularly IT systems, archives).").
word("resilience", 'n.', "The physical property of material that can resume its shape after being stretched or deformed; elasticity.").
word("resilient", 'adj.', "Returning quickly to original shape after force is applied; elastic.").
word("resilient", 'adj.', "Returning quickly to normal after damaging events or conditions.").
word("resistance", 'n.', "A force that tends to oppose motion.").
word("resistance", 'n.', "The act of resisting, or the capacity to resist.").
word("resistant", 'adj.', "Which is not affected or overcome by a disease, drug, chemical or atmospheric agent, extreme of temperature, etc.").
word("resistant", 'adj.', "Not greatly influenced by individual members of a sample.").
word("resistive", 'adj.', "Resisting the passage of electrical current").
word("resistive", 'adj.', "Tending to resist").
word("resistless", 'adj.', "Putting up no resistance; unresisting.").
word("resistless", 'adj.', "That cannot be resisted; irresistible.").
word("resonance", 'n.', "An increase in the strength or duration of a musical tone produced by sympathetic vibration.").
word("resonance", 'n.', "The property of a compound that can be visualized as having two structures differing only in the distribution of electrons; mesomerism.").
word("resonate", 'v.', "To have an effect or impact; to influence; to engender support.").
word("resonate", 'v.', "To vibrate or sound, especially in response to another vibration.").
word("resource", 'n.', "Something that one uses to achieve an objective, e.g. raw materials or personnel.").
word("resource", 'n.', "A person's capacity to deal with difficulty.").
word("respite", 'n.', "A brief interval of rest or relief.").
word("respite", 'n.', "A reprieve, especially from a sentence of death.").
word("resplendent", 'adj.', "Shiny and colourful, and thus pleasing to the eye.").
word("resplendent", 'adj.', "Exhibiting the property of resplendency in Peano arithmetic.").
word("respondent", 'adj.', "Disposed or expected to respond; answering; according; corresponding.").
word("restitution", 'n.', "That which is offered or given in return for what has been lost, injured, or destroyed; compensation.").
word("restitution", 'n.', "The movement of rotation which usually occurs in childbirth after the head has been delivered, and which causes the latter to point towards the side to which it was directed at the beginning of labour.").
word("resumption", 'n.', "The act of resuming or starting something again.").
word("resurgent", 'adj.', "Rising again, as from the dead.").
word("resurgent", 'adj.', "Of a celestial object, moving upwards relative to the horizon after a period of having moved downwards.").
word("resurrection", 'n.', "The act of arising from the dead and becoming alive again.").
word("resurrection", 'n.', "Bodysnatching").
word("resuscitate", 'v.', "To restore consciousness, vigor, or life to.").
word("resuscitate", 'v.', "To regain consciousness.").
word("retaliate", 'v.', "To repay or requite by an act of the same kind.").
word("retaliate", 'v.', "To do something harmful or negative to get revenge for some harm; to fight back or respond in kind to an injury or affront.").
word("retch", 'v.', "To make an unsuccessful effort to vomit; to strain, as in vomiting.").
word("retch", 'v.', "To reck").
word("retention", 'n.', "The act or power of remembering things").
word("retention", 'n.', "The act of retaining or something retained").
word("reticence", 'n.', "Followed by ' ': discretion or restraint in the use of something.").
word("reticence", 'n.', "Avoidance of saying or reluctance to say too much; discretion, tight-lippedness; an instance of acting in this manner.").
word("reticent", 'adj.', "Keeping one's thoughts and opinions to oneself; reserved or restrained.").
word("reticent", 'adj.', "Hesitant or not wanting to take some action; reluctant (usually followed by a verb in the infinitive).").
word("retinue", 'n.', "A group of servants or attendants, especially of someone considered important.").
word("retinue", 'n.', "A group of warriors or nobles accompanying a king or other leader; comitatus.").
word("retort", 'n.', "A airtight vessel in which material is subjected to high temperatures in the chemical industry or as part of an industrial manufacturing process, especially during the smelting and forging of metal.").
word("retort", 'n.', "A sharp or witty reply, or one which turns an argument against its originator; a comeback.").
word("retouch", 'v.', "To modify a flint tool by making secondary flaking along the cutting edge.").
word("retouch", 'v.', "To colour the roots of hair to match hair previously coloured.").
word("retrace", 'v.', "To go back over something, usually in an attempt of rediscovery.").
word("retrace", 'v.', "To trace (a line, etc. in drawing) again.").
word("retract", 'v.', "To draw back; to draw up; to withdraw.").
word("retrench", 'v.', "To cut down or reduce.").
word("retrench", 'v.', "To dig or redig a trench where one already exists.").
word("retrieve", 'v.', "To regain or get back something.").
word("retrieve", 'v.', "To fetch or carry back something.").
word("retroactive", 'adj.', "Extending in scope, effect, application or influence to a prior time or to prior conditions").
word("retrogression", 'n.', "A deterioration or decline to a previous state.").
word("retrogression", 'n.', "A return to a less complex condition.").
word("retrospect", 'n.', "Consideration of past times.").
word("retrospective", 'adj.', "Of, relating to, or contemplating the past.").
word("retrospective", 'adj.', "Affecting or influencing past things; retroactive.").
word("reunite", 'v.', "To unite again.").
word("revelation", 'n.', "The act of revealing or disclosing.").
word("revelation", 'n.', "A manifestation of divine truth.").
word("revere", 'v.', "To regard someone or something with great awe or devotion.").
word("revere", 'v.', "To honour in a form lesser than worship, e.g. a saint, or an idol").
word("reverent", 'adj.', "Showing or characterized by great respect or reverence; respectful.").
word("reversion", 'n.', "The action of returning to a former condition or practice.").
word("reversion", 'n.', "The right of succeeding to an office after the death or retirement of the holder.").
word("revert", 'v.', "To return to an earlier or primitive type or state; to take on the traits or characters of an ancestral type.").
word("revert", 'v.', "To take up again or return to a previous topic.").
word("revile", 'v.', "To attack (someone) with abusive language.").
word("revisal", 'n.', "The act of revising; a revision.").
word("revise", 'v.', "To look over again (something previously written or learned), especially in preparation for an examination.").
word("revise", 'v.', "To look at again, to reflect on.").
word("revocation", 'n.', "An act or instance of revoking.").
word("revoke", 'v.', "To fail to follow suit in a game of cards when holding a card in that suit.").
word("revoke", 'v.', "To call back to mind.").
word("rhapsody", 'n.', "A random collection or medley; a miscellany or confused string of stories, words etc.").
word("rhapsody", 'n.', "An exalted or exaggeratedly enthusiastic expression of feeling in speech or writing.").
word("rhetoric", 'n.', "The art of using language, especially public speaking, as a means to persuade.").
word("rhetoric", 'n.', "Meaningless language with an exaggerated style intended to impress.").
word("rhetorician", 'n.', "An orator or eloquent public speaker.").
word("rhetorician", 'n.', "An expert or student of rhetoric.").
word("ribald", 'adj.', "Coarsely, vulgarly, or lewdly amusing; referring to sexual matters in a rude or irreverent way.").
word("riddance", 'n.', "The act of being rid of something; deliverance").
word("riddance", 'n.', "The earth thrown up by a burrowing animal.").
word("ridicule", 'n.', "An object of sport or laughter; a laughing stock.").
word("ridicule", 'n.', "Derision; mocking or humiliating words or behaviour").
word("ridiculous", 'adj.', "Astonishing; unbelievable.").
word("ridiculous", 'adj.', "Deserving of ridicule; foolish; absurd.").
word("rife", 'adj.', "Abounding; present in large numbers, plentiful.").
word("rife", 'adj.', "Full of (mostly unpleasant or harmful things).").
word("righteousness", 'n.', "The state of being right with God; justification; the work of Christ, which is the ground justification.").
word("righteousness", 'n.', "Holiness; conformity of life to the divine law.").
word("rightful", 'adj.', "By right; by law.").
word("rigmarole", 'n.', "Nonsense; confused and incoherent talk.").
word("rigmarole", 'n.', "A long and complicated procedure that seems tiresome or pointless.").
word("rigorous", 'adj.', "Severe; intense.").
word("rigorous", 'adj.', "Showing, causing, or favoring rigour/rigor; scrupulously accurate or strict; thorough.").
word("ripplet", 'n.', "A small ripple.").
word("risible", 'adj.', "Of or pertaining to laughter").
word("risible", 'adj.', "Easily laughing; prone to laughter").
word("rivulet", 'n.', "A small brook or stream; a streamlet; a gill.").
word("rivulet", 'n.', ", a geometrid moth.").
word("robust", 'adj.', "Not greatly influenced by errors in assumptions about the distribution of sample errors.").
word("robust", 'adj.', "Requiring strength or vigor").
word("rondo", 'n.', "A musical composition, commonly of a lively, cheerful character, in which the first strain recurs after each of the other strains.").
word("rondo", 'n.', "A game resembling keep-away, used to train soccer players: one group is tasked with completing a number of passes while the other smaller group tries to take possession of the ball.").
word("rookery", 'n.', "A place where criminals congregate, often an area of a town or city.").
word("rookery", 'n.', "A colony of breeding birds or other animals.").
word("rotary", 'adj.', "Capable of rotation.").
word("rotate", 'v.', "To advance something through a sequence; to allocate or deploy in turns.").
word("rotate", 'v.', "To lift the nose during takeoff, just prior to liftoff.").
word("rote", 'n.', "A kind of guitar, the notes of which were produced by a small wheel or wheel-like arrangement; an instrument similar to the hurdy-gurdy.").
word("rotund", 'adj.', "Having a round, spherical or curved shape; circular; orbicular.").
word("rotund", 'adj.', "Having a round body shape; portly or plump; podgy.").
word("rudimentary", 'adj.', "Basic; minimal; with less than, or only the minimum, necessary.").
word("rudimentary", 'adj.', "Of or relating to one or more rudiments.").
word("rue", 'v.', "To cause to repent of sin or regret some past action.").
word("rue", 'v.', "To feel sorrow or regret.").
word("ruffian", 'adj.', "Brutal; cruel; savagely boisterous; murderous.").
word("ruminant", 'adj.', "Chewing cud.").
word("ruminant", 'adj.', "Pondering; ruminative.").
word("ruminate", 'v.', "To meditate or ponder over; to muse on.").
word("ruminate", 'v.', "To chew cud. (Said of ruminants.) Involves regurgitating partially digested food from the rumen.").
word("rupture", 'v.', "To burst, break through, or split, as under pressure.").
word("rupture", 'v.', "To dehisce irregularly.").
word("rustic", 'adj.', "Country-styled or pastoral; rural.").
word("rustic", 'adj.', "Unfinished or roughly finished.}}").
word("ruth", 'n.', "Sorrow for the misery of another; pity, compassion; mercy.").
word("ruth", 'n.', "Sorrow; misery; distress. [https://books.google.com.au/books?id=O3sSAAAAIAAJ&pg=PR1&lpg=PR1&dq=dictionary+of+the+edinburgh+james+leslie&source=bl&ots=f5U9DzPqBm&sig=c1II0xlM5z7BRdhI5cbnyXdhhCA&hl=en&sa=X&ved=0ahUKEwjpivny7ZDOAhVBs5QKHdaoCnoQ6AEILzAE#v=onepage&q=dictionary%20of%20the%20edinburgh%20james%20leslie&f Dictionary of the Edinburgh]").
word("sacrifice", 'v.', "To offer (something) as a gift to a deity.").
word("sacrifice", 'v.', "To advance (a runner on base) by batting the ball so it can be fielded, placing the batter out, but with insufficient time to put the runner out.").
word("sacrificial", 'adj.', "Used as a sacrifice.").
word("sacrificial", 'adj.', "Relating to sacrifice").
word("sacrilege", 'n.', "Desecration, profanation, misuse or violation of something regarded as sacred.").
word("sacrilegious", 'adj.', "Committing sacrilege; acting or speaking very disrespectfully toward what is held to be sacred.").
word("safeguard", 'v.', "To protect, to keep safe.").
word("safeguard", 'v.', "To escort safely.").
word("sagacious", 'adj.', "Having or showing keen discernment, sound judgment, and farsightedness; mentally shrewd.").
word("salacious", 'adj.', "Promoting sexual desire or lust.").
word("salacious", 'adj.', "Lascivious, bawdy, obscene, lewd.").
word("salience", 'n.', "A highlight; perceptual prominence, or likelihood of being noticed.").
word("salience", 'n.', "Relative importance based on context.").
word("salient", 'adj.', "Prominent; conspicuous.").
word("salient", 'adj.', "Shooting or springing out; projecting.").
word("saline", 'adj.', "Resembling salt.").
word("saline", 'adj.', "Containing salt; salty.").
word("salutary", 'adj.', "Promoting good health and physical well-being; wholesome; curative.").
word("salutary", 'adj.', "Effecting or designed to effect an improvement; remedial: salutary advice.").
word("salutation", 'n.', "The act of greeting.").
word("salutation", 'n.', "Quickening; excitement.").
word("salutatory", 'n.', "A greeting; an address, speech or article of greeting; the first editorial by the new editor of a newspaper or periodical; an introduction or preface.").
word("salutatory", 'n.', "A place for saluting or greeting.").
word("salvage", 'n.', "Anything put to good use that would otherwise have been wasted, such as damaged goods.").
word("salvage", 'n.', "The similar rescue of property liable to loss; the property so rescued.").
word("salvo", 'n.', "A concentrated fire from pieces of artillery, as in endeavoring to make a break in a fortification; a volley.").
word("salvo", 'n.', "Any volley, as in an argument or debate.").
word("sanctimonious", 'adj.', "Making a show of being morally better than others, especially hypocritically pious.").
word("sanctimonious", 'adj.', "Holy, devout.").
word("sanction", 'v.', "To give official authorization or approval to; to countenance.").
word("sanction", 'v.', "To ratify; to make valid.").
word("sanctity", 'n.', "Holiness of life or disposition; saintliness").
word("sanctity", 'n.', "Something considered sacred.").
word("sanguinary", 'adj.', "Eager to shed blood; bloodthirsty.").
word("sanguinary", 'adj.', "Involving bloodshed.").
word("sanguine", 'adj.', "Having the colour of blood; blood red.").
word("sanguine", 'adj.', "Having a bodily constitution characterised by a preponderance of blood over the other bodily humours, thought to be marked by irresponsible mirth; indulgent in pleasure to the exclusion of important matters.").
word("sanguineous", 'adj.', "Resembling or constituting blood.").
word("sanguineous", 'adj.', "Accompanied by bloodshed; bloody.").
word("sapid", 'adj.', "Tasty, flavoursome or savoury").
word("sapience", 'n.', "The property of being sapient, the property of possessing or being able to possess wisdom.").
word("sapient", 'adj.', "Possessing wisdom and discernment; wise, learned.").
word("sapient", 'adj.', "Attempting to appear wise or discerning.").
word("sapiential", 'adj.', "Containing or conferring wisdom (especially religious wisdom)").
word("saponaceous", 'adj.', "Resembling soap; having the qualities of soap; soapy.").
word("saponaceous", 'adj.', "Slippery; evasive.").
word("sarcasm", 'n.', "Use of acerbic language to mock or convey contempt, often using irony and (in speech) often marked by overemphasis and a sneering tone of voice.").
word("sarcasm", 'n.', "An act of sarcasm.").
word("sarcophagus", 'n.', "A stone coffin, often inscribed or decorated with sculpture.").
word("sarcophagus", 'n.', "A kind of limestone used by the Greeks for coffins, so called because it was thought to consume the flesh of corpses.").
word("sardonic", 'adj.', "Scornfully mocking or cynical.").
word("sardonic", 'adj.', "Disdainfully or ironically humorous.").
word("satiate", 'v.', "To fill to satisfaction; to satisfy.").
word("satiate", 'v.', "To satisfy to excess. To fill to satiety.").
word("satire", 'n.', "A literary device of writing or art which principally ridicules its subject often as an intended means of provoking or preventing change. Humor, irony, and exaggeration are often used to aid this.").
word("satire", 'n.', "Severity of remark.").
word("satiric", 'adj.', "Of or pertaining to satire").
word("satirize", 'v.', "To make a satire of; to mock.").
word("satyr", 'n.', "A sylvan deity or demigod, male companion of Pan or Dionysus, represented as part man and part goat, and characterized by riotous merriment and lasciviousness, sometimes pictured with a perpetual erection.").
word("savage", 'n.', "A person living in a traditional, especially tribal, rather than civilized society, especially when viewed as uncivilized and uncultivated; a barbarian.").
word("savage", 'n.', "A defiant person.").
word("scabbard", 'n.', "The sheath of a sword.").
word("scarcity", 'n.', "An inadequate amount of something; a shortage").
word("scarcity", 'n.', "The condition of something being scarce or deficient").
word("scholarly", 'adj.', "Characteristic of a scholar.").
word("scholarly", 'adj.', "Of or relating to scholastics or scholarship.").
word("scholastic", 'adj.', "Of or relating to school; academic").
word("scholastic", 'adj.', "Characterized by excessive subtlety, or needlessly minute subdivisions; pedantic; formal.").
word("scintilla", 'n.', "A small spark or flash.").
word("scintilla", 'n.', "A small or trace amount.").
word("scintillate", 'v.', "Especially of a phosphor: to emit a flash of light upon absorbing ionizing radiation.").
word("scintillate", 'v.', "To give off sparks; to shine as if emanating sparks; to twinkle or glow.").
word("scope", 'n.', "Opportunity; broad range; degree of freedom.").
word("scope", 'n.', "The region of an utterance to which some modifying element applies.").
word("scoundrel", 'n.', "A mean, worthless fellow; a rascal; a villain; a person without honour or virtue.").
word("scribble", 'n.', "Careless, hasty writing, doodle or drawing").
word("scribe", 'n.', "A writer and doctor of the law; one skilled in the law and traditions; one who read and explained the law to the people.").
word("scribe", 'n.', "Someone who writes; a draughtsperson; a writer for another; especially, an official or public writer; an amanuensis, secretary, notary or copyist.").
word("script", 'n.', "The written document containing the dialogue and action for a drama; the text of a stage play, movie, or other performance. Especially, the final form used for the performance itself.").
word("script", 'n.', "Written characters; style of writing.").
word("scriptural", 'adj.', "Of or pertaining to scripture.").
word("scruple", 'n.', "Hesitation to act from the difficulty of determining what is right or expedient; doubt, hesitation or unwillingness due to motives of conscience.").
word("scruple", 'n.', "A doubt or uncertainty concerning a matter of fact; intellectual perplexity.").
word("scrupulous", 'adj.', "Precise; exact or strict").
word("scrupulous", 'adj.', "Exactly and carefully conducted.").
word("scurrilous", 'adj.', "Gross, vulgar and evil.").
word("scurrilous", 'adj.', "Given to vulgar verbal abuse; foul-mouthed.").
word("scuttle", 'v.', "To cut a hole or holes through the bottom, deck, or sides of (as of a ship), for any purpose.").
word("scuttle", 'v.', "To deliberately sink one's ship or boat by any means, usually by order of the vessel's commander or owner.").
word("scythe", 'n.', "An instrument for mowing grass, grain, etc. by hand, composed of a long, curving blade with a sharp concave edge, fastened to a long handle called a snath.").
word("scythe", 'n.', "The tenth Lenormand card.").
word("sear", 'v.', "To char, scorch, or burn the surface of (something) with a hot instrument.").
word("sear", 'v.', "To mark permanently, as if by burning.").
word("sebaceous", 'adj.', "Of or relating to fat, sebum").
word("sebaceous", 'adj.', "Oozing fat").
word("secant", 'adj.', "That cuts or divides.").
word("secede", 'v.', "To split from or to withdraw from membership of a political union, an alliance or an organisation.").
word("secede", 'v.', "To split or to withdraw one or more constituent entities from membership of a political union, an alliance or an organisation.").
word("secession", 'n.', "The act of seceding.").
word("seclude", 'v.', "To shut off or keep apart, as from company, society, etc.; withdraw (oneself) from society or into solitude.").
word("seclude", 'v.', "To shut or keep out; exclude; preclude.").
word("seclusion", 'n.', "The mature phase of the extratropical cyclone life cycle.").
word("seclusion", 'n.', "The state of being secluded or shut out, as from company, society, the world, etc.; solitude.").
word("secondary", 'adj.', "Of less than primary importance.").
word("secondary", 'adj.', "Produced by alteration or deposition subsequent to the formation of the original rock mass.").
word("secondly", 'adv.', "In the second place.").
word("secrecy", 'n.', "Concealment; the condition of being secret or hidden.").
word("secrecy", 'n.', "The habit of keeping secrets.").
word("secretary", 'n.', "A person who keeps records, takes notes and handles general clerical work.").
word("secretary", 'n.', "Someone employed as a scribe for personal correspondence.").
word("secretive", 'adj.', "Having an inclination to secrecy").
word("secretive", 'adj.', "Relating to secretion").
word("sedate", 'adj.', "Remaining composed and dignified, and avoiding too much activity or excitement.").
word("sedate", 'adj.', "Not overly ornate or showy.").
word("sedentary", 'adj.', "Not moving much; sitting around.").
word("sedentary", 'adj.', "Caused by long sitting.").
word("sediment", 'n.', "A collection of small particles, particularly dirt, that precipitates from a river or other body of water.").
word("sedition", 'n.', "Organized incitement of rebellion or civil disorder against authority or the state, usually by speech or writing.").
word("sedition", 'n.', "Insurrection or rebellion.").
word("seditious", 'adj.', "Of, related to, or being involved in sedition.").
word("seduce", 'v.', "To entice or induce (someone) to engage in a sexual relationship.").
word("seduce", 'v.', "To have sexual intercourse with.").
word("sedulous", 'adj.', "Of a person: diligent in application or pursuit; constant and persevering in business or in endeavours to effect a goal; steadily industrious.").
word("sedulous", 'adj.', "Of an activity: carried out with diligence.").
word("seer", 'n.', "One who foretells the future; a clairvoyant, prophet, soothsayer or diviner.").
word("seethe", 'v.', "To be in an agitated or angry mental state, as if boiling.").
word("seethe", 'v.', "To foam in an agitated manner, as if boiling.").
word("seignior", 'n.', "A feudal lord; a nobleman who held his lands by feudal grant; any lord (holder) of a manor").
word("seismograph", 'n.', "An instrument that automatically detects and records the intensity, direction and duration of earthquakes and similar events.").
word("seize", 'v.', "To take possession of (by force, law etc.).").
word("seize", 'v.', "To deliberately take hold of; to grab or capture.").
word("selective", 'adj.', "Having the authority or capability to make a selection.").
word("selective", 'adj.', "Of or relating to the social work approach called selectivity.").
word("semblance", 'n.', "The way something looks; appearance; form").
word("semblance", 'n.', "Likeness, similarity; the quality of being similar.").
word("semiannual", 'adj.', "Biannual: occurring twice a year").
word("semicircle", 'n.', "Half of a circle. Category:en:Curves").
word("semicircle", 'n.', "An instrument for measuring angles.").
word("semicivilized", 'adj.', "Somewhat or partially civilized.").
word("semiconscious", 'adj.', "Neither fully conscious nor unconscious, partially aware but confused or distracted.").
word("seminar", 'n.', "A class held for advanced studies in which students meet regularly to discuss original research, under the guidance of a professor.").
word("seminar", 'n.', "A meeting held for the exchange of useful information by members of a common business community.").
word("seminary", 'n.', "A theological school for the training of rabbis, priests, or ministers.").
word("seminary", 'n.', "A class of religious education for youths ages 14–18 that accompanies normal secular education.").
word("senile", 'adj.', "Exhibiting the deterioration in mind and body often accompanying old age; doddering.").
word("senile", 'adj.', "Of, or relating to old age.").
word("sensation", 'n.', "A physical feeling or perception from something that comes into contact with the body; something sensed.").
word("sensation", 'n.', "A small serving of gin or sherry.").
word("sense", 'n.', "A single conventional use of a word; one of the entries for a word in a dictionary.").
word("sense", 'n.', "Any of the manners by which living beings perceive the physical world: for humans sight, smell, hearing, touch, taste.").
word("sensibility", 'n.', "The ability to sense, feel or perceive; responsiveness to sensory stimuli; sensitivity.").
word("sensibility", 'n.', "Emotional or artistic awareness; keen sensitivity to matters of feeling or creative expression.").
word("sensitive", 'adj.', "Meant to be concealed or kept secret.").
word("sensitive", 'adj.', "Easily offended, upset or hurt.").
word("sensorium", 'n.', "The brain or mind in relation to the senses.").
word("sensorium", 'n.', "The central part of a nervous system that receives and coordinates all stimuli.").
word("sensual", 'adj.', "Of or pertaining to the physical senses; sensory.").
word("sensual", 'adj.', "Provoking or exciting a strong response in the senses.").
word("sensuous", 'adj.', "Appealing to the senses, or to sensual gratification.").
word("sensuous", 'adj.', "Of or relating to the senses; sensory.").
word("sentence", 'n.', "A grammatically complete series of words consisting of a subject and predicate, even if one or the other is implied, and typically beginning with a capital letter and ending with a full stop.").
word("sentence", 'n.', "Any of the set of strings that can be generated by a given formal grammar.").
word("sentience", 'n.', "The state or quality of being sentient; possession of consciousness or sensory awareness.").
word("sentient", 'adj.', "Able to consciously perceive through the use of sense faculties.").
word("sentient", 'adj.', "Experiencing sensation, thought, or feeling.").
word("sentinel", 'n.', "A unique string of characters recognised by a computer program for processing in a special way; a keyword.").
word("sentinel", 'n.', "A sign of a health risk (e.g. a disease, an adverse effect).").
word("separable", 'adj.', "Having a countable dense subset.").
word("separable", 'adj.', "Able to be separated.").
word("separate", 'v.', "To set apart; to select from among others, as for a special use or service.").
word("separate", 'v.', "To disunite from a group or mass; to disconnect.").
word("separatist", 'n.', "A person who advocates or seeks the splitting of one country or territory into two politically independent countries or territories.").
word("separatist", 'n.', "Someone who advocates separation from the established Church; a member of any of various sects or schismatics.").
word("septennial", 'adj.', "Happening or returning once in every seven years.").
word("septennial", 'adj.', "Lasting or continuing seven years.").
word("sepulcher", 'n.', "A burial chamber.").
word("sequacious", 'adj.', "Likely to follow, conform, or yield to others, especially showing unthinking adherence to others' ideas; easily led.").
word("sequacious", 'adj.', "Likely to follow or yield to physical pressure; easily shaped or molded.").
word("sequel", 'n.', "The events, collectively, which follow a previously mentioned event; the aftermath.").
word("sequel", 'n.', "A narrative that is written after another narrative set in the same universe, especially a narrative that is chronologically set after its predecessors, or (perhaps improper usage) any narrative that has a preceding narrative of its own.").
word("sequence", 'n.', "A series of musical phrases where a theme or melody is repeated, with some change each time, such as in pitch or length (example: opening of Beethoven's Fifth Symphony).").
word("sequence", 'n.', "A set of things next to each other in a set order; a series").
word("sequent", 'adj.', "That comes after in time or order; subsequent.").
word("sequent", 'adj.', "That follows on as a result, conclusion etc.; consequent , , .").
word("sequester", 'v.', "To temporarily remove (property) from the possession of its owner and hold it as security against legal claims.").
word("sequester", 'v.', "To set apart; to put aside; to remove; to separate from other things.").
word("sequestrate", 'v.', "To sequester.").
word("sergeant", 'n.', "UK army rank with NATO code OR-6, senior to corporal and junior to warrant officer ranks.").
word("sergeant", 'n.', "The highest rank of noncommissioned officer in some non-naval military forces and police.").
word("service", 'n.', "A function that is provided by one program or machine for another.").
word("service", 'n.', "A taxi shared among unrelated passengers, each of whom pays part of the fare; often, it has a fixed route between cities.").
word("serviceable", 'adj.', "Repairable instead of disposable.").
word("serviceable", 'adj.', "In condition for use.").
word("servitude", 'n.', "The state of being a slave; slavery; being forced to work for others or do their bidding without one's consent or against one's will, either in perpetuity or for a period of time over which one has little or no control.").
word("servitude", 'n.', "A qualified beneficial interest severed or fragmented from the ownership of an inferior property and attached to a superior property or to some person other than the owner; the most common form is an easement.").
word("severance", 'n.', "A separation.").
word("severance", 'n.', "The act of severing or the state of being severed.").
word("severely", 'adv.', "In a severe manner.").
word("sextet", 'n.', "A group of six singers or instrumentalists.").
word("sextet", 'n.', "Any group of six people or things.").
word("sextuple", 'adj.', "Being six times as great.").
word("sextuple", 'adj.', "Having six beats to the bar.").
word("sheer", 'adj.', "Very steep; almost vertical or perpendicular.").
word("sheer", 'adj.', "Downright; complete; pure.").
word("shiftless", 'adj.', "Untrustworthy as a result of being incompetent at the job.").
word("shiftless", 'adj.', "Lazy, unmotivated.").
word("shrewd", 'adj.', "Bad, evil, threatening.").
word("shrewd", 'adj.', "Portending, boding.").
word("shriek", 'n.', "A sharp, shrill outcry or scream; a shrill wild cry such as is caused by sudden or extreme terror, pain, or the like.").
word("shriek", 'n.', "An exclamation mark.").
word("shrinkage", 'n.', "The loss of merchandise through theft, spoilage, and obsolescence.").
word("shrinkage", 'n.', "The reduction in size of the male genitalia when cold, such as from immersion in cold water.").
word("shrivel", 'v.', "To draw into wrinkles.").
word("shrivel", 'v.', "To become wrinkled.").
word("shuffle", 'n.', "The act of reordering anything, such as music tracks in a media player.").
word("shuffle", 'n.', "An instance of walking without lifting one's feet.").
word("sibilance", 'n.', "The quality of being sibilant: a hissing quality.").
word("sibilant", 'adj.', "Characterized by a hissing sound such as the \"s\" or \"sh\" in sash or surge.").
word("sibilate", 'v.', "To speak with a hissing sound.").
word("sibilate", 'v.', "To hiss.").
word("sidelong", 'adj.', "Along the side of something.").
word("sidelong", 'adj.', "Slanting or sloping; oblique.").
word("sidereal", 'adj.', "Of or relating to the stars.").
word("sidereal", 'adj.', "Relating to a measurement of time relative to the position of the stars.").
word("siege", 'n.', "A place with a toilet seat: an outhouse; a lavatory.").
word("siege", 'n.', "Military action.").
word("significance", 'n.', "The extent to which something matters; importance").
word("significance", 'n.', "Meaning.").
word("significant", 'adj.', "Reasonably large in number or amount.").
word("significant", 'adj.', "Having a low probability of occurring by chance (for example, having high correlation and thus likely to be related).").
word("signification", 'n.', "A meaning of a word.").
word("signification", 'n.', "Evidence for the existence of something.").
word("similar", 'adj.', "Of geometrical figures including triangles, squares, ellipses, arcs and more complex figures, having the same shape but possibly different size, rotational orientation, and position; in particular, having corresponding angles equal and corresponding line segments proportional; such that one can be had from the other using a sequence of rotations, translations and scalings.").
word("similar", 'adj.', "Of two square matrices; being such that a conjugation sends one matrix to the other.").
word("simile", 'n.', "A figure of speech in which one thing is explicitly compared to another, using e.g. like or as.").
word("similitude", 'n.', "A parable or allegory.").
word("similitude", 'n.', "Someone or something that closely resembles another; a duplicate or twin.").
word("simplify", 'v.', "To make simpler, either by reducing in complexity, reducing to component parts, or making easier to understand.").
word("simplify", 'v.', "To become simpler.").
word("simulate", 'v.', "To model, replicate, duplicate the behavior, appearance or properties of.").
word("simultaneous", 'adj.', "Happening at the same moment.").
word("simultaneous", 'adj.', "To be solved for the same values of variables.").
word("sinecure", 'n.', "A position that requires no work but still gives an ample payment; a cushy job.").
word("sinecure", 'n.', "An ecclesiastical benefice without the care of souls.").
word("singe", 'v.', "To burn slightly.").
word("singe", 'v.', "To remove the nap of (cloth), by passing it rapidly over a red-hot bar, or over a flame, preliminary to dyeing it.").
word("sinister", 'adj.', "Evil or seemingly evil; indicating lurking danger or harm.").
word("sinister", 'adj.', "Of the left side.").
word("sinuosity", 'n.', "The property of being sinuous.").
word("sinuous", 'adj.', "Having curves in alternate directions; meandering.").
word("sinuous", 'adj.', "Moving gracefully and in a supple manner.").
word("sinus", 'n.', "An irregular venous or lymphatic cavity, reservoir, or dilated vessel.").
word("sinus", 'n.', "An abnormal cavity or passage such as a fistula, leading from a deep-seated infection and discharging pus to the surface.").
word("siren", 'n.', "Any of various nymphalid butterflies of the genus .").
word("siren", 'n.', "An instrument for demonstrating the laws of beats and combination tones.").
word("sirocco", 'n.', "A hot and often strong southerly to southeasterly wind on the Mediterranean that originates in the Sahara and adjacent North African regions.").
word("sirocco", 'n.', "A draft of hot air from an artificial source of heat.").
word("sisterhood", 'n.', "The quality of being sisterly; sisterly companionship; especially, the sense that women have of being in solidarity with one another.").
word("sisterhood", 'n.', "The idea of universal experience amongst women, regardless of other traits or factors. (Considered obsolete in third-wave feminism.)").
word("skeptic", 'n.', "Someone who doubts beliefs, claims, plans, etc that are accepted by others as true or appropriate, especially one who habitually does so.").
word("skeptic", 'n.', "Someone who is skeptical towards religion.").
word("skepticism", 'n.', "A methodology that starts from a neutral standpoint and aims to acquire certainty though scientific or logical observation.").
word("skepticism", 'n.', "A studied attitude of questioning and doubt").
word("skiff", 'n.', "A small flat-bottomed open boat with a pointed bow and square stern.").
word("skiff", 'n.', "Any of various types of boats small enough for sailing or rowing by one person.").
word("skirmish", 'n.', "A brief battle between small groups, usually part of a longer or larger battle or war.").
word("skirmish", 'n.', "A type of outdoor military style game using paintball or similar weapons.").
word("sleight", 'n.', "An artful trick; sly artifice; a feat so dexterous that the manner of performance escapes observation.").
word("sleight", 'n.', "Dexterous practice; dexterity; skill.").
word("slight", 'adj.', "Still; with little or no movement on the surface").
word("slight", 'adj.', "Of slender build").
word("slothful", 'adj.', "Lazy; idle; tending to sloth.").
word("sluggard", 'n.', "A person who is lazy, stupid, or idle by habit.").
word("sluggard", 'n.', "A fearful or cowardly person, a poltroon.").
word("sociable", 'adj.', "Capable of being, or fit to be, united in one body or company; associable.").
word("sociable", 'adj.', "Offering opportunities for conversation; characterized by much conversation.").
word("socialism", 'n.', "Any of various economic and political theories advocating collective or governmental ownership and administration of the means of production and distribution of goods.").
word("socialism", 'n.', "The intermediate phase of social development between capitalism and communism in Marxist theory in which the state has control of the means of production.").
word("socialist", 'adj.', "Of, relating to, supporting, or advocating socialism.").
word("sociology", 'n.', "The study of society, human social interaction and the rules and processes that bind and separate people not only as individuals, but as members of associations, groups and institutions").
word("sol", 'n.', "A former Spanish-American silver coin.").
word("sol", 'n.', "An old coin from France and some other countries worth 12 deniers.").
word("solace", 'n.', "Comfort or consolation in a time of loneliness or distress.").
word("solace", 'n.', "A source of comfort or consolation.").
word("solar", 'adj.', "Of or pertaining to the sun; proceeding from the sun").
word("solar", 'adj.', "Produced by the action of the sun, or peculiarly affected by its influence.").
word("solder", 'n.', "Any of various easily-melted alloys, commonly of tin and lead, that are used to mend, coat, or join metal objects, usually small.").
word("solder", 'n.', "Figuratively, circumstances or emotions that strongly bond things or persons together in analogy to solder that joins metals.").
word("soldier", 'n.', "A private in military service, as distinguished from an officer.").
word("soldier", 'n.', "A low-ranking member of the mafia who engages in physical conflict.").
word("solecism", 'n.', "An erroneous or improper usage.").
word("solecism", 'n.', "A faux pas or breach of etiquette; a transgression against the norms of expected behavior.").
word("solicitor", 'n.', "In English Canada and in parts of Australia, a type of lawyer who historically held the same role as above, but whose role has in modern times been merged with that of a barrister.").
word("solicitor", 'n.', "In parts of the U.S., the chief legal officer of a city, town or other jurisdiction.").
word("solicitude", 'n.', "The state of being solicitous; uneasiness of mind occasioned by fear of evil or desire for good; anxiety.").
word("solicitude", 'n.', "A cause of anxiety or concern.").
word("soliloquy", 'n.', "A speech or written discourse in this form.").
word("soliloquy", 'n.', "The act of a character speaking to themselves so as to reveal their thoughts to the audience.").
word("solstice", 'n.', "One of the two points in the ecliptic at which the sun is furthest from the celestial equator. This corresponds to one of two days in the year when the day is either longest or shortest.").
word("soluble", 'adj.', "Able to be solved or explained.").
word("soluble", 'adj.', "Able to be dissolved.").
word("solvent", 'adj.', "Able to pay all debts as they become due, and having no more liabilities than assets.").
word("solvent", 'adj.', "Having the power of dissolving; causing solution.").
word("somniferous", 'adj.', "Causing or inducing sleep, normally with harmful overtones.").
word("somnolence", 'n.', "A state of drowsiness or sleepiness.").
word("somnolent", 'adj.', "Drowsy or sleepy.").
word("somnolent", 'adj.', "Causing literal or figurative sleepiness.").
word("sonata", 'n.', "A musical composition for one or a few instruments, one of which is frequently a piano, in three or four movements that vary in key and tempo.").
word("sonnet", 'n.', "A fixed verse form of Italian origin consisting of fourteen lines that are typically five-foot iambics and rhyme according to one of a few prescribed schemes.").
word("sonorous", 'adj.', "Capable of giving out a deep, resonant sound.").
word("sonorous", 'adj.', "Full of sound and rich, as in language or verse.").
word("soothsayer", 'n.', "One who tells the truth; a truthful person.").
word("soothsayer", 'n.', "One who predicts the future, using magic, intuition or intelligence; a diviner.").
word("sophism", 'n.', "A flawed argument, superficially correct in its reasoning, usually designed to deceive.").
word("sophism", 'n.', "A method of teaching using the techniques of philosophy and rhetoric.").
word("sophistical", 'adj.', "Fallacious, misleading or incorrect in logic or reasoning, especially intentionally.").
word("sophistical", 'adj.', "Pertaining to a sophist or sophistry.").
word("sophisticate", 'v.', "To make less natural or innocent.").
word("sophisticate", 'v.', "To make more complex or refined.").
word("sophistry", 'n.', "An argument that seems plausible, but is fallacious or misleading, especially one devised deliberately to be so.").
word("sophistry", 'n.', "The art of using deceptive speech or writing.").
word("soprano", 'n.', "Musical part or section higher in pitch than alto and other sections.").
word("soprano", 'n.', "Person or instrument that performs the soprano part.").
word("sorcery", 'n.', "Magical power; the use of witchcraft or magic arts.").
word("sordid", 'adj.', "Dirty or squalid.").
word("sordid", 'adj.', "Of a dull colour.").
word("souvenir", 'n.', "An item of sentimental value, to remember an event or location.").
word("sparse", 'adj.', "Having few nonzero elements").
word("sparse", 'adj.', "Not dense; meager; scanty").
word("spartan", 'adj.', "Lacking in decoration and luxury.").
word("spartan", 'adj.', "Austere, frugal, characterized by self-denial.").
word("spasmodic", 'adj.', "Of or relating to a spasm; resembling a sudden contraction of the muscles.").
word("spasmodic", 'adj.', "Erratic or unsustained.").
word("specialize", 'v.', "To make distinct or separate from what is what is common, particularly:").
word("specialize", 'v.', "To become distinct or separate from what is common, particularly:").
word("specialty", 'n.', "A particular or peculiar case.").
word("specialty", 'n.', "Particularity.").
word("specie", 'n.', "Money, especially in the form of coins made from precious metal, that has an intrinsic value; coinage.").
word("specie", 'n.', "Type or kind, in various uses of the phrase 'in specie'.").
word("species", 'n.', "Either of the two elements of the Eucharist after they have been consecrated.").
word("species", 'n.', "Type or kind. .}}").
word("specimen", 'n.', "A sample, especially one used for diagnostic analysis.").
word("specimen", 'n.', "An individual instance that represents a class; an example.").
word("specious", 'adj.', "Employing fallacious but deceptively plausible arguments; deceitful.").
word("specious", 'adj.', "Seemingly well-reasoned, plausible or true, but actually fallacious.").
word("spectator", 'n.', "One who watches an event; especially, an event held outdoors.").
word("specter", 'n.', "A ghostly apparition, a phantom.").
word("specter", 'n.', "A threatening mental image.").
word("spectrum", 'n.', "The pattern of absorption or emission of radiation produced by a substance when subjected to energy (radiation, heat, electricity, etc.).").
word("spectrum", 'n.', "A range; a continuous, infinite, one-dimensional set, possibly bounded by extremes.").
word("speculate", 'v.', "To make an inference based on inconclusive evidence; to surmise or conjecture.").
word("speculate", 'v.', "To anticipate which branch of code will be chosen and execute it in advance.").
word("speculator", 'n.', "One who speculates; as in investing, one who is willing to take volatile risks upon invested for the potential of substantial returns.").
word("speculator", 'n.', "One who forms theories; a theorist.").
word("sphericity", 'n.', "The quality of being spherical, being a sphere.").
word("sphericity", 'n.', "The ratio of the surface area of a given particle to the surface area of a sphere with the same volume.").
word("spheroid", 'n.', "A solid of revolution generated by rotating an ellipse about its major (prolate), or minor (oblate) axis. Category:en:Surfaces").
word("spherometer", 'n.', "A device used to measure the curvature of a surface, such as a lens.").
word("spinous", 'adj.', "Having a sharp projection.").
word("spinous", 'adj.', "Of a person: difficult to deal with, prickly.").
word("spinster", 'n.', "A woman who has never been married, especially one past the typical marrying age according to social traditions.").
word("spinster", 'n.', "A woman of evil life and character; so called from being forced to spin in a house of correction.").
word("spontaneous", 'adj.', "Proceeding from natural feeling or native tendency without external or conscious constraint").
word("spontaneous", 'adj.', "Done by one's own free choice, or without planning.").
word("sprightly", 'adj.', "Animated, gay or vivacious; lively, spirited.").
word("sprightly", 'adj.', "Of a person: full of life and vigour, especially with a light and springy step.").
word("spurious", 'adj.', "False, not authentic, not genuine.").
word("spurious", 'adj.', "Extraneous; stray; not relevant or wanted.").
word("squabble", 'v.', "To participate in a minor fight or argument; to quarrel.").
word("squabble", 'v.', "To disarrange, so that the letters or lines stand awry and require readjustment.").
word("squalid", 'adj.', "Extremely dirty and unpleasant.").
word("squalid", 'adj.', "Showing a contemptible lack of moral standards.").
word("squatter", 'n.', "One who occupies a building or land without title or permission.").
word("squatter", 'n.', "One who squats, sits down idly.").
word("stagnant", 'adj.', "Lacking freshness, motion, or flow; decaying through stillness.").
word("stagnant", 'adj.', "Without progress or change; stale; inactive.").
word("stagnate", 'v.', "To cease motion, activity, or progress:").
word("stagnation", 'n.', "Inactivity").
word("stagnation", 'n.', "Being stagnant; being without circulation").
word("stagy", 'adj.', "Theatrical").
word("stagy", 'adj.', "Melodramatic; sensationalized").
word("staid", 'adj.', "Not capricious or impulsive; sedate, serious, sober.").
word("staid", 'adj.', "Always fixed in the same location; stationary.").
word("stallion", 'n.', "An adult male horse.").
word("stallion", 'n.', "A very virile and sexually-inclined man or (rarely) woman.").
word("stanchion", 'n.', "A framework of such posts, used to secure or confine cattle.").
word("stanchion", 'n.', "A vertical pole, post, or support.").
word("stanza", 'n.', "An apartment or division in a building.").
word("stanza", 'n.', "A unit of a poem, written or printed as a paragraph; equivalent to a verse.").
word("statecraft", 'n.', "The skills of being a statesman, of leading a country well; statesmanship.").
word("static", 'adj.', "Defined for the class itself, as opposed to instances of it; thus shared between all instances and accessible even without an instance.").
word("static", 'adj.', "Unchanging; that cannot or does not change.").
word("statics", 'n.', "The branch of mechanics concerned with forces in static equilibrium").
word("stationary", 'adj.', "Not moving.").
word("stationary", 'adj.', "Incapable of being moved").
word("statistician", 'n.', "A person who compiles, interprets, or studies statistics.").
word("statistician", 'n.', "A mathematician with a specialty of statistics.").
word("statuesque", 'adj.', "Elegantly tall, graceful, and attractive.").
word("statuesque", 'adj.', "Resembling or characteristic of a statue.").
word("statuette", 'n.', "A small statue, usually a figure much less than life size, especially when of marble or bronze, or of plaster or clay as a preparation for the marble or bronze, as distinguished from a figure in terra cotta etc.").
word("stature", 'n.', "A person or animal's natural height when standing upright.").
word("stature", 'n.', "Respect coming from achievement or development.").
word("statute", 'n.', "Written law, as laid down by the legislature.").
word("stealth", 'n.', "The attribute or characteristic of acting in secrecy, or in such a way that the actions are unnoticed or difficult to detect by others.").
word("stealth", 'n.', "An act of secrecy, especially one involving thievery.").
word("stellar", 'adj.', "Of, pertaining to, or characteristic of stars.").
word("stellar", 'adj.', "Heavenly.").
word("steppe", 'n.', "The grasslands of Eastern Europe and Asia. Similar to (North American) prairie and (African) savanna.").
word("steppe", 'n.', "A vast cold, dry grass-plain.").
word("sterling", 'adj.', "Genuine; true; pure; of great value or excellence.").
word("sterling", 'adj.', "Of acknowledged worth or influence; high quality; authoritative.").
word("stifle", 'v.', "To feel smothered; to find it difficult to breathe.").
word("stifle", 'v.', "To make (an animal or person) unconscious or cause (an animal or person) death by preventing breathing; to smother, to suffocate.").
word("stigma", 'n.', "A ligature of the Greek letters sigma and tau, (Ϛ/ϛ).").
word("stigma", 'n.', "A mark of infamy or disgrace.").
word("stiletto", 'n.', "A small, slender knife or dagger-like weapon intended for stabbing.").
word("stiletto", 'n.', "An awl.").
word("stimulant", 'n.', "Something that promotes activity, interest, or enthusiasm.").
word("stimulant", 'n.', "A substance that acts to increase physiological or nervous activity in the body.").
word("stimulate", 'v.', "To arouse an organism to functional activity.").
word("stimulate", 'v.', "To encourage into action.").
word("stimulus", 'n.', "An external phenomenon that has an influence on a system, by triggering or modifying an internal phenomenon; for example, a spur or incentive that drives a person to take action or change behaviour.").
word("stimulus", 'n.', "A sting on the body of a plant or insect.").
word("stingy", 'adj.', "Unwilling to spend, give, or share; ungenerous; mean").
word("stingy", 'adj.', "Small, scant, meager, insufficient").
word("stipend", 'n.', "A fixed payment, generally small and occurring at regular intervals; a modest allowance.").
word("stipend", 'n.', "Salary").
word("stoicism", 'n.', "A school of philosophy popularized during the Roman Empire that emphasized reason as a means of understanding the natural state of things, or logos, and as a means of freeing oneself from emotional distress.").
word("stoicism", 'n.', "A real or pretended indifference to pleasure or pain; insensibility; impassiveness.").
word("stolid", 'adj.', "Having or revealing little emotion or sensibility; dully or heavily stupid.").
word("strait", 'n.', "A narrow channel of water connecting two larger bodies of water.").
word("strait", 'n.', "A neck of land; an isthmus.").
word("stratagem", 'n.', "A tactic or artifice designed to gain the upper hand, especially one involving underhanded dealings or deception.").
word("stratagem", 'n.', "Specifically, such a tactic or artifice in military operation.").
word("stratum", 'n.', "One of several parallel horizontal layers of material arranged one on top of another.").
word("stratum", 'n.', "A layer of sedimentary rock having approximately the same composition throughout.").
word("streamlet", 'n.', "A small stream.").
word("stringency", 'n.', "A rigorous imposition of standards.").
word("stringency", 'n.', "A scarcity of money or credit.").
word("stringent", 'adj.', "Strict; binding strongly; making strict requirements; restrictive; rigid; severe").
word("stripling", 'n.', "A young man in the state of adolescence, or just passing from boyhood to manhood; a lad. .").
word("stripling", 'n.', "A seedling with most of the leaves stripped off.").
word("studious", 'adj.', "Dedicated to study; devoted to the acquisition of knowledge from books").
word("studious", 'adj.', "Given to thought, or to the examination of subjects by contemplation; contemplative.").
word("stultify", 'v.', "To cause to appear foolish.").
word("stultify", 'v.', "To deprive of strength or efficacy; make useless or worthless.").
word("stupendous", 'adj.', "Of stunning excellence or degree; marvelous.").
word("stupendous", 'adj.', "Astonishingly great or large; huge; enormous.").
word("stupor", 'n.', "A state of extreme apathy or torpor resulting often from stress or shock.").
word("stupor", 'n.', "A state of greatly dulled or completely suspended consciousness or sensibility; a chiefly mental condition marked by absence of spontaneous movement, greatly diminished responsiveness to stimulation, and usually impaired consciousness.").
word("suasion", 'n.', "The act of urging or influencing; persuasion.").
word("suave", 'adj.', "Charming, confident and elegant.").
word("subacid", 'adj.', "Somewhat acidic.").
word("subaquatic", 'adj.', "Located or living under water; submarine.").
word("subconscious", 'adj.', "Below the level of consciousness.").
word("subconscious", 'adj.', "Partially conscious.").
word("subjacent", 'adj.', "Lying beneath or at a lower level; underlying.").
word("subjection", 'n.', "The act of bringing something under the control of something else.").
word("subjection", 'n.', "The state of being subjected.").
word("subjugate", 'v.', "To forcibly impose obedience or servitude upon.").
word("subliminal", 'adj.', "Below the threshold of conscious perception, especially if still able to produce a response.").
word("sublingual", 'adj.', "Situated beneath the tongue.").
word("sublingual", 'adj.', "Administered through placement under the tongue.").
word("submarine", 'adj.', "Existing, relating to, or made for use beneath the sea.").
word("submarine", 'adj.', "Of a pitch, thrown with the hand lower than the elbow.").
word("submerge", 'v.', "To sink out of sight.").
word("submerge", 'v.', "To engulf or overwhelm.").
word("submergence", 'n.', "The act of submerging or the state of being submerged; submersion.").
word("submersible", 'adj.', "Able to be submerged.").
word("submersion", 'n.', "The act of submerging, or the state of being submerged; immersion").
word("submersion", 'n.', "A differentiable map whose differential is everywhere surjective.").
word("submission", 'n.', "The act of submitting or yielding; surrender.").
word("submission", 'n.', "A subset or component of a mission.").
word("submittal", 'n.', "Data about a product, such as shop drawings, material data, or samples.").
word("submittal", 'n.', "The act of submitting; submission").
word("subordinate", 'adj.', "Submissive or inferior to, or controlled by authority.").
word("subordinate", 'adj.', "Dependent on and either modifying or complementing the main clause").
word("subsequent", 'adj.', "Following in time; coming or being after something else at any time, indefinitely.").
word("subsequent", 'adj.', "Following in order of place; succeeding.").
word("subservience", 'n.', "The state of being subservient.").
word("subservient", 'adj.', "Obsequiously submissive.").
word("subservient", 'adj.', "Useful in an inferior capacity.").
word("subside", 'v.', "To fall into a state of calm; to be calm again; to settle down; to become tranquil; to abate.").
word("subside", 'v.', "To sink or fall to the bottom; to settle, as lees.").
word("subsist", 'v.', "To have ontological reality; to exist.").
word("subsist", 'v.', "To survive on a minimum of resources.").
word("subsistence", 'n.', "Real being; existence.").
word("subsistence", 'n.', "Something (food, water, money, etc.) that is required to stay alive.").
word("substantive", 'adj.', "Depending on itself; independent.").
word("substantive", 'adj.', "Of the essence or essential element of a thing.").
word("subtend", 'v.', "To extend or stretch opposite something; to be part of a straight or curved line that is opposite to and delimits an angle.").
word("subtend", 'v.', "To use an angle to delimit (mark off, enclose) part of a straight or curved line, for example an arc or the opposite side of a triangle.").
word("subterfuge", 'n.', "An indirect or deceptive device or stratagem; a blind. Refers especially to war and diplomatics.").
word("subterfuge", 'n.', "Deception; misrepresentation of the true nature of an activity.").
word("subterranean", 'adj.', "Below ground, under the earth, underground.").
word("subterranean", 'adj.', "Secret, concealed.").
word("subtle", 'adj.', "Hard to grasp; not obvious or easily understood; barely noticeable.").
word("subtle", 'adj.', "Insidious.").
word("subtrahend", 'n.', "A number or quantity to be subtracted from another.").
word("subversion", 'n.', "A systematic attempt to overthrow a government by working from within; undermining.").
word("subversion", 'n.', "The act of subverting or the condition of being subverted.").
word("subvert", 'v.', "To overturn from the foundation; to overthrow; to ruin utterly.").
word("subvert", 'v.', "To pervert, as the mind, and turn it from the truth; to corrupt; to confound.").
word("succeed", 'v.', "To prevail in obtaining an intended objective or accomplishment; to prosper as a result or conclusion of a particular effort.").
word("succeed", 'v.', "To ensue with an intended consequence or effect.").
word("success", 'n.', "One who, or that which, achieves assumed goals.").
word("success", 'n.', "The achievement of one's aim or goal.").
word("successful", 'adj.', "Resulting in success; assuring, or promoting, success; accomplishing what was proposed; having the desired effect").
word("successor", 'n.', "A person or thing that immediately follows another in holding an office or title.").
word("successor", 'n.', "The integer, ordinal number or cardinal number immediately following another.").
word("succinct", 'adj.', "Brief and to the point").
word("succinct", 'adj.', "Compressed into a tiny area.").
word("succulent", 'adj.', "Juicy or lush.").
word("succulent", 'adj.', "Luscious or delectable.").
word("succumb", 'v.', "To die.").
word("succumb", 'v.', "To give up, or give in.").
word("sufferance", 'n.', "Acquiescence or tacit compliance with some circumstance, behavior, or instruction.").
word("sufferance", 'n.', "A permission granted by the customs authorities for the shipment of goods.").
word("sufficiency", 'n.', "An adequate amount.").
word("sufficiency", 'n.', "The quality or condition of being sufficient.").
word("suffrage", 'n.', "The right or chance to vote, express an opinion, or participate in a decision, especially in a democratic elections.").
word("suffrage", 'n.', "A prayer, for example a prayer offered for the faithful dead.").
word("suffuse", 'v.', "To spread through or over in the manner of a liquid.").
word("suffuse", 'v.', "To spread through or over something, especially as a liquid, colour or light; to bathe.").
word("suggestible", 'adj.', "Susceptible to influence by suggestion.").
word("suggestive", 'adj.', "Tending to suggest or imply.").
word("suggestive", 'adj.', "Relating to hypnotic suggestion.").
word("summary", 'n.', "An abstract or a condensed presentation of the substance of a body of material.").
word("sumptuous", 'adj.', "Magnificent, luxurious, splendid.").
word("superabundance", 'n.', "An extreme abundance; abundance to a vast degree that seems almost excessive.").
word("superadd", 'v.', "To add on top of a previous addition.").
word("superannuate", 'v.', "To become obsolete or antiquated.").
word("superannuate", 'v.', "To give a pension to, on account of old age or other infirmity; to cause to retire from service on a pension.").
word("superb", 'adj.', "Grand; magnificent; august; stately.").
word("superb", 'adj.', "First-rate; of the highest quality; exceptionally good.").
word("supercilious", 'adj.', "Arrogantly superior; showing contemptuous indifference; haughty.").
word("superficial", 'adj.', "Not thorough, deep, or complete; concerned only with the obvious or apparent.").
word("superfluity", 'n.', "Collective noun for a group of nuns.").
word("superfluity", 'n.', "The quality or state of being superfluous; overflowingness.").
word("superfluous", 'adj.', "In excess of what is required or sufficient.").
word("superheat", 'v.', "To heat a liquid above its boiling point").
word("superheat", 'v.', "To heat a vapour above its saturation point").
word("superintend", 'v.', "To administer the affairs of something or someone.").
word("superintend", 'v.', "To oversee the work of others; to supervise.").
word("superintendence", 'n.', "The act of superintending; supervision").
word("superintendent", 'n.', "A person who is authorized to supervise, direct or administer something.").
word("superintendent", 'n.', "In some Protestant churches, a clergyman having the oversight of the clergy of a district.").
word("superlative", 'n.', "The form of an adjective that expresses which of several items has the highest degree of the quality expressed by the adjective; in English, formed by appending \"-est\" to the end of the adjective (for some short adjectives only) or putting \"most\" before it.").
word("superlative", 'n.', "The extreme (e.g. highest, lowest, deepest, farthest, etc) extent or degree of something.").
word("supernatural", 'adj.', "Above nature; beyond or added to nature, often so considered because it is given by a deity or some force beyond that which humans are born with.").
word("supernatural", 'adj.', "Not of the usual; not natural; altered by forces that are not understood fully if at all.").
word("supernumerary", 'adj.', "Beyond what is necessary; redundant.").
word("supernumerary", 'adj.', "Beyond the prescribed or standard amount or number; excess, extra.").
word("supersede", 'v.', "To displace in favour of itself.").
word("supersede", 'v.', "To take the place of.").
word("supine", 'adj.', "Lying on its back.").
word("supine", 'adj.', "Inclining or leaning backward; inclined, sloping.").
word("supplant", 'v.', "To take the place of; to replace, to supersede.").
word("supplant", 'v.', "To uproot, to remove violently.").
word("supple", 'adj.', "Pliant, flexible, easy to bend").
word("supple", 'adj.', "Lithe and agile when moving and bending").
word("supplementary", 'adj.', "Additional; added to supply what is wanted.").
word("supplicant", 'n.', "One who comes to humbly ask or petition").
word("supplicant", 'n.', "A device attempting to authenticate itself to an 802.11 network.").
word("supplicate", 'v.', "To humble oneself before (another) in making a request; to beg or beseech.").
word("supplicate", 'v.', "To request that an academic degree is awarded at a ceremony.").
word("supposition", 'n.', "Something that is supposed; an assumption made to account for known facts, conjecture.").
word("supposition", 'n.', "The act or an instance of supposing.").
word("suppress", 'v.', "To exclude undesirable thoughts from one's mind.").
word("suppress", 'v.', "To prevent publication.").
word("suppressible", 'adj.', "Capable of being suppressed.").
word("suppression", 'n.', "A subconscious adaptation by a person's brain to eliminate the symptoms of disorders of binocular vision such as strabismus, convergence insufficiency and aniseikonia.").
word("suppression", 'n.', "A process in which a person consciously excludes anxiety-producing thoughts, feelings, or memories.").
word("supramundane", 'adj.', "Above or beyond the mundane.").
word("surcharge", 'n.', "An addition of extra charge on the agreed or stated price.").
word("surcharge", 'n.', "An excessive price charged e.g. to an unsuspecting customer.").
word("surety", 'n.', "One who undertakes to pay money or perform other acts in the event that his principal fails therein.").
word("surety", 'n.', "A promise to pay a sum of money in the event that another person fails to fulfill an obligation.").
word("surfeit", 'v.', "To overeat or feed to excess (on or upon something).").
word("surfeit", 'v.', "To feed (someone) to excess (on, upon or with something).").
word("surmise", 'v.', "To imagine or suspect; to conjecture; to posit with contestable premises.").
word("surmount", 'v.', "To get over; to overcome.").
word("surmount", 'v.', "To cap; to sit on top off.").
word("surreptitious", 'adj.', "Stealthy, furtive, well hidden, covert (especially movements).").
word("surrogate", 'n.', "Any of a range of Unicode codepoints which are used in pairs in UTF-16 to represent characters beyond the Basic Multilingual Plane.").
word("surrogate", 'n.', "A judicial officer of limited jurisdiction, who administers matters of probate and intestate succession and, in some cases, adoptions.").
word("surround", 'v.', "To encircle something or simultaneously extend in all directions.").
word("surround", 'v.', "To pass around; to travel about; to circumnavigate.").
word("surveyor", 'n.', "A person charged with inspecting something for the purpose of determining its condition, value, etc.").
word("surveyor", 'n.', "A person occupied with surveying -- the process of determining positions on the earth's surface.").
word("susceptibility", 'n.', "Emotional sensitivity.").
word("susceptibility", 'n.', "The condition of being susceptible; vulnerability").
word("susceptible", 'adj.', "Easily influenced or tricked; credulous").
word("susceptible", 'adj.', "That, when subjected to a specific operation, will yield a specific result").
word("suspense", 'n.', "The unpleasant emotion of anxiety or apprehension in an uncertain situation.").
word("suspense", 'n.', "The pleasurable emotion of anticipation and excitement regarding the outcome or climax of a book, film etc.").
word("suspension", 'n.', "A topological space derived from another by taking the product of the original space with an interval and collapsing each end of the product to a point.").
word("suspension", 'n.', "The temporary barring of a person from a workplace, society, etc. pending investigation into alleged misconduct.").
word("suspicious", 'adj.', "Distrustful or tending to suspect.").
word("suspicious", 'adj.', "Arousing suspicion.").
word("sustenance", 'n.', "Something that provides support or nourishment.").
word("swarthy", 'adj.', "Darker-skinned than white, but lighter-skinned than tawny.").
word("swarthy", 'adj.', "Dark-skinned.").
word("sybarite", 'n.', "A person devoted to pleasure and luxury.").
word("sycophant", 'n.', "One who seeks to gain through the powerful and influential.").
word("sycophant", 'n.', "One who uses obsequious compliments to gain self-serving favor or advantage from another; a servile flatterer.").
word("syllabic", 'adj.', "Of, or being a form of verse, based on the number of syllables in a line rather than on the arrangement of accents or quantities.").
word("syllabic", 'adj.', "Of, relating to, or consisting of a syllable or syllables.").
word("syllabication", 'n.', "The act of syllabifying; syllabification.").
word("syllable", 'n.', "A small part of a sentence or discourse; anything concise or short; a particle.").
word("syllable", 'n.', "A unit of human speech that is interpreted by the listener as a single sound, although syllables usually consist of one or more vowel sounds, either alone or combined with the sound of one or more consonants; a word consists of one or more syllables.").
word("syllabus", 'n.', "A summary of topics which will be covered during an academic course, or a text or lecture.").
word("syllabus", 'n.', "The headnote of a reported case; the brief statement of the points of law determined prefixed to a reported case.").
word("sylph", 'n.', "A slender woman or girl, usually graceful and sometimes with the implication of sublime station over everyday people.").
word("sylph", 'n.', "The elemental being of air, usually female.").
word("symmetrical", 'adj.', "Exhibiting symmetry; having harmonious or proportionate arrangement of parts; having corresponding parts or relations.").
word("symmetry", 'n.', "Exact correspondence on either side of a dividing line, plane, center or axis.").
word("symmetry", 'n.', "The satisfying arrangement of a balanced distribution of the elements of a whole.").
word("sympathetic", 'adj.', "Attracting the liking of others.").
word("sympathetic", 'adj.', "Relating to, producing, or denoting an effect which arises through an affinity, interdependence, or mutual association.").
word("sympathize", 'v.', "To share (a feeling or experience).").
word("sympathize", 'v.', "To have a common feeling, as of bodily pleasure or pain.").
word("symphonic", 'adj.', "Characteristic of a symphony").
word("symphonious", 'adj.', "Of or pertaining to simultaneous sounds that are harmonious together.").
word("symphony", 'n.', "An extended piece of music of sophisticated structure, usually for orchestra.").
word("symphony", 'n.', "Harmony in music or colour, or a harmonious combination of elements.").
word("synchronism", 'n.', "A temporal relationship between events.").
word("synchronism", 'n.', "The tabular arrangement of contemporary events etc. in history.").
word("syndicate", 'n.', "A group of individuals or companies formed to transact some specific business, or to promote a common interest; a self-coordinating group.").
word("syndicate", 'n.', "The office or jurisdiction of a syndic; a body or council of syndics.").
word("synod", 'n.', "An ecclesiastic council or meeting to consult on church matters.").
word("synod", 'n.', "An assembly or council having civil authority; a legislative body.").
word("synonym", 'n.', "A word whose meaning is the same as that of another word.").
word("synonym", 'n.', "A word or phrase with a meaning that is the same as, or very similar to, another word or phrase.").
word("synopsis", 'n.', "A brief summary of the major points of a written work, either as prose or as a table; an abridgment or condensation of a work.").
word("synopsis", 'n.', "A reference work containing brief articles that taken together give an overview of an entire field.").
word("systematic", 'adj.', "Methodical, regular and orderly.").
word("systematic", 'adj.', "Carried out using a planned, ordered procedure.").
word("tableau", 'n.', "A vivid graphic scene of a group of people arranged as in a painting or bas relief sculpture.").
word("tableau", 'n.', "A striking and vivid representation; a picture.").
word("tacit", 'adj.', "Implied, but not made explicit, especially through silence.").
word("tacit", 'adj.', "Not derived from formal principles of reasoning; based on induction rather than deduction.").
word("taciturn", 'adj.', "Silent; temperamentally untalkative; disinclined to speak.").
word("tack", 'n.', "A course or heading that enables a sailing vessel to head upwind. See also reach, gybe.").
word("tack", 'n.', "A small nail with a flat head.").
word("tact", 'n.', "Sensitive mental touch; special skill or faculty; keen perception or discernment; ready power of appreciating and doing what is required by circumstances; the ability to say the right thing.").
word("tact", 'n.', "A verbal operant which is controlled by a nonverbal stimulus (such as an object, event, or property of an object) and is maintained by nonspecific social reinforcement (praise).").
word("tactician", 'n.', "A person skilled in the planning and execution of tactics.").
word("tactics", 'n.', "The employment and ordered arrangement of forces in relation to each other Joint Publication 1-02 U.S. Department of Defense Dictionary of Military and Associated Terms; 12 April 2001 (As Amended Through 14 April 2006). .").
word("tactics", 'n.', "The military science that deals with achieving the objectives set by strategy.").
word("tangency", 'n.', "The state of being tangent; an instance of (something) being tangent.").
word("tangent", 'adj.', "Touching a curve at a single point but not crossing it at that point.").
word("tangent", 'adj.', "Of a topic, only loosely related to a main topic.").
word("tangible", 'adj.', "Touchable; able to be touched or felt; perceptible by the sense of touch").
word("tangible", 'adj.', "Possible to be treated as fact; real or concrete.").
word("tannery", 'n.', "A place where people tan hides to make leather.").
word("tannery", 'n.', "The business of a tanner.").
word("tantalize", 'v.', "To tease (someone) by offering something desirable but keeping it out of reach").
word("tantalize", 'v.', "To bait (someone) by showing something desirable but leaving them unsatisfied").
word("tantamount", 'adj.', "Equivalent in meaning or effect; amounting to the same thing in practical terms, even if being technically distinct.").
word("tapestry", 'n.', "Anything with variegated or complex details.").
word("tapestry", 'n.', "A heavy woven cloth, often with decorative pictorial designs, normally hung on walls.").
word("tarnish", 'v.', "To lose its lustre or attraction; to become dull.").
word("tarnish", 'v.', "To oxidize or discolor due to oxidation.").
word("taut", 'adj.', "Under tension, like a stretched bowstring, rope, or sail; tight.").
word("taut", 'adj.', "Experiencing anxiety or stress.").
word("taxation", 'n.', "The act of imposing taxes and the fact of being taxed.").
word("taxation", 'n.', "A particular system of taxing people or companies").
word("taxidermy", 'n.', "The art of stuffing and mounting the skins of dead animals for exhibition in a lifelike state.").
word("technic", 'adj.', "Technical").
word("technicality", 'n.', "That which is technical, or peculiar to any trade, profession, sect, or the like.").
word("technicality", 'n.', "A minor detail, rule, law, etc., seemingly insignificant to a non-specialist but which has significant consequences in larger matters.").
word("technique", 'n.', "A method of achieving something or carrying something out, especially one requiring some skill or knowledge.").
word("technique", 'n.', "Practical ability in some given field or practice, often as opposed to creativity or imaginative skill.").
word("technography", 'n.', "The description of the arts and crafts of tribes and peoples.").
word("technography", 'n.', "Live capture of meeting notes while projecting the real-time transcription to participants.").
word("technology", 'n.', "The organization of knowledge for practical purposes.").
word("technology", 'n.', "A discourse or treatise on the arts.").
word("teem", 'v.', "To be stocked to overflowing.").
word("teem", 'v.', "To be prolific; to abound; to be rife.").
word("telepathy", 'n.', "The capability to communicate directly by psychic means; the sympathetic affection of one mind by the thoughts, feelings, or emotions of another at a distance, without communication through the ordinary channels of sensation.").
word("telephony", 'n.', "The act of sound transmission via the electromagnetic spectrum.").
word("telephony", 'n.', "The study and application of telephone technology.").
word("telescope", 'v.', "To come into collision, as railway cars, in such a manner that one runs into another.").
word("telescope", 'v.', "To slide or pass one within another, after the manner of the sections of a small telescope or spyglass.").
word("telltale", 'adj.', "Revealing something, especially something not intended to be known.").
word("temerity", 'n.', "An act or case of reckless boldness.").
word("temerity", 'n.', "Reckless boldness; foolish bravery.").
word("temporal", 'adj.', "Of or relating to the material world, as opposed to sacred or clerical.").
word("temporal", 'adj.', "Of or situated in the temples of the head or the sides of the skull behind the orbits.").
word("temporary", 'adj.', "Existing only for a short time or short times; transient, ephemeral.").
word("temporary", 'adj.', "Not permanent; existing only for a period or periods of time.").
word("temporize", 'v.', "To deliberately act evasively or prolong a discussion in order to gain time or postpone a decision, sometimes so that a compromise can be reached or simply to make a conversation more temperate; to stall for time.").
word("temporize", 'v.', "To comply with the occasion or time; to humour, or yield to, current circumstances or opinion; also, to .").
word("tempt", 'v.', "To provoke someone to do wrong, especially by promising a reward; to entice.").
word("tempt", 'v.', "To attract; to allure.").
word("tempter", 'n.', "A seducer, especially a man who seduces.").
word("tempter", 'n.', "Someone or something that tempts.").
word("tenacious", 'adj.', "Having a good memory; retentive.").
word("tenacious", 'adj.', "Clinging to an object or surface; adhesive.").
word("tenant", 'n.', "One who has possession of any place.").
word("tenant", 'n.', "Any of a number of customers serviced through the same instance of an application.").
word("tendency", 'n.', "An organised unit or faction within a larger political organisation.").
word("tendency", 'n.', "A likelihood of behaving in a particular way or going in a particular direction; a tending toward.").
word("tenet", 'n.', "An opinion, belief, or principle that is held as absolute truth by someone or especially an organization.").
word("tenor", 'n.', "A musical part or section that holds or performs the main melody, as opposed to the contratenor bassus and contratenor altus, who perform countermelodies.").
word("tenor", 'n.', "That course of thought which holds on through a discourse; the general drift or course of thought; purport; intent; meaning; understanding.").
word("tense", 'adj.', "Pulled taut, without any slack.").
word("tense", 'adj.', "Showing signs of stress or strain; not relaxed.").
word("tentative", 'adj.', "Of or pertaining to a trial or trials; essaying; experimental.").
word("tentative", 'adj.', "Restrained; polite; to feel one's way, not using full force.").
word("tenure", 'n.', "A status of possessing a thing or an office; an incumbency.").
word("tenure", 'n.', "A period of time during which something is possessed.").
word("tercentenary", 'adj.', "Of or relative to such an anniversary, or to a span of 300 years").
word("termagant", 'adj.', "Quarrelsome and scolding or censorious; shrewish.").
word("terminal", 'adj.', "Appearing at the end; top or apex of a physical object.").
word("terminal", 'adj.', "Occurring at the end of a word, sentence, or period of time, and serves to terminate it").
word("terminate", 'v.', "To end something, especially when left in an incomplete state; to die.").
word("terminate", 'v.', "To end the employment contract of an employee; to fire, lay off.").
word("termination", 'n.', "The ending up of a polypeptid chain.").
word("termination", 'n.', "The process of firing an employee; ending one's employment at a business for any reason.").
word("terminus", 'n.', "The end or final point of something.").
word("terminus", 'n.', "The end point of a transportation system, or the town or city in which it is located.").
word("terrify", 'v.', "To menace or intimidate.").
word("terrify", 'v.', "To frighten greatly; to fill with terror.").
word("territorial", 'adj.', "Of, relating to or restricted to a specific geographic area, or territory.").
word("territorial", 'adj.', "Of or relating to geography or territory.").
word("terse", 'adj.', "Of manner or speech: abruptly or brusquely short; curt.").
word("terse", 'adj.', "Of speech or style: brief, concise, to the point.").
word("testament", 'n.', "A solemn, authentic instrument in writing, by which a person declares his or her will as to disposal of his or her inheritance (estate and effects) after his or her death, benefiting specified heir(s).").
word("testament", 'n.', "A credo, expression of conviction").
word("testator", 'n.', "One who makes or has made a legally valid will.").
word("testimonial", 'n.', "A tribute given in appreciation of someone's service etc.").
word("testimonial", 'n.', "A match played in tribute to a particular player (who sometimes receives a proportion of the gate money).").
word("thearchy", 'n.', "A government ruled by God or a god; a theocracy.").
word("thearchy", 'n.', "A system or ordering of deities.").
word("theism", 'n.', "Belief in the existence of a personal creator god, goddess, gods and/or goddesses present and active in the governance and organization of the world and the universe. The God may be known by or through revelation.").
word("theism", 'n.', "Belief in the existence of at least one deity.").
word("theocracy", 'n.', "Rule by a god.").
word("theocracy", 'n.', "Government under the control of a state religion.").
word("theocrasy", 'n.', "Interaction, admixture, and conflation of divine principles.").
word("theologian", 'n.', "In Eastern Orthodox usage, a person who has had direct experience of and unity with God.").
word("theologian", 'n.', "In Roman Catholic usage, a theological lecturer attached to a cathedral church.").
word("theological", 'adj.', "Of or relating to theology.").
word("theology", 'n.', "The study of God, a god, or gods; and of the truthfulness of religion in general.").
word("theology", 'n.', "An organized method of interpreting spiritual works and beliefs into practical form.").
word("theoretical", 'adj.', "Of or relating to theory; abstract; not empirical.").
word("theorist", 'n.', "Someone who constructs theories, especially in the arts or sciences.").
word("theorize", 'v.', "To speculate.").
word("theorize", 'v.', "To formulate a theory, especially about some specific subject.").
word("thereabout", 'adv.', "Approximately that number or quantity.").
word("thereabout", 'adv.', "About or near that place.").
word("therefor", 'adv.', "For or in return for that.").
word("therefor", 'adv.', "Therefore, for that or this reason or cause.").
word("thermal", 'adj.', "Pertaining to heat or temperature.").
word("thermal", 'adj.', "Caused or brought about by heat.").
word("thermoelectric", 'adj.', "Of, pertaining to, or exhibiting thermoelectricity").
word("thermoelectricity", 'n.', "The direct conversion of heat into electricity").
word("thoroughbred", 'adj.', "Bred from pure stock.").
word("thoroughbred", 'adj.', "Well-bred and properly educated.").
word("thoroughfare", 'n.', "A road open at both ends or connecting one area with another; a highway or main street.").
word("thoroughfare", 'n.', "The act of going through; passage; travel, transit.").
word("thrall", 'n.', "The state of being under the control of another person.").
word("thrall", 'n.', "One who is enslaved or under mind control.").
word("tilth", 'n.', "Rich cultivated soil.").
word("tilth", 'n.', "Agricultural labour; husbandry.").
word("timbre", 'n.', "The quality of a sound independent of its pitch and volume.").
word("timbre", 'n.', "The pitch of a sound as heard by the ear, described relative to its absolute pitch.").
word("timorous", 'adj.', "Fearful; afraid; timid").
word("tincture", 'n.', "An alcoholic extract of plant material, used as a medicine.").
word("tincture", 'n.', "A colour or metal used in the depiction of a coat of arms.").
word("tinge", 'n.', "A small added amount of colour; a small added amount of some other thing.").
word("tinge", 'n.', "The degree of vividness of a colour; hue, shade, tint.").
word("tipsy", 'adj.', "Slightly drunk, fuddled, staggering, foolish as a result of drinking alcoholic beverages").
word("tipsy", 'adj.', "Unsteady, askew").
word("tirade", 'n.', "A long, angry or violent speech.").
word("tirade", 'n.', "A section of verse concerning a single theme.").
word("tireless", 'adj.', "Indefatigable, untiring and not yielding to fatigue").
word("tireless", 'adj.', "Without a tire (wheel covering); tyreless.").
word("tiresome", 'adj.', "Causing fatigue or boredom; wearisome.").
word("titanic", 'adj.', "Having great size, or great strength, force or power.").
word("titanic", 'adj.', "Of or relating to titanium, especially tetravalent titanium").
word("toilsome", 'adj.', "Requiring continuous physical effort; laborious.").
word("tolerable", 'adj.', "Moderate in degree; mediocre; passable, acceptable or so-so.").
word("tolerable", 'adj.', "In fair health; passably well.").
word("tolerance", 'n.', "The ability of the body (or other organism) to resist the action of a poison, to cope with a dangerous drug or to survive infection by an organism.").
word("tolerance", 'n.', "The variation or deviation from a standard, especially the maximum permitted variation in an engineering measurement.").
word("tolerant", 'adj.', "Tending to permit, allow, understand, or accept something").
word("tolerant", 'adj.', "Tending to withstand or survive").
word("tolerate", 'v.', "To allow (something that one dislikes or disagrees with) to exist or occur without interference.").
word("toleration", 'n.', "Specifically, the allowance by a government (or other ruling power) of the exercise of religion beyond the state established faith.").
word("toleration", 'n.', "Endurance of evil, suffering etc.").
word("topography", 'n.', "A detailed graphic representation of the surface features of a place or object.").
word("topography", 'n.', "The surveying of the features.").
word("torpor", 'n.', "A state of apathy or lethargy.").
word("torpor", 'n.', "A state of being inactive or stuporous.").
word("torrid", 'adj.', "Very hot and dry.").
word("torrid", 'adj.', "Full of difficulty.").
word("tortious", 'adj.', "Wrongful; harmful.").
word("tortious", 'adj.', "Of, pertaining to, or characteristic of torts.").
word("tortuous", 'adj.', "Twisted; having many turns; convoluted.").
word("tortuous", 'adj.', "Oblique; applied to the six signs of the zodiac (from Capricorn to Gemini) that ascend most rapidly and obliquely.").
word("torturous", 'adj.', "Of or pertaining to torture.").
word("torturous", 'adj.', "Painful, excruciating, torturing.").
word("tractable", 'adj.', "Capable of being easily led, taught, or managed.").
word("tractable", 'adj.', "Easy to deal with or manage").
word("trait", 'n.', "An identifying characteristic, habit or trend.").
word("trait", 'n.', "An uninstantiable collection of methods that provides functionality to a class by using the class’s own interface.").
word("trajectory", 'n.', "The path an object takes as it moves.").
word("trajectory", 'n.', "The path of a body as it travels through space.").
word("trammel", 'n.', "Whatever impedes activity, progress, or freedom, such as a net or shackle.").
word("trammel", 'n.', "A fishing net that has large mesh at the edges and smaller mesh in the middle").
word("tranquil", 'adj.', "Calm; without motion or sound.").
word("tranquil", 'adj.', "Free from emotional or mental disturbance.").
word("tranquility", 'n.', "The absence of disturbance; peacefulness").
word("tranquility", 'n.', "The absence of stress; serenity").
word("tranquilize", 'v.', "To calm (a person or animal) or put them to sleep using a drug.").
word("tranquilize", 'v.', "To become tranquil.").
word("transact", 'v.', "To conduct business.").
word("transact", 'v.', "To exchange or trade, as of ideas, money, goods, etc.").
word("transalpine", 'adj.', "On the other side of the Alps (with respect to Rome, therefore the north side).").
word("transatlantic", 'adj.', "On, spanning or crossing, or from the other side of the Atlantic Ocean.").
word("transcend", 'v.', "To climb; to mount.").
word("transcend", 'v.', "To surpass, as in intensity or power; to excel.").
word("transcendent", 'adj.', "Surpassing usual limits").
word("transcendent", 'adj.', "Beyond the range of usual perception").
word("transcontinental", 'adj.', "Crossing or spanning a continent.").
word("transcribe", 'v.', "To make such a conversion from live or recorded speech to text.").
word("transcribe", 'v.', "To represent speech by phonetic symbols.").
word("transcript", 'n.', "A copy of any kind; an imitation.").
word("transcript", 'n.', "An inventory of the courses taken and grades earned of a student alleged throughout a course.").
word("transfer", 'v.', "To move or pass from one place, person or thing to another.").
word("transfer", 'v.', "To convey the impression of (something) from one surface to another.").
word("transferable", 'adj.', "Able to be transferred.").
word("transferee", 'n.', "A person to whom title or ownership is conveyed.").
word("transferee", 'n.', "A person who is transferred.").
word("transference", 'n.', "The act of conveying from one place to another; the act of transferring or the fact of being transferred.").
word("transference", 'n.', "The process by which emotions and desires, originally associated with one person, such as a parent, are unconsciously shifted to another.").
word("transferrer", 'n.', "A person who, or thing that transfers").
word("transfigure", 'v.', "To glorify or exalt.").
word("transfigure", 'v.', "To transform the outward appearance of; to convert into a different form, state or substance.").
word("transfuse", 'v.', "To pour liquid from one vessel into another.").
word("transfuse", 'v.', "To administer a transfusion of.").
word("transfusible", 'adj.', "Capable of being transfused").
word("transfusion", 'n.', "The act of pouring liquid from one vessel to another.").
word("transfusion", 'n.', "The transfer of blood or blood products from one individual to another.").
word("transgress", 'v.', "To spread over land along a shoreline; to inundate.").
word("transgress", 'v.', "To commit an offense; to sin.").
word("transience", 'n.', "An impermanence that suggests the inevitability of ending or dying.").
word("transience", 'n.', "The quality of being transient, temporary, brief or fleeting.").
word("transient", 'n.', "A module that generally remains in memory only for a short time.").
word("transient", 'n.', "A relatively loud, non-repeating signal in an audio waveform that occurs very quickly, such as the attack of a snare drum.").
word("transition", 'n.', "The process of change from one form, state, style or place to another.").
word("transition", 'n.', "The process or act of changing from one gender role to another, or of bringing one's outward appearance in line with one's internal gender identity.").
word("transitory", 'adj.', "Lasting only a short time; temporary.").
word("transitory", 'adj.', "Of an action: that may be brought in any county").
word("translator", 'n.', "A language interpreter.").
word("translator", 'n.', "One that makes a new version of a source material in a different language or format.").
word("translucence", 'n.', "The state of being translucent").
word("translucent", 'adj.', "Allowing light to pass through, but diffusing it.").
word("translucent", 'adj.', "Clear, lucid, or transparent.").
word("transmissible", 'adj.', "Able to be transmitted.").
word("transmission", 'n.', "The passage of a nerve impulse across synapses.").
word("transmission", 'n.', "The passing of a communicable disease from an infected host individual or group to a conspecific individual or group.").
word("transmit", 'v.', "To send out a signal (as opposed to receive).").
word("transmit", 'v.', "To send or convey something from one person, place or thing to another.").
word("transmute", 'v.', "To change, transform or convert one thing to another, or from one state or form to another.").
word("transparent", 'adj.', "Obvious; readily apparent; easy to see or understand.").
word("transparent", 'adj.', "See-through, clear; having the property that light passes through it almost undisturbed, such that one can see through it clearly.").
word("transpire", 'v.', "To give off (vapour, waste matter etc.); to exhale (an odour etc.).").
word("transpire", 'v.', "Of plants, to give off water and waste products through the stomata.").
word("transplant", 'v.', "To remove (something) and establish its residence in another place; to resettle or relocate.").
word("transplant", 'v.', "To uproot (a growing plant), and plant it in another place.").
word("transposition", 'n.', "A incorporation of the provisions of a European Union directive into a Member State's domestic law.").
word("transposition", 'n.', "A sequence of moves resulting in a position that may also be reached by another, more common sequence.").
word("transverse", 'adj.', "Situated or lying across; side to side, relative to some defined \"forward\" direction; perpendicular or slanted relative to the \"forward\" direction; identified with movement across areas.").
word("transverse", 'adj.', "Not tangent, so that a nondegenerate angle is formed between the two things intersecting.").
word("travail", 'n.', "Arduous or painful exertion; excessive labor, suffering, hardship.").
word("travail", 'n.', "Specifically, the labor of childbirth.").
word("travesty", 'n.', "An absurd or grotesque misrepresentation.").
word("travesty", 'n.', "A parody or stylistic imitation.").
word("treacherous", 'adj.', "Unreliable; dangerous.").
word("treacherous", 'adj.', "Deceitful; inclined to betray.").
word("treachery", 'n.', "The act of violating the confidence of another, usually for personal gain.").
word("treachery", 'n.', "Deliberate, often calculated, disregard for trust or faith.").
word("treasonable", 'adj.', "Involving or constituting treason").
word("treatise", 'n.', "A formal, usually lengthy, systematic discourse on some subject.").
word("treble", 'adj.', "Threefold, triple.").
word("treble", 'adj.', "High in pitch; shrill.").
word("trebly", 'adv.', "To three times the extent or degree; triply.").
word("trebly", 'adv.', "Three times, thrice").
word("tremendous", 'adj.', "Awe-inspiring; terrific.").
word("tremendous", 'adj.', "Notable for its size, power, or excellence.").
word("tremor", 'n.', "A shake, quiver, or vibration.").
word("tremor", 'n.', "An earthquake.").
word("tremulous", 'adj.', "Trembling, quivering, or shaking.").
word("tremulous", 'adj.', "Timid, hesitant; lacking confidence.").
word("trenchant", 'adj.', "Keen; biting; vigorously articulate and effective; severe.").
word("trenchant", 'adj.', "Fitted to trench or cut; gutting; sharp.").
word("trepidation", 'n.', "A fearful state; a state of concern or hesitation.").
word("trepidation", 'n.', "An involuntary trembling, sometimes an effect of paralysis, but usually caused by terror or fear; quaking; quivering.").
word("trestle", 'n.', "A horizontal member supported near each end by a pair of divergent legs, such as sawhorses.").
word("trestle", 'n.', "A framework, using spreading, divergent pairs of legs used to support a bridge.").
word("triad", 'n.', "On a CRT display, a group of three neighbouring phosphor dots, coloured green, red, and blue.").
word("triad", 'n.', "A grouping of three.").
word("tribune", 'n.', "The domed or vaulted apse in a Christian church that houses the bishop's throne.").
word("tribune", 'n.', "A protector of the people.").
word("trickery", 'n.', "An instance of deception, underhanded behavior, dressing up, imposture, artifice, etc.").
word("trickery", 'n.', "Artifice; the use of one or more stratagems.").
word("tricycle", 'n.', "A cycle with three wheels, powered by pedals and usually intended for young children.").
word("tricycle", 'n.', "A cycle rickshaw.").
word("trident", 'n.', "A three-pronged spear somewhat resembling a pitchfork.").
word("trident", 'n.', "A curve of third order of the form:").
word("triennial", 'adj.', "Happening every three years.").
word("triennial", 'adj.', "Lasting for three years.").
word("trimness", 'n.', "The property of being trim.").
word("trinity", 'n.', "The state of being three; independence of three things; things divided into three.").
word("trinity", 'n.', "A group or set of three people or things; three things combined into one.").
word("trio", 'n.', "A group of three people or things.").
word("trio", 'n.', "A group of three musicians.").
word("triple", 'adj.', "Designed for three users.").
word("triple", 'adj.', "Folded in three; composed of three layers.").
word("triplicate", 'adj.', "Made thrice as much; threefold; tripled.").
word("triplicity", 'n.', "The quality or state of being triple or threefold; trebleness.").
word("triplicity", 'n.', "The division of the twelve signs according to the four elements.").
word("tripod", 'n.', "A three-legged stand or mount.").
word("tripod", 'n.', "A fictional three-legged Martian war machine from H.G. Wells's novel The War of the Worlds (1897).").
word("trisect", 'v.', "To divide a quantity, angle etc into three equal parts").
word("trisect", 'v.', "To cut into three pieces").
word("trite", 'adj.', "Often in reference to a word or phrase: used so many times that it is commonplace, or no longer interesting or effective; worn out, hackneyed.").
word("trite", 'adj.', "So well established as to be beyond debate: trite law.").
word("triumvir", 'n.', "One member of a triumvirate").
word("trivial", 'adj.', "Ignorable; of little significance or value.").
word("trivial", 'adj.', "Commonplace, ordinary.").
word("troublesome", 'adj.', "Causing trouble or anxiety").
word("truculence", 'n.', "The state of being truculent; eagerness to fight; ferocity.").
word("truculent", 'adj.', "Eager or quick to argue, fight or start a conflict.").
word("truculent", 'adj.', "Cruel or savage.").
word("truism", 'n.', "A banality or cliché.").
word("truism", 'n.', "A self-evident or obvious truth.").
word("truthful", 'adj.', "Accurately depicting what is real.").
word("truthful", 'adj.', "Honest, and always telling the truth.").
word("turgid", 'adj.', "Distended beyond the natural state by some internal agent, especially fluid, or expansive force.").
word("turgid", 'adj.', "Overly complex and difficult to understand; grandiloquent; bombastic.").
word("turpitude", 'n.', "An act evident of such a depravity.").
word("turpitude", 'n.', "Inherent baseness, depravity or wickedness; corruptness and evilness.").
word("tutelage", 'n.', "The state of being under a guardian or a tutor; care or protection enjoyed.").
word("tutelage", 'n.', "The act of guarding, protecting, or guiding; guardianship; protection").
word("tutelar", 'adj.', "Serving as a guardian; protective; tutelary.").
word("tutorship", 'n.', "The duty of a tutor; tutelage").
word("twinge", 'n.', "A sudden sharp pain.").
word("twinge", 'n.', "A pinch; a tweak; a twitch.").
word("typical", 'adj.', "Characteristically representing something by form, group, idea or type.").
word("typical", 'adj.', "Capturing the overall sense of a thing.").
word("typify", 'v.', "To embody, exemplify; to represent by an image, form, model, or resemblance.").
word("typify", 'v.', "To serve as a typical or reference specimen of.").
word("typographical", 'adj.', "Pertaining to typography or printing.").
word("typographical", 'adj.', "Produced by typography; printed.").
word("typography", 'n.', "The appearance and style of typeset matter.").
word("typography", 'n.', "The art or practice of setting and arranging type; typesetting.").
word("tyrannical", 'adj.', "Despotic, oppressive or authoritarian.").
word("tyrannical", 'adj.', "Of, or relating to tyranny or a tyrant.").
word("tyranny", 'n.', "Absolute power, or its use.").
word("tyranny", 'n.', "A system of government in which power is exercised on behalf of the ruler or ruling class, without regard to the wishes of the governed.").
word("tyro", 'n.', "A beginner; a novice.").
word("ubiquitous", 'adj.', "Appearing to be everywhere at once; being or seeming to be in more than one location at the same time.").
word("ubiquitous", 'adj.', "Being everywhere at once: omnipresent.").
word("ulterior", 'adj.', "Situated beyond, or on the farther side.").
word("ulterior", 'adj.', "Being intentionally concealed so as to deceive.").
word("ultimate", 'adj.', "Incapable of further analysis; incapable of further division or separation; constituent; elemental.").
word("ultimate", 'adj.', "Last in a train of progression or consequences; tended toward by all that precedes; arrived at, as the last result; final.").
word("ultimatum", 'n.', "A final statement of terms or conditions made by one party to another, especially one that expresses a threat of reprisal or war.").
word("ultramontane", 'adj.', "From the other side of a mountain range, particularly the Alps.").
word("ultramontane", 'adj.', "Respecting the supremacy of the Pope.").
word("ultramundane", 'adj.', "Extraterrestrial; outside of earth or the universe").
word("ultramundane", 'adj.', "Extraordinary; abnormal").
word("umbrage", 'n.', "A feeling of anger or annoyance caused by something offensive.").
word("umbrage", 'n.', "Leaves that provide shade, as the foliage of trees.").
word("unaccountable", 'adj.', "Inexplicable; unable to account for, or explain.").
word("unaccountable", 'adj.', "Not responsible; free from accountability or control.").
word("unaffected", 'adj.', "Lacking pretense or affectation; natural.").
word("unaffected", 'adj.', "Not affected or changed.").
word("unanimity", 'n.', "The condition of agreement by all parties, the state of being unanimous.").
word("unanimous", 'adj.', "Sharing the same views or opinions, and being in harmony or accord.").
word("unanimous", 'adj.', "Based on unanimity, assent or agreement.").
word("unavoidable", 'adj.', "Impossible to avoid; bound to happen.").
word("unavoidable", 'adj.', "Not voidable; incapable of being made null or void.").
word("unbearable", 'adj.', "So unpleasant or painful as to be unendurable").
word("unbecoming", 'adj.', "Not in keeping with the expected standards of one's position.").
word("unbecoming", 'adj.', "Not flattering, attractive or appropriate.").
word("unbelief", 'n.', "An absence (or rejection) of belief, especially religious belief").
word("unbiased", 'adj.', "Impartial or without bias or prejudice.").
word("unbridled", 'adj.', "Without restraint or limit.").
word("unbridled", 'adj.', "Not fitted with a bridle.").
word("uncommon", 'adj.', "Rare; not readily found; unusual.").
word("uncommon", 'adj.', "Remarkable; exceptional.").
word("unconscionable", 'adj.', "Excessive, imprudent or unreasonable.").
word("unconscionable", 'adj.', "Not conscionable; unscrupulous and lacking principles or conscience.").
word("unconscious", 'adj.', "Not awake; having no awareness.").
word("unconscious", 'adj.', "Without directed thought or awareness.").
word("unction", 'n.', "A religious or ceremonial anointing.").
word("unction", 'n.', "A balm or something that soothes.").
word("unctuous", 'adj.', "Oily or greasy.").
word("unctuous", 'adj.', "Profusely polite, especially unpleasantly so and insincerely earnest.").
word("undeceive", 'v.', "To free from misconception, deception or error.").
word("undercharge", 'v.', "To charge less than the correct amount.").
word("undercharge", 'v.', "To put too small a charge into.").
word("undergarment", 'n.', "Any garment worn underneath others, especially one worn next to the skin; an item of underwear.").
word("undergarment", 'n.', "Temple garments worn by the followers of the Church of Jesus Christ of Latter-day Saints.").
word("underhanded", 'adj.', "Done by moving the hand (and arm) from below.").
word("underhanded", 'adj.', "Insincere; sarcastic.").
word("underlie", 'v.', "To serve as a basis of; form the foundation of.").
word("underlie", 'v.', "To be subject to; be liable to answer, as a charge or challenge.").
word("underling", 'n.', "A subordinate, or person of lesser rank or authority.").
word("underling", 'n.', "A low, wretched person.").
word("underman", 'v.', "To fail to provide with enough workers or crew.").
word("undermine", 'v.', "To erode the base or foundation of something, e.g. by the action of water.").
word("undermine", 'v.', "To weaken or work against; to hinder, sabotage.").
word("underrate", 'v.', "To underestimate; to make too low a rate or estimate").
word("undersell", 'v.', "To sell goods for a lower price than a competitor.").
word("undersell", 'v.', "To put forward an idea, or to market a new product, with insufficient enthusiasm.").
word("undersized", 'adj.', "Below the usual or expected size").
word("understate", 'v.', "To state a quantity that is too low.").
word("understate", 'v.', "To state (something) with less completeness than needed; to minimise or downplay.").
word("undervalue", 'v.', "To have too little regard for.").
word("undervalue", 'v.', "To underestimate, or assign too low a value to.").
word("underworld", 'n.', "That part of society that is engaged in crime or vice.").
word("underworld", 'n.', "The portion of a game that is set below ground.").
word("underwrite", 'v.', "To agree to pay by signing one's name; subscribe.").
word("underwrite", 'v.', "To support, lend support to, guarantee the basis of.").
word("undue", 'adj.', "Excessive; going beyond that what is natural or sufficient.").
word("undue", 'adj.', "That which ought not to be done; illegal; unjustified.").
word("undulate", 'v.', "To appear wavelike.").
word("undulate", 'v.', "To move in wavelike motions.").
word("undulous", 'adj.', "Undulating").
word("ungainly", 'adj.', "Clumsy; lacking grace.").
word("ungainly", 'adj.', "Difficult to move or to manage; unwieldy.").
word("unguent", 'n.', "Any cream containing medicinal ingredients applied to the skin for therapeutic purposes.").
word("unicellular", 'adj.', "Describing any microorganism that has a single cell").
word("unify", 'v.', "Become one.").
word("unify", 'v.', "Cause to become one; make into a unit; consolidate; merge; combine.").
word("unique", 'adj.', "Being the only one of its kind; unequaled, unparalleled or unmatched.").
word("unique", 'adj.', "Of a feature, such that only one holder has it.").
word("unison", 'n.', "The state of being in harmony or agreement; harmonious agreement or togetherness, synchronisation.").
word("unison", 'n.', "Identical pitch between two notes or sounds; the simultaneous playing of notes of identical pitch (or separated by one or more octaves).").
word("unisonant", 'adj.', "Of a single sound; producing the same sound.").
word("unitarian", 'adj.', "Espousing a unitary view of something").
word("univalence", 'n.', "The condition of being univalent").
word("unlawful", 'adj.', "Prohibited; not permitted by law (either civil or criminal law; see illegal).").
word("unlimited", 'adj.', "Limitless or without bounds; unrestricted").
word("unnatural", 'adj.', "Going against nature; perverse.").
word("unnatural", 'adj.', "Not natural.").
word("unnecessary", 'adj.', "Not needed or necessary.").
word("unnecessary", 'adj.', "Done in addition to requirements; unrequired.").
word("unsettle", 'v.', "To bring into disorder or disarray").
word("unsettle", 'v.', "To make upset or uncomfortable").
word("unsophisticated", 'adj.', "Not sophisticated; lacking sophistication.").
word("unspeakable", 'adj.', "Impossible to speak about.").
word("unspeakable", 'adj.', "Incapable of being spoken or uttered").
word("untimely", 'adj.', "At an inopportune time.").
word("untimely", 'adj.', "Early; premature.").
word("untoward", 'adj.', "Unfavourable, adverse, or disadvantageous.").
word("untoward", 'adj.', "Unruly, troublesome; not easily guided.").
word("unutterable", 'adj.', "Extremely bad or objectionable; unspeakable.").
word("unutterable", 'adj.', "Not utterable; incapable of being spoken or voiced").
word("unwieldy", 'adj.', "Difficult to carry, handle, manage or operate because of its size, weight, shape or complexity.").
word("unwieldy", 'adj.', "Badly managed or operated.").
word("unwise", 'adj.', "Not wise; lacking wisdom").
word("unyoke", 'v.', "To cease from labour.").
word("unyoke", 'v.', "To disconnect, unlink.").
word("upbraid", 'v.', "To object or urge as a matter of reproach").
word("upbraid", 'v.', "To charge with something wrong or disgraceful; to reproach").
word("upcast", 'n.', "The ventilating shaft of a mine out of which the air passes after having circulated through the mine.").
word("upcast", 'n.', "An upset, as from a carriage.").
word("upheaval", 'n.', "A sudden violent upset, disruption or convulsion.").
word("upheaval", 'n.', "Disruptive change, from one state to another.").
word("upheave", 'v.', "To heave or lift up; raise up or aloft.").
word("upheave", 'v.', "To lift or thrust something upward forcefully, or be similarly lifted or thrust upward.").
word("uppermost", 'adj.', "At or nearest the top of something.").
word("uproarious", 'adj.', "Characterized by loud, confused noise, or by noisy and uncontrollable laughter.").
word("uproot", 'v.', "Of oneself or someone: to move away from a familiar environment (for example, to live elsewhere).").
word("upturn", 'v.', "To turn (something) up or over").
word("urban", 'adj.', "Related to the (or any) city.").
word("urban", 'adj.', "Characteristic of city life.").
word("urbanity", 'n.', "Behaviour that is polished, refined, courteous.").
word("urbanity", 'n.', "What is characteristically urban in an area; urbanness.").
word("urchin", 'n.', "A neutron-generating device that triggered the nuclear detonation of the earliest plutonium atomic bombs.").
word("urchin", 'n.', "A mischievous child.").
word("urgency", 'n.', "Insistence, pressure").
word("urgency", 'n.', "The quality or condition of being urgent").
word("usage", 'n.', "Habit, practice.").
word("usage", 'n.', "Utilization.").
word("usurious", 'adj.', "Exorbitant.").
word("usurious", 'adj.', "Of or pertaining to usury.").
word("usurp", 'v.', "To take the place rightfully belonging to someone or something else.").
word("usurp", 'v.', "To use and assume the coat of arms of another person.").
word("usury", 'n.', "The practice of lending money at interest.").
word("usury", 'n.', "The practice of lending money at such rates.").
word("utilitarianism", 'n.', "A system of ethics based on the premise that something's value may be measured by its usefulness.").
word("utilitarianism", 'n.', "The theory that action should be directed toward achieving the \"greatest happiness for the greatest number of people\" (hedonistic universalism), or one of various related theories.").
word("utility", 'n.', "Something that is useful.").
word("utility", 'n.', "A software program designed to perform a single task or a small range of tasks, often to help manage and tune computer hardware, an operating system or application software.").
word("utmost", 'n.', "The greatest possible capability, extent, or quantity; maximum.").
word("vacate", 'v.', "To leave an area, usually as a result of orders from public authorities in the event of a riot or natural disaster.").
word("vacate", 'v.', "To leave an office or position.").
word("vaccinate", 'v.', "Treat with a vaccine to produce immunity against a disease.").
word("vacillate", 'v.', "To sway unsteadily from one side to the other; oscillate.").
word("vacillate", 'v.', "To swing indecisively from one course of action or opinion to another.").
word("vacuous", 'adj.', "Empty; void; lacking meaningful content.").
word("vacuous", 'adj.', "Showing a lack of thought or intelligence; vacant").
word("vacuum", 'n.', "A region of space that contains no matter.").
word("vacuum", 'n.', "An emptiness in life created by a loss of a person who was close, or of an occupation.").
word("vagabond", 'n.', "One who wanders from place to place, having no fixed dwelling, or not abiding in it, and usually without the means of honest livelihood.").
word("vagabond", 'n.', "A person on a trip of indeterminate destination and/or length of time.").
word("vagrant", 'n.', "An animal, typically a bird, found outside its species' usual range.").
word("vagrant", 'n.', "A person who wanders from place to place; a nomad, a wanderer.").
word("vainglory", 'n.', "Excessive vanity.").
word("vainglory", 'n.', "A regarding of oneself with undue favor.").
word("vale", 'n.', "A valley.").
word("valediction", 'n.', "A word or phrase (such as adieu or farewell) said upon leaving.").
word("valediction", 'n.', "The act of parting company.").
word("valedictorian", 'n.', "The individual in a graduating class who delivers the farewell or valedictory address, often the person who graduates with the highest grades.").
word("valedictorian", 'n.', "The individual in a graduating class who graduates with the highest grades.").
word("valedictory", 'n.', "An address given on an occasion of bidding farewell or parting company.").
word("valedictory", 'n.', "A speech given by a valedictorian at a commencement or graduation ceremony.").
word("valid", 'adj.', "Of an argument: whose conclusion is always true whenever its premises are true.").
word("valid", 'adj.', "Well grounded or justifiable, pertinent.").
word("valorous", 'adj.', "Having or displaying valour.").
word("vapid", 'adj.', "Offering nothing that is stimulating or challenging.").
word("vapid", 'adj.', "Lifeless, dull, or banal.").
word("vaporizer", 'n.', "A device with a heating element, used to vaporize a liquid solution with medicine. The produced vapor condensates into fine aerosols, forming a mist inside the device, to be inhaled by the patient for delivery of the medicine into the lungs.").
word("vaporizer", 'n.', "A device with a heating element, used to vaporize a liquid.").
word("variable", 'adj.', "Tending to deviate from a normal or recognized type.").
word("variable", 'adj.', "Likely to vary.").
word("variance", 'n.', "A difference between what is expected and what is observed; deviation.").
word("variance", 'n.', "An official permit to do something that is ordinarily forbidden by regulations.").
word("variant", 'n.', "Something that is slightly different from a type or norm.").
word("variant", 'n.', "One of a set of words or other linguistic forms that conveys the same meaning or serves the same function.").
word("variation", 'n.', "The modification of a hereditary trait.").
word("variation", 'n.', "A related but distinct thing.").
word("variegate", 'v.', "To change the appearance of something, especially by covering with patches or streaks of different colour.").
word("variegate", 'v.', "To dapple.").
word("vassal", 'n.', "The grantee of a fief, feud, or fee; one who keeps land of a superior, and who vows fidelity and homage to him, normally a lord of a manor; a feudatory; a feudal tenant.").
word("vassal", 'n.', "A subordinate").
word("vaudeville", 'n.', "An entertainment in this style.").
word("vaudeville", 'n.', "A style of multi-act theatrical entertainment which originated from France and flourished in Europe and North America from the 1880s through the 1920s.").
word("vegetal", 'adj.', "Capable of growth and reproduction, but not feeling or reason (often opposed to and ).").
word("vegetal", 'adj.', "Pertaining to vegetables or plants.").
word("vegetarian", 'n.', "A person who does not eat animal flesh, or, in some cases, use any animal products.").
word("vegetarian", 'n.', "An animal that eats only plants; a herbivore.").
word("vegetate", 'v.', "To live or spend a period of time in a dull, inactive, unchallenging way.").
word("vegetate", 'v.', "To spread abnormally.").
word("vegetation", 'n.', "Plants, taken collectively.").
word("vegetation", 'n.', "An abnormal verrucous or fibrinous growth").
word("vegetative", 'adj.', "Of or relating to plants; especially to their growth.").
word("vegetative", 'adj.', "Of or relating to functions such as growth, nutrition and asexual reproduction rather than sexual reproduction.").
word("vehement", 'adj.', "Showing strong feelings; passionate; forceful or intense.").
word("velocity", 'n.', "Rapidity of motion.").
word("velocity", 'n.', "The rate of occurrence.").
word("velvety", 'adj.', "Like velvet; soft, smooth, soothing.").
word("venal", 'adj.', "Corrupt, mercenary.").
word("venal", 'adj.', "Capable of being bought (of a person); willing to take bribes.").
word("vendible", 'adj.', "Salable; able to be bought, sold, or traded.").
word("vendition", 'n.', "The act of vending or selling; sale.").
word("vendor", 'n.', "A person or a company that vends or sells.").
word("vendor", 'n.', "A vending machine.").
word("veneer", 'n.', "A thin decorative covering of fine material (usually wood) applied to coarser wood or other material.").
word("veneer", 'n.', "An attractive appearance that covers or disguises true nature or feelings.").
word("venerable", 'adj.', "Made sacred especially by religious or historical association.").
word("venerable", 'adj.', "Commanding respect because of age, dignity, character or position.").
word("venerate", 'v.', "To revere or hold in awe.").
word("venerate", 'v.', "To treat with great respect and deference.").
word("venereal", 'adj.', "Of or relating to the genitals or sexual intercourse.").
word("venereal", 'adj.', "Pertaining to the astrological influence of the planet Venus; lascivious, lustful.").
word("venial", 'adj.', "Pardonable; able to be forgiven.").
word("venial", 'adj.', "Excusable; trifling").
word("venison", 'n.', "The meat of a deer.").
word("venison", 'n.', "The meat of an antelope.").
word("venom", 'n.', "A poison carried by an animal, usually injected into an enemy or prey by biting or stinging.").
word("venom", 'n.', "Feeling or speech marked by spite or malice; vitriol.").
word("venous", 'adj.', "Of or pertaining to veins.").
word("venous", 'adj.', "Having passed through the capillaries and given up oxygen for the tissues and become charged with carbon dioxide.").
word("veracious", 'adj.', "Truthful; speaking the truth.").
word("veracious", 'adj.', "True.").
word("veracity", 'n.', "Something that is true; a truthful statement; a truth.").
word("veracity", 'n.', "The quality of speaking or stating the truth; truthfulness.").
word("verbatim", 'adv.', "Word for word; in exactly the same words as were used originally.").
word("verbatim", 'adv.', "Orally; verbally.").
word("verbiage", 'n.', "The manner in which something is expressed in words.").
word("verbiage", 'n.', "Overabundance of words.").
word("verbose", 'adj.', "Containing or using more words than necessary; long-winded, wordy.").
word("verbose", 'adj.', "Producing detailed output for diagnostic purposes.").
word("verdant", 'adj.', "Green in colour.").
word("verdant", 'adj.', "Fresh.").
word("verification", 'n.', "The act of verifying.").
word("verification", 'n.', "The operation of testing the equation of a problem, to see whether it truly expresses the conditions of the problem.").
word("verify", 'v.', "To substantiate or prove the truth of something.").
word("verify", 'v.', "To confirm or test the truth or accuracy of something.").
word("verily", 'adv.', "Truly; doubtlessly; honestly; in truth.").
word("verily", 'adv.', "Confidently, certainly").
word("verity", 'n.', "A true statement; an established doctrine.").
word("verity", 'n.', "Truth, fact or reality, especially an enduring religious or ethical truth; veracity.").
word("vermin", 'n.', "Animals that prey on game, such as foxes or weasels.").
word("vermin", 'n.', "Any one of various common types of small insects or animals which cause harm and annoyance.").
word("vernacular", 'n.', "A language lacking standardization or a written form.").
word("vernacular", 'n.', "The language of a people or a national language.").
word("vernal", 'adj.', "Pertaining to or occurring in spring.").
word("vernal", 'adj.', "Having characteristics like spring; fresh, young, youthful.").
word("versatile", 'adj.', "Capable of taking either a penetrative (top) or receptive (bottom) role in anal sex.").
word("versatile", 'adj.', "Having varied uses or many functions.").
word("version", 'n.', "An eye movement involving both eyes moving synchronously and symmetrically in the same direction.").
word("version", 'n.', "A condition of the uterus in which its axis is deflected from its normal position without being bent upon itself. See anteversion and retroversion.").
word("vertex", 'n.', "The highest point, top or apex of something.").
word("vertex", 'n.', "A point in 3D space, usually given in terms of its Cartesian coordinates.").
word("vertical", 'adj.', "Standing, pointing, or moving straight up or down; parallel to the local direction of gravity; along the direction of a plumb line; perpendicular to something horizontal.").
word("vertical", 'adj.', "In a two-dimensional Cartesian co-ordinate system, describing the axis y oriented normal (perpendicular, at right angles) to the horizontal axis x.").
word("vertigo", 'n.', "The act of whirling round and round; rapid rotation.").
word("vertigo", 'n.', "A sensation of whirling and loss of balance, caused by looking down from a great height or by disease affecting the inner ear.").
word("vestige", 'n.', "A faint mark or visible sign left by something which is lost, or has perished, or is no longer present.").
word("vestige", 'n.', "A mark left on the earth by a foot.").
word("vestment", 'n.', "A robe, gown, or other article of clothing worn as an indication of office.").
word("vestment", 'n.', "Any of the special articles of clothing worn by members of the clergy etc., especially a garment worn at the celebration of the Eucharist.").
word("veto", 'n.', "An invocation of that right.").
word("veto", 'n.', "A political right to disapprove of (and thereby stop) the process of a decision, a law etc.").
word("vicarious", 'adj.', "Experienced or gained by taking in another person’s experience, rather than through first-hand experience, such as through watching or reading.").
word("vicarious", 'adj.', "On behalf of others.").
word("viceroy", 'n.', "One who governs a country, province, or colony as the representative of a monarch.").
word("viceroy", 'n.', "An orange and black North American butterfly ( ), so named because it is similar to, but smaller than, the monarch butterfly.").
word("vicissitude", 'n.', "Regular change or succession from one thing to another, or one part of a cycle to the next; alternation; mutual succession; interchange.").
word("vicissitude", 'n.', "A change, especially in one's life or fortunes.").
word("vie", 'v.', "To fight for superiority; to contend; to compete eagerly so as to gain something.").
word("vie", 'v.', "To stake a sum of money upon a hand of cards, as in the old game of gleek. See .").
word("vigilance", 'n.', "Alert watchfulness.").
word("vigilance", 'n.', "Close and continuous attention.").
word("vigilant", 'adj.', "Watchful, especially for danger or disorder; alert; wary").
word("vignette", 'n.', "Any small borderless picture in a book, especially an engraving, photograph, or the like, which vanishes gradually at the edge.").
word("vignette", 'n.', "A hardware deficiency (even occurring in most expensive models) of a computer display wherein the picture slants towards a colour or brightness towards the edges especially if viewed from an angle.").
word("vincible", 'adj.', "Capable of being defeated or overcome; assailable or vulnerable").
word("vindicate", 'v.', "To avenge; to punish").
word("vindicate", 'v.', "To liberate; to set free; to deliver.").
word("vindicative", 'adj.', "Vindictive, excessively vengeful.").
word("vindicative", 'adj.', "Vindicating, having a tendency to vindicate .").
word("vindicatory", 'adj.', "Promoting or producing retribution or punishment.").
word("vindicatory", 'adj.', "Promoting or producing vindication.").
word("vinery", 'n.', "A structure, usually enclosed with glass, for rearing and protecting vines; a grapery.").
word("vinery", 'n.', "A vineyard.").
word("viol", 'n.', "A large rope used to manipulate the anchor").
word("viol", 'n.', "A stringed instrument related to the violin family, but held in the lap between the legs like a cello, usually with C-holes, a flat back, a fretted neck and six strings, played with an underhanded bow hold").
word("viola", 'n.', "A stringed instrument of the violin family, somewhat larger than a violin, played under the chin, and having a deeper tone.").
word("viola", 'n.', "A 10-string steel-string acoustic guitar, used in Brazilian folk music.").
word("violation", 'n.', "The act or an instance of violating or the condition of being violated.").
word("violator", 'n.', "One who violates (a rule, a boundary, another person's body, etc.); offender").
word("violator", 'n.', "In the publishing and packaging industries, a visual element that intentionally \"violates\" the underlying design, such as a starburst, color bar or \"splat\" on a product package or magazine cover intended to attract special attention.").
word("virago", 'n.', "A woman given to undue belligerence or ill manner at the slightest provocation.").
word("virago", 'n.', "A woman who is rough, loud, and aggressive.").
word("virile", 'adj.', "Being manly; having characteristics associated with being male, such as strength; exhibiting masculine traits to an exaggerated degree such as strength, forcefulness or vigor.").
word("virile", 'adj.', "Pertaining to a grammatical gender used in plurals of some Slavic languages, corresponding to the personal masculine animate nouns.").
word("virtual", 'adj.', "In effect or essence, if not in fact or reality; imitated, simulated.").
word("virtual", 'adj.', "Having the power of acting or of invisible efficacy without the agency of the material or measurable part; potential.").
word("virtuoso", 'n.', "An expert in virtù or art objects and antiquities; a connoisseur.").
word("virtuoso", 'n.', "Specifically, a musician (or other performer) with masterly ability, technique, or personal style.").
word("virulence", 'n.', "A measure of how virulent a thing is.").
word("virulence", 'n.', "The state of being virulent.").
word("virulent", 'adj.', "Of animals, plants, or substances: extremely venomous or poisonous.").
word("virulent", 'adj.', "Extremely hostile or malicious; intensely acrimonious.").
word("visage", 'n.', "Countenance; appearance; one's face.").
word("viscount", 'n.', "Any of various nymphalid butterflies of the genus . Other butterflies in this genus are called earls and counts.").
word("viscount", 'n.', "A member of the peerage, above a baron but below a count or earl.").
word("vista", 'n.', "A distant view or prospect, especially one seen through some opening, avenue or passage.").
word("vista", 'n.', "A site offering such a view.").
word("visual", 'adj.', "That can be seen; visible.").
word("visual", 'adj.', "Related to or affecting the vision.").
word("vitality", 'n.', "Energy or vigour.").
word("vitality", 'n.', "That which distinguishes living from nonliving things; life, animateness.").
word("vitiate", 'v.', "To violate, to rape").
word("vitiate", 'v.', "To debase or morally corrupt").
word("vituperable", 'adj.', "Liable to, or deserving, vituperation or severe censure.").
word("vivacity", 'n.', "The quality or state of being vivacious.").
word("vivify", 'v.', "To bring to life; to enliven.").
word("vivify", 'v.', "To impart vitality.").
word("vivisection", 'n.', "The action of cutting, surgery or other invasive treatment of a living organism for the purposes of physiological or pathological scientific investigation.").
word("vocable", 'n.', "A word or utterance, especially with reference to its form rather than its meaning.").
word("vocable", 'n.', "A syllable or sound without specific meaning, used together with or in place of actual words in a song.").
word("vocative", 'adj.', "Used in address; appellative (said of that case or form of the noun, pronoun, or adjective, in which a person or thing is addressed). For example \"Domine, O Lord\"").
word("vocative", 'adj.', "Of or pertaining to calling; used in calling or vocation.").
word("vociferance", 'n.', "Vociferation; noise; clamor").
word("vociferate", 'v.', "To utter with a loud voice; to shout out.").
word("vociferate", 'v.', "To cry out with vehemence").
word("vociferous", 'adj.', "Making or characterized by a noisy outcry; clamorous.").
word("vogue", 'n.', "The prevailing fashion or style.").
word("vogue", 'n.', "A highly stylized modern dance that evolved out of the Harlem ballroom scene in the 1960s.").
word("volant", 'adj.', "Flying, or able to fly.").
word("volant", 'adj.', "Moving quickly or lightly, as though flying; nimble.").
word("volatile", 'adj.', "Having its associated memory immediately updated with any changes in value.").
word("volatile", 'adj.', "Fickle.").
word("volition", 'n.', "The mental power or ability of choosing; the will.").
word("volition", 'n.', "A concept that distinguishes whether or not the subject or agent intended something.").
word("volitive", 'adj.', "Of or pertaining the will or volition.").
word("volitive", 'adj.', "In the volitive; expressing a wish.").
word("voluble", 'adj.', "Fluent or having a ready flow of speech.").
word("voluble", 'adj.', "Easily rolling or turning; having a fluid, undulating motion.").
word("voluptuous", 'adj.', "Curvaceous and sexually attractive.").
word("voluptuous", 'adj.', "Suggestive of or characterized by full, generous, pleasurable sensation.").
word("voracious", 'adj.', "Wanting or devouring great quantities of food.").
word("voracious", 'adj.', "Having a great appetite for anything.").
word("vortex", 'n.', "A whirlwind, whirlpool, or similarly moving matter in the form of a spiral or column.").
word("vortex", 'n.', "A supposed collection of particles of very subtle matter, endowed with a rapid rotary motion around an axis which was also the axis of a sun or planet; part of a Cartesian theory accounting for the formation of the universe, and the movements of the bodies composing it.").
word("votary", 'adj.', "Consecrated by a vow or promise; consequent on a vow; devoted; promised.").
word("votive", 'adj.', "Dedicated or given in fulfillment of a vow or pledge").
word("votive", 'adj.', "Of, expressing, or symbolizing a vow. Often used to describe thick cylindrical candles found in many churches, lit when making a private vow or asking a private intention.").
word("vulgarity", 'n.', "An offensive or obscene act or expression.").
word("vulgarity", 'n.', "The quality of being vulgar.").
word("vulnerable", 'adj.', "More or most likely to be exposed to the chance of being attacked or harmed, either physically or emotionally.").
word("vulnerable", 'adj.', "More likely to be exposed to malicious programs or viruses.").
word("waif", 'n.', "Something (such as clouds or smoke) carried aloft by the wind.").
word("waif", 'n.', "A small flag used as a signal.").
word("waistcoat", 'n.', "An ornamental garment worn under a doublet.").
word("waistcoat", 'n.', "A sleeveless, collarless garment worn over a shirt and under a suit jacket.").
word("waive", 'v.', "To abandon, give up (someone or something).").
word("waive", 'v.', "To relinquish (a right etc.); to give up claim to; to forgo.").
word("wampum", 'n.', "Small beads made from polished shells, especially white ones, formerly used as money and jewelry by certain Native American peoples.").
word("wampum", 'n.', "A string of such beads.").
word("wane", 'v.', "To decrease physically in size, amount, numbers or surface.").
word("wane", 'v.', "Said of the Moon as it passes through the phases of its monthly cycle where its surface is less and less visible.").
word("wantonness", 'n.', "The state or characteristic of being wanton; recklessness, especially as represented in lascivious or other excessive behavior.").
word("wantonness", 'n.', "A particular wanton act.").
word("warlike", 'adj.', "Hostile and belligerent.").
word("warlike", 'adj.', "Martial, bellicose or militaristic.").
word("wavelet", 'n.', "A small wave; a ripple.").
word("wavelet", 'n.', "A fast-decaying oscillation.").
word("weal", 'n.', "Boon, benefit.").
word("weal", 'n.', "Specifically, the general happiness of a community, country etc. (often with qualifying word).").
word("wean", 'v.', "To cease giving breast milk to an offspring; to accustom and reconcile (a child or young animal) to a want or deprivation of mother's milk; to take from the breast or udder.").
word("wean", 'v.', "To cease to depend on the mother's milk for nutrition.").
word("wearisome", 'adj.', "Tiresome, tedious or causing fatigue.").
word("wee", 'adj.', "Small, little.").
word("whereabouts", 'n.', "Location; where something is situated.").
word("whereabouts", 'n.', "Information about an elite athlete's future whereabouts, supplied to anti-doping authorities to facilitate random out-of-competition testing").
word("wherever", 'adv.', "In, at or to any place that one likes or chooses.").
word("wherever", 'adv.', "The place (no matter where) in, at or to which.").
word("wherewith", 'n.', "Something with which; the means by which.").
word("whet", 'v.', "To stimulate or make more keen.").
word("whet", 'v.', "To preen.").
word("whimsical", 'adj.', "Given to whimsy.").
word("whine", 'v.', "To utter a high-pitched cry.").
word("whine", 'v.', "To make a sound resembling such a cry.").
word("wholly", 'adv.', "Completely and entirely; to the fullest extent.").
word("wholly", 'adv.', "Exclusively and solely.").
word("wield", 'v.', "To handle with skill and ease, especially a weapon or tool.").
word("wield", 'v.', "To exercise (authority or influence) effectively.").
word("wile", 'n.', "A trick or stratagem practiced for ensnaring or deception; a sly, insidious artifice").
word("winsome", 'adj.', "Charming, engaging, winning; inspiring approval and trust, especially if in an innocent manner.").
word("wintry", 'adj.', "Of precipitation, containing sleet or snow.").
word("wintry", 'adj.', "Aged, white-haired.").
word("wiry", 'adj.', "Thin, muscular and flexible.").
word("witchcraft", 'n.', "The practice of witches; magic, sorcery or the use of supernatural powers to influence or predict events.").
word("witchcraft", 'n.', "Something, such as an advanced technology, that seems almost magical.").
word("witless", 'adj.', "Lacking wit or understanding").
word("witless", 'adj.', "Indiscreet; not using clear and sound judgment.").
word("witling", 'n.', "A person who feigns wit, pretending or aspiring to be witty.").
word("witling", 'n.', "A person with very little wit.").
word("witticism", 'n.', "A witty remark").
word("wittingly", 'adv.', "In a witting manner, intentionally, on purpose").
word("wizen", 'v.', "To wither; to become, or make, lean and wrinkled by shrinkage, as from age or illness.").
word("workmanlike", 'adj.', "Performed with the skill of an artisan or craftsman.").
word("workmanlike", 'adj.', "Done competently but without flair.").
word("workmanship", 'n.', "The skill of an artisan or craftsman.").
word("workmanship", 'n.', "The quality of something made by an artisan or craftsman.").
word("wrangle", 'v.', "To bicker, or quarrel angrily and noisily.").
word("wrangle", 'v.', "To involve in a quarrel or dispute; to embroil.").
word("wreak", 'v.', "To inflict or take vengeance on.").
word("wreak", 'v.', "To cause harm; to afflict; to inflict; to harm or injure; to let out harm.").
word("wrest", 'v.', "To obtain by pulling or violent force.").
word("wrest", 'v.', "To pull or twist violently.").
word("wretchedness", 'n.', "A state of prolonged misfortune, privation or anguish.").
word("wretchedness", 'n.', "An unhappy state of mental or physical suffering.").
word("writhe", 'v.', "To twist or contort the body; to be distorted.").
word("writhe", 'v.', "To contort (a part of the body).").
word("writing", 'n.', "Graphism of symbols such as letters that express some meaning.").
word("writing", 'n.', "The process of representing a language with symbols or letters.").
word("wry", 'adj.', "Deviating from the right direction; misdirected; out of place.").
word("wry", 'adj.', "Turned away, contorted (of the face or body).").
word("yearling", 'n.', "An animal that is between one and two years old; one that is in its second year (but not yet two full years old).").
word("yearling", 'n.', "A racehorse that is considered to be one year old until a subsequent January 1st.").
word("zealot", 'n.', "A member of a radical, warlike, ardently patriotic group of Jews in Judea, particularly prominent in the first century, who advocated the violent overthrow of Roman rule and vigorously resisted the efforts of the Romans and their supporters to convert the Jews.").
word("zealot", 'n.', "A member of an anti-aristocratic political group in Thessalonica from 1342 until 1350.").
word("zeitgeist", 'n.', "The spirit of the age; the taste, outlook, and spirit characteristic of a period.").
word("zenith", 'n.', "The point in the sky vertically above a given position or observer; the point in the celestial sphere opposite the nadir.").
word("zenith", 'n.', "Highest point or state; peak.").
word("zephyr", 'n.', "Any light refreshing wind; a gentle breeze.").
word("zephyr", 'n.', "Anything of fine, soft, or light quality, especially fabric.").
word("zodiac", 'n.', "The belt-like region of the celestial sphere approximately eight degrees north and south of the ecliptic which include the apparent path of the sun, moon, and visible planets.").
word("zodiac", 'n.', "The ecliptic: the belt-like region of the celestial sphere corresponding to the apparent path of the sun over the course of a year.").
