/** <module> Quiz program

@author Douglas S. Green
@license GPL
*/
module(quiz,
    [
        check_cards/0,
        list_decks/0,
        play/0,
        play/1
    ]).

%! check_cards
% Check the subjects to see if there are any subjects that don't have cards or any cards that don't have subjects, and
% check for cards that have duplicate front.
check_cards :-
    setof(Name, (subject(_, Name, _), \+ card(Name, _, _)), Subjects),
    format("Here's a list of subjects that don't have cards:~n~n"),
    writeln(Subjects),
    fail.
check_cards :-
    setof(Name, (card(Name, _, _), \+ subject(_, Name, _)), Subjects),
    format("Here's a list of card subjects that don't have subjects defined:~n~n"),
    writeln(Subjects),
    fail.
check_cards :-
    setof((Name, Front), Back^Back1^(card(Name, Front, Back), card(Name, Front, Back1), Back \= Back1), Subjects),
    format("Here's a list of cards that have duplicate front:~n~n"),
    writeln(Subjects),
    fail.
check_cards :- !.

%! play
% Pick a random deck to study.
play :- play(_, _).

%! play(?Cat:atom)
% Provide the name of a category to study or one will be picked at random.
play(Cat) :-
    play(Cat, _).

%! play(?Cat:atom, ?Name:atom)
% Provide the name of a category or deck to study or one will be picked at random.
play(Cat, Name) :-
    format("Quiz Program. Use Q to quit.~n~n"),
    pick_subject(Cat, Name, Desc),
    setof((Term, Def), card(Name, Term, Def), Defs),
    length(Defs, N),
    format("Subject: ~w~nCards: ~d~n~n", [Desc, N]),
    random_permutation(Defs, ShuffledDefs),
    ask(ShuffledDefs).
play(_, _) :- !.

%! ask(Questions:list)
ask([(Q, A)|Qs]) :-
    writeln(Q),
    get_single_char(Code),
    to_lower(Code, LowCode),
    char_code(LowChar, LowCode),
    (
        LowChar = 'q',
        writeln("Bye!"),
        !;
        writeln(A),
        nl,
        ask(Qs)
    ).

%! list_decks
% List the decks and their descriptions.
list_decks :-
    format("Here's a list of the deck names and descriptions:~n~n"),
    subject(Cat, Name, Desc),
    format("* ~w/~w: ~w\n", [Cat, Name, Desc]),
    fail.

%! pick_subject(Cat:atom, Name:atom, Desc:string)
pick_subject(Cat, Name, Desc) :-
    var(Cat),
    var(Name),
    setof((Cat1, Name1, Desc1), subject(Cat1, Name1, Desc1), Subjects),
    length(Subjects, N),
    R is random(N),
    nth0(R, Subjects, (Cat, Name, Desc)).
pick_subject(Cat, Name, Desc) :-
    atom(Cat),
    var(Name),
    setof((Cat, Name1, Desc1), subject(Cat, Name1, Desc1), Subjects),
    length(Subjects, N),
    R is random(N),
    nth0(R, Subjects, (Cat, Name, Desc)).
pick_subject(Cat, Name, Desc) :-
    atom(Name),
    subject(Cat, Name, Desc).
pick_subject(Cat, Name, Desc) :-
    atom(Name),
    \+ subject(Cat, Name, Desc),
    format("There's no deck by that name.~n~n"),
    list_decks.

%! subject(Name:atom, Desc:string)
subject(art, baroque_paintings, "Baroque paintings and the artists who created them").
subject(art, paintings, "Paintings and the artists who created them").
subject(art, romanticism_paintings, "Romanticism paintings and the artists who created them").
subject(art, sculptures, "Sculptures and the artists who created them").
subject(astronomy, moons, "Moons and the planets that they orbit around").
subject(literature, fiction_books, "Fictional books and authors").
subject(literature, nonfiction_books, "Nonfictional books and authors").
subject(literature, poets, "Poems and the poets who wrote them").
subject(math, combinations, "Calculated values of combinations").
subject(math, factorials, "Calculated values of factorials").
subject(math, permutations, "Calculated values of permutations").
subject(math, powers, "Calculated values of powers").
subject(math, products, "Calculated values of products").
subject(math, square_roots, "Calculated values of square_roots").
subject(math, sums, "Calculated values of sums").
subject(movies, actor_roles, "Movie roles and the actors who played them").
subject(movies, actress_roles, "Movie roles and the actresses who played them").
subject(music, song_titles, "Pop and rock song titles and bands").
subject(mythology, greek_and_roman_gods, "The names of Greek gods and goddesses and their roman equivalents").
subject(mythology, greek_gods, "The names of Greek gods and goddesses and their domains").
subject(philosophy, ethics, "Ethical terms and definitions, most of which were adapted from Wiktionary").
subject(programming, git_commands, "Git commands with definitions taken from the documentation").
subject(programming, laws_of_computing, "General laws of computing as defined in Wikipedia").
subject(programming, perl_regexp, "Perl-compatible regular expressions").
subject(programming, phpdoc_params, "PHPDoc parameters used in tags").
subject(programming, prolog_library, "SWI Prolog libraries (see https://www.swi-prolog.org/pldoc/man?section=libpl)").
subject(programming, prolog_predicates, "SWI Prolog predicates (see https://www.swi-prolog.org/pldoc/doc_for?object=manual)").
subject(reference, acronyms, "Acronyms and the terms that they expand into").
subject(reference, latin_phrases, "A list of phrases in Latin and the English translation").
subject(reference, phonetic_alphabet, "NATO Phonetic Alphabet").
subject(spanish, spanish_vocabulary, "Translations from English to Spanish").
subject(united_states, state_abbreviations, "Two-letter abbreviations for states of the United States").
subject(united_states, state_capitals, "State capitals of the USA").

%! card(Name:atom, Question:string, Answer:string)
card(acronyms, "AAAS", "American Association for the Advancement of Science").
card(acronyms, "AAC", "Advanced Audio Coding").
card(acronyms, "ABC", "Atanasoff-Berry Computer").
card(acronyms, "AC", "Asheron's Call").
card(acronyms, "ACE", "access control entry").
card(acronyms, "ACL", "access control list").
card(acronyms, "ACM", "Association for Computing Machinery").
card(acronyms, "ACPI", "Advanced Configuration and Power Interface").
card(acronyms, "AD", "Active Directory").
card(acronyms, "ADC", "analog-to-digital").
card(acronyms, "ADD", "attention deficit disorder").
card(acronyms, "ADHD", "attention deficit hyperactivity disorder").
card(acronyms, "ADO", "ActiveX Data Object").
card(acronyms, "ADSL", "asymmetric digital subscriber line").
card(acronyms, "ADSM", "ADSTAR Distributed Storage Management").
card(acronyms, "AES", "Advanced Encryption Standard").
card(acronyms, "AF", "autofocus").
card(acronyms, "AFK", "Away From Keyboard").
card(acronyms, "AFL", "American Football League").
card(acronyms, "AGP", "accelerated graphics port").
card(acronyms, "AHCI", "Advanced Host Controller Interface").
card(acronyms, "AI", "artificial intelligence").
card(acronyms, "AIDS", "acquired immune deficiency syndrome").
card(acronyms, "AIM", "AOL Instant Messenger").
card(acronyms, "AIX", "advanced interactive executive").
card(acronyms, "AJAX", "Asynchronous JavaScript and XML").
card(acronyms, "AKA", "also known as").
card(acronyms, "ALGOL", "algorithmic language").
card(acronyms, "ALU", "arithmetic logic unit").
card(acronyms, "AMA", "ask me anything").
card(acronyms, "ANI", "automatic number identification").
card(acronyms, "ANSI", "American National Standards Institute").
card(acronyms, "AOSP", "Android Open Source Project").
card(acronyms, "APA", "American Psychological Association").
card(acronyms, "API", "application programming interface").
card(acronyms, "AR", "augmented reality").
card(acronyms, "ARP", "Address Resolution Protocol").
card(acronyms, "ARPA", "Advanced Research Projects Agency").
card(acronyms, "ARPANET", "Advanced Research Projects Agency Network").
card(acronyms, "ARQ", "automatic repeat request").
card(acronyms, "AS", "autonomous system").
card(acronyms, "ASAP", "as soon as possible").
card(acronyms, "ASCII", "American Standard Code for Information Interchange").
card(acronyms, "ASME", "American Society of Mechanical Engineers").
card(acronyms, "ASN", "autonomous system number").
card(acronyms, "ASR", "automatic speech recognition").
card(acronyms, "AT", "advanced technology").
card(acronyms, "ATA", "Advanced Technology Attachment").
card(acronyms, "ATM", "automated teller machine").
card(acronyms, "AUI", "Attachment Unit Interface").
card(acronyms, "AUP", "acceptable use policy").
card(acronyms, "AVC", "Advanced Video Coding").
card(acronyms, "AVI", "Audio Video Interleaved").
card(acronyms, "AWOL", "absent without leave").
card(acronyms, "AWS", "Amazon Web Services").
card(acronyms, "Alpha", "alphabet").
card(acronyms, "App", "application").
card(acronyms, "Arg", "argument").
card(acronyms, "Auto", "autonomous").
card(acronyms, "BB", "broadband").
card(acronyms, "BBS", "bulletin board system").
card(acronyms, "BC", "before Christ").
card(acronyms, "BCD", "binary-coded decimal").
card(acronyms, "BCNF", "Boyce-Codd normal form").
card(acronyms, "BCPL", "Basic Combined Programming Language").
card(acronyms, "BDC", "backup domain controller").
card(acronyms, "BER", "bit error rate").
card(acronyms, "BGP", "Border Gateway Protocol").
card(acronyms, "BHO", "Browser Helper Object").
card(acronyms, "BIND", "Berkeley Internet Name Domain").
card(acronyms, "BIO", "biography").
card(acronyms, "BIOS", "basic input/output system").
card(acronyms, "BOFH", "Bastard Operator From Hell").
card(acronyms, "BOINC", "Berkeley Open Infrastructure for Network Computing").
card(acronyms, "BRI", "basic rate interface").
card(acronyms, "BSS", "basic service set").
card(acronyms, "BTC", "bitcoin").
card(acronyms, "Bit", "binary digit").
card(acronyms, "Bps", "bytes per second").
card(acronyms, "C", "Celsius").
card(acronyms, "CA", "certificate authority").
card(acronyms, "CAD", "computer-aided design").
card(acronyms, "CAPTCHA", "Completely Automated Public Turing Test to tell Computers and Humans Apart").
card(acronyms, "CAT", "Central Africa Time").
card(acronyms, "CBT", "computer-based training").
card(acronyms, "CCD", "charge-coupled device").
card(acronyms, "CCNP", "Cisco Certified Network Professional").
card(acronyms, "CD", "compact disc").
card(acronyms, "CDC", "Centers for Disease Control and Prevention").
card(acronyms, "CDDI", "Copper Distributed Data Interface").
card(acronyms, "CDE", "Common Desktop Environment").
card(acronyms, "CDMA", "code division multiple access").
card(acronyms, "CDN", "content distribution network").
card(acronyms, "CDP", "continuous data protection").
card(acronyms, "CEO", "chief executive officer").
card(acronyms, "CERT", "Computer Emergency Response Team").
card(acronyms, "CES", "Consumer Electronics Show").
card(acronyms, "CF", "CompactFlash").
card(acronyms, "CGI", "computer-generated imagery").
card(acronyms, "CI", "continuous integration").
card(acronyms, "CIA", "Central Intelligence Agency").
card(acronyms, "CIDR", "classless inter-domain routing").
card(acronyms, "CIFS", "common Internet file system").
card(acronyms, "CIM", "common information model").
card(acronyms, "CISC", "complex instruction set computer").
card(acronyms, "CISSP", "Certified Information Systems Security Professional").
card(acronyms, "CLI", "command-line interface").
card(acronyms, "CLOS", "Common Lisp object system").
card(acronyms, "CLR", "common language runtime").
card(acronyms, "CMOS", "complementary metal-oxide semiconductor").
card(acronyms, "CMS", "content management system").
card(acronyms, "CO", "central office").
card(acronyms, "COBOL", "Common Business Oriented Language").
card(acronyms, "COPPA", "Children's Online Privacy Protection Act").
card(acronyms, "CPAN", "comprehensive Perl archive network").
card(acronyms, "CPI", "characters per inch").
card(acronyms, "CPL", "Corporal").
card(acronyms, "CPM", "cost per thousand").
card(acronyms, "CPS", "Child Protective Services").
card(acronyms, "CPU", "central processing unit").
card(acronyms, "CR", "carriage return").
card(acronyms, "CRC", "cyclic redundancy check").
card(acronyms, "CRM", "customer relationship management").
card(acronyms, "CRT", "cathode ray tube").
card(acronyms, "CS", "customer service").
card(acronyms, "CSI", "Crime Scene Investigation").
card(acronyms, "CSNET", "computer science network").
card(acronyms, "CSR", "corporate social responsibility").
card(acronyms, "CSS", "Content Scramble System").
card(acronyms, "CSV", "comma-separated values").
card(acronyms, "CTO", "technology officer").
card(acronyms, "CTS", "Clear to Send").
card(acronyms, "CUPS", "Common Unix Printing System").
card(acronyms, "CUT", "Coordinated Universal Time").
card(acronyms, "CVS", "Concurrent Version System").
card(acronyms, "Char", "character").
card(acronyms, "Code", "source code").
card(acronyms, "Con", "console").
card(acronyms, "Core", "core dump").
card(acronyms, "Ctrl", "control key").
card(acronyms, "D", "depth").
card(acronyms, "DAC", "discretionary access control").
card(acronyms, "DAG", "directed acyclic graph").
card(acronyms, "DARE", "Drug Abuse Resistance Education").
card(acronyms, "DARPA", "Defense Advanced Research Projects Agency").
card(acronyms, "DASD", "direct access storage device").
card(acronyms, "DAT", "Digital Audio Tape").
card(acronyms, "DAW", "digital audio workstation").
card(acronyms, "DB", "database").
card(acronyms, "DBA", "doing business as").
card(acronyms, "DBMS", "database management system").
card(acronyms, "DCE", "distributed computing environment").
card(acronyms, "DCOM", "Distributed Component Object Model").
card(acronyms, "DDBMS", "distributed database management system").
card(acronyms, "DDE", "doctrine of double effect; Dynamic Data Exchange").
card(acronyms, "DDK", "driver development kit").
card(acronyms, "DDL", "data definition language").
card(acronyms, "DDR", "double data rate").
card(acronyms, "DDS", "Digital Data Storage").
card(acronyms, "DDoS", "Distributed Denial of Service").
card(acronyms, "DEA", "data encryption algorithm").
card(acronyms, "DEC", "Digital Equipment Corporation").
card(acronyms, "DES", "Data Encryption Standard").
card(acronyms, "DHCP", "Dynamic Host Configuration Protocol").
card(acronyms, "DID", "direct inward dialing").
card(acronyms, "DIME", "direct Internet message encapsulation").
card(acronyms, "DIMM", "dual in-line memory module").
card(acronyms, "DIP", "dual in-line package").
card(acronyms, "DIY", "Do It Yourself").
card(acronyms, "DKNF", "domain-key normal form").
card(acronyms, "DLC", "downloadable content").
card(acronyms, "DLL", "dynamic-link library").
card(acronyms, "DLT", "digital linear tape").
card(acronyms, "DMA", "direct memory access").
card(acronyms, "DMCA", "Digital Millennium Copyright Act").
card(acronyms, "DMI", "Desktop Management Interface").
card(acronyms, "DML", "data manipulation language").
card(acronyms, "DMTF", "Distributed Management Task Force").
card(acronyms, "DMZ", "demilitarized zone").
card(acronyms, "DNC", "Democratic National Committee").
card(acronyms, "DNS", "domain name system").
card(acronyms, "DOD", "Department of Defense").
card(acronyms, "DON", "Department of the Navy").
card(acronyms, "DOS", "disk operating system").
card(acronyms, "DPI", "dots per inch").
card(acronyms, "DPMI", "DOS Protected Mode Interface").
card(acronyms, "DPS", "damage per second").
card(acronyms, "DRAM", "dynamic random access memory").
card(acronyms, "DRM", "digital rights management").
card(acronyms, "DRY", "Don't Repeat Yourself").
card(acronyms, "DSL", "digital subscriber line; domain specific language").
card(acronyms, "DSO", "data source object").
card(acronyms, "DSP", "digital signal processor").
card(acronyms, "DSR", "Dynamic Source Routing").
card(acronyms, "DSS", "Digital Signature Standard").
card(acronyms, "DTR", "data terminal ready").
card(acronyms, "DVD", "digital versatile disc").
card(acronyms, "DVI", "digital visual interface").
card(acronyms, "DVR", "digital video recorder").
card(acronyms, "DZ", "drop zone").
card(acronyms, "DoS", "denial of service").
card(acronyms, "E", "Enlightenment").
card(acronyms, "EA", "Electronic Arts").
card(acronyms, "EAI", "enterprise application integration").
card(acronyms, "EAP", "Extensible Authentication Protocol").
card(acronyms, "EBCDIC", "Extended Binary Coded Decimal Interchange Code").
card(acronyms, "ECC", "error-correcting code").
card(acronyms, "EDA", "electronic design automation").
card(acronyms, "EDI", "electronic data interchange").
card(acronyms, "EDO", "extended data out").
card(acronyms, "EDP", "electronic data processing").
card(acronyms, "EDSAC", "Electronic Delay Storage Automatic Calculator").
card(acronyms, "EDVAC", "Electronic Discrete Variable Automatic Computer").
card(acronyms, "EEPROM", "electrically erasable programmable read-only memory").
card(acronyms, "EFI", "extensible firmware interface").
card(acronyms, "EFS", "Encrypting File System").
card(acronyms, "EHCI", "enhanced host controller interface").
card(acronyms, "EIDE", "enhanced integrated drive electronics").
card(acronyms, "EIGRP", "Enhanced Interior Gateway Routing Protocol").
card(acronyms, "ELF", "extremely low frequency").
card(acronyms, "EM", "emphasized").
card(acronyms, "EMF", "enhanced metafile").
card(acronyms, "ENIAC", "Electronic Numerical Integrator and Calculator").
card(acronyms, "EOF", "end-of-file").
card(acronyms, "EPIC", "Electronic Privacy Information Center").
card(acronyms, "EPP", "Enhanced Parallel Port").
card(acronyms, "EPROM", "erasable programmable read-only memory").
card(acronyms, "EPS", "encapsulated PostScript").
card(acronyms, "ESA", "Entertainment Software Association").
card(acronyms, "ESCD", "Extended System Configuration Data").
card(acronyms, "ESL", "English As A Second Language").
card(acronyms, "ESRB", "Entertainment Software Rating Board").
card(acronyms, "EST", "Eastern Standard Time").
card(acronyms, "ETA", "Estimated Time of Arrival").
card(acronyms, "Eval", "evaluate").
card(acronyms, "F", "fahrenheit").
card(acronyms, "FAQ", "Frequently Asked Questions").
card(acronyms, "FAT", "file allocation table").
card(acronyms, "FBI", "Federal Bureau of Investigation").
card(acronyms, "FCC", "Federal Communications Commission").
card(acronyms, "FCIP", "Fibre Channel over IP").
card(acronyms, "FDDI", "Fiber Distributed Data Interface").
card(acronyms, "FIFO", "first in, first out").
card(acronyms, "FIPS", "Federal Information Processing Standards").
card(acronyms, "FM", "frequency modulation").
card(acronyms, "FOIA", "Freedom of Information Act").
card(acronyms, "FORTRAN", "Formula Translation").
card(acronyms, "FPGA", "field-programmable gate array").
card(acronyms, "FPM", "fast page mode").
card(acronyms, "FPS", "frames per second").
card(acronyms, "FPU", "floating-point unit").
card(acronyms, "FQDN", "fully qualified domain name").
card(acronyms, "FRAM", "Ferroelectric RAM").
card(acronyms, "FS", "file system").
card(acronyms, "FTC", "Federal Trade Commission").
card(acronyms, "FTP", "File Transfer Protocol").
card(acronyms, "FYI", "For Your Information").
card(acronyms, "Famicom", "family computer").
card(acronyms, "Feat", "feature").
card(acronyms, "Flash", "Adobe Flash").
card(acronyms, "Fn", "function").
card(acronyms, "GBIC", "gigabit interface converter").
card(acronyms, "GCC", "GNU Compiler Collection").
card(acronyms, "GCHQ", "Government Communications Headquarters").
card(acronyms, "GDPR", "General Data Protection Regulation").
card(acronyms, "GFS", "Google File System").
card(acronyms, "GHz", "gigahertz").
card(acronyms, "GIF", "Graphics Interchange Format").
card(acronyms, "GIMP", "GNU image manipulation program").
card(acronyms, "GIS", "Geographic Information System").
card(acronyms, "GNU", "GNU's Not Unix").
card(acronyms, "GPF", "general protection fault").
card(acronyms, "GPG", "GNU Privacy Guard").
card(acronyms, "GPL", "general public license").
card(acronyms, "GPO", "Group Policy Object").
card(acronyms, "GPRS", "General Packet Radio Service").
card(acronyms, "GPS", "Global Positioning System").
card(acronyms, "GPT", "GUID partition table").
card(acronyms, "GPU", "graphics processing unit").
card(acronyms, "GRUB", "GRand Unified Bootloader").
card(acronyms, "GSM", "Global System for Mobile communication").
card(acronyms, "GTA", "Grand Theft Auto").
card(acronyms, "GUI", "graphical user interface").
card(acronyms, "GUID", "globally unique identifier").
card(acronyms, "Gbps", "gigabits per second").
card(acronyms, "Gmail", "Google Mail").
card(acronyms, "Gzip", "GNU zip").
card(acronyms, "H", "height").
card(acronyms, "HAL", "hardware abstraction layer").
card(acronyms, "HBA", "host bus adapter").
card(acronyms, "HD", "high-density").
card(acronyms, "HDD", "hard disk drive").
card(acronyms, "HDLC", "high-level data link control").
card(acronyms, "HDMI", "High-Definition Multimedia Interface").
card(acronyms, "HDML", "handheld device markup language").
card(acronyms, "HDSL", "high-bit-rate digital subscriber line").
card(acronyms, "HEVC", "high efficiency video coding").
card(acronyms, "HFC", "hybrid fiber coax").
card(acronyms, "HFS", "hierarchical file system").
card(acronyms, "HIV", "human immunodeficiency virus").
card(acronyms, "HP", "hit points").
card(acronyms, "HR", "Human Resources").
card(acronyms, "HRW", "Human Rights Watch").
card(acronyms, "HSSI", "High-Speed Serial Interface").
card(acronyms, "HTML", "Hypertext Markup Language").
card(acronyms, "HTTP", "Hypertext Transfer Protocol").
card(acronyms, "Hz", "Hertz").
card(acronyms, "IAB", "Internet Architecture Board").
card(acronyms, "IANA", "Internet Assigned Numbers Authority").
card(acronyms, "IAP", "Internet access provider").
card(acronyms, "ICANN", "Internet Corporation for Assigned Names and Numbers").
card(acronyms, "ICCPR", "International Covenant on Civil and Political Rights").
card(acronyms, "ICMP", "Internet Control Message Protocol").
card(acronyms, "ID", "identification").
card(acronyms, "IDE", "integrated device electronics").
card(acronyms, "IDEA", "International Data Encryption Algorithm").
card(acronyms, "IDS", "intrusion detection system").
card(acronyms, "IE", "Internet Explorer").
card(acronyms, "IEEE", "Institute of Electrical and Electronics Engineers").
card(acronyms, "IETF", "Internet engineering task force").
card(acronyms, "IFIP", "International Federation for Information Processing").
card(acronyms, "IGMP", "Internet Group Management Protocol").
card(acronyms, "IGP", "Interior Gateway Protocol").
card(acronyms, "IIS", "Internet Information Server").
card(acronyms, "IM", "instant messenger").
card(acronyms, "IMAP", "Internet Message Access Protocol").
card(acronyms, "IMDb", "Internet Movie Database").
card(acronyms, "IMEI", "International Mobile Equipment Identity").
card(acronyms, "IMSI", "international mobile subscriber identity").
card(acronyms, "INC", "incorporated").
card(acronyms, "INCITS", "International Committee for Information Technology Standards").
card(acronyms, "IP", "Internet Protocol").
card(acronyms, "IPC", "interprocess communication").
card(acronyms, "IPL", "initial program load").
card(acronyms, "IPS", "intrusion prevention system").
card(acronyms, "IPTV", "Internet Protocol television").
card(acronyms, "IPng", "Internet Protocol next generation").
card(acronyms, "IPsec", "Internet Protocol security").
card(acronyms, "IQ", "intelligence quotient").
card(acronyms, "IRB", "institutional review board").
card(acronyms, "IRC", "Internet Relay Chat").
card(acronyms, "IRQ", "interrupt request").
card(acronyms, "ISA", "Industry Standard Architecture").
card(acronyms, "ISAM", "indexed sequential access method").
card(acronyms, "ISAPI", "Internet Server Application Programming Interface").
card(acronyms, "ISBN", "International Standard Book Number").
card(acronyms, "ISDN", "Integrated Services Digital Network").
card(acronyms, "ISO", "International Organization for Standardization").
card(acronyms, "ISP", "Internet service provider").
card(acronyms, "ISV", "independent software vendor").
card(acronyms, "IT", "information technology").
card(acronyms, "ITIL", "Information Technology Infrastructure Library").
card(acronyms, "ITU", "International Telecommunication Union").
card(acronyms, "Info", "information").
card(acronyms, "IrDA", "Infrared Data Association").
card(acronyms, "JAR", "Java archive").
card(acronyms, "JAWS", "Job Access With Speech").
card(acronyms, "JCL", "job control language").
card(acronyms, "JDBC", "Java Database Connectivity").
card(acronyms, "JDK", "Java Development Kit").
card(acronyms, "JEDEC", "Joint Electron Device Engineering Council").
card(acronyms, "JIT", "just-in-time").
card(acronyms, "JNI", "Java Native Interface").
card(acronyms, "JPEG", "Joint Photographic Experts Group").
card(acronyms, "JRE", "Java Runtime Environment").
card(acronyms, "JSON", "JavaScript Object Notation").
card(acronyms, "JVM", "Java virtual machine").
card(acronyms, "K", "kilobit").
card(acronyms, "KB", "knowledge base").
card(acronyms, "KDE", "K Desktop Environment").
card(acronyms, "KISS", "Keep It Simple, Stupid").
card(acronyms, "Kbps", "kilobits per second").
card(acronyms, "LAN", "local area network").
card(acronyms, "LAWN", "local area wireless network").
card(acronyms, "LBS", "location-based service").
card(acronyms, "LCD", "liquid crystal display").
card(acronyms, "LDAP", "Lightweight Directory Access Protocol").
card(acronyms, "LED", "light-emitting diode").
card(acronyms, "LF", "line feed").
card(acronyms, "LG", "Life's Good").
card(acronyms, "LGPL", "Lesser General Public License").
card(acronyms, "LIFO", "last in, first out").
card(acronyms, "LILO", "Linux loader").
card(acronyms, "LMS", "Learning Management System").
card(acronyms, "LP", "long play").
card(acronyms, "LPI", "lines per inch").
card(acronyms, "LSB", "least significant bit").
card(acronyms, "LSD", "least significant digit").
card(acronyms, "LTE", "Long-Term Evolution").
card(acronyms, "LU", "logical unit").
card(acronyms, "Lisp", "list processing").
card(acronyms, "MAC", "media access control").
card(acronyms, "MADD", "Mothers Against Drunk Driving").
card(acronyms, "MAN", "metropolitan area network").
card(acronyms, "MAR", "memory address register").
card(acronyms, "MB", "megabyte").
card(acronyms, "MBR", "master boot record").
card(acronyms, "MBps", "megabytes per second").
card(acronyms, "MCA", "Micro Channel Architecture").
card(acronyms, "MD", "Medical Doctor").
card(acronyms, "MFT", "Master File Table").
card(acronyms, "MHz", "megahertz").
card(acronyms, "MIA", "missing in action").
card(acronyms, "MIB", "management information base").
card(acronyms, "MICR", "magnetic ink character recognition").
card(acronyms, "MIDI", "Musical Instrument Digital Interface").
card(acronyms, "MIME", "Multipurpose Internet Mail Extension").
card(acronyms, "MIPS", "millions of instructions per second").
card(acronyms, "MIS", "management information system").
card(acronyms, "MIT", "Massachusetts Institute of Technology").
card(acronyms, "MLA", "Modern Language Association").
card(acronyms, "MMC", "Microsoft Management Console").
card(acronyms, "MMU", "memory management unit").
card(acronyms, "MMX", "multimedia extension").
card(acronyms, "MPAA", "Motion Picture Association of America").
card(acronyms, "MPEG", "Moving Picture Experts Group").
card(acronyms, "MPI", "message passing interface").
card(acronyms, "MPLS", "Multiprotocol Label Switching").
card(acronyms, "MPP", "massively parallel processing").
card(acronyms, "MSRP", "manufacturer's suggested retail price").
card(acronyms, "MST", "Mountain Standard Time").
card(acronyms, "MTBF", "mean time between failure").
card(acronyms, "MTU", "maximum transmission unit").
card(acronyms, "MUD", "multi-user dungeon").
card(acronyms, "MVC", "model-view-controller").
card(acronyms, "MVP", "most valuable player").
card(acronyms, "MVS", "multiple virtual storage").
card(acronyms, "Matlab", "matrix laboratory").
card(acronyms, "Max", "maximum").
card(acronyms, "Mb", "megabit").
card(acronyms, "Mbps", "megabits per second").
card(acronyms, "Memo", "memorandum").
card(acronyms, "Min", "minimum").
card(acronyms, "Mutex", "mutual exclusion object").
card(acronyms, "N", "nano").
card(acronyms, "NAFTA", "North American Free Trade Agreement").
card(acronyms, "NAK", "negative acknowledgment").
card(acronyms, "NAS", "network-attached storage").
card(acronyms, "NASA", "National Aeronautics and Space Administration").
card(acronyms, "NAT", "Network Address Translation").
card(acronyms, "NBA", "National Basketball Association").
card(acronyms, "NCSA", "National Center for Supercomputing Applications").
card(acronyms, "NDA", "non-disclosure agreement").
card(acronyms, "NDIS", "network driver interface specification").
card(acronyms, "NFL", "National Football League").
card(acronyms, "NFS", "network file system").
card(acronyms, "NHL", "National Hockey League").
card(acronyms, "NIC", "network interface card").
card(acronyms, "NIDS", "network intrusion detection system").
card(acronyms, "NLP", "natural language processing").
card(acronyms, "NNTP", "Network News Transfer Protocol").
card(acronyms, "NOS", "network operating system").
card(acronyms, "NPC", "NP-Complete").
card(acronyms, "NRZ", "non-return-to-zero").
card(acronyms, "NSAP", "Network Service Access Point").
card(acronyms, "NTFS", "NTFS file system").
card(acronyms, "NTP", "Network Time Protocol").
card(acronyms, "NUC", "Next Unit of Computing").
card(acronyms, "NaN", "not a number").
card(acronyms, "Net", "network").
card(acronyms, "NetBIOS", "network basic input/output system").
card(acronyms, "NiMH", "nickel-metal hydride").
card(acronyms, "Num", "number").
card(acronyms, "OBJ", "object").
card(acronyms, "OCR", "optical character recognition").
card(acronyms, "OCTAVE", "operationally critical threat, asset, and vulnerability evaluation").
card(acronyms, "ODBC", "Open Database Connectivity").
card(acronyms, "OEM", "original equipment manufacturer").
card(acronyms, "OID", "object identifier").
card(acronyms, "OLAP", "online analytical processing").
card(acronyms, "OLE", "OnLine English").
card(acronyms, "OLED", "organic light-emitting diode").
card(acronyms, "OLPC", "one laptop per child").
card(acronyms, "OLTP", "online transaction processing").
card(acronyms, "OMG", "Oh My God").
card(acronyms, "OOP", "object-oriented programming").
card(acronyms, "OR", "OR operator").
card(acronyms, "OS", "operating system").
card(acronyms, "OSF", "Open Software Foundation").
card(acronyms, "OSHA", "Occupational Safety and Health Administration").
card(acronyms, "OSPF", "open shortest path first").
card(acronyms, "OT", "overtime").
card(acronyms, "Open", "open source").
card(acronyms, "PAE", "physical address extension").
card(acronyms, "PARC", "Palo Alto Research Center").
card(acronyms, "PB", "petabyte").
card(acronyms, "PC", "player character").
card(acronyms, "PCB", "printed circuit board").
card(acronyms, "PCI", "Peripheral Component Interconnect").
card(acronyms, "PCIe", "PCI Express").
card(acronyms, "PCM", "pulse-code modulation").
card(acronyms, "PDA", "personal digital assistant").
card(acronyms, "PDC", "Primary Domain Controller").
card(acronyms, "PDF", "Portable Document Format").
card(acronyms, "PDP", "Programmed Data Processor").
card(acronyms, "PDU", "protocol data unit").
card(acronyms, "PEAR", "PHP Extension and Application Repository").
card(acronyms, "PETA", "People for the Ethical Treatment of Animals").
card(acronyms, "PGP", "Pretty Good Privacy").
card(acronyms, "PHP", "PHP: Hypertext Preprocessor").
card(acronyms, "PIM", "Protocol Independent Multicast").
card(acronyms, "PIN", "personal identification number").
card(acronyms, "PIO", "programmed input/output").
card(acronyms, "PLCC", "plastic leaded chip carrier").
card(acronyms, "PM", "private message").
card(acronyms, "PNG", "Portable Network Graphics").
card(acronyms, "POP", "Post Office Protocol").
card(acronyms, "POTUS", "President of the United States").
card(acronyms, "POV", "point of view").
card(acronyms, "POW", "Prisoner Of War").
card(acronyms, "PPC", "pay per click").
card(acronyms, "PPGA", "Plastic Pin Grid Array").
card(acronyms, "PPP", "Point-to-Point Protocol").
card(acronyms, "PPV", "pay per view").
card(acronyms, "PR", "public relations").
card(acronyms, "PROM", "programmable read-only memory").
card(acronyms, "PSTN", "public switched telephone network").
card(acronyms, "PSU", "power supply unit").
card(acronyms, "PVR", "personal video recorder").
card(acronyms, "PWA", "progressive web application").
card(acronyms, "PWS", "Personal Web Server").
card(acronyms, "PXE", "preboot execution environment").
card(acronyms, "PaaS", "Platform as a Service").
card(acronyms, "Parm", "parameter").
card(acronyms, "Pic", "picture").
card(acronyms, "Plus", "Microsoft Plus!").
card(acronyms, "PnP", "plug and play").
card(acronyms, "Prolog", "programming in logic").
card(acronyms, "QA", "quality assurance").
card(acronyms, "QoS", "quality of service").
card(acronyms, "RAD", "rapid application development").
card(acronyms, "RADAR", "Radio Detection And Ranging").
card(acronyms, "RADIUS", "Remote Authentication Dial-in User Service").
card(acronyms, "RAID", "redundant array of independent disks").
card(acronyms, "RAM", "random access memory").
card(acronyms, "RAR", "Roshal Archive").
card(acronyms, "RAT", "Remote Access Trojan").
card(acronyms, "RBAC", "role-based access control").
card(acronyms, "RCS", "revision control system").
card(acronyms, "RDBMS", "relational database management system").
card(acronyms, "RDF", "Resource Description Framework").
card(acronyms, "RDP", "Remote Desktop Protocol").
card(acronyms, "REC", "record").
card(acronyms, "REPL", "read-eval-print loop").
card(acronyms, "RF", "radio frequency").
card(acronyms, "RFC", "Request for Comments").
card(acronyms, "RFID", "radio frequency identification").
card(acronyms, "RIAA", "Recording Industry Association of America").
card(acronyms, "RIP", "Routing Information Protocol").
card(acronyms, "RISC", "reduced instruction set computer").
card(acronyms, "RLE", "run-length encoding").
card(acronyms, "RMS", "root mean square").
card(acronyms, "RNC", "Republican National Committee").
card(acronyms, "ROFL", "rolling on the floor laughing").
card(acronyms, "ROM", "read-only memory").
card(acronyms, "RPC", "remote procedure call").
card(acronyms, "RPG", "role playing game").
card(acronyms, "RT", "retweet").
card(acronyms, "RTC", "real-time clock").
card(acronyms, "RTF", "Rich Text Format").
card(acronyms, "RTOS", "real-time operating system").
card(acronyms, "RTS", "Request to Send").
card(acronyms, "RTSP", "Real Time Streaming Protocol").
card(acronyms, "Regex", "regular expression").
card(acronyms, "Rel", "release").
card(acronyms, "SAN", "storage area network").
card(acronyms, "SATAN", "Security Administrator Tool for Analyzing Networks").
card(acronyms, "SCSI", "small computer system interface").
card(acronyms, "SDK", "software development kit").
card(acronyms, "SDRAM", "synchronous DRAM").
card(acronyms, "SE", "second edition").
card(acronyms, "SELinux", "Security-Enhanced Linux").
card(acronyms, "SEO", "search engine optimization").
card(acronyms, "SERP", "search engine results page").
card(acronyms, "SETI", "Search for Extraterrestrial Intelligence").
card(acronyms, "SFTP", "SSH File Transfer Protocol").
card(acronyms, "SFX", "special effects").
card(acronyms, "SGML", "Standard Generalized Markup Language").
card(acronyms, "SIGINT", "signals intelligence").
card(acronyms, "SIMD", "single instruction, multiple data").
card(acronyms, "SLA", "service-level agreement").
card(acronyms, "SLIP", "Serial Line Internet Protocol").
card(acronyms, "SMIL", "Synchronized Multimedia Integration Language").
card(acronyms, "SMP", "symmetric multiprocessing").
card(acronyms, "SMTP", "Simple Mail Transfer Protocol").
card(acronyms, "SNA", "Systems Network Architecture").
card(acronyms, "SNMP", "Simple Network Management Protocol").
card(acronyms, "SOA", "start of authority").
card(acronyms, "SOAP", "Simple Object Access Protocol").
card(acronyms, "SP", "spelling").
card(acronyms, "SPCA", "Society for the Prevention of Cruelty to Animals").
card(acronyms, "SQL", "Structured Query Language").
card(acronyms, "SRAM", "static random access memory").
card(acronyms, "SRI", "socially responsible investing").
card(acronyms, "SRP", "Single Responsibility Principle").
card(acronyms, "SSD", "solid-state drive").
card(acronyms, "SSE", "Streaming SIMD Extensions").
card(acronyms, "SSI", "small-scale integration").
card(acronyms, "SSID", "service set identifier").
card(acronyms, "SUV", "Sports Utility Vehicle").
card(acronyms, "SW", "software").
card(acronyms, "SWAT", "Special Weapons And Tactics").
card(acronyms, "SYN", "synchronize").
card(acronyms, "SaaS", "Software as a Service").
card(acronyms, "Sig", "signature").
card(acronyms, "Sim", "simulation").
card(acronyms, "SoC", "system on a chip").
card(acronyms, "Source", "source code").
card(acronyms, "Spec", "specification").
card(acronyms, "Stdin", "standard input").
card(acronyms, "TBA", "to be announced").
card(acronyms, "TBD", "to be determined").
card(acronyms, "TCO", "total cost of ownership").
card(acronyms, "TD", "table data").
card(acronyms, "TH", "table head").
card(acronyms, "TIFF", "Tagged Image File Format").
card(acronyms, "TLD", "top-level domain").
card(acronyms, "TLS", "Transport Layer Security").
card(acronyms, "TM", "trademark").
card(acronyms, "TN", "twisted nematic").
card(acronyms, "TOS", "type of service").
card(acronyms, "TPM", "trusted platform module").
card(acronyms, "TR", "technical report").
card(acronyms, "TRS", "Telecommunications Relay Service").
card(acronyms, "TTL", "transistor-transistor logic").
card(acronyms, "TTS", "text-to-speech").
card(acronyms, "TTY", "teletypewriter").
card(acronyms, "TV", "television").
card(acronyms, "Ta", "tantalum").
card(acronyms, "Tech", "technology").
card(acronyms, "Ti", "Titanium").
card(acronyms, "Tk", "toolkit").
card(acronyms, "Tor", "The Onion Router").
card(acronyms, "UA", "user agent").
card(acronyms, "UCE", "unsolicited commercial e-mail").
card(acronyms, "UDF", "user-defined function").
card(acronyms, "UDP", "User Datagram Protocol").
card(acronyms, "UEFI", "Unified Extensible Firmware Interface").
card(acronyms, "UFO", "unidentified flying object").
card(acronyms, "UHCI", "Universal Host Controller Interface").
card(acronyms, "UI", "user interface").
card(acronyms, "UN", "United Nations").
card(acronyms, "UNIVAC", "Universal Automatic Computer").
card(acronyms, "UPC", "universal product code").
card(acronyms, "UPS", "United Parcel Service").
card(acronyms, "UPnP", "Universal Plug and Play").
card(acronyms, "URI", "uniform resource identifier").
card(acronyms, "URL", "Uniform Resource Locator").
card(acronyms, "URN", "Uniform Resource Name").
card(acronyms, "USAF", "United States Air Force").
card(acronyms, "USB", "universal serial bus").
card(acronyms, "UT", "Universal Time").
card(acronyms, "UTC", "Coordinated Universal Time").
card(acronyms, "UTF", "Unicode Transformation Format").
card(acronyms, "UUID", "universal unique identifier").
card(acronyms, "UV", "ultraviolet").
card(acronyms, "UX", "user experience").
card(acronyms, "VA", "virtual address").
card(acronyms, "VAN", "value-added network").
card(acronyms, "VAR", "value-added reseller").
card(acronyms, "VB", "Visual Basic").
card(acronyms, "VC", "virtual circuit").
card(acronyms, "VDU", "visual display unit").
card(acronyms, "VGA", "video graphics array").
card(acronyms, "VHDL", "VHSIC Hardware Description Language ").
card(acronyms, "VHF", "very high frequency").
card(acronyms, "VHS", "Video Home System").
card(acronyms, "VIP", "very important person").
card(acronyms, "VLAN", "virtual local area network").
card(acronyms, "VLC", "VideoLAN").
card(acronyms, "VLSI", "very-large-scale integration").
card(acronyms, "VMM", "virtual machine monitor").
card(acronyms, "VNC", "Virtual Network Computing").
card(acronyms, "VOD", "video on demand").
card(acronyms, "VPN", "virtual private network").
card(acronyms, "VPS", "virtual private server").
card(acronyms, "VR", "virtual reality").
card(acronyms, "VRML", "Virtual Reality Modeling Language").
card(acronyms, "VSAM", "virtual storage access method").
card(acronyms, "Veronica", "Very Easy Rodent-Oriented Net-wide Index to Computer Archives").
card(acronyms, "VoIP", "Voice over Internet Protocol").
card(acronyms, "W", "width").
card(acronyms, "WAIS", "Wide Area Information Server").
card(acronyms, "WAN", "wide area network").
card(acronyms, "WAP", "Wireless Application Protocol").
card(acronyms, "WBEM", "Web-based Enterprise Management").
card(acronyms, "WEP", "Wired Equivalent Privacy").
card(acronyms, "WGA", "Windows Genuine Advantage").
card(acronyms, "WISP", "wireless Internet service provider").
card(acronyms, "WMA", "World Medical Association").
card(acronyms, "WML", "Wireless Markup Language").
card(acronyms, "WP", "WordPress").
card(acronyms, "WWE", "World Wrestling Entertainment").
card(acronyms, "WWW", "World Wide Web").
card(acronyms, "WYSIWYG", "what you see is what you get").
card(acronyms, "X", "X Window System").
card(acronyms, "XHTML", "Extensible Hypertext Markup Language").
card(acronyms, "XML", "Extensible Markup Language").
card(acronyms, "XMPP", "Extensible Messaging and Presence Protocol").
card(acronyms, "XSL", "Extensible Stylesheet Language").
card(acronyms, "XSLT", "extensible stylesheet language transformations").
card(acronyms, "XSS", "cross-site scripting").
card(acronyms, "YAML", "YAML Ain't Markup Language").
card(acronyms, "YT", "youtube").
card(acronyms, "ZIF", "zero insertion force").
card(acronyms, "bps", "bits per second").
card(acronyms, "kHz", "kilohertz").
card(acronyms, "kilo", "one thousand").
card(acronyms, "lvl", "level").
card(acronyms, "m", "milli").
card(acronyms, "ne", "not equal").
card(acronyms, "nm", "nanometer").
card(acronyms, "sync", "synchronize").
card(acronyms, "synth", "synthesizer").
card(acronyms, "sysgen", "system generation").
card(acronyms, "sysop", "system operator").
card(actor_roles, "10 Cloverfield Lane", "John Goodman").
card(actor_roles, "12 Angry Men", "Ed Begley; Henry Fonda; Lee J. Cobb").
card(actor_roles, "12 Years a Slave", "Chiwetel Ejiofor").
card(actor_roles, "127 Hours", "James Franco").
card(actor_roles, "1917", "Mark Strong").
card(actor_roles, "21 Jump Street", "Channing Tatum; Jonah Hill").
card(actor_roles, "24", "Kiefer Sutherland").
card(actor_roles, "28 Days Later...", "Cillian Murphy").
card(actor_roles, "300", "Gerard Butler").
card(actor_roles, "45 Years", "Tom Courtenay").
card(actor_roles, "A Clockwork Orange", "Malcolm McDowell").
card(actor_roles, "A Fish Called Wanda", "John Cleese").
card(actor_roles, "A History of Violence", "William Hurt").
card(actor_roles, "A Man for All Seasons", "Paul Scofield; Robert Shaw").
card(actor_roles, "A Night at the Opera", "Groucho Marx").
card(actor_roles, "A Quiet Place", "John Krasinski").
card(actor_roles, "A Single Man", "Colin Firth").
card(actor_roles, "A Star Is Born", "Bradley Cooper; Sam Elliott").
card(actor_roles, "Ad Astra (Producer)", "Brad Pitt").
card(actor_roles, "Adaptation.", "Chris Cooper").
card(actor_roles, "Airplane!", "Leslie Nielsen").
card(actor_roles, "Alexis Zorbas", "Anthony Quinn").
card(actor_roles, "Aliens", "Bill Paxton").
card(actor_roles, "All About Eve", "George Sanders").
card(actor_roles, "All the King's Men", "Broderick Crawford").
card(actor_roles, "All the President's Men", "Jason Robards; Martin Balsam").
card(actor_roles, "Almost Famous", "Billy Crudup").
card(actor_roles, "Amadeus", "Tom Hulce").
card(actor_roles, "Amour", "Jean-Louis Trintignant").
card(actor_roles, "An Officer and a Gentleman", "Louis Gossett Jr.").
card(actor_roles, "Anatomy of a Murder", "James Stewart").
card(actor_roles, "Anchorman 2: The Legend Continues (Producer)", "Will Ferrell").
card(actor_roles, "Angels with Dirty Faces", "James Cagney").
card(actor_roles, "Ant-Man", "Paul Rudd").
card(actor_roles, "Apocalypse Now", "Marlon Brando").
card(actor_roles, "Appaloosa", "Ed Harris").
card(actor_roles, "Argo (Producer)", "Ben Affleck").
card(actor_roles, "Argo", "Alan Arkin").
card(actor_roles, "Arrested Development", "Jason Bateman").
card(actor_roles, "Arthur", "Dudley Moore; John Gielgud; Russell Brand").
card(actor_roles, "As Good as It Gets", "Greg Kinnear").
card(actor_roles, "Austin Powers: The Spy Who Shagged Me", "Mike Myers").
card(actor_roles, "Avatar", "Sam Worthington").
card(actor_roles, "Avengers: Endgame", "Josh Brolin").
card(actor_roles, "Baby Boy", "Tyrese Gibson").
card(actor_roles, "Back to the Future", "Christopher Lloyd; Michael J. Fox").
card(actor_roles, "Barbershop", "Michael Ealy").
card(actor_roles, "Barton Fink", "John Turturro; Michael Lerner").
card(actor_roles, "Batman & Robin", "Chris O'Donnell").
card(actor_roles, "Battlestar Galactica", "Edward James Olmos").
card(actor_roles, "Beasts of No Nation", "Idris Elba").
card(actor_roles, "Beginners", "Christopher Plummer").
card(actor_roles, "Behind the Candelabra", "Michael Douglas").
card(actor_roles, "Being John Malkovich", "John Malkovich").
card(actor_roles, "Being There", "Melvyn Douglas; Peter Sellers").
card(actor_roles, "Ben-Hur", "Charlton Heston; Hugh Griffith").
card(actor_roles, "Big Night", "Stanley Tucci").
card(actor_roles, "Billy Elliot", "Jamie Bell").
card(actor_roles, "Birdman or (The Unexpected Virtue of Ignorance)", "Michael Keaton").
card(actor_roles, "Black Panther", "Chadwick Boseman; Michael B. Jordan").
card(actor_roles, "Black Swan", "Vincent Cassel").
card(actor_roles, "Blade Runner", "Rutger Hauer").
card(actor_roles, "Blade", "Wesley Snipes").
card(actor_roles, "Blood Diamond", "Djimon Hounsou").
card(actor_roles, "Blue Valentine", "Ryan Gosling").
card(actor_roles, "Boiler Room", "Giovanni Ribisi").
card(actor_roles, "Bonnie and Clyde", "Warren Beatty").
card(actor_roles, "Boogie Nights", "Burt Reynolds").
card(actor_roles, "Borat: Cultural Learnings of America for Make Benefit Glorious Nation of Kazakhstan", "Sacha Baron Cohen").
card(actor_roles, "Braveheart", "Mel Gibson").
card(actor_roles, "Breaking Bad", "Aaron Paul; Bryan Cranston").
card(actor_roles, "Bride of Frankenstein", "Boris Karloff").
card(actor_roles, "Bridge of Spies", "Mark Rylance").
card(actor_roles, "Brokeback Mountain", "Heath Ledger; Randy Quaid").
card(actor_roles, "Brothers", "Tobey Maguire").
card(actor_roles, "Bruce Almighty", "Jim Carrey").
card(actor_roles, "Buffalo '66", "Vincent Gallo").
card(actor_roles, "C'era una volta il West", "Charles Bronson").
card(actor_roles, "Calvary", "Brendan Gleeson").
card(actor_roles, "Casablanca", "Claude Rains; Humphrey Bogart; Peter Lorre").
card(actor_roles, "Casino Royale", "Daniel Craig").
card(actor_roles, "Cast Away (Producer)", "Tom Hanks").
card(actor_roles, "Charade", "Cary Grant").
card(actor_roles, "Chef (Producer)", "Jon Favreau").
card(actor_roles, "Chicago", "John C. Reilly; Richard Gere").
card(actor_roles, "Children of Men", "Clive Owen").
card(actor_roles, "Chinatown", "Jack Nicholson").
card(actor_roles, "Citizen Kane", "Orson Welles").
card(actor_roles, "City Slickers", "Jack Palance").
card(actor_roles, "Coach", "Craig T. Nelson").
card(actor_roles, "Cocoon", "Don Ameche").
card(actor_roles, "Colossal", "Jason Sudeikis").
card(actor_roles, "Congo", "Tim Curry").
card(actor_roles, "Cool Hand Luke", "George Kennedy").
card(actor_roles, "Crank", "Jason Statham").
card(actor_roles, "Crash", "Don Cheadle; Ryan Phillippe").
card(actor_roles, "Cyrano de Bergerac", "Gérard Depardieu").
card(actor_roles, "Dallas Buyers Club", "Jared Leto; Matthew McConaughey").
card(actor_roles, "Dark City", "Rufus Sewell").
card(actor_roles, "Dasharatham", "Mohanlal").
card(actor_roles, "De battre mon coeur s'est arrêté", "Romain Duris").
card(actor_roles, "Dead Man's Shoes", "Paddy Considine").
card(actor_roles, "Dead Ringers", "Jeremy Irons").
card(actor_roles, "Deadpool 2", "Ryan Reynolds").
card(actor_roles, "Den 12. mann", "Jonathan Rhys Meyers").
card(actor_roles, "Der Untergang", "Bruno Ganz").
card(actor_roles, "Deuce Bigalow: European Gigolo", "Rob Schneider").
card(actor_roles, "Dexter", "Michael C. Hall").
card(actor_roles, "Diary of a Mad Black Woman (Writer)", "Tyler Perry").
card(actor_roles, "Die Hard", "Alan Rickman; Bruce Willis").
card(actor_roles, "Dinner at Eight", "Wallace Beery").
card(actor_roles, "Dirty Dancing", "Patrick Swayze").
card(actor_roles, "Django Unchained", "Christoph Waltz").
card(actor_roles, "Do the Right Thing", "Danny Aiello").
card(actor_roles, "Dog Day Afternoon", "John Cazale").
card(actor_roles, "Don 2", "Shah Rukh Khan").
card(actor_roles, "Double Impact", "Jean-Claude Van Damme").
card(actor_roles, "Double Indemnity", "Edward G. Robinson").
card(actor_roles, "Drive", "Albert Brooks").
card(actor_roles, "Dune", "José Ferrer").
card(actor_roles, "East of Eden", "James Dean").
card(actor_roles, "Eastern Promises", "Armin Mueller-Stahl").
card(actor_roles, "Easy Rider", "Dennis Hopper; Peter Fonda").
card(actor_roles, "Ed Wood", "Martin Landau").
card(actor_roles, "Erin Brockovich", "Albert Finney").
card(actor_roles, "Ex Machina", "Oscar Isaac").
card(actor_roles, "Face/Off", "Nicolas Cage").
card(actor_roles, "Family Guy (Writer)", "Seth MacFarlane").
card(actor_roles, "Fantastic Four", "Ioan Gruffudd").
card(actor_roles, "Fargo", "Steve Buscemi; William H. Macy").
card(actor_roles, "Fences", "Denzel Washington").
card(actor_roles, "Filth", "James McAvoy").
card(actor_roles, "Finding Neverland", "Freddie Highmore").
card(actor_roles, "Flash Gordon", "Max von Sydow").
card(actor_roles, "Footloose", "Kevin Bacon").
card(actor_roles, "Foreign Correspondent", "Joel McCrea").
card(actor_roles, "Forget Paris", "Billy Crystal").
card(actor_roles, "Forgetting Sarah Marshall", "Jason Segel").
card(actor_roles, "Forrest Gump", "Gary Sinise").
card(actor_roles, "Friday (Soundtrack)", "Ice Cube").
card(actor_roles, "From Here to Eternity", "Burt Lancaster; Frank Sinatra; Montgomery Clift").
card(actor_roles, "Frost/Nixon", "Frank Langella").
card(actor_roles, "Frozen", "Josh Gad").
card(actor_roles, "Funny Face (Soundtrack)", "Fred Astaire").
card(actor_roles, "Furious 6", "Sung Kang").
card(actor_roles, "Game of Thrones", "Peter Dinklage").
card(actor_roles, "Ghost Busters (Writer)", "Dan Aykroyd").
card(actor_roles, "Girls! Girls! Girls! (Soundtrack)", "Elvis Presley").
card(actor_roles, "Gone Baby Gone", "Casey Affleck").
card(actor_roles, "Good Night, and Good Luck.", "David Strathairn").
card(actor_roles, "Good Will Hunting", "Matt Damon; Stellan Skarsgård").
card(actor_roles, "Goodfellas", "Joe Pesci; Ray Liotta").
card(actor_roles, "Goon", "Jay Baruchel").
card(actor_roles, "Gosford Park", "Richard E. Grant").
card(actor_roles, "Grosse Pointe Blank", "John Cusack").
card(actor_roles, "Guardians of the Galaxy", "Chris Pratt; Michael Rooker; Vin Diesel").
card(actor_roles, "Guess Who's Coming to Dinner", "Sidney Poitier; Spencer Tracy").
card(actor_roles, "Hacksaw Ridge", "Andrew Garfield").
card(actor_roles, "Hairspray", "Christopher Walken; James Marsden").
card(actor_roles, "Hannibal", "Mads Mikkelsen").
card(actor_roles, "Hard Target", "Lance Henriksen").
card(actor_roles, "Harry Potter and the Deathly Hallows: Part 2", "Daniel Radcliffe").
card(actor_roles, "Harry and Tonto", "Art Carney").
card(actor_roles, "Hell or High Water", "Ben Foster").
card(actor_roles, "Henry V", "Kenneth Branagh").
card(actor_roles, "High Noon", "Gary Cooper").
card(actor_roles, "Home Alone", "Macaulay Culkin").
card(actor_roles, "Honey Boy", "Shia LaBeouf").
card(actor_roles, "House M.D.", "Hugh Laurie").
card(actor_roles, "House of Cards", "Mahershala Ali").
card(actor_roles, "How Green Was My Valley", "Donald Crisp").
card(actor_roles, "How I Met Your Mother", "Neil Patrick Harris").
card(actor_roles, "Huo Yuan Jia", "Jet Li").
card(actor_roles, "Hustle & Flow", "Terrence Howard").
card(actor_roles, "In Good Company", "Topher Grace").
card(actor_roles, "In the Heat of the Night", "Rod Steiger").
card(actor_roles, "Inception", "Joseph Gordon-Levitt; Leonardo DiCaprio; Tom Hardy").
card(actor_roles, "Independence Day", "Bill Pullman").
card(actor_roles, "Into the Wild", "Hal Holbrook").
card(actor_roles, "Iron Man", "Robert Downey Jr.").
card(actor_roles, "It Happened One Night", "Clark Gable").
card(actor_roles, "It's Always Sunny in Philadelphia (Producer)", "Charlie Day").
card(actor_roles, "Jackie Brown", "Robert Forster").
card(actor_roles, "Jaws", "Roy Scheider").
card(actor_roles, "Jerry Maguire", "Cuba Gooding Jr.").
card(actor_roles, "Joe Dirt", "David Spade").
card(actor_roles, "Judgment at Nuremberg", "Maximilian Schell").
card(actor_roles, "Jumanji: Welcome to the Jungle", "Dwayne Johnson").
card(actor_roles, "Juno", "Elliot Page").
card(actor_roles, "Jurassic Park", "Jeff Goldblum; Richard Attenborough").
card(actor_roles, "Justified", "Timothy Olyphant").
card(actor_roles, "Key Largo", "Lionel Barrymore").
card(actor_roles, "Kick-Ass", "Aaron Taylor-Johnson").
card(actor_roles, "Kingsman: The Secret Service", "Taron Egerton").
card(actor_roles, "Kinsey", "Liam Neeson").
card(actor_roles, "L.A. Confidential", "Kevin Spacey").
card(actor_roles, "La dolce vita", "Marcello Mastroianni").
card(actor_roles, "La vita è bella", "Roberto Benigni").
card(actor_roles, "Law & Order", "Sam Waterston").
card(actor_roles, "Lawrence of Arabia", "Omar Sharif; Peter O'Toole").
card(actor_roles, "Les Misérables", "Eddie Redmayne; Hugh Jackman; Russell Crowe").
card(actor_roles, "Lethal Weapon", "Danny Glover").
card(actor_roles, "Life of Pi", "Suraj Sharma").
card(actor_roles, "Live Free or Die Hard", "Justin Long").
card(actor_roles, "Logan", "Patrick Stewart").
card(actor_roles, "Lolita", "James Mason").
card(actor_roles, "Lost in Translation", "Bill Murray").
card(actor_roles, "Love Actually", "Hugh Grant").
card(actor_roles, "Lucky Number Slevin", "Josh Hartnett").
card(actor_roles, "Léon", "Jean Reno").
card(actor_roles, "M*A*S*H", "Alan Alda").
card(actor_roles, "Mad Max: Fury Road", "Nicholas Hoult").
card(actor_roles, "Mad Men", "Jon Hamm").
card(actor_roles, "Man of Steel", "Henry Cavill").
card(actor_roles, "Manhattan (Writer)", "Woody Allen").
card(actor_roles, "Martin", "Martin Lawrence").
card(actor_roles, "Marty", "Ernest Borgnine").
card(actor_roles, "Mary Poppins", "Dick Van Dyke").
card(actor_roles, "Master and Commander: The Far Side of the World", "Paul Bettany").
card(actor_roles, "Masters of Sex", "Michael Sheen").
card(actor_roles, "Matilda", "Danny DeVito").
card(actor_roles, "Memento", "Guy Pearce").
card(actor_roles, "Meng long guo jiang", "Bruce Lee").
card(actor_roles, "Merry Christmas Mr. Lawrence", "Tom Conti").
card(actor_roles, "Michael Clayton", "George Clooney; Tom Wilkinson").
card(actor_roles, "Midnight Cowboy", "Jon Voight").
card(actor_roles, "Million Dollar Baby", "Clint Eastwood").
card(actor_roles, "Miracle on 34th Street", "Edmund Gwenn").
card(actor_roles, "Miss Congeniality", "Benjamin Bratt").
card(actor_roles, "Moon", "Sam Rockwell").
card(actor_roles, "Motherless Brooklyn", "Edward Norton").
card(actor_roles, "Moulin Rouge!", "Ewan McGregor; Jim Broadbent; John Leguizamo").
card(actor_roles, "Mozart in the Jungle", "Gael García Bernal").
card(actor_roles, "Mrs. Doubtfire", "Robin Williams").
card(actor_roles, "Murder by Death", "David Niven").
card(actor_roles, "My Fair Lady", "Rex Harrison").
card(actor_roles, "My Own Private Idaho", "River Phoenix").
card(actor_roles, "Mystic River", "Sean Penn; Tim Robbins").
card(actor_roles, "Naked", "David Thewlis").
card(actor_roles, "Napoleon Dynamite", "Jon Heder").
card(actor_roles, "Nebraska", "Bruce Dern").
card(actor_roles, "Neighbors", "Dave Franco").
card(actor_roles, "Network", "Ned Beatty; Peter Finch").
card(actor_roles, "Ngo si seoi", "Jackie Chan").
card(actor_roles, "Nightcrawler", "Jake Gyllenhaal").
card(actor_roles, "Nineteen Eighty-Four", "John Hurt").
card(actor_roles, "Nosferatu: Phantom der Nacht", "Klaus Kinski").
card(actor_roles, "Ocean's Eleven", "Andy Garcia").
card(actor_roles, "Oh, God!", "George Burns").
card(actor_roles, "Old School", "Luke Wilson").
card(actor_roles, "Oldeuboi", "Choi Min-sik").
card(actor_roles, "Ordinary People", "Timothy Hutton").
card(actor_roles, "Out of the Past", "Robert Mitchum").
card(actor_roles, "Patton", "George C. Scott").
card(actor_roles, "Paul Blart: Mall Cop", "Kevin James").
card(actor_roles, "Paul", "Nick Frost").
card(actor_roles, "Penthouse", "Warner Baxter").
card(actor_roles, "Philomena", "Steve Coogan").
card(actor_roles, "Pierrot le Fou", "Jean-Paul Belmondo").
card(actor_roles, "Pineapple Express", "Danny McBride").
card(actor_roles, "Pirates of the Caribbean: Dead Man's Chest", "Jack Davenport").
card(actor_roles, "Planes, Trains & Automobiles", "John Candy").
card(actor_roles, "Predator", "Arnold Schwarzenegger").
card(actor_roles, "Psycho", "Anthony Perkins").
card(actor_roles, "Pulp Fiction", "John Travolta; Samuel L. Jackson").
card(actor_roles, "Quantum Leap", "Dean Stockwell").
card(actor_roles, "Raging Bull", "Robert De Niro").
card(actor_roles, "Random Harvest", "Ronald Colman").
card(actor_roles, "Ray", "Jamie Foxx").
card(actor_roles, "Red River", "Walter Brennan").
card(actor_roles, "Reservoir Dogs", "Harvey Keitel").
card(actor_roles, "Ride Along", "Kevin Hart").
card(actor_roles, "Rob Roy", "Tim Roth").
card(actor_roles, "Robot Chicken", "Seth Green").
card(actor_roles, "Rocky", "Sylvester Stallone").
card(actor_roles, "Roxanne (Writer)", "Steve Martin").
card(actor_roles, "Rush Hour 2", "Chris Tucker").
card(actor_roles, "Rush", "Daniel Brühl").
card(actor_roles, "Rushmore", "Jason Schwartzman").
card(actor_roles, "Saturday Night Live", "Andy Samberg").
card(actor_roles, "Saving Private Ryan", "Barry Pepper").
card(actor_roles, "Saw", "Cary Elwes").
card(actor_roles, "Scarface: The Shame of the Nation", "Paul Muni").
card(actor_roles, "Se7en", "Morgan Freeman").
card(actor_roles, "Selma", "David Oyelowo").
card(actor_roles, "Serpico", "Al Pacino").
card(actor_roles, "Sexy Beast", "Ben Kingsley").
card(actor_roles, "Shaft", "Jeffrey Wright").
card(actor_roles, "Shame", "Michael Fassbender").
card(actor_roles, "Shane", "Van Heflin").
card(actor_roles, "Shattered Glass", "Peter Sarsgaard").
card(actor_roles, "Shaun of the Dead", "Simon Pegg").
card(actor_roles, "Shichinin no samurai", "Takashi Shimura").
card(actor_roles, "Sicario", "Benicio Del Toro").
card(actor_roles, "Sideways", "Paul Giamatti; Thomas Haden Church").
card(actor_roles, "Singin' in the Rain (Soundtrack)", "Gene Kelly").
card(actor_roles, "Skyfall", "Javier Bardem").
card(actor_roles, "Sleuth", "Laurence Olivier").
card(actor_roles, "Sling Blade", "Billy Bob Thornton").
card(actor_roles, "Sons of Anarchy", "Charlie Hunnam").
card(actor_roles, "Spaceballs", "Mel Brooks").
card(actor_roles, "Spartacus", "Kirk Douglas; Peter Ustinov").
card(actor_roles, "Spider-Man 2", "Alfred Molina").
card(actor_roles, "Spider-Man", "Cliff Robertson; Willem Dafoe").
card(actor_roles, "Spotlight", "Liev Schreiber; Mark Ruffalo").
card(actor_roles, "St. Elmo's Fire", "Rob Lowe").
card(actor_roles, "Stagecoach", "Thomas Mitchell").
card(actor_roles, "Stalag 17", "William Holden").
card(actor_roles, "Star Trek V: The Final Frontier", "William Shatner").
card(actor_roles, "Star Trek", "Chris Pine; Eric Bana; Karl Urban").
card(actor_roles, "Star Wars", "Alec Guinness; Mark Hamill").
card(actor_roles, "Star Wars: Episode II - Attack of the Clones", "Christopher Lee; Hayden Christensen").
card(actor_roles, "Star Wars: Episode VII - The Force Awakens", "Adam Driver").
card(actor_roles, "Sunset Blvd.", "Erich von Stroheim").
card(actor_roles, "Superbad", "Michael Cera").
card(actor_roles, "Superman", "Christopher Reeve").
card(actor_roles, "Sweeney Todd: The Demon Barber of Fleet Street", "Johnny Depp").
card(actor_roles, "That '70s Show", "Ashton Kutcher").
card(actor_roles, "The 39 Steps", "Robert Donat").
card(actor_roles, "The Adventures of Robin Hood", "Errol Flynn").
card(actor_roles, "The Amazing Spider-Man", "Rhys Ifans").
card(actor_roles, "The Apartment", "Jack Lemmon").
card(actor_roles, "The Apostle", "Robert Duvall").
card(actor_roles, "The Artist", "Jean Dujardin").
card(actor_roles, "The Avengers", "Chris Evans; Chris Hemsworth; Tom Hiddleston").
card(actor_roles, "The Bernie Mac Show", "Bernie Mac").
card(actor_roles, "The Best Years of Our Lives", "Fredric March; Harold Russell").
card(actor_roles, "The Big Country", "Burl Ives").
card(actor_roles, "The Big Lebowski", "Jeff Bridges").
card(actor_roles, "The Blacklist", "James Spader").
card(actor_roles, "The Break-Up (Producer)", "Vince Vaughn").
card(actor_roles, "The Buddy Holly Story", "Gary Busey").
card(actor_roles, "The Crying Game", "Stephen Rea").
card(actor_roles, "The Daily Show", "Rob Riggle").
card(actor_roles, "The Dark Knight", "Aaron Eckhart; Christian Bale; Michael Caine").
card(actor_roles, "The Day After Tomorrow", "Dennis Quaid").
card(actor_roles, "The Departed", "Alec Baldwin; Martin Sheen; Ray Winstone").
card(actor_roles, "The Dirty Dozen", "Lee Marvin").
card(actor_roles, "The Doors", "Val Kilmer").
card(actor_roles, "The Family Way", "John Mills").
card(actor_roles, "The Fast and the Furious", "Paul Walker").
card(actor_roles, "The Fighter (Producer)", "Mark Wahlberg").
card(actor_roles, "The French Connection", "Gene Hackman").
card(actor_roles, "The Fresh Prince of Bel-Air (Music_department)", "Will Smith").
card(actor_roles, "The Fugitive", "Harrison Ford; Tommy Lee Jones").
card(actor_roles, "The General", "Buster Keaton").
card(actor_roles, "The Godfather", "James Caan").
card(actor_roles, "The Goodbye Girl", "Richard Dreyfuss").
card(actor_roles, "The Grand Budapest Hotel", "F. Murray Abraham; Ralph Fiennes").
card(actor_roles, "The Great Dictator (Writer)", "Charles Chaplin").
card(actor_roles, "The Great Escape", "James Coburn; Steve McQueen").
card(actor_roles, "The Green Mile", "Graham Greene; James Cromwell; Michael Clarke Duncan").
card(actor_roles, "The Hangover", "Ed Helms; Zach Galifianakis").
card(actor_roles, "The Hateful Eight", "Kurt Russell").
card(actor_roles, "The Hunger Games", "Liam Hemsworth").
card(actor_roles, "The Hunger Games: Catching Fire", "Donald Sutherland").
card(actor_roles, "The Hurt Locker", "Anthony Mackie; Jeremy Renner").
card(actor_roles, "The Hustler", "Paul Newman").
card(actor_roles, "The Imitation Game", "Benedict Cumberbatch").
card(actor_roles, "The Killing Fields", "Haing S. Ngor").
card(actor_roles, "The King's Speech", "Geoffrey Rush").
card(actor_roles, "The Last Command", "Emil Jannings").
card(actor_roles, "The Last King of Scotland", "Forest Whitaker").
card(actor_roles, "The Last Picture Show", "Ben Johnson").
card(actor_roles, "The Last Samurai", "Ken Watanabe").
card(actor_roles, "The Last of Us", "Troy Baker").
card(actor_roles, "The Legend of Tarzan", "Alexander Skarsgård").
card(actor_roles, "The Lobster", "Colin Farrell").
card(actor_roles, "The Long Good Friday", "Bob Hoskins").
card(actor_roles, "The Lord of the Rings: The Fellowship of the Ring", "Elijah Wood; Ian McKellen; Orlando Bloom; Sean Bean").
card(actor_roles, "The Lord of the Rings: The Return of the King", "Hugo Weaving; Ian Holm; John Rhys-Davies; Sean Astin; Viggo Mortensen").
card(actor_roles, "The Lost Weekend", "Ray Milland").
card(actor_roles, "The Lunchbox", "Irrfan Khan").
card(actor_roles, "The Madness of King George", "Nigel Hawthorne").
card(actor_roles, "The Man Who Shot Liberty Valance", "Edmond O'Brien").
card(actor_roles, "The Mask of Zorro", "Antonio Banderas").
card(actor_roles, "The Master", "Philip Seymour Hoffman").
card(actor_roles, "The Matrix", "Keanu Reeves; Laurence Fishburne").
card(actor_roles, "The More the Merrier", "Charles Coburn").
card(actor_roles, "The Mummy", "Brendan Fraser").
card(actor_roles, "The Natural", "Robert Redford").
card(actor_roles, "The Notebook", "James Garner").
card(actor_roles, "The Nutty Professor", "Eddie Murphy; Jerry Lewis").
card(actor_roles, "The Odd Couple", "Walter Matthau").
card(actor_roles, "The Office", "Steve Carell").
card(actor_roles, "The Passion of the Christ", "Jim Caviezel").
card(actor_roles, "The Perks of Being a Wallflower", "Ezra Miller; Logan Lerman").
card(actor_roles, "The Phantom of the Opera", "Patrick Wilson").
card(actor_roles, "The Pianist", "Adrien Brody").
card(actor_roles, "The Poseidon Adventure", "Red Buttons").
card(actor_roles, "The Postman", "Kevin Costner").
card(actor_roles, "The Producers", "Matthew Broderick; Nathan Lane").
card(actor_roles, "The Quiet Man", "Barry Fitzgerald; Victor McLaglen").
card(actor_roles, "The Royal Tenenbaums", "Owen Wilson").
card(actor_roles, "The School of Rock", "Jack Black").
card(actor_roles, "The Sessions", "John Hawkes").
card(actor_roles, "The Shape of Water", "Michael Shannon; Richard Jenkins").
card(actor_roles, "The Shop Around the Corner", "Joseph Schildkraut").
card(actor_roles, "The Silence of the Lambs", "Anthony Hopkins").
card(actor_roles, "The Sixth Sense", "Haley Joel Osment").
card(actor_roles, "The Skeleton Twins", "Bill Hader").
card(actor_roles, "The Social Network", "Jesse Eisenberg").
card(actor_roles, "The Sopranos", "James Gandolfini").
card(actor_roles, "The Spectacular Now", "Miles Teller").
card(actor_roles, "The Squid and the Whale", "Jeff Daniels").
card(actor_roles, "The Straight Story", "Richard Farnsworth").
card(actor_roles, "The Talented Mr. Ripley", "Jude Law").
card(actor_roles, "The Ten Commandments", "Yul Brynner").
card(actor_roles, "The Thin Man", "William Powell").
card(actor_roles, "The Third Man", "Joseph Cotten").
card(actor_roles, "The Three Musketeers", "Ray Stevenson").
card(actor_roles, "The Treasure of the Sierra Madre", "Walter Huston").
card(actor_roles, "The Two Popes", "Jonathan Pryce").
card(actor_roles, "The Untouchables", "Sean Connery").
card(actor_roles, "The Usual Suspects", "Chazz Palminteri; Pete Postlethwaite").
card(actor_roles, "The Walking Dead", "Andrew Lincoln; Norman Reedus").
card(actor_roles, "The Waterboy", "Adam Sandler").
card(actor_roles, "The Way", "Emilio Estevez").
card(actor_roles, "The World Is Not Enough", "Pierce Brosnan").
card(actor_roles, "The Wrestler", "Mickey Rourke").
card(actor_roles, "There Will Be Blood", "Daniel Day-Lewis; Paul Dano").
card(actor_roles, "There's Something About Mary", "Matt Dillon").
card(actor_roles, "They Shoot Horses, Don't They?", "Gig Young").
card(actor_roles, "This Is Spinal Tap", "Christopher Guest").
card(actor_roles, "This Is the End", "Craig Robinson; Seth Rogen").
card(actor_roles, "Three Days of the Condor", "John Houseman").
card(actor_roles, "Tinker Tailor Soldier Spy", "Gary Oldman").
card(actor_roles, "Titanic", "Billy Zane").
card(actor_roles, "To Kill a Mockingbird", "Gregory Peck").
card(actor_roles, "Tootsie", "Dustin Hoffman").
card(actor_roles, "Top Five", "Chris Rock").
card(actor_roles, "Top Gun", "Tom Cruise").
card(actor_roles, "Toy Story", "Tim Allen").
card(actor_roles, "Training Day", "Ethan Hawke").
card(actor_roles, "Transformers", "Josh Duhamel").
card(actor_roles, "Tron", "Garrett Hedlund").
card(actor_roles, "True Detective", "Woody Harrelson").
card(actor_roles, "True Grit", "John Wayne").
card(actor_roles, "Twentieth Century", "John Barrymore").
card(actor_roles, "Twilight", "Billy Burke; Cam Gigandet; Robert Pattinson").
card(actor_roles, "Two and a Half Men", "Charlie Sheen").
card(actor_roles, "Unforgiven", "Richard Harris").
card(actor_roles, "Vampires", "James Woods").
card(actor_roles, "Walk the Line", "Joaquin Phoenix").
card(actor_roles, "Walker, Texas Ranger", "Chuck Norris").
card(actor_roles, "Wanted", "Common").
card(actor_roles, "War for the Planet of the Apes", "Andy Serkis").
card(actor_roles, "Warrior", "Nick Nolte").
card(actor_roles, "Watch on the Rhine", "Paul Lukas").
card(actor_roles, "Watchmen", "Jackie Earle Haley").
card(actor_roles, "West Side Story", "George Chakiris").
card(actor_roles, "Whiplash", "J.K. Simmons").
card(actor_roles, "White Chicks", "Marlon Wayans").
card(actor_roles, "White Christmas", "Bing Crosby; Dean Jagger").
card(actor_roles, "Who Framed Roger Rabbit", "Mel Blanc").
card(actor_roles, "Who's Afraid of Virginia Woolf?", "Richard Burton").
card(actor_roles, "Wild Wild West", "Kevin Kline").
card(actor_roles, "Willy Wonka & the Chocolate Factory", "Gene Wilder; Jack Albertson").
card(actor_roles, "Witness for the Prosecution", "Charles Laughton").
card(actor_roles, "Wo hu cang long", "Yun-Fat Chow").
card(actor_roles, "X-Men Origins: Wolverine", "Taylor Kitsch").
card(actor_roles, "X-Men", "Bruce Davison").
card(actor_roles, "X2", "Brian Cox").
card(actor_roles, "Yôjinbô", "Toshirô Mifune").
card(actor_roles, "Zoolander (Producer)", "Ben Stiller").
card(actress_roles, "10 Cloverfield Lane", "Mary Elizabeth Winstead").
card(actress_roles, "10 Things I Hate About You", "Julia Stiles").
card(actress_roles, "12 Years a Slave", "Lupita Nyong'o").
card(actress_roles, "2012", "Amanda Peet").
card(actress_roles, "30 Rock (Writer)", "Tina Fey").
card(actress_roles, "300", "Lena Headey").
card(actress_roles, "45 Years", "Charlotte Rampling").
card(actress_roles, "8 femmes", "Catherine Deneuve").
card(actress_roles, "A Beautiful Mind", "Jennifer Connelly").
card(actress_roles, "A Cinderella Story", "Hilary Duff; Jennifer Coolidge").
card(actress_roles, "A History of Violence", "Maria Bello").
card(actress_roles, "A Passage to India", "Peggy Ashcroft").
card(actress_roles, "A Series of Unfortunate Events", "Emily Browning").
card(actress_roles, "A Star Is Born", "Janet Gaynor").
card(actress_roles, "A Streetcar Named Desire", "Kim Hunter; Vivien Leigh").
card(actress_roles, "A Walk to Remember", "Mandy Moore").
card(actress_roles, "Airport", "Helen Hayes").
card(actress_roles, "Albert Nobbs", "Janet McTeer").
card(actress_roles, "Alias", "Jennifer Garner").
card(actress_roles, "Alien: Resurrection", "Sigourney Weaver").
card(actress_roles, "All About Eve", "Anne Baxter; Bette Davis; Celeste Holm").
card(actress_roles, "Almost Famous", "Kate Hudson").
card(actress_roles, "American Beauty", "Annette Bening").
card(actress_roles, "American Crime", "Lili Taylor").
card(actress_roles, "American Gangster", "Ruby Dee").
card(actress_roles, "Amour", "Emmanuelle Riva").
card(actress_roles, "Anna", "Sally Kirkland").
card(actress_roles, "Annie Hall", "Diane Keaton").
card(actress_roles, "Another Earth", "Brit Marling").
card(actress_roles, "Ant-Man", "Evangeline Lilly").
card(actress_roles, "Apollo 13", "Kathleen Quinlan").
card(actress_roles, "Aquaman", "Amber Heard").
card(actress_roles, "Arrival", "Amy Adams").
card(actress_roles, "As Good as It Gets", "Helen Hunt").
card(actress_roles, "Atonement", "Vanessa Redgrave").
card(actress_roles, "Auntie Mame", "Rosalind Russell").
card(actress_roles, "Avatar", "Michelle Rodriguez; Zoe Saldana").
card(actress_roles, "Babel", "Adriana Barraza; Rinko Kikuchi").
card(actress_roles, "Bad Times at the El Royale", "Cynthia Erivo").
card(actress_roles, "Banshun", "Setsuko Hara").
card(actress_roles, "Basic Instinct", "Sharon Stone").
card(actress_roles, "Batman Begins", "Katie Holmes").
card(actress_roles, "Battlestar Galactica", "Mary McDonnell").
card(actress_roles, "Baywatch", "Alexandra Daddario; Priyanka Chopra").
card(actress_roles, "Before We Go", "Alice Eve").
card(actress_roles, "Being John Malkovich", "Catherine Keener").
card(actress_roles, "Big Hero 6", "Jamie Chung").
card(actress_roles, "Big Love", "Ginnifer Goodwin").
card(actress_roles, "Big Momma's House", "Nia Long").
card(actress_roles, "Billy Elliot", "Julie Walters").
card(actress_roles, "Birdman or (The Unexpected Virtue of Ignorance)", "Amy Ryan; Andrea Riseborough").
card(actress_roles, "Black Swan", "Mila Kunis; Natalie Portman").
card(actress_roles, "Bombshell", "Jean Harlow").
card(actress_roles, "Bonnie and Clyde", "Estelle Parsons").
card(actress_roles, "Born Yesterday", "Judy Holliday").
card(actress_roles, "Breakfast at Tiffany's", "Audrey Hepburn").
card(actress_roles, "Breaking the Waves", "Emily Watson").
card(actress_roles, "Bridesmaids", "Jill Clayburgh; Kristen Wiig; Maya Rudolph").
card(actress_roles, "Bridge to Terabithia", "AnnaSophia Robb").
card(actress_roles, "Bright Star", "Abbie Cornish").
card(actress_roles, "Bring It On", "Eliza Dushku").
card(actress_roles, "Buffy the Vampire Slayer", "Michelle Trachtenberg; Sarah Michelle Gellar").
card(actress_roles, "C'era una volta il West", "Claudia Cardinale").
card(actress_roles, "Cabaret (Soundtrack)", "Liza Minnelli").
card(actress_roles, "Carol", "Cate Blanchett; Rooney Mara").
card(actress_roles, "Casablanca", "Ingrid Bergman").
card(actress_roles, "Casino Royale", "Eva Green").
card(actress_roles, "Casper", "Christina Ricci").
card(actress_roles, "Catwoman", "Halle Berry").
card(actress_roles, "Central do Brasil", "Fernanda Montenegro").
card(actress_roles, "Chicago", "Catherine Zeta-Jones; Renée Zellweger").
card(actress_roles, "Children of a Lesser God", "Marlee Matlin").
card(actress_roles, "Close Encounters of the Third Kind", "Teri Garr").
card(actress_roles, "Cloverfield", "Jessica Lucas").
card(actress_roles, "Clueless", "Alicia Silverstone").
card(actress_roles, "Come Back, Little Sheba", "Shirley Booth").
card(actress_roles, "Coquette", "Mary Pickford").
card(actress_roles, "Coyote Ugly", "Piper Perabo").
card(actress_roles, "Crash", "Thandie Newton").
card(actress_roles, "Dancer in the Dark (Soundtrack)", "Björk").
card(actress_roles, "Dawn of the Dead", "Sarah Polley").
card(actress_roles, "Deadwood", "Robin Weigert").
card(actress_roles, "Divergent", "Shailene Woodley").
card(actress_roles, "Django Unchained", "Kerry Washington").
card(actress_roles, "Doctor Zhivago", "Julie Christie").
card(actress_roles, "Dodgeball: A True Underdog Story", "Christine Taylor").
card(actress_roles, "Don't Tell Mom the Babysitter's Dead", "Christina Applegate").
card(actress_roles, "Double Indemnity", "Barbara Stanwyck").
card(actress_roles, "Double Jeopardy", "Ashley Judd").
card(actress_roles, "Dreamgirls (Soundtrack)", "Beyoncé; Jennifer Hudson").
card(actress_roles, "Driving Miss Daisy", "Jessica Tandy").
card(actress_roles, "East of Eden", "Jo Van Fleet").
card(actress_roles, "Edge of Tomorrow", "Emily Blunt").
card(actress_roles, "Elle", "Isabelle Huppert").
card(actress_roles, "Elmer Gantry", "Shirley Jones").
card(actress_roles, "Eternal Sunshine of the Spotless Mind", "Kate Winslet").
card(actress_roles, "Ex Machina", "Alicia Vikander").
card(actress_roles, "Falcon Crest", "Jane Wyman").
card(actress_roles, "Fantastic Four", "Jessica Alba; Kate Mara").
card(actress_roles, "Far from Heaven", "Julianne Moore").
card(actress_roles, "Fargo", "Frances McDormand").
card(actress_roles, "Fatal Attraction", "Glenn Close").
card(actress_roles, "Fences", "Viola Davis").
card(actress_roles, "Fifty Shades of Grey", "Dakota Johnson").
card(actress_roles, "First Man", "Claire Foy").
card(actress_roles, "Forrest Gump", "Robin Wright; Sally Field").
card(actress_roles, "Frida", "Salma Hayek").
card(actress_roles, "Friends", "Courteney Cox; Jennifer Aniston; Lisa Kudrow").
card(actress_roles, "Frozen", "Kristen Bell").
card(actress_roles, "Funny Girl (Soundtrack)", "Barbra Streisand").
card(actress_roles, "G.I. Jane", "Demi Moore").
card(actress_roles, "G.I. Joe: Retaliation", "Adrianne Palicki").
card(actress_roles, "Game of Thrones", "Emilia Clarke; Natalie Dormer").
card(actress_roles, "Ghost World", "Thora Birch").
card(actress_roles, "Ghost", "Whoopi Goldberg").
card(actress_roles, "Giant", "Mercedes McCambridge").
card(actress_roles, "Gigli", "Jennifer Lopez").
card(actress_roles, "Gilda", "Rita Hayworth").
card(actress_roles, "Gods and Monsters", "Lynn Redgrave").
card(actress_roles, "Going Hollywood", "Marion Davies").
card(actress_roles, "Gone Girl", "Rosamund Pike").
card(actress_roles, "Gone with the Wind", "Hattie McDaniel").
card(actress_roles, "Gosford Park", "Maggie Smith").
card(actress_roles, "Gossip Girl", "Blake Lively").
card(actress_roles, "Grease (Soundtrack)", "Olivia Newton-John").
card(actress_roles, "Grease", "Stockard Channing").
card(actress_roles, "Grosse Pointe Blank", "Minnie Driver").
card(actress_roles, "Hairspray", "Amanda Bynes; Queen Latifah").
card(actress_roles, "Hanna", "Saoirse Ronan").
card(actress_roles, "Hannah Montana (Soundtrack)", "Miley Cyrus").
card(actress_roles, "Hannah and Her Sisters", "Dianne Wiest").
card(actress_roles, "Harry Potter and the Order of the Phoenix", "Imelda Staunton").
card(actress_roles, "Hidden Figures", "Octavia Spencer").
card(actress_roles, "High School Musical 3: Senior Year", "Vanessa Hudgens").
card(actress_roles, "High Sierra", "Ida Lupino").
card(actress_roles, "Hitch", "Eva Mendes").
card(actress_roles, "Hot Pursuit", "Sofía Vergara").
card(actress_roles, "Hotel Rwanda", "Sophie Okonedo").
card(actress_roles, "House of Sand and Fog", "Shohreh Aghdashloo").
card(actress_roles, "Hud", "Patricia Neal").
card(actress_roles, "Husbands and Wives", "Judy Davis").
card(actress_roles, "I Know What You Did Last Summer", "Jennifer Love Hewitt").
card(actress_roles, "I Love Lucy", "Lucille Ball").
card(actress_roles, "If I Stay", "Mireille Enos").
card(actress_roles, "In a Lonely Place", "Gloria Grahame").
card(actress_roles, "In a World...", "Lake Bell").
card(actress_roles, "In the Bedroom", "Sissy Spacek").
card(actress_roles, "In the Heat of the Night", "Lee Grant").
card(actress_roles, "Inglourious Basterds", "Mélanie Laurent").
card(actress_roles, "Inside Out", "Amy Poehler").
card(actress_roles, "It Happened One Night", "Claudette Colbert").
card(actress_roles, "It's a Wonderful Life", "Donna Reed").
card(actress_roles, "Jackie Brown", "Pam Grier").
card(actress_roles, "Jules et Jim", "Jeanne Moreau").
card(actress_roles, "Jumanji", "Bonnie Hunt").
card(actress_roles, "Juno", "Olivia Thirlby").
card(actress_roles, "Jurassic Park", "Laura Dern").
card(actress_roles, "Key Largo", "Claire Trevor").
card(actress_roles, "Kill Bill: Vol. 1", "Lucy Liu; Uma Thurman").
card(actress_roles, "Kill Bill: Vol. 2", "Daryl Hannah").
card(actress_roles, "Killing Eve", "Sandra Oh").
card(actress_roles, "Kiss Kiss Bang Bang", "Michelle Monaghan").
card(actress_roles, "Klute", "Jane Fonda").
card(actress_roles, "Knocked Up", "Leslie Mann").
card(actress_roles, "Kramer vs. Kramer", "Jane Alexander").
card(actress_roles, "L.A. Confidential", "Kim Basinger").
card(actress_roles, "La La Land", "Emma Stone").
card(actress_roles, "La Môme", "Marion Cotillard").
card(actress_roles, "La boum", "Sophie Marceau").
card(actress_roles, "La passion de Jeanne d'Arc", "Maria Falconetti").
card(actress_roles, "La vie d'Adèle", "Léa Seydoux").
card(actress_roles, "Lady Bird (Writer)", "Greta Gerwig").
card(actress_roles, "Last Vegas", "Mary Steenburgen").
card(actress_roles, "Le fabuleux destin d'Amélie Poulain", "Audrey Tautou").
card(actress_roles, "Leaving Las Vegas", "Elisabeth Shue").
card(actress_roles, "Les Misérables", "Amanda Seyfried; Anne Hathaway").
card(actress_roles, "Les diaboliques", "Simone Signoret").
card(actress_roles, "Let Me In", "Chloë Grace Moretz").
card(actress_roles, "Lights Out", "Teresa Palmer").
card(actress_roles, "Little Miss Sunshine", "Abigail Breslin").
card(actress_roles, "Little Women", "Winona Ryder").
card(actress_roles, "Live and Let Die", "Jane Seymour").
card(actress_roles, "Lola rennt", "Franka Potente").
card(actress_roles, "Lolita", "Sue Lyon").
card(actress_roles, "Lost in Translation", "Scarlett Johansson").
card(actress_roles, "Maleficent", "Angelina Jolie").
card(actress_roles, "Maria Full of Grace", "Catalina Sandino Moreno").
card(actress_roles, "Martha Marcy May Marlene", "Elizabeth Olsen").
card(actress_roles, "Mighty Aphrodite", "Mira Sorvino").
card(actress_roles, "Million Dollar Baby", "Hilary Swank").
card(actress_roles, "Min and Bill", "Marie Dressler").
card(actress_roles, "Minority Report", "Samantha Morton").
card(actress_roles, "Misery", "Kathy Bates").
card(actress_roles, "Miss Congeniality (Producer)", "Sandra Bullock").
card(actress_roles, "Mission: Impossible - Ghost Protocol", "Paula Patton").
card(actress_roles, "Monster (Producer)", "Charlize Theron").
card(actress_roles, "Monte Carlo", "Selena Gomez").
card(actress_roles, "Moonstruck", "Cher; Olympia Dukakis").
card(actress_roles, "Moulin Rouge!", "Nicole Kidman").
card(actress_roles, "Mr. Smith Goes to Washington", "Jean Arthur").
card(actress_roles, "Mrs. Miniver", "Greer Garson").
card(actress_roles, "Mulholland Dr.", "Naomi Watts").
card(actress_roles, "Murder on the Orient Express", "Wendy Hiller").
card(actress_roles, "My Cousin Vinny", "Marisa Tomei").
card(actress_roles, "My Left Foot: The Story of Christy Brown", "Brenda Fricker").
card(actress_roles, "My So-Called Life", "Claire Danes").
card(actress_roles, "My Week with Marilyn", "Michelle Williams").
card(actress_roles, "Mystic River", "Marcia Gay Harden").
card(actress_roles, "Män som hatar kvinnor", "Noomi Rapace").
card(actress_roles, "Nashville", "Lily Tomlin").
card(actress_roles, "Natural Born Killers", "Juliette Lewis").
card(actress_roles, "Nebraska", "June Squibb").
card(actress_roles, "Network", "Beatrice Straight; Faye Dunaway").
card(actress_roles, "Never Been Kissed (Producer)", "Drew Barrymore").
card(actress_roles, "Never Let Me Go", "Carey Mulligan").
card(actress_roles, "New Girl", "Zooey Deschanel").
card(actress_roles, "Nick and Norah's Infinite Playlist", "Kat Dennings").
card(actress_roles, "Nightcrawler", "Rene Russo").
card(actress_roles, "Ninotchka", "Greta Garbo").
card(actress_roles, "None But the Lonely Heart", "Ethel Barrymore").
card(actress_roles, "On the Waterfront", "Eva Marie Saint").
card(actress_roles, "One Flew Over the Cuckoo's Nest", "Louise Fletcher").
card(actress_roles, "One for the Money", "Katherine Heigl").
card(actress_roles, "Ordinary People", "Mary Tyler Moore").
card(actress_roles, "Out of Africa", "Meryl Streep").
card(actress_roles, "Overboard", "Goldie Hawn").
card(actress_roles, "Paper Moon", "Tatum O'Neal").
card(actress_roles, "Parks and Recreation", "Rashida Jones").
card(actress_roles, "Phantom Thread", "Lesley Manville").
card(actress_roles, "Pillow Talk (Soundtrack)", "Doris Day").
card(actress_roles, "Pirates of the Caribbean: The Curse of the Black Pearl", "Keira Knightley").
card(actress_roles, "Pitch Perfect", "Brittany Snow; Rebel Wilson").
card(actress_roles, "Possession", "Isabelle Adjani").
card(actress_roles, "Precious", "Gabourey Sidibe; Mo'Nique").
card(actress_roles, "Pretty Woman", "Julia Roberts").
card(actress_roles, "Pride & Prejudice", "Brenda Blethyn").
card(actress_roles, "Prince of Persia: The Sands of Time", "Gemma Arterton").
card(actress_roles, "Psycho", "Janet Leigh").
card(actress_roles, "RED", "Helen Mirren").
card(actress_roles, "Rachel, Rachel", "Joanne Woodward").
card(actress_roles, "Ray", "Regina King").
card(actress_roles, "Rear Window", "Grace Kelly").
card(actress_roles, "Rebel Without a Cause", "Natalie Wood").
card(actress_roles, "Reds", "Maureen Stapleton").
card(actress_roles, "Rent", "Rosario Dawson").
card(actress_roles, "Requiem for a Dream", "Ellen Burstyn").
card(actress_roles, "Rock of Ages", "Julianne Hough").
card(actress_roles, "Rocky", "Talia Shire").
card(actress_roles, "Rogue One", "Felicity Jones").
card(actress_roles, "Roma città aperta", "Anna Magnani").
card(actress_roles, "Romancing the Stone", "Kathleen Turner").
card(actress_roles, "Room", "Brie Larson; Joan Allen").
card(actress_roles, "Rosemary's Baby", "Mia Farrow; Ruth Gordon").
card(actress_roles, "Sayonara", "Miyoshi Umeki").
card(actress_roles, "Scream 3", "Parker Posey").
card(actress_roles, "Scream", "Neve Campbell").
card(actress_roles, "Secretary", "Maggie Gyllenhaal").
card(actress_roles, "Seinfeld", "Julia Louis-Dreyfus").
card(actress_roles, "Sense and Sensibility", "Emma Thompson").
card(actress_roles, "Sex and the City", "Sarah Jessica Parker").
card(actress_roles, "Shadow of a Doubt", "Teresa Wright").
card(actress_roles, "Shakespeare in Love", "Gwyneth Paltrow").
card(actress_roles, "She Done Him Wrong", "Mae West").
card(actress_roles, "Shirley Valentine", "Pauline Collins").
card(actress_roles, "Sideways", "Virginia Madsen").
card(actress_roles, "Silver Linings Playbook", "Jacki Weaver").
card(actress_roles, "Singin' in the Rain", "Debbie Reynolds").
card(actress_roles, "Six Feet Under", "Rachel Griffiths").
card(actress_roles, "Sixteen Candles", "Molly Ringwald").
card(actress_roles, "Skyfall", "Judi Dench").
card(actress_roles, "Slumdog Millionaire", "Freida Pinto").
card(actress_roles, "Snow White and the Huntsman", "Kristen Stewart").
card(actress_roles, "Some Like It Hot", "Marilyn Monroe").
card(actress_roles, "Spider-Man", "Kirsten Dunst").
card(actress_roles, "Spy", "Rose Byrne").
card(actress_roles, "Star Wars: Episode VIII - The Last Jedi", "Carrie Fisher").
card(actress_roles, "Stoker", "Mia Wasikowska").
card(actress_roles, "Strange Days", "Angela Bassett").
card(actress_roles, "Suicide Squad", "Margot Robbie").
card(actress_roles, "Sunset Blvd.", "Gloria Swanson").
card(actress_roles, "Superman Returns", "Kate Bosworth").
card(actress_roles, "Superman", "Margot Kidder").
card(actress_roles, "Suspicion", "Joan Fontaine").
card(actress_roles, "Sweeney Todd: The Demon Barber of Fleet Street", "Helena Bonham Carter").
card(actress_roles, "Sweet Bird of Youth", "Geraldine Page").
card(actress_roles, "Taken", "Maggie Grace").
card(actress_roles, "Terminator 2: Judgment Day", "Linda Hamilton").
card(actress_roles, "Terms of Endearment", "Debra Winger; Shirley MacLaine").
card(actress_roles, "Tess", "Nastassja Kinski").
card(actress_roles, "The Act", "Joey King").
card(actress_roles, "The Artist", "Bérénice Bejo").
card(actress_roles, "The Avengers", "Cobie Smulders").
card(actress_roles, "The Bad Seed", "Eileen Heckart").
card(actress_roles, "The Big Bang Theory", "Kaley Cuoco").
card(actress_roles, "The Big C", "Laura Linney").
card(actress_roles, "The Bodyguard (Soundtrack)", "Whitney Houston").
card(actress_roles, "The Carol Burnett Show (Soundtrack)", "Carol Burnett").
card(actress_roles, "The Constant Gardener", "Rachel Weisz").
card(actress_roles, "The Craft", "Fairuza Balk").
card(actress_roles, "The Crying Game", "Miranda Richardson").
card(actress_roles, "The Curious Case of Benjamin Button", "Taraji P. Henson").
card(actress_roles, "The Divorcee", "Norma Shearer").
card(actress_roles, "The English Patient", "Juliette Binoche; Kristin Scott Thomas").
card(actress_roles, "The Falling", "Florence Pugh").
card(actress_roles, "The Family Man", "Téa Leoni").
card(actress_roles, "The Farmer's Daughter", "Loretta Young").
card(actress_roles, "The Favourite", "Olivia Colman").
card(actress_roles, "The Fifth Element", "Milla Jovovich").
card(actress_roles, "The Fighter", "Melissa Leo").
card(actress_roles, "The First Wives Club (Soundtrack)", "Bette Midler").
card(actress_roles, "The Fisher King", "Mercedes Ruehl").
card(actress_roles, "The Gang's All Here", "Carmen Miranda").
card(actress_roles, "The Goodbye Girl", "Marsha Mason").
card(actress_roles, "The Graduate", "Anne Bancroft").
card(actress_roles, "The Grapes of Wrath", "Jane Darwell").
card(actress_roles, "The Great Ziegfeld", "Luise Rainer").
card(actress_roles, "The Grifters", "Anjelica Huston").
card(actress_roles, "The Hateful Eight", "Jennifer Jason Leigh").
card(actress_roles, "The Heat", "Melissa McCarthy").
card(actress_roles, "The Heiress", "Olivia de Havilland").
card(actress_roles, "The Help", "Allison Janney").
card(actress_roles, "The House Bunny", "Anna Faris").
card(actress_roles, "The Hunger Games", "Elizabeth Banks; Jennifer Lawrence").
card(actress_roles, "The Hunger Games: Mockingjay - Part 2", "Jena Malone").
card(actress_roles, "The Hustler", "Piper Laurie").
card(actress_roles, "The Illusionist", "Jessica Biel").
card(actress_roles, "The Invisible Man", "Elisabeth Moss").
card(actress_roles, "The King and I", "Deborah Kerr").
card(actress_roles, "The Last Picture Show", "Cloris Leachman").
card(actress_roles, "The Last Seduction", "Linda Fiorentino").
card(actress_roles, "The Lion in Winter", "Katharine Hepburn").
card(actress_roles, "The Little Colonel", "Shirley Temple").
card(actress_roles, "The Lord of the Rings: The Return of the King", "Liv Tyler").
card(actress_roles, "The Major and the Minor", "Ginger Rogers").
card(actress_roles, "The Maltese Falcon", "Mary Astor").
card(actress_roles, "The Man from Earth", "Alexis Thorpe").
card(actress_roles, "The Manchurian Candidate", "Angela Lansbury").
card(actress_roles, "The Mark of Zorro", "Gale Sondergaard").
card(actress_roles, "The Matrix Revolutions", "Jada Pinkett Smith").
card(actress_roles, "The Matrix", "Carrie-Anne Moss").
card(actress_roles, "The Mortal Instruments: City of Bones", "Lily Collins").
card(actress_roles, "The Night of the Hunter", "Lillian Gish").
card(actress_roles, "The Night of the Iguana", "Ava Gardner").
card(actress_roles, "The Notebook", "Gena Rowlands; Rachel McAdams").
card(actress_roles, "The Office", "Mindy Kaling").
card(actress_roles, "The Parent Trap", "Lindsay Lohan").
card(actress_roles, "The Perks of Being a Wallflower", "Emma Watson").
card(actress_roles, "The Phantom of the Opera", "Emmy Rossum").
card(actress_roles, "The Piano", "Anna Paquin; Holly Hunter").
card(actress_roles, "The Poseidon Adventure", "Shelley Winters").
card(actress_roles, "The Proposal", "Betty White").
card(actress_roles, "The Quiet Man", "Maureen O'Hara").
card(actress_roles, "The Roommate", "Leighton Meester").
card(actress_roles, "The Shape of Water", "Sally Hawkins").
card(actress_roles, "The Silence of the Lambs", "Jodie Foster").
card(actress_roles, "The Sixth Sense", "Toni Collette").
card(actress_roles, "The Sound of Music", "Julie Andrews").
card(actress_roles, "The Station Agent", "Patricia Clarkson").
card(actress_roles, "The Thin Man", "Myrna Loy").
card(actress_roles, "The Three Musketeers", "Raquel Welch").
card(actress_roles, "The Towering Inferno", "Jennifer Jones").
card(actress_roles, "The Wizard of Oz", "Judy Garland").
card(actress_roles, "The X Files", "Gillian Anderson").
card(actress_roles, "The Year of Living Dangerously", "Linda Hunt").
card(actress_roles, "Thelma & Louise", "Geena Davis; Susan Sarandon").
card(actress_roles, "Thirteen", "Evan Rachel Wood").
card(actress_roles, "Titanic", "Gloria Stuart").
card(actress_roles, "To Be or Not to Be", "Carole Lombard").
card(actress_roles, "To Have and Have Not", "Lauren Bacall").
card(actress_roles, "Tootsie", "Jessica Lange").
card(actress_roles, "Transamerica", "Felicity Huffman").
card(actress_roles, "Transformers", "Megan Fox").
card(actress_roles, "Trois couleurs: Blanc", "Julie Delpy").
card(actress_roles, "Tron", "Olivia Wilde").
card(actress_roles, "True Grit", "Hailee Steinfeld").
card(actress_roles, "True Lies", "Jamie Lee Curtis").
card(actress_roles, "True Romance", "Patricia Arquette").
card(actress_roles, "Una giornata particolare", "Sophia Loren").
card(actress_roles, "Underworld: Evolution", "Kate Beckinsale").
card(actress_roles, "Unfaithful", "Diane Lane").
card(actress_roles, "Up in the Air", "Anna Kendrick; Vera Farmiga").
card(actress_roles, "Valley of the Dolls", "Patty Duke").
card(actress_roles, "Vanilla Sky", "Cameron Diaz").
card(actress_roles, "Vertigo", "Kim Novak").
card(actress_roles, "Vicky Cristina Barcelona", "Penélope Cruz; Rebecca Hall").
card(actress_roles, "Viskningar och rop", "Liv Ullmann").
card(actress_roles, "Waitress", "Keri Russell").
card(actress_roles, "War of the Worlds", "Dakota Fanning").
card(actress_roles, "We Are Who We Are", "Chloë Sevigny").
card(actress_roles, "We Need to Talk About Kevin", "Tilda Swinton").
card(actress_roles, "We're the Millers", "Emma Roberts").
card(actress_roles, "Wedding Crashers", "Isla Fisher").
card(actress_roles, "West Side Story", "Rita Moreno").
card(actress_roles, "Whale Rider", "Keisha Castle-Hughes").
card(actress_roles, "What Ever Happened to Baby Jane?", "Joan Crawford").
card(actress_roles, "What Lies Beneath", "Michelle Pfeiffer").
card(actress_roles, "When Harry Met Sally...", "Meg Ryan").
card(actress_roles, "Who's Afraid of Virginia Woolf?", "Elizabeth Taylor; Sandy Dennis").
card(actress_roles, "Wild (Producer)", "Reese Witherspoon").
card(actress_roles, "With a Song in My Heart", "Susan Hayward").
card(actress_roles, "Witness for the Prosecution (Soundtrack)", "Marlene Dietrich").
card(actress_roles, "Wo hu cang long", "Michelle Yeoh").
card(actress_roles, "Women in Love", "Glenda Jackson").
card(actress_roles, "Wonder Woman", "Gal Gadot").
card(actress_roles, "Working Girl", "Melanie Griffith").
card(actress_roles, "Written on the Wind", "Dorothy Malone").
card(actress_roles, "X-Men: The Last Stand", "Famke Janssen").
card(actress_roles, "X: First Class", "January Jones").
card(actress_roles, "Yi dai zong shi", "Ziyi Zhang").
card(actress_roles, "Zero Dark Thirty", "Jessica Chastain").
card(actress_roles, "À bout de souffle", "Jean Seberg").
card(baroque_paintings, "A Fantastic Cave with Odysseus and Calypso", "Jan Brueghel the Elder").
card(baroque_paintings, "Ahimelech Giving the Sword of Goliath to David", "Aert de Gelder").
card(baroque_paintings, "Alethea Talbot with her Husband", "Peter Paul Rubens").
card(baroque_paintings, "Allegory of War", "Jan Brueghel the Younger").
card(baroque_paintings, "Arctic Adventure", "Abraham Hondius").
card(baroque_paintings, "Banquet Still Life", "Abraham van Beijeren").
card(baroque_paintings, "Boys Eating Grapes and Melon", "Bartolomé Esteban Murillo").
card(baroque_paintings, "Brothel Scene", "Nikolaus Knüpfer").
card(baroque_paintings, "Children Teaching a Cat to Dance", "Jan Steen").
card(baroque_paintings, "Christ in the House of Martha and Mary", "Jan Brueghel the Younger, Peter Paul Rubens").
card(baroque_paintings, "Concert", "Dirck van Baburen").
card(baroque_paintings, "Creation of Adam", "Jan Brueghel the Younger").
card(baroque_paintings, "David Gives Uriah a Letter for Joab", "Pieter Lastman").
card(baroque_paintings, "David Playing the Harp", "Jan de Bray").
card(baroque_paintings, "David and Uriah", "Rembrandt").
card(baroque_paintings, "Dedication of a New Vestal Virgin", "Alessandro Marchesini").
card(baroque_paintings, "Distribution of Loaves to the Poor", "David Vinckboons").
card(baroque_paintings, "Domine quo vadis?", "Annibale Carracci").
card(baroque_paintings, "Drunken Silenus", "Jusepe de Ribera").
card(baroque_paintings, "Esther and Ahasuerus", "Artemisia Gentileschi").
card(baroque_paintings, "Flora", "Rembrandt").
card(baroque_paintings, "Fruit and Vegetables with a Monkey, Parrot and Squirrel", "Franz Snyders").
card(baroque_paintings, "Girl Eating an Apple", "Godfried Schalcken").
card(baroque_paintings, "Girl at a Window", "Rembrandt").
card(baroque_paintings, "Great Fish Market", "Jan Brueghel the Elder").
card(baroque_paintings, "Hendrickje Bathing in a River", "Rembrandt").
card(baroque_paintings, "Infanta Margarita Teresa in a Blue Dress", "Diego Velázquez").
card(baroque_paintings, "Infanta Margarita Teresa in a Pink Dress", "Diego Velázquez").
card(baroque_paintings, "Jacob Wrestling with the Angel", "Rembrandt").
card(baroque_paintings, "Judith Beheading Holofernes", "Artemisia Gentileschi").
card(baroque_paintings, "Judith and her Maidservant", "Artemisia Gentileschi").
card(baroque_paintings, "King David Handing the Letter to Uriah", "Pieter Lastman").
card(baroque_paintings, "Kitchen Scene", "Joachim Beuckelaer").
card(baroque_paintings, "Landscape with a Huntsman and Dead Game", "Jan Weenix").
card(baroque_paintings, "Laughing Cavalier", "Frans Hals").
card(baroque_paintings, "Lucretia", "Rembrandt").
card(baroque_paintings, "Marriage Portrait of Isaac Massa and Beatrix van der Laen", "Frans Hals").
card(baroque_paintings, "Martyrdom of St. Philip", "Jusepe de Ribera").
card(baroque_paintings, "Mary Magdalene in the Desert", "Jusepe de Ribera").
card(baroque_paintings, "Mercury", "Hendrik Goltzius").
card(baroque_paintings, "Narcissus", "Caravaggio").
card(baroque_paintings, "Noli me tangere", "Jan Brueghel the Younger").
card(baroque_paintings, "Paradise", "Jan Brueghel the Younger").
card(baroque_paintings, "Peacocks", "Melchior d'Hondecoeter").
card(baroque_paintings, "Peasants Before an Inn", "Jan Steen").
card(baroque_paintings, "Pietà", "Jusepe de Ribera").
card(baroque_paintings, "Portrait of Abraham van Lennep", "Caspar Netscher").
card(baroque_paintings, "Portrait of Titus", "Rembrandt").
card(baroque_paintings, "Portrait of a Lady", "Thomas de Keyser").
card(baroque_paintings, "Portrait of a Man", "Diego Velázquez").
card(baroque_paintings, "Portrait of an Elderly Lady", "Frans Hals").
card(baroque_paintings, "Portrait of the Lomellini Family", "Anthony van Dyck").
card(baroque_paintings, "Prometheus Being Chained by Vulcan", "Dirck van Baburen").
card(baroque_paintings, "Sleeping Cupid", "Battistello Caracciolo").
card(baroque_paintings, "The Flagellation of Christ", "Caravaggio").
card(baroque_paintings, "The Rape of the Daughters of Leucippus", "Peter Paul Rubens").
card(combinations, "C(1, 1)", "1").
card(combinations, "C(10, 1)", "10").
card(combinations, "C(10, 10)", "1").
card(combinations, "C(10, 2)", "45").
card(combinations, "C(10, 3)", "120").
card(combinations, "C(10, 4)", "210").
card(combinations, "C(10, 5)", "252").
card(combinations, "C(10, 6)", "210").
card(combinations, "C(10, 7)", "120").
card(combinations, "C(10, 8)", "45").
card(combinations, "C(10, 9)", "10").
card(combinations, "C(2, 1)", "2").
card(combinations, "C(2, 2)", "1").
card(combinations, "C(3, 1)", "3").
card(combinations, "C(3, 2)", "3").
card(combinations, "C(3, 3)", "1").
card(combinations, "C(4, 1)", "4").
card(combinations, "C(4, 2)", "6").
card(combinations, "C(4, 3)", "4").
card(combinations, "C(4, 4)", "1").
card(combinations, "C(5, 1)", "5").
card(combinations, "C(5, 2)", "10").
card(combinations, "C(5, 3)", "10").
card(combinations, "C(5, 4)", "5").
card(combinations, "C(5, 5)", "1").
card(combinations, "C(6, 1)", "6").
card(combinations, "C(6, 2)", "15").
card(combinations, "C(6, 3)", "20").
card(combinations, "C(6, 4)", "15").
card(combinations, "C(6, 5)", "6").
card(combinations, "C(6, 6)", "1").
card(combinations, "C(7, 1)", "7").
card(combinations, "C(7, 2)", "21").
card(combinations, "C(7, 3)", "35").
card(combinations, "C(7, 4)", "35").
card(combinations, "C(7, 5)", "21").
card(combinations, "C(7, 6)", "7").
card(combinations, "C(7, 7)", "1").
card(combinations, "C(8, 1)", "8").
card(combinations, "C(8, 2)", "28").
card(combinations, "C(8, 3)", "56").
card(combinations, "C(8, 4)", "70").
card(combinations, "C(8, 5)", "56").
card(combinations, "C(8, 6)", "28").
card(combinations, "C(8, 7)", "8").
card(combinations, "C(8, 8)", "1").
card(combinations, "C(9, 1)", "9").
card(combinations, "C(9, 2)", "36").
card(combinations, "C(9, 3)", "84").
card(combinations, "C(9, 4)", "126").
card(combinations, "C(9, 5)", "126").
card(combinations, "C(9, 6)", "84").
card(combinations, "C(9, 7)", "36").
card(combinations, "C(9, 8)", "9").
card(combinations, "C(9, 9)", "1").
card(ethics, "A Theory of Justice", "Book of political philosophy and ethics by John Rawls on problem of distributive justice").
card(ethics, "Amnesty International", "London-based non-governmental organization focused on human rights").
card(ethics, "Belmont Report", "Summary of ethical principles and areas of application for research involving human subjects").
card(ethics, "Christian ethics", "Virtue ethics regarding rich and poor, treatment of women, and the morality of war").
card(ethics, "Confucianism", "Traditional Chinese school that emphasizes the importance of the family and social harmony").
card(ethics, "Cynicism", "Good life comes from using self-control to achieve virtue and avoid wealth, power, sex, and fame").
card(ethics, "Declaration of Helsinki", "Set of ethical principles regarding human experimentation developed for the medical community by the World Medical Association (WMA).").
card(ethics, "Epicureanism", "Materialist philosophy that moderation in seeking pleasure leads to equanimity and virtue").
card(ethics, "Eudemian Ethics", "Shorter secondary work on ethics by Aristotle that has much in common with his Nicomachean Ethics").
card(ethics, "European Convention on Human Rights", "International treaty to protect human rights and political freedoms in Europe").
card(ethics, "European Court of Human Rights", "International court established by the European Convention on Human Rights").
card(ethics, "Euthyphro dilemma", "Is what is morally good commanded by God because it is morally good, or is it morally good because God commands it?").
card(ethics, "Geneva Conventions", "Treaties and protocols that establish the standards of international law for humanitarian treatment in war").
card(ethics, "Golden Rule", "Principle that one should treat other people as one would want to be treated by them").
card(ethics, "Greenpeace", "Environmental organization that focuses on climate change, deforestation, overfishing, commercial whaling, genetic engineering, and anti-nuclear issues").
card(ethics, "Hastings Center", "First bioethics research organization, which was important in establishing bioethics as a field of study").
card(ethics, "Hedonism", "Belief that pleasure or happiness is the highest good in life").
card(ethics, "Hippocratic Oath", "Religious vow taken by physicians to uphold ethical standards such as medical confidentiality and nonmaleficence").
card(ethics, "Homosexuality", "Romantic or sexual attraction or behavior between members of the same sex or gender").
card(ethics, "Human Rights Watch (HRW)", "International non-governmental organization that conducts research and advocacy on human rights").
card(ethics, "International Covenant on Civil and Political Rights (ICCPR)", "Multilateral treaty adopted by the United Nations to respect the civil and political rights of individuals").
card(ethics, "Jewish ethics", "Long tradition of moral thinking based on the Torah, rabbinical writings, medieval and modern philosophy").
card(ethics, "Kingdom of Ends", "Hypothetical realm of people who agree to be bound by the categorical imperative; Thought experiment of Immanuel Kant").
card(ethics, "Milgram experiment", "Series of social psychology experiments on obedience to authority figures").
card(ethics, "Nicomachean Ethics", "Ten books on ethics by Aristotle which became a core work of Medieval philosophy").
card(ethics, "Nuremberg Code", "Research ethics principles for human experimentation set at the end of the Second World War").
card(ethics, "Nuremberg defense", "Legal plea that a person not be held guilty for actions ordered by a superior officer").
card(ethics, "Nuremberg principles", "Guidelines for determining what constitutes a war crime which were used to judge Nazis").
card(ethics, "People for the Ethical Treatment of Animals (PETA)", "Largest animal rights group in the world").
card(ethics, "Random Acts of Kindness Day", "Holiday started in New Zealand to celebrate and encourage small spontaneous good deeds").
card(ethics, "Ring of Gyges", "Greek myth that asks if a person would continue being moral if they were invisible and could avoid punishment").
card(ethics, "Roko's basilisk", "Future AI system tortures simulations of those who did not work to bring the system into existence; Thought experiment of LessWrong contributor Roko").
card(ethics, "Stoicism", "Seek virtue by treating others fairly, being part of nature's plan, and exercising self-control over pleasure and pain").
card(ethics, "Tuskegee syphilis experiment", "Infamous, unethical, and malicious clinical study conducted by the U.S. Public Health Service").
card(ethics, "Universal Declaration of Human Rights", "Non-binding document adopted by the United Nations affirming individual rights").
card(ethics, "World Kindness Day", "International holiday to perform or recognize good deeds in the community").
card(ethics, "abolitionism", "General term which describes the movement to end slavery").
card(ethics, "abortion", "Cessation of pregnancy or fetal development, especially when medically induced").
card(ethics, "accountability", "Being required to answer for how you managed a responsibility").
card(ethics, "act and omissions doctrine", "There is a moral distinction between actions and deliberate non-actions which lead to the same outcome").
card(ethics, "act utilitarianism", "Giving more weight to specific outcomes rather than general prescriptions when weighing the morality of an action").
card(ethics, "addiction", "Compulsive drug use or engagement in rewarding behavior, despite negative consequences").
card(ethics, "adultery", "Extramarital sex that is objectionable on social, religious, moral, or legal grounds").
card(ethics, "altruism", "Unselfish devotion to the welfare of others").
card(ethics, "amoral", "Neutral with regard to morality").
card(ethics, "anarchist ethics", "Morality is a social approach grounded in evolution that emphasizes freedom, equality, and reciprocal good treatment").
card(ethics, "anger", "Strong feeling of displeasure or hostility towards someone, usually combined with an urge to harm").
card(ethics, "animal ethics", "Term used in academia to describe human-animal relationships and how animals ought to be treated").
card(ethics, "animal liberation", "Social movement dedicated to the advancement of the interests and rights of non-human animals").
card(ethics, "animal rights", "Concept that animals have certain fundamental rights such as the right to be spared undue suffering").
card(ethics, "animal testing", "Use of non-human animals in scientific and medical experiments").
card(ethics, "anthropocentrism", "Belief that human beings are exceptional and supreme among all creatures within their environment").
card(ethics, "applied ethics", "Branch of ethics that studies morality in a particular area of practical concern, such as business or medicine").
card(ethics, "aretaic", "Pertaining to virtue or excellence").
card(ethics, "arete", "Excellence of any kind, especially in taking effective action that lives up to one's potential").
card(ethics, "authenticity", "Being true to one's own personality, spirit, or character, despite external pressures").
card(ethics, "authority", "Power to enforce rules or give orders").
card(ethics, "autonomy", "Capacity to make an informed, uncoerced decision").
card(ethics, "axiology", "Philosophical study of value, combining ethics and aesthetics").
card(ethics, "beneficence", "Ethical principle that one should do good and prevent harm").
card(ethics, "bias", "Unfair partiality in favor of a person or group or against another").
card(ethics, "biocentrism", "Belief that all life has inherent value and that people are not at the center of things").
card(ethics, "bioethics", "Branch of ethics that studies the implications of biological and biomedical advances").
card(ethics, "blame", "Being given accountability for actions that are morally wrong").
card(ethics, "bribery", "Giving or receiving something of value for some kind of influence or action in return").
card(ethics, "business ethics", "Study of morality in economic organizations").
card(ethics, "capital punishment; death penalty", "Government-sanctioned practice whereby a person is put to death by the state as a punishment for a crime").
card(ethics, "cardinal virtues", "Prudence, courage, temperance, and justice, which were important to Plato and other classical philosophers").
card(ethics, "care ethics", "Feminist virtue ethics whose values include the importance of empathetic relationships and compassion").
card(ethics, "care", "Personal or medical treatment of those in need").
card(ethics, "casuistry", "Rule-based reasoning used to resolve moral problems, often in a clever but unsound manner").
card(ethics, "censorship", "Use of state or group power to control freedom of expression or press").
card(ethics, "character", "Consistent personal habit of practicing moral virtues").
card(ethics, "chastity", "Sexual abstinence, especially in premarital and extramarital sex").
card(ethics, "cheating", "Act of deception, fraud, trickery, imposture, or infidelity").
card(ethics, "cloning", "Process of producing genetically identical individuals of an organism either naturally or artificially").
card(ethics, "coercion", "Use of physical or moral force to compel a person to do or not do something, depriving them of free will").
card(ethics, "cognitive dissonance", "Conflict or anxiety resulting from inconsistencies between one's beliefs and one's actions or other beliefs").
card(ethics, "cognitivism", "Ethical sentences express propositions and thus can be true or false").
card(ethics, "collectivism", "Cultural value characterized by an emphasis on cohesiveness among individuals and prioritization of the group over self").
card(ethics, "communitarianism", "Individual identity and personality are molded by relationships").
card(ethics, "comparative ethics", "Type of descriptive ethics which studies the beliefs about morality held by people in diverse social or cultural groups").
card(ethics, "compassion", "Deep awareness of the suffering of another, coupled with the wish to relieve it").
card(ethics, "confidentiality", "Set of rules or an agreement to keep certain information private").
card(ethics, "conflict of interest", "Situation in which someone in a position of trust has competing professional or personal interests").
card(ethics, "conscience", "Emotional or intuitive moral sense of right and wrong which affects one's behavior").
card(ethics, "consent", "When one person voluntarily agrees to the proposal or desires of another").
card(ethics, "consequentialism", "Judging the morality of an action based on whether its outcome is good or bad").
card(ethics, "conservation movement", "protecting natural resources including animal and plant species as well as their habitat for the future").
card(ethics, "conventional", "Kohlberg stage of development involving conforming to social norms and maintaining law and order").
card(ethics, "corporate social responsibility (CSR)", "Voluntary self-regulation, sustainable practices, and philanthropy that goes beyond minimum legal requirements for a business").
card(ethics, "corruption", "Act of impairing integrity, virtue, or moral principle, especially when someone in authority acts for personal benefit").
card(ethics, "courage", "Willingness to take moral action when confronted with physical harm or popular opposition").
card(ethics, "death penalty", "Punishment in which the offender is put to death by the state").
card(ethics, "death", "Cessation of all biological functions that sustain a living organism").
card(ethics, "decadence", "Perceived decay in standards, morals, dignity, or competence among the members of the social elite").
card(ethics, "deep ecology", "Promoting the inherent worth of living beings regardless of their instrumental utility to human needs").
card(ethics, "defamation", "Damaging someone's reputation by either slander or libel").
card(ethics, "deontic", "Pertaining to necessity, duty or obligation").
card(ethics, "deontology", "Judging the morality of an action based on its adherence to rules or obligations").
card(ethics, "descriptive ethics", "Study of people's beliefs about morality, in contrast to normative ethics and metaethics").
card(ethics, "dignity", "Elevation of mind or character that is worthy of esteem").
card(ethics, "diligence", "Willingness to work persistently and carefully").
card(ethics, "dirty hands", "Whether political leaders can be morally justified in committing a known wrong to prevent even greater harm").
card(ethics, "discrimination", "Treating a class of people badly based on group membership rather than individual characteristics").
card(ethics, "divine command theory", "Action is morally good if commanded by God and morally bad if forbidden by God").
card(ethics, "doctrine of double effect (DDE)", "Conditions that must be satisfied before a good action with bad side effects can be justified").
card(ethics, "drug", "Psychoactive substance, especially one which is illegal and addictive, ingested for recreational use").
card(ethics, "duty", "Commitment or expectation to perform some action in general or if certain circumstances arise").
card(ethics, "effective altruism", "Using evidence and reasoning to determine the most practical ways to benefit others").
card(ethics, "egalitarianism", "All people are equal in fundamental worth or social status").
card(ethics, "emotivism", "Ethical sentences express attitudes rather than propositions").
card(ethics, "empathy", "Identification with the thoughts or feelings of another").
card(ethics, "engineering ethics", "System of moral principles that apply to the practice of engineering").
card(ethics, "entitlement", "Right to have something that society is believed to owe to a person").
card(ethics, "environmental ethics", "Branch of ethics concerned with the management and protection of the natural world").
card(ethics, "envy", "Irrational attachment to the possessions or qualities of others that causes resentment").
card(ethics, "equal opportunity", "Chances for work and advancement within a society should go to the most qualified without discrimination").
card(ethics, "equality of outcome", "Ensuring that income or wealth are redistributed among people to bring them to the same level").
card(ethics, "ethic of reciprocity", "Like the Golden Rule, but contains the idea that similar treatment should be expected in return").
card(ethics, "ethical banking", "Being concerned with the social and environmental impacts of investments and loans").
card(ethics, "ethical code", "Written set of moral standards adopted by an organization to govern its members").
card(ethics, "ethical consumerism", "Activism based on dollar voting that recommends or boycotts products and companies").
card(ethics, "ethical dilemma", "Decision-making problem between two moral imperatives, neither of which is unambiguously acceptable or preferable").
card(ethics, "ethical egoism", "Moral agents ought to do what is in their own self-interest").
card(ethics, "ethical naturalism", "Ethical terms can be defined in non-ethical terms, namely, descriptive terms from the natural sciences").
card(ethics, "ethical system", "Set of consistent moral principles").
card(ethics, "ethicist", "Someone whose judgment on ethics is trusted by a specific community").
card(ethics, "ethics", "Study of shared social principles relating to right and wrong conduct").
card(ethics, "eudemonia", "Good life of happiness and well-being that arises from the exercise of virtue and wisdom").
card(ethics, "eugenics", "Social philosophy which advocates the improvement of human hereditary qualities through selective breeding").
card(ethics, "euthanasia", "Intentionally ending a life to relieve pain and suffering").
card(ethics, "evil", "Action which is deliberately malicious and harmful in a way that violates universal ethical norms").
card(ethics, "evolutionary ethics", "Biological approaches to morality based on the role of evolution in shaping psychology and behavior").
card(ethics, "excellence", "Talent or quality which is unusually good and so surpasses ordinary standards").
card(ethics, "experience machine", "Critique of Hedonism that imagines whether a device that simulates endless pleasure would be preferable to reality; Thought experiment of Robert Nozick").
card(ethics, "expressivism", "Moral sentences do not express fact or have objective truth value, but rather express personal attitudes").
card(ethics, "extrinsic", "Value which is derived relationally or serves instrumentally").
card(ethics, "fair trade", "Social movement to help producers in developing countries achieve better export terms").
card(ethics, "fall guy", "Person to whom blame is deliberately and falsely attributed in order to deflect blame from another party").
card(ethics, "family values", "Holding the parent/child bond to be the essential ethical and moral unit of society").
card(ethics, "fidelity", "Faithfulness to one's duties or loyalty to one's relationships").
card(ethics, "first formulation of categorical imperative", "Act only according to that maxim whereby you can, at the same time, will that it should become a universal law").
card(ethics, "first, do no harm", "Medical principle of avoiding injury to the patient").
card(ethics, "forgiveness", "Renouncing any negative feeling or desire for punishment, retribution, or compensation").
card(ethics, "formal ethics", "Logical system for describing and evaluating the structure rather than the content of ethical principles").
card(ethics, "fornication", "Illicit sexual intercourse between unmarried persons").
card(ethics, "fraud", "Act of deception carried out for unfair, undeserved and/or unlawful gain").
card(ethics, "free software", "Software distributed under terms that allow users to run, study, change, and distribute it and any adapted versions").
card(ethics, "freedom", "Ability to do as one wills and what one has the power to do").
card(ethics, "friendship", "Strong interpersonal bond based on mutual affection").
card(ethics, "gamesmanship", "Use of legal but unsporting tactics to gain an advantage over one's opponent").
card(ethics, "gender", "Range of characteristics pertaining to, and differentiating between, masculinity and femininity").
card(ethics, "generosity", "Being unattached to material possessions and giving freely to others").
card(ethics, "genetic engineering", "Direct manipulation of an organism's genes using biotechnology").
card(ethics, "genocide", "Systematic killing of a population based on their ethnicity, religion, political beliefs, social status, etc").
card(ethics, "global warming", "Observed century-scale rise in the average temperature of the Earth's climate system and its related effects").
card(ethics, "gluttony", "Over-indulgence and over-consumption of food, drink, or luxury goods").
card(ethics, "good and evil", "Common philosophical dichotomy in which opposite influences should either be defeated or reconciled as one").
card(ethics, "good", "Action which is voluntarily benevolent and helpful in a way that exceeds minimum ethical requirements").
card(ethics, "greed", "Inordinate desire to use or possess more than one needs").
card(ethics, "guilt", "Emotion that occurs when a person feels that they have violated a moral standard").
card(ethics, "happiness", "State of well-being featuring positive or pleasant emotions ranging from contentment to intense joy").
card(ethics, "harassment", "Behavior that appears to be disturbing or threatening, and is usually repetitive").
card(ethics, "harm principle", "Actions of individuals should only be limited to prevent harm to other individuals").
card(ethics, "heroism", "Performing great deeds for the common good or for the classical goals of pride and fame").
card(ethics, "homestead principle", "Gaining ownership of an unowned natural resource by performing an act of original appropriation").
card(ethics, "honesty", "Being scrupulous and trustworthy with regard to telling the truth").
card(ethics, "honor", "Good reputation given to someone for competence and character").
card(ethics, "how many men?", "Demonstration of the concept of taxation as theft by an increasing series of larger votes to confiscate someone's property").
card(ethics, "human enhancement", "Altering the human body or brain using biotechnology to produce capacities beyond the normal human range").
card(ethics, "human nature", "Ways that people typically think, feel, and act which can be regarded as a source of ethical norms").
card(ethics, "human rights", "Legal, social, or ethical principles of freedom or entitlement").
card(ethics, "human subject research", "Performing scientific inquiry on human beings involving private interviews or physical interactions").
card(ethics, "humanism", "Ethical system that centers on people's values, dignity and freedom rather than theistic religion and superstition").
card(ethics, "humanitarian", "Concerned with people's welfare and the alleviation of suffering").
card(ethics, "humility", "Modesty and having no pretensions or ostentation").
card(ethics, "immoral", "Actions or beliefs which violate personal or social norms, especially when sexual").
card(ethics, "impact investing", "Strategy for allocating money which actively aims to achieve social or environmental good along with profit").
card(ethics, "inalienable rights", "Entitlements that cannot be surrendered or transferred to another person").
card(ethics, "indeterminism", "Human actions determined by deliberate choice or free will rather than the preceding events, conditions, causes or karma").
card(ethics, "individualism", "Moral stance that promotes independence and self-reliance while opposing interference with each person's choices").
card(ethics, "informed consent", "Getting permission before conducting a healthcare intervention on someone, or for disclosing personal information").
card(ethics, "institutional review board (IRB)", "Committee that reviews the methods proposed for research to ensure that they are ethical").
card(ethics, "instrumental", "Serving to reach some other end").
card(ethics, "integrity", "Consistency in strong adherence to personal moral principles and avoiding temptation or corruption").
card(ethics, "intrinsic", "Value something has in itself, for its own sake, neither relational nor instrumental").
card(ethics, "is-ought problem", "Question of how one can coherently move from descriptive statements to prescriptive ones").
card(ethics, "just war theory", "Set of criteria which a military conflict must meet to be considered morally acceptable").
card(ethics, "justice", "Ideal of fairness and impartiality, especially with regard to the punishment of wrongdoing").
card(ethics, "karma; fate", "Force or law of nature which causes one to reap what one sows").
card(ethics, "kindness", "Behavior marked by ethical characteristics, a pleasant disposition, and concern and consideration for others").
card(ethics, "laziness", "Being inclined to idleness, procrastination, and avoiding work").
card(ethics, "legal ethics", "Principles of conduct that judges and lawyers are expected to observe in their practice").
card(ethics, "legal rights", "Entitlements given to a person by law or custom that can be changed or repealed").
card(ethics, "leveling up of rank", "Hypothetical bringing of all human beings up to the high rank of nobility or aristocracy; Thought experiment of Jeremy Waldron").
card(ethics, "libel", "Written false statement which unjustly seeks to damage someone's reputation").
card(ethics, "liberty", "Absence of arbitrary restraints which considers the rights of all involved").
card(ethics, "love", "Feeling of powerful attraction and emotional attachment").
card(ethics, "loyalty", "Devotion and faithfulness to a person, nation, or cause").
card(ethics, "lust", "Excess of passionate desire, especially for sexual experience").
card(ethics, "machine ethics", "Redefinition of ethics on an explicit practical basis for artificially programmed or learning agents").
card(ethics, "medical ethics", "Study of morality in health and its treatment").
card(ethics, "mercy", "Forgiveness or compassion, especially toward those less fortunate").
card(ethics, "metaethics", "Branch of ethics that studies the nature of philosophical moral systems").
card(ethics, "military ethics", "Moral treatment of the issues surrounding the use of force in armed conflicts").
card(ethics, "moral absolutism", "Actions are intrinsically right or wrong, independent of context or consequences").
card(ethics, "moral agency", "Individual's ability to make moral judgments and to be held accountable for these actions").
card(ethics, "moral code", "Formal, consistent set of rules prescribing righteous behavior").
card(ethics, "moral compass", "Inner sense of right and wrong that guides a person in ethical decision making").
card(ethics, "moral imperative", "Strongly felt principle that compels that person to act").
card(ethics, "moral intuitionism", "Our innate awareness of value forms the foundation of our ethical knowledge").
card(ethics, "moral luck", "Assigning blame or praise for an action or its consequences even if the agent did not have full control").
card(ethics, "moral nihilism", "Rejection of inherent or objective moral principles").
card(ethics, "moral psychology", "Study of the mental ability or experience of making ethical decisions").
card(ethics, "moral realism", "Ethical sentences express propositions that refer to objective features of the world").
card(ethics, "moral relativism", "Moral values depend on the customs and opinions of the people holding them").
card(ethics, "moral sense theory", "Distinctions between morality and immorality are discovered by emotional responses to experience").
card(ethics, "moral skepticism", "No one has moral knowledge or moral knowledge is impossible").
card(ethics, "moral suasion", "Persuasion brought to bear by appeals to someone's sense of ethics").
card(ethics, "moral subjectivism", "Values and moral principles come from attitudes, convention, whim, or preference").
card(ethics, "moral universalism", "Actions are right or wrong for all similarly situated individuals, independent of custom or opinion").
card(ethics, "morality", "Set of personal guiding principles for right and wrong conduct").
card(ethics, "murder", "Killing someone without justification, especially with malice aforethought").
card(ethics, "natural law", "Rules of moral behavior are inherent and can be understood through reasoning").
card(ethics, "natural rights", "Innate entitlements that are universal and inalienable").
card(ethics, "naturalistic fallacy", "Explaining what is \"good\" reductively in terms of natural properties such as \"pleasant\" or \"desirable\"").
card(ethics, "negligence", "Unintentional failure to perform a duty of reasonable care, causing damage").
card(ethics, "nepotism", "Favoring of relatives or personal friends because of their relationship rather than because of their abilities").
card(ethics, "neuroethics", "Studying how science can predict or alter human behavior, experience, or identity through the brain").
card(ethics, "nihilism", "Rejection of inherent or objective moral principles").
card(ethics, "noble lie", "Myth or untruth, often religious, knowingly propagated by an elite to maintain social harmony or to advance an agenda").
card(ethics, "noncognitivism", "Ethical sentences do not express propositions and thus cannot be true or false").
card(ethics, "nonviolence", "Personal practice of being harmless to self and others under every condition").
card(ethics, "norm", "Sentence with non-descriptive meaning, such as a command, permission or prohibition").
card(ethics, "normative ethics", "Branch of ethics concerned with classifying actions as right and wrong").
card(ethics, "obligation", "Course of action that one is required to take").
card(ethics, "optimism", "belief or hope that outcomes will be positive, favorable, and desirable").
card(ethics, "original position", "Hypothetical state in which people are to select fair principles for a society to live under").
card(ethics, "pain", "Unpleasant and punitive outcome of suffering physical harm that encourages someone to avoid it").
card(ethics, "paternalism", "Action limiting a person's or group's liberty or autonomy which is meant to promote their own good").
card(ethics, "peace", "Harmonious lack of conflict and freedom from fear of violence between individuals and heterogeneous social groups").
card(ethics, "person", "Being that has certain capacities or attributes such as reason, morality, and consciousness").
card(ethics, "pessimism", "mental attitude in which an undesirable outcome is expected from a situation").
card(ethics, "phronesis", "Type of wisdom relevant to practical action, implying both good judgement and excellence of character").
card(ethics, "piety", "Reverence and devotion to one's parents and family or to God").
card(ethics, "plagiarism", "Appropriating someone else's intellectual and work and passing it off as your own").
card(ethics, "pleasure", "Rewarding outcome of an action that satisfies some biological drive that encourages its repetition").
card(ethics, "political ethics", "Moral consideration of the methods of public officials and the rightness of policies and laws").
card(ethics, "pornography", "Explicit visual or literary depiction of sexual subjects").
card(ethics, "postconventional", "Kohlberg stage of development involving the social contract and universal ethical principles").
card(ethics, "posthuman", "Existing in a mental or physical state beyond human as it is presently defined").
card(ethics, "postmodern ethics", "Relativism and pluralism in moral matters that is complex, conditional, and grounded in individual experience").
card(ethics, "poverty", "Scarcity of money or other essential material resources").
card(ethics, "pragmatic ethics", "Moral correctness evolves similarly to scientific knowledge: socially over many lifetimes").
card(ethics, "praise", "Being given accountability for actions that are morally right").
card(ethics, "preconventional", "Kohlberg stage of development involving obedience to avoid punishment and self-interest").
card(ethics, "prejudice", "Adverse judgment or opinion formed beforehand or without knowledge of the facts").
card(ethics, "preparedness", "Readiness to take action, especially to prevent unexpected harm").
card(ethics, "prescriptive", "Good action that is required by a norm or standard").
card(ethics, "prescriptivism", "Rather than expressing propositions, ethical sentences are universal imperatives").
card(ethics, "pride", "Unreasonable feeling of superiority and disdain for others who are of lesser worth").
card(ethics, "primum non nocere", "It may be better to do nothing than to risk causing more harm than good").
card(ethics, "principle", "Rule or concept that is a guide for behavior or evaluation").
card(ethics, "privacy", "Ability to conceal information about yourself, and so express yourself selectively").
card(ethics, "pro-choice", "Supportive of a woman's right to have an abortion").
card(ethics, "professional ethics", "Standards of behavior expected from practitioners of an occupation").
card(ethics, "professional responsibility", "Duties to obey the law, avoid conflicts of interest, and put the interests of clients ahead of their own interests").
card(ethics, "programming ethics", "Professional ethics as applied in software development").
card(ethics, "promise", "Commitment that one will or will not perform some action").
card(ethics, "proscriptive", "Bad action that is forbidden by a norm or standard").
card(ethics, "prostitution", "Engaging in sexual activity with another person for pay").
card(ethics, "prudence", "Ability to take practical action with careful, sensible judgment").
card(ethics, "psychological egoism", "Self-interest always motivates people, even in what seem to be acts of altruism").
card(ethics, "public interest", "Welfare or well-being of the public").
card(ethics, "racism", "Belief in the superiority of one race over another").
card(ethics, "rape", "Assault involving sexual penetration without someone's consent").
card(ethics, "relational", "Derived from something's relations to other things").
card(ethics, "respect", "Attitude of consideration or high regard for the virtues of another").
card(ethics, "responsibility", "Task you are expected to perform or outcome you are expected to guarantee").
card(ethics, "reverse discrimination", "Favoritism against members of a dominant or majority group, in favor of members of a minority or historically disadvantaged group").
card(ethics, "right to choose", "Freedom of a woman to have an abortion or a person to receive euthanasia").
card(ethics, "right to life", "Claim of a human being, especially an unborn child, to the continuation of his or her existence").
card(ethics, "right to work", "Assurance of having paid employment").
card(ethics, "role ethics", "Collectivist ethics where values are determined by fulfilling relationships with families and communities").
card(ethics, "rule utilitarianism", "Giving more weight to general prescriptions rather than specific outcomes when weighing the morality of an action").
card(ethics, "sanctity of life", "Principle of implied protection regarding human and animal life").
card(ethics, "second formulation of categorical imperative", "Always treat people as an end, not merely as a means to an end").
card(ethics, "selling out", "Compromising of a person's integrity, morality, or authenticity for personal gain").
card(ethics, "sensualism", "Gratification of the senses is the highest good").
card(ethics, "sentience", "Having consciousness and sensory awareness, which is distinct from the ability to reason").
card(ethics, "service", "Action taken to benefit others").
card(ethics, "sexual ethics", "Evaluating the moral conduct of interpersonal relationships and sexual activities from social, cultural, and philosophical perspectives").
card(ethics, "sexual harassment", "Persistent and unwanted sexual advances, typically in the workplace").
card(ethics, "sexual orientation", "One's tendencies of sexual attraction, considered as a whole").
card(ethics, "situational ethics", "Evaluates an action in its particular context, rather than by absolute moral standards").
card(ethics, "slander", "Spoken false statement which unjustly seeks to damage someone's reputation").
card(ethics, "slavery", "Any system in which people are legally allowed to buy, own, and sell other people").
card(ethics, "social Darwinism", "Laws of evolution by natural selection also apply to social structures and can be used to justify harsh policies").
card(ethics, "social choice theory", "Framework for analysis of combining individual opinions, interests, or welfares to reach a collective decision or social welfare").
card(ethics, "social enterprise", "Organization that applies commercial strategies to make improvements in social and environmental well-being").
card(ethics, "social equality", "Equality of status and rights, and absence of class and category discrimination, within a society").
card(ethics, "social justice", "Proper moral relations between the individual and society in the distribution of wealth, opportunity, and privilege").
card(ethics, "social philosophy", "Study of questions about shared culture and behavior in terms of ethical values rather than empirical relations").
card(ethics, "socially responsible investing (SRI)", "Strategy for allocating money which considers both profit and social or environmental good").
card(ethics, "speciesism", "Assigning greater rights to human beings than to other animals").
card(ethics, "spin", "Providing a certain interpretation of information, possibly deceitful, which is meant to sway public opinion").
card(ethics, "stages of moral development", "Six levels of ethical behavior described by Lawrence Kohlberg").
card(ethics, "suffering", "Ongoing state of physical pain or mental distress").
card(ethics, "suicide", "Intentional killing of oneself").
card(ethics, "sustainability", "Organizing economic and technological activity to meet present and future needs while preserving the environment").
card(ethics, "sympathy", "Feeling of pity for the suffering of another").
card(ethics, "teleology", "Reason or explanation for something in function of its outcome or purpose").
card(ethics, "temperance", "Voluntary self-restraint in the indulgence of appetite, sexual desire, vanity, or anger").
card(ethics, "terrorism", "Deliberate commission of an act of violence to create public fear in the furtherance of a political or social agenda").
card(ethics, "tolerance", "Acceptance of or patience with the beliefs and practices of others").
card(ethics, "torture", "Intentionally causing someone to experience physical or mental agony").
card(ethics, "transhumanism", "Transforming the human condition by using technology to enhance the mind and body").
card(ethics, "trolley problem", "Whether to stop or change the course of a vehicle to kill some people while saving others").
card(ethics, "two wrongs make a right", "Logical fallacy whereby a wrong action is justified by the commission of another").
card(ethics, "understanding", "Comprehension of concepts or agreement and acceptance between people").
card(ethics, "unintended consequences", "Outcomes that are not the ones foreseen and intended by a purposeful action").
card(ethics, "utilitarianism", "Judging the morality of an action based on how much pain or pleasure it causes").
card(ethics, "utility", "Either a general measure of worth or a specific set of preferences").
card(ethics, "value pluralism", "There are several values which may be equally correct and fundamental, and yet in conflict with each other").
card(ethics, "value theory", "Study of how people rank moral and natural goods in relative importance").
card(ethics, "value", "Personal preference concerning appropriate courses of actions or outcomes").
card(ethics, "veganism", "Not eating meat, milk products, eggs, or honey, or using other animal products").
card(ethics, "vegetarianism", "Not eating meat but possibly eating milk or eggs").
card(ethics, "veil of ignorance", "Assuming a hypothetical state of ignorance and impartiality when allocating rights and benefits within a society; Thought experiment of John Rawls").
card(ethics, "vice", "Defect in personal character or bad, unhealthy, or immoral habit").
card(ethics, "violence", "Intentional use of physical force which might cause injury").
card(ethics, "virtue ethics", "Normative theories which emphasize good qualities of mind and character").
card(ethics, "virtue jurisprudence", "Laws should promote the development of virtuous characters by citizens").
card(ethics, "virtue", "Personal quality that is socially esteemed and promoted as displaying moral excellence").
card(ethics, "war", "State of armed conflict between states, societies and informal groups, such as insurgents and militias").
card(ethics, "wealth", "Abundance of money or other essential material resources").
card(ethics, "whistleblower", "Person who exposes any kind of activity or information that is deemed illegal or unethical within an organization").
card(ethics, "wisdom", "Mature understanding and sound judgement derived from knowledge and experience").
card(ethics, "women and children first", "Code of conduct for who to save first when abandoning ship").
card(ethics, "wrong", "Action that is illegal or immoral").
card(factorials, "1!", "1").
card(factorials, "10!", "3628800").
card(factorials, "2!", "2").
card(factorials, "3!", "6").
card(factorials, "4!", "24").
card(factorials, "5!", "120").
card(factorials, "6!", "720").
card(factorials, "7!", "5040").
card(factorials, "8!", "40320").
card(factorials, "9!", "362880").
card(fiction_books, "2001: A Space Odyssey", "Arthur C. Clarke").
card(fiction_books, "2666", "Roberto Bolaño").
card(fiction_books, "A Bend in the River", "V. S. Naipaul").
card(fiction_books, "A Clockwork Orange", "Anthony Burgess").
card(fiction_books, "A Confederacy of Dunces", "John Kennedy Toole").
card(fiction_books, "A Dance to the Music of Time", "Anthony Powell").
card(fiction_books, "A Doll's House", "Henrik Ibsen").
card(fiction_books, "A Farewell to Arms", "Ernest Hemingway").
card(fiction_books, "A Fine Balance", "Rohinton Mistry").
card(fiction_books, "A Good Man Is Hard to Find", "Flannery O'Connor").
card(fiction_books, "A Handful of Dust", "Evelyn Waugh").
card(fiction_books, "A Hero of Our Time", "Mikhail Lermontov").
card(fiction_books, "A House for Mr. Biswas", "V. S. Naipaul").
card(fiction_books, "A Midsummer Night's Dream", "William Shakespeare").
card(fiction_books, "A Passage to India", "E. M. Forster").
card(fiction_books, "A Portrait of the Artist as a Young Man", "James Joyce").
card(fiction_books, "A Prayer for Owen Meany", "John Irving").
card(fiction_books, "A Room With a View", "E. M. Forster").
card(fiction_books, "A Season in Hell", "Arthur Rimbaud").
card(fiction_books, "A Sentimental Education", "Gustave Flaubert").
card(fiction_books, "A Suitable Boy", "Vikram Seth").
card(fiction_books, "A Tale of Two Cities", "Charles Dickens").
card(fiction_books, "A Tree Grows in Brooklyn", "Betty Smith").
card(fiction_books, "A Visit From The Goon Squad", "Jennifer Egan").
card(fiction_books, "A Wrinkle In Time", "Madeleine L'Engle").
card(fiction_books, "Absalom, Absalom!", "William Faulkner").
card(fiction_books, "Ajax", "Sophocles").
card(fiction_books, "Alice's Adventures in Wonderland", "Lewis Carroll").
card(fiction_books, "All Quiet on the Western Front", "Erich Maria Remarque").
card(fiction_books, "All the King's Men", "Robert Penn Warren").
card(fiction_books, "All the Pretty Horses", "Cormac McCarthy").
card(fiction_books, "American Pastoral", "Philip Roth").
card(fiction_books, "American Psycho", "Bret Easton Ellis").
card(fiction_books, "An American Tragedy", "Theodore Dreiser").
card(fiction_books, "And Then There Were None", "Agatha Christie").
card(fiction_books, "Animal Farm", "George Orwell").
card(fiction_books, "Anna Karenina", "Leo Tolstoy").
card(fiction_books, "Anniversaries", "Uwe Johnson").
card(fiction_books, "Antigone", "Sophocles").
card(fiction_books, "Arrowsmith", "Sinclair Lewis").
card(fiction_books, "As I Lay Dying", "William Faulkner").
card(fiction_books, "Atlas Shrugged", "Ayn Rand").
card(fiction_books, "Atonement", "Ian McEwan").
card(fiction_books, "Austerlitz", "W. G. Sebald").
card(fiction_books, "Awakening", "John Galsworthy").
card(fiction_books, "Babbitt", "Sinclair Lewis").
card(fiction_books, "Barchester Towers", "Anthony Trollope").
card(fiction_books, "Bartleby the Scrivener", "Herman Melville").
card(fiction_books, "Bastard Out of Carolina", "Dorothy Allison").
card(fiction_books, "Beloved", "Toni Morrison").
card(fiction_books, "Berlin Alexanderplatz", "Alfred Döblin").
card(fiction_books, "Birdsong", "Sebastian Faulks").
card(fiction_books, "Bleak House", "Charles Dickens").
card(fiction_books, "Blood Meridian", "Cormac McCarthy").
card(fiction_books, "Bonfire of the Vanities", "Tom Wolfe").
card(fiction_books, "Bouvard et Pécuchet", "Gustave Flaubert").
card(fiction_books, "Brave New World", "Aldous Huxley").
card(fiction_books, "Breakfast at Tiffany's", "Truman Capote").
card(fiction_books, "Brideshead Revisited", "Evelyn Waugh").
card(fiction_books, "Brighton Rock", "Graham Greene").
card(fiction_books, "Buddenbrooks", "Thomas Mann").
card(fiction_books, "Call It Sleep", "Henry Roth").
card(fiction_books, "Candide", "Voltaire").
card(fiction_books, "Carry On, Jeeves", "P. G. Wodehouse").
card(fiction_books, "Cat's Cradle", "Kurt Vonnegut").
card(fiction_books, "Catch-22", "Joseph Heller").
card(fiction_books, "Charlotte's Web", "E. B. White").
card(fiction_books, "Cider with Rosie", "Laurie Lee").
card(fiction_books, "Clarissa", "Samuel Richardson").
card(fiction_books, "Cloud Atlas", "David Mitchell").
card(fiction_books, "Cold Comfort Farm", "Stella Gibbons").
card(fiction_books, "Cold Mountain", "Charles Frazier").
card(fiction_books, "Collected Fiction", "Jorge Luis Borges").
card(fiction_books, "Collected Poems of T.S. Eliot", "T. S. Eliot").
card(fiction_books, "Collected Poems of [author]", "Dylan Thomas; W. B. Yeats").
card(fiction_books, "Collected Poems", "Wallace Stevens").
card(fiction_books, "Complete Poems of [author]", "Giacomo Leopardi").
card(fiction_books, "Complete Poems", "Elizabeth Bishop").
card(fiction_books, "Confessions of Zeno", "Italo Svevo").
card(fiction_books, "Corelli's Mandolin", "Louis de Bernières").
card(fiction_books, "Cousin Bette", "Honoré de Balzac").
card(fiction_books, "Crash: A Novel", "J. G. Ballard").
card(fiction_books, "Crime and Punishment", "Fyodor Dostoyevsky").
card(fiction_books, "Cry, the Beloved Country", "Alan Paton").
card(fiction_books, "Dangerous Liaison", "Pierre Choderlos de Laclos").
card(fiction_books, "Darkness at Noon", "Arthur Koestler").
card(fiction_books, "David Copperfield", "Charles Dickens").
card(fiction_books, "De Rerum Natura", "Lucretius").
card(fiction_books, "Dead Souls", "Nikolai Gogol").
card(fiction_books, "Death in Venice", "Thomas Mann").
card(fiction_books, "Death of Virgil", "Hermann Broch").
card(fiction_books, "Decameron", "Giovanni Boccaccio").
card(fiction_books, "Disgrace", "J M Coetzee").
card(fiction_books, "Do Androids Dream of Electric Sheep?", "Philip K. Dick").
card(fiction_books, "Doctor Faustus", "Thomas Mann").
card(fiction_books, "Doctor Zhivago", "Boris Pasternak").
card(fiction_books, "Dom Casmurro", "Machado de Assis").
card(fiction_books, "Don Quixote", "Miguel de Cervantes").
card(fiction_books, "Dracula", "Bram Stoker").
card(fiction_books, "Dream of the Red Chamber", "Cao Xueqin").
card(fiction_books, "Dubliners", "James Joyce").
card(fiction_books, "Dune", "Frank Herbert").
card(fiction_books, "Electra", "Sophocles").
card(fiction_books, "Emma", "Jane Austen").
card(fiction_books, "Epic of Gilgamesh", "Unknown").
card(fiction_books, "Ethan Frome", "Edith Wharton").
card(fiction_books, "Eugenie Grandet", "Honoré de Balzac").
card(fiction_books, "Fahrenheit 451", "Ray Bradbury").
card(fiction_books, "Fairy Tales and Stories", "Hans Christian Anderson").
card(fiction_books, "Father Goriot", "Honoré de Balzac").
card(fiction_books, "Fathers and Sons", "Ivan Turgenev").
card(fiction_books, "Faust", "Johann Wolfgang von Goethe").
card(fiction_books, "Fear and Loathing in Las Vegas: A Savage Journey to the Heart of the American Dream", "Hunter S. Thompson").
card(fiction_books, "Ferdydurke", "Witold Gombrowicz").
card(fiction_books, "Finnegans Wake", "James Joyce").
card(fiction_books, "For Whom the Bell Tolls", "Ernest Hemingway").
card(fiction_books, "Foundation", "Isaac Asimov").
card(fiction_books, "Frankenstein", "Mary Shelley").
card(fiction_books, "Gargantua and Pantagruel", "Francois Rabelais").
card(fiction_books, "Germinal", "Émile Zola").
card(fiction_books, "Gilead", "Marilynne Robinson").
card(fiction_books, "Giovanni's Room", "James Baldwin").
card(fiction_books, "Go Tell it on the Mountain", "James Baldwin").
card(fiction_books, "Gone With the Wind", "Margaret Mitchell").
card(fiction_books, "Gravity's Rainbow", "Thomas Pynchon").
card(fiction_books, "Great Expectations", "Charles Dickens").
card(fiction_books, "Gulliver's Travels", "Jonathan Swift").
card(fiction_books, "Gypsy Ballads", "Federico García Lorca").
card(fiction_books, "Half of a Yellow Sun", "Chimamanda Ngozi Adichie").
card(fiction_books, "Hamlet", "William Shakespeare").
card(fiction_books, "Harry Potter And The Philosopher's Stone", "J. K Rowling").
card(fiction_books, "Heart of Darkness", "Joseph Conrad").
card(fiction_books, "Henderson The Rain King", "Saul Bellow").
card(fiction_books, "Herzog", "Saul Bellow").
card(fiction_books, "His Dark Materials", "Philip Pullman").
card(fiction_books, "Hopscotch", "Julio Cortázar").
card(fiction_books, "Household Tales", "Brothers Grimm").
card(fiction_books, "Howards End", "E. M. Forster").
card(fiction_books, "Humboldt's Gift", "Saul Bellow").
card(fiction_books, "Hunger", "Knut Hamsun").
card(fiction_books, "I'm Not Stiller", "Max Frisch").
card(fiction_books, "I, Claudius", "Robert Graves").
card(fiction_books, "If on a Winter's Night a Traveller", "Italo Calvino").
card(fiction_books, "In Chancery", "John Galsworthy").
card(fiction_books, "In Our Time", "Ernest Hemingway").
card(fiction_books, "In Search of Lost Time", "Marcel Proust").
card(fiction_books, "Independent People", "Halldor Laxness").
card(fiction_books, "Indian Summer of a Forsyte", "John Galsworthy").
card(fiction_books, "Infinite Jest", "David Foster Wallace").
card(fiction_books, "Invisible Cities", "Italo Calvino").
card(fiction_books, "Invisible Man", "Ralph Ellison").
card(fiction_books, "Ivanhoe", "Walter Scott").
card(fiction_books, "Jacques the Fatalist and His Master", "Denis Diderot").
card(fiction_books, "Jane Eyre", "Charlotte Bronte").
card(fiction_books, "Jazz", "Toni Morrison").
card(fiction_books, "Jimmy Corrigan, the Smartest Kid on Earth", "Chris Ware").
card(fiction_books, "Journey to the End of The Night", "Louis-Ferdinand Céline").
card(fiction_books, "Journey to the West", "Wu Cheng'en").
card(fiction_books, "Jude the Obscure", "Thomas Hardy").
card(fiction_books, "Kim", "Rudyard Kipling").
card(fiction_books, "King Lear", "William Shakespeare").
card(fiction_books, "Kristin Lavransdatter", "Sigrid Undset").
card(fiction_books, "La Regenta", "Clarín").
card(fiction_books, "Labyrinths", "Jorge Luis Borges").
card(fiction_books, "Lady Chatterley's Lover", "D. H. Lawrence").
card(fiction_books, "Le Morte d'Arthur", "Thomas Malory").
card(fiction_books, "Leaves of Grass", "Walt Whitman").
card(fiction_books, "Les Misérables", "Victor Hugo").
card(fiction_books, "Life of Pi", "Yann Martel").
card(fiction_books, "Life, a User's Manual", "Georges Perec").
card(fiction_books, "Light in August", "William Faulkner").
card(fiction_books, "Little Women", "Louisa May Alcott").
card(fiction_books, "Lolita", "Vladimir Nabokov").
card(fiction_books, "London Fields", "Martin Amis").
card(fiction_books, "Lord Jim", "Joseph Conrad").
card(fiction_books, "Lord of the Flies", "William Golding").
card(fiction_books, "Lost Illusions", "Honoré de Balzac").
card(fiction_books, "Love Medicine", "Louise Erdrich").
card(fiction_books, "Love in the Time of Cholera", "Gabriel Garcia Marquez").
card(fiction_books, "Loving", "Henry Green").
card(fiction_books, "Lucky Jim", "Kingsley Amis").
card(fiction_books, "Lysistrata", "Aristophanes").
card(fiction_books, "Macbeth", "William Shakespeare").
card(fiction_books, "Madame Bovary", "Gustave Flaubert").
card(fiction_books, "Main Street", "Sinclair Lewis").
card(fiction_books, "Maldoror (Les Chants de Maldoror)", "Comte de Lautréamont").
card(fiction_books, "Malone Dies", "Samuel Beckett").
card(fiction_books, "Man's Fate", "Andre Malraux").
card(fiction_books, "Medea", "Euripides").
card(fiction_books, "Memoirs of Hadrian", "Marguerite Yourcenar").
card(fiction_books, "Metamorphoses", "Ovid").
card(fiction_books, "Middlemarch", "George Eliot").
card(fiction_books, "Middlesex", "Jeffrey Eugenides").
card(fiction_books, "Midnight's Children", "Salman Rushdie").
card(fiction_books, "Moby Dick", "Herman Melville").
card(fiction_books, "Moll Flanders", "Daniel Defoe").
card(fiction_books, "Molloy", "Samuel Beckett").
card(fiction_books, "Money", "Martin Amis").
card(fiction_books, "Mourning Becomes Electra", "Eugene O'Neill").
card(fiction_books, "Mrs. Dalloway", "Virginia Woolf").
card(fiction_books, "My Antonia", "Willa Cather").
card(fiction_books, "NW: A Novel", "Zadie Smith").
card(fiction_books, "Naked Lunch", "William S. Burroughs").
card(fiction_books, "Native Son", "Richard Wright").
card(fiction_books, "Nausea", "Jean Paul Sartre").
card(fiction_books, "Neuromancer", "William Gibson").
card(fiction_books, "Never Let Me Go", "Kazuo Ishiguro").
card(fiction_books, "New Grub Street: A Novel", "George Gissing").
card(fiction_books, "Nights At The Circus", "Angela Carter").
card(fiction_books, "Nine Stories", "J. D. Salinger").
card(fiction_books, "Nineteen Eighty Four", "George Orwell").
card(fiction_books, "Nineteen Nineteen", "John Dos Passos").
card(fiction_books, "Nostromo", "Joseph Conrad").
card(fiction_books, "Notes from the Underground", "Fyodor Dostoyevsky").
card(fiction_books, "Oblomov", "Ivan Goncharov").
card(fiction_books, "Oedipus at Colonus", "Sophocles").
card(fiction_books, "Oedipus the King", "Sophocles").
card(fiction_books, "Of Human Bondage", "W. Somerset Maugham").
card(fiction_books, "Of Mice and Men", "John Steinbeck").
card(fiction_books, "On the Road", "Jack Kerouac").
card(fiction_books, "One Day in the Life of Ivan Denisovich", "Aleksandr Solzhenitsyn").
card(fiction_books, "One Flew Over the Cuckoo's Nest", "Ken Kesey").
card(fiction_books, "One Hundred Years of Solitude", "Gabriel Garcia Marquez").
card(fiction_books, "One Thousand and One Nights", "India/Iran/Iraq/Egypt").
card(fiction_books, "Oresteia", "Aeschylus").
card(fiction_books, "Orlando: A Biography", "Virginia Woolf").
card(fiction_books, "Othello", "William Shakespeare").
card(fiction_books, "Our Mutual Friend", "Charles Dickens").
card(fiction_books, "Pale Fire", "Vladimir Nabokov").
card(fiction_books, "Parade's End", "Ford Madox Ford").
card(fiction_books, "Paradise Lost", "John Milton").
card(fiction_books, "Pedro Paramo", "Juan Rulfo").
card(fiction_books, "Persuasion", "Jane Austen").
card(fiction_books, "Philoctetes", "Sophocles").
card(fiction_books, "Phèdre", "Jean Racine").
card(fiction_books, "Pilgrim's Progress", "John Bunyan").
card(fiction_books, "Pippi Longstocking", "Astrid Lindgren").
card(fiction_books, "Poems of [author]", "Emily Dickinson; W. H. Auden").
card(fiction_books, "Portnoy's Complaint", "Philip Roth").
card(fiction_books, "Possession", "A. S. Byatt").
card(fiction_books, "Pride and Prejudice", "Jane Austen").
card(fiction_books, "Prince Caspian: The Return to Narnia", "C. S. Lewis").
card(fiction_books, "Prometheus Bound", "Aeschylus").
card(fiction_books, "Rabbit Is Rich", "John Updike").
card(fiction_books, "Rabbit Redux", "John Updike").
card(fiction_books, "Rabbit at Rest", "John Updike").
card(fiction_books, "Rabbit, Run", "John Updike").
card(fiction_books, "Ragtime", "E. L. Doctorow").
card(fiction_books, "Rebecca", "Daphne du Maurier").
card(fiction_books, "Regeneration", "Pat Barker").
card(fiction_books, "Riddle of the Sands", "Erskine Childers").
card(fiction_books, "Robinson Crusoe", "Daniel Defoe").
card(fiction_books, "Rubaiyat of Omar Khayyam", "Edward FitzGerald").
card(fiction_books, "Satanic Verses", "Salman Rushdie").
card(fiction_books, "Schindler's List", "Thomas Keneally").
card(fiction_books, "Scoop", "Evelyn Waugh").
card(fiction_books, "Season of Migration to the North", "Al-Tayyib Salih").
card(fiction_books, "Selected Stories of [author]", "Alice Munro").
card(fiction_books, "Seven Against Thebes", "Aeschylus").
card(fiction_books, "Siddhartha", "Hermann Hesse").
card(fiction_books, "Silas Marner", "George Eliot").
card(fiction_books, "Sister Carrie", "Theodore Dreiser").
card(fiction_books, "Six Characters in Search of an Author", "Luigi Pirandello").
card(fiction_books, "Slaughterhouse-Five", "Kurt Vonnegut").
card(fiction_books, "Snow Falling on Cedars", "David Guterson").
card(fiction_books, "So Long, See You Tomorrow", "William Maxwell").
card(fiction_books, "Some Prefer Nettles", "Junichiro Tanizaki").
card(fiction_books, "Song of Solomon", "Toni Morrison").
card(fiction_books, "Songs of Innocence and Experience", "William Blake").
card(fiction_books, "Sons and Lovers", "D. H. Lawrence").
card(fiction_books, "Sophie's Choice", "William Styron").
card(fiction_books, "Steppenwolf", "Hermann Hesse").
card(fiction_books, "Stories of [author]", "Ernest Hemingway; Guy de Maupassant").
card(fiction_books, "Stranger in a Strange Land", "Robert A. Heinlein").
card(fiction_books, "Suite Française", "Irène Némirovsky").
card(fiction_books, "Tarzan of the Apes", "Edgar Rice Burroughs").
card(fiction_books, "Tender Is the Night", "F. Scott Fitzgerald").
card(fiction_books, "Tess of the d'Urbervilles", "Thomas Hardy").
card(fiction_books, "The 42nd Parallel", "John Dos Passos").
card(fiction_books, "The Adventures of Augie March", "Saul Bellow").
card(fiction_books, "The Adventures of Huckleberry Finn", "Mark Twain").
card(fiction_books, "The Adventures of Oliver Twist", "Charles Dickens").
card(fiction_books, "The Aeneid", "Virgil").
card(fiction_books, "The Age of Innocence", "Edith Wharton").
card(fiction_books, "The Alchemist", "Paulo Coelho").
card(fiction_books, "The Alexandria Quartet", "Lawrence Durrell").
card(fiction_books, "The Amazing Adventures of Kavalier and Clay", "Michael Chabon").
card(fiction_books, "The Ambassadors", "Henry James").
card(fiction_books, "The Awakening", "Kate Chopin").
card(fiction_books, "The Bacchae", "Euripides").
card(fiction_books, "The Bean Trees", "Barbara Kingsolver").
card(fiction_books, "The Bell Jar", "Sylvia Plath").
card(fiction_books, "The Betrothed", "Alessandro Manzoni").
card(fiction_books, "The Big Money", "John Dos Passos").
card(fiction_books, "The Big Sleep", "Raymond Chandler").
card(fiction_books, "The Birds", "Aristophanes").
card(fiction_books, "The Blind Assassin", "Margaret Atwood").
card(fiction_books, "The Book Thief", "Markus Zusak").
card(fiction_books, "The Book of Disquiet", "Fernando Pessoa").
card(fiction_books, "The Breakfast of Champions", "Kurt Vonnegut").
card(fiction_books, "The Brief Wondrous Life of Oscar Wao", "Junot Diaz").
card(fiction_books, "The Brothers Karamazov", "Fyodor Dostoyevsky").
card(fiction_books, "The Call of the Wild", "Jack London").
card(fiction_books, "The Canterbury Tales", "Geoffrey Chaucer").
card(fiction_books, "The Castle", "Franz Kafka").
card(fiction_books, "The Catcher in the Rye", "J. D. Salinger").
card(fiction_books, "The Charterhouse of Parma", "Stendhal").
card(fiction_books, "The Cherry Orchard", "Anton Chekhov").
card(fiction_books, "The Clouds", "Aristophanes").
card(fiction_books, "The Collected Stories of [author]", "Eudora Welty").
card(fiction_books, "The Color Purple", "Alice Walker").
card(fiction_books, "The Complete Poetry and Prose of [author]", "William Blake").
card(fiction_books, "The Complete Sherlock Holmes", "Arthur Conan Doyle").
card(fiction_books, "The Complete Stories of [author]", "Flannery O'Connor; Franz Kafka").
card(fiction_books, "The Complete Tales and Poems of [author]", "Edgar Allan Poe").
card(fiction_books, "The Confusions of Young Törless", "Robert Musil").
card(fiction_books, "The Corrections", "Jonathan Franzen").
card(fiction_books, "The Count of Monte Cristo", "Alexandre Dumas").
card(fiction_books, "The Counterfeiters", "André Gide").
card(fiction_books, "The Custom of the Country", "Edith Wharton").
card(fiction_books, "The Day of the Locust", "Nathanael West").
card(fiction_books, "The Death of Ivan Ilyich", "Leo Tolstoy").
card(fiction_books, "The Death of the Heart", "Elizabeth Bowen").
card(fiction_books, "The Devil to Pay in the Backlands", "Joao Guimaraes Rosa").
card(fiction_books, "The Divine Comedy", "Dante Alighieri").
card(fiction_books, "The Duino Elegies", "Rainer Maria Rilke").
card(fiction_books, "The End of the Affair", "Graham Greene").
card(fiction_books, "The English Patient", "Michael Ondaatje").
card(fiction_books, "The Flowers of Evil", "Charles Baudelaire").
card(fiction_books, "The Fountainhead", "Ayn Rand").
card(fiction_books, "The French Lieutenant's Woman", "John Fowles").
card(fiction_books, "The Giver", "Lois Lowry").
card(fiction_books, "The God of Small Things", "Arundhati Roy").
card(fiction_books, "The Godfather", "Mario Puzo").
card(fiction_books, "The Golden Notebook", "Doris Lessing").
card(fiction_books, "The Good Earth", "Pearl S. Buck").
card(fiction_books, "The Good Soldier Svejk", "Jaroslav Hašek").
card(fiction_books, "The Good Soldier", "Ford Madox Ford").
card(fiction_books, "The Grapes of Wrath", "John Steinbeck").
card(fiction_books, "The Great Gatsby", "F. Scott Fitzgerald").
card(fiction_books, "The Handmaid's Tale", "Margaret Atwood").
card(fiction_books, "The Heart Is A Lonely Hunter", "Carson McCullers").
card(fiction_books, "The Hitchhiker's Guide to the Galaxy", "Douglas Adams").
card(fiction_books, "The Hobbit", "J. R. R. Tolkien").
card(fiction_books, "The Horse and His Boy: The Chronicles of Narnia", "C. S. Lewis").
card(fiction_books, "The Hound of the Baskervilles", "Arthur Conan Doyle").
card(fiction_books, "The Hour of the Star", "Clarice Lispector").
card(fiction_books, "The House of Mirth", "Edith Wharton").
card(fiction_books, "The House of the Spirits", "Isabel Allende").
card(fiction_books, "The Human Stain", "Philip Roth").
card(fiction_books, "The Hunchback of Notre-Dame", "Victor Hugo").
card(fiction_books, "The Idiot", "Fyodor Dostoyevsky").
card(fiction_books, "The Iliad", "Homer").
card(fiction_books, "The Joy Luck Club", "Amy Tan").
card(fiction_books, "The Jungle", "Upton Sinclair").
card(fiction_books, "The Killer Angels", "Michael Shaara").
card(fiction_books, "The Known World", "Edward P. Jones").
card(fiction_books, "The Last Battle: The Chronicles of Narnia", "C. S. Lewis").
card(fiction_books, "The Last Chronicle of Barset", "Anthony Trollope").
card(fiction_books, "The Last of the Mohicans", "James Fenimore Cooper").
card(fiction_books, "The Leopard", "Giuseppe Tomasi di Lampedusa").
card(fiction_books, "The Line of Beauty", "Alan Hollinghurst").
card(fiction_books, "The Lion, The Witch and the Wardrobe", "C. S. Lewis").
card(fiction_books, "The Little Prince", "Antoine de Saint-Exupéry").
card(fiction_books, "The Long Goodbye: A Novel", "Raymond Chandler").
card(fiction_books, "The Lord of the Rings", "J. R. R. Tolkien").
card(fiction_books, "The Lover", "Marguerite Duras").
card(fiction_books, "The Lusiad", "Luís Vaz Camões").
card(fiction_books, "The Magic Mountain", "Thomas Mann").
card(fiction_books, "The Magician's Nephew", "C. S. Lewis, Clive Staples Lewis").
card(fiction_books, "The Magus", "John Fowles").
card(fiction_books, "The Maltese Falcon", "Dashiell Hammett").
card(fiction_books, "The Man Who Loved Children", "Christina Stead").
card(fiction_books, "The Man Without Qualities", "Robert Musil").
card(fiction_books, "The Man of Property", "John Galsworthy").
card(fiction_books, "The Master and Margarita", "Mikhail Bulgakov").
card(fiction_books, "The Mayor of Casterbridge", "Thomas Hardy").
card(fiction_books, "The Metamorphosis", "Franz Kafka").
card(fiction_books, "The Mill on the Floss", "George Eliot").
card(fiction_books, "The Moon and the Bonfires", "Cesare Pavese").
card(fiction_books, "The Moviegoer", "Walker Percy").
card(fiction_books, "The Naked Dead", "Norman Mailer").
card(fiction_books, "The Name of the Rose", "Umberto Eco").
card(fiction_books, "The Nibelungenlied", "Anonymous").
card(fiction_books, "The Odyssey", "Homer").
card(fiction_books, "The Old Man and the Sea", "Ernest Hemingway").
card(fiction_books, "The Old Wives' Tale", "Arnold Bennett").
card(fiction_books, "The Once and Future King", "T. H. White").
card(fiction_books, "The Persians", "Aeschylus").
card(fiction_books, "The Phantom Tollbooth", "Norton Juster").
card(fiction_books, "The Pickwick Papers", "Charles Dickens").
card(fiction_books, "The Picture of Dorian Gray", "Oscar Wilde").
card(fiction_books, "The Plague", "Albert Camus").
card(fiction_books, "The Poems of [author]", "John Keats; Robert Frost").
card(fiction_books, "The Poisonwood Bible", "Barbara Kingsolver").
card(fiction_books, "The Portrait of a Lady", "Henry James").
card(fiction_books, "The Possessed", "Fyodor Dostoyevsky").
card(fiction_books, "The Posthumous Memoirs of Bras Cubas", "Machado de Assis").
card(fiction_books, "The Prime of Miss Jean Brodie", "Muriel Spark").
card(fiction_books, "The Princess of Cleves", "Madame de La Fayette").
card(fiction_books, "The Quiet American", "Graham Greene").
card(fiction_books, "The Radetzky March", "Joseph Roth").
card(fiction_books, "The Rainbow", "D. H. Lawrence").
card(fiction_books, "The Razor's Edge", "W. Somerset Maugham").
card(fiction_books, "The Red Badge of Courage", "Stephen Crane").
card(fiction_books, "The Red and the Black", "Stendhal").
card(fiction_books, "The Remains of the Day", "Kazuo Ishiguro").
card(fiction_books, "The Republic", "Plato").
card(fiction_books, "The Rime of the Ancient Mariner", "Samuel Taylor Coleridge").
card(fiction_books, "The Road", "Cormac McCarthy").
card(fiction_books, "The Savage Detectives", "Roberto Bolaño").
card(fiction_books, "The Scarlet Letter", "Nathaniel Hawthorne").
card(fiction_books, "The Sea, The Sea", "Iris Murdoch").
card(fiction_books, "The Secret Agent", "Joseph Conrad").
card(fiction_books, "The Secret History", "Donna Tartt").
card(fiction_books, "The Sense of an Ending", "Julian Barnes").
card(fiction_books, "The Shining", "Stephen King").
card(fiction_books, "The Shipping News", "E. Annie Proulx").
card(fiction_books, "The Silver Chair: The Chronicles of Narnia", "C. S. Lewis").
card(fiction_books, "The Sorrows of Young Werther", "Johann Wolfgang von Goethe").
card(fiction_books, "The Sound and the Fury", "William Faulkner").
card(fiction_books, "The Stand", "Stephen King").
card(fiction_books, "The Stone Diaries", "Carol Shields").
card(fiction_books, "The Stories of [author]", "Anton Chekhov; John Cheever; Raymond Carver").
card(fiction_books, "The Strange Case of Dr. Jekyll and Mr. Hyde", "Robert Louis Stevenson").
card(fiction_books, "The Stranger", "Albert Camus").
card(fiction_books, "The Sun Also Rises", "Ernest Hemingway").
card(fiction_books, "The Suppliants", "Aeschylus").
card(fiction_books, "The Tale of Genji", "Murasaki Shikibu").
card(fiction_books, "The Tale of Peter Rabbit", "Beatrix Potter").
card(fiction_books, "The Talented Mr. Ripley", "Patricia Highsmith").
card(fiction_books, "The Tartar Steppe", "Dino Buzzati").
card(fiction_books, "The Tempest", "William Shakespeare").
card(fiction_books, "The Temple of the Golden Pavilion", "Yukio Mishima").
card(fiction_books, "The Things They Carried", "Tim O'Brien").
card(fiction_books, "The Thorn Birds", "Colleen McCullough").
card(fiction_books, "The Three Musketeers", "Alexandre Dumas").
card(fiction_books, "The Time Machine", "H. G. Wells").
card(fiction_books, "The Tin Drum", "Günter Grass").
card(fiction_books, "The Trial", "Franz Kafka").
card(fiction_books, "The Unbearable Lightness of Being", "Milan Kundera").
card(fiction_books, "The Unnamable", "Samuel Beckett").
card(fiction_books, "The Voyage of the Dawn Treader: The Chronicles of Narnia", "C. S. Lewis").
card(fiction_books, "The War of the End of the World", "Mario Vargas Llosa").
card(fiction_books, "The Waste Land", "T. S. Eliot").
card(fiction_books, "The Waves", "Virginia Woolf").
card(fiction_books, "The Way We Live Now", "Anthony Trollope").
card(fiction_books, "The White Tiger", "Aravind Adiga").
card(fiction_books, "The Wind in the Willows", "Kenneth Grahame").
card(fiction_books, "The Wind-Up Bird Chronicle", "Haruki Murakami").
card(fiction_books, "The Woman in White", "Wilkie Collins").
card(fiction_books, "The Wonderful Wizard of Oz", "L. Frank Baum").
card(fiction_books, "The World According to Garp", "John Irving").
card(fiction_books, "Their Eyes Were Watching God", "Zora Neale Hurston").
card(fiction_books, "Things Fall Apart", "Chinua Achebe").
card(fiction_books, "Three Sisters", "Anton Chekhov").
card(fiction_books, "Through the Looking Glass", "Lewis Carroll").
card(fiction_books, "Thus Spake Zarathustra", "Friedrich Nietzsche").
card(fiction_books, "Thérèse Raquin", "Emile Zola").
card(fiction_books, "To Kill a Mockingbird", "Harper Lee").
card(fiction_books, "To Let", "John Galsworthy").
card(fiction_books, "To the Lighthouse", "Virginia Woolf").
card(fiction_books, "Tom Jones", "Henry Fielding").
card(fiction_books, "Treasure Island", "Robert Louis Stevenson").
card(fiction_books, "Tristram Shandy", "Laurence Sterne").
card(fiction_books, "Tropic of Cancer", "Henry Miller").
card(fiction_books, "Twenty Thousand Leagues Under the Sea", "Jules Verne").
card(fiction_books, "Ulysses", "James Joyce").
card(fiction_books, "Uncle Tom's Cabin", "Harriet Beecher Stowe").
card(fiction_books, "Under the Net", "Iris Murdoch").
card(fiction_books, "Under the Volcano", "Malcolm Lowry").
card(fiction_books, "Underworld", "Don DeLillo").
card(fiction_books, "Vanity Fair", "William Makepeace Thackeray").
card(fiction_books, "Waiting for Godot", "Samuel Beckett").
card(fiction_books, "Waiting for the Barbarians", "J M Coetzee").
card(fiction_books, "War and Peace", "Leo Tolstoy").
card(fiction_books, "War of the Worlds", "H. G. Wells").
card(fiction_books, "Watchmen", "Alan Moore, Dave Gibbons").
card(fiction_books, "Watership Down", "Richard Adams").
card(fiction_books, "Way of All Flesh", "Samuel Butler").
card(fiction_books, "We", "Yevgeny Zamyatin").
card(fiction_books, "Where the Wild Things Are", "Maurice Sendak").
card(fiction_books, "White Noise", "Don DeLillo").
card(fiction_books, "White Teeth", "Zadie Smith").
card(fiction_books, "Wide Sargasso Sea", "Jean Rhys").
card(fiction_books, "Winesburg, Ohio", "Sherwood Anderson").
card(fiction_books, "Wings of the Dove", "Henry James").
card(fiction_books, "Winnie the Pooh", "A. A Milne").
card(fiction_books, "Wolf Hall", "Hilary Mantel").
card(fiction_books, "Women in Love", "D. H. Lawrence").
card(fiction_books, "Women of Trachis", "Sophocles").
card(fiction_books, "Wuthering Heights", "Emily Brontë").
card(fiction_books, "Zorba the Greek", "Nikos Kazantzakis").
card(git_commands, "add", "Add file contents to the index").
card(git_commands, "bisect", "Use binary search to find the commit that introduced a bug").
card(git_commands, "branch", "List, create, or delete branches").
card(git_commands, "checkout", "Switch branches or restore working tree files").
card(git_commands, "clone", "Clone a repository into a new directory").
card(git_commands, "commit", "Record changes to the repository").
card(git_commands, "diff", "Show changes between commits, commit and working tree, etc").
card(git_commands, "fetch", "Download objects and refs from another repository").
card(git_commands, "grep", "Print lines matching a pattern").
card(git_commands, "init", "Create an empty Git repository or reinitialize an existing one").
card(git_commands, "log", "Show commit logs").
card(git_commands, "merge", "Join two or more development histories together").
card(git_commands, "mv", "Move or rename a file, a directory, or a symlink").
card(git_commands, "pull", "Fetch from and integrate with another repository or a local branch").
card(git_commands, "push", "Update remote refs along with associated objects").
card(git_commands, "rebase", "Reapply commits on top of another base tip").
card(git_commands, "reset", "Reset current HEAD to the specified state").
card(git_commands, "rm", "Remove files from the working tree and from the index").
card(git_commands, "show", "Show various types of objects").
card(git_commands, "status", "Show the working tree status").
card(git_commands, "tag", "Create, list, delete or verify a tag object signed with GPG").
card(greek_and_roman_gods, "Aphrodite", "Venus").
card(greek_and_roman_gods, "Apollo", "Apollo").
card(greek_and_roman_gods, "Ares", "Mars").
card(greek_and_roman_gods, "Artemis", "Diana").
card(greek_and_roman_gods, "Athena", "Minerva").
card(greek_and_roman_gods, "Charites", "Gratiae").
card(greek_and_roman_gods, "Demeter", "Ceres").
card(greek_and_roman_gods, "Erinyes", "Furiae").
card(greek_and_roman_gods, "Eris", "Discordia").
card(greek_and_roman_gods, "Eros", "Cupid").
card(greek_and_roman_gods, "Hades", "Pluto").
card(greek_and_roman_gods, "Helios", "Sol").
card(greek_and_roman_gods, "Hephaistos", "Vulcan").
card(greek_and_roman_gods, "Hera", "Juno").
card(greek_and_roman_gods, "Hermes", "Mercury").
card(greek_and_roman_gods, "Hestia", "Vesta").
card(greek_and_roman_gods, "Horai", "Horae").
card(greek_and_roman_gods, "Kronos", "Saturn").
card(greek_and_roman_gods, "Moirae", "Parcae").
card(greek_and_roman_gods, "Pan", "Faunus").
card(greek_and_roman_gods, "Persephone", "Proserpina").
card(greek_and_roman_gods, "Poseidon", "Neptune").
card(greek_and_roman_gods, "Selene", "Luna").
card(greek_and_roman_gods, "Tyche", "Fortuna").
card(greek_and_roman_gods, "Zeus", "Jupiter").
card(greek_gods, "Aphrodite", "love").
card(greek_gods, "Apollo", "prophecy and light").
card(greek_gods, "Ares", "war").
card(greek_gods, "Artemis", "hunting").
card(greek_gods, "Athena", "wisdom and crafts").
card(greek_gods, "Charites", "charm and beauty.").
card(greek_gods, "Demeter", "fertility and cultivation of grain").
card(greek_gods, "Erinyes", "vengeance for wrongs").
card(greek_gods, "Eris", "discord").
card(greek_gods, "Eros", "love and desire").
card(greek_gods, "Hades", "the underworld").
card(greek_gods, "Helios", "the sun").
card(greek_gods, "Hephaistos", "fire and forge").
card(greek_gods, "Hera", "marriage").
card(greek_gods, "Hermes", "messenger, trickster, and god of commerce").
card(greek_gods, "Hestia", "hearth fires").
card(greek_gods, "Horai", "the seasons").
card(greek_gods, "Kronos", "father of Zeus").
card(greek_gods, "Moirae", "fate").
card(greek_gods, "Pan", "goat-footed shepherd").
card(greek_gods, "Persephone", "spring vegetation").
card(greek_gods, "Poseidon", "the sea and horses").
card(greek_gods, "Selene", "the moon").
card(greek_gods, "Tyche", "chance and good fortune").
card(greek_gods, "Zeus", "sky and thunder").
card(latin_phrases, "a fortiori", "from the stronger").
card(latin_phrases, "a posteriori", "from the latter").
card(latin_phrases, "a priori", "from the earlier").
card(latin_phrases, "ad hoc", "for this").
card(latin_phrases, "ad libitum", "at pleasure").
card(latin_phrases, "alter ego", "another self").
card(latin_phrases, "argumentum ab absurdo", "argument from absurdity").
card(latin_phrases, "argumentum ab auctoritate", "argument from authority").
card(latin_phrases, "argumentum ad antiquitatem", "argument from antiquity").
card(latin_phrases, "argumentum ad baculum", "argument to a stick").
card(latin_phrases, "argumentum ad consequentiam", "argument to consequences").
card(latin_phrases, "argumentum ad crumenam", "argument to wealth").
card(latin_phrases, "argumentum ad hominem", "argument to a person").
card(latin_phrases, "argumentum ad ignorantiam", "argument to ignorance").
card(latin_phrases, "argumentum ad infinitum", "argument to infinity").
card(latin_phrases, "argumentum ad lapidem", "argument to a stone").
card(latin_phrases, "argumentum ad lazarum", "argument to poverty").
card(latin_phrases, "argumentum ad misericordiam", "argument to pity").
card(latin_phrases, "argumentum ad naturam", "argument to nature").
card(latin_phrases, "argumentum ad nauseam", "argument to nausea").
card(latin_phrases, "argumentum ad novitatem", "argument to novelty").
card(latin_phrases, "argumentum ad odium", "argument to hate").
card(latin_phrases, "argumentum ad passiones", "argument to emotions").
card(latin_phrases, "argumentum ad populum", "argument to the people").
card(latin_phrases, "argumentum ad temperantiam", "argument to moderation").
card(latin_phrases, "argumentum ad verecundiam", "argument to authority").
card(latin_phrases, "argumentum ex silentio", "argument to silence").
card(latin_phrases, "bona fide", "in good faith").
card(latin_phrases, "carpe diem", "seize the day").
card(latin_phrases, "caveat emptor", "let the buyer beware").
card(latin_phrases, "caveat lector", "let the reader beware").
card(latin_phrases, "caveat venditor", "let the seller beware").
card(latin_phrases, "consensus", "consent").
card(latin_phrases, "de facto", "in fact").
card(latin_phrases, "de jure", "in law").
card(latin_phrases, "ergo", "therefore").
card(latin_phrases, "et cetera", "and the rest").
card(latin_phrases, "excelsior", "higher").
card(latin_phrases, "ignoratio elenchi", "ignoring the refutation").
card(latin_phrases, "in re", "in the matter of").
card(latin_phrases, "major", "greater").
card(latin_phrases, "mea culpa", "my fault").
card(latin_phrases, "per capita", "per person").
card(latin_phrases, "per diem", "per day").
card(latin_phrases, "per se", "essentially").
card(latin_phrases, "petitio principii", "begging the question").
card(latin_phrases, "post hoc ergo propter hoc", "after this, therefore because of this").
card(latin_phrases, "primum nil nocere; primum non nocere", "first, to do no harm").
card(latin_phrases, "status quo", "state in which").
card(latin_phrases, "tu quoque", "you also").
card(latin_phrases, "verbatim", "word for word").
card(latin_phrases, "vice versa", "conversely").
card(laws_of_computing, "60/60 Rule", "Sixty percent of software's dollar is spent on maintenance, and sixty percent of that maintenance is enhancement").
card(laws_of_computing, "90/90 Rule", "The first 90% of the code accounts for the first 90% of the development time; the remaining 10% of the code accounts for the other 90% of the development time").
card(laws_of_computing, "Amdahl's Law", "In parallel computing, theoretical speedup depends on the portion of time spent on the task being speeded up, or Speedup = 1/((1-p)+p/s)").
card(laws_of_computing, "Bell's Law of Computer Classes", "Roughly every decade a new computer industry forms based on a new programming platform, network, and interface").
card(laws_of_computing, "Benford's Law", "In many naturally occurring collections of numbers, the leading significant digit is likely to be small").
card(laws_of_computing, "Brooke's Law", "Adding workers to a late software project makes it later").
card(laws_of_computing, "Conway's Law", "Any piece of software reflects the organizational structure that produced it").
card(laws_of_computing, "Ellison's Law of Cryptography and Usability", "The userbase for strong cryptography declines by half with every additional keystroke or mouseclick required to make it work").
card(laws_of_computing, "Fitts's Law", "The time to acquire a target is a function of the distance to and the size of the target, or Time = a + b log2(D/S + 1)").
card(laws_of_computing, "Flon's Axiom", "There does not now, nor will there ever, exist a programming language in which it is the least bit hard to write bad programs").
card(laws_of_computing, "Greenspun's Tenth Rule of Programming", "Any sufficiently complicated C or Fortran program contains an ad-hoc, informally-specified, bug-ridden, slow implementation of half of Common Lisp").
card(laws_of_computing, "Hartree's Law", "Whatever the state of a project, the time a project-leader will estimate for completion is constant").
card(laws_of_computing, "Hick's Law", "The time to make a decision is a function of the possible choices he or she has, or Time = b log2(n + 1)").
card(laws_of_computing, "Hofstadter's Law", "A task always takes longer than you expect, even when you take into account this law").
card(laws_of_computing, "Jakob's Law of Internet User Experience", "Users spend most of their time on other sites. This means that users prefer your site to work the same way as all the other sites they already know.").
card(laws_of_computing, "Kerchkoff's Law", "In cryptography, a system should be secure even if everything about the system, except for a small piece of information - the key - is public knowledge").
card(laws_of_computing, "Linus's Law", "Given enough eyeballs, all bugs are shallow").
card(laws_of_computing, "Metcalfe's Law", "In network theory, the value of a system grows as approximately the square of the number of users of the system").
card(laws_of_computing, "Moore's Law", "The number of transistors on an integrated circuit will double in about two years").
card(laws_of_computing, "Nielsen's Law", "Network connection speeds for high-end home users will increase 50% per year").
card(laws_of_computing, "Occam's razor; law of parsimony", "The simplest explanation is usually the right one").
card(laws_of_computing, "Pareto Principle", "For many phenomena, 80% of consequences stem from 20% of the causes").
card(laws_of_computing, "Parkinson's Law", "Work expands so as to fill the time available for its completion").
card(laws_of_computing, "Postel's Law", "Be conservative in what you send, liberal in what you accept").
card(laws_of_computing, "Reed's Law", "The utility of large networks, particularly social networks, scales exponentially with the size of the network").
card(laws_of_computing, "Spector's Law", "The time it takes your favorite application to complete a given task doubles with each new revision").
card(laws_of_computing, "Sturgeon's Law", "Ninety percent of everything is crud").
card(laws_of_computing, "Tesler's Law of Conservation as Complexity", "You cannot reduce the complexity of a given task beyond a certain point").
card(laws_of_computing, "Weibull's Power Law", "The logarithm of failure rates increases linearly with the logarithm of age").
card(laws_of_computing, "Wirth's Law", "Software gets slower faster than hardware gets faster").
card(laws_of_computing, "Zawinksi's Law", "Every program attempts to expand until it can read mail").
card(moons, "Amalthea", "Jupiter").
card(moons, "Ariel", "Uranus").
card(moons, "Callisto", "Jupiter").
card(moons, "Charon", "Pluto").
card(moons, "Deimos", "Mars").
card(moons, "Dione", "Saturn").
card(moons, "Enceladus", "Saturn").
card(moons, "Europa", "Jupiter").
card(moons, "Ganymede", "Jupiter").
card(moons, "Hyperion", "Saturn").
card(moons, "Iapetus", "Saturn").
card(moons, "Io", "Jupiter").
card(moons, "Mimas", "Saturn").
card(moons, "Miranda", "Uranus").
card(moons, "Moon", "Earth").
card(moons, "Nereid", "Neptune").
card(moons, "Oberon", "Uranus").
card(moons, "Phobos", "Mars").
card(moons, "Phoebe", "Saturn").
card(moons, "Rhea", "Saturn").
card(moons, "Tethys", "Saturn").
card(moons, "Titan", "Saturn").
card(moons, "Titania", "Uranus").
card(moons, "Triton", "Neptune").
card(moons, "Umbriel", "Uranus").
card(nonfiction_books, " Bureaucracy", "Ludwig von Mises").
card(nonfiction_books, " Mont-Saint-Michel and Chartres", "Henry Adams").
card(nonfiction_books, " The Economy of Cities", "Jane Jacobs").
card(nonfiction_books, " The Feynman Lectures on Physics", "Richard P. Feynman").
card(nonfiction_books, " The Unheavenly City", "Edward C. Banfield").
card(nonfiction_books, "A Brief History of Time", "Stephen Hawking").
card(nonfiction_books, "A Bright Shining Lie", "Neil Sheehan").
card(nonfiction_books, "A Dictionary of the English Language", "Samuel Johnson").
card(nonfiction_books, "A Field Guide to the Birds", "Roger Tory Peterson").
card(nonfiction_books, "A Fire on the Moon", "Norman Mailer").
card(nonfiction_books, "A General Introduction to Psycho-Analysis", "Sigmund Freud").
card(nonfiction_books, "A Heartbreaking Work of Staggering Genius", "Dave Eggers").
card(nonfiction_books, "A History of Philosophy", "Frederick Charles Copleston").
card(nonfiction_books, "A Long Way Gone: Memoirs of a Boy Soldier", "Ishmael Beah").
card(nonfiction_books, "A Mathematician's Apology", "G. H. Hardy").
card(nonfiction_books, "A Modest Proposal and Other Satirical Works", "Jonathan Swift").
card(nonfiction_books, "A People's History of the United States", "Howard Zinn").
card(nonfiction_books, "A Room of One's Own", "Virginia Woolf").
card(nonfiction_books, "A Sand County Almanac", "Aldo Leopold").
card(nonfiction_books, "A Stillness at Appomattox", "Bruce Catton").
card(nonfiction_books, "A Study of History", "Arnold J. Toynbee").
card(nonfiction_books, "A Supposedly Fun Thing I'll Never Do Again", "David Foster Wallace").
card(nonfiction_books, "A Theory Of The Consumption Function", "Milton Friedman").
card(nonfiction_books, "A Vindication of the Rights of Woman", "Mary Wollstonecraft").
card(nonfiction_books, "After Virtue", "Alasdair MacIntyre").
card(nonfiction_books, "Against Our Will", "Susan Brownmiller").
card(nonfiction_books, "All the President's Men", "Carl Bernstein").
card(nonfiction_books, "Almagest", "Ptolemy").
card(nonfiction_books, "América Hispánica: (1492-1898)", "Guillermo Céspedes del Castillo").
card(nonfiction_books, "An American Dilemma", "Gunnar Myrdal").
card(nonfiction_books, "An Autobiography of [author]", "Anthony Trollope").
card(nonfiction_books, "An Enquiry Concerning Human Understanding", "David Hume").
card(nonfiction_books, "An Essay Concerning Human Understanding", "John Locke").
card(nonfiction_books, "An Introduction to Mathematics", "Alfred North Whitehead").
card(nonfiction_books, "An Introduction to Metaphysics", "Henri Bergson").
card(nonfiction_books, "Analects", "Confucius").
card(nonfiction_books, "And the Band Played On", "Randy Shilts").
card(nonfiction_books, "Angela's Ashes: A Memoir", "Frank McCourt").
card(nonfiction_books, "Annals", "Cornelius Tacitus").
card(nonfiction_books, "Apology", "Plato").
card(nonfiction_books, "Armenian Atrocities: The Murder of a Nation", "Arnold Toynbee").
card(nonfiction_books, "Aspects of the Novel", "E. M. Forster").
card(nonfiction_books, "Atomic Theory and the Description of Nature", "Niels Bohr").
card(nonfiction_books, "Autobiographies", "W. B. Yeats").
card(nonfiction_books, "Bad Science", "Ben Goldacre").
card(nonfiction_books, "Ball Four", "Jim Bouton").
card(nonfiction_books, "Balzac", "Stefan Zweig").
card(nonfiction_books, "Basic Documents in American History", "Richard Brandon Morris").
card(nonfiction_books, "Battle Cry of Freedom", "James M. McPherson").
card(nonfiction_books, "Before Night Falls", "Reinaldo Arenas").
card(nonfiction_books, "Being and Nothingness", "Jean Paul Sartre").
card(nonfiction_books, "Being and Time", "Martin Heidegger").
card(nonfiction_books, "Between the World and Me", "Ta-Nehisi Coates").
card(nonfiction_books, "Beyond Good and Evil", "Friedrich Nietzsche").
card(nonfiction_books, "Beyond the Pleasure Principle", "Sigmund Freud").
card(nonfiction_books, "Birthday Letters", "Ted Hughes").
card(nonfiction_books, "Black Boy", "Richard Wright").
card(nonfiction_books, "Black Lamb and Grey Falcon", "Rebecca West").
card(nonfiction_books, "Borstal Boy", "Brendan Behan").
card(nonfiction_books, "Bury My Heart at Wounded Knee", "Dee Alexander Brown").
card(nonfiction_books, "Capitalism and Freedom", "Milton Friedman").
card(nonfiction_books, "Capitalism, Socialism, and Democracy", "Joseph A. Schumpeter").
card(nonfiction_books, "Care of the Soul: Guide for Cultivating Depth and Sacredness", "Thomas More").
card(nonfiction_books, "Cataract", "Mykhaylo Osadchy").
card(nonfiction_books, "Centesimus Annus", "Pope John Paul II").
card(nonfiction_books, "Charter of the [author]", "United Nations").
card(nonfiction_books, "Children of Crisis", "Robert Coles").
card(nonfiction_books, "Christ Stopped at Eboli: The Story of a Year", "Carlo Levi").
card(nonfiction_books, "Chronicles of Wasted Time", "Malcolm Muggeridge").
card(nonfiction_books, "Citizens", "Simon Schama").
card(nonfiction_books, "Civil Disobedience", "Henry David Thoreau").
card(nonfiction_books, "Civilisation", "Kenneth Clark").
card(nonfiction_books, "Civilization and Its Discontents", "Sigmund Freud").
card(nonfiction_books, "Collected Essays of [author]", "George Orwell").
card(nonfiction_books, "Coming of Age in Samoa", "Margaret Mead").
card(nonfiction_books, "Common Ground", "J. Anthony Lukas").
card(nonfiction_books, "Common Sense", "Thomas Paine").
card(nonfiction_books, "Communist Manifesto", "Friedrich Engels").
card(nonfiction_books, "Confessions ", "Augustine").
card(nonfiction_books, "Corpus Aristotelicum", "Aristotle").
card(nonfiction_books, "Correspondence", "Voltaire").
card(nonfiction_books, "Critique of Pure Reason", "Immanuel Kant").
card(nonfiction_books, "Darwin's Black Box", "Michael J. Behe").
card(nonfiction_books, "Das Kapital", "Karl Marx").
card(nonfiction_books, "Democracy and Leadership", "Irving Babbitt").
card(nonfiction_books, "Democracy in America", "Alexis de Tocqueville").
card(nonfiction_books, "Democratic Vistas", "Walt Whitman").
card(nonfiction_books, "Der Judenstaat", "Theodor Herzl").
card(nonfiction_books, "Desert Solitaire", "Edward Abbey").
card(nonfiction_books, "Dialogue Concerning the Two Chief World Systems", "Galileo").
card(nonfiction_books, "Discourse on Method", "Rene Descartes").
card(nonfiction_books, "Discussion with Einstein on Epistemology", "Niels Bohr").
card(nonfiction_books, "Dispatches", "Michael Herr").
card(nonfiction_books, "Disraeli", "Robert Blake").
card(nonfiction_books, "Down Second Avenue", "Es'kia Mphahlele").
card(nonfiction_books, "Dreams from My Father", "Barack Obama").
card(nonfiction_books, "Duke of Deception", "Geoffrey Wolff").
card(nonfiction_books, "Dust Tracks on a Road: An Autobiography", "Zora Neale Hurston").
card(nonfiction_books, "Eats, Shoots and Leaves", "Lynne Truss").
card(nonfiction_books, "Economy and Society", "Max Weber").
card(nonfiction_books, "Edith Wharton: A Biography", "R. W. B. Lewis").
card(nonfiction_books, "Either Or", "Soren Kierkegaard").
card(nonfiction_books, "El Bulli: 1998-2002", "Albert Adria").
card(nonfiction_books, "Emile, or On Education", "Jean-Jacques Rousseau").
card(nonfiction_books, "Eminent Victorians", "Lytton Strachey").
card(nonfiction_books, "Encyclopédie", "Denis Diderot").
card(nonfiction_books, "Enneads", "Plotinus").
card(nonfiction_books, "Epitome of Copernican Astronomy", "Johannes Kepler").
card(nonfiction_books, "Essays and Aphorisms", "Arthur Schopenhauer").
card(nonfiction_books, "Essays in Sociology", "Max Weber").
card(nonfiction_books, "Essays of [author]", "E. B. White").
card(nonfiction_books, "Essays", "Michel de Montaigne").
card(nonfiction_books, "Essential Cuisine", "Michel Bras").
card(nonfiction_books, "Ethics", "Baruch de Spinoza").
card(nonfiction_books, "Ethnic America", "Thomas Sowell").
card(nonfiction_books, "Etiquette in Society, in Business, in Politics and at Home", "Emily Post").
card(nonfiction_books, "Experience in Education", "John Dewey").
card(nonfiction_books, "Facundo", "Domingo Faustino Sarmiento").
card(nonfiction_books, "Fear and Trembling", "Soren Kierkegaard").
card(nonfiction_books, "First They Killed My Father: A Daughter of Cambodia Remembers", "Loung Ung").
card(nonfiction_books, "Freakonomics", "Stephen J. Dubner").
card(nonfiction_books, "Future Shock: The Third Wave", "Alvin Toffler").
card(nonfiction_books, "Genetics and the Origin of Species", "Theodosius Dobzhansky").
card(nonfiction_books, "God and Man at Yale", "William F. Buckley, Jr").
card(nonfiction_books, "Good-Bye to All That", "Robert Graves").
card(nonfiction_books, "Great Bridge", "David McCullough").
card(nonfiction_books, "Groundwork of the Metaphysic of Morals", "Immanuel Kant").
card(nonfiction_books, "Group Psychology and the Analysis of the Ego", "Sigmund Freud").
card(nonfiction_books, "Growing Up Absurd", "Paul Goodman").
card(nonfiction_books, "Guns, Germs, and Steel", "Jared Diamond").
card(nonfiction_books, "Gödel, Escher, Bach", "Douglas Hofstadter").
card(nonfiction_books, "Hard Times: An Oral History of the Great Depression", "Studs Terkel").
card(nonfiction_books, "Hell's Angels", "Hunter S. Thompson").
card(nonfiction_books, "Henry James", "Leon Edel").
card(nonfiction_books, "Hideous Kinky", "Esther Freud").
card(nonfiction_books, "Hippocratic Corpus", "Hippocrates").
card(nonfiction_books, "Hiroshima", "John Hersey").
card(nonfiction_books, "Histories", "Cornelius Tacitus").
card(nonfiction_books, "History of My Life", "Giacomo Casanova").
card(nonfiction_books, "Hollywood Babylon", "Kenneth Anger").
card(nonfiction_books, "Homage to Catalonia", "George Orwell").
card(nonfiction_books, "How to Cook", "Delia Smith").
card(nonfiction_books, "How to Win Friends and Influence People", "Dale Carnegie").
card(nonfiction_books, "I Ching", "China").
card(nonfiction_books, "I Know Why the Caged Bird Sings", "Maya Angelou").
card(nonfiction_books, "I, Rigoberta Menchú: An Indian Woman in Guatemala", "Rigoberta Menchú Tum").
card(nonfiction_books, "Ideas Have Consequences", "Richard M. Weaver").
card(nonfiction_books, "If This Is a Man", "Primo Levi").
card(nonfiction_books, "In Cold Blood", "Truman Capote").
card(nonfiction_books, "In the Heart of the Sea", "Nathaniel Philbrick").
card(nonfiction_books, "Inhibitions, Symptoms, and Anxiety", "Sigmund Freud").
card(nonfiction_books, "Insight: A Study of Human Understanding", "Bernard Lonergan").
card(nonfiction_books, "Instincts and Their Vicissitudes", "Sigmund Freud").
card(nonfiction_books, "Institutes of the Christian Religion", "John Calvin").
card(nonfiction_books, "James Joyce", "Richard Ellmann").
card(nonfiction_books, "Jefferson and His Time", "Dumas Malone").
card(nonfiction_books, "Journals: 1889-1913", "André Gide").
card(nonfiction_books, "Kaffir Boy", "Mark Mathabane").
card(nonfiction_books, "Kafka's Other Trial", "Elias Canetti").
card(nonfiction_books, "King Solomon's Ring", "Konrad Lorenz").
card(nonfiction_books, "Larousse Gastronomique: The World's Greatest Culinary Encyclopedia", "Joël Robuchon").
card(nonfiction_books, "Les Caractères ", "Jean de La Bruyère").
card(nonfiction_books, "Let Us Now Praise Famous Men", "James Agee").
card(nonfiction_books, "Letters from a Stoic", "Seneca").
card(nonfiction_books, "Letters to a Young Poet", "Rainer Maria Rilke").
card(nonfiction_books, "Lettres de madame de Sévigné", "Marie de Rabutin-Chantal marquise de Sévigné").
card(nonfiction_books, "Leviathan", "Thomas Hobbes").
card(nonfiction_books, "Life is a Carawanserai Has Two Doors I Went in One I Came out the Other", "Emine Sevgi Özdamar").
card(nonfiction_books, "Life on the Mississippi", "Mark Twain").
card(nonfiction_books, "Lives of the Caesars", "Suetonius").
card(nonfiction_books, "London: The Biography", "Peter Ackroyd").
card(nonfiction_books, "Long Walk to Freedom: The Autobiography of [author]", "Nelson Mandela").
card(nonfiction_books, "Look Homeward, Angel", "Thomas Wolfe").
card(nonfiction_books, "Looking Back", "Norman Douglas").
card(nonfiction_books, "Lost in the Cosmos", "Walker Percy").
card(nonfiction_books, "Love in the Western World", "Denis de Rougemont").
card(nonfiction_books, "Love's Work", "Gillian Rose").
card(nonfiction_books, "Main Currents in American Thought", "Vernon L Parrington").
card(nonfiction_books, "Man's Search for Meaning", "Victor Frankl").
card(nonfiction_books, "Master of the Senate", "Robert Caro").
card(nonfiction_books, "Maus", "Art Spiegelman").
card(nonfiction_books, "Maximes", "François duc de La Rochefoucauld").
card(nonfiction_books, "Me Talk Pretty One Day", "David Sedaris").
card(nonfiction_books, "Meditations", "Marcus Aurelius").
card(nonfiction_books, "Mein Kampf", "Adolf Hitler").
card(nonfiction_books, "Memoirs From Beyond the Grave", "François René De Chateaubriand").
card(nonfiction_books, "Memoirs of Cardinal De Retz ", "Cardinal de Retz").
card(nonfiction_books, "Memoirs of My Nervous Illness", "Daniel Paul Schreber").
card(nonfiction_books, "Mere Christianity", "C. S. Lewis").
card(nonfiction_books, "Metaphysics", "Aristotle").
card(nonfiction_books, "Microbe Hunters", "Paul de Kruif").
card(nonfiction_books, "Modern Times", "Paul Johnson").
card(nonfiction_books, "Moneyball", "Michael M. Lewis").
card(nonfiction_books, "Moveable Feast", "Ernest Hemingway").
card(nonfiction_books, "My Childhood", "Maxim Gorky").
card(nonfiction_books, "My Fight for Birth Control", "Margaret Sanger").
card(nonfiction_books, "Mythology", "Edith Hamilton").
card(nonfiction_books, "Nadja", "André Breton").
card(nonfiction_books, "Narrative of the Life of [author]", "Frederick Douglass").
card(nonfiction_books, "Natural Right and History", "Leo Strauss").
card(nonfiction_books, "Nature and Destiny of Man", "Reinhold Niebuhr").
card(nonfiction_books, "New Introductory Lectures on Psycho-Analysis", "Sigmund Freud").
card(nonfiction_books, "Nickel And Dimed", "Barbara Ehrenreich").
card(nonfiction_books, "Night", "Elie Wiesel").
card(nonfiction_books, "North", "Seamus Heaney").
card(nonfiction_books, "Notes from a Small Island", "Bill Bryson").
card(nonfiction_books, "Notes of a Native Son", "James Baldwin").
card(nonfiction_books, "Observations on \"Wild\" Psycho-Analysis", "Sigmund Freud").
card(nonfiction_books, "On Death and Dying", "Elisabeth Kübler-Ross").
card(nonfiction_books, "On Food and Cooking: The Science and Lore of the Kitchen", "Harold McGee").
card(nonfiction_books, "On Liberty", "John Stuart Mill").
card(nonfiction_books, "On Narcissism", "Sigmund Freud").
card(nonfiction_books, "On War", "Carl Von Clausewitz").
card(nonfiction_books, "On Writing", "Stephen King").
card(nonfiction_books, "On the Genealogy of Morality", "Friedrich Nietzsche").
card(nonfiction_books, "On the Origin of Species", "Charles Darwin").
card(nonfiction_books, "On the Revolutions of the Heavenly Spheres", "Nicolaus Copernicus").
card(nonfiction_books, "Orthodoxy", "G. K. Chesterton").
card(nonfiction_books, "Our Band Could Be Your Life: Scenes from the American Indie Underground, 1981-1991", "Michael Azerrad").
card(nonfiction_books, "Out of Africa", "Isak Dinesen").
card(nonfiction_books, "Oxford English Dictionary", "Oxford University Press").
card(nonfiction_books, "Parallel Lives", "Plutarch").
card(nonfiction_books, "Parting the Waters", "Taylor Branch").
card(nonfiction_books, "Patriotic Gore", "Edmund Wilson").
card(nonfiction_books, "Pavel's Letters", "Monika Maron").
card(nonfiction_books, "Pensées", "Blaise Pascal").
card(nonfiction_books, "Persepolis", "Marjane Satrapi").
card(nonfiction_books, "Persons and Places", "George Santayana").
card(nonfiction_books, "Phaedo", "Plato").
card(nonfiction_books, "Philosophical Investigations", "Ludwig Wittgenstein").
card(nonfiction_books, "Philosophical Writings", "Novalis").
card(nonfiction_books, "Physics and Philosophy", "Werner Heisenberg").
card(nonfiction_books, "Pilgrim at Tinker Creek", "Annie Dillard").
card(nonfiction_books, "Poetics", "Aristotle").
card(nonfiction_books, "Poetry and the Age", "Randall Jarrell").
card(nonfiction_books, "Pragmatism", "Will James").
card(nonfiction_books, "Prejudices", "H. L. Mencken").
card(nonfiction_books, "Present at the Creation", "Dean Acheson").
card(nonfiction_books, "Priestdaddy: A Memoir", "Patricia Lockwood").
card(nonfiction_books, "Principia Mathematica", "Issac Newton").
card(nonfiction_books, "Profiles in Courage", "John F. Kennedy").
card(nonfiction_books, "Promise at Dawn", "Romain Gary").
card(nonfiction_books, "Protestant, Catholic, Jew", "Will Herberg").
card(nonfiction_books, "Quotations from Chairman [author]", "Mao").
card(nonfiction_books, "R. E. Lee", "Douglas Southall Freeman").
card(nonfiction_books, "Radical Chic and Mau-Mauing the Flak Catchers", "Tom Wolfe").
card(nonfiction_books, "Rameau's Nephew", "Denis Diderot").
card(nonfiction_books, "Rationalism in Politics", "Michael Oakeshott").
card(nonfiction_books, "Reading Lolita in Tehran", "Azar Nafisi").
card(nonfiction_books, "Records of the Grand Historian", "Sima Qian").
card(nonfiction_books, "Reflections of a Russian Statesman", "Konstantin P. Pobedonostsev").
card(nonfiction_books, "Relativity", "Albert Einstein").
card(nonfiction_books, "Religion and the Rise of Western Culture", "Christopher Dawson").
card(nonfiction_books, "Repression", "Sigmund Freud").
card(nonfiction_books, "Reveille in Washington", "Margaret Leech").
card(nonfiction_books, "Reveries of a Solitary Walker", "Jean-Jacques Rousseau").
card(nonfiction_books, "Rights of Man", "Thomas Paine").
card(nonfiction_books, "Roll, Jordan, Roll", "Eugene Genovese").
card(nonfiction_books, "Roughing It", "Mark Twain").
card(nonfiction_books, "Russia Leaves the War", "George F. Kennan").
card(nonfiction_books, "Samuel Johnson", "Walter Jackson Bate").
card(nonfiction_books, "Satyagraha in South Africa", "Mahatma Gandhi").
card(nonfiction_books, "Science and Hypothesis", "Henri Poincaré").
card(nonfiction_books, "Science and the Modern World", "Alfred North Whitehead").
card(nonfiction_books, "Scientific Autobiography and Other Papers", "Max Planck").
card(nonfiction_books, "Scrutiny", "F. R. Leavis").
card(nonfiction_books, "Second World War", "John Keegan").
card(nonfiction_books, "Selected Essays of [author]", "T. S. Eliot").
card(nonfiction_books, "Selected Papers on Hysteria", "Sigmund Freud").
card(nonfiction_books, "Seven Years in Tibet", "Heinrich Harrer").
card(nonfiction_books, "Shadow and ACT", "Ralph Ellison").
card(nonfiction_books, "Silent Spring", "Rachel Carson").
card(nonfiction_books, "Sisterhood Is Powerful", "robin morgan ").
card(nonfiction_books, "Slouching Towards Bethlehem", "Joan Didion").
card(nonfiction_books, "Small Is Beautiful: Economics as if People Mattered", "E. F. Schumacher").
card(nonfiction_books, "Smoking and Health", "Surgeon General").
card(nonfiction_books, "Sociobiology", "Edward O. Wilson").
card(nonfiction_books, "Speak, Memory", "Vladimir Nabokov").
card(nonfiction_books, "Storm of Steel", "Ernst Jünger").
card(nonfiction_books, "Strange Defeat", "Marc Bloch").
card(nonfiction_books, "Structural Anthropology", "Claude Lévi-Strauss").
card(nonfiction_books, "Studies in the Psychology of Sex", "Havelock Ellis").
card(nonfiction_books, "Suicide", "Emile Durkheim").
card(nonfiction_books, "Summa Theologica", "Thomas Aquinas").
card(nonfiction_books, "Superhighway--superhoax", "Helen Leavitt").
card(nonfiction_books, "Systematic Theology", "Wolfhart Pannenberg").
card(nonfiction_books, "Tao Te Ching", "Lao Tsu").
card(nonfiction_books, "Teacher in America", "Jacques Barzun").
card(nonfiction_books, "Team of Rivals: The Political Genius of Abraham Lincoln", "Doris Kearns Goodwin").
card(nonfiction_books, "Tell Me How It Ends: An Essay in 40 Questions", "Valeria Luiselli").
card(nonfiction_books, "Ten Days That Shook the World", "John Reed").
card(nonfiction_books, "Testament Of Youth", "Vera Brittain").
card(nonfiction_books, "The ABC of Reading", "Ezra Pound").
card(nonfiction_books, "The Abolition of Man", "C. S. Lewis").
card(nonfiction_books, "The Acquisitive Society", "R. H. Tawney").
card(nonfiction_books, "The Affluent Society", "John Kenneth Galbraith").
card(nonfiction_books, "The Age of Jackson", "Arthur M. Schlesinger, Jr").
card(nonfiction_books, "The Age of Reform", "Richard Hofstadter").
card(nonfiction_books, "The American Language", "H. L. Mencken").
card(nonfiction_books, "The Americans", "Robert Frank").
card(nonfiction_books, "The Ants", "Bert Hölldobler").
card(nonfiction_books, "The Argonauts", "Maggie Nelson").
card(nonfiction_books, "The Armies of the Night", "Norman Mailer").
card(nonfiction_books, "The Art of Memory", "Frances A. Yates").
card(nonfiction_books, "The Art of War", "Sun Zi").
card(nonfiction_books, "The Artist's Way", "Julia Cameron").
card(nonfiction_books, "The Autobiography of Alice B. Toklas", "Gertrude Stein").
card(nonfiction_books, "The Autobiography of Malcolm X", "Alex Haley").
card(nonfiction_books, "The Autobiography of [author]", "Benjamin Franklin; Lincoln Steffens").
card(nonfiction_books, "The Battle with the Slum", "Jacob A. Riis").
card(nonfiction_books, "The Bookseller of Kabul", "Asne Seierstad").
card(nonfiction_books, "The Campaign of the Marne", "Sewell Tyng").
card(nonfiction_books, "The Christian Tradition", "Jaroslav Pelikan").
card(nonfiction_books, "The City in History", "Lewis Mumford").
card(nonfiction_books, "The Civil War", "Shelby Foote").
card(nonfiction_books, "The Closing of the American Mind", "Allan Bloom").
card(nonfiction_books, "The Color of Water: A Black Man's Tribute to His White Mother", "James McBride").
card(nonfiction_books, "The Common Sense Book of Baby and Child Care", "Benjamin Spock").
card(nonfiction_books, "The Complete Works of [author]", "Plato").
card(nonfiction_books, "The Confessions of [author]", "Jean-Jacques Rousseau").
card(nonfiction_books, "The Conservative Mind", "Russell Kirk").
card(nonfiction_books, "The Constitution of Liberty", "Friedrich von Hayek").
card(nonfiction_books, "The Courage to Be", "Paul Tillich").
card(nonfiction_books, "The Crisis of European Sciences and Transcendental Phenomenology", "Edmund Husserl").
card(nonfiction_books, "The Death and Life of Great American Cities", "Jane Jacobs").
card(nonfiction_books, "The Decline and Fall of the Roman Empire", "Edward Gibbon").
card(nonfiction_books, "The Devil In The White City", "Erik Larson").
card(nonfiction_books, "The Diary of a Young Girl", "Anne Frank").
card(nonfiction_books, "The Diversity of Life", "Edward O. Wilson").
card(nonfiction_books, "The Double Helix: A Personal Account of the Discovery of the Structure of DNA", "James D. Watson").
card(nonfiction_books, "The Drowned and the Saved", "Primo Levi").
card(nonfiction_books, "The Edge of the Sword", "Charles De Gaulle").
card(nonfiction_books, "The Education of [author]", "Henry Adams").
card(nonfiction_books, "The Ego and the Id", "Sigmund Freud").
card(nonfiction_books, "The Electric Kool-Aid Acid Test", "Tom Wolfe").
card(nonfiction_books, "The Elements of Style", "E. B. White").
card(nonfiction_books, "The Emperor", "Ryszard Kapuscinski").
card(nonfiction_books, "The End of History and the Last Man", "Francis Fukuyama").
card(nonfiction_books, "The Essential Writings of [author]", "Ralph Waldo Emerson").
card(nonfiction_books, "The Everlasting Man", "G. K. Chesterton").
card(nonfiction_books, "The Expanding Universe", "Arthur Eddington").
card(nonfiction_books, "The Face of Battle", "John Keegan").
card(nonfiction_books, "The Family of Man", "Edward Steichen").
card(nonfiction_books, "The Federalist Papers", "John Jay").
card(nonfiction_books, "The Feminine Mystique", "Betty Friedan").
card(nonfiction_books, "The Fire Next Time", "James Baldwin").
card(nonfiction_books, "The First Tycoon: The Epic Life of Cornelius Vanderbilt", "T. J. Stiles").
card(nonfiction_books, "The Frontier in American History", "Frederick Jackson Turner").
card(nonfiction_books, "The Future Prospects of Psycho-Analytic Therapy", "Sigmund Freud").
card(nonfiction_books, "The General Theory of Employment, Interest and Money", "John Maynard Keynes").
card(nonfiction_books, "The George Sand-[author] Letters", "Gustave Flaubert").
card(nonfiction_books, "The Golden Bough", "James George Frazer").
card(nonfiction_books, "The Good Society", "Walter Lippmann").
card(nonfiction_books, "The Great Chain of Being", "Arthur Lovejoy").
card(nonfiction_books, "The Great Terror", "Robert Conquest").
card(nonfiction_books, "The Great War and Modern Memory", "Paul Fussell").
card(nonfiction_books, "The Gulag Archipelago", "Aleksandr Solzhenitsyn").
card(nonfiction_books, "The Guns of August", "Barbara Tuchman").
card(nonfiction_books, "The Habit of Being", "Flannery O'Connor").
card(nonfiction_books, "The Hare with Amber Eyes: A Family's Century of Art and Loss", "Edmund de Waal").
card(nonfiction_books, "The Harmony of the Worlds", "Johannes Kepler").
card(nonfiction_books, "The Haunted Land", "Tina Rosenberg").
card(nonfiction_books, "The Hedgehog and the Fox", "Isaiah Berlin").
card(nonfiction_books, "The Hemingses of Monticello", "Annette Gordon-Reed").
card(nonfiction_books, "The Hero with a Thousand Faces", "Joseph Campbell").
card(nonfiction_books, "The Histories of [author]", "Herodotus").
card(nonfiction_books, "The History of the Peloponnesian War", "Thucydides").
card(nonfiction_books, "The House of Morgan", "Ron Chernow").
card(nonfiction_books, "The House on Henry Street", "Lillian D. Wald").
card(nonfiction_books, "The Idea of History", "R. G. Collingwood").
card(nonfiction_books, "The Immortal Life of Henrietta Lacks", "Rebecca Skloot").
card(nonfiction_books, "The Interesting Narrative of the Life of [author]", "Olaudah Equiano").
card(nonfiction_books, "The Interpretation of Dreams", "Sigmund Freud").
card(nonfiction_books, "The Invention of Solitude", "Paul Auster").
card(nonfiction_books, "The Journal of [author]", "Jules Renard").
card(nonfiction_books, "The Journalist and the Murderer", "Janet Malcolm").
card(nonfiction_books, "The Joy of Cooking", "Ethan Becker").
card(nonfiction_books, "The Last Lion", "William Manchester").
card(nonfiction_books, "The Liars' Club", "Mary Karr").
card(nonfiction_books, "The Liberal Imagination", "Lionel Trilling").
card(nonfiction_books, "The Life of Charlotte Brontë", "Elizabeth Gaskell").
card(nonfiction_books, "The Life of Samuel Johnson", "James Boswell").
card(nonfiction_books, "The Life of the Bee", "Maurice Maeterlinck").
card(nonfiction_books, "The Lives of a Cell", "Lewis Thomas").
card(nonfiction_books, "The Looming Tower", "Lawrence Wright").
card(nonfiction_books, "The Machiavellians", "James Burnham").
card(nonfiction_books, "The Making of Homeric Verse", "Milman Parry").
card(nonfiction_books, "The Making of the Atomic Bomb", "Richard Rhodes").
card(nonfiction_books, "The Making of the English Working Class", "E. P. Thompson").
card(nonfiction_books, "The Man Who Mistook His Wife for a Hat", "Oliver Sacks").
card(nonfiction_books, "The Meaning of Truth", "Will James").
card(nonfiction_books, "The Memoirs of the Duke of Saint-Simon on the Reign of Louis XIV. and the Regency", "Louis de Rouvroy Saint-Simon (duc de)").
card(nonfiction_books, "The Memory of Fire Trilogy", "Eduardo Galeano").
card(nonfiction_books, "The Mismeasure of Man", "Stephen Jay Gould").
card(nonfiction_books, "The Myth of Sisyphus", "Albert Camus").
card(nonfiction_books, "The Nature of Life", "C. H. Waddington").
card(nonfiction_books, "The New Science of Politics", "Eric Voegelin").
card(nonfiction_books, "The Noonday Demon", "Andrew Solomon").
card(nonfiction_books, "The Omnivore's Dilemma", "Michael Pollan").
card(nonfiction_books, "The Open Society", "Karl Popper").
card(nonfiction_books, "The Origin and Development of Psycho-Analysis", "Sigmund Freud").
card(nonfiction_books, "The Origins of Totalitarianism", "Hannah Arendt").
card(nonfiction_books, "The Path to Power", "Robert Caro").
card(nonfiction_books, "The Pillow Book", "Sei Shōnagon").
card(nonfiction_books, "The Politics of Ecstasy", "Timothy Leary").
card(nonfiction_books, "The Power Broker", "Robert Caro").
card(nonfiction_books, "The Praise of Folly", "Erasmus").
card(nonfiction_books, "The Prince", "Niccolo Machiavelli").
card(nonfiction_books, "The Principles of Psychology", "Will James").
card(nonfiction_books, "The Problems of Philosophy", "Bertrand Russell").
card(nonfiction_books, "The Protestant Ethic and the Spirit of Capitalism", "Max Weber").
card(nonfiction_books, "The Provincial Letters", "Blaise Pascal").
card(nonfiction_books, "The Pursuit of the Millennium", "Norman Cohn").
card(nonfiction_books, "The Quest for Community", "Robert Nisbet").
card(nonfiction_books, "The Reason Why", "Cecil Woodham-Smith").
card(nonfiction_books, "The Rebel", "Albert Camus").
card(nonfiction_books, "The Reluctant Fundamentalist", "Mohsin Hamid").
card(nonfiction_books, "The Revolt of the Masses", "José Ortega y Gasset").
card(nonfiction_books, "The Right Stuff", "Tom Wolfe").
card(nonfiction_books, "The Rise and Fall of the Third Reich", "William L. Shirer").
card(nonfiction_books, "The Rise of Theodore Roosevelt", "Edmund Morris").
card(nonfiction_books, "The Road from Coorain", "Jill Ker Conway").
card(nonfiction_books, "The Road to Serfdom", "Friedrich von Hayek").
card(nonfiction_books, "The Russian Revolution", "Richard Pipes").
card(nonfiction_books, "The Second Sex", "Simone de Beauvoir").
card(nonfiction_books, "The Second World War", "Winston Churchill").
card(nonfiction_books, "The Selfish Gene", "Richard Dawkins").
card(nonfiction_books, "The Seven Pillars of Wisdom", "T. E. Lawrence").
card(nonfiction_books, "The Seven Storey Mountain", "Thomas Merton").
card(nonfiction_books, "The Shock Doctrine: The Rise of Disaster Capitalism", "Naomi Klein").
card(nonfiction_books, "The Sixth Extinction: An Unnatural History", "Elizabeth Kolbert").
card(nonfiction_books, "The Snow Leopard", "Peter Matthiessen").
card(nonfiction_books, "The Social Contract", "Jean-Jacques Rousseau").
card(nonfiction_books, "The Souls of Black Folk", "W. E. B. Du Bois").
card(nonfiction_books, "The Starr Report", "Kenneth W. Starr").
card(nonfiction_books, "The Story of My Life", "Helen Keller").
card(nonfiction_books, "The Strange Ride of Rudyard Kipling", "Angus Wilson").
card(nonfiction_books, "The Stripping of the Altars", "Eamon Duffy").
card(nonfiction_books, "The Structure of Scientific Revolutions", "Thomas Kuhn").
card(nonfiction_books, "The Struggle for Europe", "Chester Wilmot").
card(nonfiction_books, "The Subjection of Women", "John Stuart Mill").
card(nonfiction_books, "The Swerve: How the World Became Modern", "Stephen Greenblatt").
card(nonfiction_books, "The Tao of Physics", "Fritjof Capra").
card(nonfiction_books, "The Theory of the Leisure Class", "Thorstein Veblen").
card(nonfiction_books, "The Tipping Point", "Malcolm Gladwell").
card(nonfiction_books, "The Triumph of the Therapeutic", "Philip Rieff").
card(nonfiction_books, "The True History of the Conquest of New Spain", "Bernal Díaz del Castillo").
card(nonfiction_books, "The Unconscious", "Sigmund Freud").
card(nonfiction_books, "The Unsettling of America", "Wendell Berry").
card(nonfiction_books, "The Uses of Enchantment", "Bruno Bettelheim").
card(nonfiction_books, "The Varieties of Religious Experience", "Will James").
card(nonfiction_books, "The Voices of Marrakesh: A Record of a Visit", "Elias Canetti").
card(nonfiction_books, "The Voyage of the Beagle", "Charles Darwin").
card(nonfiction_books, "The Waning of the Middle Ages", "Johan Huizinga").
card(nonfiction_books, "The Way the World Works", "Jude Wanniski").
card(nonfiction_books, "The Wealth of Nations", "Adam Smith").
card(nonfiction_books, "The Whig Interpretation of History", "Herbert Butterfield").
card(nonfiction_books, "The Whole Internet: User's Guide & Catalog", "Ed Krol").
card(nonfiction_books, "The Woman Warrior: Memoirs of a Girlhood Among Ghosts", "Maxine Hong Kingston").
card(nonfiction_books, "The Word of God and the Word of Man", "Karl Barth").
card(nonfiction_books, "The Works of [author]", "Max Beerbohm").
card(nonfiction_books, "The Worst Journey in the World", "Robert Falcon Scott").
card(nonfiction_books, "The Wretched of the Earth", "Frantz Fanon").
card(nonfiction_books, "The Year of Magical Thinking", "Joan Didion").
card(nonfiction_books, "There Are No Children Here", "Alex Kotlowitz").
card(nonfiction_books, "This Boy's Life", "Tobias Wolff").
card(nonfiction_books, "Thoughts for the Times on War and Death", "Sigmund Freud").
card(nonfiction_books, "Three Case Histories", "Sigmund Freud").
card(nonfiction_books, "Three Cups of Tea", "David Oliver Relin").
card(nonfiction_books, "Three Essays on the Theory of Sexuality", "Sigmund Freud").
card(nonfiction_books, "Titi Livi Ab urbe condita libri", "Livy").
card(nonfiction_books, "To the Finland Station", "Edmund Wilson").
card(nonfiction_books, "Tractatus Logico-Philosophicus", "Ludwig Wittgenstein").
card(nonfiction_books, "Treatise on Radioactivity", "Marie Curie").
card(nonfiction_books, "Tristes Tropiques", "Claude Lévi-Strauss").
card(nonfiction_books, "Truman", "David McCullough").
card(nonfiction_books, "Twenty Years at Hull-House", "Jane Addams").
card(nonfiction_books, "Two Treatises of Government", "John Locke").
card(nonfiction_books, "Unbroken: A World War II Story of Survival, Resilience, and Redemption", "Laura Hillenbrand").
card(nonfiction_books, "Understanding Poetry", "Robert Penn Warren").
card(nonfiction_books, "Up from Slavery", "Booker T. Washington").
card(nonfiction_books, "Up in the Old Hotel", "Joseph Mitchell").
card(nonfiction_books, "Voices from Chernobyl", "Svetlana Alexievich").
card(nonfiction_books, "Walden", "Henry David Thoreau").
card(nonfiction_books, "Wealth and Poverty", "George Gilder").
card(nonfiction_books, "West With the Night", "Beryl Markham").
card(nonfiction_books, "What Is Life?", "Erwin Schrödinger").
card(nonfiction_books, "What Is Metaphysics?", "Martin Heidegger").
card(nonfiction_books, "Why I Am Not a Christian", "Bertrand Russell").
card(nonfiction_books, "Why We Can't Wait", "Martin Luther King").
card(nonfiction_books, "Wild Swans: Three Daughters of China", "Jung Chang").
card(nonfiction_books, "Witness", "Whittaker Chambers").
card(nonfiction_books, "Wittgenstein's Nephew", "Thomas Bernhard").
card(nonfiction_books, "Woman Suffrage and Politics: The Inner Story of the Suffrage Movement", "Carrie Chapman Catt").
card(nonfiction_books, "Words", "Jean Paul Sartre").
card(nonfiction_books, "Zeitoun", "Dave Eggers").
card(nonfiction_books, "Zen and the Art of Motorcycle Maintenance", "Robert M. Pirsig").
card(nonfiction_books, "[author]'s Elements", "Euclid").
card(paintings, "A Bar at the Folies-Bergère", "Édouard Manet").
card(paintings, "A Cotton Office in New Orleans", "Edgar Degas").
card(paintings, "A Friend in Need", "Cassius Marcellus Coolidge").
card(paintings, "A Sunday Afternoon on the Island of La Grande Jatte", "Georges Seurat").
card(paintings, "Adam and Eve", "Lucas Cranach the Elder").
card(paintings, "Adoration of the Magi", "Gentile da Fabriano").
card(paintings, "Allegory of Art", "Georg Baselitz").
card(paintings, "Ambassadors", "Hans Holbein the Younger").
card(paintings, "American Gothic", "Grant Wood").
card(paintings, "An Englishman in Moscow", "Kazimir Malevich").
card(paintings, "An Experiment on a Bird in the Air Pump", "Joseph Wright of Derby").
card(paintings, "Annunciation", "Leonardo da Vinci").
card(paintings, "Arnolfini Portrait", "Jan van Eyck").
card(paintings, "Artist in his Atelier", "Johannes Vermeer").
card(paintings, "Ashes", "Edvard Munch").
card(paintings, "Astronomer", "Johannes Vermeer").
card(paintings, "At 4 O'Clock in the Summer, Hope", "Yves Tanguy").
card(paintings, "Autumn Rhythm", "Jackson Pollock").
card(paintings, "Bacchanals", "Titian").
card(paintings, "Bacchus and Ariadne", "Titian").
card(paintings, "Backlit Nude", "Pierre Bonnard").
card(paintings, "Bal du moulin de la Galette", "Pierre-Auguste Renoir").
card(paintings, "Barge Haulers on the Volga", "Ilya Repin").
card(paintings, "Bath", "Jean-Léon Gérôme").
card(paintings, "Bather at the River", "Henri Matisse").
card(paintings, "Battle of San Romano", "Paolo Uccello").
card(paintings, "Beta-Kappa", "Morris Louis").
card(paintings, "Bird Garden", "Paul Klee").
card(paintings, "Birth of Venus", "Alexandre Cabanel").
card(paintings, "Black Skin", "Gotthard Graubner").
card(paintings, "Blue Nude", "Henri Matisse").
card(paintings, "Boulevard Montmartre Spring", "Camille Pissarro").
card(paintings, "Breakfast Table", "Juan Gris").
card(paintings, "Breakfast at the Hunt", "Gustave Courbet").
card(paintings, "Breezing Up", "Winslow Homer").
card(paintings, "Burning Giraffe", "Salvador Dalí").
card(paintings, "Burning of the Houses of Parliament", "William Turner").
card(paintings, "C & O", "Franz Kline").
card(paintings, "Café Terrace at Night", "Vincent van Gogh").
card(paintings, "Charles I in Three Positions", "Anthony van Dyck").
card(paintings, "Chateau de Steen with Hunter", "Peter Paul Rubens").
card(paintings, "Child's Bath", "Mary Cassatt").
card(paintings, "Christ Healing a Blind Man", "Duccio").
card(paintings, "Christina's World", "Andrew Wyeth").
card(paintings, "Colossus", "Francisco Goya").
card(paintings, "Composition VIII", "Wassily Kandinsky").
card(paintings, "Concetto Spaziale", "Lucio Fontana").
card(paintings, "Crucifixion from the Isenheim Altarpiece", "Matthias Grünewald").
card(paintings, "Crucifixion of Christ", "Andrea Mantegna").
card(paintings, "Cut with the Kitchen Knife", "Hannah Hoch").
card(paintings, "Dance at the Moulin De La Galette", "Pierre-Auguste Renoir").
card(paintings, "Dante and Virgil in Hell", "William-Adolphe Bouguereau").
card(paintings, "Diana and Callisto", "Titian").
card(paintings, "Dream Landscape", "Paul Nash").
card(paintings, "Dream of St. Joseph", "Georges de La Tour").
card(paintings, "Dutch Interior I", "Joan Miró").
card(paintings, "Ecce Homo", "Honoré Daumier").
card(paintings, "Empire of Light", "René Magritte").
card(paintings, "Encounter", "Johannes Itten").
card(paintings, "Equestrian Portrait of Prince Balthasar Charles", "Diego Velázquez").
card(paintings, "Farewells", "Umberto Boccioni").
card(paintings, "Feast of the Rosary", "Albrecht Dürer").
card(paintings, "Fire", "Giuseppe Arcimboldo").
card(paintings, "Five Women on the Street", "Ernst Ludwig Kirchner").
card(paintings, "Flag", "Jasper Johns").
card(paintings, "Flaming June", "Frederic Leighton").
card(paintings, "Flanders", "Otto Dix").
card(paintings, "Flower Carrier", "Diego Rivera").
card(paintings, "Fort Vimieux", "J. M. W. Turner").
card(paintings, "Fortune Teller", "Georges de La Tour").
card(paintings, "Four Girls on the Bridge", "Edvard Munch").
card(paintings, "Fox Hunt", "Winslow Homer").
card(paintings, "Foxes", "Franz Marc").
card(paintings, "Franz von Lenbach with Wife and Daughters", "Franz von Lenbach").
card(paintings, "Garden of Earthly Delights", "Hieronymus Bosch").
card(paintings, "Girl with Hair Band", "Roy Lichtenstein").
card(paintings, "Girl with a Pearl Earring", "Johannes Vermeer").
card(paintings, "Gleaners", "Jean-François Millet").
card(paintings, "Grande Odalisque", "Jean-Auguste-Dominique Ingres").
card(paintings, "Great Friends", "Georg Baselitz").
card(paintings, "Great Wave Off Kanagawa", "Katsushika Hokusai").
card(paintings, "Gross Clinic", "Thomas Eakins").
card(paintings, "Grosvenor Hunt", "George Stubbs").
card(paintings, "Guernica", "Pablo Picasso").
card(paintings, "Hay Wain", "John Constable").
card(paintings, "Hireling Shepherd", "William Holman Hunt").
card(paintings, "Homage to the Square: Against Deep Blue", "Josef Albers").
card(paintings, "Hunters in the Snow; Return of the Hunters", "Pieter Bruegel the Elder").
card(paintings, "I and the Village", "Marc Chagall").
card(paintings, "Impression, Sunrise", "Claude Monet").
card(paintings, "Improvisation 6", "Wassily Kandinsky").
card(paintings, "Interior of Grote Kerk in Haarlem", "Pieter Jansz. Saenredam").
card(paintings, "Irises", "Vincent van Gogh").
card(paintings, "Japanese Footbridge", "Claude Monet").
card(paintings, "Jewish Bride", "Rembrandt").
card(paintings, "Kiss", "Gustav Klimt").
card(paintings, "LIS", "László Moholy-Nagy").
card(paintings, "La Vie", "Pablo Picasso").
card(paintings, "Lady with an Ermine", "Leonardo da Vinci").
card(paintings, "Lamentation of Christ", "Andrea Mantegna").
card(paintings, "Landscape with the Fall of Icarus", "Pieter Bruegel the Elder").
card(paintings, "Las Meninas (The Ladies-in-waiting)", "Diego Velázquez").
card(paintings, "Last Supper", "Leonardo da Vinci").
card(paintings, "Laughing Cavalier", "Frans Hals").
card(paintings, "Le Déjeuner sur l'herbe (The Luncheon on the Grass)", "Édouard Manet").
card(paintings, "Leda and the Swan", "Correggio").
card(paintings, "Les Demoiselles d'Avignon", "Pablo Picasso").
card(paintings, "Liberty Leading the People", "Eugène Delacroix").
card(paintings, "Lictors Bring to Brutus the Bodies of His Sons", "Jacques-Louis David").
card(paintings, "Luncheon of the Boating Party", "Pierre-Auguste Renoir").
card(paintings, "Madonna del Prato (Madonna of the Meadow)", "Raphael").
card(paintings, "Madonna of the Chancellor Rolin", "Jan van Eyck").
card(paintings, "Mahana no atua (Day of God)", "Paul Gauguin").
card(paintings, "Marie-Louise O'Murphey", "Francois Boucher").
card(paintings, "Massacre of the Innocents", "Peter Paul Rubens").
card(paintings, "Medieval City on a River", "Karl Friedrich Schinkel").
card(paintings, "Meditation", "Alexej von Jawlensky").
card(paintings, "Meeting", "Richard Lindner").
card(paintings, "Mercury and Argus", "Peter Paul Rubens").
card(paintings, "Miss America", "Wolf Vostell").
card(paintings, "Mona Lisa", "Leonardo da Vinci").
card(paintings, "Mont Sainte-Victoire", "Paul Cézanne").
card(paintings, "Mountains and Sea", "Helen Frankenthaler").
card(paintings, "Mourning of Christ", "Giotto").
card(paintings, "Mr and Mrs Andrews", "Thomas Gainsborough").
card(paintings, "Naked Maja", "Francisco Goya").
card(paintings, "Napoleon Crossing The Alps", "Jacques-Louis David").
card(paintings, "Night Cafe", "Vincent van Gogh").
card(paintings, "Nighthawks", "Edward Hopper").
card(paintings, "Ninth Wave", "Ivan Aivazovsky").
card(paintings, "No. 5, 1948", "Jackson Pollock").
card(paintings, "Nocturne in Black and Gold - The Falling Rocket", "James Abbott McNeill Whistler").
card(paintings, "Nude Descending a Staircase, No. 2", "Marcel Duchamp").
card(paintings, "Oath of Horatii", "Jacques-Louis David").
card(paintings, "Odalisque", "Francois Boucher").
card(paintings, "Olympia", "Édouard Manet").
card(paintings, "Ophelia", "John Everett Millais").
card(paintings, "Paris Street; Rainy Day", "Gustave Caillebotte").
card(paintings, "Pastoral Concert", "Giorgione").
card(paintings, "Peaceable Kingdom", "Edward Hicks").
card(paintings, "Persistence of Memory", "Salvador Dalí").
card(paintings, "Pollice Verso", "Jean-Léon Gérôme").
card(paintings, "Pont du Gard", "Hubert Robert").
card(paintings, "Portrait of Adele-Bloch Bauer I", "Gustav Klimt").
card(paintings, "Portrait of Louis XIV.", "Hyacinthe Rigaud").
card(paintings, "Portrait of Madame Récamier", "Jacques-Louis David").
card(paintings, "Portrait of a Gentleman Skating", "Gilbert Stuart").
card(paintings, "Portrait of a Lady", "Rogier van der Weyden").
card(paintings, "Portrait of a Young Man", "Raphael").
card(paintings, "Prayer of Christ in the Garden of Gethsemane", "Giovanni Bellini").
card(paintings, "Primavera", "Sandro Botticelli").
card(paintings, "Procession of the Magi", "Benozzo Gozzoli").
card(paintings, "Pyramus and Thisbe", "Niklaus Manuel Deutsch").
card(paintings, "Red Balloon", "Paul Klee").
card(paintings, "Red, Brown and Black", "Mark Rothko").
card(paintings, "Resurrection of Christ", "Piero della Francesca").
card(paintings, "Resurrection, Cookham", "Stanley Spencer").
card(paintings, "Rev. Robert Walker Skating", "Henry Raeburn").
card(paintings, "Sad Young Man in a Train", "Marcel Duchamp").
card(paintings, "Saint Johns Altarpiece", "Rogier van der Weyden").
card(paintings, "Salisbury Cathedral", "John Constable").
card(paintings, "Salome", "Franz von Stuck").
card(paintings, "Saturn Devouring His Son", "Francisco Goya").
card(paintings, "Scream", "Edvard Munch").
card(paintings, "Self-Portrait with Daughter", "Élisabeth Vigée Le Brun").
card(paintings, "Self-portrait as Paul", "Rembrandt").
card(paintings, "Self-portrait", "Albrecht Dürer; Vincent van Gogh").
card(paintings, "Sleepers", "Gustave Courbet").
card(paintings, "Sleeping Gypsy", "Henri Rousseau").
card(paintings, "Sleeping Venus", "Giorgione; Titian").
card(paintings, "Son of Man", "René Magritte").
card(paintings, "St. George and The Dragon", "Paolo Uccello").
card(paintings, "St. John's Altarpiece", "Hans Memling").
card(paintings, "St. Mary of Egypt", "Emil Nolde").
card(paintings, "Stag Night at Sharkeys", "George Bellows").
card(paintings, "Starry Night", "Vincent van Gogh").
card(paintings, "Still Life: Lemons, Oranges and a Rose", "Francisco de Zurbarán").
card(paintings, "Storm", "William McTaggart").
card(paintings, "Sunday", "Frits Van den Berghe").
card(paintings, "Supper at Emmaus", "Caravaggio").
card(paintings, "Susanna and The Elders", "Artemisia Gentileschi").
card(paintings, "Swing", "Jean-Honoré Fragonard").
card(paintings, "The Actors - Triptych", "Max Beckmann").
card(paintings, "The Anatomy Lesson of Dr. Nicolaes Tulp", "Rembrandt").
card(paintings, "The Avenue in the Rain", "Childe Hassam").
card(paintings, "The Bathers; Large Bathers", "Paul Cézanne").
card(paintings, "The Beheading of St John the Baptist", "Caravaggio").
card(paintings, "The Birth of Christ", "Piero della Francesca").
card(paintings, "The Birth of Venus", "Sandro Botticelli").
card(paintings, "The Boating Party", "Mary Cassatt").
card(paintings, "The Burial of the Count of Orgaz", "El Greco").
card(paintings, "The Card Players", "Paul Cézanne").
card(paintings, "The Cardsharps", "Caravaggio").
card(paintings, "The Creation of Adam", "Michelangelo").
card(paintings, "The Embarkation for Cythera", "Jean-Antoine Watteau").
card(paintings, "The Fall of the Damned; The Fall of the Rebel Angels", "Peter Paul Rubens").
card(paintings, "The Hat Shop", "August Macke").
card(paintings, "The Kiss", "Francesco Hayez").
card(paintings, "The Lady of Shalott", "John William Waterhouse").
card(paintings, "The Lute Player", "Caravaggio").
card(paintings, "The Massacre at Chios", "Eugène Delacroix").
card(paintings, "The Musicians", "Caravaggio").
card(paintings, "The Night Watch", "Rembrandt").
card(paintings, "The Potato Eaters", "Vincent van Gogh").
card(paintings, "The Raft of the Medusa", "Théodore Géricault").
card(paintings, "The School of Athens", "Raphael").
card(paintings, "The Storm on the Sea of Galilee", "Rembrandt").
card(paintings, "The Surrender of Breda", "Diego Velázquez").
card(paintings, "The Third of May 1808", "Francisco Goya").
card(paintings, "The Virgin and Child with St. Anne", "Leonardo da Vinci").
card(paintings, "The Wedding at Cana", "Paolo Veronese").
card(paintings, "Three Studies for Figures at the Base of a Crucifixion", "Francis Bacon").
card(paintings, "Tiger", "Franz Marc").
card(paintings, "Tower of Babel", "Pieter Bruegel the Elder").
card(paintings, "Tribute Money", "Masaccio").
card(paintings, "Triumph of Death", "Pieter Bruegel the Elder").
card(paintings, "Triumph of Galatea", "Raphael").
card(paintings, "Turkish Bath", "Jean-Auguste-Dominique Ingres").
card(paintings, "Venice - La Dogana and Santa Maria della Salute", "William Turner").
card(paintings, "Very Rare Picture of Earth", "Francis Picabia").
card(paintings, "View of Delft", "Johannes Vermeer").
card(paintings, "View of Toledo", "El Greco").
card(paintings, "Virgin and Child and the Young John", "Giulio Romano").
card(paintings, "Wanderer above the Sea of Fog", "Caspar David Friedrich").
card(paintings, "War", "Konrad Klapheck").
card(paintings, "Washington Crossing the Delaware", "Emanuel Leutze").
card(paintings, "Watson and The Shark", "John Singleton Copley").
card(paintings, "Wave", "William-Adolphe Bouguereau").
card(paintings, "Wedding", "Fernand Léger").
card(paintings, "Whistler's Mother", "James Abbott McNeill Whistler").
card(paintings, "White Calico Flower", "Georgia O'Keeffe").
card(paintings, "William Bethune with Wife and Daughter", "David Wilkie").
card(paintings, "Winter Scene on a Canal", "Hendrick Avercamp").
card(paintings, "Woman in the Bath", "Edgar Degas").
card(paintings, "Woman in the Garden", "Claude Monet").
card(paintings, "Young Schoolmistress", "Jean-Baptiste-Siméon Chardin").
card(perl_regexp, "$", "End of subject or line").
card(perl_regexp, "( )", "Subpattern").
card(perl_regexp, "(?! )", "Negative lookahead").
card(perl_regexp, "(?: )", "Match without backreference").
card(perl_regexp, "(?<= )", "Positive lookbehind").
card(perl_regexp, "(?<=! )", "Negative lookbehind").
card(perl_regexp, "(?= )", "Positive lookahead").
card(perl_regexp, "*", "0 or more quantifier").
card(perl_regexp, "+", "1 or more quantifier").
card(perl_regexp, "-", "Character range").
card(perl_regexp, ".", "Any character").
card(perl_regexp, "?", "0 or 1 quantifier").
card(perl_regexp, "?", "Makes quantifier lazy").
card(perl_regexp, "[ ]", "Character class").
card(perl_regexp, "\\", "Escape character").
card(perl_regexp, "\\1", "Backreference").
card(perl_regexp, "\\A", "Start of a string").
card(perl_regexp, "\\B", "Non-word boundary").
card(perl_regexp, "\\P{xx}", "Character without unicode property").
card(perl_regexp, "\\R", "Line break").
card(perl_regexp, "\\S", "Any non-whitespace character").
card(perl_regexp, "\\W", "Any non-word character").
card(perl_regexp, "\\Z", "End of a string").
card(perl_regexp, "\\b", "Word boundary").
card(perl_regexp, "\\d", "Any decimal digit").
card(perl_regexp, "\\n", "Newline").
card(perl_regexp, "\\p{xx}", "Character with unicode property").
card(perl_regexp, "\\r", "Carriage return").
card(perl_regexp, "\\s", "Any whitespace character").
card(perl_regexp, "\\t", "Tab").
card(perl_regexp, "\\w", "Any word character").
card(perl_regexp, "\\xhh", "Character with hex code").
card(perl_regexp, "^", "Negate character class").
card(perl_regexp, "^", "Start of subject or line").
card(perl_regexp, "i", "Option for case insensitive matching").
card(perl_regexp, "m", "Option for ^ and $ matching newlines").
card(perl_regexp, "s", "Option for . including newlines").
card(perl_regexp, "x", "Option for ignoring white space and comments in regexp").
card(perl_regexp, "{ }", "Min/max quantifier").
card(perl_regexp, "|", "Alternatives").
card(permutations, "P(1, 1)", "1").
card(permutations, "P(10, 1)", "10").
card(permutations, "P(10, 10)", "3628800").
card(permutations, "P(10, 2)", "90").
card(permutations, "P(10, 3)", "720").
card(permutations, "P(10, 4)", "5040").
card(permutations, "P(10, 5)", "30240").
card(permutations, "P(10, 6)", "151200").
card(permutations, "P(10, 7)", "604800").
card(permutations, "P(10, 8)", "1814400").
card(permutations, "P(10, 9)", "3628800").
card(permutations, "P(2, 1)", "2").
card(permutations, "P(2, 2)", "2").
card(permutations, "P(3, 1)", "3").
card(permutations, "P(3, 2)", "6").
card(permutations, "P(3, 3)", "6").
card(permutations, "P(4, 1)", "4").
card(permutations, "P(4, 2)", "12").
card(permutations, "P(4, 3)", "24").
card(permutations, "P(4, 4)", "24").
card(permutations, "P(5, 1)", "5").
card(permutations, "P(5, 2)", "20").
card(permutations, "P(5, 3)", "60").
card(permutations, "P(5, 4)", "120").
card(permutations, "P(5, 5)", "120").
card(permutations, "P(6, 1)", "6").
card(permutations, "P(6, 2)", "30").
card(permutations, "P(6, 3)", "120").
card(permutations, "P(6, 4)", "360").
card(permutations, "P(6, 5)", "720").
card(permutations, "P(6, 6)", "720").
card(permutations, "P(7, 1)", "7").
card(permutations, "P(7, 2)", "42").
card(permutations, "P(7, 3)", "210").
card(permutations, "P(7, 4)", "840").
card(permutations, "P(7, 5)", "2520").
card(permutations, "P(7, 6)", "5040").
card(permutations, "P(7, 7)", "5040").
card(permutations, "P(8, 1)", "8").
card(permutations, "P(8, 2)", "56").
card(permutations, "P(8, 3)", "336").
card(permutations, "P(8, 4)", "1680").
card(permutations, "P(8, 5)", "6720").
card(permutations, "P(8, 6)", "20160").
card(permutations, "P(8, 7)", "40320").
card(permutations, "P(8, 8)", "40320").
card(permutations, "P(9, 1)", "9").
card(permutations, "P(9, 2)", "72").
card(permutations, "P(9, 3)", "504").
card(permutations, "P(9, 4)", "3024").
card(permutations, "P(9, 5)", "15120").
card(permutations, "P(9, 6)", "60480").
card(permutations, "P(9, 7)", "181440").
card(permutations, "P(9, 8)", "362880").
card(permutations, "P(9, 9)", "362880").
card(phonetic_alphabet, "A", "Alfa").
card(phonetic_alphabet, "B", "Bravo").
card(phonetic_alphabet, "C", "Charlie").
card(phonetic_alphabet, "D", "Delta").
card(phonetic_alphabet, "E", "Echo").
card(phonetic_alphabet, "F", "Foxtrot").
card(phonetic_alphabet, "G", "Golf").
card(phonetic_alphabet, "H", "Hotel").
card(phonetic_alphabet, "I", "India").
card(phonetic_alphabet, "J", "Juliett").
card(phonetic_alphabet, "K", "Kilo").
card(phonetic_alphabet, "L", "Lima").
card(phonetic_alphabet, "M", "Mike").
card(phonetic_alphabet, "N", "November").
card(phonetic_alphabet, "O", "Oscar").
card(phonetic_alphabet, "P", "Papa").
card(phonetic_alphabet, "Q", "Quebec").
card(phonetic_alphabet, "R", "Romeo").
card(phonetic_alphabet, "S", "Sierra").
card(phonetic_alphabet, "T", "Tango").
card(phonetic_alphabet, "U", "Uniform").
card(phonetic_alphabet, "V", "Victor").
card(phonetic_alphabet, "W", "Whiskey").
card(phonetic_alphabet, "X", "X-ray").
card(phonetic_alphabet, "Y", "Yankee").
card(phonetic_alphabet, "Z", "Zulu").
card(phpdoc_params, "@author", "name email").
card(phpdoc_params, "@const", "type description").
card(phpdoc_params, "@copyright", "description").
card(phpdoc_params, "@default", "value").
card(phpdoc_params, "@deprecated", "text").
card(phpdoc_params, "@event", "name").
card(phpdoc_params, "@file", "text").
card(phpdoc_params, "@fires", "name").
card(phpdoc_params, "@function", "name").
card(phpdoc_params, "@inheritdoc", "n/a").
card(phpdoc_params, "@interface", "n/a").
card(phpdoc_params, "@link", "url").
card(phpdoc_params, "@listens", "name").
card(phpdoc_params, "@method", "name").
card(phpdoc_params, "@name", "name").
card(phpdoc_params, "@namespace", "name").
card(phpdoc_params, "@override", "n/a").
card(phpdoc_params, "@param", "type name description").
card(phpdoc_params, "@property", "type name description").
card(phpdoc_params, "@return", "type description").
card(phpdoc_params, "@since", "version").
card(phpdoc_params, "@summary", "summary").
card(phpdoc_params, "@throws", "type description").
card(phpdoc_params, "@todo", "text").
card(phpdoc_params, "@type", "name").
card(phpdoc_params, "@uses", "type description").
card(phpdoc_params, "@var", "type description").
card(phpdoc_params, "@version", "version").
card(poets, "'Goodbye, my friend, goodbye'", "Sergei Aleksandrovich Esenin").
card(poets, "2 a.m.", "Ernesto Trejo").
card(poets, "211th Chorus", "Jack Kerouac").
card(poets, "45 Mercy Street", "Anne Sexton").
card(poets, "A Ballad of Death", "Algernon Charles Swinburne").
card(poets, "A Ballad of Dreamland", "Algernon Charles Swinburne").
card(poets, "A Ballad of John Silver", "John Masefield").
card(poets, "A Barefoot Boy", "James Whitcomb Riley").
card(poets, "A Beautiful Young Nymph Going To Bed", "Jonathan Swift").
card(poets, "A Broken Appointment", "Thomas Hardy").
card(poets, "A Brown Girl Dead", "Countee Cullen").
card(poets, "A Character", "William Wordsworth").
card(poets, "A Child's Garden", "Robert Louis Stevenson").
card(poets, "A Clear Midnight", "Walt Whitman").
card(poets, "A Code of Morals", "Rudyard Kipling").
card(poets, "A Crazed Girl", "William Butler Yeats").
card(poets, "A Dream Lies Dead", "Dorothy Parker").
card(poets, "A Dream Within A Dream", "Edgar Allan Poe").
card(poets, "A Familiar Letter", "Oliver Wendell Holmes").
card(poets, "A Farewell", "Alfred Lord Tennyson; Charles Kingsley").
card(poets, "A Girl", "Ezra Pound").
card(poets, "A Gleam Of Sunshine", "Henry Wadsworth Longfellow").
card(poets, "A Golden Day", "Paul Laurence Dunbar").
card(poets, "A Good Boy", "Robert Louis Stevenson").
card(poets, "A Grain Of Sand", "Robert W Service").
card(poets, "A Happy Man", "Edwin Arlington Robinson").
card(poets, "A Letter From A Stupid Woman", "Nizar Qabbani").
card(poets, "A Life-Lesson", "James Whitcomb Riley").
card(poets, "A Little Boy's Dream", "Katherine Mansfield").
card(poets, "A Lover's Call   XXVII", "Khalil Gibran").
card(poets, "A Lower Eastside Poem", "Miguel Pinero").
card(poets, "A Man's A Man For A' That", "Robert Burns").
card(poets, "A Moment Of Happiness", "Mewlana Jalaluddin Rumi").
card(poets, "A Poison Tree", "William Blake").
card(poets, "A Pretty Woman", "Robert Browning").
card(poets, "A Red, Red Rose", "Robert Burns").
card(poets, "A Refusal To Mourn The Death, By Fire, Of A Child In London", "Dylan Thomas").
card(poets, "A Ritual To Read To Each Other", "William Stafford").
card(poets, "A River", "A.K. Ramanujan").
card(poets, "A Sea Dream", "Cicely Fox Smith").
card(poets, "A Silly Poem", "Spike Milligan").
card(poets, "A Sincere Man Am I  (Verse I)", "Jose Marti").
card(poets, "A Smile To Remember", "Charles Bukowski").
card(poets, "A Sort Of A Song", "William Carlos Williams").
card(poets, "A Strange Wild Song", "Lewis Carroll").
card(poets, "A Supermarket In California", "Allen Ginsberg").
card(poets, "A Tear And A Smile", "Khalil Gibran").
card(poets, "A Very Short Song", "Dorothy Parker").
card(poets, "A Vision", "Oscar Wilde").
card(poets, "A Walk", "Rainer Maria Rilke").
card(poets, "A Wish", "Matthew Arnold").
card(poets, "A Woman to her Lover", "Christina Walshe").
card(poets, "A Woman's Last Word", "Robert Browning").
card(poets, "A Word to Husbands", "Ogden Nash").
card(poets, "A Worker Reads History", "Bertolt Brecht").
card(poets, "A bee", "Matsuo Basho").
card(poets, "A child said, What is the grass?", "Walt Whitman").
card(poets, "Abode Of The Beloved", "Kabir").
card(poets, "Abou Ben Adhem", "James Henry Leigh Hunt").
card(poets, "About Marriage", "Denise Levertov").
card(poets, "Adlestrop", "Edward Thomas").
card(poets, "Advice To A Girl", "Sara Teasdale").
card(poets, "Advice To A Son", "Ernest Hemingway").
card(poets, "After All", "Henry Lawson").
card(poets, "After Auschwitz", "Anne Sexton").
card(poets, "Aftermath. (Birds Of Passage. Flight The Third)", "Henry Wadsworth Longfellow").
card(poets, "Again and Again", "Rainer Maria Rilke").
card(poets, "All The World's A Stage", "William Shakespeare").
card(poets, "All Things will Die", "Alfred Lord Tennyson").
card(poets, "All nature has a feeling", "John Clare").
card(poets, "Alone ", "Ambrose Bierce").
card(poets, "Alone Looking at the Mountain", "Li Po").
card(poets, "Alone With Everybody", "Charles Bukowski").
card(poets, "Alone and Drinking Under the Moon", "Li Po").
card(poets, "Alone", "Edgar Allan Poe; Sara Teasdale").
card(poets, "Alone, Looking For Blossoms Along The River", "Du Fu").
card(poets, "Along With Youth", "Ernest Hemingway").
card(poets, "Always Marry An April Girl", "Ogden Nash").
card(poets, "Amazing Grace", "John Newton").
card(poets, "America The Beautiful", "Katharine Lee Bates").
card(poets, "America", "Claude McKay").
card(poets, "An Almost Made Up Poem", "Charles Bukowski").
card(poets, "An Hymn To The Morning", "Phillis Wheatley").
card(poets, "An Irish Airman Foresees His Death", "William Butler Yeats").
card(poets, "An Old Man's Winter Night", "Robert Frost").
card(poets, "Anarchy", "John McCrae").
card(poets, "And Death Shall Have No Dominion", "Dylan Thomas").
card(poets, "And The Days Are Not Full Enough", "Ezra Pound").
card(poets, "Andy's Gone With Cattle", "Henry Lawson").
card(poets, "Anna Who Was Mad", "Anne Sexton").
card(poets, "Annabel Lee", "Edgar Allan Poe").
card(poets, "Another Reason Why I Don't Keep A Gun In The House", "Billy Collins").
card(poets, "Answer", "Sir Walter Scott").
card(poets, "Anthem For Doomed Youth", "Wilfred Owen").
card(poets, "Anywhere Out of the World", "Charles Baudelaire").
card(poets, "April Love", "Ernest Christopher Dowson").
card(poets, "Ariel", "Sylvia Plath").
card(poets, "Arithmetic", "Carl Sandburg").
card(poets, "Armies In The Fire", "Robert Louis Stevenson").
card(poets, "Ars Poetica", "Archibald MacLeish").
card(poets, "As I Grew Older", "Langston Hughes").
card(poets, "Ask Me", "William Stafford").
card(poets, "Aubade", "Philip Larkin").
card(poets, "Auguries of Innocence", "William Blake").
card(poets, "Australia", "A D Hope").
card(poets, "Autumn Song", "Dante Gabriel Rossetti; Sarojini Naidu").
card(poets, "Autumn", "Roy Campbell").
card(poets, "Ballad Of Birmingham", "Dudley Randall").
card(poets, "Be With Those Who Help Your Being", "Mewlana Jalaluddin Rumi").
card(poets, "Beach Burial", "Kenneth Slessor").
card(poets, "Beaucourt Revisited", "A P Herbert").
card(poets, "Before The Dawn ", "Federico Garcia Lorca").
card(poets, "Believe Me, If All Those Endearing Young Charms", "Thomas Moore").
card(poets, "Bell Birds", "Henry Kendall").
card(poets, "Birches", "Robert Frost").
card(poets, "Black spring! Pick up your pen, and weeping...", "Boris Pasternak").
card(poets, "Blow, Blow, Thou Winter Wind", "William Shakespeare").
card(poets, "Blow, Bugle, Blow", "Alfred Lord Tennyson").
card(poets, "Bluebird", "Charles Bukowski").
card(poets, "Brimming Water by Tu Fu (712-770)", "Du Fu").
card(poets, "Carpe Diem", "Robert Frost; William Shakespeare").
card(poets, "Casey at the Bat", "Ernest Lawrence Thayer").
card(poets, "Chaap Tilak ", "Amir Khusro").
card(poets, "Chicago", "Carl Sandburg").
card(poets, "Child on Top of a Greenhouse", "Theodore Roethke").
card(poets, "Childhood", "David Bates").
card(poets, "Children Chapter IV", "Khalil Gibran").
card(poets, "Cinderella", "Sylvia Plath").
card(poets, "City That Does Not Sleep", "Federico Garcia Lorca").
card(poets, "Clancy of the Overflow", "A B Banjo Paterson").
card(poets, "Clouds And Waves", "Rabindranath Tagore").
card(poets, "Collection of Six Haiku", "Matsuo Basho").
card(poets, "Composed Upon Westminster Bridge, September 3, 1802", "William Wordsworth").
card(poets, "Conference Of The Birds", "Farid al-Din Attar").
card(poets, "Conscience", "Henry David Thoreau").
card(poets, "Conscientious Objector", "Edna St. Vincent Millay").
card(poets, "Coromandel Fishers", "Sarojini Naidu").
card(poets, "Country Towns", "Kenneth Slessor").
card(poets, "Crossing the Bar", "Alfred Lord Tennyson").
card(poets, "Crucifix In A Deathhand", "Charles Bukowski").
card(poets, "Daddy", "Sylvia Plath").
card(poets, "Daffodils", "William Wordsworth").
card(poets, "Day's End", "Du Fu").
card(poets, "Daydreams for Ginsberg", "Jack Kerouac").
card(poets, "Death Be Not Proud", "John Donne").
card(poets, "Did I Not Say To You", "Mewlana Jalaluddin Rumi").
card(poets, "Disabled", "Wilfred Owen").
card(poets, "Disillusionment Of Ten O'Clock ", "Wallace Stevens").
card(poets, "Do Not Go Gentle Into That Good Night", "Dylan Thomas").
card(poets, "Do Not Stand At My Grave And Weep", "Mary Frye").
card(poets, "Dos Patrias", "Jose Marti").
card(poets, "Dover Beach", "Matthew Arnold").
card(poets, "Dream Land", "Christina Georgina Rossetti").
card(poets, "Dreamland", "Lewis Carroll").
card(poets, "Dreams", "Langston Hughes").
card(poets, "Drinking Alone in the Moonlight", "Li Po").
card(poets, "Dulce Et Decorum Est Pro Patria Mori", "Wilfred Owen").
card(poets, "Echo", "Christina Georgina Rossetti").
card(poets, "Elegy Written in a Country Churchyard", "Thomas Gray").
card(poets, "Eloisa to Abelard", "Alexander Pope").
card(poets, "Every Time I Kiss You", "Nizar Qabbani").
card(poets, "Exposure", "Wilfred Owen").
card(poets, "Father Death Blues", "Allen Ginsberg").
card(poets, "Feeling Fucked Up", "Etheridge Knight").
card(poets, "Feelings", "Spike Milligan").
card(poets, "Fern Hill", "Dylan Thomas").
card(poets, "Fire And Ice", "Robert Frost").
card(poets, "First Love", "John Clare").
card(poets, "Five A.M.", "Allen Ginsberg").
card(poets, "Five Bells", "Kenneth Slessor").
card(poets, "Fleas", "Ogden Nash").
card(poets, "Flower of Love", "Oscar Wilde").
card(poets, "Flowers By The Sea", "William Carlos Williams").
card(poets, "Fog", "Carl Sandburg").
card(poets, "For My People", "Margaret Walker").
card(poets, "For The Fallen", "Robert Laurence Binyon").
card(poets, "For whom the Bell Tolls", "John Donne").
card(poets, "Friendship", "Alexander Sergeyevich Pushkin; Henry David Thoreau").
card(poets, "From A German War Primer", "Bertolt Brecht").
card(poets, "From: War Is Kind", "Stephen Maria Crane").
card(poets, "Full Moon", "Du Fu").
card(poets, "Funeral Blues", "W H Auden").
card(poets, "Get Drunk", "Charles Baudelaire").
card(poets, "Give All To Love", "Ralph Waldo Emerson").
card(poets, "God's Grandeur", "Gerard Manley Hopkins").
card(poets, "Good Old Moon", "Li Po").
card(poets, "Good-Night", "Percy Bysshe Shelley").
card(poets, "Growing Old", "Matthew Arnold").
card(poets, "Haiku (Birds singing...)", "Jack Kerouac").
card(poets, "Haiku (The low yellow...)", "Jack Kerouac").
card(poets, "Haiku (The taste...)", "Jack Kerouac").
card(poets, "Hard Frost", "Andrew John Young").
card(poets, "Harrow-On-The-Hill", "Sir John Betjeman").
card(poets, "Have A Nice day", "Spike Milligan").
card(poets, "Hawk Roosting", "Ted Hughes").
card(poets, "He is more than a hero", "Sappho").
card(poets, "Her Voice", "Oscar Wilde").
card(poets, "Here I Love You", "Pablo Neruda").
card(poets, "Heritage", "Countee Cullen").
card(poets, "Hero And Leander", "Christopher Marlowe").
card(poets, "Himself", "Alice Guerin Crist").
card(poets, "History Of The Night", "Jorge Luis Borges").
card(poets, "Hope", "Emily Jane Bronte").
card(poets, "Horses on the Camargue", "Roy Campbell").
card(poets, "Hot And Cold", "Roald Dahl").
card(poets, "How pleasant to know Mr. Lear", "Edward Lear").
card(poets, "I Am In Need Of Music", "Elizabeth Bishop").
card(poets, "I Am The Only Being Whose Doom", "Emily Jane Bronte").
card(poets, "I Knew a Woman", "Theodore Roethke").
card(poets, "I Know Why The Caged Bird Sings", "Maya Angelou").
card(poets, "I Loved You", "Alexander Sergeyevich Pushkin").
card(poets, "I Remember, I Remember", "Thomas Hood").
card(poets, "I Sit And Think", "J R R Tolkien").
card(poets, "I Thought Of You", "Sara Teasdale").
card(poets, "I taste a liquor never brewed", "Emily Dickinson").
card(poets, "I'm Nobody! Who are you?", "Emily Dickinson").
card(poets, "I, Too.", "Langston Hughes").
card(poets, "Ice and Fire", "Edmund Spenser").
card(poets, "If I Were In Charge of the World", "Judith Viorst").
card(poets, "If We Must Die", "Claude McKay").
card(poets, "If You Forget Me", "Pablo Neruda").
card(poets, "If....", "Rudyard Kipling").
card(poets, "In A Station Of The Metro", "Ezra Pound").
card(poets, "In Flanders Field", "John McCrae").
card(poets, "In The Summer", "Nizar Qabbani").
card(poets, "Inchcape Rock", "Robert Southey").
card(poets, "Incident", "Countee Cullen").
card(poets, "Inniskeen Road: July Evening", "Patrick Kavanagh").
card(poets, "Instants", "Jorge Luis Borges").
card(poets, "Introduction to Poetry", "Billy Collins").
card(poets, "Invictus: The Unconquerable", "William Ernest Henley").
card(poets, "It Couldn't Be Done", "Edgar Albert Guest").
card(poets, "It's September", "Edgar Albert Guest").
card(poets, "Jabberwocky", "Lewis Carroll").
card(poets, "Jazz Fantasia", "Carl Sandburg").
card(poets, "Jewish Wedding in Bombay", "Nissim Ezekiel").
card(poets, "Jitterbug Jesus", "Miguel Pinero").
card(poets, "Knee-Deep in June", "James Whitcomb Riley").
card(poets, "La Bodega Sold Dreams", "Miguel Pinero").
card(poets, "Lady Lazarus", "Sylvia Plath").
card(poets, "Last Night As I Was Sleeping", "Antonio Machado").
card(poets, "Life", "Charlotte Bronte").
card(poets, "Life's Tragedy", "Paul Laurence Dunbar").
card(poets, "Like the Touch of Rain", "Edward Thomas").
card(poets, "Little Boy Blue", "Eugene Field").
card(poets, "Look To This Day", "Kalidasa").
card(poets, "Lord Ullin's Daughter", "Thomas Campbell").
card(poets, "Love After Love", "Derek Walcott").
card(poets, "Love Is Not All", "Edna St. Vincent Millay").
card(poets, "Love", "Pablo Neruda").
card(poets, "Love's Philosophy", "Percy Bysshe Shelley").
card(poets, "Love's Secret", "William Blake").
card(poets, "Lovesong", "Ted Hughes").
card(poets, "Lucy Gray [or Solitude]", "William Wordsworth").
card(poets, "Madhushala (The Tavern) ", "Harivansh Rai Bachchan").
card(poets, "Matilda Who told Lies, and was Burned to Death", "Hilaire Belloc").
card(poets, "Mcmxiv", "Philip Larkin").
card(poets, "Meeting At Night", "Robert Browning").
card(poets, "Mirror", "Sylvia Plath").
card(poets, "Moonlit Apples", "John Drinkwater").
card(poets, "Moonlit Night: Two Translations", "Du Fu").
card(poets, "Morning Song", "Sylvia Plath").
card(poets, "Mother To Son", "Langston Hughes").
card(poets, "Municipal Gum", "Oodgeroo Noonuccal Kath Walker").
card(poets, "My Country", "Dorothea Mackellar").
card(poets, "My Creed", "Edgar Albert Guest").
card(poets, "My Heart Leaps Up", "William Wordsworth").
card(poets, "My Last Duchess", "Robert Browning").
card(poets, "My Love Is Like To Ice", "Edmund Spenser").
card(poets, "My November Guest", "Robert Frost").
card(poets, "My Papa's Waltz", "Theodore Roethke").
card(poets, "Myfanwy", "Sir John Betjeman").
card(poets, "Myself", "Edgar Albert Guest").
card(poets, "Naming of Parts", "Henry Reed").
card(poets, "Night of the Scorpion", "Nissim Ezekiel").
card(poets, "No Man Is an Island", "John Donne").
card(poets, "Not Waving but Drowning", "Stevie Smith").
card(poets, "Nothing Gold Can Stay", "Robert Frost").
card(poets, "Nothing's Changed", "Tatamkhulu Afrika").
card(poets, "O Captain! My Captain!", "Walt Whitman").
card(poets, "Ode On The Death Of A Favourite Cat Drowned In A Tub Of Gold Fishes", "Thomas Gray").
card(poets, "Ode To Autumn", "John Keats").
card(poets, "Ode on Solitude", "Alexander Pope").
card(poets, "On Being Brought from Africa to America", "Phillis Wheatley").
card(poets, "On Gay Wallpaper", "William Carlos Williams").
card(poets, "On Growing Old", "John Masefield").
card(poets, "On Imagination", "Phillis Wheatley").
card(poets, "On Raglan Road", "Patrick Kavanagh").
card(poets, "On The Ning Nang Nong", "Spike Milligan").
card(poets, "One Art", "Elizabeth Bishop").
card(poets, "Our Casuarina Tree", "Toru Dutt").
card(poets, "Ozymandias", "Percy Bysshe Shelley").
card(poets, "Palanquin Bearers", "Sarojini Naidu").
card(poets, "Patterns", "Amy Lowell").
card(poets, "Perhaps (To R.A.L.)", "Vera Brittain").
card(poets, "Phenomenal Woman", "Maya Angelou").
card(poets, "Prayer Before Birth", "Louis MacNeice").
card(poets, "Prayers To Lord Murugan", "A.K. Ramanujan").
card(poets, "Primaveral (With English Translation)", "Ruben Dario").
card(poets, "Rain", "Edward Thomas").
card(poets, "Remember", "Christina Georgina Rossetti").
card(poets, "Renascence", "Edna St. Vincent Millay").
card(poets, "Revenge", "Letitia Elizabeth Landon").
card(poets, "Riparto D'Assalto", "Ernest Hemingway").
card(poets, "Risk", "Anais Nin").
card(poets, "Romance De La Luna, Luna", "Federico Garcia Lorca").
card(poets, "Rondel of Merciless Beauty", "Geoffrey Chaucer").
card(poets, "Rural Reflections", "Adrienne Rich").
card(poets, "Sailor Town", "Cicely Fox Smith").
card(poets, "Sea Fever", "John Masefield").
card(poets, "Secret Love", "Amelia Opie").
card(poets, "See It Through", "Edgar Albert Guest").
card(poets, "She Walks In Beauty", "George Gordon Byron").
card(poets, "Signior Dildo", "Lord John Wilmot").
card(poets, "Silver", "Walter de la Mare").
card(poets, "So We'll Go No More A-Roving", "George Gordon Byron").
card(poets, "Solitude", "Ella Wheeler Wilcox").
card(poets, "Some One", "Walter de la Mare").
card(poets, "Sonnet 116: 'Let me not to the marriage of true minds...'", "William Shakespeare").
card(poets, "Sonnet 130: 'My mistress' eyes are nothing like the sun...'", "William Shakespeare").
card(poets, "Sonnet 54", "Edmund Spenser").
card(poets, "Sonnet LXVI: I Do Not Love You Except Because I Love You", "Pablo Neruda").
card(poets, "Sonnet XLIII: How Do I Love Thee?", "Elizabeth Barrett Browning").
card(poets, "Sonnet", "Toru Dutt").
card(poets, "Sonnet: What Lips My Lips Have Kissed", "Edna St. Vincent Millay").
card(poets, "Sonnet: When I Have Fears That I May Cease To Be", "John Keats").
card(poets, "South Of My Days", "Judith Wright").
card(poets, "Spring Offensive", "Wilfred Owen").
card(poets, "Steppe", "Arseny Tarkovsky").
card(poets, "Still I Rise", "Maya Angelou").
card(poets, "Stopping By Woods On A Snowy Evening", "Robert Frost").
card(poets, "Success is counted Sweetest", "Emily Dickinson").
card(poets, "Suicide Off Egg Rock", "Sylvia Plath").
card(poets, "Sun and Shadow", "Oliver Wendell Holmes").
card(poets, "Sunday Morning", "Wallace Stevens").
card(poets, "Sunflower Sutra", "Allen Ginsberg").
card(poets, "Sunny Prestatyn", "Philip Larkin").
card(poets, "Sure On This Shining Night", "James Agee").
card(poets, "Symptom Recital", "Dorothy Parker").
card(poets, "Tarantella", "Hilaire Belloc").
card(poets, "The Ballad Of The Landlord", "Langston Hughes").
card(poets, "The Bell", "Ralph Waldo Emerson").
card(poets, "The Book of Genesis According to St. Miguelito", "Miguel Pinero").
card(poets, "The Broken Tower", "Harold Hart Crane").
card(poets, "The Bull Moose", "Alden Nowlan").
card(poets, "The Bus", "Arun Kolatkar").
card(poets, "The Chariot [ Because I could not stop for Death ]", "Emily Dickinson").
card(poets, "The Conclusion", "Sir Walter Raleigh").
card(poets, "The Cremation of Sam McGee", "Robert W Service").
card(poets, "The Crocodile", "Lewis Carroll").
card(poets, "The Crunch", "Charles Bukowski").
card(poets, "The Dead Woman", "Pablo Neruda").
card(poets, "The Death Of The Ball Turret Gunner", "Randall Jarrell").
card(poets, "The Early Morning", "Hilaire Belloc").
card(poets, "The Emperor of Ice-Cream", "Wallace Stevens").
card(poets, "The Faithless Wife", "Federico Garcia Lorca").
card(poets, "The First Snowfall", "James Russell Lowell").
card(poets, "The Fish", "Elizabeth Bishop").
card(poets, "The Guest House", "Mewlana Jalaluddin Rumi").
card(poets, "The Guitar", "Federico Garcia Lorca").
card(poets, "The Hero", "Siegfried Sassoon").
card(poets, "The Highwayman", "Alfred Noyes").
card(poets, "The Hope Of My Heart", "John McCrae").
card(poets, "The Horses", "Edwin Muir").
card(poets, "The Kiss", "Anne Sexton").
card(poets, "The Last Of His Tribe", "Henry Kendall").
card(poets, "The Licorice Fields At Pontefract", "Sir John Betjeman").
card(poets, "The Lion and Albert", "Marriott Edgar").
card(poets, "The Listeners", "Walter de la Mare").
card(poets, "The Man from Snowy River", "A B Banjo Paterson").
card(poets, "The Meadow Mouse", "Theodore Roethke").
card(poets, "The Moon", "Henry David Thoreau").
card(poets, "The Negro Mother", "Langston Hughes").
card(poets, "The Negro Speaks Of Rivers", "Langston Hughes").
card(poets, "The New Colossus", "Emma Lazarus").
card(poets, "The Night Ride", "Kenneth Slessor").
card(poets, "The Old Flame", "Robert Lowell").
card(poets, "The Old Grey Squirrel", "Alfred Noyes").
card(poets, "The Panther", "Rainer Maria Rilke").
card(poets, "The Passionate Shepherd To His Love", "Christopher Marlowe").
card(poets, "The Raven", "Edgar Allan Poe").
card(poets, "The Rear-Guard", "Siegfried Sassoon").
card(poets, "The Red Wheelbarrow", "William Carlos Williams").
card(poets, "The Road Not Taken", "Robert Frost").
card(poets, "The Rose That Grew From Concrete", "Tupac Shakur").
card(poets, "The Rubaiyat of Omar Khayyam", "Omar Khayyam").
card(poets, "The Scarecrow", "Walter de la Mare").
card(poets, "The Second Coming", "William Butler Yeats").
card(poets, "The Seed-Shop", "Muriel Stuart").
card(poets, "The Shark", "Edwin John Pratt").
card(poets, "The Sick Rose", "William Blake").
card(poets, "The Solitary Reaper", "William Wordsworth").
card(poets, "The Song of Maria Clara", "Jose Rizal").
card(poets, "The Suicide's Argument", "Samuel Taylor Coleridge").
card(poets, "The Surfer", "Judith Wright").
card(poets, "The Swing", "Robert Louis Stevenson").
card(poets, "The Village Schoolmaster", "Oliver Goldsmith").
card(poets, "The War Sonnets:  V The Soldier", "Rupert Brooke").
card(poets, "The Wedding", "Sidney Lanier").
card(poets, "The Welsh Hill Country", "R S Thomas").
card(poets, "The Whipping", "Robert Hayden").
card(poets, "The Zonnebeke Road", "Edmund Blunden").
card(poets, "The child is not dead", "Ingrid Jonker").
card(poets, "There Is Pleasure In The Pathless Woods", "George Gordon Byron").
card(poets, "There Was A Boy", "William Wordsworth").
card(poets, "There Will Come Soft Rains", "Sara Teasdale").
card(poets, "This Is Just To Say", "William Carlos Williams").
card(poets, "This Is Not The Place Where I Was Born", "Miguel Pinero").
card(poets, "Those Winter Sundays", "Robert Hayden").
card(poets, "Tie Your Heart At Night To Mine, Love,", "Pablo Neruda").
card(poets, "To His Coy Mistress", "Andrew Marvell").
card(poets, "To The Virgins: To Make Much Of Time", "Robert Herrick").
card(poets, "To my Dear and Loving Husband", "Anne Bradstreet").
card(poets, "Trapped Dingo", "Judith Wright").
card(poets, "Traveling Through The Dark", "William Stafford").
card(poets, "Trebetherick", "Sir John Betjeman").
card(poets, "Triangles", "Pablo Neruda").
card(poets, "True Love", "Judith Viorst").
card(poets, "Trumpet Player", "Langston Hughes").
card(poets, "Ulysses", "Alfred Lord Tennyson").
card(poets, "Unending Love", "Rabindranath Tagore").
card(poets, "Variations On The Word Love", "Margaret Atwood").
card(poets, "Voices Of The Night : A Psalm Of Life", "Henry Wadsworth Longfellow").
card(poets, "Voyages III", "Harold Hart Crane").
card(poets, "We Wear the Mask", "Paul Laurence Dunbar").
card(poets, "What The Motorcycle Said", "Mona Van Duyn").
card(poets, "What Were They Like?", "Denise Levertov").
card(poets, "When I Love", "Nizar Qabbani").
card(poets, "When We Two Parted", "George Gordon Byron").
card(poets, "When You Are Old", "William Butler Yeats").
card(poets, "Where The Mind Is Without Fear", "Rabindranath Tagore").
card(poets, "Who Ever Loved That Loved Not At First Sight?", "Christopher Marlowe").
card(poets, "Who Said That Love Was Fire?", "Patience Worth").
card(poets, "Wind", "Ted Hughes").
card(poets, "Winter Memories", "Henry David Thoreau").
card(poets, "Woman To Man", "Judith Wright").
card(poets, "Woman with Girdle", "Anne Sexton").
card(poets, "Wombat", "Douglas Alexander Stewart").
card(poets, "You Will Hear Thunder", "Anna Akhmatova").
card(poets, "Young Sycamore", "William Carlos Williams").
card(poets, "\"Hope\" is the thing with feathers--", "Emily Dickinson").
card(poets, "a man who had fallen among thieves", "e.e. cummings").
card(poets, "from Book I, Paterson", "William Carlos Williams").
card(poets, "hastee apnee Hubaab kee see hai", "Meer Taqi Meer").
card(poets, "i carry your heart with me", "e.e. cummings").
card(poets, "i like my body when it is with your", "e.e. cummings").
card(poets, "maggie and milly and molly and may", "e.e. cummings").
card(poets, "may i feel said he", "e.e. cummings").
card(powers, "10^2", "100").
card(powers, "10^3", "1000").
card(powers, "10^4", "10000").
card(powers, "11^2", "121").
card(powers, "11^3", "1331").
card(powers, "12^2", "144").
card(powers, "12^3", "1728").
card(powers, "13^2", "169").
card(powers, "13^3", "2197").
card(powers, "14^2", "196").
card(powers, "14^3", "2744").
card(powers, "15^2", "225").
card(powers, "15^3", "3375").
card(powers, "16^2", "256").
card(powers, "16^3", "4096").
card(powers, "17^2", "289").
card(powers, "17^3", "4913").
card(powers, "18^2", "324").
card(powers, "18^3", "5832").
card(powers, "19^2", "361").
card(powers, "19^3", "6859").
card(powers, "20^2", "400").
card(powers, "20^3", "8000").
card(powers, "21^2", "441").
card(powers, "21^3", "9261").
card(powers, "22^2", "484").
card(powers, "23^2", "529").
card(powers, "24^2", "576").
card(powers, "25^2", "625").
card(powers, "26^2", "676").
card(powers, "27^2", "729").
card(powers, "28^2", "784").
card(powers, "29^2", "841").
card(powers, "2^10", "1024").
card(powers, "2^11", "2048").
card(powers, "2^12", "4096").
card(powers, "2^13", "8192").
card(powers, "2^2", "4").
card(powers, "2^3", "8").
card(powers, "2^4", "16").
card(powers, "2^5", "32").
card(powers, "2^6", "64").
card(powers, "2^7", "128").
card(powers, "2^8", "256").
card(powers, "2^9", "512").
card(powers, "30^2", "900").
card(powers, "3^2", "9").
card(powers, "3^3", "27").
card(powers, "3^4", "81").
card(powers, "3^5", "243").
card(powers, "3^6", "729").
card(powers, "3^7", "2187").
card(powers, "3^8", "6561").
card(powers, "4^2", "16").
card(powers, "4^3", "64").
card(powers, "4^4", "256").
card(powers, "4^5", "1024").
card(powers, "4^6", "4096").
card(powers, "5^2", "25").
card(powers, "5^3", "125").
card(powers, "5^4", "625").
card(powers, "5^5", "3125").
card(powers, "6^2", "36").
card(powers, "6^3", "216").
card(powers, "6^4", "1296").
card(powers, "6^5", "7776").
card(powers, "7^2", "49").
card(powers, "7^3", "343").
card(powers, "7^4", "2401").
card(powers, "8^2", "64").
card(powers, "8^3", "512").
card(powers, "8^4", "4096").
card(powers, "9^2", "81").
card(powers, "9^3", "729").
card(powers, "9^4", "6561").
card(products, "10 * 10", "100").
card(products, "10 * 11", "110").
card(products, "10 * 12", "120").
card(products, "10 * 13", "130").
card(products, "10 * 14", "140").
card(products, "10 * 15", "150").
card(products, "10 * 16", "160").
card(products, "10 * 17", "170").
card(products, "10 * 18", "180").
card(products, "10 * 19", "190").
card(products, "10 * 20", "200").
card(products, "10 * 21", "210").
card(products, "10 * 22", "220").
card(products, "10 * 23", "230").
card(products, "10 * 24", "240").
card(products, "10 * 25", "250").
card(products, "10 * 26", "260").
card(products, "10 * 27", "270").
card(products, "10 * 28", "280").
card(products, "10 * 29", "290").
card(products, "10 * 30", "300").
card(products, "11 * 11", "121").
card(products, "11 * 12", "132").
card(products, "11 * 13", "143").
card(products, "11 * 14", "154").
card(products, "11 * 15", "165").
card(products, "11 * 16", "176").
card(products, "11 * 17", "187").
card(products, "11 * 18", "198").
card(products, "11 * 19", "209").
card(products, "11 * 20", "220").
card(products, "11 * 21", "231").
card(products, "11 * 22", "242").
card(products, "11 * 23", "253").
card(products, "11 * 24", "264").
card(products, "11 * 25", "275").
card(products, "11 * 26", "286").
card(products, "11 * 27", "297").
card(products, "11 * 28", "308").
card(products, "11 * 29", "319").
card(products, "11 * 30", "330").
card(products, "12 * 12", "144").
card(products, "12 * 13", "156").
card(products, "12 * 14", "168").
card(products, "12 * 15", "180").
card(products, "12 * 16", "192").
card(products, "12 * 17", "204").
card(products, "12 * 18", "216").
card(products, "12 * 19", "228").
card(products, "12 * 20", "240").
card(products, "12 * 21", "252").
card(products, "12 * 22", "264").
card(products, "12 * 23", "276").
card(products, "12 * 24", "288").
card(products, "12 * 25", "300").
card(products, "12 * 26", "312").
card(products, "12 * 27", "324").
card(products, "12 * 28", "336").
card(products, "12 * 29", "348").
card(products, "12 * 30", "360").
card(products, "13 * 13", "169").
card(products, "13 * 14", "182").
card(products, "13 * 15", "195").
card(products, "13 * 16", "208").
card(products, "13 * 17", "221").
card(products, "13 * 18", "234").
card(products, "13 * 19", "247").
card(products, "13 * 20", "260").
card(products, "13 * 21", "273").
card(products, "13 * 22", "286").
card(products, "13 * 23", "299").
card(products, "13 * 24", "312").
card(products, "13 * 25", "325").
card(products, "13 * 26", "338").
card(products, "13 * 27", "351").
card(products, "13 * 28", "364").
card(products, "13 * 29", "377").
card(products, "13 * 30", "390").
card(products, "14 * 14", "196").
card(products, "14 * 15", "210").
card(products, "14 * 16", "224").
card(products, "14 * 17", "238").
card(products, "14 * 18", "252").
card(products, "14 * 19", "266").
card(products, "14 * 20", "280").
card(products, "14 * 21", "294").
card(products, "14 * 22", "308").
card(products, "14 * 23", "322").
card(products, "14 * 24", "336").
card(products, "14 * 25", "350").
card(products, "14 * 26", "364").
card(products, "14 * 27", "378").
card(products, "14 * 28", "392").
card(products, "14 * 29", "406").
card(products, "14 * 30", "420").
card(products, "15 * 15", "225").
card(products, "15 * 16", "240").
card(products, "15 * 17", "255").
card(products, "15 * 18", "270").
card(products, "15 * 19", "285").
card(products, "15 * 20", "300").
card(products, "15 * 21", "315").
card(products, "15 * 22", "330").
card(products, "15 * 23", "345").
card(products, "15 * 24", "360").
card(products, "15 * 25", "375").
card(products, "15 * 26", "390").
card(products, "15 * 27", "405").
card(products, "15 * 28", "420").
card(products, "15 * 29", "435").
card(products, "15 * 30", "450").
card(products, "16 * 16", "256").
card(products, "16 * 17", "272").
card(products, "16 * 18", "288").
card(products, "16 * 19", "304").
card(products, "16 * 20", "320").
card(products, "16 * 21", "336").
card(products, "16 * 22", "352").
card(products, "16 * 23", "368").
card(products, "16 * 24", "384").
card(products, "16 * 25", "400").
card(products, "16 * 26", "416").
card(products, "16 * 27", "432").
card(products, "16 * 28", "448").
card(products, "16 * 29", "464").
card(products, "16 * 30", "480").
card(products, "17 * 17", "289").
card(products, "17 * 18", "306").
card(products, "17 * 19", "323").
card(products, "17 * 20", "340").
card(products, "17 * 21", "357").
card(products, "17 * 22", "374").
card(products, "17 * 23", "391").
card(products, "17 * 24", "408").
card(products, "17 * 25", "425").
card(products, "17 * 26", "442").
card(products, "17 * 27", "459").
card(products, "17 * 28", "476").
card(products, "17 * 29", "493").
card(products, "17 * 30", "510").
card(products, "18 * 18", "324").
card(products, "18 * 19", "342").
card(products, "18 * 20", "360").
card(products, "18 * 21", "378").
card(products, "18 * 22", "396").
card(products, "18 * 23", "414").
card(products, "18 * 24", "432").
card(products, "18 * 25", "450").
card(products, "18 * 26", "468").
card(products, "18 * 27", "486").
card(products, "18 * 28", "504").
card(products, "18 * 29", "522").
card(products, "18 * 30", "540").
card(products, "19 * 19", "361").
card(products, "19 * 20", "380").
card(products, "19 * 21", "399").
card(products, "19 * 22", "418").
card(products, "19 * 23", "437").
card(products, "19 * 24", "456").
card(products, "19 * 25", "475").
card(products, "19 * 26", "494").
card(products, "19 * 27", "513").
card(products, "19 * 28", "532").
card(products, "19 * 29", "551").
card(products, "19 * 30", "570").
card(products, "2 * 10", "20").
card(products, "2 * 11", "22").
card(products, "2 * 12", "24").
card(products, "2 * 13", "26").
card(products, "2 * 14", "28").
card(products, "2 * 15", "30").
card(products, "2 * 16", "32").
card(products, "2 * 17", "34").
card(products, "2 * 18", "36").
card(products, "2 * 19", "38").
card(products, "2 * 2", "4").
card(products, "2 * 20", "40").
card(products, "2 * 21", "42").
card(products, "2 * 22", "44").
card(products, "2 * 23", "46").
card(products, "2 * 24", "48").
card(products, "2 * 25", "50").
card(products, "2 * 26", "52").
card(products, "2 * 27", "54").
card(products, "2 * 28", "56").
card(products, "2 * 29", "58").
card(products, "2 * 3", "6").
card(products, "2 * 30", "60").
card(products, "2 * 4", "8").
card(products, "2 * 5", "10").
card(products, "2 * 6", "12").
card(products, "2 * 7", "14").
card(products, "2 * 8", "16").
card(products, "2 * 9", "18").
card(products, "20 * 20", "400").
card(products, "20 * 21", "420").
card(products, "20 * 22", "440").
card(products, "20 * 23", "460").
card(products, "20 * 24", "480").
card(products, "20 * 25", "500").
card(products, "20 * 26", "520").
card(products, "20 * 27", "540").
card(products, "20 * 28", "560").
card(products, "20 * 29", "580").
card(products, "20 * 30", "600").
card(products, "21 * 21", "441").
card(products, "21 * 22", "462").
card(products, "21 * 23", "483").
card(products, "21 * 24", "504").
card(products, "21 * 25", "525").
card(products, "21 * 26", "546").
card(products, "21 * 27", "567").
card(products, "21 * 28", "588").
card(products, "21 * 29", "609").
card(products, "21 * 30", "630").
card(products, "22 * 22", "484").
card(products, "22 * 23", "506").
card(products, "22 * 24", "528").
card(products, "22 * 25", "550").
card(products, "22 * 26", "572").
card(products, "22 * 27", "594").
card(products, "22 * 28", "616").
card(products, "22 * 29", "638").
card(products, "22 * 30", "660").
card(products, "23 * 23", "529").
card(products, "23 * 24", "552").
card(products, "23 * 25", "575").
card(products, "23 * 26", "598").
card(products, "23 * 27", "621").
card(products, "23 * 28", "644").
card(products, "23 * 29", "667").
card(products, "23 * 30", "690").
card(products, "24 * 24", "576").
card(products, "24 * 25", "600").
card(products, "24 * 26", "624").
card(products, "24 * 27", "648").
card(products, "24 * 28", "672").
card(products, "24 * 29", "696").
card(products, "24 * 30", "720").
card(products, "25 * 25", "625").
card(products, "25 * 26", "650").
card(products, "25 * 27", "675").
card(products, "25 * 28", "700").
card(products, "25 * 29", "725").
card(products, "25 * 30", "750").
card(products, "26 * 26", "676").
card(products, "26 * 27", "702").
card(products, "26 * 28", "728").
card(products, "26 * 29", "754").
card(products, "26 * 30", "780").
card(products, "27 * 27", "729").
card(products, "27 * 28", "756").
card(products, "27 * 29", "783").
card(products, "27 * 30", "810").
card(products, "28 * 28", "784").
card(products, "28 * 29", "812").
card(products, "28 * 30", "840").
card(products, "29 * 29", "841").
card(products, "29 * 30", "870").
card(products, "3 * 10", "30").
card(products, "3 * 11", "33").
card(products, "3 * 12", "36").
card(products, "3 * 13", "39").
card(products, "3 * 14", "42").
card(products, "3 * 15", "45").
card(products, "3 * 16", "48").
card(products, "3 * 17", "51").
card(products, "3 * 18", "54").
card(products, "3 * 19", "57").
card(products, "3 * 20", "60").
card(products, "3 * 21", "63").
card(products, "3 * 22", "66").
card(products, "3 * 23", "69").
card(products, "3 * 24", "72").
card(products, "3 * 25", "75").
card(products, "3 * 26", "78").
card(products, "3 * 27", "81").
card(products, "3 * 28", "84").
card(products, "3 * 29", "87").
card(products, "3 * 3", "9").
card(products, "3 * 30", "90").
card(products, "3 * 4", "12").
card(products, "3 * 5", "15").
card(products, "3 * 6", "18").
card(products, "3 * 7", "21").
card(products, "3 * 8", "24").
card(products, "3 * 9", "27").
card(products, "30 * 30", "900").
card(products, "4 * 10", "40").
card(products, "4 * 11", "44").
card(products, "4 * 12", "48").
card(products, "4 * 13", "52").
card(products, "4 * 14", "56").
card(products, "4 * 15", "60").
card(products, "4 * 16", "64").
card(products, "4 * 17", "68").
card(products, "4 * 18", "72").
card(products, "4 * 19", "76").
card(products, "4 * 20", "80").
card(products, "4 * 21", "84").
card(products, "4 * 22", "88").
card(products, "4 * 23", "92").
card(products, "4 * 24", "96").
card(products, "4 * 25", "100").
card(products, "4 * 26", "104").
card(products, "4 * 27", "108").
card(products, "4 * 28", "112").
card(products, "4 * 29", "116").
card(products, "4 * 30", "120").
card(products, "4 * 4", "16").
card(products, "4 * 5", "20").
card(products, "4 * 6", "24").
card(products, "4 * 7", "28").
card(products, "4 * 8", "32").
card(products, "4 * 9", "36").
card(products, "5 * 10", "50").
card(products, "5 * 11", "55").
card(products, "5 * 12", "60").
card(products, "5 * 13", "65").
card(products, "5 * 14", "70").
card(products, "5 * 15", "75").
card(products, "5 * 16", "80").
card(products, "5 * 17", "85").
card(products, "5 * 18", "90").
card(products, "5 * 19", "95").
card(products, "5 * 20", "100").
card(products, "5 * 21", "105").
card(products, "5 * 22", "110").
card(products, "5 * 23", "115").
card(products, "5 * 24", "120").
card(products, "5 * 25", "125").
card(products, "5 * 26", "130").
card(products, "5 * 27", "135").
card(products, "5 * 28", "140").
card(products, "5 * 29", "145").
card(products, "5 * 30", "150").
card(products, "5 * 5", "25").
card(products, "5 * 6", "30").
card(products, "5 * 7", "35").
card(products, "5 * 8", "40").
card(products, "5 * 9", "45").
card(products, "6 * 10", "60").
card(products, "6 * 11", "66").
card(products, "6 * 12", "72").
card(products, "6 * 13", "78").
card(products, "6 * 14", "84").
card(products, "6 * 15", "90").
card(products, "6 * 16", "96").
card(products, "6 * 17", "102").
card(products, "6 * 18", "108").
card(products, "6 * 19", "114").
card(products, "6 * 20", "120").
card(products, "6 * 21", "126").
card(products, "6 * 22", "132").
card(products, "6 * 23", "138").
card(products, "6 * 24", "144").
card(products, "6 * 25", "150").
card(products, "6 * 26", "156").
card(products, "6 * 27", "162").
card(products, "6 * 28", "168").
card(products, "6 * 29", "174").
card(products, "6 * 30", "180").
card(products, "6 * 6", "36").
card(products, "6 * 7", "42").
card(products, "6 * 8", "48").
card(products, "6 * 9", "54").
card(products, "7 * 10", "70").
card(products, "7 * 11", "77").
card(products, "7 * 12", "84").
card(products, "7 * 13", "91").
card(products, "7 * 14", "98").
card(products, "7 * 15", "105").
card(products, "7 * 16", "112").
card(products, "7 * 17", "119").
card(products, "7 * 18", "126").
card(products, "7 * 19", "133").
card(products, "7 * 20", "140").
card(products, "7 * 21", "147").
card(products, "7 * 22", "154").
card(products, "7 * 23", "161").
card(products, "7 * 24", "168").
card(products, "7 * 25", "175").
card(products, "7 * 26", "182").
card(products, "7 * 27", "189").
card(products, "7 * 28", "196").
card(products, "7 * 29", "203").
card(products, "7 * 30", "210").
card(products, "7 * 7", "49").
card(products, "7 * 8", "56").
card(products, "7 * 9", "63").
card(products, "8 * 10", "80").
card(products, "8 * 11", "88").
card(products, "8 * 12", "96").
card(products, "8 * 13", "104").
card(products, "8 * 14", "112").
card(products, "8 * 15", "120").
card(products, "8 * 16", "128").
card(products, "8 * 17", "136").
card(products, "8 * 18", "144").
card(products, "8 * 19", "152").
card(products, "8 * 20", "160").
card(products, "8 * 21", "168").
card(products, "8 * 22", "176").
card(products, "8 * 23", "184").
card(products, "8 * 24", "192").
card(products, "8 * 25", "200").
card(products, "8 * 26", "208").
card(products, "8 * 27", "216").
card(products, "8 * 28", "224").
card(products, "8 * 29", "232").
card(products, "8 * 30", "240").
card(products, "8 * 8", "64").
card(products, "8 * 9", "72").
card(products, "9 * 10", "90").
card(products, "9 * 11", "99").
card(products, "9 * 12", "108").
card(products, "9 * 13", "117").
card(products, "9 * 14", "126").
card(products, "9 * 15", "135").
card(products, "9 * 16", "144").
card(products, "9 * 17", "153").
card(products, "9 * 18", "162").
card(products, "9 * 19", "171").
card(products, "9 * 20", "180").
card(products, "9 * 21", "189").
card(products, "9 * 22", "198").
card(products, "9 * 23", "207").
card(products, "9 * 24", "216").
card(products, "9 * 25", "225").
card(products, "9 * 26", "234").
card(products, "9 * 27", "243").
card(products, "9 * 28", "252").
card(products, "9 * 29", "261").
card(products, "9 * 30", "270").
card(products, "9 * 9", "81").
card(prolog_library, "dcg/basics", "Various general DCG utilities").
card(prolog_library, "dcg/high_order", "High order grammar operations").
card(prolog_library, aggregate, "Aggregation operators on backtrackable predicates").
card(prolog_library, ansi_term, "Print decorated text to ANSI consoles").
card(prolog_library, apply, "Apply predicates on a list").
card(prolog_library, assoc, "Association lists").
card(prolog_library, broadcast, "Broadcast and receive event notifications").
card(prolog_library, charsio, "I/O on Lists of Character Codes").
card(prolog_library, check, "Consistency checking").
card(prolog_library, clpb, "CLP(B): Constraint Logic Programming over Boolean Variables").
card(prolog_library, clpfd, "CLP(FD): Constraint Logic Programming over Finite Domains").
card(prolog_library, clpqr, "Constraint Logic Programming over Rationals and Reals").
card(prolog_library, csv, "Process CSV (Comma-Separated Values) data").
card(prolog_library, debug, "Print debug messages and test assertions").
card(prolog_library, dicts, "Dict utilities").
card(prolog_library, error, "Error generating support").
card(prolog_library, fastrw, "Fast reading and writing of terms").
card(prolog_library, gensym, "Generate unique identifiers").
card(prolog_library, heaps, "Heaps/priority queues").
card(prolog_library, increval, "Incremental dynamic predicate modification").
card(prolog_library, intercept, "Intercept and signal interface").
card(prolog_library, iostream, "Utilities to deal with streams").
card(prolog_library, listing, "List programs and pretty print clauses").
card(prolog_library, lists, "List Manipulation").
card(prolog_library, main, "Provide entry point for scripts").
card(prolog_library, nb_set, "Non-backtrackable set").
card(prolog_library, occurs, "Finding and counting sub-terms").
card(prolog_library, option, "Option list processing").
card(prolog_library, optparse, "Command line parsing").
card(prolog_library, ordsets, "Ordered set manipulation").
card(prolog_library, pairs, "Operations on key-value lists").
card(prolog_library, persistency, "Provide persistent dynamic predicates").
card(prolog_library, pio, "Pure I/O").
card(prolog_library, portray_text, "Portray text").
card(prolog_library, predicate_options, "Declare option-processing of predicates").
card(prolog_library, prolog_debug, "User level debugging tools").
card(prolog_library, prolog_jiti, "Just In Time Indexing (JITI) utilities").
card(prolog_library, prolog_pack, "A package manager for Prolog").
card(prolog_library, prolog_xref, "Prolog cross-referencer data collection").
card(prolog_library, quasi_quotations, "Define Quasi Quotation syntax").
card(prolog_library, random, "Random numbers").
card(prolog_library, rbtrees, "Red black trees").
card(prolog_library, readutil, "Read utilities").
card(prolog_library, record, "Access named fields in a term").
card(prolog_library, registry, "Manipulating the Windows registry").
card(prolog_library, settings, "Setting management").
card(prolog_library, simplex, "Solve linear programming problems").
card(prolog_library, solution_sequences, "Modify solution sequences").
card(prolog_library, statistics, "Get information about resource usage").
card(prolog_library, strings, "String utilities").
card(prolog_library, tables, "XSB interface to tables").
card(prolog_library, terms, "Term manipulation").
card(prolog_library, thread, "High level thread primitives").
card(prolog_library, thread_pool, "Resource bounded thread management").
card(prolog_library, ugraphs, "Graph manipulation library").
card(prolog_library, url, "Analysing and constructing URL").
card(prolog_library, varnumbers, "Utilities for numbered terms").
card(prolog_library, www_browser, "Activating your Web-browser").
card(prolog_library, yall, "Lambda expressions").
card(prolog_predicates, "!/0", "Cut").
card(prolog_predicates, "$/0", "Cut plus determinism").
card(prolog_predicates, "$/1", "Check if a goal succeeds deterministically").
card(prolog_predicates, ",/2", "And").
card(prolog_predicates, "->/2", "If-then").
card(prolog_predicates, ";/2", "Or").
card(prolog_predicates, "</2", "Less than").
card(prolog_predicates, "=../2", "Term to list; univ").
card(prolog_predicates, "=/2", "Unify").
card(prolog_predicates, "=:=/2", "Equality").
card(prolog_predicates, "=</2", "Less than or equal").
card(prolog_predicates, "==/2", "Equivalence").
card(prolog_predicates, "=\\=/2", "Inequality").
card(prolog_predicates, ">/2", "Greater than").
card(prolog_predicates, ">=/2", "Greater than or equal").
card(prolog_predicates, "@</2", "Term comes before term").
card(prolog_predicates, "@=</2", "Term comes before or is equal to term").
card(prolog_predicates, "@>/2", "Term comes after term").
card(prolog_predicates, "@>=/2", "Term comes after or is equal to term").
card(prolog_predicates, "\\+/1", "Unprovable; not").
card(prolog_predicates, "\\=/2", "Doesn't unify").
card(prolog_predicates, "\\==/2", "Isn't equivalent").
card(prolog_predicates, "abolish/1, abolish/2", "Remove a predicate from the database").
card(prolog_predicates, "abort/0", "Stop the execution").
card(prolog_predicates, "absolute_file_name/2, absolute_file_name/3", "Expand a filename into its path").
card(prolog_predicates, "access_file/2", "Check if a file can be accessed in a mode").
card(prolog_predicates, "acyclic_term/1", "Check if a term doesn't contain cycles").
card(prolog_predicates, "add_import_module/3", "Add an import module to the list").
card(prolog_predicates, "append/1", "Open a file to write at the end").
card(prolog_predicates, "append/2", "Concatenate a list of lists").
card(prolog_predicates, "append/3", "Concatenate two lists to form a third list").
card(prolog_predicates, "arg/3", "Get the numbered argument of a term").
card(prolog_predicates, "assert/1, assert/2", "Add a clause to the database").
card(prolog_predicates, "asserta/1, assert/2", "Add a clause to the front of the database").
card(prolog_predicates, "assertz/1, assertz/2", "Add a clause to the end of the database").
card(prolog_predicates, "at_end_of_stream/0, at_end_of_stream/1", "Check if the last character has been read").
card(prolog_predicates, "atom/1", "Check if a term is an atom").
card(prolog_predicates, "atom_chars/2", "Convert an atom to a list of character atoms").
card(prolog_predicates, "atom_codes/2", "Convert an atom to a list of character codes").
card(prolog_predicates, "atom_concat/2", "Concatenate two atoms to form a third atom").
card(prolog_predicates, "atom_length/2", "Find the length of an atom").
card(prolog_predicates, "atom_number/2", "Convert an atom directly to a number or fail silently").
card(prolog_predicates, "atomic/1", "Check if a term is not a variable or compound").
card(prolog_predicates, "atomic_list_concat/2, atomic_list_concat/3", "Join a list with or without a separator to form an atom").
card(prolog_predicates, "attvar/1", "Check if a variable is attributed").
card(prolog_predicates, "b_getval/2", "Get the value of a backtrackable global variable").
card(prolog_predicates, "b_setval/2", "Set the value of a global variable and unset on backtracking").
card(prolog_predicates, "bagof/3", "Collect the results of applying a template to a goal or fail if none").
card(prolog_predicates, "between/3", "Check or generate integer values in a range").
card(prolog_predicates, "break/0", "Start a new top level").
card(prolog_predicates, "call/1, call/2", "Append optional arguments to a goal and call it").
card(prolog_predicates, "call_cleanup/2", "Call a goal and do a cleanup").
card(prolog_predicates, "call_residue_vars/2", "Find any residual attributed variables left by calling a goal").
card(prolog_predicates, "call_shared_object_function/2", "Call a function in the loaded shared object file").
card(prolog_predicates, "callable/1", "Check for an atom or compound term that might be callable").
card(prolog_predicates, "catch/3", "When an exception occurs, cut, backtrack, and recover").
card(prolog_predicates, "char_code/2", "Convert between a character atom and a code").
card(prolog_predicates, "char_conversion/2", "Map character codes to different codes while reading input").
card(prolog_predicates, "char_type/2", "Check or generate characters or their types").
card(prolog_predicates, "character_count/2", "Get the number of characters read or written").
card(prolog_predicates, "clause/2, clause/3", "Match the head and body of a clause").
card(prolog_predicates, "close/1, close/3", "Close a stream").
card(prolog_predicates, "close_shared_object/1", "Close a loaded shared object file").
card(prolog_predicates, "compare/3", "Check if two terms are in order").
card(prolog_predicates, "compile_predicates/1", "Compile dynamic predicates back into static predicates").
card(prolog_predicates, "compound/1", "Check if a term is compound").
card(prolog_predicates, "consult/1", "Load a source file").
card(prolog_predicates, "copy_term/2, copy_term/3", "Copy terms and variables with attributes").
card(prolog_predicates, "copy_term_nat/2", "Copy terms and variables without attributes").
card(prolog_predicates, "create_prolog_flag/3", "Define a new flag").
card(prolog_predicates, "current_atom/1", "Get a currently defined atom").
card(prolog_predicates, "current_char_conversion/2", "Get a character code mapping").
card(prolog_predicates, "current_input/1", "Get the current input stream").
card(prolog_predicates, "current_module/1", "Get a currently loaded module").
card(prolog_predicates, "current_op/3", "Get the precedence, type, and name of an operator").
card(prolog_predicates, "current_output/1", "Get the current output stream").
card(prolog_predicates, "current_predicate/1, current_predicate/2", "Get a currently defined predicate and optionally autoload it").
card(prolog_predicates, "current_prolog_flag/2", "Get the value of a flag").
card(prolog_predicates, "cyclic_term/1", "Check if a term contains cycles").
card(prolog_predicates, "del_attr/1", "Delete an attribute of a variable").
card(prolog_predicates, "del_attrs/1", "Delete all attributes of a variable").
card(prolog_predicates, "delete_directory/1", "Delete an empty file directory").
card(prolog_predicates, "delete_file/1", "Delete a file ").
card(prolog_predicates, "delete_import_module/2", "Delete an import module from the list").
card(prolog_predicates, "det/1", "Declare a predicate to be deterministic").
card(prolog_predicates, "directory_files/2", "Get the list of entries in a file directory").
card(prolog_predicates, "duplicate_term/2", "Copy terms, ground terms, and variables with attributes").
card(prolog_predicates, "ensure_loaded/1", "Load and consult a file if it isn't already loaded").
card(prolog_predicates, "erase/1", "Delete a record from the recorded database").
card(prolog_predicates, "exception/3", "Called by the system for runtime errors").
card(prolog_predicates, "expand_term/2", "Called by the compiler to process input").
card(prolog_predicates, "export/1", "Add predicate to the public list of a dynamically created module").
card(prolog_predicates, "fail/0", "Always fail").
card(prolog_predicates, "false/0", "Always fail").
card(prolog_predicates, "fast_read/2", "Read a term using the fast serialization format").
card(prolog_predicates, "fast_write/2", "Write a term using the fast serialization format").
card(prolog_predicates, "file_name_extension/3", "Add, remove, or check a filename extension").
card(prolog_predicates, "file_search_path/2", "Define an alias for file paths").
card(prolog_predicates, "findall/3, findall/4", "Collect the results of applying a template to a goal while ignoring free variables").
card(prolog_predicates, "findnsols/4, findnsols/5", "Like findall/3 and findall/4, but returns a chunk of n solutions").
card(prolog_predicates, "float/1", "Convert or check a floating point number").
card(prolog_predicates, "flush_output/0, flush_output/1", "Flush output").
card(prolog_predicates, "forall/2", "For each condition, prove an action").
card(prolog_predicates, "format/1, format/2", "Format and print a list of arguments").
card(prolog_predicates, "freeze/2", "Delay the execution of a goal until a variable is bound").
card(prolog_predicates, "frozen/2", "Unify with a goal delayed on some attributed variable in a term").
card(prolog_predicates, "functor/3", "Term is a functor with name and arity").
card(prolog_predicates, "garbage_collect/0", "Invoke the garbage collector").
card(prolog_predicates, "get/1, get/2, get0/1, get0/2", "Deprecated, use get_char or get_code instead").
card(prolog_predicates, "get_attr/3", "Get an attribute of a variable").
card(prolog_predicates, "get_attrs/2", "Get all attributes of a variable").
card(prolog_predicates, "get_byte/1, get_byte/2", "Read the next byte").
card(prolog_predicates, "get_char/1, get_char/2", "Read the next character atom").
card(prolog_predicates, "get_code/1, get_code/2", "Read the next character code").
card(prolog_predicates, "get_time/1", "Get the current time").
card(prolog_predicates, "ground", "Check if a term holds no free variables").
card(prolog_predicates, "halt/0, halt/1", "Stop execution with error code").
card(prolog_predicates, "ignore/1", "Call a goal at most once and ignore if it fails").
card(prolog_predicates, "import_module/2", "Check if a module inherits from an import").
card(prolog_predicates, "instance/2", "Unify a term with a database record").
card(prolog_predicates, "integer/1", "Check if a term is an integer").
card(prolog_predicates, "is/2", "Evaluate an expression").
card(prolog_predicates, "is_absolute_file_name/1", "Check if a filename is an absolute path").
card(prolog_predicates, "is_list/1", "Recursively check if a term is bound to a list").
card(prolog_predicates, "keysort/2", "Sort a list of key-value pairs by key").
card(prolog_predicates, "leash/2", "Set or query user interaction on trace ports").
card(prolog_predicates, "length/2", "Get the number of elements in a list").
card(prolog_predicates, "line_count/2", "Count the number of lines read or written").
card(prolog_predicates, "line_position/2", "Count the character position on the current line").
card(prolog_predicates, "load_files/1", "Main predicate for loading files").
card(prolog_predicates, "main/0", "Call the main program predicate").
card(prolog_predicates, "make_directory/1", "Create a new file directory").
card(prolog_predicates, "memberchk/2", "Semideterministic check for list membership").
card(prolog_predicates, "message_hook/3", "Intercept messages from print_message/2 and format them").
card(prolog_predicates, "message_queue_create/1", "Create a message queue").
card(prolog_predicates, "message_queue_destroy/1", "Destroy a message queue").
card(prolog_predicates, "message_to_string/2", "Translate a message term into a string").
card(prolog_predicates, "module/1", "Switch the default working module for the interactive top level").
card(prolog_predicates, "module_property/2", "Check a property of a module").
card(prolog_predicates, "msort/1", "Sort without removing duplicates").
card(prolog_predicates, "mutex_create/1", "Create a mutex").
card(prolog_predicates, "mutex_lock/1", "Lock a mutex").
card(prolog_predicates, "mutex_unlock/1", "Unlock a mutex").
card(prolog_predicates, "nb_current/2", "Get any non-backtrackable variable and its value").
card(prolog_predicates, "nb_delete/1", "Delete any non-backtrackable variable").
card(prolog_predicates, "nb_getval/2", "Non-backtrackable synonym for b_getval/2").
card(prolog_predicates, "nb_setarg/3", "Set a numbered argument of a compound term and don't unset on backtracking").
card(prolog_predicates, "nb_setval/2", "Set the value of a global variable and don't unset on backtracking").
card(prolog_predicates, "nl/0, nl/1", "Write a newline character").
card(prolog_predicates, "nonvar/1", "Check if a term isn't a variable").
card(prolog_predicates, "notrace/0", "Suspend the tracer").
card(prolog_predicates, "nth_clause/3", "Get a clause of a predicate using its index number").
card(prolog_predicates, "number/1", "Check if a term is a number").
card(prolog_predicates, "number_chars/2", "Convert a number to a list of character atoms").
card(prolog_predicates, "number_codes/2", "Convert a number to a list of character codes").
card(prolog_predicates, "number_string/2", "Convert a number to a string").
card(prolog_predicates, "numbervars/3", "Unify the free variables in a term with a numbered variable").
card(prolog_predicates, "on_signal/3", "Get or set a signal handler").
card(prolog_predicates, "once/1", "Make a goal semideterministic").
card(prolog_predicates, "op/3", "Declare an operator with a type and precedence").
card(prolog_predicates, "open/3, open/4", "Open a file for reading or writing").
card(prolog_predicates, "open_shared_object/2, open_shared_object/3", "Open a shared object file").
card(prolog_predicates, "peek_byte/1, peek_byte/2", "Read the next byte without removing it from the stream").
card(prolog_predicates, "peek_char/1, peek_char/2", "Read the next character atom without removing it from the stream").
card(prolog_predicates, "peek_code/1, peek_code/2", "Read the next character code without removing it from the stream").
card(prolog_predicates, "phrase/2, phrase/3", "Check if a DCG body parses a difference list").
card(prolog_predicates, "plus/3", "Check if two arguments sum to a third").
card(prolog_predicates, "portray/1", "Change the behavior of print on subterms").
card(prolog_predicates, "predicate_property/2", "Check if head refers to a predicate that has a property").
card(prolog_predicates, "print/1, print/2", "Print a term for debugging").
card(prolog_predicates, "print_message/2", "Print various kinds of messages the same way as the system and libraries print them").
card(prolog_predicates, "print_message_lines/3", "Print a message that has been translated to a list of elements").
card(prolog_predicates, "prolog_file_type/2", "Determine the extensions used when searching for files").
card(prolog_predicates, "prolog_load_context/2", "Get context information during compilation").
card(prolog_predicates, "prolog_to_os_filename/2", "Convert a file path to an operating system path").
card(prolog_predicates, "prompt/2", "Set a prompt for reading user input").
card(prolog_predicates, "prompt1/1", "Set the prompt for reading the next line of user input").
card(prolog_predicates, "put/1, put/2", "Deprecated, use put_char or put_code instead").
card(prolog_predicates, "put_attr/3", "Set an attribute of a variable").
card(prolog_predicates, "put_attrs/2", "Set all attributes of a variable").
card(prolog_predicates, "put_byte/1, put_byte/2", "Write the next byte").
card(prolog_predicates, "put_char/1, put_char/2", "Write the next character atom").
card(prolog_predicates, "put_code/1, put_code/2", "Write the next character code").
card(prolog_predicates, "rational/1", "Convert the exact value of an expression to a rational number or integer").
card(prolog_predicates, "rationalize/1", "Convert the closest value of an expression to a rational number or integer").
card(prolog_predicates, "read/1, read/2", "Read the next term").
card(prolog_predicates, "read_clause/3", "Read the next term in the current context according to options").
card(prolog_predicates, "read_link/3", "Get the link and target of a symbolic link").
card(prolog_predicates, "read_term/2, read_term/3", "Read the next term according to options").
card(prolog_predicates, "read_term_from_atom/3", "Read the next term from an atom according to options").
card(prolog_predicates, "recorda/3", "Insert a record at the front of the recorded database").
card(prolog_predicates, "recorded/3", "Get the value of a record in the recorded database").
card(prolog_predicates, "recordz/3", "Insert a record at the end of the recorded database").
card(prolog_predicates, "reexport/1, reexport/2", "Load a module and reexport all imported predicates").
card(prolog_predicates, "rename_file/2", "Rename a file").
card(prolog_predicates, "repeat/0", "Always succeed providing unlimited choice points").
card(prolog_predicates, "retract/1", "Remove a matching fact or clause from the database").
card(prolog_predicates, "retractall/1", "Remove all matching facts or clauses from the database").
card(prolog_predicates, "see/1", "Open a source for reading as the current input").
card(prolog_predicates, "seeing/1", "Get the current input stream").
card(prolog_predicates, "seek/4", "Set the current position of the input stream").
card(prolog_predicates, "seen/0", "Close the current input stream and return to user input").
card(prolog_predicates, "set_input/1", "Set the current input stream").
card(prolog_predicates, "set_output/1", "Set the current output stream").
card(prolog_predicates, "set_prolog_flag/2", "Set the value of a flag").
card(prolog_predicates, "set_stream_position/2", "Set the current position of a stream").
card(prolog_predicates, "setarg", "Set a numbered argument of a compound term").
card(prolog_predicates, "setenv/2", "Set an environment variable").
card(prolog_predicates, "setof/3", "Collect the unique, sorted results of applying a template to a goal or fail if none").
card(prolog_predicates, "setup_call_cleanup/3", "Do setup once, call a goal, then do a cleanup").
card(prolog_predicates, "shell/1, shell/2", "Execute a command on the operating system shell").
card(prolog_predicates, "skip/1, skip/2", "Read until a code or end of file is found").
card(prolog_predicates, "sleep/1", "Suspend execution for a fractional or integer number of seconds").
card(prolog_predicates, "sort/2", "Sort a list removing duplicates").
card(prolog_predicates, "statistics/0, statistics/1", "Print information about resource usage").
card(prolog_predicates, "stream_position_data/3", "Get position information about a stream property").
card(prolog_predicates, "stream_property/2", "Check a property of a stream").
card(prolog_predicates, "string/1", "Check if term is a string").
card(prolog_predicates, "sub_atom/5", "Break apart an atom into before, after, and length").
card(prolog_predicates, "sub_string/5", "Break apart a string into before, after, and length").
card(prolog_predicates, "subsumes_term/2", "Check if a term is more generic than and unifies with another term").
card(prolog_predicates, "succ/2", "Check if an integer is one more than another integer").
card(prolog_predicates, "tab/1, tab/2", "Write a tab character").
card(prolog_predicates, "tell/1", "Open a source for writing as the current output").
card(prolog_predicates, "telling/1", "Get the current output stream").
card(prolog_predicates, "term_attvars/2", "Get a list of all attributed variables in a term and its attributes").
card(prolog_predicates, "term_expansion/2", "User hook to rewrite terms read during consulting").
card(prolog_predicates, "term_hash/2, term_hash/4", "Get the hash of a term").
card(prolog_predicates, "term_to_atom/2", "Parse and unify a atom with a term").
card(prolog_predicates, "term_variables/2, term_variables/3", "Get a list of the variables in a term").
card(prolog_predicates, "thread_create/2, thread_create/3", "Create a thread and execute a goal in it").
card(prolog_predicates, "thread_exit/1", "Terminate a thread").
card(prolog_predicates, "thread_get_message/1, thread_get_message/2", "Block execution until a term arrives in a queue").
card(prolog_predicates, "thread_join/2", "Wait for a thread to terminate and get its status").
card(prolog_predicates, "thread_peek_message/1, thread_peek_message/2", "Search a message queue for a term without waiting or removing it").
card(prolog_predicates, "thread_property/2", "Check if a thread has a property").
card(prolog_predicates, "thread_self/1", "Get the thread ID of the running thread").
card(prolog_predicates, "thread_send_message/2", "Place a term in a message queue").
card(prolog_predicates, "thread_statistics/3", "Get statistical information on a thread").
card(prolog_predicates, "throw/1", "Raise an exception").
card(prolog_predicates, "tmp_file/2", "Create a temporary file identified by a base name").
card(prolog_predicates, "told/0", "Close the current output stream and return to user output").
card(prolog_predicates, "trace/0", "Start the program tracer").
card(prolog_predicates, "true/0", "Always succeed").
card(prolog_predicates, "ttyflush/0", "Flush pending output to user").
card(prolog_predicates, "undo/1", "Set a goal that can revert other goals on backtracking").
card(prolog_predicates, "unifiable/3", "Check if and how X and Y can unify").
card(prolog_predicates, "unify_with_occurs_check/2", "Perform sound unification with a check for cyclic terms").
card(prolog_predicates, "use_foreign_library/1, use_foreign_library/2", "Load and install a foreign library").
card(prolog_predicates, "use_module/1, use_module/2", "Load a file and import a list of predicates").
card(prolog_predicates, "var/1", "Check if a term is a variable").
card(prolog_predicates, "with_output_to/2", "Run a goal as once and capture output characters").
card(prolog_predicates, "working_directory/2", "Get and change the current working directory").
card(prolog_predicates, "write/1, write/2", "Write a term").
card(prolog_predicates, "write_canonical/1, write_canonical/2", "Write a term in standard quoted form with no defined operators").
card(prolog_predicates, "write_term/2, write_term/3", "Write a term with options").
card(prolog_predicates, "writeq/1, writeq/2", "Write a quoted term").
card(romanticism_paintings, "Alexander von Humboldt", "Friedrich Georg Weitsch").
card(romanticism_paintings, "Clorinda Rescues Olindo und Sophroni", "Eugène Delacroix").
card(romanticism_paintings, "Death of Sardanapalus", "Eugène Delacroix").
card(romanticism_paintings, "Dedham Vale", "John Constable").
card(romanticism_paintings, "Entry of the Crusaders in Constantinople", "Eugène Delacroix").
card(romanticism_paintings, "Episode of the Belgian Revolution of 1830", "Egide Charles Gustave Wappers").
card(romanticism_paintings, "Friedland, 1807", "Jean-Louis-Ernest Meissonier").
card(romanticism_paintings, "Frédéric Chopin", "Eugène Delacroix").
card(romanticism_paintings, "Henri Duverger, comte de la Rochejaquelein", "Pierre-Narcisse Guérin").
card(romanticism_paintings, "Henry Fuseli in Conversation with Johann Jakob Bodmer", "Henry Fuseli").
card(romanticism_paintings, "Jean-Baptiste Belley", "Anne-Louis Girodet de Roussy-Trioson").
card(romanticism_paintings, "Johann Wolfgang von Goethe", "Joseph Karl Stieler").
card(romanticism_paintings, "Liberty Leading the People", "Eugène Delacroix").
card(romanticism_paintings, "Louis Duverger, marquis de la Rochejaquelein", "Pierre-Narcisse Guérin").
card(romanticism_paintings, "Moonrise Over the Sea", "Caspar David Friedrich").
card(romanticism_paintings, "Napoleon Pardoning the Rebels at Cairo", "Pierre-Narcisse Guérin").
card(romanticism_paintings, "Odysseus in front of Scylla and Charybdis", "Henry Fuseli").
card(romanticism_paintings, "Portrait of Ludwig van Beethoven Composing Missa Solemnis", "Joseph Karl Stieler").
card(romanticism_paintings, "Portrait of Maria Dietsch", "Joseph Karl Stieler").
card(romanticism_paintings, "Portrait of a Kleptomaniac", "Théodore Géricault").
card(romanticism_paintings, "Pygmalion and Galatea", "Anne-Louis Girodet de Roussy-Trioson").
card(romanticism_paintings, "Self Portrait", "J. M. W. Turner").
card(romanticism_paintings, "Self-Portrait", "Eugène Delacroix").
card(romanticism_paintings, "Spoliarium", "Juan Luna").
card(romanticism_paintings, "Summary Execution under the Moorish Kings of Granada", "Henri Regnault").
card(romanticism_paintings, "The Barque of Dante", "Eugène Delacroix").
card(romanticism_paintings, "The Charging Chasseur", "Théodore Géricault").
card(romanticism_paintings, "The Destruction of Sodom and Gomorrah", "John Martin").
card(romanticism_paintings, "The Forging of the Sampo", "Akseli Gallen-Kallela").
card(romanticism_paintings, "The Hunt", "Raden Saleh").
card(romanticism_paintings, "The Lady of Shalott", "John William Waterhouse").
card(romanticism_paintings, "The Lion Hunt", "Eugène Delacroix").
card(romanticism_paintings, "The Massacre at Chios", "Eugène Delacroix").
card(romanticism_paintings, "The Prisoner of Chillon", "Eugène Delacroix").
card(romanticism_paintings, "The Raft of the Medusa", "Théodore Géricault").
card(romanticism_paintings, "The Return of Marcus Sextus", "Pierre-Narcisse Guérin").
card(romanticism_paintings, "The Second of May 1808", "Francisco Goya").
card(romanticism_paintings, "The Siege of Paris of 1870", "Jean-Louis-Ernest Meissonier").
card(romanticism_paintings, "The Slave Ship", "J. M. W. Turner").
card(romanticism_paintings, "The Third of May 1808", "Francisco Goya").
card(romanticism_paintings, "The Wounded Officer of the Imperial Guard Leaving the Battlefield", "Théodore Géricault").
card(romanticism_paintings, "Wanderer above the Sea of Fog", "Caspar David Friedrich").
card(romanticism_paintings, "Women of Algiers", "Eugène Delacroix").
card(romanticism_paintings, "Wreck in the Ice-sea", "Caspar David Friedrich").
card(sculptures, "Adams Memorial", "Augustus Saint-Gaudens").
card(sculptures, "Apollo and Daphne", "Gian Lorenzo Bernini").
card(sculptures, "Apollo", "Adriaen de Vries").
card(sculptures, "Atlas", "Lee Lawrie").
card(sculptures, "Bacchus", "Giambologna").
card(sculptures, "Balloon Dog", "Jeff Koons").
card(sculptures, "Barberini Faun", "Satyr").
card(sculptures, "Bird in Space", "Constantin Brâncuși").
card(sculptures, "Bird", "Fernando Botero").
card(sculptures, "Borghese Gladiator", "Agasias").
card(sculptures, "Bust", "Auguste Rodin").
card(sculptures, "Ceres", "Adriaen de Vries").
card(sculptures, "City Square", "Alberto Giacometti").
card(sculptures, "Cristo della Minerva", "Michelangelo").
card(sculptures, "Cupid", "Michelangelo").
card(sculptures, "Dama Velata (Puritas)", "Antonio Corradini").
card(sculptures, "David", "Donatello; Michelangelo").
card(sculptures, "Diana", "Augustus Saint-Gaudens").
card(sculptures, "Dog", "Alberto Giacometti").
card(sculptures, "Dying Gladiator", "Pierre Julien").
card(sculptures, "Dying Slave", "Michelangelo").
card(sculptures, "Ecstasy of Saint Teresa", "Teresa of Ávila").
card(sculptures, "Fiorenza", "Giambologna").
card(sculptures, "Guitar", "Pablo Picasso").
card(sculptures, "Head", "Auguste Rodin").
card(sculptures, "Hercules and Cacus", "Bartolommeo Bandinelli").
card(sculptures, "Hiawatha", "Augustus Saint-Gaudens").
card(sculptures, "Judith and Holofernes", "Donatello").
card(sculptures, "La Paix de Nimègue", "Martin Desjardins").
card(sculptures, "Laocoon", "Adriaen de Vries").
card(sculptures, "Laocoön and His Sons", "Agesander, Athenodoros and Polydorus of Rhodes").
card(sculptures, "Large Seated Nude", "Henri Matisse").
card(sculptures, "Le Génie du Mal", "Guillaume Geefs").
card(sculptures, "Little Dancer of Fourteen Years", "Edgar Degas").
card(sculptures, "Mademoiselle Pogany", "Constantin Brâncuși").
card(sculptures, "Madonna of Bruges", "Michelangelo").
card(sculptures, "Maman", "Louise Bourgeois").
card(sculptures, "Man with the Broken Nose", "Auguste Rodin").
card(sculptures, "Mercury Attaching his Wings", "Jean-Baptiste Pigalle").
card(sculptures, "Mercury and Psyche", "Adriaen de Vries").
card(sculptures, "Mercury", "Adriaen de Vries").
card(sculptures, "Milo of Croton", "Pierre Paul Puget").
card(sculptures, "Monument to Balzac", "Auguste Rodin").
card(sculptures, "Moses", "Michelangelo").
card(sculptures, "Neptune and Triton", "Gian Lorenzo Bernini").
card(sculptures, "Neptune", "Adriaen de Vries").
card(sculptures, "Paris", "Antonio Canova").
card(sculptures, "Perseus with the Head of the Gorgon Medusa", "Antonio Canova").
card(sculptures, "Pietà", "Michelangelo").
card(sculptures, "Psyche Revived by Cupid's Kiss", "Antonio Canova").
card(sculptures, "Reclining Figure", "Henry Moore").
card(sculptures, "Spiral Jetty", "Robert Smithson").
card(sculptures, "The Burghers of Calais", "Auguste Rodin").
card(sculptures, "The Deposition", "Michelangelo").
card(sculptures, "The Endless Column", "Constantin Brâncuși").
card(sculptures, "The Gates of Hell", "Auguste Rodin").
card(sculptures, "The Goat Amalthea with the Infant Jupiter and a Faun", "Gian Lorenzo Bernini").
card(sculptures, "The Little Mermaid", "Edvard Eriksen").
card(sculptures, "The Shade", "Auguste Rodin").
card(sculptures, "The Thinker", "Auguste Rodin").
card(sculptures, "The Three Graces", "Antonio Canova").
card(sculptures, "The Three Shades", "Auguste Rodin").
card(sculptures, "The Veiled Virgin", "Giovanni Strazza").
card(sculptures, "The Walking Man", "Auguste Rodin").
card(sculptures, "Unique Forms of Continuity in Space", "Umberto Boccioni").
card(sculptures, "Veiled Vestal", "Raffaelle Monti").
card(sculptures, "Venus Urania", "Giambologna").
card(sculptures, "Venus de Milo", "Alexandros of Antioch").
card(sculptures, "Worker and Kolkhoz Woman", "Vera Mukhina").
card(song_titles, "(Everything I Do) I Do it For You", "Bryan Adams").
card(song_titles, "(Ghost) Riders in the Sky", "Vaughn Monroe").
card(song_titles, "(I Can't Get No) Satisfaction", "The Rolling Stones").
card(song_titles, "(I've Got a Gal In) Kalamazoo", "Glenn Miller").
card(song_titles, "(I've Had) the Time of My Life", "Bill Medley & Jennifer Warnes").
card(song_titles, "(It's No) Sin", "Eddy Howard").
card(song_titles, "(Just Like) Starting Over", "John Lennon").
card(song_titles, "(Let Me Be Your) Teddy Bear", "Elvis Presley").
card(song_titles, "(Put Another Nickel In) Music! Music! Music!", "Teresa Brewer").
card(song_titles, "(Sexual) Healing", "Marvin Gaye").
card(song_titles, "(Sittin' On) the Dock of the Bay", "Otis Redding").
card(song_titles, "(They Long to Be) Close to You", "Carpenters").
card(song_titles, "(You Keep Me) Hangin' On", "The Supremes").
card(song_titles, "(You're My) Soul & Inspiration", "The Righteous Brothers").
card(song_titles, "(Your Love Keeps Lifting Me) Higher & Higher", "Jackie Wilson").
card(song_titles, "12th Street Rag", "Pee Wee Hunt").
card(song_titles, "1999", "Prince").
card(song_titles, "19th Nervous Breakdown", "The Rolling Stones").
card(song_titles, "50 Ways to Leave Your Lover", "Paul Simon").
card(song_titles, "9 to 5", "Dolly Parton").
card(song_titles, "96 Tears", "Question Mark & The Mysterians").
card(song_titles, "A Boy Named Sue", "Johnny Cash").
card(song_titles, "A Hard Day's Night", "The Beatles").
card(song_titles, "A String of Pearls", "Glenn Miller").
card(song_titles, "A Thousand Miles", "Vanessa Carlton").
card(song_titles, "A Tree in the Meadow", "Margaret Whiting").
card(song_titles, "A Whiter Shade of Pale", "Procol Harum").
card(song_titles, "A Whole New World (Aladdin's Theme)", "Regina Belle & Peabo Bryson").
card(song_titles, "A Woman in Love", "Barbra Streisand").
card(song_titles, "A-Tisket A-Tasket", "Ella Fitzgerald").
card(song_titles, "ABC", "The Jackson 5").
card(song_titles, "Abracadabra", "Steve Miller Band").
card(song_titles, "Ac-cent-tchu-ate the Positive", "Johnny Mercer").
card(song_titles, "Addicted to Love", "Robert Palmer").
card(song_titles, "After You've Gone", "Marion Harris").
card(song_titles, "Afternoon Delight", "Starland Vocal Band").
card(song_titles, "Again", "Janet Jackson").
card(song_titles, "Against All Odds (Take a Look At Me Now)", "Phil Collins").
card(song_titles, "Ain't Misbehavin'", "Fats Waller").
card(song_titles, "Ain't No Mountain High Enough", "Diana Ross; Marvin Gaye & Tammi Terrell").
card(song_titles, "Ain't No Sunshine", "Bill Withers").
card(song_titles, "Ain't That a Shame", "Fats Domino").
card(song_titles, "Airplanes", "BoB & Hayley Williams").
card(song_titles, "All Along the Watchtower", "Jimi Hendrix").
card(song_titles, "All I Have to Do is Dream", "The Everly Brothers").
card(song_titles, "All I Wanna Do", "Sheryl Crow").
card(song_titles, "All My Lovin' (You're Never Gonna Get It)", "En Vogue").
card(song_titles, "All Night Long (All Night)", "Lionel Richie").
card(song_titles, "All Out of Love", "Air Supply").
card(song_titles, "All Shook Up", "Elvis Presley").
card(song_titles, "All You Need is Love", "The Beatles").
card(song_titles, "Alone Again (Naturally)", "Gilbert O'Sullivan").
card(song_titles, "Alone", "Heart").
card(song_titles, "Always On My Mind", "Willie Nelson").
card(song_titles, "American Pie", "Don McLean").
card(song_titles, "American Woman", "Guess Who").
card(song_titles, "Angie", "The Rolling Stones").
card(song_titles, "Another Brick in the Wall (part 2)", "Pink Floyd").
card(song_titles, "Another Day in Paradise", "Phil Collins").
card(song_titles, "Another Night", "MC Sar & The Real McCoy").
card(song_titles, "Another One Bites the Dust", "Queen").
card(song_titles, "Apologize", "Timbaland & OneRepublic").
card(song_titles, "April Showers", "Al Jolson").
card(song_titles, "Aquarius/Let The Sunshine In", "Fifth Dimension").
card(song_titles, "Are You Lonesome Tonight?", "Elvis Presley").
card(song_titles, "Arthur's Theme (Best That You Can Do)", "Christopher Cross").
card(song_titles, "As Time Goes By", "Rudy Vallee & his Connecticut Yankees").
card(song_titles, "At Last", "Etta James").
card(song_titles, "At the Hop", "Danny & The Juniors").
card(song_titles, "Auf Wiederseh'n Sweetheart", "Vera Lynn").
card(song_titles, "Baby Baby", "Amy Grant").
card(song_titles, "Baby Come Back", "Player").
card(song_titles, "Baby Got Back", "Sir Mix-a-Lot").
card(song_titles, "Baby Love", "The Supremes").
card(song_titles, "Baby One More Time", "Britney Spears").
card(song_titles, "Bad Day", "Daniel Powter").
card(song_titles, "Bad Girls", "Donna Summer").
card(song_titles, "Bad Moon Rising", "Creedence Clearwater Revival").
card(song_titles, "Bad Romance", "Lady GaGa").
card(song_titles, "Bad, Bad Leroy Brown", "Jim Croce").
card(song_titles, "Baker Street", "Gerry Rafferty").
card(song_titles, "Ball of Confusion (That's What the World is Today)", "The Temptations").
card(song_titles, "Ballad of the Green Berets", "Staff Sergeant Barry Sadler").
card(song_titles, "Ballerina", "Vaughn Monroe").
card(song_titles, "Band On the Run", "Wings").
card(song_titles, "Band of Gold", "Freda Payne").
card(song_titles, "Battle of New Orleans", "Johnny Horton").
card(song_titles, "Be Bop a Lula", "Gene Vincent").
card(song_titles, "Be My Baby", "The Ronettes").
card(song_titles, "Be My Love", "Mario Lanza").
card(song_titles, "Beat It", "Michael Jackson").
card(song_titles, "Beautiful Day", "U2").
card(song_titles, "Beauty & the Beast", "Celine Dion & Peabo Bryson").
card(song_titles, "Because I Love You (The Postman Song)", "Stevie B").
card(song_titles, "Because You Loved Me", "Celine Dion").
card(song_titles, "Because of You", "Tony Bennett").
card(song_titles, "Before The Next Teardrop Falls", "Freddy Fender").
card(song_titles, "Begin the Beguine", "Artie Shaw").
card(song_titles, "Behind Closed Doors", "Charlie Rich").
card(song_titles, "Being With You", "Smokey Robinson").
card(song_titles, "Believe", "Cher").
card(song_titles, "Ben", "Michael Jackson").
card(song_titles, "Bennie & the Jets", "Elton John").
card(song_titles, "Besame Mucho", "Jimmy Dorsey").
card(song_titles, "Best of My Love", "The Emotions").
card(song_titles, "Bette Davis Eyes", "Kim Carnes").
card(song_titles, "Big Bad John", "Jimmy Dean").
card(song_titles, "Big Girls Don't Cry", "Fergie; The Four Seasons").
card(song_titles, "Billie Jean", "Michael Jackson").
card(song_titles, "Bitter Sweet Symphony", "The Verve").
card(song_titles, "Black Or White", "Michael Jackson").
card(song_titles, "Black Velvet", "Alannah Myles").
card(song_titles, "Blaze of Glory", "Bon Jovi").
card(song_titles, "Bleeding Love", "Leona Lewis").
card(song_titles, "Blue Suede Shoes", "Carl Perkins").
card(song_titles, "Blue Tango", "Leroy Anderson").
card(song_titles, "Blueberry Hill", "Fats Domino").
card(song_titles, "Blurred Lines", "Robin Thicke, T.I. & Pharrell Williams").
card(song_titles, "Body & Soul", "Coleman Hawkins").
card(song_titles, "Bohemian Rhapsody", "Queen").
card(song_titles, "Boogie Oogie Oogie", "A Taste of Honey").
card(song_titles, "Boogie Woogie Bugle Boy", "The Andrews Sisters").
card(song_titles, "Boom Boom Pow", "The Black Eyed Peas").
card(song_titles, "Born in the USA", "Bruce Springsteen").
card(song_titles, "Born to Be Wild", "Steppenwolf").
card(song_titles, "Born to Run", "Bruce Springsteen").
card(song_titles, "Boulevard of Broken Dreams", "Green Day").
card(song_titles, "Brand New Key", "Melanie").
card(song_titles, "Brandy (You're A Fine Girl)", "Looking Glass").
card(song_titles, "Breaking Up is Hard to Do", "Neil Sedaka").
card(song_titles, "Breathe", "Faith Hill").
card(song_titles, "Bridge Over Troubled Water", "Simon & Garfunkel").
card(song_titles, "Brother Louie", "Stories").
card(song_titles, "Brother, Can You Spare a Dime?", "Bing Crosby").
card(song_titles, "Brown Eyed Girl", "Van Morrison").
card(song_titles, "Brown Sugar", "The Rolling Stones").
card(song_titles, "Build Me Up Buttercup", "The Foundations").
card(song_titles, "Burn", "Usher").
card(song_titles, "Buttons & Bows", "Dinah Shore").
card(song_titles, "Bye Bye Love", "The Everly Brothers").
card(song_titles, "Bye Bye, Blackbird", "Gene Austin").
card(song_titles, "Bye, Bye, Bye", "N Sync").
card(song_titles, "Caldonia Boogie (What Makes Your Big Head So Hard)", "Louis Jordan").
card(song_titles, "California Dreamin'", "The Mamas & The Papas").
card(song_titles, "California Girls", "The Beach Boys").
card(song_titles, "Call Me Maybe", "Carly Rae Jepsen").
card(song_titles, "Call Me", "Blondie").
card(song_titles, "Can You Feel the Love Tonight", "Elton John").
card(song_titles, "Can't Buy Me Love", "The Beatles").
card(song_titles, "Can't Get Enough of Your Love, Babe", "Barry White").
card(song_titles, "Can't Help Falling in Love", "Elvis Presley; UB40").
card(song_titles, "Candle in the Wind '97", "Elton John").
card(song_titles, "Candy Man", "Sammy Davis Jr").
card(song_titles, "Car Wash", "Rose Royce").
card(song_titles, "Careless Whisper", "George Michael").
card(song_titles, "Cars", "Gary Numan").
card(song_titles, "Cat's in the Cradle", "Harry Chapin").
card(song_titles, "Cathy's Clown", "The Everly Brothers").
card(song_titles, "Celebration", "Kool & The Gang").
card(song_titles, "Centerfold", "J Geils Band").
card(song_titles, "Chain of Fools", "Aretha Franklin").
card(song_titles, "Chances Are", "Johnny Mathis").
card(song_titles, "Change the World", "Eric Clapton").
card(song_titles, "Chapel of Love", "Dixie Cups").
card(song_titles, "Chattanooga Choo Choo", "Glenn Miller").
card(song_titles, "Chattanoogie Shoe-Shine Boy", "Red Foley").
card(song_titles, "Check On It", "Beyonce").
card(song_titles, "Cheek to Cheek", "Fred Astaire").
card(song_titles, "Cherish", "Association").
card(song_titles, "Cherry Pink & Apple Blossom White", "Perez Prado").
card(song_titles, "Cold, Cold Heart", "Tony Bennett").
card(song_titles, "Colors of the Wind", "Vanessa Williams").
card(song_titles, "Come On Eileen", "Dexys Midnight Runners").
card(song_titles, "Come On-a My House", "Rosemary Clooney").
card(song_titles, "Come Together", "The Beatles").
card(song_titles, "Coming Up", "Paul McCartney").
card(song_titles, "Cracklin' Rosie", "Neil Diamond").
card(song_titles, "Crazy For You", "Madonna").
card(song_titles, "Crazy Little Thing Called Love", "Queen").
card(song_titles, "Crazy in Love", "Beyonce").
card(song_titles, "Crazy", "Gnarls Barkley; Patsy Cline").
card(song_titles, "Creep", "TLC").
card(song_titles, "Crimson & Clover", "Tommy James & the Shondells").
card(song_titles, "Crocodile Rock", "Elton John").
card(song_titles, "Cry Like a Baby", "The Box Tops").
card(song_titles, "Cry", "Johnnie Ray").
card(song_titles, "Crying", "Roy Orbison").
card(song_titles, "Da Doo Ron Ron (When He Walked Me Home)", "The Crystals").
card(song_titles, "Dance to the Music", "Sly & The Family Stone").
card(song_titles, "Dancing Queen", "Abba").
card(song_titles, "Dancing in the Dark", "Bruce Springsteen").
card(song_titles, "Dancing in the Street", "Martha & The Vandellas").
card(song_titles, "Dardanella", "Ben Selvin").
card(song_titles, "Daydream Believer", "The Monkees").
card(song_titles, "December 1963 (Oh What a Night)", "The Four Seasons").
card(song_titles, "Delicado", "Percy Faith").
card(song_titles, "Dilemma", "Nelly & Kelly Rowland").
card(song_titles, "Disco Duck", "Rick Dees & his Cast of Idiots").
card(song_titles, "Disco Lady", "Johnnie Taylor").
card(song_titles, "Disturbia", "Rihanna").
card(song_titles, "Dizzy", "Tommy Roe").
card(song_titles, "Do That to Me One More Time", "Captain & Tennille").
card(song_titles, "Do Wah Diddy Diddy", "Manfred Mann").
card(song_titles, "Do Ya Think I'm Sexy?", "Rod Stewart").
card(song_titles, "Do You Love Me?", "Contours").
card(song_titles, "Don't Be Cruel", "Elvis Presley").
card(song_titles, "Don't Fence Me In", "Bing Crosby & The Andrews Sisters").
card(song_titles, "Don't Go Breaking My Heart", "Elton John & Kiki Dee").
card(song_titles, "Don't Leave Me This Way", "Thelma Houston").
card(song_titles, "Don't Let the Stars Get in Your Eyes", "Perry Como").
card(song_titles, "Don't Let the Sun Go Down On Me", "Elton John").
card(song_titles, "Don't Speak", "No Doubt").
card(song_titles, "Don't Stop 'Til You Get Enough", "Michael Jackson").
card(song_titles, "Don't Worry Be Happy", "Bobby McFerrin").
card(song_titles, "Don't You (Forget About Me)", "Simple Minds").
card(song_titles, "Don't You Want Me", "The Human League").
card(song_titles, "Doo Wop (That Thing)", "Lauryn Hill").
card(song_titles, "Down Hearted Blues", "Bessie Smith").
card(song_titles, "Down Under", "Men At Work").
card(song_titles, "Down", "Jay Sean & Lil' Wayne").
card(song_titles, "Downtown", "Petula Clark").
card(song_titles, "Dreamlover", "Mariah Carey").
card(song_titles, "Dreams", "Fleetwood Mac").
card(song_titles, "Drop it Like It's Hot", "Snoop Dogg & Pharrell Williams").
card(song_titles, "Drops of Jupiter (Tell Me)", "Train").
card(song_titles, "Duke of Earl", "Gene Chandler").
card(song_titles, "E.T.", "Katy Perry & Kanye West").
card(song_titles, "Earth Angel", "The Penguins").
card(song_titles, "Ebony & Ivory", "Paul McCartney & Stevie Wonder").
card(song_titles, "Eight Days a Week", "The Beatles").
card(song_titles, "Empire State Of Mind", "Jay-Z & Alicia Keys").
card(song_titles, "End of the Road", "Boyz II Men").
card(song_titles, "Endless Love", "Diana Ross & Lionel Richie").
card(song_titles, "Escape (The Pina Colada Song)", "Rupert Holmes").
card(song_titles, "Eve of Destruction", "Barry McGuire").
card(song_titles, "Every Breath You Take", "The Police").
card(song_titles, "Every Little Thing She Does is Magic", "The Police").
card(song_titles, "Everybody Loves Somebody", "Dean Martin").
card(song_titles, "Everybody Wants to Rule the World", "Tears For Fears").
card(song_titles, "Everyday People", "Sly & The Family Stone").
card(song_titles, "Eye of the Tiger", "Survivor").
card(song_titles, "Faith", "George Michael").
card(song_titles, "Fallin'", "Alicia Keys").
card(song_titles, "Fame", "David Bowie; Irene Cara").
card(song_titles, "Family Affair", "Mary J Blige; Sly & The Family Stone").
card(song_titles, "Fantasy", "Mariah Carey").
card(song_titles, "Fast Car", "Tracy Chapman").
card(song_titles, "Feel Good Inc", "Gorillaz").
card(song_titles, "Feel Like Making Love", "Roberta Flack").
card(song_titles, "Fire & Rain", "James Taylor").
card(song_titles, "Firework", "Katy Perry").
card(song_titles, "Flashdance... What a Feeling", "Irene Cara").
card(song_titles, "Fly Robin Fly", "Silver Convention").
card(song_titles, "Foolish Games", "Jewel").
card(song_titles, "Footloose", "Kenny Loggins").
card(song_titles, "For What It's Worth (Stop, Hey What's That Sound)", "Buffalo Springfield").
card(song_titles, "Fortunate Son", "Creedence Clearwater Revival").
card(song_titles, "Frankenstein", "Edgar Winter Group").
card(song_titles, "Freak Me", "Silk").
card(song_titles, "Freebird", "Lynyrd Skynyrd").
card(song_titles, "Frenesi", "Artie Shaw").
card(song_titles, "Funkytown", "Lipps Inc").
card(song_titles, "Gangsta's Paradise", "Coolio").
card(song_titles, "Georgia On My Mind", "Ray Charles").
card(song_titles, "Georgy Girl", "The Seekers").
card(song_titles, "Get Back", "The Beatles").
card(song_titles, "Get Down Tonight", "KC & The Sunshine Band").
card(song_titles, "Get Off of My Cloud", "The Rolling Stones").
card(song_titles, "Ghostbusters", "Ray Parker Jr").
card(song_titles, "Gimme Some Lovin'", "Spencer Davis Group").
card(song_titles, "Girls Just Wanna Have Fun", "Cyndi Lauper").
card(song_titles, "Give Me Everything", "Pitbull, Ne-Yo, Afrojack & Nayer").
card(song_titles, "Gives You Hell", "All-American Rejects").
card(song_titles, "Glamorous", "Fergie & Ludacris").
card(song_titles, "Glory of Love", "Peter Cetera").
card(song_titles, "Go Your Own Way", "Fleetwood Mac").
card(song_titles, "God Bless America", "Kate Smith").
card(song_titles, "God Bless the Child", "Billie Holiday").
card(song_titles, "Gold Digger", "Kanye West & Jamie Foxx").
card(song_titles, "Gonna Make You Sweat (Everybody Dance Now)", "C&C Music Factory").
card(song_titles, "Good Lovin'", "The Young Rascals").
card(song_titles, "Good Times", "Chic").
card(song_titles, "Good Vibrations", "The Beach Boys").
card(song_titles, "Goodbye Yellow Brick Road", "Elton John").
card(song_titles, "Goodnight, Irene", "Gordon Jenkins & The Weavers").
card(song_titles, "Got to Give it Up", "Marvin Gaye").
card(song_titles, "Grease", "Frankie Valli").
card(song_titles, "Great Balls of Fire", "Jerry Lee Lewis").
card(song_titles, "Greatest Love of All", "Whitney Houston").
card(song_titles, "Green Onions", "Booker T & the MGs").
card(song_titles, "Green River", "Creedence Clearwater Revival").
card(song_titles, "Green Tambourine", "The Lemon Pipers").
card(song_titles, "Grenade", "Bruno Mars").
card(song_titles, "Groove is in the Heart", "Deee-Lite").
card(song_titles, "Groovin'", "The Young Rascals").
card(song_titles, "Gypsies, Tramps & Thieves", "Cher").
card(song_titles, "Hair", "The Cowsills").
card(song_titles, "Hang On Sloopy", "The McCoys").
card(song_titles, "Hanging by a Moment", "Lifehouse").
card(song_titles, "Hanky Panky", "Tommy James & the Shondells").
card(song_titles, "Happy Days Are Here Again", "Ben Selvin").
card(song_titles, "Happy Together", "The Turtles").
card(song_titles, "Harbour Lights", "Sammy Kaye").
card(song_titles, "Hard to Say I'm Sorry", "Chicago").
card(song_titles, "Harper Valley PTA", "Jeannie C Riley").
card(song_titles, "Have You Ever Really Loved a Woman?", "Bryan Adams").
card(song_titles, "He'll Have to Go", "Jim Reeves").
card(song_titles, "He's So Fine", "The Chiffons").
card(song_titles, "He's a Rebel", "The Crystals").
card(song_titles, "Heart of Glass", "Blondie").
card(song_titles, "Heart of Gold", "Neil Young").
card(song_titles, "Heartbreak Hotel", "Elvis Presley").
card(song_titles, "Hello Dolly", "Louis Armstrong").
card(song_titles, "Hello, I Love You, Won't You Tell Me Your Name?", "The Doors").
card(song_titles, "Help Me, Rhonda", "The Beach Boys").
card(song_titles, "Help!", "The Beatles").
card(song_titles, "Here Without You", "Three Doors Down").
card(song_titles, "Here in My Heart", "Al Martino").
card(song_titles, "Hero", "Mariah Carey").
card(song_titles, "Hey Baby", "Bruce Channel").
card(song_titles, "Hey Jude", "The Beatles").
card(song_titles, "Hey Paula", "Paul & Paula").
card(song_titles, "Hey There Delilah", "Plain White T's").
card(song_titles, "Hey There", "Rosemary Clooney").
card(song_titles, "Hey Ya!", "OutKast").
card(song_titles, "Higher Love", "Steve Winwood").
card(song_titles, "Hips don't lie", "Shakira & Wyclef Jean").
card(song_titles, "Hit the Road, Jack", "Ray Charles").
card(song_titles, "Hold On", "Wilson Phillips").
card(song_titles, "Hollaback Girl", "Gwen Stefani").
card(song_titles, "Honey", "Bobby Goldsboro").
card(song_titles, "Honky Tonk Woman", "The Rolling Stones").
card(song_titles, "Honky Tonk", "Bill Doggett").
card(song_titles, "Horse With No Name", "America").
card(song_titles, "Hot Child In The City", "Nick Gilder").
card(song_titles, "Hot Stuff", "Donna Summer").
card(song_titles, "Hotel California", "Eagles").
card(song_titles, "Hound Dog", "Elvis Presley").
card(song_titles, "House of the Rising Sun", "The Animals").
card(song_titles, "How Deep is Your Love?", "Bee Gees").
card(song_titles, "How Do I Live?", "LeAnn Rimes").
card(song_titles, "How Do You Mend a Broken Heart", "Bee Gees").
card(song_titles, "How High the Moon", "Les Paul & Mary Ford").
card(song_titles, "How Much is That Doggy in the Window?", "Patti Page").
card(song_titles, "How Will I Know", "Whitney Houston").
card(song_titles, "How You Remind Me", "Nickelback").
card(song_titles, "How to Save a Life", "The Fray").
card(song_titles, "Hungry Heart", "Bruce Springsteen").
card(song_titles, "Hurt So Good", "John Cougar Mellencamp").
card(song_titles, "I Believe I Can Fly", "R Kelly").
card(song_titles, "I Can Dream, Can't I?", "The Andrews Sisters").
card(song_titles, "I Can Help", "Billy Swan").
card(song_titles, "I Can See Clearly Now", "Johnny Nash").
card(song_titles, "I Can't Get Next to You", "The Temptations").
card(song_titles, "I Can't Get Started", "Bunny Berigan").
card(song_titles, "I Can't Go For That (No Can Do)", "Hall & Oates").
card(song_titles, "I Can't Help Myself (Sugar Pie, Honey Bunch)", "The Four Tops").
card(song_titles, "I Can't Stop Loving You", "Ray Charles").
card(song_titles, "I Don't Want to Miss a Thing", "Aerosmith").
card(song_titles, "I Fall to Pieces", "Patsy Cline").
card(song_titles, "I Feel Fine", "The Beatles").
card(song_titles, "I Feel For You", "Chaka Khan").
card(song_titles, "I Feel Love", "Donna Summer").
card(song_titles, "I Get Around", "The Beach Boys").
card(song_titles, "I Got You (I Feel Good)", "James Brown").
card(song_titles, "I Got You Babe", "Sonny & Cher").
card(song_titles, "I Gotta Feeling", "The Black Eyed Peas").
card(song_titles, "I Heard it Through the Grapevine", "Marvin Gaye").
card(song_titles, "I Honestly Love You", "Olivia Newton-John").
card(song_titles, "I Just Called to Say I Love You", "Stevie Wonder").
card(song_titles, "I Just Wanna Be Your Everything", "Andy Gibb").
card(song_titles, "I Kissed A Girl", "Katy Perry").
card(song_titles, "I Love Rock 'n' Roll", "Joan Jett & The Blackhearts").
card(song_titles, "I Need You Now", "Eddie Fisher").
card(song_titles, "I Only Have Eyes For You", "The Flamingos").
card(song_titles, "I Shot the Sheriff", "Eric Clapton").
card(song_titles, "I Still Haven't Found What I'm Looking For", "U2").
card(song_titles, "I Swear", "All-4-One").
card(song_titles, "I Think I Love You", "The Partridge Family").
card(song_titles, "I Walk the Line", "Johnny Cash").
card(song_titles, "I Wanna Dance With Somebody (Who Loves Me)", "Whitney Houston").
card(song_titles, "I Wanna Love You", "Akon & Snoop Dogg").
card(song_titles, "I Want You Back", "The Jackson 5").
card(song_titles, "I Want to Hold Your Hand", "The Beatles").
card(song_titles, "I Want to Know What Love Is", "Foreigner").
card(song_titles, "I Went to Your Wedding", "Patti Page").
card(song_titles, "I Will Always Love You", "Whitney Houston").
card(song_titles, "I Will Follow Him", "Little Peggy March").
card(song_titles, "I Will Survive", "Gloria Gaynor").
card(song_titles, "I Write the Songs", "Barry Manilow").
card(song_titles, "I'll Be Missing You", "P Diddy & Faith Evans").
card(song_titles, "I'll Be There", "The Jackson 5").
card(song_titles, "I'll Make Love to You", "Boyz II Men").
card(song_titles, "I'll Never Smile Again", "Tommy Dorsey & Frank Sinatra").
card(song_titles, "I'll Take You There", "The Staple Singers").
card(song_titles, "I'll Walk Alone", "Dinah Shore").
card(song_titles, "I'll be seeing you", "Bing Crosby").
card(song_titles, "I'm Looking Over a Four Leaf Clover", "Art Mooney").
card(song_titles, "I'm So Lonesome I Could Cry", "Hank Williams").
card(song_titles, "I'm Sorry", "Brenda Lee").
card(song_titles, "I'm Walking Behind You", "Eddie Fisher").
card(song_titles, "I'm Your Boogie Man", "KC & The Sunshine Band").
card(song_titles, "I'm Yours", "Jason Mraz").
card(song_titles, "I'm a Believer", "The Monkees").
card(song_titles, "I've Heard That Song Before", "Harry James").
card(song_titles, "If (They Made Me a King)", "Perry Como").
card(song_titles, "If I Didn't Care", "The Ink Spots").
card(song_titles, "If You Don't Know Me By Now", "Harold Melvin & The Bluenotes").
card(song_titles, "If You Leave Me Now", "Chicago").
card(song_titles, "Imagine", "John Lennon").
card(song_titles, "In Da Club", "50 Cent").
card(song_titles, "In the End", "Linkin Park").
card(song_titles, "In the Ghetto", "Elvis Presley").
card(song_titles, "In the Mood", "Glenn Miller").
card(song_titles, "In the Summertime", "Mungo Jerry").
card(song_titles, "In the Year 2525 (Exordium & Terminus)", "Zager & Evans").
card(song_titles, "Incense & Peppermints", "Strawberry Alarm Clock").
card(song_titles, "Indian Reservation (The Lament Of The Cherokee Reservation Indian)", "Paul Revere & the Raiders").
card(song_titles, "Instant Karma", "John Lennon").
card(song_titles, "Iris", "The Goo Goo Dolls").
card(song_titles, "Ironic", "Alanis Morissette").
card(song_titles, "Irreplaceable", "Beyonce").
card(song_titles, "It Had to Be You", "Isham Jones").
card(song_titles, "It's All in the Game", "Tommy Edwards").
card(song_titles, "It's My Party", "Lesley Gore").
card(song_titles, "It's Now Or Never", "Elvis Presley").
card(song_titles, "It's Still Rock 'n' Roll to Me", "Billy Joel").
card(song_titles, "It's Too Late", "Carole King").
card(song_titles, "Jack & Diane", "John Cougar Mellencamp").
card(song_titles, "Jailhouse Rock", "Elvis Presley").
card(song_titles, "Jessie's Girl", "Rick Springfield").
card(song_titles, "Jive Talkin'", "Bee Gees").
card(song_titles, "Johnny B Goode", "Chuck Berry").
card(song_titles, "Joy to the World", "Three Dog Night").
card(song_titles, "Judy in Disguise (With Glasses)", "John Fred & The Playboy Band").
card(song_titles, "Jump", "Kris Kross; Van Halen").
card(song_titles, "Jumpin' Jack Flash", "The Rolling Stones").
card(song_titles, "Just Dance", "Lady GaGa & Colby O'Donis").
card(song_titles, "Just My Imagination (Running Away With Me)", "The Temptations").
card(song_titles, "Just the Way You Are", "Billy Joel; Bruno Mars").
card(song_titles, "Kansas City", "Wilbert Harrison").
card(song_titles, "Karma Chameleon", "Culture Club").
card(song_titles, "Keep On Loving You", "REO Speedwagon").
card(song_titles, "Killing Me Softly With His Song", "Roberta Flack").
card(song_titles, "King of the Road", "Roger Miller").
card(song_titles, "Kiss & Say Goodbye", "The Manhattans").
card(song_titles, "Kiss From a Rose", "Seal").
card(song_titles, "Kiss Me", "Sixpence None The Richer").
card(song_titles, "Kiss On My List", "Hall & Oates").
card(song_titles, "Kiss You All Over", "Exile").
card(song_titles, "Kiss", "Prince").
card(song_titles, "Knock On Wood", "Amii Stewart").
card(song_titles, "Knock Three Times", "Tony Orlando & Dawn").
card(song_titles, "Kokomo", "The Beach Boys").
card(song_titles, "Kryptonite", "Three Doors Down").
card(song_titles, "Kung Fu Fighting", "Carl Douglas").
card(song_titles, "La Bamba", "Los Lobos; Ritchie Valens").
card(song_titles, "Lady Marmalade (Voulez-Vous Coucher Aver Moi Ce Soir?)", "Christina Aguilera, Lil' Kim, Mya & Pink; Patti LaBelle").
card(song_titles, "Lady", "Kenny Rogers").
card(song_titles, "Last Train to Clarksville", "The Monkees").
card(song_titles, "Layla", "Derek & The Dominos").
card(song_titles, "Le Freak", "Chic").
card(song_titles, "Leader of the Pack", "The Shangri-Las").
card(song_titles, "Lean On Me", "Bill Withers").
card(song_titles, "Leaving, on a Jet Plane", "Peter, Paul & Mary").
card(song_titles, "Let Me Call You Sweetheart", "Peerless Quartet").
card(song_titles, "Let Me Love You", "Mario").
card(song_titles, "Let it Be", "The Beatles").
card(song_titles, "Let it Snow! Let it Snow! Let it Snow!", "Vaughn Monroe").
card(song_titles, "Let's Dance", "David Bowie").
card(song_titles, "Let's Get it On", "Marvin Gaye").
card(song_titles, "Let's Groove", "Earth, Wind & Fire").
card(song_titles, "Let's Hear it For the Boy", "Deniece Williams").
card(song_titles, "Let's Stay Together", "Al Green").
card(song_titles, "Light My Fire", "The Doors").
card(song_titles, "Lights", "Ellie Goulding").
card(song_titles, "Like a Prayer", "Madonna").
card(song_titles, "Like a Rolling Stone", "Bob Dylan").
card(song_titles, "Like a Virgin", "Madonna").
card(song_titles, "Little Darlin'", "The Diamonds").
card(song_titles, "Little Things Mean a Lot", "Kitty Kallen").
card(song_titles, "Live & Let Die", "Wings").
card(song_titles, "Livin' La Vida Loca", "Ricky Martin").
card(song_titles, "Livin' On a Prayer", "Bon Jovi").
card(song_titles, "Living For the City", "Stevie Wonder").
card(song_titles, "Locked Out Of Heaven", "Bruno Mars").
card(song_titles, "Lola", "The Kinks").
card(song_titles, "Lonely Boy", "Paul Anka").
card(song_titles, "Long Cool Woman in a Black Dress", "The Hollies").
card(song_titles, "Long Tall Sally", "Little Richard").
card(song_titles, "Look Away", "Chicago").
card(song_titles, "Lookin' Out My Back Door", "Creedence Clearwater Revival").
card(song_titles, "Lose Yourself", "Eminem").
card(song_titles, "Losing My Religion", "REM").
card(song_titles, "Louie Louie", "Kingsmen").
card(song_titles, "Love Child", "Diana Ross & The Supremes").
card(song_titles, "Love Hangover", "Diana Ross").
card(song_titles, "Love In This Club", "Usher & Young Jeezy").
card(song_titles, "Love Is Blue (L'Amour Est Bleu)", "Paul Mauriat & his Orchestra").
card(song_titles, "Love Letters in the Sand", "Pat Boone").
card(song_titles, "Love Me Do", "The Beatles").
card(song_titles, "Love Me Tender", "Elvis Presley").
card(song_titles, "Love Shack", "The B52s").
card(song_titles, "Love Theme From 'A Star is Born' (Evergreen)", "Barbra Streisand").
card(song_titles, "Love Train", "The O'Jays").
card(song_titles, "Love Will Keep Us Together", "Captain & Tennille").
card(song_titles, "Love is a Many Splendoured Thing", "Four Aces").
card(song_titles, "Love to Love You Baby", "Donna Summer").
card(song_titles, "Love's Theme", "Love Unlimited").
card(song_titles, "Loving You", "Minnie Riperton").
card(song_titles, "Low", "Flo-Rida & T-Pain").
card(song_titles, "Macarena", "Los Del Rio").
card(song_titles, "Mack the Knife", "Bobby Darin").
card(song_titles, "Maggie May", "Rod Stewart").
card(song_titles, "Magic Carpet Ride", "Steppenwolf").
card(song_titles, "Magic", "Olivia Newton-John").
card(song_titles, "Make Love to Me", "Jo Stafford").
card(song_titles, "Make it With You", "Bread").
card(song_titles, "Makin' Whoopee", "Eddie Cantor").
card(song_titles, "Mama Told Me Not to Come", "Three Dog Night").
card(song_titles, "Man in the Mirror", "Michael Jackson").
card(song_titles, "Manana (Is Soon Enough For Me)", "Peggy Lee").
card(song_titles, "Maneater", "Hall & Oates").
card(song_titles, "Maniac", "Michael Sembello").
card(song_titles, "Maybellene", "Chuck Berry").
card(song_titles, "Me & Bobby McGee", "Janis Joplin").
card(song_titles, "Me & Mrs Jones", "Billy Paul").
card(song_titles, "Memories Are Made of This", "Dean Martin").
card(song_titles, "Mercy Mercy Me (The Ecology)", "Marvin Gaye").
card(song_titles, "Mickey", "Toni Basil").
card(song_titles, "Midnight Train to Georgia", "Gladys Knight & The Pips").
card(song_titles, "Minnie the Moocher", "Cab Calloway & his Cotton Club Orchestra").
card(song_titles, "Miss You Much", "Janet Jackson").
card(song_titles, "Miss You", "The Rolling Stones").
card(song_titles, "Mister Sandman", "The Chordettes").
card(song_titles, "Mmmbop", "Hanson").
card(song_titles, "Mona Lisa", "Nat King Cole").
card(song_titles, "Monday Monday", "The Mamas & The Papas").
card(song_titles, "Money For Nothing", "Dire Straits").
card(song_titles, "Mony Mony", "Tommy James & the Shondells").
card(song_titles, "Mood Indigo", "Duke Ellington").
card(song_titles, "Moonlight Cocktail", "Glenn Miller").
card(song_titles, "Moonlight Serenade", "Glenn Miller").
card(song_titles, "More Than Words", "Extreme").
card(song_titles, "More Than a Feeling", "Boston").
card(song_titles, "Morning Train (Nine to Five)", "Sheena Easton").
card(song_titles, "Mr Big Stuff", "Jean Knight").
card(song_titles, "Mr Brightside", "The Killers").
card(song_titles, "Mr Tambourine Man", "The Byrds").
card(song_titles, "Mrs Brown You've Got a Lovely Daughter", "Herman's Hermits").
card(song_titles, "Mrs Robinson", "Simon & Garfunkel").
card(song_titles, "Mule Train", "Frankie Laine").
card(song_titles, "Music", "Madonna").
card(song_titles, "My Blue Heaven", "Gene Austin").
card(song_titles, "My Boyfriend's Back", "The Angels").
card(song_titles, "My Eyes Adored You", "Frankie Valli").
card(song_titles, "My Girl", "The Temptations").
card(song_titles, "My Guy", "Mary Wells").
card(song_titles, "My Heart Will Go On", "Celine Dion").
card(song_titles, "My Life", "Billy Joel").
card(song_titles, "My Love", "Justin Timberlake; Wings").
card(song_titles, "My Man", "Fanny Brice").
card(song_titles, "My Prayer", "The Platters").
card(song_titles, "My Sharona", "The Knack").
card(song_titles, "My Sweet Lord", "George Harrison").
card(song_titles, "Na Na Hey Hey (Kiss Him Goodbye)", "Steam").
card(song_titles, "Nature Boy", "Nat King Cole").
card(song_titles, "Near You", "Francis Craig").
card(song_titles, "Need You Now", "Lady Antebellum").
card(song_titles, "Need You Tonight", "INXS").
card(song_titles, "Never Gonna Give You Up", "Rick Astley").
card(song_titles, "Night & Day", "Fred Astaire & Leo Reisman").
card(song_titles, "Night Fever", "Bee Gees").
card(song_titles, "Nights in White Satin", "The Moody Blues").
card(song_titles, "No One", "Alicia Keys").
card(song_titles, "No Scrubs", "TLC").
card(song_titles, "Nobody Does it Better", "Carly Simon").
card(song_titles, "Nothin' on You", "BoB & Bruno Mars").
card(song_titles, "Nothing Compares 2 U", "Sinead O'Connor").
card(song_titles, "Nothing's Gonna Stop Us Now", "Jefferson Starship").
card(song_titles, "Ode To Billie Joe", "Bobbie Gentry").
card(song_titles, "Oh Happy Day", "Edwin Hawkins Singers").
card(song_titles, "Oh My Papa (O Mein Papa)", "Eddie Fisher").
card(song_titles, "Oh, Pretty Woman", "Roy Orbison").
card(song_titles, "Ol' Man River", "Paul Robeson").
card(song_titles, "Ole Buttermilk Sky", "Kay Kyser").
card(song_titles, "On Bended Knee", "Boyz II Men").
card(song_titles, "On My Own", "Patti LaBelle & Michael McDonald").
card(song_titles, "On the Atchison, Topeka & the Santa Fe", "Johnny Mercer").
card(song_titles, "One Bad Apple", "The Osmonds").
card(song_titles, "One More Try", "George Michael").
card(song_titles, "One O'Clock Jump", "Count Basie").
card(song_titles, "One Sweet Day", "Mariah Carey & Boyz II Men").
card(song_titles, "One of These Nights", "Eagles").
card(song_titles, "One of Us", "Joan Osborne").
card(song_titles, "One", "U2").
card(song_titles, "Only The Lonely (Know The Way I Feel)", "Roy Orbison").
card(song_titles, "Only You (And You Alone)", "The Platters").
card(song_titles, "Open Arms", "Journey").
card(song_titles, "Over There", "American Quartet").
card(song_titles, "Over the Rainbow", "Judy Garland").
card(song_titles, "Paint it Black", "The Rolling Stones").
card(song_titles, "Papa Don't Preach", "Madonna").
card(song_titles, "Papa Was a Rolling Stone", "The Temptations").
card(song_titles, "Papa's Got a Brand New Bag", "James Brown").
card(song_titles, "Paper Doll", "The Mills Brothers").
card(song_titles, "Paper Planes", "MIA").
card(song_titles, "Paperback Writer", "The Beatles").
card(song_titles, "Party Rock Anthem", "LMFAO").
card(song_titles, "Peg o' My Heart", "Jerry Murad's Harmonicats").
card(song_titles, "Peggy Sue", "Buddy Holly").
card(song_titles, "Pennies From Heaven", "Bing Crosby").
card(song_titles, "Penny Lane", "The Beatles").
card(song_titles, "People Got to Be Free", "The Young Rascals").
card(song_titles, "People", "Barbra Streisand").
card(song_titles, "Personality", "Johnny Mercer").
card(song_titles, "Philadelphia Freedom", "Elton John").
card(song_titles, "Physical", "Olivia Newton-John").
card(song_titles, "Piano Man", "Billy Joel").
card(song_titles, "Pick Up the Pieces", "Average White Band").
card(song_titles, "Pistol Packin' Mama", "Al Dexter & his Troopers").
card(song_titles, "Play That Funky Music", "Wild Cherry").
card(song_titles, "Please Mr Postman", "The Marvelettes").
card(song_titles, "Poker Face", "Lady GaGa").
card(song_titles, "Pon De Replay", "Rihanna").
card(song_titles, "Pony Time", "Chubby Checker").
card(song_titles, "Pop Muzik", "M").
card(song_titles, "Prisoner of Love", "Perry Como").
card(song_titles, "Private Eyes", "Hall & Oates").
card(song_titles, "Promiscuous", "Nelly Furtado & Timbaland").
card(song_titles, "Proud Mary", "Creedence Clearwater Revival").
card(song_titles, "Purple Haze", "Jimi Hendrix").
card(song_titles, "Purple Rain", "Prince").
card(song_titles, "Puttin' on the Ritz", "Harry Richman").
card(song_titles, "Que sera sera (Whatever will be will be)", "Doris Day").
card(song_titles, "Queen of Hearts", "Juice Newton").
card(song_titles, "Rag Doll", "The Four Seasons").
card(song_titles, "Rag Mop", "The Ames Brothers").
card(song_titles, "Rags to Riches", "Tony Bennett").
card(song_titles, "Raindrops Keep Falling On My Head", "B J Thomas").
card(song_titles, "Rapture", "Blondie").
card(song_titles, "Ray of Light", "Madonna").
card(song_titles, "Reach Out (I'll Be There)", "The Four Tops").
card(song_titles, "Red Red Wine", "UB40").
card(song_titles, "Rehab", "Amy Winehouse").
card(song_titles, "Respect", "Aretha Franklin").
card(song_titles, "Return to Sender", "Elvis Presley").
card(song_titles, "Reunited", "Peaches & Herb").
card(song_titles, "Revolution", "The Beatles").
card(song_titles, "Rhapsody in Blue", "George Gershwin").
card(song_titles, "Rhinestone Cowboy", "Glen Campbell").
card(song_titles, "Rich Girl", "Hall & Oates").
card(song_titles, "Riders On the Storm", "The Doors").
card(song_titles, "Right Back Where We Started From", "Maxine Nightingale").
card(song_titles, "Ring My Bell", "Anita Ward").
card(song_titles, "Ring of Fire", "Johnny Cash").
card(song_titles, "Rock Around the Clock", "Bill Haley & his Comets").
card(song_titles, "Rock With You", "Michael Jackson").
card(song_titles, "Rock Your Baby", "George McCrae").
card(song_titles, "Rock the Boat", "Hues Corporation").
card(song_titles, "Rock the Casbah", "The Clash").
card(song_titles, "Roll Over Beethoven", "Chuck Berry").
card(song_titles, "Roll With It", "Steve Winwood").
card(song_titles, "Rolling In The Deep", "Adele").
card(song_titles, "Rosanna", "Toto").
card(song_titles, "Roses Are Red", "Bobby Vinton").
card(song_titles, "Royals", "Lorde").
card(song_titles, "Ruby Tuesday", "The Rolling Stones").
card(song_titles, "Rudolph, the Red-Nosed Reindeer", "Gene Autry").
card(song_titles, "Rum & Coca-Cola", "The Andrews Sisters").
card(song_titles, "Runaround Sue", "Dion").
card(song_titles, "Runaway", "Del Shannon").
card(song_titles, "Running Scared", "Roy Orbison").
card(song_titles, "Rush Rush", "Paula Abdul").
card(song_titles, "Sailing", "Christopher Cross").
card(song_titles, "Save the Best For Last", "Vanessa Williams").
card(song_titles, "Save the Last Dance For Me", "The Drifters").
card(song_titles, "Say It Right", "Nelly Furtado").
card(song_titles, "Say My Name", "Destiny's Child").
card(song_titles, "Say Say Say", "Paul McCartney & Michael Jackson").
card(song_titles, "Say You, Say Me", "Lionel Richie").
card(song_titles, "School's Out", "Alice Cooper").
card(song_titles, "Seasons in the Sun", "Terry Jacks").
card(song_titles, "Secret Love", "Doris Day").
card(song_titles, "Sentimental Journey", "Les Brown & Doris Day").
card(song_titles, "Sexyback", "Justin Timberlake").
card(song_titles, "Sh-Boom (Life Could Be a Dream)", "The Crew-Cuts").
card(song_titles, "Shadow Dancing", "Andy Gibb").
card(song_titles, "Shake Down", "Bob Seger & The Silver Bullet Band").
card(song_titles, "Shake You Down", "Gregory Abbott").
card(song_titles, "She Drives Me Crazy", "Fine Young Cannibals").
card(song_titles, "She Loves You", "The Beatles").
card(song_titles, "She's a Lady", "Tom Jones").
card(song_titles, "Shining Star", "Earth, Wind & Fire").
card(song_titles, "Shop Around", "Smokey Robinson & The Miracles").
card(song_titles, "Shout", "Tears For Fears").
card(song_titles, "Silly Love Songs", "Wings").
card(song_titles, "Since U Been Gone", "Kelly Clarkson").
card(song_titles, "Sing, Sing, Sing (With A Swing)", "Benny Goodman").
card(song_titles, "Singing The Blues", "Guy Mitchell").
card(song_titles, "Single Ladies (Put A Ring On It)", "Beyonce").
card(song_titles, "Sir Duke", "Stevie Wonder").
card(song_titles, "Sixteen Tons", "Tennessee Ernie Ford").
card(song_titles, "Sledgehammer", "Peter Gabriel").
card(song_titles, "Sleep Walk", "Santo & Johnny").
card(song_titles, "Sleepy Lagoon", "Harry James").
card(song_titles, "Slow Poke", "Pee Wee King").
card(song_titles, "Smells Like Teen Spirit", "Nirvana").
card(song_titles, "Smoke Gets in Your Eyes", "Paul Whiteman").
card(song_titles, "Smoke On the Water", "Deep Purple").
card(song_titles, "Smoke! Smoke! Smoke! (That Cigarette)", "Tex Williams & The Western Caravan").
card(song_titles, "Smooth", "Rob Thomas & Santana").
card(song_titles, "So Much in Love", "The Tymes").
card(song_titles, "Soldier Boy", "The Shirelles").
card(song_titles, "Some Enchanted Evening", "Perry Como").
card(song_titles, "Some of These Days", "Sophie Tucker").
card(song_titles, "Somebody That I Used to Know", "Gotye & Kimbra").
card(song_titles, "Somebody to Love", "Jefferson Airplane").
card(song_titles, "Someday", "Mariah Carey").
card(song_titles, "Somethin' Stupid", "Nancy Sinatra & Frank Sinatra").
card(song_titles, "Something", "The Beatles").
card(song_titles, "Soul Man", "Sam & Dave").
card(song_titles, "Spanish Harlem", "Aretha Franklin").
card(song_titles, "Spill the Wine", "Eric Burdon & War").
card(song_titles, "Spinning Wheel", "Blood Sweat & Tears").
card(song_titles, "Spirit in the Sky", "Norman Greenbaum").
card(song_titles, "St George & the Dragonette", "Stan Freberg").
card(song_titles, "St Louis Blues", "Bessie Smith").
card(song_titles, "Stagger Lee", "Lloyd Price").
card(song_titles, "Stairway to Heaven", "Led Zeppelin").
card(song_titles, "Stand By Me", "Ben E King").
card(song_titles, "Stardust", "Artie Shaw; Hoagy Carmichael").
card(song_titles, "Stars & Stripes Forever", "Sousa's Band").
card(song_titles, "Stay (I Missed You)", "Lisa Loeb & Nine Stories").
card(song_titles, "Stayin' Alive", "Bee Gees").
card(song_titles, "Stop! in the Name of Love", "The Supremes").
card(song_titles, "Stormy Weather (Keeps Rainin' All the Time)", "Ethel Waters; Lena Horne").
card(song_titles, "Straight Up", "Paula Abdul").
card(song_titles, "Strange Fruit", "Billie Holiday").
card(song_titles, "Stranger On the Shore", "Mr Acker Bilk").
card(song_titles, "Strangers in the Night", "Frank Sinatra").
card(song_titles, "Strawberry Fields Forever", "The Beatles").
card(song_titles, "Streets of Philadelphia", "Bruce Springsteen").
card(song_titles, "Stronger", "Kanye West").
card(song_titles, "Stuck On You", "Elvis Presley").
card(song_titles, "Sugar Shack", "The Fireballs").
card(song_titles, "Sugar Sugar", "Archies").
card(song_titles, "Summer in the City", "Lovin' Spoonful").
card(song_titles, "Summertime Blues", "Eddie Cochran").
card(song_titles, "Sunday, Monday or Always", "Bing Crosby").
card(song_titles, "Sunshine Superman", "Donovan").
card(song_titles, "Sunshine of Your Love", "Cream").
card(song_titles, "Superstar", "Carpenters").
card(song_titles, "Superstition", "Stevie Wonder").
card(song_titles, "Surfin' USA", "The Beach Boys").
card(song_titles, "Suspicious Minds", "Elvis Presley").
card(song_titles, "Swanee", "Al Jolson").
card(song_titles, "Sweet Caroline (Good Times Never Seemed So Good)", "Neil Diamond").
card(song_titles, "Sweet Child O' Mine", "Guns n' Roses").
card(song_titles, "Sweet Dreams (Are Made of This)", "The Eurythmics").
card(song_titles, "Sweet Georgia Brown", "Ben Bernie").
card(song_titles, "Sweet Home Alabama", "Lynyrd Skynyrd").
card(song_titles, "Sweet Soul Music", "Arthur Conley").
card(song_titles, "Swinging On a Star", "Bing Crosby").
card(song_titles, "T For Texas (Blue Yodel No 1)", "Jimmie Rodgers").
card(song_titles, "TSOP (The Sound of Philadelphia)", "MFSB").
card(song_titles, "Take Me Home, Country Roads", "John Denver").
card(song_titles, "Take My Breath Away", "Berlin").
card(song_titles, "Take On Me", "A-Ha").
card(song_titles, "Take The 'A' Train", "Duke Ellington").
card(song_titles, "Take a Bow", "Madonna").
card(song_titles, "Tammy", "Debbie Reynolds").
card(song_titles, "Tangerine", "Jimmy Dorsey").
card(song_titles, "Tears in Heaven", "Eric Clapton").
card(song_titles, "Tears of a Clown", "Smokey Robinson").
card(song_titles, "Temperature", "Sean Paul").
card(song_titles, "Tennessee Waltz", "Patti Page").
card(song_titles, "Tequila", "Champs").
card(song_titles, "Tha Crossroads", "Bone Thugs-n-Harmony").
card(song_titles, "Thank You (Falettinme be Mice Elf Again)", "Sly & The Family Stone").
card(song_titles, "That Lucky Old Sun (Just Rolls Around Heaven All Day)", "Frankie Laine").
card(song_titles, "That Old Black Magic", "Glenn Miller").
card(song_titles, "That'll Be the Day", "Buddy Holly").
card(song_titles, "That's Amore", "Dean Martin").
card(song_titles, "That's What Friends Are For", "Dionne Warwick & Friends").
card(song_titles, "That's the Way (I Like It)", "KC & The Sunshine Band").
card(song_titles, "That's the Way Love Goes", "Janet Jackson").
card(song_titles, "The Boy is Mine", "Brandy & Monica").
card(song_titles, "The Boys of Summer", "Don Henley").
card(song_titles, "The Christmas Song (Chestnuts Roasting On An Open Fire)", "Nat King Cole").
card(song_titles, "The End of the World", "Skeeter Davis").
card(song_titles, "The First Time Ever I Saw Your Face", "Roberta Flack").
card(song_titles, "The Girl From Ipanema", "Stan Getz & Joao Gilberto").
card(song_titles, "The Glow-Worm", "The Mills Brothers").
card(song_titles, "The Great Pretender", "The Platters").
card(song_titles, "The Gypsy", "The Ink Spots").
card(song_titles, "The Hustle", "Van McCoy").
card(song_titles, "The Joker", "Steve Miller Band").
card(song_titles, "The Last Dance", "Donna Summer").
card(song_titles, "The Letter", "The Box Tops").
card(song_titles, "The Loco-Motion", "Grand Funk Railroad; Little Eva").
card(song_titles, "The Long & Winding Road", "The Beatles").
card(song_titles, "The Love You Save", "The Jackson 5").
card(song_titles, "The Morning After", "Maureen McGovern").
card(song_titles, "The Power of Love", "Huey Lewis & The News").
card(song_titles, "The Prisoner's Song", "Vernon Dalhart").
card(song_titles, "The Reason", "Hoobastank").
card(song_titles, "The Rose", "Bette Midler").
card(song_titles, "The Sign", "Ace of Base").
card(song_titles, "The Song From Moulin Rouge (Where Is Your Heart)", "Percy Faith").
card(song_titles, "The Sounds of Silence", "Simon & Garfunkel").
card(song_titles, "The Streak", "Ray Stevens").
card(song_titles, "The Sweet Escape", "Gwen Stefani & Akon").
card(song_titles, "The Thing", "Phil Harris").
card(song_titles, "The Tide is High", "Blondie").
card(song_titles, "The Tracks of My Tears", "The Miracles").
card(song_titles, "The Twist", "Chubby Checker").
card(song_titles, "The Wanderer", "Dion").
card(song_titles, "The Way We Were", "Barbra Streisand").
card(song_titles, "The Way You Look Tonight", "Fred Astaire").
card(song_titles, "The Way You Move", "OutKast").
card(song_titles, "Theme From 'A Summer Place'", "Percy Faith").
card(song_titles, "Theme From 'Greatest American Hero' (Believe It Or Not)", "Joey Scarbury").
card(song_titles, "Theme From 'Shaft'", "Isaac Hayes").
card(song_titles, "There goes my baby", "The Drifters").
card(song_titles, "These Boots Are Made For Walking", "Nancy Sinatra").
card(song_titles, "Third Man Theme", "Anton Karas").
card(song_titles, "This Diamond Ring", "Gary Lewis & The Playboys").
card(song_titles, "This Guy's in Love With You", "Herb Alpert").
card(song_titles, "This Land is Your Land", "Woody Guthrie").
card(song_titles, "This Love", "Maroon 5").
card(song_titles, "This Ole House", "Rosemary Clooney").
card(song_titles, "This Used to Be My Playground", "Madonna").
card(song_titles, "Three Coins in the Fountain", "Four Aces").
card(song_titles, "Three Times a Lady", "The Commodores").
card(song_titles, "Thrift Shop", "Macklemore & Ryan Lewis").
card(song_titles, "Thriller", "Michael Jackson").
card(song_titles, "Ticket to Ride", "The Beatles").
card(song_titles, "Tie a Yellow Ribbon 'round the Old Oak Tree", "Tony Orlando & Dawn").
card(song_titles, "Tiger Rag", "Original Dixieland Jazz Band").
card(song_titles, "Tighten Up", "Archie Bell & The Drells").
card(song_titles, "Tik-Toc", "Ke$ha").
card(song_titles, "Till I Waltz Again With You", "Teresa Brewer").
card(song_titles, "Till The End of Time", "Perry Como").
card(song_titles, "Time After Time", "Cyndi Lauper").
card(song_titles, "Time of the Season", "The Zombies").
card(song_titles, "To Sir, With Love", "Lulu").
card(song_titles, "Tom Dooley", "The Kingston Trio").
card(song_titles, "Tonight's the Night (Gonna Be Alright)", "Rod Stewart").
card(song_titles, "Too Close", "Next").
card(song_titles, "Too Young", "Nat King Cole").
card(song_titles, "Tossing & Turning", "Bobby Lewis").
card(song_titles, "Total Eclipse of the Heart", "Bonnie Tyler").
card(song_titles, "Touch Me", "The Doors").
card(song_titles, "Toxic", "Britney Spears").
card(song_titles, "Travellin' Band", "Creedence Clearwater Revival").
card(song_titles, "Travellin' Man", "Ricky Nelson").
card(song_titles, "Truly Madly Deeply", "Savage Garden").
card(song_titles, "Turn! Turn! Turn! (To Everything There is a Season)", "The Byrds").
card(song_titles, "Tutti Frutti", "Little Richard").
card(song_titles, "Twist & Shout", "The Beatles; The Isley Brothers").
card(song_titles, "Two Hearts", "Phil Collins").
card(song_titles, "U Can't Touch This", "MC Hammer").
card(song_titles, "U Got it Bad", "Usher").
card(song_titles, "Umbrella", "Rihanna & Jay-Z").
card(song_titles, "Un-Break My Heart", "Toni Braxton").
card(song_titles, "Unbelievable", "EMF").
card(song_titles, "Unchained Melody", "The Righteous Brothers").
card(song_titles, "Uncle Albert (Admiral Halsey)", "Wings").
card(song_titles, "Under the Boardwalk", "The Drifters").
card(song_titles, "Under the Bridge", "Red Hot Chili Peppers").
card(song_titles, "Unforgettable", "Nat King Cole").
card(song_titles, "Up Around the Bend", "Creedence Clearwater Revival").
card(song_titles, "Up Up & Away", "Fifth Dimension").
card(song_titles, "Up Where We Belong", "Joe Cocker & Jennifer Warnes").
card(song_titles, "Upside Down", "Diana Ross").
card(song_titles, "Use Somebody", "Kings of Leon").
card(song_titles, "Vaya Con Dios (may God Be With You)", "Les Paul & Mary Ford").
card(song_titles, "Venus", "Frankie Avalon; Shocking Blue").
card(song_titles, "Vision of Love", "Mariah Carey").
card(song_titles, "Viva La Vida", "Coldplay").
card(song_titles, "Vogue", "Madonna").
card(song_titles, "Volare", "Domenico Modugno").
card(song_titles, "Wabash Cannonball", "Roy Acuff").
card(song_titles, "Waiting For a Girl Like You", "Foreigner").
card(song_titles, "Wake Me Up Before You Go Go", "Wham!").
card(song_titles, "Wake Up Little Susie", "The Everly Brothers").
card(song_titles, "Walk Don't Run", "The Ventures").
card(song_titles, "Walk Like a Man", "The Four Seasons").
card(song_titles, "Walk Like an Egyptian", "The Bangles").
card(song_titles, "Walk On By", "Dionne Warwick").
card(song_titles, "Walk On the Wild Side", "Lou Reed").
card(song_titles, "Walk This Way", "Run DMC & Aerosmith").
card(song_titles, "Wannabe", "Spice Girls").
card(song_titles, "Want Ads", "Honey Cone").
card(song_titles, "Wanted", "Perry Como").
card(song_titles, "War", "Edwin Starr").
card(song_titles, "Waterfalls", "TLC").
card(song_titles, "Wayward Wind", "Gogi Grant").
card(song_titles, "We Are Family", "Sister Sledge").
card(song_titles, "We Are Young", "fun.").
card(song_titles, "We Are the Champions", "Queen").
card(song_titles, "We Are the World", "USA For Africa").
card(song_titles, "We Belong Together", "Mariah Carey").
card(song_titles, "We Built This City", "Jefferson Starship").
card(song_titles, "We Can Work it Out", "The Beatles").
card(song_titles, "We Didn't Start the Fire", "Billy Joel").
card(song_titles, "We Found Love", "Rihanna & Calvin Harris").
card(song_titles, "We Got The Beat", "The Go Gos").
card(song_titles, "We Will Rock You", "Queen").
card(song_titles, "We've Only Just Begun", "Carpenters").
card(song_titles, "Weak", "SWV").
card(song_titles, "Wedding Bell Blues", "Fifth Dimension").
card(song_titles, "West End Blues", "Louis Armstrong").
card(song_titles, "West End Girls", "The Pet Shop Boys").
card(song_titles, "What Goes Around Comes Around", "Justin Timberlake").
card(song_titles, "What a Fool Believes", "The Doobie Brothers").
card(song_titles, "What'd I Say", "Ray Charles").
card(song_titles, "What's Going On?", "Marvin Gaye").
card(song_titles, "What's Love Got to Do With It?", "Tina Turner").
card(song_titles, "Whatcha Say", "Jason Derulo").
card(song_titles, "Wheel of Fortune", "Kay Starr").
card(song_titles, "When Doves Cry", "Prince").
card(song_titles, "When You Wish Upon a Star", "Cliff Edwards (Ukelele Ike)").
card(song_titles, "When a Man Loves a Woman", "Percy Sledge").
card(song_titles, "Where Did Our Love Go", "The Supremes").
card(song_titles, "Where is the Love?", "The Black Eyed Peas").
card(song_titles, "Whip It", "Devo").
card(song_titles, "Whispering", "Paul Whiteman").
card(song_titles, "White Christmas", "Bing Crosby").
card(song_titles, "White Rabbit", "Jefferson Airplane").
card(song_titles, "Whole Lotta Love", "Led Zeppelin").
card(song_titles, "Whole Lotta Shakin' Goin' On", "Jerry Lee Lewis").
card(song_titles, "Whoomp! (There it Is)", "Tag Team").
card(song_titles, "Why Do Fools Fall in Love?", "Frankie Lymon & The Teenagers").
card(song_titles, "Why Don't You Believe Me?", "Joni James").
card(song_titles, "Wichita Lineman", "Glen Campbell").
card(song_titles, "Wicked Game", "Chris Isaak").
card(song_titles, "Wild Thing", "The Troggs; Tone Loc").
card(song_titles, "Wild Wild West", "The Escape Club").
card(song_titles, "Will It Go Round In Circles", "Billy Preston").
card(song_titles, "Will You Love Me Tomorrow", "The Shirelles").
card(song_titles, "Winchester Cathedral", "New Vaudeville Band").
card(song_titles, "Wind Beneath My Wings", "Bette Midler").
card(song_titles, "Wipe Out", "The Surfaris").
card(song_titles, "Wishing Well", "Terence Trent D'Arby").
card(song_titles, "With Or Without You", "U2").
card(song_titles, "Without Me", "Eminem").
card(song_titles, "Without You", "Harry Nilsson").
card(song_titles, "Woman", "John Lennon").
card(song_titles, "Won't Get Fooled Again", "The Who").
card(song_titles, "Wooly Bully", "Sam The Sham & The Pharaohs").
card(song_titles, "Working My Way Back to You", "The Detroit Spinners").
card(song_titles, "YMCA", "The Village People").
card(song_titles, "Yakety Yak", "The Coasters").
card(song_titles, "Yeah!", "Usher").
card(song_titles, "Yellow Rose of Texas", "Mitch Miller").
card(song_titles, "Yesterday", "The Beatles").
card(song_titles, "You Ain't Seen Nothin' Yet", "Bachman-Turner Overdrive").
card(song_titles, "You Always Hurt the One You Love", "The Mills Brothers").
card(song_titles, "You Are the Sunshine of My Life", "Stevie Wonder").
card(song_titles, "You Belong With Me", "Taylor Swift").
card(song_titles, "You Belong to Me", "Jo Stafford").
card(song_titles, "You Can't Hurry Love", "The Supremes").
card(song_titles, "You Don't Bring Me Flowers", "Barbra Streisand & Neil Diamond").
card(song_titles, "You Don't Have to Be a Star (To Be in My Show)", "Marilyn McCoo & Billy Davis Jr").
card(song_titles, "You Light Up My Life", "Debbie Boone").
card(song_titles, "You Make Me Feel Brand New", "The Stylistics").
card(song_titles, "You Make Me Feel Like Dancing", "Leo Sayer").
card(song_titles, "You Really Got Me", "The Kinks").
card(song_titles, "You Send Me", "Sam Cooke").
card(song_titles, "You Sexy Thing", "Hot Chocolate").
card(song_titles, "You Were Meant for Me", "Jewel").
card(song_titles, "You make Me Wanna", "Usher").
card(song_titles, "You'll Never Know", "Dick Haymes").
card(song_titles, "You're Beautiful", "James Blunt").
card(song_titles, "You're So Vain", "Carly Simon").
card(song_titles, "You're Still the One", "Shania Twain").
card(song_titles, "You're the One That I Want", "John Travolta & Olivia Newton-John").
card(song_titles, "You've Got a Friend", "James Taylor").
card(song_titles, "You've Lost That Lovin' Feelin'", "The Righteous Brothers").
card(song_titles, "Your Cheatin' Heart", "Hank Williams").
card(song_titles, "Your Song", "Elton John").
card(spanish_vocabulary, "April", "abril").
card(spanish_vocabulary, "August", "agosto").
card(spanish_vocabulary, "CD", "discos compactos").
card(spanish_vocabulary, "December", "diciembre").
card(spanish_vocabulary, "February", "febrero").
card(spanish_vocabulary, "Friday", "viernes").
card(spanish_vocabulary, "God", "Dios").
card(spanish_vocabulary, "I", "yo").
card(spanish_vocabulary, "January", "enero").
card(spanish_vocabulary, "July", "julio").
card(spanish_vocabulary, "June", "junio").
card(spanish_vocabulary, "March", "marzo").
card(spanish_vocabulary, "May", "Mayo").
card(spanish_vocabulary, "Monday", "lunes").
card(spanish_vocabulary, "Noun", "Sustantivo").
card(spanish_vocabulary, "November", "noviembre").
card(spanish_vocabulary, "October", "octubre").
card(spanish_vocabulary, "Saturday", "sábado").
card(spanish_vocabulary, "September", "septiembre").
card(spanish_vocabulary, "Sunday", "domingo").
card(spanish_vocabulary, "T-shirt", "camiseta").
card(spanish_vocabulary, "TV", "televisión").
card(spanish_vocabulary, "Thursday", "jueves").
card(spanish_vocabulary, "Tuesday", "martes").
card(spanish_vocabulary, "Wednesday", "miércoles").
card(spanish_vocabulary, "a, an", "un, una").
card(spanish_vocabulary, "abandon", "abandonar").
card(spanish_vocabulary, "ability", "capacidad").
card(spanish_vocabulary, "able", "poder").
card(spanish_vocabulary, "about", "acerca de").
card(spanish_vocabulary, "above", "encima").
card(spanish_vocabulary, "abroad", "extranjero").
card(spanish_vocabulary, "absolute", "absoluto").
card(spanish_vocabulary, "absolutely", "absolutamente").
card(spanish_vocabulary, "academic", "académico").
card(spanish_vocabulary, "accept", "aceptar").
card(spanish_vocabulary, "acceptable", "aceptable").
card(spanish_vocabulary, "access", "acceso").
card(spanish_vocabulary, "accident", "accidente").
card(spanish_vocabulary, "accommodation", "alojamiento").
card(spanish_vocabulary, "accompany", "acompañar").
card(spanish_vocabulary, "according to", "de acuerdo a").
card(spanish_vocabulary, "account", "cuenta").
card(spanish_vocabulary, "accurate", "preciso").
card(spanish_vocabulary, "accuse", "acusar").
card(spanish_vocabulary, "achieve", "lograr").
card(spanish_vocabulary, "achievement", "logro").
card(spanish_vocabulary, "acknowledge", "reconocer").
card(spanish_vocabulary, "acquire", "adquirir").
card(spanish_vocabulary, "across", "a través de").
card(spanish_vocabulary, "act", "actuar").
card(spanish_vocabulary, "action", "acción").
card(spanish_vocabulary, "active", "activo").
card(spanish_vocabulary, "activity", "actividad").
card(spanish_vocabulary, "actor", "actor").
card(spanish_vocabulary, "actress", "actriz").
card(spanish_vocabulary, "actual", "real").
card(spanish_vocabulary, "actually", "realmente").
card(spanish_vocabulary, "ad", "anuncio").
card(spanish_vocabulary, "adapt", "adaptar").
card(spanish_vocabulary, "add", "añadir").
card(spanish_vocabulary, "addition", "adición").
card(spanish_vocabulary, "additional", "adicional").
card(spanish_vocabulary, "address", "habla a").
card(spanish_vocabulary, "administration", "administración").
card(spanish_vocabulary, "admire", "admirar").
card(spanish_vocabulary, "admit", "admitir").
card(spanish_vocabulary, "adopt", "adoptar").
card(spanish_vocabulary, "adult", "adulto").
card(spanish_vocabulary, "advance", "avanzar").
card(spanish_vocabulary, "advanced", "avanzado").
card(spanish_vocabulary, "advantage", "ventaja").
card(spanish_vocabulary, "adventure", "aventuras").
card(spanish_vocabulary, "advertise", "anunciar").
card(spanish_vocabulary, "advertisement", "anuncio").
card(spanish_vocabulary, "advertising", "publicidad").
card(spanish_vocabulary, "advice", "consejo").
card(spanish_vocabulary, "affair", "asunto").
card(spanish_vocabulary, "affect", "afectar").
card(spanish_vocabulary, "afford", "permitirse").
card(spanish_vocabulary, "afraid", "temeroso").
card(spanish_vocabulary, "after", "después").
card(spanish_vocabulary, "afternoon", "tarde").
card(spanish_vocabulary, "afterwards", "después").
card(spanish_vocabulary, "again", "de nuevo").
card(spanish_vocabulary, "against", "en contra").
card(spanish_vocabulary, "age", "años").
card(spanish_vocabulary, "aged", "envejecido").
card(spanish_vocabulary, "agency", "agencia").
card(spanish_vocabulary, "agenda", "agenda").
card(spanish_vocabulary, "agent", "agente").
card(spanish_vocabulary, "aggressive", "agresivo").
card(spanish_vocabulary, "ago", "hace").
card(spanish_vocabulary, "agree", "de acuerdo").
card(spanish_vocabulary, "agreement", "acuerdo").
card(spanish_vocabulary, "ah", "ah").
card(spanish_vocabulary, "ahead", "adelante").
card(spanish_vocabulary, "aid", "ayuda").
card(spanish_vocabulary, "aim", "objetivo").
card(spanish_vocabulary, "air", "aire").
card(spanish_vocabulary, "aircraft", "aeronave").
card(spanish_vocabulary, "airline", "aerolínea").
card(spanish_vocabulary, "airport", "aeropuerto").
card(spanish_vocabulary, "alarm", "alarma").
card(spanish_vocabulary, "album", "álbum").
card(spanish_vocabulary, "alcohol", "alcohol").
card(spanish_vocabulary, "alcoholic", "alcohólico").
card(spanish_vocabulary, "alive", "viva").
card(spanish_vocabulary, "all right", "todo bien").
card(spanish_vocabulary, "all", "todas").
card(spanish_vocabulary, "allow", "permitir").
card(spanish_vocabulary, "almost", "casi").
card(spanish_vocabulary, "alone", "solo").
card(spanish_vocabulary, "along", "a lo largo").
card(spanish_vocabulary, "already", "ya").
card(spanish_vocabulary, "also", "además").
card(spanish_vocabulary, "alter", "alterar").
card(spanish_vocabulary, "alternative", "alternativa").
card(spanish_vocabulary, "although", "a pesar de que").
card(spanish_vocabulary, "always", "siempre").
card(spanish_vocabulary, "amazed", "asombrado").
card(spanish_vocabulary, "amazing", "asombroso").
card(spanish_vocabulary, "ambition", "ambición").
card(spanish_vocabulary, "ambitious", "ambicioso").
card(spanish_vocabulary, "among", "entre").
card(spanish_vocabulary, "amount", "cantidad").
card(spanish_vocabulary, "analysis", "análisis").
card(spanish_vocabulary, "analyze", "analizar").
card(spanish_vocabulary, "ancient", "antiguo").
card(spanish_vocabulary, "and", "y").
card(spanish_vocabulary, "anger", "enfado").
card(spanish_vocabulary, "angle", "ángulo").
card(spanish_vocabulary, "angry", "enojado").
card(spanish_vocabulary, "animal", "animal").
card(spanish_vocabulary, "ankle", "tobillo").
card(spanish_vocabulary, "anniversary", "aniversario").
card(spanish_vocabulary, "announce", "anunciar").
card(spanish_vocabulary, "announcement", "anuncio").
card(spanish_vocabulary, "annoy", "molestar").
card(spanish_vocabulary, "annoyed", "irritado").
card(spanish_vocabulary, "annoying", "molesto").
card(spanish_vocabulary, "annual", "anual").
card(spanish_vocabulary, "another", "otro").
card(spanish_vocabulary, "answer", "responder").
card(spanish_vocabulary, "anxious", "ansioso").
card(spanish_vocabulary, "any more", "nunca más").
card(spanish_vocabulary, "any", "alguna").
card(spanish_vocabulary, "anybody", "cualquiera").
card(spanish_vocabulary, "anyone", "nadie").
card(spanish_vocabulary, "anything", "cualquier cosa").
card(spanish_vocabulary, "anyway", "de todas formas").
card(spanish_vocabulary, "anywhere", "en cualquier sitio").
card(spanish_vocabulary, "apart", "aparte").
card(spanish_vocabulary, "apartment", "departamento").
card(spanish_vocabulary, "apologize", "pedir disculpas").
card(spanish_vocabulary, "app", "aplicación").
card(spanish_vocabulary, "apparent", "aparente").
card(spanish_vocabulary, "apparently", "aparentemente").
card(spanish_vocabulary, "appeal", "apelación").
card(spanish_vocabulary, "appear", "aparecer").
card(spanish_vocabulary, "appearance", "apariencia").
card(spanish_vocabulary, "apple", "manzana").
card(spanish_vocabulary, "application", "solicitud").
card(spanish_vocabulary, "apply", "aplicar").
card(spanish_vocabulary, "appointment", "cita").
card(spanish_vocabulary, "appreciate", "apreciar").
card(spanish_vocabulary, "approach", "acercarse").
card(spanish_vocabulary, "appropriate", "apropiado").
card(spanish_vocabulary, "approval", "aprobación").
card(spanish_vocabulary, "approve", "aprobar").
card(spanish_vocabulary, "approximately", "aproximadamente").
card(spanish_vocabulary, "architect", "arquitecto").
card(spanish_vocabulary, "architecture", "arquitectura").
card(spanish_vocabulary, "area", "zona").
card(spanish_vocabulary, "argue", "discutir").
card(spanish_vocabulary, "argument", "argumento").
card(spanish_vocabulary, "arise", "surgir").
card(spanish_vocabulary, "arm", "brazo").
card(spanish_vocabulary, "armed", "armado").
card(spanish_vocabulary, "arms", "brazos").
card(spanish_vocabulary, "army", "ejército").
card(spanish_vocabulary, "around", "alrededor").
card(spanish_vocabulary, "arrange", "organizar").
card(spanish_vocabulary, "arrangement", "arreglo").
card(spanish_vocabulary, "arrest", "arrestar").
card(spanish_vocabulary, "arrival", "llegada").
card(spanish_vocabulary, "arrive", "llegar").
card(spanish_vocabulary, "art", "arte").
card(spanish_vocabulary, "article", "artículo").
card(spanish_vocabulary, "artificial", "artificial").
card(spanish_vocabulary, "artist", "artista").
card(spanish_vocabulary, "artistic", "artístico").
card(spanish_vocabulary, "as", "como").
card(spanish_vocabulary, "ashamed", "avergonzado").
card(spanish_vocabulary, "ask", "pedir").
card(spanish_vocabulary, "asleep", "dormido").
card(spanish_vocabulary, "aspect", "aspecto").
card(spanish_vocabulary, "assess", "evaluar").
card(spanish_vocabulary, "assessment", "evaluación").
card(spanish_vocabulary, "assignment", "asignación").
card(spanish_vocabulary, "assist", "ayudar").
card(spanish_vocabulary, "assistant", "asistente").
card(spanish_vocabulary, "associate", "asociar").
card(spanish_vocabulary, "associated", "asociado").
card(spanish_vocabulary, "association", "asociación").
card(spanish_vocabulary, "assume", "asumir").
card(spanish_vocabulary, "at", "a").
card(spanish_vocabulary, "athlete", "atleta").
card(spanish_vocabulary, "atmosphere", "atmósfera").
card(spanish_vocabulary, "attach", "adjuntar").
card(spanish_vocabulary, "attack", "ataque").
card(spanish_vocabulary, "attempt", "intento").
card(spanish_vocabulary, "attend", "asistir").
card(spanish_vocabulary, "attention", "atención").
card(spanish_vocabulary, "attitude", "actitud").
card(spanish_vocabulary, "attract", "atraer").
card(spanish_vocabulary, "attraction", "atracción").
card(spanish_vocabulary, "attractive", "atractivo").
card(spanish_vocabulary, "audience", "audiencia").
card(spanish_vocabulary, "aunt", "tía").
card(spanish_vocabulary, "author", "autor").
card(spanish_vocabulary, "authority", "autoridad").
card(spanish_vocabulary, "autumn", "otoño").
card(spanish_vocabulary, "available", "disponible").
card(spanish_vocabulary, "average", "promedio").
card(spanish_vocabulary, "avoid", "evitar").
card(spanish_vocabulary, "award", "premio").
card(spanish_vocabulary, "aware", "consciente").
card(spanish_vocabulary, "away", "lejos").
card(spanish_vocabulary, "awful", "horrible").
card(spanish_vocabulary, "baby", "bebé").
card(spanish_vocabulary, "back", "espalda").
card(spanish_vocabulary, "background", "antecedentes").
card(spanish_vocabulary, "backwards", "hacia atrás").
card(spanish_vocabulary, "bacteria", "bacterias").
card(spanish_vocabulary, "bad", "malo").
card(spanish_vocabulary, "badly", "mal").
card(spanish_vocabulary, "bag", "bolso").
card(spanish_vocabulary, "bake", "hornear").
card(spanish_vocabulary, "balance", "equilibrar").
card(spanish_vocabulary, "ball", "pelota").
card(spanish_vocabulary, "ban", "prohibición").
card(spanish_vocabulary, "banana", "plátano").
card(spanish_vocabulary, "band", "banda").
card(spanish_vocabulary, "bank (money)", "banco").
card(spanish_vocabulary, "bank (river)", "orilla").
card(spanish_vocabulary, "bar", "bar").
card(spanish_vocabulary, "barrier", "barrera").
card(spanish_vocabulary, "base", "base").
card(spanish_vocabulary, "baseball", "béisbol").
card(spanish_vocabulary, "based", "establecido").
card(spanish_vocabulary, "basic", "básico").
card(spanish_vocabulary, "basically", "básicamente").
card(spanish_vocabulary, "basis", "base").
card(spanish_vocabulary, "basketball", "baloncesto").
card(spanish_vocabulary, "bath", "bañera").
card(spanish_vocabulary, "bathroom", "baño").
card(spanish_vocabulary, "battery", "batería").
card(spanish_vocabulary, "battle", "batalla").
card(spanish_vocabulary, "be", "ser").
card(spanish_vocabulary, "beach", "playa").
card(spanish_vocabulary, "bean", "frijol").
card(spanish_vocabulary, "bear (animal)", "oso").
card(spanish_vocabulary, "bear (deal with)", "soportar").
card(spanish_vocabulary, "beat", "golpear").
card(spanish_vocabulary, "beautiful", "hermoso").
card(spanish_vocabulary, "beauty", "belleza").
card(spanish_vocabulary, "because", "porque").
card(spanish_vocabulary, "become", "volverse").
card(spanish_vocabulary, "bed", "cama").
card(spanish_vocabulary, "bedroom", "dormitorio").
card(spanish_vocabulary, "bee", "abeja").
card(spanish_vocabulary, "beef", "carne de vaca").
card(spanish_vocabulary, "beer", "cerveza").
card(spanish_vocabulary, "before", "antes de").
card(spanish_vocabulary, "beg", "mendigar").
card(spanish_vocabulary, "begin", "empezar").
card(spanish_vocabulary, "beginning", "comenzando").
card(spanish_vocabulary, "behave", "comportarse").
card(spanish_vocabulary, "behavior", "comportamiento").
card(spanish_vocabulary, "behind", "detrás").
card(spanish_vocabulary, "being", "siendo").
card(spanish_vocabulary, "belief", "creencia").
card(spanish_vocabulary, "believe", "creer").
card(spanish_vocabulary, "bell", "campana").
card(spanish_vocabulary, "belong", "pertenecer a").
card(spanish_vocabulary, "below", "abajo").
card(spanish_vocabulary, "belt", "cinturón").
card(spanish_vocabulary, "bend", "curva").
card(spanish_vocabulary, "benefit", "beneficio").
card(spanish_vocabulary, "bent", "doblado").
card(spanish_vocabulary, "best", "mejor").
card(spanish_vocabulary, "bet", "apuesta").
card(spanish_vocabulary, "better", "mejor").
card(spanish_vocabulary, "between", "entre").
card(spanish_vocabulary, "beyond", "más all").
card(spanish_vocabulary, "bicycle", "bicicleta").
card(spanish_vocabulary, "big", "grande").
card(spanish_vocabulary, "bike", "bicicleta").
card(spanish_vocabulary, "bill", "cuenta").
card(spanish_vocabulary, "billion number", "número mil millones").
card(spanish_vocabulary, "bin", "compartimiento").
card(spanish_vocabulary, "biology", "biología").
card(spanish_vocabulary, "bird", "pájaro").
card(spanish_vocabulary, "birth", "nacimiento").
card(spanish_vocabulary, "birthday", "cumpleaños").
card(spanish_vocabulary, "biscuit", "galleta").
card(spanish_vocabulary, "bit", "poco").
card(spanish_vocabulary, "bite", "mordedura").
card(spanish_vocabulary, "bitter", "amargo").
card(spanish_vocabulary, "black", "negro").
card(spanish_vocabulary, "blame", "culpa").
card(spanish_vocabulary, "blank", "blanco").
card(spanish_vocabulary, "blind", "ciego").
card(spanish_vocabulary, "block", "bloquear").
card(spanish_vocabulary, "blog", "blog").
card(spanish_vocabulary, "blonde", "rubia").
card(spanish_vocabulary, "blood", "sangre").
card(spanish_vocabulary, "blow", "soplo").
card(spanish_vocabulary, "blue", "azul").
card(spanish_vocabulary, "board", "tablero").
card(spanish_vocabulary, "boat", "barco").
card(spanish_vocabulary, "body", "cuerpo").
card(spanish_vocabulary, "boil", "hervir").
card(spanish_vocabulary, "bomb", "bomba").
card(spanish_vocabulary, "bond", "enlace").
card(spanish_vocabulary, "bone", "hueso").
card(spanish_vocabulary, "book", "libro").
card(spanish_vocabulary, "boot", "bota").
card(spanish_vocabulary, "border", "frontera").
card(spanish_vocabulary, "bored", "aburrido").
card(spanish_vocabulary, "boring", "aburrido").
card(spanish_vocabulary, "born", "nacido").
card(spanish_vocabulary, "borrow", "pedir prestado").
card(spanish_vocabulary, "boss", "jefe").
card(spanish_vocabulary, "both", "ambos").
card(spanish_vocabulary, "bother", "molestia").
card(spanish_vocabulary, "bottle", "botella").
card(spanish_vocabulary, "bottom", "fondo").
card(spanish_vocabulary, "bowl", "cuenco").
card(spanish_vocabulary, "box", "caja").
card(spanish_vocabulary, "boy", "chico").
card(spanish_vocabulary, "boyfriend", "novio").
card(spanish_vocabulary, "brain", "cerebro").
card(spanish_vocabulary, "branch", "rama").
card(spanish_vocabulary, "brand", "marca").
card(spanish_vocabulary, "brave", "valiente").
card(spanish_vocabulary, "bread", "pan de molde").
card(spanish_vocabulary, "break", "descanso").
card(spanish_vocabulary, "breakfast", "desayuno").
card(spanish_vocabulary, "breast", "pecho").
card(spanish_vocabulary, "breath", "respiración").
card(spanish_vocabulary, "breathe", "respirar").
card(spanish_vocabulary, "breathing", "respiración").
card(spanish_vocabulary, "bride", "novia").
card(spanish_vocabulary, "bridge", "puente").
card(spanish_vocabulary, "brief", "breve").
card(spanish_vocabulary, "bright", "brillante").
card(spanish_vocabulary, "brilliant", "brillante").
card(spanish_vocabulary, "bring", "traer").
card(spanish_vocabulary, "broad", "ancho").
card(spanish_vocabulary, "broadcast", "transmitir").
card(spanish_vocabulary, "broken", "roto").
card(spanish_vocabulary, "brother", "hermano").
card(spanish_vocabulary, "brown", "marrón").
card(spanish_vocabulary, "brush", "cepillo").
card(spanish_vocabulary, "bubble", "burbuja").
card(spanish_vocabulary, "budget", "presupuesto").
card(spanish_vocabulary, "build", "construir").
card(spanish_vocabulary, "building", "edificio").
card(spanish_vocabulary, "bullet", "bala").
card(spanish_vocabulary, "bunch", "manojo").
card(spanish_vocabulary, "burn", "quemar").
card(spanish_vocabulary, "bury", "enterrar").
card(spanish_vocabulary, "bus", "autobús").
card(spanish_vocabulary, "bush", "arbusto").
card(spanish_vocabulary, "business", "negocio").
card(spanish_vocabulary, "businessman", "empresario").
card(spanish_vocabulary, "busy", "ocupado").
card(spanish_vocabulary, "but", "pero").
card(spanish_vocabulary, "butter", "mantequilla").
card(spanish_vocabulary, "button", "botón").
card(spanish_vocabulary, "buy", "comprar").
card(spanish_vocabulary, "by", "por").
card(spanish_vocabulary, "bye", "adiós").
card(spanish_vocabulary, "cable", "cable").
card(spanish_vocabulary, "cafe", "cafetería").
card(spanish_vocabulary, "cake", "pastel").
card(spanish_vocabulary, "calculate", "calcular").
card(spanish_vocabulary, "call", "llamada").
card(spanish_vocabulary, "calm", "calma").
card(spanish_vocabulary, "camera", "cámara").
card(spanish_vocabulary, "camp", "acampar").
card(spanish_vocabulary, "campaign", "campaña").
card(spanish_vocabulary, "camping", "cámping").
card(spanish_vocabulary, "campus", "instalaciones").
card(spanish_vocabulary, "cancel", "cancelar").
card(spanish_vocabulary, "cancer", "cáncer").
card(spanish_vocabulary, "candidate", "candidato").
card(spanish_vocabulary, "cannot", "no puedo").
card(spanish_vocabulary, "cap", "gorra").
card(spanish_vocabulary, "capable", "capaz").
card(spanish_vocabulary, "capacity", "capacidad").
card(spanish_vocabulary, "capital", "capital").
card(spanish_vocabulary, "captain", "capitán").
card(spanish_vocabulary, "capture", "capturar").
card(spanish_vocabulary, "car", "coche").
card(spanish_vocabulary, "card", "tarjeta").
card(spanish_vocabulary, "care", "cuidado").
card(spanish_vocabulary, "career", "carrera").
card(spanish_vocabulary, "careful", "cuidado").
card(spanish_vocabulary, "carefully", "cuidadosamente").
card(spanish_vocabulary, "careless", "descuidado").
card(spanish_vocabulary, "carpet", "alfombra").
card(spanish_vocabulary, "carrot", "zanahoria").
card(spanish_vocabulary, "carry", "llevar").
card(spanish_vocabulary, "cartoon", "dibujos animados").
card(spanish_vocabulary, "case", "caso").
card(spanish_vocabulary, "cash", "efectivo").
card(spanish_vocabulary, "cast", "emitir").
card(spanish_vocabulary, "castle", "castillo").
card(spanish_vocabulary, "cat", "gato").
card(spanish_vocabulary, "catch", "captura").
card(spanish_vocabulary, "category", "categoría").
card(spanish_vocabulary, "cause", "porque").
card(spanish_vocabulary, "ceiling", "techo").
card(spanish_vocabulary, "celebrate", "celebrar").
card(spanish_vocabulary, "celebration", "celebracion").
card(spanish_vocabulary, "celebrity", "celebridad").
card(spanish_vocabulary, "cell", "célula").
card(spanish_vocabulary, "cent", "centavo").
card(spanish_vocabulary, "center", "centrar").
card(spanish_vocabulary, "central", "central").
card(spanish_vocabulary, "century", "siglo").
card(spanish_vocabulary, "ceremony", "ceremonia").
card(spanish_vocabulary, "certain", "cierto").
card(spanish_vocabulary, "certainly", "ciertamente").
card(spanish_vocabulary, "chain", "cadena").
card(spanish_vocabulary, "chair", "silla").
card(spanish_vocabulary, "chairman", "presidente").
card(spanish_vocabulary, "challenge", "desafío").
card(spanish_vocabulary, "champion", "campeón").
card(spanish_vocabulary, "chance", "oportunidad").
card(spanish_vocabulary, "change", "cambio").
card(spanish_vocabulary, "channel", "canal").
card(spanish_vocabulary, "chapter", "capítulo").
card(spanish_vocabulary, "character", "personaje").
card(spanish_vocabulary, "characteristic", "característica").
card(spanish_vocabulary, "charge", "cargar").
card(spanish_vocabulary, "charity", "caridad").
card(spanish_vocabulary, "chart", "gráfico").
card(spanish_vocabulary, "chat", "charla").
card(spanish_vocabulary, "cheap", "barato").
card(spanish_vocabulary, "cheat", "engañar").
card(spanish_vocabulary, "check", "cheque").
card(spanish_vocabulary, "cheerful", "alegre").
card(spanish_vocabulary, "cheese", "queso").
card(spanish_vocabulary, "chef", "cocinero").
card(spanish_vocabulary, "chemical", "químico").
card(spanish_vocabulary, "chemistry", "química").
card(spanish_vocabulary, "chest", "cofre").
card(spanish_vocabulary, "chicken", "pollo").
card(spanish_vocabulary, "chief", "jefe").
card(spanish_vocabulary, "child", "niño").
card(spanish_vocabulary, "childhood", "infancia").
card(spanish_vocabulary, "chip", "chip").
card(spanish_vocabulary, "chocolate", "chocolate").
card(spanish_vocabulary, "choice", "elección").
card(spanish_vocabulary, "choose", "escoger").
card(spanish_vocabulary, "church", "iglesia").
card(spanish_vocabulary, "cigarette", "cigarrillo").
card(spanish_vocabulary, "cinema", "cine").
card(spanish_vocabulary, "circle", "circulo").
card(spanish_vocabulary, "circumstance", "circunstancia").
card(spanish_vocabulary, "cite", "citar").
card(spanish_vocabulary, "citizen", "ciudadano").
card(spanish_vocabulary, "city", "ciudad").
card(spanish_vocabulary, "civil", "civil").
card(spanish_vocabulary, "claim", "reclamación").
card(spanish_vocabulary, "class", "clase").
card(spanish_vocabulary, "classic", "clásico").
card(spanish_vocabulary, "classical", "clásico").
card(spanish_vocabulary, "classroom", "salón de clases").
card(spanish_vocabulary, "clause", "cláusula").
card(spanish_vocabulary, "clean", "limpiar").
card(spanish_vocabulary, "clear", "claro").
card(spanish_vocabulary, "clearly", "claramente").
card(spanish_vocabulary, "clever", "inteligente").
card(spanish_vocabulary, "click", "hacer clic").
card(spanish_vocabulary, "client", "cliente").
card(spanish_vocabulary, "climate", "clima").
card(spanish_vocabulary, "climb", "subida").
card(spanish_vocabulary, "clock", "reloj").
card(spanish_vocabulary, "closed", "cerrado").
card(spanish_vocabulary, "closely", "cercanamente").
card(spanish_vocabulary, "cloth", "paño").
card(spanish_vocabulary, "clothes", "ropa").
card(spanish_vocabulary, "clothing", "ropa").
card(spanish_vocabulary, "cloud", "nube").
card(spanish_vocabulary, "club", "club").
card(spanish_vocabulary, "clue", "pista").
card(spanish_vocabulary, "coach", "entrenador").
card(spanish_vocabulary, "coal", "carbón").
card(spanish_vocabulary, "coast", "costa").
card(spanish_vocabulary, "coat", "saco").
card(spanish_vocabulary, "code", "código").
card(spanish_vocabulary, "coffee", "café").
card(spanish_vocabulary, "coin", "moneda").
card(spanish_vocabulary, "cold", "frío").
card(spanish_vocabulary, "collapse", "colapso").
card(spanish_vocabulary, "colleague", "colega").
card(spanish_vocabulary, "collect", "recoger").
card(spanish_vocabulary, "collection", "colección").
card(spanish_vocabulary, "college", "universidad").
card(spanish_vocabulary, "color", "color").
card(spanish_vocabulary, "colored", "de colores").
card(spanish_vocabulary, "column", "columna").
card(spanish_vocabulary, "combination", "combinación").
card(spanish_vocabulary, "combine", "combinar").
card(spanish_vocabulary, "come", "ven").
card(spanish_vocabulary, "comedy", "comedia").
card(spanish_vocabulary, "comfort", "comodidad").
card(spanish_vocabulary, "comfortable", "cómodo").
card(spanish_vocabulary, "command", "mando").
card(spanish_vocabulary, "comment", "comentario").
card(spanish_vocabulary, "commercial", "comercial").
card(spanish_vocabulary, "commission", "comisión").
card(spanish_vocabulary, "commit", "cometer").
card(spanish_vocabulary, "commitment", "compromiso").
card(spanish_vocabulary, "committee", "comité").
card(spanish_vocabulary, "common", "común").
card(spanish_vocabulary, "commonly", "comúnmente").
card(spanish_vocabulary, "communicate", "comunicar").
card(spanish_vocabulary, "communication", "comunicación").
card(spanish_vocabulary, "community", "comunidad").
card(spanish_vocabulary, "company", "empresa").
card(spanish_vocabulary, "compare", "comparar").
card(spanish_vocabulary, "comparison", "comparación").
card(spanish_vocabulary, "compete", "competir").
card(spanish_vocabulary, "competition", "competencia").
card(spanish_vocabulary, "competitive", "competitivo").
card(spanish_vocabulary, "competitor", "competidor").
card(spanish_vocabulary, "complain", "quejar").
card(spanish_vocabulary, "complaint", "queja").
card(spanish_vocabulary, "complete", "completar").
card(spanish_vocabulary, "completely", "completamente").
card(spanish_vocabulary, "complex", "complejo").
card(spanish_vocabulary, "complicated", "complicado").
card(spanish_vocabulary, "component", "componente").
card(spanish_vocabulary, "computer", "computadora").
card(spanish_vocabulary, "concentrate", "concentrado").
card(spanish_vocabulary, "concentration", "concentración").
card(spanish_vocabulary, "concept", "concepto").
card(spanish_vocabulary, "concern", "preocupación").
card(spanish_vocabulary, "concerned", "preocupado").
card(spanish_vocabulary, "concert", "concierto").
card(spanish_vocabulary, "conclude", "concluir").
card(spanish_vocabulary, "conclusion", "conclusión").
card(spanish_vocabulary, "condition", "condición").
card(spanish_vocabulary, "conduct", "conducta").
card(spanish_vocabulary, "conference", "conferencia").
card(spanish_vocabulary, "confidence", "confianza").
card(spanish_vocabulary, "confident", "confidente").
card(spanish_vocabulary, "confirm", "confirmar").
card(spanish_vocabulary, "conflict", "conflicto").
card(spanish_vocabulary, "confuse", "confundir").
card(spanish_vocabulary, "confused", "confuso").
card(spanish_vocabulary, "confusing", "confuso").
card(spanish_vocabulary, "connect", "conectar").
card(spanish_vocabulary, "connected", "conectado").
card(spanish_vocabulary, "connection", "conexión").
card(spanish_vocabulary, "conscious", "consciente").
card(spanish_vocabulary, "consequence", "consecuencia").
card(spanish_vocabulary, "conservative", "conservador").
card(spanish_vocabulary, "consider", "considerar").
card(spanish_vocabulary, "consideration", "consideración").
card(spanish_vocabulary, "consist", "consistir").
card(spanish_vocabulary, "consistent", "consistente").
card(spanish_vocabulary, "constant", "constante").
card(spanish_vocabulary, "constantly", "constantemente").
card(spanish_vocabulary, "construct", "construir").
card(spanish_vocabulary, "construction", "construcción").
card(spanish_vocabulary, "consume", "consumir").
card(spanish_vocabulary, "consumer", "consumidor").
card(spanish_vocabulary, "contact", "contacto").
card(spanish_vocabulary, "contain", "contiene").
card(spanish_vocabulary, "container", "envase").
card(spanish_vocabulary, "contemporary", "contemporáneo").
card(spanish_vocabulary, "content", "contenido").
card(spanish_vocabulary, "contest", "concurso").
card(spanish_vocabulary, "context", "contexto").
card(spanish_vocabulary, "continent", "continente").
card(spanish_vocabulary, "continue", "seguir").
card(spanish_vocabulary, "continuous", "continuo").
card(spanish_vocabulary, "contract", "contrato").
card(spanish_vocabulary, "contrast", "contraste").
card(spanish_vocabulary, "contribute", "contribuir").
card(spanish_vocabulary, "contribution", "contribución").
card(spanish_vocabulary, "control", "controlar").
card(spanish_vocabulary, "convenient", "conveniente").
card(spanish_vocabulary, "conversation", "conversacion").
card(spanish_vocabulary, "convert", "convertir").
card(spanish_vocabulary, "convince", "convencer").
card(spanish_vocabulary, "convinced", "convencido").
card(spanish_vocabulary, "cook", "cocinar").
card(spanish_vocabulary, "cooker", "horno").
card(spanish_vocabulary, "cooking", "cocinando").
card(spanish_vocabulary, "cool", "frio").
card(spanish_vocabulary, "copy", "copiar").
card(spanish_vocabulary, "core", "núcleo").
card(spanish_vocabulary, "corner", "esquina").
card(spanish_vocabulary, "corporate", "corporativo").
card(spanish_vocabulary, "correct", "correcto").
card(spanish_vocabulary, "correctly", "correctamente").
card(spanish_vocabulary, "cost", "costo").
card(spanish_vocabulary, "costume", "disfraz").
card(spanish_vocabulary, "cottage", "cabaña").
card(spanish_vocabulary, "cotton", "algodón").
card(spanish_vocabulary, "could", "podría").
card(spanish_vocabulary, "council", "consejo").
card(spanish_vocabulary, "count", "contar").
card(spanish_vocabulary, "country", "país").
card(spanish_vocabulary, "countryside", "campo").
card(spanish_vocabulary, "county", "condado").
card(spanish_vocabulary, "couple", "pareja").
card(spanish_vocabulary, "courage", "valor").
card(spanish_vocabulary, "course", "curso").
card(spanish_vocabulary, "court", "corte").
card(spanish_vocabulary, "cousin", "prima").
card(spanish_vocabulary, "cover", "cubrir").
card(spanish_vocabulary, "covered", "cubierto").
card(spanish_vocabulary, "cow", "vaca").
card(spanish_vocabulary, "crash", "choque").
card(spanish_vocabulary, "crazy", "loco").
card(spanish_vocabulary, "cream", "crema").
card(spanish_vocabulary, "create", "crear").
card(spanish_vocabulary, "creation", "creación").
card(spanish_vocabulary, "creative", "creativo").
card(spanish_vocabulary, "creature", "criatura").
card(spanish_vocabulary, "credit", "crédito").
card(spanish_vocabulary, "crew", "tripulación").
card(spanish_vocabulary, "crime", "crimen").
card(spanish_vocabulary, "criminal", "delincuente").
card(spanish_vocabulary, "crisis", "crisis").
card(spanish_vocabulary, "criterion", "criterio").
card(spanish_vocabulary, "critic", "crítico").
card(spanish_vocabulary, "critical", "crítico").
card(spanish_vocabulary, "criticism", "crítica").
card(spanish_vocabulary, "criticize", "criticar").
card(spanish_vocabulary, "crop", "cosecha").
card(spanish_vocabulary, "cross", "cruzar").
card(spanish_vocabulary, "crowd", "multitud").
card(spanish_vocabulary, "crowded", "lleno de gente").
card(spanish_vocabulary, "crucial", "crucial").
card(spanish_vocabulary, "cruel", "cruel").
card(spanish_vocabulary, "cry", "llorar").
card(spanish_vocabulary, "cultural", "cultural").
card(spanish_vocabulary, "culture", "cultura").
card(spanish_vocabulary, "cup", "taza").
card(spanish_vocabulary, "cupboard", "alacena").
card(spanish_vocabulary, "cure", "cura").
card(spanish_vocabulary, "curly", "rizado").
card(spanish_vocabulary, "currency", "moneda").
card(spanish_vocabulary, "current", "actual").
card(spanish_vocabulary, "currently", "actualmente").
card(spanish_vocabulary, "curtain", "cortina").
card(spanish_vocabulary, "curve", "curva").
card(spanish_vocabulary, "curved", "curvo").
card(spanish_vocabulary, "custom", "personalizado").
card(spanish_vocabulary, "customer", "cliente").
card(spanish_vocabulary, "cut", "cortar").
card(spanish_vocabulary, "cycle", "ciclo").
card(spanish_vocabulary, "dad", "papá").
card(spanish_vocabulary, "daily", "diario").
card(spanish_vocabulary, "damage", "dañar").
card(spanish_vocabulary, "dance", "baile").
card(spanish_vocabulary, "dancer", "bailarín").
card(spanish_vocabulary, "dancing", "bailando").
card(spanish_vocabulary, "danger", "peligro").
card(spanish_vocabulary, "dangerous", "peligroso").
card(spanish_vocabulary, "dark", "oscuro").
card(spanish_vocabulary, "data", "datos").
card(spanish_vocabulary, "date", "fecha").
card(spanish_vocabulary, "daughter", "hija").
card(spanish_vocabulary, "day", "día").
card(spanish_vocabulary, "dead", "muerto").
card(spanish_vocabulary, "deal", "acuerdo").
card(spanish_vocabulary, "dear", "querido").
card(spanish_vocabulary, "death", "muerte").
card(spanish_vocabulary, "debate", "debate").
card(spanish_vocabulary, "debt", "deuda").
card(spanish_vocabulary, "decade", "década").
card(spanish_vocabulary, "decent", "bueno").
card(spanish_vocabulary, "decide", "decidir").
card(spanish_vocabulary, "decision", "decisión").
card(spanish_vocabulary, "declare", "declarar").
card(spanish_vocabulary, "decline", "disminución").
card(spanish_vocabulary, "decorate", "decorar").
card(spanish_vocabulary, "decoration", "decoración").
card(spanish_vocabulary, "decrease", "disminución").
card(spanish_vocabulary, "deep", "profundo").
card(spanish_vocabulary, "deeply", "profundamente").
card(spanish_vocabulary, "defeat", "derrota").
card(spanish_vocabulary, "defend", "defender").
card(spanish_vocabulary, "defense", "defensa").
card(spanish_vocabulary, "define", "definir").
card(spanish_vocabulary, "definite", "definido").
card(spanish_vocabulary, "definitely", "seguro").
card(spanish_vocabulary, "definition", "definición").
card(spanish_vocabulary, "degree", "la licenciatura").
card(spanish_vocabulary, "delay", "retrasar").
card(spanish_vocabulary, "deliberate", "deliberar").
card(spanish_vocabulary, "deliberately", "deliberadamente").
card(spanish_vocabulary, "delicious", "delicioso").
card(spanish_vocabulary, "delight", "deleite").
card(spanish_vocabulary, "delighted", "encantado").
card(spanish_vocabulary, "deliver", "entregar").
card(spanish_vocabulary, "delivery", "entrega").
card(spanish_vocabulary, "demand", "demanda").
card(spanish_vocabulary, "demonstrate", "demostrar").
card(spanish_vocabulary, "dentist", "dentista").
card(spanish_vocabulary, "deny", "negar").
card(spanish_vocabulary, "department", "departamento").
card(spanish_vocabulary, "departure", "salida").
card(spanish_vocabulary, "depend", "depender").
card(spanish_vocabulary, "depressed", "deprimido").
card(spanish_vocabulary, "depressing", "deprimente").
card(spanish_vocabulary, "depth", "profundidad").
card(spanish_vocabulary, "describe", "describir").
card(spanish_vocabulary, "description", "descripción").
card(spanish_vocabulary, "desert", "desierto").
card(spanish_vocabulary, "deserve", "merecer").
card(spanish_vocabulary, "design", "diseño").
card(spanish_vocabulary, "designer", "diseñador").
card(spanish_vocabulary, "desire", "deseo").
card(spanish_vocabulary, "desk", "escritorio").
card(spanish_vocabulary, "desperate", "desesperado").
card(spanish_vocabulary, "despite", "a pesar de").
card(spanish_vocabulary, "destination", "destino").
card(spanish_vocabulary, "destroy", "destruir").
card(spanish_vocabulary, "detail", "detalle").
card(spanish_vocabulary, "detailed", "detallado").
card(spanish_vocabulary, "detect", "detectar").
card(spanish_vocabulary, "detective", "detective").
card(spanish_vocabulary, "determine", "determinar").
card(spanish_vocabulary, "determined", "determinado").
card(spanish_vocabulary, "develop", "desarrollar").
card(spanish_vocabulary, "development", "desarrollo").
card(spanish_vocabulary, "device", "dispositivo").
card(spanish_vocabulary, "diagram", "diagrama").
card(spanish_vocabulary, "dialogue", "diálogo").
card(spanish_vocabulary, "diamond", "diamante").
card(spanish_vocabulary, "diary", "diario").
card(spanish_vocabulary, "dictionary", "diccionario").
card(spanish_vocabulary, "die", "morir").
card(spanish_vocabulary, "diet", "dieta").
card(spanish_vocabulary, "difference", "diferencia").
card(spanish_vocabulary, "different", "diferente").
card(spanish_vocabulary, "differently", "diferentemente").
card(spanish_vocabulary, "difficult", "difícil").
card(spanish_vocabulary, "difficulty", "dificultad").
card(spanish_vocabulary, "dig", "cavar").
card(spanish_vocabulary, "digital", "digital").
card(spanish_vocabulary, "dinner", "cena").
card(spanish_vocabulary, "direct", "directo").
card(spanish_vocabulary, "direction", "dirección").
card(spanish_vocabulary, "directly", "directamente").
card(spanish_vocabulary, "director", "director").
card(spanish_vocabulary, "dirt", "suciedad").
card(spanish_vocabulary, "dirty", "sucio").
card(spanish_vocabulary, "disagree", "discrepar").
card(spanish_vocabulary, "disappear", "desaparecer").
card(spanish_vocabulary, "disappointed", "decepcionado").
card(spanish_vocabulary, "disappointing", "decepcionante").
card(spanish_vocabulary, "disaster", "desastre").
card(spanish_vocabulary, "discipline", "disciplina").
card(spanish_vocabulary, "discount", "descuento").
card(spanish_vocabulary, "discover", "descubrir").
card(spanish_vocabulary, "discovery", "descubrimiento").
card(spanish_vocabulary, "discuss", "discutir").
card(spanish_vocabulary, "discussion", "discusión").
card(spanish_vocabulary, "disease", "enfermedad").
card(spanish_vocabulary, "dish", "plato").
card(spanish_vocabulary, "dishonest", "deshonesto").
card(spanish_vocabulary, "dislike", "disgusto").
card(spanish_vocabulary, "dismiss", "descartar").
card(spanish_vocabulary, "display", "monitor").
card(spanish_vocabulary, "distance", "distancia").
card(spanish_vocabulary, "distribute", "distribuir").
card(spanish_vocabulary, "distribution", "distribución").
card(spanish_vocabulary, "district", "distrito").
card(spanish_vocabulary, "divide", "dividir").
card(spanish_vocabulary, "division", "división").
card(spanish_vocabulary, "divorced", "divorciado").
card(spanish_vocabulary, "do", "hacer").
card(spanish_vocabulary, "doctor", "médico").
card(spanish_vocabulary, "document", "documento").
card(spanish_vocabulary, "documentary", "documental").
card(spanish_vocabulary, "dog", "perro").
card(spanish_vocabulary, "dollar", "dólar").
card(spanish_vocabulary, "domestic", "doméstico").
card(spanish_vocabulary, "dominate", "dominar").
card(spanish_vocabulary, "donate", "donar").
card(spanish_vocabulary, "door", "puerta").
card(spanish_vocabulary, "double", "doble").
card(spanish_vocabulary, "doubt", "duda").
card(spanish_vocabulary, "down", "abajo").
card(spanish_vocabulary, "download", "descargar").
card(spanish_vocabulary, "downstairs", "abajo").
card(spanish_vocabulary, "downwards", "hacia abajo").
card(spanish_vocabulary, "dozen", "docena").
card(spanish_vocabulary, "draft", "sequía").
card(spanish_vocabulary, "drag", "arrastrar").
card(spanish_vocabulary, "drama", "drama").
card(spanish_vocabulary, "dramatic", "dramático").
card(spanish_vocabulary, "draw", "dibujar").
card(spanish_vocabulary, "drawing", "dibujo").
card(spanish_vocabulary, "dream", "sueño").
card(spanish_vocabulary, "dress", "vestido").
card(spanish_vocabulary, "dressed", "vestido").
card(spanish_vocabulary, "drink", "beber").
card(spanish_vocabulary, "drive", "manejar").
card(spanish_vocabulary, "driver", "conductor").
card(spanish_vocabulary, "driving", "conducción").
card(spanish_vocabulary, "drop", "soltar").
card(spanish_vocabulary, "drug", "droga").
card(spanish_vocabulary, "drum", "tambor").
card(spanish_vocabulary, "drunk", "borracho").
card(spanish_vocabulary, "dry", "seco").
card(spanish_vocabulary, "due", "debido").
card(spanish_vocabulary, "during", "durante").
card(spanish_vocabulary, "dust", "polvo").
card(spanish_vocabulary, "duty", "deber").
card(spanish_vocabulary, "each", "cada").
card(spanish_vocabulary, "ear", "oído").
card(spanish_vocabulary, "early", "temprano").
card(spanish_vocabulary, "earn", "ganar").
card(spanish_vocabulary, "earth", "tierra").
card(spanish_vocabulary, "earthquake", "terremoto").
card(spanish_vocabulary, "easily", "fácilmente").
card(spanish_vocabulary, "east", "este").
card(spanish_vocabulary, "eastern", "oriental").
card(spanish_vocabulary, "easy", "fácil").
card(spanish_vocabulary, "eat", "comer").
card(spanish_vocabulary, "economic", "económico").
card(spanish_vocabulary, "economy", "economía").
card(spanish_vocabulary, "edge", "borde").
card(spanish_vocabulary, "edit", "editar").
card(spanish_vocabulary, "edition", "edición").
card(spanish_vocabulary, "editor", "editor").
card(spanish_vocabulary, "educate", "educar").
card(spanish_vocabulary, "educated", "educado").
card(spanish_vocabulary, "education", "educación").
card(spanish_vocabulary, "educational", "educativo").
card(spanish_vocabulary, "effect", "efecto").
card(spanish_vocabulary, "effective", "eficaz").
card(spanish_vocabulary, "effectively", "efectivamente").
card(spanish_vocabulary, "efficient", "eficiente").
card(spanish_vocabulary, "effort", "esfuerzo").
card(spanish_vocabulary, "egg", "huevo").
card(spanish_vocabulary, "eight", "ocho").
card(spanish_vocabulary, "eighteen", "dieciocho").
card(spanish_vocabulary, "eighty", "ochenta").
card(spanish_vocabulary, "either", "ya sea").
card(spanish_vocabulary, "elderly", "mayor").
card(spanish_vocabulary, "elect", "electo").
card(spanish_vocabulary, "election", "elección").
card(spanish_vocabulary, "electric", "eléctrico").
card(spanish_vocabulary, "electrical", "eléctrico").
card(spanish_vocabulary, "electricity", "electricidad").
card(spanish_vocabulary, "electronic", "electrónico").
card(spanish_vocabulary, "element", "elemento").
card(spanish_vocabulary, "elephant", "elefante").
card(spanish_vocabulary, "eleven", "once").
card(spanish_vocabulary, "else", "más").
card(spanish_vocabulary, "elsewhere", "en otra parte").
card(spanish_vocabulary, "email", "correo electrónico").
card(spanish_vocabulary, "embarrassed", "desconcertado").
card(spanish_vocabulary, "embarrassing", "embarazoso").
card(spanish_vocabulary, "emerge", "surgir").
card(spanish_vocabulary, "emergency", "emergencia").
card(spanish_vocabulary, "emotion", "emoción").
card(spanish_vocabulary, "emotional", "emocional").
card(spanish_vocabulary, "emphasis", "énfasis").
card(spanish_vocabulary, "emphasize", "enfatizar").
card(spanish_vocabulary, "employ", "emplear").
card(spanish_vocabulary, "employee", "empleado").
card(spanish_vocabulary, "employer", "empleador").
card(spanish_vocabulary, "employment", "empleo").
card(spanish_vocabulary, "empty", "vacío").
card(spanish_vocabulary, "enable", "habilitar").
card(spanish_vocabulary, "encounter", "encuentro").
card(spanish_vocabulary, "encourage", "alentar").
card(spanish_vocabulary, "end", "final").
card(spanish_vocabulary, "ending", "finalizando").
card(spanish_vocabulary, "enemy", "enemigo").
card(spanish_vocabulary, "energy", "energía").
card(spanish_vocabulary, "engage", "contratar").
card(spanish_vocabulary, "engaged", "comprometido").
card(spanish_vocabulary, "engine", "motor").
card(spanish_vocabulary, "engineer", "ingeniero").
card(spanish_vocabulary, "engineering", "ingenieria").
card(spanish_vocabulary, "enhance", "mejorar").
card(spanish_vocabulary, "enjoy", "disfrutar").
card(spanish_vocabulary, "enormous", "enorme").
card(spanish_vocabulary, "enough", "suficiente").
card(spanish_vocabulary, "ensure", "asegurar").
card(spanish_vocabulary, "enter", "entrar").
card(spanish_vocabulary, "entertain", "entretener").
card(spanish_vocabulary, "entertainment", "entretenimiento").
card(spanish_vocabulary, "enthusiasm", "entusiasmo").
card(spanish_vocabulary, "enthusiastic", "entusiasta").
card(spanish_vocabulary, "entire", "todo").
card(spanish_vocabulary, "entirely", "enteramente").
card(spanish_vocabulary, "entrance", "entrada").
card(spanish_vocabulary, "entry", "entrada").
card(spanish_vocabulary, "environment", "ambiente").
card(spanish_vocabulary, "environmental", "ambiental").
card(spanish_vocabulary, "episode", "episodio").
card(spanish_vocabulary, "equal", "igual").
card(spanish_vocabulary, "equally", "igualmente").
card(spanish_vocabulary, "equipment", "equipo").
card(spanish_vocabulary, "error", "error").
card(spanish_vocabulary, "escape", "escapar").
card(spanish_vocabulary, "especially", "especialmente").
card(spanish_vocabulary, "essay", "ensayo").
card(spanish_vocabulary, "essential", "esencial").
card(spanish_vocabulary, "establish", "establecer").
card(spanish_vocabulary, "estate", "inmuebles").
card(spanish_vocabulary, "estimate", "estimar").
card(spanish_vocabulary, "ethical", "ético").
card(spanish_vocabulary, "euro", "euro").
card(spanish_vocabulary, "evaluate", "evaluar").
card(spanish_vocabulary, "even", "incluso").
card(spanish_vocabulary, "evening", "noche").
card(spanish_vocabulary, "event", "evento").
card(spanish_vocabulary, "eventually", "finalmente").
card(spanish_vocabulary, "ever", "nunca").
card(spanish_vocabulary, "every", "cada").
card(spanish_vocabulary, "everybody", "todos").
card(spanish_vocabulary, "everyday", "todos los días").
card(spanish_vocabulary, "everyone", "todo el mundo").
card(spanish_vocabulary, "everything", "todo").
card(spanish_vocabulary, "everywhere", "en todas partes").
card(spanish_vocabulary, "evidence", "evidencia").
card(spanish_vocabulary, "evil", "mal").
card(spanish_vocabulary, "exact", "exacto").
card(spanish_vocabulary, "exactly", "exactamente").
card(spanish_vocabulary, "exam", "examen").
card(spanish_vocabulary, "examination", "examen").
card(spanish_vocabulary, "examine", "examinar").
card(spanish_vocabulary, "example", "ejemplo").
card(spanish_vocabulary, "excellent", "excelente").
card(spanish_vocabulary, "except", "excepto").
card(spanish_vocabulary, "exchange", "intercambiar").
card(spanish_vocabulary, "excited", "emocionado").
card(spanish_vocabulary, "excitement", "emoción").
card(spanish_vocabulary, "exciting", "emocionante").
card(spanish_vocabulary, "excuse", "excusa").
card(spanish_vocabulary, "executive", "ejecutivo").
card(spanish_vocabulary, "exercise", "ejercicio").
card(spanish_vocabulary, "exhibition", "exposición").
card(spanish_vocabulary, "exist", "existe").
card(spanish_vocabulary, "existence", "existencia").
card(spanish_vocabulary, "expand", "expandir").
card(spanish_vocabulary, "expect", "esperar").
card(spanish_vocabulary, "expectation", "expectativa").
card(spanish_vocabulary, "expected", "esperado").
card(spanish_vocabulary, "expedition", "expedición").
card(spanish_vocabulary, "expense", "gastos").
card(spanish_vocabulary, "expensive", "costoso").
card(spanish_vocabulary, "experience", "experiencia").
card(spanish_vocabulary, "experienced", "experimentado").
card(spanish_vocabulary, "experiment", "experimentar").
card(spanish_vocabulary, "expert", "experto").
card(spanish_vocabulary, "explain", "explique").
card(spanish_vocabulary, "explanation", "explicación").
card(spanish_vocabulary, "explode", "explotar").
card(spanish_vocabulary, "exploration", "exploración").
card(spanish_vocabulary, "explore", "explorar").
card(spanish_vocabulary, "explosion", "explosión").
card(spanish_vocabulary, "export", "exportar").
card(spanish_vocabulary, "expose", "exponer").
card(spanish_vocabulary, "express", "rápido").
card(spanish_vocabulary, "expression", "expresión").
card(spanish_vocabulary, "extend", "ampliar").
card(spanish_vocabulary, "extent", "grado").
card(spanish_vocabulary, "external", "externo").
card(spanish_vocabulary, "extra", "extra").
card(spanish_vocabulary, "extraordinary", "extraordinario").
card(spanish_vocabulary, "extreme", "extremo").
card(spanish_vocabulary, "extremely", "extremadamente").
card(spanish_vocabulary, "eye", "ojo").
card(spanish_vocabulary, "face", "cara").
card(spanish_vocabulary, "facility", "instalaciones").
card(spanish_vocabulary, "fact", "hecho").
card(spanish_vocabulary, "factor", "factor").
card(spanish_vocabulary, "factory", "fábrica").
card(spanish_vocabulary, "fail", "fallar").
card(spanish_vocabulary, "failure", "fracaso").
card(spanish_vocabulary, "fair", "justa").
card(spanish_vocabulary, "fairly", "bastante").
card(spanish_vocabulary, "faith", "fe").
card(spanish_vocabulary, "fall", "otoño").
card(spanish_vocabulary, "false", "falso").
card(spanish_vocabulary, "familiar", "familiar").
card(spanish_vocabulary, "family", "familia").
card(spanish_vocabulary, "famous", "famoso").
card(spanish_vocabulary, "fan", "ventilador").
card(spanish_vocabulary, "fancy", "lujoso").
card(spanish_vocabulary, "fantastic", "fantástico").
card(spanish_vocabulary, "far", "lejos").
card(spanish_vocabulary, "farm", "granja").
card(spanish_vocabulary, "farmer", "granjero").
card(spanish_vocabulary, "farming", "agricultura").
card(spanish_vocabulary, "fascinating", "fascinante").
card(spanish_vocabulary, "fashion", "moda").
card(spanish_vocabulary, "fashionable", "de moda").
card(spanish_vocabulary, "fast", "rápido").
card(spanish_vocabulary, "fasten", "sujetar").
card(spanish_vocabulary, "fat", "grasa").
card(spanish_vocabulary, "father", "padre").
card(spanish_vocabulary, "fault", "culpa").
card(spanish_vocabulary, "favor", "favor").
card(spanish_vocabulary, "favorite", "favorito").
card(spanish_vocabulary, "fear", "miedo").
card(spanish_vocabulary, "feather", "pluma").
card(spanish_vocabulary, "feature", "característica").
card(spanish_vocabulary, "fee", "cuota").
card(spanish_vocabulary, "feed", "alimentar").
card(spanish_vocabulary, "feedback", "realimentación").
card(spanish_vocabulary, "feel", "sensación").
card(spanish_vocabulary, "feeling", "sensación").
card(spanish_vocabulary, "fellow", "compañero").
card(spanish_vocabulary, "female", "hembra").
card(spanish_vocabulary, "fence", "cerca").
card(spanish_vocabulary, "festival", "festival").
card(spanish_vocabulary, "few", "pocos").
card(spanish_vocabulary, "fiction", "ficción").
card(spanish_vocabulary, "field", "campo").
card(spanish_vocabulary, "fifteen", "quince").
card(spanish_vocabulary, "fifth", "quinto").
card(spanish_vocabulary, "fifty", "cincuenta").
card(spanish_vocabulary, "fight", "lucha").
card(spanish_vocabulary, "fighting", "luchando").
card(spanish_vocabulary, "figure", "figura").
card(spanish_vocabulary, "file", "expediente").
card(spanish_vocabulary, "fill", "llenar").
card(spanish_vocabulary, "film", "película").
card(spanish_vocabulary, "final", "final").
card(spanish_vocabulary, "finally", "finalmente").
card(spanish_vocabulary, "finance", "finanzas").
card(spanish_vocabulary, "financial", "financiero").
card(spanish_vocabulary, "find", "encontrar").
card(spanish_vocabulary, "finding", "hallazgo").
card(spanish_vocabulary, "fine", "multa").
card(spanish_vocabulary, "finger", "dedo").
card(spanish_vocabulary, "finish", "terminar").
card(spanish_vocabulary, "fire", "fuego").
card(spanish_vocabulary, "firm", "firma").
card(spanish_vocabulary, "first", "primero").
card(spanish_vocabulary, "firstly", "en primer lugar").
card(spanish_vocabulary, "fish", "pez").
card(spanish_vocabulary, "fishing", "pescar").
card(spanish_vocabulary, "fit", "ajuste").
card(spanish_vocabulary, "fitness", "aptitud").
card(spanish_vocabulary, "five", "cinco").
card(spanish_vocabulary, "fix", "reparar").
card(spanish_vocabulary, "fixed", "fijo").
card(spanish_vocabulary, "flag", "bandera").
card(spanish_vocabulary, "flame", "fuego").
card(spanish_vocabulary, "flash", "destello").
card(spanish_vocabulary, "flat", "plano").
card(spanish_vocabulary, "flexible", "flexible").
card(spanish_vocabulary, "flight", "vuelo").
card(spanish_vocabulary, "float", "flotador").
card(spanish_vocabulary, "flood", "inundar").
card(spanish_vocabulary, "floor", "piso").
card(spanish_vocabulary, "flour", "harina").
card(spanish_vocabulary, "flow", "fluir").
card(spanish_vocabulary, "flower", "flor").
card(spanish_vocabulary, "flu", "gripe").
card(spanish_vocabulary, "fly", "volar").
card(spanish_vocabulary, "flying", "volador").
card(spanish_vocabulary, "focus", "atención").
card(spanish_vocabulary, "fold", "doblez").
card(spanish_vocabulary, "folding", "plegable").
card(spanish_vocabulary, "folk", "gente").
card(spanish_vocabulary, "follow", "seguir").
card(spanish_vocabulary, "following", "siguiendo").
card(spanish_vocabulary, "food", "comida").
card(spanish_vocabulary, "foot", "pie").
card(spanish_vocabulary, "football", "fútbol americano").
card(spanish_vocabulary, "for", "para").
card(spanish_vocabulary, "force", "fuerza").
card(spanish_vocabulary, "foreign", "exterior").
card(spanish_vocabulary, "forest", "bosque").
card(spanish_vocabulary, "forever", "siempre").
card(spanish_vocabulary, "forget", "olvidar").
card(spanish_vocabulary, "forgive", "perdonar").
card(spanish_vocabulary, "fork", "tenedor").
card(spanish_vocabulary, "form", "formar").
card(spanish_vocabulary, "formal", "formal").
card(spanish_vocabulary, "former", "ex").
card(spanish_vocabulary, "fortunately", "por suerte").
card(spanish_vocabulary, "fortune", "fortuna").
card(spanish_vocabulary, "forty", "cuarenta").
card(spanish_vocabulary, "forward", "adelante").
card(spanish_vocabulary, "found", "encontró").
card(spanish_vocabulary, "four", "cuatro").
card(spanish_vocabulary, "fourteen", "catorce").
card(spanish_vocabulary, "fourth", "cuarto").
card(spanish_vocabulary, "frame", "cuadro").
card(spanish_vocabulary, "free", "gratis").
card(spanish_vocabulary, "freedom", "libertad").
card(spanish_vocabulary, "freeze", "congelar").
card(spanish_vocabulary, "frequency", "frecuencia").
card(spanish_vocabulary, "frequently", "frecuentemente").
card(spanish_vocabulary, "fresh", "fresco").
card(spanish_vocabulary, "fridge", "refrigerador").
card(spanish_vocabulary, "friend", "amigo").
card(spanish_vocabulary, "friendly", "amistoso").
card(spanish_vocabulary, "friendship", "amistad").
card(spanish_vocabulary, "frighten", "asustar").
card(spanish_vocabulary, "frightened", "asustado").
card(spanish_vocabulary, "frightening", "aterrador").
card(spanish_vocabulary, "frog", "rana").
card(spanish_vocabulary, "from", "de").
card(spanish_vocabulary, "front", "frente").
card(spanish_vocabulary, "frozen", "congelado").
card(spanish_vocabulary, "fruit", "fruta").
card(spanish_vocabulary, "fry", "freír").
card(spanish_vocabulary, "fuel", "combustible").
card(spanish_vocabulary, "full", "completo").
card(spanish_vocabulary, "fully", "completamente").
card(spanish_vocabulary, "fun", "divertido").
card(spanish_vocabulary, "function", "función").
card(spanish_vocabulary, "fund", "fondo").
card(spanish_vocabulary, "fundamental", "fundamental").
card(spanish_vocabulary, "funding", "fondos").
card(spanish_vocabulary, "funny", "gracioso").
card(spanish_vocabulary, "fur", "pelaje").
card(spanish_vocabulary, "furniture", "mueble").
card(spanish_vocabulary, "further", "más lejos").
card(spanish_vocabulary, "furthermore", "además").
card(spanish_vocabulary, "future", "futuro").
card(spanish_vocabulary, "gain", "ganancia").
card(spanish_vocabulary, "gallery", "galería").
card(spanish_vocabulary, "game", "juego").
card(spanish_vocabulary, "gang", "pandilla").
card(spanish_vocabulary, "gap", "brecha").
card(spanish_vocabulary, "garage", "garaje").
card(spanish_vocabulary, "garden", "jardín").
card(spanish_vocabulary, "gas", "gas").
card(spanish_vocabulary, "gate", "portón").
card(spanish_vocabulary, "gather", "reunir").
card(spanish_vocabulary, "general", "general").
card(spanish_vocabulary, "generally", "generalmente").
card(spanish_vocabulary, "generate", "generar").
card(spanish_vocabulary, "generation", "generacion").
card(spanish_vocabulary, "generous", "generoso").
card(spanish_vocabulary, "genre", "género").
card(spanish_vocabulary, "gentle", "amable").
card(spanish_vocabulary, "gentleman", "caballero").
card(spanish_vocabulary, "geography", "geografía").
card(spanish_vocabulary, "get", "obtener").
card(spanish_vocabulary, "ghost", "fantasma").
card(spanish_vocabulary, "giant", "gigante").
card(spanish_vocabulary, "gift", "regalo").
card(spanish_vocabulary, "girl", "niña").
card(spanish_vocabulary, "girlfriend", "novia").
card(spanish_vocabulary, "give", "dar").
card(spanish_vocabulary, "glad", "alegre").
card(spanish_vocabulary, "glass", "vaso").
card(spanish_vocabulary, "global", "global").
card(spanish_vocabulary, "glove", "guante").
card(spanish_vocabulary, "go", "vamos").
card(spanish_vocabulary, "goal", "objetivo").
card(spanish_vocabulary, "gold", "oro").
card(spanish_vocabulary, "golf", "golf").
card(spanish_vocabulary, "good", "bueno").
card(spanish_vocabulary, "goodbye", "adiós").
card(spanish_vocabulary, "goods", "bienes").
card(spanish_vocabulary, "govern", "regir").
card(spanish_vocabulary, "government", "gobierno").
card(spanish_vocabulary, "grab", "agarrar").
card(spanish_vocabulary, "grade", "grado").
card(spanish_vocabulary, "gradually", "gradualmente").
card(spanish_vocabulary, "graduate", "graduado").
card(spanish_vocabulary, "grain", "grano").
card(spanish_vocabulary, "grand", "grandioso").
card(spanish_vocabulary, "grandfather", "abuelo").
card(spanish_vocabulary, "grandmother", "abuela").
card(spanish_vocabulary, "grandparent", "abuelo").
card(spanish_vocabulary, "grant", "conceder").
card(spanish_vocabulary, "grass", "césped").
card(spanish_vocabulary, "grateful", "agradecido").
card(spanish_vocabulary, "gray", "gris").
card(spanish_vocabulary, "great", "excelente").
card(spanish_vocabulary, "green", "verde").
card(spanish_vocabulary, "greet", "saludar").
card(spanish_vocabulary, "ground", "suelo").
card(spanish_vocabulary, "group", "grupo").
card(spanish_vocabulary, "grow", "crecer").
card(spanish_vocabulary, "growth", "crecimiento").
card(spanish_vocabulary, "guarantee", "garantía").
card(spanish_vocabulary, "guard", "guardia").
card(spanish_vocabulary, "guess", "adivinar").
card(spanish_vocabulary, "guest", "invitado").
card(spanish_vocabulary, "guide", "guía").
card(spanish_vocabulary, "guilty", "culpable").
card(spanish_vocabulary, "guitar", "guitarra").
card(spanish_vocabulary, "gun", "pistola").
card(spanish_vocabulary, "guy", "chico").
card(spanish_vocabulary, "gym", "gimnasio").
card(spanish_vocabulary, "habit", "hábito").
card(spanish_vocabulary, "hair", "cabello").
card(spanish_vocabulary, "half", "medio").
card(spanish_vocabulary, "hall", "salón").
card(spanish_vocabulary, "hand", "mano").
card(spanish_vocabulary, "handle", "encargarse de").
card(spanish_vocabulary, "hang", "colgar").
card(spanish_vocabulary, "happen", "ocurrir").
card(spanish_vocabulary, "happily", "felizmente").
card(spanish_vocabulary, "happiness", "felicidad").
card(spanish_vocabulary, "happy", "contento").
card(spanish_vocabulary, "hard", "difícil").
card(spanish_vocabulary, "hardly", "apenas").
card(spanish_vocabulary, "harm", "daño").
card(spanish_vocabulary, "harmful", "perjudicial").
card(spanish_vocabulary, "hat", "sombrero").
card(spanish_vocabulary, "hate", "odio").
card(spanish_vocabulary, "have to modal", "tienes a modal").
card(spanish_vocabulary, "have", "tener").
card(spanish_vocabulary, "he", "él").
card(spanish_vocabulary, "head", "cabeza").
card(spanish_vocabulary, "headache", "dolor de cabeza").
card(spanish_vocabulary, "headline", "titular").
card(spanish_vocabulary, "health", "salud").
card(spanish_vocabulary, "healthy", "saludable").
card(spanish_vocabulary, "hear", "oír").
card(spanish_vocabulary, "hearing", "escuchando").
card(spanish_vocabulary, "heart", "corazón").
card(spanish_vocabulary, "heat", "calor").
card(spanish_vocabulary, "heating", "calefacción").
card(spanish_vocabulary, "heaven", "cielo").
card(spanish_vocabulary, "heavily", "fuertemente").
card(spanish_vocabulary, "heavy", "pesado").
card(spanish_vocabulary, "heel", "tacón").
card(spanish_vocabulary, "height", "altura").
card(spanish_vocabulary, "helicopter", "helicóptero").
card(spanish_vocabulary, "hell", "infierno").
card(spanish_vocabulary, "hello", "hola").
card(spanish_vocabulary, "help", "ayuda").
card(spanish_vocabulary, "helpful", "servicial").
card(spanish_vocabulary, "her", "su").
card(spanish_vocabulary, "here", "aquí").
card(spanish_vocabulary, "hero", "héroe").
card(spanish_vocabulary, "hers", "suyo").
card(spanish_vocabulary, "herself", "sí misma").
card(spanish_vocabulary, "hesitate", "vacilar").
card(spanish_vocabulary, "hey", "oye").
card(spanish_vocabulary, "hi", "hola").
card(spanish_vocabulary, "hide", "esconder").
card(spanish_vocabulary, "high", "alto").
card(spanish_vocabulary, "highlight", "realce").
card(spanish_vocabulary, "highly", "altamente").
card(spanish_vocabulary, "hill", "colina").
card(spanish_vocabulary, "him", "él").
card(spanish_vocabulary, "himself", "él mismo").
card(spanish_vocabulary, "hire", "alquiler").
card(spanish_vocabulary, "his", "su").
card(spanish_vocabulary, "historic", "histórico").
card(spanish_vocabulary, "historical", "histórico").
card(spanish_vocabulary, "history", "historia").
card(spanish_vocabulary, "hit", "golpear").
card(spanish_vocabulary, "hobby", "pasatiempo").
card(spanish_vocabulary, "hockey", "hockey").
card(spanish_vocabulary, "hold", "sostener").
card(spanish_vocabulary, "hole", "agujero").
card(spanish_vocabulary, "holiday", "fiesta").
card(spanish_vocabulary, "hollow", "hueco").
card(spanish_vocabulary, "holy", "santo").
card(spanish_vocabulary, "home", "hogar").
card(spanish_vocabulary, "homework", "deberes").
card(spanish_vocabulary, "honest", "honesto").
card(spanish_vocabulary, "honor", "honor").
card(spanish_vocabulary, "hope", "esperanza").
card(spanish_vocabulary, "horrible", "horrible").
card(spanish_vocabulary, "horror", "horror").
card(spanish_vocabulary, "horse", "caballo").
card(spanish_vocabulary, "hospital", "hospital").
card(spanish_vocabulary, "host", "anfitrión").
card(spanish_vocabulary, "hot", "caliente").
card(spanish_vocabulary, "hotel", "hotel").
card(spanish_vocabulary, "hour", "hora").
card(spanish_vocabulary, "house", "casa").
card(spanish_vocabulary, "household", "casa").
card(spanish_vocabulary, "housing", "alojamiento").
card(spanish_vocabulary, "how", "cómo").
card(spanish_vocabulary, "however", "sin embargo").
card(spanish_vocabulary, "huge", "enorme").
card(spanish_vocabulary, "human", "humano").
card(spanish_vocabulary, "humor", "humor").
card(spanish_vocabulary, "humorous", "humorístico").
card(spanish_vocabulary, "hundred", "cien").
card(spanish_vocabulary, "hungry", "hambriento").
card(spanish_vocabulary, "hunt", "cazar").
card(spanish_vocabulary, "hunting", "caza").
card(spanish_vocabulary, "hurricane", "huracán").
card(spanish_vocabulary, "hurry", "prisa").
card(spanish_vocabulary, "hurt", "herir").
card(spanish_vocabulary, "husband", "marido").
card(spanish_vocabulary, "ice cream", "helado").
card(spanish_vocabulary, "ice", "hielo").
card(spanish_vocabulary, "idea", "idea").
card(spanish_vocabulary, "ideal", "ideal").
card(spanish_vocabulary, "identify", "identificar").
card(spanish_vocabulary, "identity", "identidad").
card(spanish_vocabulary, "if", "si").
card(spanish_vocabulary, "ignore", "ignorar").
card(spanish_vocabulary, "ill", "enfermo").
card(spanish_vocabulary, "illegal", "ilegal").
card(spanish_vocabulary, "illness", "enfermedad").
card(spanish_vocabulary, "illustrate", "ilustrar").
card(spanish_vocabulary, "illustration", "ilustración").
card(spanish_vocabulary, "image", "imagen").
card(spanish_vocabulary, "imaginary", "imaginario").
card(spanish_vocabulary, "imagination", "imaginación").
card(spanish_vocabulary, "imagine", "imagina").
card(spanish_vocabulary, "immediate", "inmediato").
card(spanish_vocabulary, "immediately", "inmediatamente").
card(spanish_vocabulary, "immigrant", "inmigrante").
card(spanish_vocabulary, "impact", "impacto").
card(spanish_vocabulary, "impatient", "impaciente").
card(spanish_vocabulary, "imply", "implicar").
card(spanish_vocabulary, "import", "importar").
card(spanish_vocabulary, "importance", "importancia").
card(spanish_vocabulary, "important", "importante").
card(spanish_vocabulary, "impose", "imponer").
card(spanish_vocabulary, "impossible", "imposible").
card(spanish_vocabulary, "impress", "impresionar").
card(spanish_vocabulary, "impressed", "impresionado").
card(spanish_vocabulary, "impression", "impresión").
card(spanish_vocabulary, "impressive", "impresionante").
card(spanish_vocabulary, "improve", "mejorar").
card(spanish_vocabulary, "improvement", "mejora").
card(spanish_vocabulary, "in", "en").
card(spanish_vocabulary, "inch", "pulgada").
card(spanish_vocabulary, "incident", "incidente").
card(spanish_vocabulary, "include", "incluir").
card(spanish_vocabulary, "included", "incluido").
card(spanish_vocabulary, "including", "incluso").
card(spanish_vocabulary, "income", "ingresos").
card(spanish_vocabulary, "increase", "incrementar").
card(spanish_vocabulary, "increasingly", "cada vez más").
card(spanish_vocabulary, "incredible", "increíble").
card(spanish_vocabulary, "incredibly", "increíblemente").
card(spanish_vocabulary, "indeed", "en efecto").
card(spanish_vocabulary, "independent", "independiente").
card(spanish_vocabulary, "indicate", "indicar").
card(spanish_vocabulary, "indirect", "indirecto").
card(spanish_vocabulary, "individual", "individual").
card(spanish_vocabulary, "indoor", "interior").
card(spanish_vocabulary, "indoors", "adentro").
card(spanish_vocabulary, "industrial", "industrial").
card(spanish_vocabulary, "industry", "industria").
card(spanish_vocabulary, "infection", "infección").
card(spanish_vocabulary, "influence", "influencia").
card(spanish_vocabulary, "inform", "informar").
card(spanish_vocabulary, "informal", "informal").
card(spanish_vocabulary, "information", "información").
card(spanish_vocabulary, "ingredient", "ingrediente").
card(spanish_vocabulary, "initial", "inicial").
card(spanish_vocabulary, "initially", "inicialmente").
card(spanish_vocabulary, "initiative", "iniciativa").
card(spanish_vocabulary, "injure", "lesionar").
card(spanish_vocabulary, "injured", "lesionado").
card(spanish_vocabulary, "injury", "lesión").
card(spanish_vocabulary, "inner", "interior").
card(spanish_vocabulary, "innocent", "inocente").
card(spanish_vocabulary, "inquiry", "investigación").
card(spanish_vocabulary, "insect", "insecto").
card(spanish_vocabulary, "inside", "dentro").
card(spanish_vocabulary, "insight", "visión").
card(spanish_vocabulary, "insist", "insistir").
card(spanish_vocabulary, "inspire", "inspirar").
card(spanish_vocabulary, "install", "instalar en pc").
card(spanish_vocabulary, "instance", "ejemplo").
card(spanish_vocabulary, "instead", "en lugar").
card(spanish_vocabulary, "institute", "instituto").
card(spanish_vocabulary, "institution", "institución").
card(spanish_vocabulary, "instruction", "instrucción").
card(spanish_vocabulary, "instructor", "instructor").
card(spanish_vocabulary, "instrument", "instrumento").
card(spanish_vocabulary, "insurance", "seguro").
card(spanish_vocabulary, "intelligence", "inteligencia").
card(spanish_vocabulary, "intelligent", "inteligente").
card(spanish_vocabulary, "intend", "intentar").
card(spanish_vocabulary, "intended", "destinado a").
card(spanish_vocabulary, "intense", "intenso").
card(spanish_vocabulary, "intention", "intención").
card(spanish_vocabulary, "interest", "interesar").
card(spanish_vocabulary, "interested", "interesado").
card(spanish_vocabulary, "interesting", "interesante").
card(spanish_vocabulary, "internal", "interno").
card(spanish_vocabulary, "international", "internacional").
card(spanish_vocabulary, "internet", "internet").
card(spanish_vocabulary, "interpret", "interpretar").
card(spanish_vocabulary, "interrupt", "interrumpir").
card(spanish_vocabulary, "interview", "entrevista").
card(spanish_vocabulary, "into", "dentro").
card(spanish_vocabulary, "introduce", "introducir").
card(spanish_vocabulary, "introduction", "introducción").
card(spanish_vocabulary, "invent", "inventar").
card(spanish_vocabulary, "invention", "invención").
card(spanish_vocabulary, "invest", "invertir").
card(spanish_vocabulary, "investigate", "investigar").
card(spanish_vocabulary, "investigation", "investigación").
card(spanish_vocabulary, "investment", "inversión").
card(spanish_vocabulary, "invitation", "invitación").
card(spanish_vocabulary, "invite", "invitación").
card(spanish_vocabulary, "involve", "involucrar").
card(spanish_vocabulary, "involved", "involucrado").
card(spanish_vocabulary, "iron", "hierro").
card(spanish_vocabulary, "island", "isla").
card(spanish_vocabulary, "issue", "problema").
card(spanish_vocabulary, "it", "eso").
card(spanish_vocabulary, "item", "articulo").
card(spanish_vocabulary, "its", "sus").
card(spanish_vocabulary, "itself", "sí mismo").
card(spanish_vocabulary, "jacket", "chaqueta").
card(spanish_vocabulary, "jam", "mermelada").
card(spanish_vocabulary, "jazz", "jazz").
card(spanish_vocabulary, "jeans", "pantalones").
card(spanish_vocabulary, "jewelry", "joyería").
card(spanish_vocabulary, "job", "trabajo").
card(spanish_vocabulary, "join", "unirse").
card(spanish_vocabulary, "joke", "broma").
card(spanish_vocabulary, "journal", "diario").
card(spanish_vocabulary, "journalist", "periodista").
card(spanish_vocabulary, "journey", "viaje").
card(spanish_vocabulary, "joy", "alegría").
card(spanish_vocabulary, "judge", "juez").
card(spanish_vocabulary, "judgement", "juicio").
card(spanish_vocabulary, "juice", "jugo").
card(spanish_vocabulary, "jump", "saltar").
card(spanish_vocabulary, "junior", "júnior").
card(spanish_vocabulary, "just", "sólo").
card(spanish_vocabulary, "justice", "justicia").
card(spanish_vocabulary, "justify", "justificar").
card(spanish_vocabulary, "keen", "afilado").
card(spanish_vocabulary, "keep", "mantener").
card(spanish_vocabulary, "key", "llave").
card(spanish_vocabulary, "keyboard", "teclado").
card(spanish_vocabulary, "kick", "golpear").
card(spanish_vocabulary, "kid", "niño").
card(spanish_vocabulary, "kill", "matar").
card(spanish_vocabulary, "killing", "asesinato").
card(spanish_vocabulary, "kilometer", "kilómetro").
card(spanish_vocabulary, "kind (caring)", "amable").
card(spanish_vocabulary, "kind (type)", "tipo)").
card(spanish_vocabulary, "king", "rey").
card(spanish_vocabulary, "kiss", "beso").
card(spanish_vocabulary, "kitchen", "cocina").
card(spanish_vocabulary, "knee", "rodilla").
card(spanish_vocabulary, "knife", "cuchillo").
card(spanish_vocabulary, "knock", "golpe").
card(spanish_vocabulary, "know", "saber").
card(spanish_vocabulary, "knowledge", "conocimiento").
card(spanish_vocabulary, "lab", "laboratorio").
card(spanish_vocabulary, "label", "etiqueta").
card(spanish_vocabulary, "labor", "labor").
card(spanish_vocabulary, "laboratory", "laboratorio").
card(spanish_vocabulary, "lack", "carencia").
card(spanish_vocabulary, "lady", "dama").
card(spanish_vocabulary, "lake", "lago").
card(spanish_vocabulary, "lamp", "lámpara").
card(spanish_vocabulary, "land", "tierra").
card(spanish_vocabulary, "landscape", "paisaje").
card(spanish_vocabulary, "language", "idioma").
card(spanish_vocabulary, "laptop", "ordenador portátil").
card(spanish_vocabulary, "large", "grande").
card(spanish_vocabulary, "largely", "en gran parte").
card(spanish_vocabulary, "last (final)", "último").
card(spanish_vocabulary, "last (taking time)", "durar").
card(spanish_vocabulary, "late", "tarde").
card(spanish_vocabulary, "later", "luego").
card(spanish_vocabulary, "latest", "último").
card(spanish_vocabulary, "laugh", "risa").
card(spanish_vocabulary, "laughter", "la risa").
card(spanish_vocabulary, "launch", "lanzamiento").
card(spanish_vocabulary, "law", "ley").
card(spanish_vocabulary, "lawyer", "abogado").
card(spanish_vocabulary, "lay", "laico").
card(spanish_vocabulary, "layer", "capa").
card(spanish_vocabulary, "lazy", "perezoso").
card(spanish_vocabulary, "lead", "dirigir").
card(spanish_vocabulary, "leader", "líder").
card(spanish_vocabulary, "leadership", "liderazgo").
card(spanish_vocabulary, "leading", "líder").
card(spanish_vocabulary, "leaf", "hoja").
card(spanish_vocabulary, "league", "liga").
card(spanish_vocabulary, "lean", "apoyarse").
card(spanish_vocabulary, "learn", "aprender").
card(spanish_vocabulary, "learning", "aprendizaje").
card(spanish_vocabulary, "least", "menos").
card(spanish_vocabulary, "leather", "cuero").
card(spanish_vocabulary, "leave", "salir").
card(spanish_vocabulary, "lecture", "conferencia").
card(spanish_vocabulary, "left", "izquierda").
card(spanish_vocabulary, "leg", "pierna").
card(spanish_vocabulary, "legal", "legal").
card(spanish_vocabulary, "leisure", "ocio").
card(spanish_vocabulary, "lemon", "limón").
card(spanish_vocabulary, "lend", "prestar").
card(spanish_vocabulary, "length", "longitud").
card(spanish_vocabulary, "less", "menos").
card(spanish_vocabulary, "lesson", "lección").
card(spanish_vocabulary, "let", "dejar").
card(spanish_vocabulary, "letter", "letra").
card(spanish_vocabulary, "level", "nivel").
card(spanish_vocabulary, "library", "biblioteca").
card(spanish_vocabulary, "license", "licencia").
card(spanish_vocabulary, "lie", "mentira").
card(spanish_vocabulary, "life", "vida").
card(spanish_vocabulary, "lifestyle", "estilo de vida").
card(spanish_vocabulary, "lift", "ascensor").
card(spanish_vocabulary, "light (brightness)", "la luz").
card(spanish_vocabulary, "light (not heavy)", "ligero").
card(spanish_vocabulary, "like (find pleasant)", "gustar").
card(spanish_vocabulary, "like (similar)", "como").
card(spanish_vocabulary, "likely", "probable").
card(spanish_vocabulary, "limit", "límite").
card(spanish_vocabulary, "limited", "limitado").
card(spanish_vocabulary, "line", "línea").
card(spanish_vocabulary, "link", "enlace").
card(spanish_vocabulary, "lion", "león").
card(spanish_vocabulary, "lip", "labio").
card(spanish_vocabulary, "liquid", "líquido").
card(spanish_vocabulary, "list", "lista").
card(spanish_vocabulary, "listen", "escucha").
card(spanish_vocabulary, "listener", "oyente").
card(spanish_vocabulary, "literature", "literatura").
card(spanish_vocabulary, "little", "pequeño").
card(spanish_vocabulary, "lively", "animado").
card(spanish_vocabulary, "living", "vivo").
card(spanish_vocabulary, "load", "carga").
card(spanish_vocabulary, "loan", "préstamo").
card(spanish_vocabulary, "local", "local").
card(spanish_vocabulary, "locate", "localizar").
card(spanish_vocabulary, "located", "situado").
card(spanish_vocabulary, "location", "ubicación").
card(spanish_vocabulary, "lock", "bloquear").
card(spanish_vocabulary, "logical", "lógico").
card(spanish_vocabulary, "lonely", "solitario").
card(spanish_vocabulary, "long", "largo").
card(spanish_vocabulary, "long-term", "a largo plazo").
card(spanish_vocabulary, "look", "mira").
card(spanish_vocabulary, "loose", "suelto").
card(spanish_vocabulary, "lord", "señor").
card(spanish_vocabulary, "lorry", "camión").
card(spanish_vocabulary, "lose", "perder").
card(spanish_vocabulary, "loss", "pérdida").
card(spanish_vocabulary, "lost", "perdió").
card(spanish_vocabulary, "lot", "lote").
card(spanish_vocabulary, "loud", "ruidoso").
card(spanish_vocabulary, "loudly", "ruidosamente").
card(spanish_vocabulary, "love", "amor").
card(spanish_vocabulary, "lovely", "encantador").
card(spanish_vocabulary, "low", "bajo").
card(spanish_vocabulary, "lower", "inferior").
card(spanish_vocabulary, "luck", "suerte").
card(spanish_vocabulary, "lucky", "suerte").
card(spanish_vocabulary, "lunch", "almuerzo").
card(spanish_vocabulary, "lung", "pulmón").
card(spanish_vocabulary, "luxury", "lujo").
card(spanish_vocabulary, "machine", "máquina").
card(spanish_vocabulary, "mad", "enojado").
card(spanish_vocabulary, "magazine", "revista").
card(spanish_vocabulary, "magic", "magia").
card(spanish_vocabulary, "mail", "correo").
card(spanish_vocabulary, "main", "principal").
card(spanish_vocabulary, "mainly", "principalmente").
card(spanish_vocabulary, "maintain", "mantener").
card(spanish_vocabulary, "major", "mayor").
card(spanish_vocabulary, "majority", "mayoria").
card(spanish_vocabulary, "make", "hacer").
card(spanish_vocabulary, "male", "masculino").
card(spanish_vocabulary, "mall", "centro comercial").
card(spanish_vocabulary, "man", "hombre").
card(spanish_vocabulary, "manage", "gestionar").
card(spanish_vocabulary, "management", "administración").
card(spanish_vocabulary, "manager", "gerente").
card(spanish_vocabulary, "manner", "conducta").
card(spanish_vocabulary, "many", "muchos").
card(spanish_vocabulary, "map", "mapa").
card(spanish_vocabulary, "mark", "marca").
card(spanish_vocabulary, "market", "mercado").
card(spanish_vocabulary, "marketing", "márketing").
card(spanish_vocabulary, "marriage", "matrimonio").
card(spanish_vocabulary, "married", "casado").
card(spanish_vocabulary, "marry", "casar").
card(spanish_vocabulary, "mass", "masa").
card(spanish_vocabulary, "massive", "masivo").
card(spanish_vocabulary, "master", "maestro").
card(spanish_vocabulary, "match (contest)", "combate").
card(spanish_vocabulary, "match (correspond)", "combinar").
card(spanish_vocabulary, "matching", "pareo").
card(spanish_vocabulary, "material", "material").
card(spanish_vocabulary, "mathematics", "matemáticas").
card(spanish_vocabulary, "matter", "importar").
card(spanish_vocabulary, "maximum", "máximo").
card(spanish_vocabulary, "may modal", "puede modal").
card(spanish_vocabulary, "maybe", "tal vez").
card(spanish_vocabulary, "me", "yo").
card(spanish_vocabulary, "meal", "comida").
card(spanish_vocabulary, "mean", "media").
card(spanish_vocabulary, "meaning", "sentido").
card(spanish_vocabulary, "means", "medio").
card(spanish_vocabulary, "meanwhile", "mientras tanto").
card(spanish_vocabulary, "measure", "medida").
card(spanish_vocabulary, "measurement", "medición").
card(spanish_vocabulary, "meat", "carne").
card(spanish_vocabulary, "media", "medios de comunicación").
card(spanish_vocabulary, "medical", "médico").
card(spanish_vocabulary, "medicine", "medicamento").
card(spanish_vocabulary, "medium", "medio").
card(spanish_vocabulary, "meet", "reunirse").
card(spanish_vocabulary, "meeting", "reunión").
card(spanish_vocabulary, "melt", "derretir").
card(spanish_vocabulary, "member", "miembro").
card(spanish_vocabulary, "memory", "memoria").
card(spanish_vocabulary, "mental", "mental").
card(spanish_vocabulary, "mention", "mencionar").
card(spanish_vocabulary, "menu", "menú").
card(spanish_vocabulary, "mess", "lío").
card(spanish_vocabulary, "message", "mensaje").
card(spanish_vocabulary, "metal", "metal").
card(spanish_vocabulary, "meter", "metro").
card(spanish_vocabulary, "method", "método").
card(spanish_vocabulary, "middle", "medio").
card(spanish_vocabulary, "midnight", "medianoche").
card(spanish_vocabulary, "might modal", "podría modal").
card(spanish_vocabulary, "mild", "leve").
card(spanish_vocabulary, "mile", "milla").
card(spanish_vocabulary, "military", "militar").
card(spanish_vocabulary, "milk", "leche").
card(spanish_vocabulary, "million number", "millones de número").
card(spanish_vocabulary, "mind", "mente").
card(spanish_vocabulary, "mine (belongs to me)", "mío").
card(spanish_vocabulary, "mine (hole in the ground)", "mina").
card(spanish_vocabulary, "mineral", "mineral").
card(spanish_vocabulary, "minimum", "mínimo").
card(spanish_vocabulary, "minister", "ministro").
card(spanish_vocabulary, "minor", "menor").
card(spanish_vocabulary, "minority", "minoría").
card(spanish_vocabulary, "minute", "minuto").
card(spanish_vocabulary, "mirror", "espejo").
card(spanish_vocabulary, "miss", "perder").
card(spanish_vocabulary, "missing", "desaparecido").
card(spanish_vocabulary, "mission", "misión").
card(spanish_vocabulary, "mistake", "error").
card(spanish_vocabulary, "mix", "mezcla").
card(spanish_vocabulary, "mixed", "mezclado").
card(spanish_vocabulary, "mixture", "mezcla").
card(spanish_vocabulary, "mobile", "móvil").
card(spanish_vocabulary, "model", "modelo").
card(spanish_vocabulary, "modern", "moderno").
card(spanish_vocabulary, "modify", "modificar").
card(spanish_vocabulary, "moment", "momento").
card(spanish_vocabulary, "money", "dinero").
card(spanish_vocabulary, "monitor", "monitor").
card(spanish_vocabulary, "monkey", "mono").
card(spanish_vocabulary, "month", "mes").
card(spanish_vocabulary, "mood", "estado animico").
card(spanish_vocabulary, "moon", "luna").
card(spanish_vocabulary, "moral", "moral").
card(spanish_vocabulary, "more", "más").
card(spanish_vocabulary, "morning", "mañana").
card(spanish_vocabulary, "most", "más").
card(spanish_vocabulary, "mostly", "principalmente").
card(spanish_vocabulary, "mother", "madre").
card(spanish_vocabulary, "motor", "motor").
card(spanish_vocabulary, "motorcycle", "motocicleta").
card(spanish_vocabulary, "mount", "montar").
card(spanish_vocabulary, "mountain", "montaña").
card(spanish_vocabulary, "mouse", "ratón").
card(spanish_vocabulary, "mouth", "boca").
card(spanish_vocabulary, "move", "moverse").
card(spanish_vocabulary, "movement", "movimiento").
card(spanish_vocabulary, "movie", "película").
card(spanish_vocabulary, "much", "mucho").
card(spanish_vocabulary, "mud", "barro").
card(spanish_vocabulary, "multiple", "múltiple").
card(spanish_vocabulary, "multiply", "multiplicar").
card(spanish_vocabulary, "mum", "mamá").
card(spanish_vocabulary, "murder", "asesinato").
card(spanish_vocabulary, "muscle", "músculo").
card(spanish_vocabulary, "museum", "museo").
card(spanish_vocabulary, "music", "música").
card(spanish_vocabulary, "musical", "musical").
card(spanish_vocabulary, "musician", "músico").
card(spanish_vocabulary, "must modal", "debe modal").
card(spanish_vocabulary, "my", "mi").
card(spanish_vocabulary, "myself", "yo mismo").
card(spanish_vocabulary, "mysterious", "misterioso").
card(spanish_vocabulary, "mystery", "misterio").
card(spanish_vocabulary, "nail", "uña").
card(spanish_vocabulary, "name", "nombre").
card(spanish_vocabulary, "narrative", "narrativa").
card(spanish_vocabulary, "narrow", "estrecho").
card(spanish_vocabulary, "nation", "nación").
card(spanish_vocabulary, "national", "nacional").
card(spanish_vocabulary, "native", "nativo").
card(spanish_vocabulary, "natural", "natural").
card(spanish_vocabulary, "naturally", "naturalmente").
card(spanish_vocabulary, "nature", "naturaleza").
card(spanish_vocabulary, "near", "cerca").
card(spanish_vocabulary, "nearly", "casi").
card(spanish_vocabulary, "neat", "ordenado").
card(spanish_vocabulary, "necessarily", "necesariamente").
card(spanish_vocabulary, "necessary", "necesario").
card(spanish_vocabulary, "neck", "cuello").
card(spanish_vocabulary, "need", "necesitar").
card(spanish_vocabulary, "needle", "aguja").
card(spanish_vocabulary, "negative", "negativo").
card(spanish_vocabulary, "neighbor", "vecino").
card(spanish_vocabulary, "neighbourhood", "barrio").
card(spanish_vocabulary, "neither", "ninguno").
card(spanish_vocabulary, "nerve", "nervio").
card(spanish_vocabulary, "nervous", "nervioso").
card(spanish_vocabulary, "net", "red").
card(spanish_vocabulary, "network", "red").
card(spanish_vocabulary, "never", "nunca").
card(spanish_vocabulary, "nevertheless", "sin embargo").
card(spanish_vocabulary, "new", "nuevo").
card(spanish_vocabulary, "news", "noticias").
card(spanish_vocabulary, "newspaper", "periódico").
card(spanish_vocabulary, "next to", "cerca de").
card(spanish_vocabulary, "next", "siguiente").
card(spanish_vocabulary, "nice", "bonito").
card(spanish_vocabulary, "night", "noche").
card(spanish_vocabulary, "nightmare", "pesadilla").
card(spanish_vocabulary, "nine", "nueve").
card(spanish_vocabulary, "nineteen", "diecinueve").
card(spanish_vocabulary, "ninety", "noventa").
card(spanish_vocabulary, "no one", "ninguno").
card(spanish_vocabulary, "no", "no").
card(spanish_vocabulary, "nobody", "nadie").
card(spanish_vocabulary, "noise", "ruido").
card(spanish_vocabulary, "noisy", "ruidoso").
card(spanish_vocabulary, "none", "ninguna").
card(spanish_vocabulary, "nor", "ni").
card(spanish_vocabulary, "normal", "normal").
card(spanish_vocabulary, "normally", "normalmente").
card(spanish_vocabulary, "north", "norte").
card(spanish_vocabulary, "northern", "del Norte").
card(spanish_vocabulary, "nose", "nariz").
card(spanish_vocabulary, "not", "no").
card(spanish_vocabulary, "note", "nota").
card(spanish_vocabulary, "nothing", "nada").
card(spanish_vocabulary, "notice", "aviso").
card(spanish_vocabulary, "notion", "noción").
card(spanish_vocabulary, "novel", "novela").
card(spanish_vocabulary, "now", "ahora").
card(spanish_vocabulary, "nowhere", "en ninguna parte").
card(spanish_vocabulary, "nuclear", "nuclear").
card(spanish_vocabulary, "number", "número").
card(spanish_vocabulary, "numerous", "numeroso").
card(spanish_vocabulary, "nurse", "enfermera").
card(spanish_vocabulary, "nut", "nuez").
card(spanish_vocabulary, "obey", "obedecer").
card(spanish_vocabulary, "object", "objeto").
card(spanish_vocabulary, "objective", "objetivo").
card(spanish_vocabulary, "obligation", "obligación").
card(spanish_vocabulary, "observation", "observación").
card(spanish_vocabulary, "observe", "observar").
card(spanish_vocabulary, "obtain", "obtener").
card(spanish_vocabulary, "obvious", "obvio").
card(spanish_vocabulary, "obviously", "obviamente").
card(spanish_vocabulary, "occasion", "ocasión").
card(spanish_vocabulary, "occasionally", "de vez en cuando").
card(spanish_vocabulary, "occur", "ocurrir").
card(spanish_vocabulary, "ocean", "oceano").
card(spanish_vocabulary, "odd", "impar").
card(spanish_vocabulary, "of", "de").
card(spanish_vocabulary, "off", "apagado").
card(spanish_vocabulary, "offence", "ofensa").
card(spanish_vocabulary, "offend", "ofender").
card(spanish_vocabulary, "offensive", "ofensiva").
card(spanish_vocabulary, "offer", "oferta").
card(spanish_vocabulary, "office", "oficina").
card(spanish_vocabulary, "officer", "oficial").
card(spanish_vocabulary, "official", "oficial").
card(spanish_vocabulary, "often", "a menudo").
card(spanish_vocabulary, "oh", "oh").
card(spanish_vocabulary, "oil", "petróleo").
card(spanish_vocabulary, "old", "antiguo").
card(spanish_vocabulary, "old-fashioned", "anticuado").
card(spanish_vocabulary, "on", "en").
card(spanish_vocabulary, "once", "una vez").
card(spanish_vocabulary, "one", "uno").
card(spanish_vocabulary, "onion", "cebolla").
card(spanish_vocabulary, "online", "en línea").
card(spanish_vocabulary, "only", "solamente").
card(spanish_vocabulary, "onto", "sobre").
card(spanish_vocabulary, "open", "abierto").
card(spanish_vocabulary, "opening", "apertura").
card(spanish_vocabulary, "operate", "funcionar").
card(spanish_vocabulary, "operation", "operación").
card(spanish_vocabulary, "opinion", "opinión").
card(spanish_vocabulary, "opponent", "adversario").
card(spanish_vocabulary, "opportunity", "oportunidad").
card(spanish_vocabulary, "oppose", "oponerse a").
card(spanish_vocabulary, "opposed", "opuesto").
card(spanish_vocabulary, "opposite", "opuesto").
card(spanish_vocabulary, "opposition", "oposición").
card(spanish_vocabulary, "option", "opción").
card(spanish_vocabulary, "or", "o").
card(spanish_vocabulary, "orange", "naranja").
card(spanish_vocabulary, "order", "orden").
card(spanish_vocabulary, "ordinary", "ordinario").
card(spanish_vocabulary, "organ", "organo").
card(spanish_vocabulary, "organization", "organización").
card(spanish_vocabulary, "organize", "organizar").
card(spanish_vocabulary, "organized", "organizado").
card(spanish_vocabulary, "organizer", "organizador").
card(spanish_vocabulary, "origin", "origen").
card(spanish_vocabulary, "original", "original").
card(spanish_vocabulary, "originally", "originalmente").
card(spanish_vocabulary, "other", "otro").
card(spanish_vocabulary, "otherwise", "de otra manera").
card(spanish_vocabulary, "ought", "debería").
card(spanish_vocabulary, "our", "nuestro").
card(spanish_vocabulary, "ours", "la nuestra").
card(spanish_vocabulary, "ourselves", "nosotros mismos").
card(spanish_vocabulary, "out", "fuera").
card(spanish_vocabulary, "outcome", "salir").
card(spanish_vocabulary, "outdoor", "al aire libre").
card(spanish_vocabulary, "outdoors", "al aire libre").
card(spanish_vocabulary, "outer", "exterior").
card(spanish_vocabulary, "outline", "contorno").
card(spanish_vocabulary, "outside", "fuera de").
card(spanish_vocabulary, "oven", "horno").
card(spanish_vocabulary, "over", "encima").
card(spanish_vocabulary, "overall", "en general").
card(spanish_vocabulary, "owe", "deber").
card(spanish_vocabulary, "own", "propio").
card(spanish_vocabulary, "owner", "propietario").
card(spanish_vocabulary, "o’clock", "en punto").
card(spanish_vocabulary, "pace", "paso").
card(spanish_vocabulary, "pack", "paquete").
card(spanish_vocabulary, "package", "paquete").
card(spanish_vocabulary, "page", "página").
card(spanish_vocabulary, "pain", "dolor").
card(spanish_vocabulary, "painful", "doloroso").
card(spanish_vocabulary, "paint", "pintar").
card(spanish_vocabulary, "painter", "pintor").
card(spanish_vocabulary, "painting", "pintura").
card(spanish_vocabulary, "pair", "par").
card(spanish_vocabulary, "palace", "palacio").
card(spanish_vocabulary, "pale", "pálido").
card(spanish_vocabulary, "pan", "pan").
card(spanish_vocabulary, "panel", "panel").
card(spanish_vocabulary, "pants", "pantalones").
card(spanish_vocabulary, "paper", "papel").
card(spanish_vocabulary, "paragraph", "párrafo").
card(spanish_vocabulary, "parent", "padre").
card(spanish_vocabulary, "park", "parque").
card(spanish_vocabulary, "parking", "estacionamiento").
card(spanish_vocabulary, "parliament", "parlamento").
card(spanish_vocabulary, "part", "parte").
card(spanish_vocabulary, "participant", "partícipe").
card(spanish_vocabulary, "participate", "participar").
card(spanish_vocabulary, "particular", "especial").
card(spanish_vocabulary, "particularly", "particularmente").
card(spanish_vocabulary, "partly", "parcialmente").
card(spanish_vocabulary, "partner", "compañero").
card(spanish_vocabulary, "party", "partido").
card(spanish_vocabulary, "pass", "pasar").
card(spanish_vocabulary, "passage", "paso").
card(spanish_vocabulary, "passenger", "pasajero").
card(spanish_vocabulary, "passion", "pasión").
card(spanish_vocabulary, "passport", "pasaporte").
card(spanish_vocabulary, "past", "pasado").
card(spanish_vocabulary, "path", "camino").
card(spanish_vocabulary, "patient", "paciente").
card(spanish_vocabulary, "pattern", "patrón").
card(spanish_vocabulary, "pay", "pagar").
card(spanish_vocabulary, "payment", "pago").
card(spanish_vocabulary, "peace", "paz").
card(spanish_vocabulary, "peaceful", "pacífico").
card(spanish_vocabulary, "pen", "bolígrafo").
card(spanish_vocabulary, "pencil", "lápiz").
card(spanish_vocabulary, "penny", "centavo").
card(spanish_vocabulary, "pension", "pensión").
card(spanish_vocabulary, "people", "personas").
card(spanish_vocabulary, "pepper", "pimienta").
card(spanish_vocabulary, "per cent", "por ciento").
card(spanish_vocabulary, "per", "por").
card(spanish_vocabulary, "percentage", "porcentaje").
card(spanish_vocabulary, "perfect", "perfecto").
card(spanish_vocabulary, "perfectly", "perfectamente").
card(spanish_vocabulary, "perform", "realizar").
card(spanish_vocabulary, "performance", "actuación").
card(spanish_vocabulary, "perhaps", "quizás").
card(spanish_vocabulary, "period", "período").
card(spanish_vocabulary, "permanent", "permanente").
card(spanish_vocabulary, "permission", "permiso").
card(spanish_vocabulary, "permit", "permiso").
card(spanish_vocabulary, "person", "persona").
card(spanish_vocabulary, "personal", "personal").
card(spanish_vocabulary, "personality", "personalidad").
card(spanish_vocabulary, "personally", "personalmente").
card(spanish_vocabulary, "perspective", "perspectiva").
card(spanish_vocabulary, "persuade", "persuadir").
card(spanish_vocabulary, "pet", "mascota").
card(spanish_vocabulary, "petrol", "gasolina").
card(spanish_vocabulary, "phase", "fase").
card(spanish_vocabulary, "phenomenon", "fenómeno").
card(spanish_vocabulary, "philosophy", "filosofía").
card(spanish_vocabulary, "phone", "teléfono").
card(spanish_vocabulary, "photo", "foto").
card(spanish_vocabulary, "photograph", "fotografía").
card(spanish_vocabulary, "photographer", "fotógrafo").
card(spanish_vocabulary, "photography", "fotografía").
card(spanish_vocabulary, "phrase", "frase").
card(spanish_vocabulary, "physical", "físico").
card(spanish_vocabulary, "physics", "física").
card(spanish_vocabulary, "piano", "piano").
card(spanish_vocabulary, "pick", "recoger").
card(spanish_vocabulary, "picture", "imagen").
card(spanish_vocabulary, "piece", "trozo").
card(spanish_vocabulary, "pig", "cerdo").
card(spanish_vocabulary, "pile", "pila").
card(spanish_vocabulary, "pilot", "piloto").
card(spanish_vocabulary, "pin", "alfiler").
card(spanish_vocabulary, "pink", "rosado").
card(spanish_vocabulary, "pipe", "tubo").
card(spanish_vocabulary, "pitch", "tono").
card(spanish_vocabulary, "place", "sitio").
card(spanish_vocabulary, "plain", "llanura").
card(spanish_vocabulary, "plan", "plan").
card(spanish_vocabulary, "plane", "avión").
card(spanish_vocabulary, "planet", "planeta").
card(spanish_vocabulary, "planning", "planificación").
card(spanish_vocabulary, "plant", "planta").
card(spanish_vocabulary, "plastic", "el plastico").
card(spanish_vocabulary, "plate", "plato").
card(spanish_vocabulary, "platform", "plataforma").
card(spanish_vocabulary, "play", "jugar").
card(spanish_vocabulary, "player", "jugador").
card(spanish_vocabulary, "pleasant", "agradable").
card(spanish_vocabulary, "please", "por favor").
card(spanish_vocabulary, "pleased", "satisfecho").
card(spanish_vocabulary, "pleasure", "placer").
card(spanish_vocabulary, "plenty", "mucho").
card(spanish_vocabulary, "plot", "trama").
card(spanish_vocabulary, "plus", "más").
card(spanish_vocabulary, "pocket", "bolsillo").
card(spanish_vocabulary, "poem", "poema").
card(spanish_vocabulary, "poet", "poeta").
card(spanish_vocabulary, "poetry", "poesía").
card(spanish_vocabulary, "point", "punto").
card(spanish_vocabulary, "pointed", "puntiagudo").
card(spanish_vocabulary, "poison", "veneno").
card(spanish_vocabulary, "poisonous", "venenoso").
card(spanish_vocabulary, "police", "policía").
card(spanish_vocabulary, "policeman", "policía").
card(spanish_vocabulary, "policy", "política").
card(spanish_vocabulary, "polite", "cortés").
card(spanish_vocabulary, "political", "político").
card(spanish_vocabulary, "politician", "político").
card(spanish_vocabulary, "politics", "política").
card(spanish_vocabulary, "pollution", "contaminación").
card(spanish_vocabulary, "pool", "piscina").
card(spanish_vocabulary, "poor", "pobre").
card(spanish_vocabulary, "pop", "popular").
card(spanish_vocabulary, "popular", "popular").
card(spanish_vocabulary, "popularity", "popularidad").
card(spanish_vocabulary, "population", "población").
card(spanish_vocabulary, "port", "puerto").
card(spanish_vocabulary, "portrait", "retrato").
card(spanish_vocabulary, "pose", "pose").
card(spanish_vocabulary, "position", "posición").
card(spanish_vocabulary, "positive", "positivo").
card(spanish_vocabulary, "possess", "poseer").
card(spanish_vocabulary, "possession", "posesión").
card(spanish_vocabulary, "possibility", "posibilidad").
card(spanish_vocabulary, "possible", "posible").
card(spanish_vocabulary, "possibly", "posiblemente").
card(spanish_vocabulary, "post", "enviar").
card(spanish_vocabulary, "poster", "póster").
card(spanish_vocabulary, "pot", "maceta").
card(spanish_vocabulary, "potato", "patata").
card(spanish_vocabulary, "potential", "potencial").
card(spanish_vocabulary, "pound", "libra").
card(spanish_vocabulary, "pour", "verter").
card(spanish_vocabulary, "poverty", "pobreza").
card(spanish_vocabulary, "powder", "polvo").
card(spanish_vocabulary, "power", "poder").
card(spanish_vocabulary, "powerful", "poderoso").
card(spanish_vocabulary, "practical", "práctico").
card(spanish_vocabulary, "practice", "práctica").
card(spanish_vocabulary, "praise", "alabanza").
card(spanish_vocabulary, "pray", "orar").
card(spanish_vocabulary, "prayer", "oración").
card(spanish_vocabulary, "predict", "predecir").
card(spanish_vocabulary, "prediction", "predicción").
card(spanish_vocabulary, "prefer", "preferir").
card(spanish_vocabulary, "pregnant", "embarazada").
card(spanish_vocabulary, "preparation", "preparación").
card(spanish_vocabulary, "prepare", "preparar").
card(spanish_vocabulary, "prepared", "preparado").
card(spanish_vocabulary, "presence", "presencia").
card(spanish_vocabulary, "present", "presente").
card(spanish_vocabulary, "presentation", "presentación").
card(spanish_vocabulary, "preserve", "preservar").
card(spanish_vocabulary, "president", "presidente").
card(spanish_vocabulary, "press", "prensa").
card(spanish_vocabulary, "pressure", "presión").
card(spanish_vocabulary, "pretend", "fingir").
card(spanish_vocabulary, "pretty", "bonita").
card(spanish_vocabulary, "prevent", "evitar").
card(spanish_vocabulary, "previous", "anterior").
card(spanish_vocabulary, "previously", "previamente").
card(spanish_vocabulary, "price", "precio").
card(spanish_vocabulary, "priest", "sacerdote").
card(spanish_vocabulary, "primary", "primario").
card(spanish_vocabulary, "prime", "principal").
card(spanish_vocabulary, "prince", "príncipe").
card(spanish_vocabulary, "princess", "princesa").
card(spanish_vocabulary, "principle", "principio").
card(spanish_vocabulary, "print", "impresión").
card(spanish_vocabulary, "printer", "impresora").
card(spanish_vocabulary, "printing", "impresión").
card(spanish_vocabulary, "priority", "prioridad").
card(spanish_vocabulary, "prison", "prisión").
card(spanish_vocabulary, "prisoner", "prisionero").
card(spanish_vocabulary, "privacy", "intimidad").
card(spanish_vocabulary, "private", "privado").
card(spanish_vocabulary, "prize", "premio").
card(spanish_vocabulary, "probably", "probablemente").
card(spanish_vocabulary, "problem", "problema").
card(spanish_vocabulary, "procedure", "procedimiento").
card(spanish_vocabulary, "process", "proceso").
card(spanish_vocabulary, "produce", "produce").
card(spanish_vocabulary, "producer", "productor").
card(spanish_vocabulary, "product", "producto").
card(spanish_vocabulary, "production", "producción").
card(spanish_vocabulary, "profession", "profesión").
card(spanish_vocabulary, "professional", "profesional").
card(spanish_vocabulary, "professor", "profesor").
card(spanish_vocabulary, "profile", "perfil").
card(spanish_vocabulary, "profit", "lucro").
card(spanish_vocabulary, "program", "programa").
card(spanish_vocabulary, "progress", "progreso").
card(spanish_vocabulary, "project", "proyecto").
card(spanish_vocabulary, "promise", "promesa").
card(spanish_vocabulary, "promote", "promover").
card(spanish_vocabulary, "pronounce", "pronunciar").
card(spanish_vocabulary, "proof", "prueba").
card(spanish_vocabulary, "proper", "apropiado").
card(spanish_vocabulary, "properly", "correctamente").
card(spanish_vocabulary, "property", "propiedad").
card(spanish_vocabulary, "proposal", "propuesta").
card(spanish_vocabulary, "propose", "proponer").
card(spanish_vocabulary, "prospect", "perspectiva").
card(spanish_vocabulary, "protect", "proteger").
card(spanish_vocabulary, "protection", "proteccion").
card(spanish_vocabulary, "protest", "protesta").
card(spanish_vocabulary, "proud", "orgulloso").
card(spanish_vocabulary, "prove", "probar").
card(spanish_vocabulary, "provide", "proporcionar").
card(spanish_vocabulary, "psychologist", "psicólogo").
card(spanish_vocabulary, "psychology", "psicología").
card(spanish_vocabulary, "pub", "pub").
card(spanish_vocabulary, "public", "público").
card(spanish_vocabulary, "publication", "publicación").
card(spanish_vocabulary, "publish", "publicar").
card(spanish_vocabulary, "pull", "halar").
card(spanish_vocabulary, "punish", "castigar").
card(spanish_vocabulary, "punishment", "castigo").
card(spanish_vocabulary, "pupil", "alumno").
card(spanish_vocabulary, "purchase", "compra").
card(spanish_vocabulary, "pure", "puro").
card(spanish_vocabulary, "purple", "púrpura").
card(spanish_vocabulary, "purpose", "propósito").
card(spanish_vocabulary, "pursue", "perseguir").
card(spanish_vocabulary, "push", "empujar").
card(spanish_vocabulary, "put", "poner").
card(spanish_vocabulary, "qualification", "calificación").
card(spanish_vocabulary, "qualified", "calificado").
card(spanish_vocabulary, "qualify", "calificar").
card(spanish_vocabulary, "quality", "calidad").
card(spanish_vocabulary, "quantity", "cantidad").
card(spanish_vocabulary, "quarter", "trimestre").
card(spanish_vocabulary, "queen", "reina").
card(spanish_vocabulary, "question", "pregunta").
card(spanish_vocabulary, "queue", "cola").
card(spanish_vocabulary, "quick", "rápido").
card(spanish_vocabulary, "quickly", "con rapidez").
card(spanish_vocabulary, "quiet", "tranquilo").
card(spanish_vocabulary, "quietly", "tranquilamente").
card(spanish_vocabulary, "quit", "dejar").
card(spanish_vocabulary, "quite", "bastante").
card(spanish_vocabulary, "quotation", "cotización").
card(spanish_vocabulary, "quote", "citar").
card(spanish_vocabulary, "race (competition)", "carrera").
card(spanish_vocabulary, "race (people)", "raza").
card(spanish_vocabulary, "racing", "carreras").
card(spanish_vocabulary, "radio", "radio").
card(spanish_vocabulary, "railway", "ferrocarril").
card(spanish_vocabulary, "rain", "lluvia").
card(spanish_vocabulary, "raise", "aumento").
card(spanish_vocabulary, "range", "rango").
card(spanish_vocabulary, "rank", "rango").
card(spanish_vocabulary, "rapid", "rápido").
card(spanish_vocabulary, "rapidly", "rápidamente").
card(spanish_vocabulary, "rare", "raro").
card(spanish_vocabulary, "rarely", "raramente").
card(spanish_vocabulary, "rate", "velocidad").
card(spanish_vocabulary, "rather", "más bien").
card(spanish_vocabulary, "raw", "crudo").
card(spanish_vocabulary, "reach", "alcanzar").
card(spanish_vocabulary, "react", "reaccionar").
card(spanish_vocabulary, "reaction", "reacción").
card(spanish_vocabulary, "read", "leer").
card(spanish_vocabulary, "reader", "lector").
card(spanish_vocabulary, "reading", "leyendo").
card(spanish_vocabulary, "ready", "listo").
card(spanish_vocabulary, "real", "real").
card(spanish_vocabulary, "realistic", "realista").
card(spanish_vocabulary, "reality", "realidad").
card(spanish_vocabulary, "realize", "darse cuenta de").
card(spanish_vocabulary, "really", "de Verdad").
card(spanish_vocabulary, "reason", "razón").
card(spanish_vocabulary, "reasonable", "razonable").
card(spanish_vocabulary, "recall", "recordar").
card(spanish_vocabulary, "receipt", "recibo").
card(spanish_vocabulary, "receive", "recibir").
card(spanish_vocabulary, "recent", "reciente").
card(spanish_vocabulary, "recently", "recientemente").
card(spanish_vocabulary, "reception", "recepción").
card(spanish_vocabulary, "recipe", "receta").
card(spanish_vocabulary, "recognize", "reconocer").
card(spanish_vocabulary, "recommend", "recomendar").
card(spanish_vocabulary, "recommendation", "recomendación").
card(spanish_vocabulary, "record", "grabar").
card(spanish_vocabulary, "recording", "grabación").
card(spanish_vocabulary, "recover", "recuperar").
card(spanish_vocabulary, "recycle", "reciclar").
card(spanish_vocabulary, "red", "rojo").
card(spanish_vocabulary, "reduce", "reducir").
card(spanish_vocabulary, "reduction", "reducción").
card(spanish_vocabulary, "refer", "referir").
card(spanish_vocabulary, "reference", "referencia").
card(spanish_vocabulary, "reflect", "reflejar").
card(spanish_vocabulary, "refuse", "negar").
card(spanish_vocabulary, "regard", "considerar").
card(spanish_vocabulary, "region", "región").
card(spanish_vocabulary, "regional", "regional").
card(spanish_vocabulary, "register", "registrarse").
card(spanish_vocabulary, "regret", "lamentar").
card(spanish_vocabulary, "regular", "regular").
card(spanish_vocabulary, "regularly", "regularmente").
card(spanish_vocabulary, "regulation", "regulación").
card(spanish_vocabulary, "reject", "rechazar").
card(spanish_vocabulary, "relate", "relacionar").
card(spanish_vocabulary, "related", "relacionado").
card(spanish_vocabulary, "relation", "relación").
card(spanish_vocabulary, "relationship", "relación").
card(spanish_vocabulary, "relative", "relativo").
card(spanish_vocabulary, "relatively", "relativamente").
card(spanish_vocabulary, "relax", "relajarse").
card(spanish_vocabulary, "relaxed", "relajado").
card(spanish_vocabulary, "relaxing", "relajante").
card(spanish_vocabulary, "release", "lanzamiento").
card(spanish_vocabulary, "relevant", "pertinente").
card(spanish_vocabulary, "reliable", "de confianza").
card(spanish_vocabulary, "relief", "alivio").
card(spanish_vocabulary, "religion", "religión").
card(spanish_vocabulary, "religious", "religioso").
card(spanish_vocabulary, "rely", "confiar").
card(spanish_vocabulary, "remain", "permanecer").
card(spanish_vocabulary, "remark", "observación").
card(spanish_vocabulary, "remember", "recuerda").
card(spanish_vocabulary, "remind", "recordar").
card(spanish_vocabulary, "remote", "remoto").
card(spanish_vocabulary, "remove", "eliminar").
card(spanish_vocabulary, "rent", "alquilar").
card(spanish_vocabulary, "repair", "reparar").
card(spanish_vocabulary, "repeat", "repetir").
card(spanish_vocabulary, "repeated", "repetido").
card(spanish_vocabulary, "replace", "reemplazar").
card(spanish_vocabulary, "reply", "respuesta").
card(spanish_vocabulary, "report", "reporte").
card(spanish_vocabulary, "reporter", "reportero").
card(spanish_vocabulary, "represent", "representar").
card(spanish_vocabulary, "representative", "representante").
card(spanish_vocabulary, "reputation", "reputación").
card(spanish_vocabulary, "request", "solicitud").
card(spanish_vocabulary, "require", "exigir").
card(spanish_vocabulary, "requirement", "requisito").
card(spanish_vocabulary, "rescue", "rescate").
card(spanish_vocabulary, "research", "investigación").
card(spanish_vocabulary, "researcher", "investigador").
card(spanish_vocabulary, "reservation", "reserva").
card(spanish_vocabulary, "reserve", "reserva").
card(spanish_vocabulary, "resident", "residente").
card(spanish_vocabulary, "resist", "resistirse").
card(spanish_vocabulary, "resolve", "resolver").
card(spanish_vocabulary, "resource", "recurso").
card(spanish_vocabulary, "respect", "el respeto").
card(spanish_vocabulary, "respond", "responder").
card(spanish_vocabulary, "response", "respuesta").
card(spanish_vocabulary, "responsibility", "responsabilidad").
card(spanish_vocabulary, "responsible", "responsable").
card(spanish_vocabulary, "rest (remaining part)", "resto").
card(spanish_vocabulary, "rest (sleep/relax)", "descansar").
card(spanish_vocabulary, "restaurant", "restaurante").
card(spanish_vocabulary, "result", "resultado").
card(spanish_vocabulary, "retain", "conservar").
card(spanish_vocabulary, "retire", "jubilarse").
card(spanish_vocabulary, "retired", "retirado").
card(spanish_vocabulary, "return", "regreso").
card(spanish_vocabulary, "reveal", "revelar").
card(spanish_vocabulary, "review", "revisión").
card(spanish_vocabulary, "revise", "revisar").
card(spanish_vocabulary, "revolution", "revolución").
card(spanish_vocabulary, "reward", "recompensa").
card(spanish_vocabulary, "rhythm", "ritmo").
card(spanish_vocabulary, "rice", "arroz").
card(spanish_vocabulary, "rich", "rico").
card(spanish_vocabulary, "rid", "eliminar").
card(spanish_vocabulary, "ride", "paseo").
card(spanish_vocabulary, "right", "derecha").
card(spanish_vocabulary, "ring", "anillo").
card(spanish_vocabulary, "rise", "subir").
card(spanish_vocabulary, "risk", "riesgo").
card(spanish_vocabulary, "river", "río").
card(spanish_vocabulary, "road", "la carretera").
card(spanish_vocabulary, "robot", "robot").
card(spanish_vocabulary, "rock (music)", "la música rock)").
card(spanish_vocabulary, "rock (stone)", "roca").
card(spanish_vocabulary, "role", "papel").
card(spanish_vocabulary, "roll", "rodar").
card(spanish_vocabulary, "romantic", "romántico").
card(spanish_vocabulary, "roof", "techo").
card(spanish_vocabulary, "room", "habitación").
card(spanish_vocabulary, "root", "raíz").
card(spanish_vocabulary, "rope", "cuerda").
card(spanish_vocabulary, "rough", "áspero").
card(spanish_vocabulary, "round", "redondo").
card(spanish_vocabulary, "route", "ruta").
card(spanish_vocabulary, "routine", "rutina").
card(spanish_vocabulary, "row", "fila").
card(spanish_vocabulary, "royal", "real").
card(spanish_vocabulary, "rub", "frotar").
card(spanish_vocabulary, "rubber", "caucho").
card(spanish_vocabulary, "rubbish", "basura").
card(spanish_vocabulary, "rude", "grosero").
card(spanish_vocabulary, "rugby", "rugby").
card(spanish_vocabulary, "rule", "regla").
card(spanish_vocabulary, "run", "correr").
card(spanish_vocabulary, "runner", "corredor").
card(spanish_vocabulary, "running", "corriendo").
card(spanish_vocabulary, "rural", "rural").
card(spanish_vocabulary, "rush", "prisa").
card(spanish_vocabulary, "sad", "triste").
card(spanish_vocabulary, "sadly", "tristemente").
card(spanish_vocabulary, "safe", "seguro").
card(spanish_vocabulary, "safety", "la seguridad").
card(spanish_vocabulary, "sail", "vela").
card(spanish_vocabulary, "sailing", "navegación").
card(spanish_vocabulary, "sailor", "marinero").
card(spanish_vocabulary, "salad", "ensalada").
card(spanish_vocabulary, "salary", "salario").
card(spanish_vocabulary, "sale", "rebaja").
card(spanish_vocabulary, "salt", "sal").
card(spanish_vocabulary, "same", "mismo").
card(spanish_vocabulary, "sample", "muestra").
card(spanish_vocabulary, "sand", "arena").
card(spanish_vocabulary, "sandwich", "emparedado").
card(spanish_vocabulary, "satellite", "satélite").
card(spanish_vocabulary, "satisfied", "satisfecho").
card(spanish_vocabulary, "satisfy", "satisfacer").
card(spanish_vocabulary, "sauce", "salsa").
card(spanish_vocabulary, "save", "salvar").
card(spanish_vocabulary, "saving", "ahorro").
card(spanish_vocabulary, "say", "decir").
card(spanish_vocabulary, "scale", "escala").
card(spanish_vocabulary, "scan", "escanear").
card(spanish_vocabulary, "scared", "asustado").
card(spanish_vocabulary, "scary", "de miedo").
card(spanish_vocabulary, "scene", "escena").
card(spanish_vocabulary, "schedule", "calendario").
card(spanish_vocabulary, "scheme", "esquema").
card(spanish_vocabulary, "school", "colegio").
card(spanish_vocabulary, "science", "ciencias").
card(spanish_vocabulary, "scientific", "científico").
card(spanish_vocabulary, "scientist", "científico").
card(spanish_vocabulary, "score", "puntuación").
card(spanish_vocabulary, "scream", "gritar").
card(spanish_vocabulary, "screen", "pantalla").
card(spanish_vocabulary, "script", "guión").
card(spanish_vocabulary, "sculpture", "escultura").
card(spanish_vocabulary, "sea", "mar").
card(spanish_vocabulary, "search", "buscar").
card(spanish_vocabulary, "season", "temporada").
card(spanish_vocabulary, "seat", "asiento").
card(spanish_vocabulary, "second (next after the first)", "segundo").
card(spanish_vocabulary, "second (unit of time)", "segundo").
card(spanish_vocabulary, "secondary", "secundario").
card(spanish_vocabulary, "secondly", "en segundo lugar").
card(spanish_vocabulary, "secret", "secreto").
card(spanish_vocabulary, "secretary", "secretario").
card(spanish_vocabulary, "section", "sección").
card(spanish_vocabulary, "sector", "sector").
card(spanish_vocabulary, "secure", "seguro").
card(spanish_vocabulary, "security", "seguridad").
card(spanish_vocabulary, "see", "ver").
card(spanish_vocabulary, "seed", "semilla").
card(spanish_vocabulary, "seek", "buscar").
card(spanish_vocabulary, "seem", "parecer").
card(spanish_vocabulary, "select", "seleccione").
card(spanish_vocabulary, "selection", "selección").
card(spanish_vocabulary, "self", "yo").
card(spanish_vocabulary, "sell", "vender").
card(spanish_vocabulary, "send", "enviar").
card(spanish_vocabulary, "senior", "mayor").
card(spanish_vocabulary, "sense", "sentido").
card(spanish_vocabulary, "sensible", "sensato").
card(spanish_vocabulary, "sensitive", "sensible").
card(spanish_vocabulary, "sentence", "frase").
card(spanish_vocabulary, "separate", "separar").
card(spanish_vocabulary, "sequence", "secuencia").
card(spanish_vocabulary, "series", "serie").
card(spanish_vocabulary, "serious", "grave").
card(spanish_vocabulary, "seriously", "seriamente").
card(spanish_vocabulary, "servant", "servidor").
card(spanish_vocabulary, "serve", "servir").
card(spanish_vocabulary, "service", "servicio").
card(spanish_vocabulary, "session", "sesión").
card(spanish_vocabulary, "set (group)", "conjunto").
card(spanish_vocabulary, "set (put)", "dejar").
card(spanish_vocabulary, "setting", "ajuste").
card(spanish_vocabulary, "settle", "asentar").
card(spanish_vocabulary, "seven", "siete").
card(spanish_vocabulary, "seventeen", "de diecisiete").
card(spanish_vocabulary, "seventy", "setenta").
card(spanish_vocabulary, "several", "varios").
card(spanish_vocabulary, "severe", "grave").
card(spanish_vocabulary, "sex", "sexo").
card(spanish_vocabulary, "sexual", "sexual").
card(spanish_vocabulary, "shade", "sombra").
card(spanish_vocabulary, "shadow", "sombra").
card(spanish_vocabulary, "shake", "sacudir").
card(spanish_vocabulary, "shall", "deberá").
card(spanish_vocabulary, "shallow", "superficial").
card(spanish_vocabulary, "shame", "vergüenza").
card(spanish_vocabulary, "shape", "forma").
card(spanish_vocabulary, "share", "compartir").
card(spanish_vocabulary, "sharp", "agudo").
card(spanish_vocabulary, "she", "ella").
card(spanish_vocabulary, "sheep", "oveja").
card(spanish_vocabulary, "sheet", "sábana").
card(spanish_vocabulary, "shelf", "estante").
card(spanish_vocabulary, "shell", "cáscara").
card(spanish_vocabulary, "shelter", "abrigo").
card(spanish_vocabulary, "shift", "cambio").
card(spanish_vocabulary, "shine", "brillar").
card(spanish_vocabulary, "shiny", "brillante").
card(spanish_vocabulary, "ship", "embarcacion").
card(spanish_vocabulary, "shirt", "camisa").
card(spanish_vocabulary, "shock", "conmoción").
card(spanish_vocabulary, "shocked", "conmocionado").
card(spanish_vocabulary, "shoe", "zapato").
card(spanish_vocabulary, "shoot", "disparar").
card(spanish_vocabulary, "shooting", "disparo").
card(spanish_vocabulary, "shop", "tienda").
card(spanish_vocabulary, "shopping", "compras").
card(spanish_vocabulary, "short", "corto").
card(spanish_vocabulary, "shot", "disparo").
card(spanish_vocabulary, "should", "debería").
card(spanish_vocabulary, "shoulder", "hombro").
card(spanish_vocabulary, "shout", "gritar").
card(spanish_vocabulary, "show", "espectáculo").
card(spanish_vocabulary, "shower", "ducha").
card(spanish_vocabulary, "shut", "cerrar").
card(spanish_vocabulary, "shy", "tímido").
card(spanish_vocabulary, "sick", "enfermo").
card(spanish_vocabulary, "side", "lado").
card(spanish_vocabulary, "sight", "visión").
card(spanish_vocabulary, "sign", "firmar").
card(spanish_vocabulary, "signal", "señal").
card(spanish_vocabulary, "significant", "significativo").
card(spanish_vocabulary, "significantly", "significativamente").
card(spanish_vocabulary, "silence", "silencio").
card(spanish_vocabulary, "silent", "silencio").
card(spanish_vocabulary, "silk", "seda").
card(spanish_vocabulary, "silly", "tonto").
card(spanish_vocabulary, "silver", "plata").
card(spanish_vocabulary, "similar", "similar").
card(spanish_vocabulary, "similarity", "semejanza").
card(spanish_vocabulary, "similarly", "similar").
card(spanish_vocabulary, "simple", "sencillo").
card(spanish_vocabulary, "simply", "simplemente").
card(spanish_vocabulary, "since", "ya que").
card(spanish_vocabulary, "sincere", "sincero").
card(spanish_vocabulary, "sing", "canta").
card(spanish_vocabulary, "singer", "cantante").
card(spanish_vocabulary, "singing", "canto").
card(spanish_vocabulary, "single", "soltero").
card(spanish_vocabulary, "sink", "lavabo").
card(spanish_vocabulary, "sir", "señor").
card(spanish_vocabulary, "sister", "hermana").
card(spanish_vocabulary, "sit", "sentar").
card(spanish_vocabulary, "site", "sitio").
card(spanish_vocabulary, "situation", "situación").
card(spanish_vocabulary, "six", "seis").
card(spanish_vocabulary, "sixteen", "dieciséis").
card(spanish_vocabulary, "sixty", "sesenta").
card(spanish_vocabulary, "size", "talla").
card(spanish_vocabulary, "ski", "esquí").
card(spanish_vocabulary, "skiing", "esquí").
card(spanish_vocabulary, "skill", "habilidad").
card(spanish_vocabulary, "skin", "piel").
card(spanish_vocabulary, "skirt", "falda").
card(spanish_vocabulary, "sky", "cielo").
card(spanish_vocabulary, "slave", "esclavo").
card(spanish_vocabulary, "sleep", "dormir").
card(spanish_vocabulary, "slice", "rebanada").
card(spanish_vocabulary, "slide", "diapositiva").
card(spanish_vocabulary, "slight", "leve").
card(spanish_vocabulary, "slightly", "ligeramente").
card(spanish_vocabulary, "slip", "resbalón").
card(spanish_vocabulary, "slope", "pendiente").
card(spanish_vocabulary, "slow", "lento").
card(spanish_vocabulary, "slowly", "despacio").
card(spanish_vocabulary, "small", "pequeña").
card(spanish_vocabulary, "smart", "inteligente").
card(spanish_vocabulary, "smartphone", "teléfono inteligente").
card(spanish_vocabulary, "smell", "oler").
card(spanish_vocabulary, "smile", "sonreír").
card(spanish_vocabulary, "smoke", "fumar").
card(spanish_vocabulary, "smoking", "de fumar").
card(spanish_vocabulary, "smooth", "suave").
card(spanish_vocabulary, "snake", "serpiente").
card(spanish_vocabulary, "snow", "nieve").
card(spanish_vocabulary, "so", "entonces").
card(spanish_vocabulary, "soap", "jabón").
card(spanish_vocabulary, "soccer", "fútbol").
card(spanish_vocabulary, "social", "social").
card(spanish_vocabulary, "society", "sociedad").
card(spanish_vocabulary, "sock", "calcetín").
card(spanish_vocabulary, "soft", "suave").
card(spanish_vocabulary, "software", "software").
card(spanish_vocabulary, "soil", "suelo").
card(spanish_vocabulary, "solar", "solar").
card(spanish_vocabulary, "soldier", "soldado").
card(spanish_vocabulary, "solid", "sólido").
card(spanish_vocabulary, "solution", "solución").
card(spanish_vocabulary, "solve", "resolver").
card(spanish_vocabulary, "some", "algunos").
card(spanish_vocabulary, "somebody", "alguien").
card(spanish_vocabulary, "someone", "alguien").
card(spanish_vocabulary, "something", "alguna cosa").
card(spanish_vocabulary, "sometimes", "algunas veces").
card(spanish_vocabulary, "somewhat", "algo").
card(spanish_vocabulary, "somewhere", "algun lado").
card(spanish_vocabulary, "son", "hijo").
card(spanish_vocabulary, "song", "canción").
card(spanish_vocabulary, "soon", "pronto").
card(spanish_vocabulary, "sorry", "lo siento").
card(spanish_vocabulary, "sort", "ordenar").
card(spanish_vocabulary, "soul", "alma").
card(spanish_vocabulary, "sound", "sonido").
card(spanish_vocabulary, "soup", "sopa").
card(spanish_vocabulary, "source", "fuente").
card(spanish_vocabulary, "south", "sur").
card(spanish_vocabulary, "southern", "del Sur").
card(spanish_vocabulary, "space", "espacio").
card(spanish_vocabulary, "speak", "hablar").
card(spanish_vocabulary, "speaker", "altavoz").
card(spanish_vocabulary, "special", "especial").
card(spanish_vocabulary, "specialist", "especialista").
card(spanish_vocabulary, "species", "especies").
card(spanish_vocabulary, "specific", "específico").
card(spanish_vocabulary, "specifically", "específicamente").
card(spanish_vocabulary, "speech", "habla").
card(spanish_vocabulary, "speed", "velocidad").
card(spanish_vocabulary, "spell", "deletrear").
card(spanish_vocabulary, "spelling", "ortografía").
card(spanish_vocabulary, "spend", "gastar").
card(spanish_vocabulary, "spending", "gasto").
card(spanish_vocabulary, "spicy", "picante").
card(spanish_vocabulary, "spider", "araña").
card(spanish_vocabulary, "spirit", "espíritu").
card(spanish_vocabulary, "spiritual", "espiritual").
card(spanish_vocabulary, "split", "división").
card(spanish_vocabulary, "spoken", "hablado").
card(spanish_vocabulary, "sponsor", "patrocinador").
card(spanish_vocabulary, "spoon", "cuchara").
card(spanish_vocabulary, "sport", "deporte").
card(spanish_vocabulary, "spot", "mancha").
card(spanish_vocabulary, "spread", "propagar").
card(spanish_vocabulary, "spring", "primavera").
card(spanish_vocabulary, "square", "cuadrado").
card(spanish_vocabulary, "stable", "estable").
card(spanish_vocabulary, "stadium", "estadio").
card(spanish_vocabulary, "staff", "personal").
card(spanish_vocabulary, "stage", "etapa").
card(spanish_vocabulary, "stair", "escalera").
card(spanish_vocabulary, "stamp", "sello").
card(spanish_vocabulary, "stand", "estar").
card(spanish_vocabulary, "standard", "estándar").
card(spanish_vocabulary, "star", "estrella").
card(spanish_vocabulary, "stare", "mirar fijamente").
card(spanish_vocabulary, "start", "comienzo").
card(spanish_vocabulary, "state", "estado").
card(spanish_vocabulary, "statement", "declaración").
card(spanish_vocabulary, "station", "estación").
card(spanish_vocabulary, "statistic", "estadística").
card(spanish_vocabulary, "statue", "estatua").
card(spanish_vocabulary, "status", "estado").
card(spanish_vocabulary, "stay", "permanecer").
card(spanish_vocabulary, "steady", "estable").
card(spanish_vocabulary, "steal", "robar").
card(spanish_vocabulary, "steel", "acero").
card(spanish_vocabulary, "steep", "escarpado").
card(spanish_vocabulary, "step", "paso").
card(spanish_vocabulary, "stick (piece of wood)", "palo").
card(spanish_vocabulary, "stick (push into/attach)", "metar").
card(spanish_vocabulary, "sticky", "pegajoso").
card(spanish_vocabulary, "stiff", "rígido").
card(spanish_vocabulary, "still", "todavía").
card(spanish_vocabulary, "stock", "valores").
card(spanish_vocabulary, "stomach", "estómago").
card(spanish_vocabulary, "stone", "piedra; roca").
card(spanish_vocabulary, "stop", "detener").
card(spanish_vocabulary, "store", "tienda").
card(spanish_vocabulary, "storm", "tormenta").
card(spanish_vocabulary, "story", "historia").
card(spanish_vocabulary, "straight", "derecho").
card(spanish_vocabulary, "strange", "extraño").
card(spanish_vocabulary, "stranger", "desconocido").
card(spanish_vocabulary, "strategy", "estrategia").
card(spanish_vocabulary, "stream", "corriente").
card(spanish_vocabulary, "street", "calle").
card(spanish_vocabulary, "strength", "fuerza").
card(spanish_vocabulary, "stress", "estrés").
card(spanish_vocabulary, "stretch", "tramo").
card(spanish_vocabulary, "strict", "estricto").
card(spanish_vocabulary, "strike", "huelga").
card(spanish_vocabulary, "string", "cuerda").
card(spanish_vocabulary, "strong", "fuerte").
card(spanish_vocabulary, "strongly", "fuertemente").
card(spanish_vocabulary, "structure", "estructura").
card(spanish_vocabulary, "struggle", "dificil").
card(spanish_vocabulary, "student", "estudiante").
card(spanish_vocabulary, "studio", "estudio").
card(spanish_vocabulary, "study", "estudiar").
card(spanish_vocabulary, "stuff", "cosas").
card(spanish_vocabulary, "stupid", "estúpido").
card(spanish_vocabulary, "style", "estilo").
card(spanish_vocabulary, "subject", "tema").
card(spanish_vocabulary, "submit", "enviar").
card(spanish_vocabulary, "substance", "sustancia").
card(spanish_vocabulary, "succeed", "tener éxito").
card(spanish_vocabulary, "success", "éxito").
card(spanish_vocabulary, "successful", "exitoso").
card(spanish_vocabulary, "successfully", "exitosamente").
card(spanish_vocabulary, "such", "tal").
card(spanish_vocabulary, "sudden", "repentino").
card(spanish_vocabulary, "suddenly", "repentinamente").
card(spanish_vocabulary, "suffer", "sufrir").
card(spanish_vocabulary, "sugar", "azúcar").
card(spanish_vocabulary, "suggest", "sugerir").
card(spanish_vocabulary, "suggestion", "sugerencia").
card(spanish_vocabulary, "suit", "traje").
card(spanish_vocabulary, "suitable", "adecuado").
card(spanish_vocabulary, "sum", "suma").
card(spanish_vocabulary, "summarize", "resumir").
card(spanish_vocabulary, "summary", "resumen").
card(spanish_vocabulary, "summer", "verano").
card(spanish_vocabulary, "sun", "dom").
card(spanish_vocabulary, "supermarket", "supermercado").
card(spanish_vocabulary, "supply", "suministro").
card(spanish_vocabulary, "support", "apoyo").
card(spanish_vocabulary, "supporter", "seguidor").
card(spanish_vocabulary, "suppose", "suponer").
card(spanish_vocabulary, "sure", "por supuesto").
card(spanish_vocabulary, "surely", "seguramente").
card(spanish_vocabulary, "surface", "superficie").
card(spanish_vocabulary, "surgery", "cirugía").
card(spanish_vocabulary, "surprise", "sorpresa").
card(spanish_vocabulary, "surprised", "sorprendido").
card(spanish_vocabulary, "surprising", "sorprendente").
card(spanish_vocabulary, "surround", "rodear").
card(spanish_vocabulary, "surrounding", "rodeando").
card(spanish_vocabulary, "survey", "encuesta").
card(spanish_vocabulary, "survive", "sobrevivir").
card(spanish_vocabulary, "suspect", "sospechar").
card(spanish_vocabulary, "swear", "jurar").
card(spanish_vocabulary, "sweater", "suéter").
card(spanish_vocabulary, "sweep", "barrer").
card(spanish_vocabulary, "sweet", "dulce").
card(spanish_vocabulary, "swim", "nadar").
card(spanish_vocabulary, "swimming", "nadando").
card(spanish_vocabulary, "switch", "cambiar").
card(spanish_vocabulary, "symbol", "símbolo").
card(spanish_vocabulary, "sympathy", "simpatía").
card(spanish_vocabulary, "symptom", "síntoma").
card(spanish_vocabulary, "system", "sistema").
card(spanish_vocabulary, "table", "mesa").
card(spanish_vocabulary, "tablet", "tableta").
card(spanish_vocabulary, "tail", "cola").
card(spanish_vocabulary, "take", "tomar").
card(spanish_vocabulary, "tale", "cuento").
card(spanish_vocabulary, "talent", "talento").
card(spanish_vocabulary, "talented", "talentoso").
card(spanish_vocabulary, "talk", "hablar").
card(spanish_vocabulary, "tall", "alto").
card(spanish_vocabulary, "tank", "tanque").
card(spanish_vocabulary, "tape", "cinta").
card(spanish_vocabulary, "target", "objetivo").
card(spanish_vocabulary, "task", "tarea").
card(spanish_vocabulary, "taste", "gusto").
card(spanish_vocabulary, "tax", "impuesto").
card(spanish_vocabulary, "taxi", "taxi").
card(spanish_vocabulary, "tea", "té").
card(spanish_vocabulary, "teach", "enseñar").
card(spanish_vocabulary, "teacher", "profesor").
card(spanish_vocabulary, "teaching", "enseñando").
card(spanish_vocabulary, "team", "equipo").
card(spanish_vocabulary, "technical", "técnico").
card(spanish_vocabulary, "technique", "técnica").
card(spanish_vocabulary, "technology", "tecnología").
card(spanish_vocabulary, "teenage", "adolescente").
card(spanish_vocabulary, "teenager", "adolescente").
card(spanish_vocabulary, "telephone", "teléfono").
card(spanish_vocabulary, "television", "televisión").
card(spanish_vocabulary, "tell", "contar").
card(spanish_vocabulary, "temperature", "temperatura").
card(spanish_vocabulary, "temporary", "temporal").
card(spanish_vocabulary, "ten", "diez").
card(spanish_vocabulary, "tend", "tender").
card(spanish_vocabulary, "tennis", "tenis").
card(spanish_vocabulary, "tent", "tienda").
card(spanish_vocabulary, "term", "término").
card(spanish_vocabulary, "terrible", "terrible").
card(spanish_vocabulary, "test", "prueba").
card(spanish_vocabulary, "text", "texto").
card(spanish_vocabulary, "than", "que").
card(spanish_vocabulary, "thank", "gracias").
card(spanish_vocabulary, "thanks", "gracias").
card(spanish_vocabulary, "that", "ese").
card(spanish_vocabulary, "the", "el").
card(spanish_vocabulary, "theater", "teatro").
card(spanish_vocabulary, "their", "su").
card(spanish_vocabulary, "theirs", "suyo").
card(spanish_vocabulary, "them", "ellos").
card(spanish_vocabulary, "theme", "tema").
card(spanish_vocabulary, "themselves", "sí mismos").
card(spanish_vocabulary, "then", "luego").
card(spanish_vocabulary, "theory", "teoría").
card(spanish_vocabulary, "therapy", "terapia").
card(spanish_vocabulary, "there", "ahí").
card(spanish_vocabulary, "therefore", "por lo tanto").
card(spanish_vocabulary, "they", "ellos").
card(spanish_vocabulary, "thick", "grueso").
card(spanish_vocabulary, "thief", "ladrón").
card(spanish_vocabulary, "thin", "delgado").
card(spanish_vocabulary, "thing", "cosa").
card(spanish_vocabulary, "think", "pensar").
card(spanish_vocabulary, "thinking", "pensando").
card(spanish_vocabulary, "third", "tercero").
card(spanish_vocabulary, "thirsty", "sediento").
card(spanish_vocabulary, "thirteen", "trece").
card(spanish_vocabulary, "thirty", "treinta").
card(spanish_vocabulary, "this", "esta").
card(spanish_vocabulary, "though", "aunque").
card(spanish_vocabulary, "thought", "pensamiento").
card(spanish_vocabulary, "thousand", "mil").
card(spanish_vocabulary, "threat", "amenaza").
card(spanish_vocabulary, "threaten", "amenazar").
card(spanish_vocabulary, "three", "tres").
card(spanish_vocabulary, "throat", "garganta").
card(spanish_vocabulary, "through", "mediante").
card(spanish_vocabulary, "throughout", "en todo").
card(spanish_vocabulary, "throw", "lanzar").
card(spanish_vocabulary, "thus", "así").
card(spanish_vocabulary, "ticket", "boleto").
card(spanish_vocabulary, "tidy", "ordenado").
card(spanish_vocabulary, "tie", "corbata").
card(spanish_vocabulary, "tight", "apretado").
card(spanish_vocabulary, "till", "hasta que").
card(spanish_vocabulary, "time", "hora").
card(spanish_vocabulary, "tin", "estaño").
card(spanish_vocabulary, "tiny", "minúsculo").
card(spanish_vocabulary, "tip", "propina").
card(spanish_vocabulary, "tire (wheel)", "neumático").
card(spanish_vocabulary, "tired", "cansado").
card(spanish_vocabulary, "title", "título").
card(spanish_vocabulary, "to", "a").
card(spanish_vocabulary, "today", "hoy").
card(spanish_vocabulary, "toe", "dedo del pie").
card(spanish_vocabulary, "together", "juntos").
card(spanish_vocabulary, "toilet", "baño").
card(spanish_vocabulary, "tomato", "tomate").
card(spanish_vocabulary, "tomorrow", "mañana").
card(spanish_vocabulary, "tone", "tono").
card(spanish_vocabulary, "tongue", "lengua").
card(spanish_vocabulary, "tonight", "esta noche").
card(spanish_vocabulary, "too", "también").
card(spanish_vocabulary, "tool", "herramienta").
card(spanish_vocabulary, "tooth", "diente").
card(spanish_vocabulary, "top", "parte superior").
card(spanish_vocabulary, "topic", "tema").
card(spanish_vocabulary, "total", "total").
card(spanish_vocabulary, "totally", "totalmente").
card(spanish_vocabulary, "touch", "toque").
card(spanish_vocabulary, "tough", "difícil").
card(spanish_vocabulary, "tour", "excursión").
card(spanish_vocabulary, "tourism", "turismo").
card(spanish_vocabulary, "tourist", "turista").
card(spanish_vocabulary, "towards", "hacia").
card(spanish_vocabulary, "towel", "toalla").
card(spanish_vocabulary, "tower", "torre").
card(spanish_vocabulary, "town", "pueblo").
card(spanish_vocabulary, "toy", "juguete").
card(spanish_vocabulary, "track", "pista").
card(spanish_vocabulary, "trade", "comercio").
card(spanish_vocabulary, "tradition", "tradicion").
card(spanish_vocabulary, "traditional", "tradicional").
card(spanish_vocabulary, "traffic", "tráfico").
card(spanish_vocabulary, "train", "entrenar").
card(spanish_vocabulary, "trainer", "entrenador").
card(spanish_vocabulary, "training", "formación").
card(spanish_vocabulary, "transfer", "transferir").
card(spanish_vocabulary, "transform", "transformar").
card(spanish_vocabulary, "transition", "transición").
card(spanish_vocabulary, "translate", "traducir").
card(spanish_vocabulary, "translation", "traducción").
card(spanish_vocabulary, "transport", "transporte").
card(spanish_vocabulary, "travel", "viaje").
card(spanish_vocabulary, "traveler", "viajero").
card(spanish_vocabulary, "treat", "tratar").
card(spanish_vocabulary, "treatment", "tratamiento").
card(spanish_vocabulary, "tree", "árbol").
card(spanish_vocabulary, "trend", "tendencia").
card(spanish_vocabulary, "trial", "juicio").
card(spanish_vocabulary, "trick", "truco").
card(spanish_vocabulary, "trip", "viaje").
card(spanish_vocabulary, "tropical", "tropical").
card(spanish_vocabulary, "trouble", "problema").
card(spanish_vocabulary, "trousers", "pantalones").
card(spanish_vocabulary, "truck", "camión").
card(spanish_vocabulary, "true", "cierto").
card(spanish_vocabulary, "truly", "verdaderamente").
card(spanish_vocabulary, "trust", "confiar").
card(spanish_vocabulary, "truth", "verdad").
card(spanish_vocabulary, "try", "tratar").
card(spanish_vocabulary, "tube", "tubo").
card(spanish_vocabulary, "tune", "melodía").
card(spanish_vocabulary, "tunnel", "túnel").
card(spanish_vocabulary, "turn", "giro").
card(spanish_vocabulary, "twelve", "doce").
card(spanish_vocabulary, "twenty", "veinte").
card(spanish_vocabulary, "twice", "dos veces").
card(spanish_vocabulary, "twin", "gemelo").
card(spanish_vocabulary, "two", "dos").
card(spanish_vocabulary, "type", "tipo").
card(spanish_vocabulary, "typical", "típico").
card(spanish_vocabulary, "typically", "típicamente").
card(spanish_vocabulary, "ugly", "feo").
card(spanish_vocabulary, "ultimately", "por último").
card(spanish_vocabulary, "umbrella", "paraguas").
card(spanish_vocabulary, "unable", "incapaz").
card(spanish_vocabulary, "uncle", "tío").
card(spanish_vocabulary, "uncomfortable", "incómodo").
card(spanish_vocabulary, "unconscious", "inconsciente").
card(spanish_vocabulary, "under", "debajo").
card(spanish_vocabulary, "underground", "subterráneo").
card(spanish_vocabulary, "understand", "entender").
card(spanish_vocabulary, "understanding", "comprensión").
card(spanish_vocabulary, "underwear", "ropa interior").
card(spanish_vocabulary, "unemployed", "desempleados").
card(spanish_vocabulary, "unemployment", "desempleo").
card(spanish_vocabulary, "unexpected", "inesperado").
card(spanish_vocabulary, "unfair", "injusto").
card(spanish_vocabulary, "unfortunately", "desafortunadamente").
card(spanish_vocabulary, "unhappy", "infeliz").
card(spanish_vocabulary, "uniform", "uniforme").
card(spanish_vocabulary, "union", "unión").
card(spanish_vocabulary, "unique", "único").
card(spanish_vocabulary, "unit", "unidad").
card(spanish_vocabulary, "united", "unido").
card(spanish_vocabulary, "universe", "universo").
card(spanish_vocabulary, "university", "universidad").
card(spanish_vocabulary, "unknown", "desconocido").
card(spanish_vocabulary, "unless", "a no ser que").
card(spanish_vocabulary, "unlike", "diferente a").
card(spanish_vocabulary, "unlikely", "improbable").
card(spanish_vocabulary, "unnecessary", "innecesario").
card(spanish_vocabulary, "unpleasant", "desagradable").
card(spanish_vocabulary, "until", "hasta").
card(spanish_vocabulary, "unusual", "raro").
card(spanish_vocabulary, "up", "arriba").
card(spanish_vocabulary, "update", "actualizar").
card(spanish_vocabulary, "upon", "sobre").
card(spanish_vocabulary, "upper", "superior").
card(spanish_vocabulary, "upset", "trastornado").
card(spanish_vocabulary, "upstairs", "piso de arriba").
card(spanish_vocabulary, "upwards", "hacia arriba").
card(spanish_vocabulary, "urban", "urbano").
card(spanish_vocabulary, "urge", "impulso").
card(spanish_vocabulary, "us", "nos").
card(spanish_vocabulary, "use", "utilizar").
card(spanish_vocabulary, "used to", "acostumbrado a").
card(spanish_vocabulary, "used", "usado").
card(spanish_vocabulary, "useful", "útil").
card(spanish_vocabulary, "user", "usuario").
card(spanish_vocabulary, "usual", "usual").
card(spanish_vocabulary, "usually", "generalmente").
card(spanish_vocabulary, "vacation", "vacaciones").
card(spanish_vocabulary, "valley", "valle").
card(spanish_vocabulary, "valuable", "valioso").
card(spanish_vocabulary, "value", "valor").
card(spanish_vocabulary, "van", "camioneta").
card(spanish_vocabulary, "variety", "variedad").
card(spanish_vocabulary, "various", "varios").
card(spanish_vocabulary, "vary", "variar").
card(spanish_vocabulary, "vast", "vasto").
card(spanish_vocabulary, "vegetable", "vegetal").
card(spanish_vocabulary, "vehicle", "vehículo").
card(spanish_vocabulary, "venue", "lugar de eventos").
card(spanish_vocabulary, "version", "versión").
card(spanish_vocabulary, "very", "muy").
card(spanish_vocabulary, "via", "vía").
card(spanish_vocabulary, "victim", "víctima").
card(spanish_vocabulary, "victory", "victoria").
card(spanish_vocabulary, "video", "vídeo").
card(spanish_vocabulary, "view", "ver").
card(spanish_vocabulary, "viewer", "espectador").
card(spanish_vocabulary, "village", "pueblo").
card(spanish_vocabulary, "violence", "violencia").
card(spanish_vocabulary, "violent", "violento").
card(spanish_vocabulary, "virtual", "virtual").
card(spanish_vocabulary, "virus", "virus").
card(spanish_vocabulary, "vision", "visión").
card(spanish_vocabulary, "visit", "visitar").
card(spanish_vocabulary, "visitor", "visitante").
card(spanish_vocabulary, "visual", "visual").
card(spanish_vocabulary, "vital", "vital").
card(spanish_vocabulary, "vitamin", "vitamina").
card(spanish_vocabulary, "voice", "voz").
card(spanish_vocabulary, "volume", "volumen").
card(spanish_vocabulary, "volunteer", "voluntario").
card(spanish_vocabulary, "vote", "votar").
card(spanish_vocabulary, "wage", "salario").
card(spanish_vocabulary, "wait", "espere").
card(spanish_vocabulary, "waiter", "camarero").
card(spanish_vocabulary, "wake", "despertar").
card(spanish_vocabulary, "walk", "caminar").
card(spanish_vocabulary, "wall", "pared").
card(spanish_vocabulary, "want", "querer").
card(spanish_vocabulary, "war", "guerra").
card(spanish_vocabulary, "warm", "calentar").
card(spanish_vocabulary, "warn", "advertir").
card(spanish_vocabulary, "warning", "advertencia").
card(spanish_vocabulary, "wash", "lavar").
card(spanish_vocabulary, "washing", "lavado").
card(spanish_vocabulary, "waste", "residuos").
card(spanish_vocabulary, "watch", "reloj").
card(spanish_vocabulary, "water", "agua").
card(spanish_vocabulary, "wave", "ola").
card(spanish_vocabulary, "way", "camino").
card(spanish_vocabulary, "we", "nosotros").
card(spanish_vocabulary, "weak", "débiles").
card(spanish_vocabulary, "weakness", "debilidad").
card(spanish_vocabulary, "wealth", "riqueza").
card(spanish_vocabulary, "wealthy", "rico").
card(spanish_vocabulary, "weapon", "arma").
card(spanish_vocabulary, "wear", "vestir").
card(spanish_vocabulary, "weather", "clima").
card(spanish_vocabulary, "web", "web").
card(spanish_vocabulary, "website", "sitio web").
card(spanish_vocabulary, "wedding", "boda").
card(spanish_vocabulary, "week", "semana").
card(spanish_vocabulary, "weekend", "fin de semana").
card(spanish_vocabulary, "weigh", "pesar").
card(spanish_vocabulary, "weight", "peso").
card(spanish_vocabulary, "welcome", "bienvenidos").
card(spanish_vocabulary, "well", "bien").
card(spanish_vocabulary, "west", "oeste").
card(spanish_vocabulary, "western", "occidental").
card(spanish_vocabulary, "wet", "mojado").
card(spanish_vocabulary, "what", "qué").
card(spanish_vocabulary, "whatever", "lo que sea").
card(spanish_vocabulary, "wheel", "rueda").
card(spanish_vocabulary, "when", "cuando").
card(spanish_vocabulary, "whenever", "cuando").
card(spanish_vocabulary, "where", "dónde").
card(spanish_vocabulary, "whereas", "mientras").
card(spanish_vocabulary, "wherever", "donde quiera").
card(spanish_vocabulary, "whether", "ya sea").
card(spanish_vocabulary, "which", "cual").
card(spanish_vocabulary, "while", "mientras").
card(spanish_vocabulary, "whisper", "susurro").
card(spanish_vocabulary, "white", "blanco").
card(spanish_vocabulary, "who", "oMS").
card(spanish_vocabulary, "whole", "todo").
card(spanish_vocabulary, "whom", "quién").
card(spanish_vocabulary, "whose", "cuyo").
card(spanish_vocabulary, "why", "por qué").
card(spanish_vocabulary, "wide", "amplio").
card(spanish_vocabulary, "widely", "extensamente").
card(spanish_vocabulary, "wife", "esposa").
card(spanish_vocabulary, "wild", "salvaje").
card(spanish_vocabulary, "wildlife", "fauna silvestre").
card(spanish_vocabulary, "will", "será").
card(spanish_vocabulary, "willing", "complaciente").
card(spanish_vocabulary, "win", "ganar").
card(spanish_vocabulary, "window", "ventana").
card(spanish_vocabulary, "wine", "vino").
card(spanish_vocabulary, "wing", "ala").
card(spanish_vocabulary, "winner", "ganador").
card(spanish_vocabulary, "winter", "invierno").
card(spanish_vocabulary, "wire", "cable").
card(spanish_vocabulary, "wise", "sabio").
card(spanish_vocabulary, "wish", "deseo").
card(spanish_vocabulary, "with", "con").
card(spanish_vocabulary, "within", "dentro").
card(spanish_vocabulary, "without", "sin").
card(spanish_vocabulary, "witness", "testigo").
card(spanish_vocabulary, "woman", "mujer").
card(spanish_vocabulary, "wonder", "preguntarse").
card(spanish_vocabulary, "wonderful", "maravilloso").
card(spanish_vocabulary, "wood", "madera").
card(spanish_vocabulary, "wooden", "de madera").
card(spanish_vocabulary, "wool", "lana").
card(spanish_vocabulary, "word", "palabra").
card(spanish_vocabulary, "work", "trabajo").
card(spanish_vocabulary, "worker", "trabajador").
card(spanish_vocabulary, "working", "trabajando").
card(spanish_vocabulary, "world", "mundo").
card(spanish_vocabulary, "worldwide", "en todo el mundo").
card(spanish_vocabulary, "worried", "preocupado").
card(spanish_vocabulary, "worry", "preocupación").
card(spanish_vocabulary, "worse", "peor").
card(spanish_vocabulary, "worst", "peor").
card(spanish_vocabulary, "worth", "valor").
card(spanish_vocabulary, "would", "harí").
card(spanish_vocabulary, "wound", "herida").
card(spanish_vocabulary, "wow", "guau").
card(spanish_vocabulary, "wrap", "envolver").
card(spanish_vocabulary, "write", "escribir").
card(spanish_vocabulary, "writer", "escritor").
card(spanish_vocabulary, "writing", "escritura").
card(spanish_vocabulary, "written", "escrito").
card(spanish_vocabulary, "wrong", "incorrecto").
card(spanish_vocabulary, "yard", "yarda").
card(spanish_vocabulary, "yeah", "si").
card(spanish_vocabulary, "year", "año").
card(spanish_vocabulary, "yellow", "amarillo").
card(spanish_vocabulary, "yes", "si").
card(spanish_vocabulary, "yesterday", "ayer").
card(spanish_vocabulary, "yet", "todaví").
card(spanish_vocabulary, "you", "tú").
card(spanish_vocabulary, "young", "joven").
card(spanish_vocabulary, "your", "tu").
card(spanish_vocabulary, "yours", "tuya").
card(spanish_vocabulary, "yourself", "usted mismo").
card(spanish_vocabulary, "youth", "juventud").
card(spanish_vocabulary, "zero", "cero").
card(spanish_vocabulary, "zone", "zona").
card(square_roots, "sqrt(1)", "1").
card(square_roots, "sqrt(10)", "3.16227").
card(square_roots, "sqrt(11)", "3.31662").
card(square_roots, "sqrt(12)", "3.46410").
card(square_roots, "sqrt(13)", "3.60555").
card(square_roots, "sqrt(14)", "3.74165").
card(square_roots, "sqrt(15)", "3.87298").
card(square_roots, "sqrt(16)", "4").
card(square_roots, "sqrt(17)", "4.12310").
card(square_roots, "sqrt(18)", "4.24264").
card(square_roots, "sqrt(19)", "4.35889").
card(square_roots, "sqrt(2)", "1.41421").
card(square_roots, "sqrt(20)", "4.47213").
card(square_roots, "sqrt(21)", "4.58257").
card(square_roots, "sqrt(22)", "4.69041").
card(square_roots, "sqrt(23)", "4.79583").
card(square_roots, "sqrt(24)", "4.89897").
card(square_roots, "sqrt(25)", "5").
card(square_roots, "sqrt(26)", "5.09901").
card(square_roots, "sqrt(27)", "5.19615").
card(square_roots, "sqrt(28)", "5.29150").
card(square_roots, "sqrt(29)", "5.38516").
card(square_roots, "sqrt(3)", "1.73205").
card(square_roots, "sqrt(30)", "5.47722").
card(square_roots, "sqrt(4)", "2").
card(square_roots, "sqrt(5)", "2.23606").
card(square_roots, "sqrt(6)", "2.44948").
card(square_roots, "sqrt(7)", "2.64575").
card(square_roots, "sqrt(8)", "2.82842").
card(square_roots, "sqrt(9)", "3").
card(state_abbreviations, "AK", "Alaska").
card(state_abbreviations, "AL", "Alabama").
card(state_abbreviations, "AR", "Arkansas").
card(state_abbreviations, "AZ", "Arizona").
card(state_abbreviations, "CA", "California").
card(state_abbreviations, "CO", "Colorado").
card(state_abbreviations, "CT", "Connecticut").
card(state_abbreviations, "DE", "Delaware").
card(state_abbreviations, "FL", "Florida").
card(state_abbreviations, "GA", "Georgia").
card(state_abbreviations, "HI", "Hawaii").
card(state_abbreviations, "IA", "Iowa").
card(state_abbreviations, "ID", "Idaho").
card(state_abbreviations, "IL", "Illinois").
card(state_abbreviations, "IN", "Indiana").
card(state_abbreviations, "KS", "Kansas").
card(state_abbreviations, "KY", "Kentucky").
card(state_abbreviations, "LA", "Louisiana").
card(state_abbreviations, "MA", "Massachusetts").
card(state_abbreviations, "MD", "Maryland").
card(state_abbreviations, "ME", "Maine").
card(state_abbreviations, "MI", "Michigan").
card(state_abbreviations, "MN", "Minnesota").
card(state_abbreviations, "MO", "Missouri").
card(state_abbreviations, "MS", "Mississippi").
card(state_abbreviations, "MT", "Montana").
card(state_abbreviations, "NC", "North Carolina").
card(state_abbreviations, "ND", "North Dakota").
card(state_abbreviations, "NE", "Nebraska").
card(state_abbreviations, "NH", "New Hampshire").
card(state_abbreviations, "NJ", "New Jersey").
card(state_abbreviations, "NM", "New Mexico").
card(state_abbreviations, "NV", "Nevada").
card(state_abbreviations, "NY", "New York").
card(state_abbreviations, "OH", "Ohio").
card(state_abbreviations, "OK", "Oklahoma").
card(state_abbreviations, "OR", "Oregon").
card(state_abbreviations, "PA", "Pennsylvania").
card(state_abbreviations, "RI", "Rhode Island").
card(state_abbreviations, "SC", "South Carolina").
card(state_abbreviations, "SD", "South Dakota").
card(state_abbreviations, "TN", "Tennessee").
card(state_abbreviations, "TX", "Texas").
card(state_abbreviations, "UT", "Utah").
card(state_abbreviations, "VA", "Virginia").
card(state_abbreviations, "VT", "Vermont").
card(state_abbreviations, "WA", "Washington").
card(state_abbreviations, "WI", "Wisconsin").
card(state_abbreviations, "WV", "West Virginia").
card(state_abbreviations, "WY", "Wyoming").
card(state_capitals, "Alabama", "Montgomery").
card(state_capitals, "Alaska", "Juneau").
card(state_capitals, "Arizona", "Phoenix").
card(state_capitals, "Arkansas", "Little Rock").
card(state_capitals, "California", "Sacramento").
card(state_capitals, "Colorado", "Denver").
card(state_capitals, "Connecticut", "Hartford").
card(state_capitals, "Delaware", "Dover").
card(state_capitals, "Florida", "Tallahassee").
card(state_capitals, "Georgia", "Atlanta").
card(state_capitals, "Hawaii", "Honolulu").
card(state_capitals, "Idaho", "Boise").
card(state_capitals, "Illinois", "Springfield").
card(state_capitals, "Indiana", "Indianapolis").
card(state_capitals, "Iowa", "Des Moines").
card(state_capitals, "Kansas", "Topeka").
card(state_capitals, "Kentucky", "Frankfort").
card(state_capitals, "Louisiana", "Baton Rouge").
card(state_capitals, "Maine", "Augusta").
card(state_capitals, "Maryland", "Annapolis").
card(state_capitals, "Massachusetts", "Boston").
card(state_capitals, "Michigan", "Lansing").
card(state_capitals, "Minnesota", "Saint Paul").
card(state_capitals, "Mississippi", "Jackson").
card(state_capitals, "Missouri", "Jefferson City").
card(state_capitals, "Montana", "Helena").
card(state_capitals, "Nebraska", "Lincoln").
card(state_capitals, "Nevada", "Carson City").
card(state_capitals, "New Hampshire", "Concord").
card(state_capitals, "New Jersey", "Trenton").
card(state_capitals, "New Mexico", "Santa Fe").
card(state_capitals, "New York", "Albany").
card(state_capitals, "North Carolina", "Raleigh").
card(state_capitals, "North Dakota", "Bismarck").
card(state_capitals, "Ohio", "Columbus").
card(state_capitals, "Oklahoma", "Oklahoma City").
card(state_capitals, "Oregon", "Salem").
card(state_capitals, "Pennsylvania", "Harrisburg").
card(state_capitals, "Rhode Island", "Providence").
card(state_capitals, "South Carolina", "Columbia").
card(state_capitals, "South Dakota", "Pierre").
card(state_capitals, "Tennessee", "Nashville").
card(state_capitals, "Texas", "Austin").
card(state_capitals, "Utah", "Salt Lake City").
card(state_capitals, "Vermont", "Montpelier").
card(state_capitals, "Virginia", "Richmond").
card(state_capitals, "Washington", "Olympia").
card(state_capitals, "West Virginia", "Charleston").
card(state_capitals, "Wisconsin", "Madison").
card(state_capitals, "Wyoming", "Cheyenne").
card(sums, "10 + 10", "20").
card(sums, "10 + 11", "21").
card(sums, "10 + 12", "22").
card(sums, "10 + 13", "23").
card(sums, "10 + 14", "24").
card(sums, "10 + 15", "25").
card(sums, "10 + 16", "26").
card(sums, "10 + 17", "27").
card(sums, "10 + 18", "28").
card(sums, "10 + 19", "29").
card(sums, "10 + 20", "30").
card(sums, "10 + 21", "31").
card(sums, "10 + 22", "32").
card(sums, "10 + 23", "33").
card(sums, "10 + 24", "34").
card(sums, "10 + 25", "35").
card(sums, "10 + 26", "36").
card(sums, "10 + 27", "37").
card(sums, "10 + 28", "38").
card(sums, "10 + 29", "39").
card(sums, "10 + 30", "40").
card(sums, "11 + 11", "22").
card(sums, "11 + 12", "23").
card(sums, "11 + 13", "24").
card(sums, "11 + 14", "25").
card(sums, "11 + 15", "26").
card(sums, "11 + 16", "27").
card(sums, "11 + 17", "28").
card(sums, "11 + 18", "29").
card(sums, "11 + 19", "30").
card(sums, "11 + 20", "31").
card(sums, "11 + 21", "32").
card(sums, "11 + 22", "33").
card(sums, "11 + 23", "34").
card(sums, "11 + 24", "35").
card(sums, "11 + 25", "36").
card(sums, "11 + 26", "37").
card(sums, "11 + 27", "38").
card(sums, "11 + 28", "39").
card(sums, "11 + 29", "40").
card(sums, "11 + 30", "41").
card(sums, "12 + 12", "24").
card(sums, "12 + 13", "25").
card(sums, "12 + 14", "26").
card(sums, "12 + 15", "27").
card(sums, "12 + 16", "28").
card(sums, "12 + 17", "29").
card(sums, "12 + 18", "30").
card(sums, "12 + 19", "31").
card(sums, "12 + 20", "32").
card(sums, "12 + 21", "33").
card(sums, "12 + 22", "34").
card(sums, "12 + 23", "35").
card(sums, "12 + 24", "36").
card(sums, "12 + 25", "37").
card(sums, "12 + 26", "38").
card(sums, "12 + 27", "39").
card(sums, "12 + 28", "40").
card(sums, "12 + 29", "41").
card(sums, "12 + 30", "42").
card(sums, "13 + 13", "26").
card(sums, "13 + 14", "27").
card(sums, "13 + 15", "28").
card(sums, "13 + 16", "29").
card(sums, "13 + 17", "30").
card(sums, "13 + 18", "31").
card(sums, "13 + 19", "32").
card(sums, "13 + 20", "33").
card(sums, "13 + 21", "34").
card(sums, "13 + 22", "35").
card(sums, "13 + 23", "36").
card(sums, "13 + 24", "37").
card(sums, "13 + 25", "38").
card(sums, "13 + 26", "39").
card(sums, "13 + 27", "40").
card(sums, "13 + 28", "41").
card(sums, "13 + 29", "42").
card(sums, "13 + 30", "43").
card(sums, "14 + 14", "28").
card(sums, "14 + 15", "29").
card(sums, "14 + 16", "30").
card(sums, "14 + 17", "31").
card(sums, "14 + 18", "32").
card(sums, "14 + 19", "33").
card(sums, "14 + 20", "34").
card(sums, "14 + 21", "35").
card(sums, "14 + 22", "36").
card(sums, "14 + 23", "37").
card(sums, "14 + 24", "38").
card(sums, "14 + 25", "39").
card(sums, "14 + 26", "40").
card(sums, "14 + 27", "41").
card(sums, "14 + 28", "42").
card(sums, "14 + 29", "43").
card(sums, "14 + 30", "44").
card(sums, "15 + 15", "30").
card(sums, "15 + 16", "31").
card(sums, "15 + 17", "32").
card(sums, "15 + 18", "33").
card(sums, "15 + 19", "34").
card(sums, "15 + 20", "35").
card(sums, "15 + 21", "36").
card(sums, "15 + 22", "37").
card(sums, "15 + 23", "38").
card(sums, "15 + 24", "39").
card(sums, "15 + 25", "40").
card(sums, "15 + 26", "41").
card(sums, "15 + 27", "42").
card(sums, "15 + 28", "43").
card(sums, "15 + 29", "44").
card(sums, "15 + 30", "45").
card(sums, "16 + 16", "32").
card(sums, "16 + 17", "33").
card(sums, "16 + 18", "34").
card(sums, "16 + 19", "35").
card(sums, "16 + 20", "36").
card(sums, "16 + 21", "37").
card(sums, "16 + 22", "38").
card(sums, "16 + 23", "39").
card(sums, "16 + 24", "40").
card(sums, "16 + 25", "41").
card(sums, "16 + 26", "42").
card(sums, "16 + 27", "43").
card(sums, "16 + 28", "44").
card(sums, "16 + 29", "45").
card(sums, "16 + 30", "46").
card(sums, "17 + 17", "34").
card(sums, "17 + 18", "35").
card(sums, "17 + 19", "36").
card(sums, "17 + 20", "37").
card(sums, "17 + 21", "38").
card(sums, "17 + 22", "39").
card(sums, "17 + 23", "40").
card(sums, "17 + 24", "41").
card(sums, "17 + 25", "42").
card(sums, "17 + 26", "43").
card(sums, "17 + 27", "44").
card(sums, "17 + 28", "45").
card(sums, "17 + 29", "46").
card(sums, "17 + 30", "47").
card(sums, "18 + 18", "36").
card(sums, "18 + 19", "37").
card(sums, "18 + 20", "38").
card(sums, "18 + 21", "39").
card(sums, "18 + 22", "40").
card(sums, "18 + 23", "41").
card(sums, "18 + 24", "42").
card(sums, "18 + 25", "43").
card(sums, "18 + 26", "44").
card(sums, "18 + 27", "45").
card(sums, "18 + 28", "46").
card(sums, "18 + 29", "47").
card(sums, "18 + 30", "48").
card(sums, "19 + 19", "38").
card(sums, "19 + 20", "39").
card(sums, "19 + 21", "40").
card(sums, "19 + 22", "41").
card(sums, "19 + 23", "42").
card(sums, "19 + 24", "43").
card(sums, "19 + 25", "44").
card(sums, "19 + 26", "45").
card(sums, "19 + 27", "46").
card(sums, "19 + 28", "47").
card(sums, "19 + 29", "48").
card(sums, "19 + 30", "49").
card(sums, "2 + 10", "12").
card(sums, "2 + 11", "13").
card(sums, "2 + 12", "14").
card(sums, "2 + 13", "15").
card(sums, "2 + 14", "16").
card(sums, "2 + 15", "17").
card(sums, "2 + 16", "18").
card(sums, "2 + 17", "19").
card(sums, "2 + 18", "20").
card(sums, "2 + 19", "21").
card(sums, "2 + 2", "4").
card(sums, "2 + 20", "22").
card(sums, "2 + 21", "23").
card(sums, "2 + 22", "24").
card(sums, "2 + 23", "25").
card(sums, "2 + 24", "26").
card(sums, "2 + 25", "27").
card(sums, "2 + 26", "28").
card(sums, "2 + 27", "29").
card(sums, "2 + 28", "30").
card(sums, "2 + 29", "31").
card(sums, "2 + 3", "5").
card(sums, "2 + 30", "32").
card(sums, "2 + 4", "6").
card(sums, "2 + 5", "7").
card(sums, "2 + 6", "8").
card(sums, "2 + 7", "9").
card(sums, "2 + 8", "10").
card(sums, "2 + 9", "11").
card(sums, "20 + 20", "40").
card(sums, "20 + 21", "41").
card(sums, "20 + 22", "42").
card(sums, "20 + 23", "43").
card(sums, "20 + 24", "44").
card(sums, "20 + 25", "45").
card(sums, "20 + 26", "46").
card(sums, "20 + 27", "47").
card(sums, "20 + 28", "48").
card(sums, "20 + 29", "49").
card(sums, "20 + 30", "50").
card(sums, "21 + 21", "42").
card(sums, "21 + 22", "43").
card(sums, "21 + 23", "44").
card(sums, "21 + 24", "45").
card(sums, "21 + 25", "46").
card(sums, "21 + 26", "47").
card(sums, "21 + 27", "48").
card(sums, "21 + 28", "49").
card(sums, "21 + 29", "50").
card(sums, "21 + 30", "51").
card(sums, "22 + 22", "44").
card(sums, "22 + 23", "45").
card(sums, "22 + 24", "46").
card(sums, "22 + 25", "47").
card(sums, "22 + 26", "48").
card(sums, "22 + 27", "49").
card(sums, "22 + 28", "50").
card(sums, "22 + 29", "51").
card(sums, "22 + 30", "52").
card(sums, "23 + 23", "46").
card(sums, "23 + 24", "47").
card(sums, "23 + 25", "48").
card(sums, "23 + 26", "49").
card(sums, "23 + 27", "50").
card(sums, "23 + 28", "51").
card(sums, "23 + 29", "52").
card(sums, "23 + 30", "53").
card(sums, "24 + 24", "48").
card(sums, "24 + 25", "49").
card(sums, "24 + 26", "50").
card(sums, "24 + 27", "51").
card(sums, "24 + 28", "52").
card(sums, "24 + 29", "53").
card(sums, "24 + 30", "54").
card(sums, "25 + 25", "50").
card(sums, "25 + 26", "51").
card(sums, "25 + 27", "52").
card(sums, "25 + 28", "53").
card(sums, "25 + 29", "54").
card(sums, "25 + 30", "55").
card(sums, "26 + 26", "52").
card(sums, "26 + 27", "53").
card(sums, "26 + 28", "54").
card(sums, "26 + 29", "55").
card(sums, "26 + 30", "56").
card(sums, "27 + 27", "54").
card(sums, "27 + 28", "55").
card(sums, "27 + 29", "56").
card(sums, "27 + 30", "57").
card(sums, "28 + 28", "56").
card(sums, "28 + 29", "57").
card(sums, "28 + 30", "58").
card(sums, "29 + 29", "58").
card(sums, "29 + 30", "59").
card(sums, "3 + 10", "13").
card(sums, "3 + 11", "14").
card(sums, "3 + 12", "15").
card(sums, "3 + 13", "16").
card(sums, "3 + 14", "17").
card(sums, "3 + 15", "18").
card(sums, "3 + 16", "19").
card(sums, "3 + 17", "20").
card(sums, "3 + 18", "21").
card(sums, "3 + 19", "22").
card(sums, "3 + 20", "23").
card(sums, "3 + 21", "24").
card(sums, "3 + 22", "25").
card(sums, "3 + 23", "26").
card(sums, "3 + 24", "27").
card(sums, "3 + 25", "28").
card(sums, "3 + 26", "29").
card(sums, "3 + 27", "30").
card(sums, "3 + 28", "31").
card(sums, "3 + 29", "32").
card(sums, "3 + 3", "6").
card(sums, "3 + 30", "33").
card(sums, "3 + 4", "7").
card(sums, "3 + 5", "8").
card(sums, "3 + 6", "9").
card(sums, "3 + 7", "10").
card(sums, "3 + 8", "11").
card(sums, "3 + 9", "12").
card(sums, "30 + 30", "60").
card(sums, "4 + 10", "14").
card(sums, "4 + 11", "15").
card(sums, "4 + 12", "16").
card(sums, "4 + 13", "17").
card(sums, "4 + 14", "18").
card(sums, "4 + 15", "19").
card(sums, "4 + 16", "20").
card(sums, "4 + 17", "21").
card(sums, "4 + 18", "22").
card(sums, "4 + 19", "23").
card(sums, "4 + 20", "24").
card(sums, "4 + 21", "25").
card(sums, "4 + 22", "26").
card(sums, "4 + 23", "27").
card(sums, "4 + 24", "28").
card(sums, "4 + 25", "29").
card(sums, "4 + 26", "30").
card(sums, "4 + 27", "31").
card(sums, "4 + 28", "32").
card(sums, "4 + 29", "33").
card(sums, "4 + 30", "34").
card(sums, "4 + 4", "8").
card(sums, "4 + 5", "9").
card(sums, "4 + 6", "10").
card(sums, "4 + 7", "11").
card(sums, "4 + 8", "12").
card(sums, "4 + 9", "13").
card(sums, "5 + 10", "15").
card(sums, "5 + 11", "16").
card(sums, "5 + 12", "17").
card(sums, "5 + 13", "18").
card(sums, "5 + 14", "19").
card(sums, "5 + 15", "20").
card(sums, "5 + 16", "21").
card(sums, "5 + 17", "22").
card(sums, "5 + 18", "23").
card(sums, "5 + 19", "24").
card(sums, "5 + 20", "25").
card(sums, "5 + 21", "26").
card(sums, "5 + 22", "27").
card(sums, "5 + 23", "28").
card(sums, "5 + 24", "29").
card(sums, "5 + 25", "30").
card(sums, "5 + 26", "31").
card(sums, "5 + 27", "32").
card(sums, "5 + 28", "33").
card(sums, "5 + 29", "34").
card(sums, "5 + 30", "35").
card(sums, "5 + 5", "10").
card(sums, "5 + 6", "11").
card(sums, "5 + 7", "12").
card(sums, "5 + 8", "13").
card(sums, "5 + 9", "14").
card(sums, "6 + 10", "16").
card(sums, "6 + 11", "17").
card(sums, "6 + 12", "18").
card(sums, "6 + 13", "19").
card(sums, "6 + 14", "20").
card(sums, "6 + 15", "21").
card(sums, "6 + 16", "22").
card(sums, "6 + 17", "23").
card(sums, "6 + 18", "24").
card(sums, "6 + 19", "25").
card(sums, "6 + 20", "26").
card(sums, "6 + 21", "27").
card(sums, "6 + 22", "28").
card(sums, "6 + 23", "29").
card(sums, "6 + 24", "30").
card(sums, "6 + 25", "31").
card(sums, "6 + 26", "32").
card(sums, "6 + 27", "33").
card(sums, "6 + 28", "34").
card(sums, "6 + 29", "35").
card(sums, "6 + 30", "36").
card(sums, "6 + 6", "12").
card(sums, "6 + 7", "13").
card(sums, "6 + 8", "14").
card(sums, "6 + 9", "15").
card(sums, "7 + 10", "17").
card(sums, "7 + 11", "18").
card(sums, "7 + 12", "19").
card(sums, "7 + 13", "20").
card(sums, "7 + 14", "21").
card(sums, "7 + 15", "22").
card(sums, "7 + 16", "23").
card(sums, "7 + 17", "24").
card(sums, "7 + 18", "25").
card(sums, "7 + 19", "26").
card(sums, "7 + 20", "27").
card(sums, "7 + 21", "28").
card(sums, "7 + 22", "29").
card(sums, "7 + 23", "30").
card(sums, "7 + 24", "31").
card(sums, "7 + 25", "32").
card(sums, "7 + 26", "33").
card(sums, "7 + 27", "34").
card(sums, "7 + 28", "35").
card(sums, "7 + 29", "36").
card(sums, "7 + 30", "37").
card(sums, "7 + 7", "14").
card(sums, "7 + 8", "15").
card(sums, "7 + 9", "16").
card(sums, "8 + 10", "18").
card(sums, "8 + 11", "19").
card(sums, "8 + 12", "20").
card(sums, "8 + 13", "21").
card(sums, "8 + 14", "22").
card(sums, "8 + 15", "23").
card(sums, "8 + 16", "24").
card(sums, "8 + 17", "25").
card(sums, "8 + 18", "26").
card(sums, "8 + 19", "27").
card(sums, "8 + 20", "28").
card(sums, "8 + 21", "29").
card(sums, "8 + 22", "30").
card(sums, "8 + 23", "31").
card(sums, "8 + 24", "32").
card(sums, "8 + 25", "33").
card(sums, "8 + 26", "34").
card(sums, "8 + 27", "35").
card(sums, "8 + 28", "36").
card(sums, "8 + 29", "37").
card(sums, "8 + 30", "38").
card(sums, "8 + 8", "16").
card(sums, "8 + 9", "17").
card(sums, "9 + 10", "19").
card(sums, "9 + 11", "20").
card(sums, "9 + 12", "21").
card(sums, "9 + 13", "22").
card(sums, "9 + 14", "23").
card(sums, "9 + 15", "24").
card(sums, "9 + 16", "25").
card(sums, "9 + 17", "26").
card(sums, "9 + 18", "27").
card(sums, "9 + 19", "28").
card(sums, "9 + 20", "29").
card(sums, "9 + 21", "30").
card(sums, "9 + 22", "31").
card(sums, "9 + 23", "32").
card(sums, "9 + 24", "33").
card(sums, "9 + 25", "34").
card(sums, "9 + 26", "35").
card(sums, "9 + 27", "36").
card(sums, "9 + 28", "37").
card(sums, "9 + 29", "38").
card(sums, "9 + 30", "39").
card(sums, "9 + 9", "18").
