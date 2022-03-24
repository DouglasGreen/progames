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

%! subject(Name:atom, Desc:string)
subject(art, baroque_paintings, "List of Baroque paintings and the artists who created them").
subject(art, sculptures, "List of sculptures and the artists who created them").
subject(astronomy, moons, "List of moons and the planets that they orbit around").
subject(literature, fiction_books, "List of fictional books and authors").
subject(literature, nonfiction_books, "List of nonfictional books and authors").
subject(literature, poets, "List of poems and the poets who wrote them").
subject(math, combinations, "A table of calculated values of combinations").
subject(math, factorials, "A table of calculated values of factorials").
subject(math, permutations, "A table of calculated values of permutations").
subject(math, powers, "A table of calculated values of powers").
subject(math, products, "A table of calculated values of products").
subject(math, square_roots, "A table of calculated values of square_roots").
subject(math, sums, "A table of calculated values of sums").
subject(movies, actor_roles, "List of movie roles and the actors who played them").
subject(movies, actress_roles, "List of movie roles and the actresses who played them").
subject(music, song_titles, "Pop and rock song titles and bands").
subject(philosophy, ethics, "Ethical terms and definitions, most of which were adapted from Wiktionary").
subject(programming, git_commands, "List of Git commands with definitions taken from the documentation").
subject(programming, phpdoc_params, "PHPDoc parameters used in tags").
subject(programming, prolog_library, "SWI Prolog libraries (see https://www.swi-prolog.org/pldoc/man?section=libpl)").
subject(reference, acronyms, "Acronyms and the terms that they expand into").
subject(reference, phonetic_alphabet, "NATO Phonetic Alphabet").
subject(reference, state_abbreviations, "Two-letter abbreviations for states of the United States").

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
card(acronyms, "DDE", "Dynamic Data Exchange").
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
card(acronyms, "DSL", "digital subscriber line").
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
card(acronyms, "HSSI", "High-Speed Serial Interface").
card(acronyms, "HTML", "Hypertext Markup Language").
card(acronyms, "HTTP", "Hypertext Transfer Protocol").
card(acronyms, "Hz", "Hertz").
card(acronyms, "IAB", "Internet Architecture Board").
card(acronyms, "IANA", "Internet Assigned Numbers Authority").
card(acronyms, "IAP", "Internet access provider").
card(acronyms, "ICANN", "Internet Corporation for Assigned Names and Numbers").
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
card(ethics, "Declaration of Helsinki", "Set of ethical principles regarding human experimentation developed for the medical community by the World Medical Association (WMA)").
card(ethics, "Epicureanism", "Materialist philosophy that moderation in the pursuit of pleasure leads to equanimity and virtue").
card(ethics, "Eudemian Ethics", "Shorter secondary work on ethics by Aristotle that has much in common with his Nicomachean Ethics").
card(ethics, "European Convention on Human Rights", "International treaty to protect human rights and political freedoms in Europe").
card(ethics, "European Court of Human Rights", "International court established by the European Convention on Human Rights").
card(ethics, "Euthyphro dilemma", "Is what is morally good commanded by God because it is morally good, or is it morally good because it is commanded by God?").
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
card(ethics, "adultery", "Extramarital sex that is considered objectionable on social, religious, moral, or legal grounds").
card(ethics, "altruism", "Unselfish devotion to the welfare of others").
card(ethics, "amoral", "Neutral with regard to morality").
card(ethics, "anarchist ethics", "Morality is a social approach grounded in evolution that emphasizes freedom, equality, and reciprocal good treatment").
card(ethics, "anger", "Strong feeling of displeasure or hostility towards someone, usually combined with an urge to harm").
card(ethics, "animal ethics", "Term used in academia to describe human-animal relationships and how animals ought to be treated").
card(ethics, "animal liberation", "Social movement dedicated to the advancement of the interests and rights of non-human animals").
card(ethics, "animal rights", "Concept that animals are entitled to certain fundamental rights such as the right to be spared undue suffering").
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
card(ethics, "biocentrism", "Belief that all life has inherent value and that humans are not at the center of things").
card(ethics, "bioethics", "Branch of ethics that studies the implications of biological and biomedical advances").
card(ethics, "blame", "Being given accountability for actions that are morally wrong").
card(ethics, "bribery", "Giving or receiving something of value in exchange for some kind of influence or action in return").
card(ethics, "business ethics", "Study of morality in the context of economic organizations").
card(ethics, "capital punishment; death penalty", "Government-sanctioned practice whereby a person is put to death by the state as a punishment for a crime").
card(ethics, "cardinal virtues", "Prudence, courage, temperance, and justice, which were regarded as important by Plato and other classical philosophers").
card(ethics, "care ethics", "Feminist virtue ethics whose values include the importance of empathetic relationships and compassion").
card(ethics, "care", "Personal or medical treatment of those in need").
card(ethics, "casuistry", "Rule-based reasoning used to resolve moral problems, often in a clever but unsound manner").
card(ethics, "censorship", "Use of state or group power to control freedom of expression or press").
card(ethics, "character", "Consistent personal habit of practicing moral virtues").
card(ethics, "chastity", "Sexual abstinence, especially in the context of premarital and extramarital sex").
card(ethics, "cheating", "Act of deception, fraud, trickery, imposture, or infidelity").
card(ethics, "cloning", "Process of producing genetically identical individuals of an organism either naturally or artificially").
card(ethics, "coercion", "Use of physical or moral force to compel a person to do or not do something, depriving them of free will").
card(ethics, "cognitive dissonance", "Conflict or anxiety resulting from inconsistencies between one's beliefs and one's actions or other beliefs").
card(ethics, "cognitivism", "Ethical sentences express propositions and thus can be true or false").
card(ethics, "collectivism", "Cultural value characterized by emphasis on cohesiveness among individuals and prioritization of the group over self").
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
card(ethics, "discrimination", "Treating a class of people badly on the basis of group membership rather than individual characteristics").
card(ethics, "divine command theory", "Action is morally good if commanded by God and morally bad if forbidden by God").
card(ethics, "doctrine of double effect (DDE)", "Conditions that must be satisfied before a good action with bad side effects can be justified").
card(ethics, "drug", "Psychoactive substance, especially one which is illegal and addictive, ingested for recreational use").
card(ethics, "duty", "Commitment or expectation to perform some action in general or if certain circumstances arise").
card(ethics, "efective altruism", "Using evidence and reasoning to determine the most practical ways to benefit others").
card(ethics, "egalitarianism", "All humans are equal in fundamental worth or social status").
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
card(ethics, "ethical dilemma", "Decision-making problem between two possible moral imperatives, neither of which is unambiguously acceptable or preferable").
card(ethics, "ethical egoism", "Moral agents ought to do what is in their own self-interest").
card(ethics, "ethical naturalism", "Ethical terms can be defined in non-ethical terms, namely, descriptive terms from the natural sciences").
card(ethics, "ethical system", "Set of consistent moral principles").
card(ethics, "ethicist", "Someone whose judgment on ethics has come to be trusted by a specific community").
card(ethics, "ethics", "Study of shared social principles relating to right and wrong conduct").
card(ethics, "eudemonia", "Good life consisting of happiness and well-being that arises from the exercise of virtue and wisdom").
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
card(ethics, "fraud", "Act of deception carried out for the purpose of unfair, undeserved and/or unlawful gain").
card(ethics, "free software", "Software distributed under terms that allow users to run, study, change, and distribute it and any adapted versions").
card(ethics, "freedom", "Ability to do as one wills and what one has the power to do").
card(ethics, "friendship", "Strong interpersonal bond based on mutual affection").
card(ethics, "gamesmanship", "Use of legal but unsporting tactics to gain an advantage over one's opponent").
card(ethics, "gender", "Range of characteristics pertaining to, and differentiating between, masculinity and femininity").
card(ethics, "generosity", "Being unattached to material possessions and giving freely to others").
card(ethics, "genetic engineering", "Direct manipulation of an organism's genes using biotechnology").
card(ethics, "genocide", "Systematic killing of a population on the basis of their ethnicity, religion, political beliefs, social status, etc").
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
card(ethics, "instrumental", "Serving as a means to reaching some other end").
card(ethics, "integrity", "Consistency in strong adherence to personal moral principles and avoiding temptation or corruption").
card(ethics, "intrinsic", "Value something has in itself, for its own sake, neither relational nor instrumental").
card(ethics, "is-ought problem", "Question of how one can coherently move from descriptive statements to prescriptive ones").
card(ethics, "just war theory", "Set of criteria which must be met for a military conflict to be considered morally acceptable").
card(ethics, "justice", "Ideal of fairness and impartiality, especially with regard to the punishment of wrongdoing").
card(ethics, "karma; fate", "Force or law of nature which causes one to reap what one sows").
card(ethics, "kindness", "Behavior marked by ethical characteristics, a pleasant disposition, and concern and consideration for others").
card(ethics, "laziness", "Being inclined to idleness, procrastination, and avoiding work").
card(ethics, "legal ethics", "Principles of conduct that judges and lawyers are expected to observe in their practice").
card(ethics, "legal rights", "Entitlements bestowed onto a person by law or custom that can be modified or repealed").
card(ethics, "leveling up of rank", "Hypothetical bringing of all human beings up to the high rank of nobility or aristocracy; Thought experiment of Jeremy Waldron").
card(ethics, "libel", "Written false statement which unjustly seeks to damage someone's reputation").
card(ethics, "liberty", "Absence of arbitrary restraints which takes into account the rights of all involved").
card(ethics, "love", "Feeling of strong attraction and emotional attachment").
card(ethics, "loyalty", "Devotion and faithfulness to a person, nation, or cause").
card(ethics, "lust", "Excess of passionate desire, especially for sexual experience").
card(ethics, "machine ethics", "Redefinition of ethics on an explicit practical basis for artificially programmed or learning agents").
card(ethics, "medical ethics", "Study of morality in the context of health and its treatment").
card(ethics, "mercy", "Forgiveness or compassion, especially toward those less fortunate").
card(ethics, "metaethics", "Branch of ethics that studies the nature of philosophical moral systems").
card(ethics, "military ethics", "Moral treatment of the issues surrounding the use of force in armed conflicts").
card(ethics, "moral absolutism", "Actions are intrinsically right or wrong, independent of context or consequences").
card(ethics, "moral agency", "Individual's ability to make moral judgments and to be held accountable for these actions").
card(ethics, "moral code", "Formal, consistent set of rules prescribing righteous behavior").
card(ethics, "moral compass", "Inner sense of right and wrong that guides a person in ethical decision making").
card(ethics, "moral imperative", "Strongly-felt principle that compels that person to act").
card(ethics, "moral intuitionism", "Our innate awareness of value forms the foundation of our ethical knowledge").
card(ethics, "moral luck", "Assigning blame or praise for an action or its consequences even if it is clear that the agent did not have full control").
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
card(ethics, "neuroethics", "Studying how science can be used to predict or alter human behavior, experience, or identity through the brain").
card(ethics, "nihilism", "Rejection of inherent or objective moral principles").
card(ethics, "noble lie", "Myth or untruth, often of a religious nature, knowingly propagated by an elite to maintain social harmony or to advance an agenda").
card(ethics, "noncognitivism", "Ethical sentences do not express propositions and thus cannot be true or false").
card(ethics, "nonviolence", "Personal practice of being harmless to self and others under every condition").
card(ethics, "norm", "Sentence with non-descriptive meaning, such as a command, permission or prohibition").
card(ethics, "normative ethics", "Branch of ethics concerned with classifying actions as right and wrong").
card(ethics, "obligation", "Course of action that one is required to take").
card(ethics, "optimism", "belief or hope that outcomes will be positive, favorable, and desirable").
card(ethics, "original position", "Hypothetical state in which people are to select fair principles for a society to live under").
card(ethics, "pain", "Unpleasant and punitive outcome of suffering physical harm that encourages someone to avoid it").
card(ethics, "paternalism", "Action limiting a person's or group's liberty or autonomy which is intended to promote their own good").
card(ethics, "peace", "Harmonious lack of conflict and freedom from fear of violence between individuals and heterogeneous social groups").
card(ethics, "person", "Being that has certain capacities or attributes such as reason, morality, and consciousness").
card(ethics, "pessimism", "mental attitude in which an undesirable outcome is anticipated from a given situation").
card(ethics, "phronesis", "Type of wisdom relevant to practical action, implying both good judgement and excellence of character").
card(ethics, "piety", "Reverence and devotion to one's parents and family or to God").
card(ethics, "plagiarism", "Appropriating someone else's intellectual and work and passing it off as your own").
card(ethics, "pleasure", "Rewarding outcome of an action that satisfies some biological drive that encourages its repetition").
card(ethics, "political ethics", "Moral consideration of the methods of public officials and the rightness of policies and laws").
card(ethics, "pornography", "Explicit visual or literary depiction of sexual subject matter").
card(ethics, "postconventional", "Kohlberg stage of development involving the social contract and universal ethical principles").
card(ethics, "posthuman", "Existing in a mental or physical state beyond human as it is presently defined").
card(ethics, "postmodern ethics", "Relativism and pluralism in moral matters that is complex, conditional, and grounded in individual experience").
card(ethics, "poverty", "Scarcity of money or other essential material resources").
card(ethics, "pragmatic ethics", "Moral correctness evolves similarly to scientific knowledge: socially over the course of many lifetimes").
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
card(ethics, "psychological egoism", "Humans are always motivated by self-interest, even in what seem to be acts of altruism").
card(ethics, "public interest", "Welfare or well-being of the general public").
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
card(ethics, "selling out", "Compromising of a person's integrity, morality, or authenticity in exchange for personal gain").
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
card(ethics, "violence", "Intentional use of physical force which might result in injury").
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
