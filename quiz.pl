/** <module> Quiz program

@author Douglas S. Green
@license GPL
*/
module(quiz,
    [
        go/0,
        go/1
    ]).

%! go
% Pick a random deck to study.
go :- go(_).

%! go(?Name:atom)
% Provide the name of a deck or one will be picked at random. Ask all of the questions in the deck. Press Q to quit.
go(Name) :-
    format("Quiz Program. Use Q to quit.~n~n"),
    pick_subject(Name, Desc),
    setof((Term, Def), card(Name, Term, Def), Defs),
    length(Defs, N),
    format("Subject: ~w~nCards: ~d~n~n", [Desc, N]),
    random_permutation(Defs, ShuffledDefs),
    ask(ShuffledDefs).
go(_) :- !.

%! pick_subject(Name:atom, Desc:string)
pick_subject(Name, Desc) :-
    var(Name),
    setof((Name1, Desc1), subject(Name1, Desc1), Subjects),
    length(Subjects, N),
    R is random(N),
    nth0(R, Subjects, (Name, Desc)),
    subject(Name, Desc).
pick_subject(Name, Desc) :-
    atom(Name),
    subject(Name, Desc).
pick_subject(Name, Desc) :-
    atom(Name),
    \+ subject(Name, Desc),
    format("There's no deck by that name. Here's a list of the deck names and descriptions:~n~n"),
    list_decks.

%! ask(Questions:list)
ask([(Q, A)|Qs]) :-
    writeln(Q),
    get_single_char(Code),
    char_code(Char, Code),
    Char \= 'q',
    Char \= 'Q',
    !,
    writeln(A),
    nl,
    ask(Qs).

%! list_decks.
list_decks :-
    subject(Name, Desc),
    format("* ~w: ~w\n", [Name, Desc]),
    fail.

%! subject(Name:atom, Desc:string)
subject(acronyms, "Acronyms").
subject(phpdoc_params, "PHPDoc parameters used in tags").
subject(phonetic_alphabet, "NATO Phonetic Alphabet").
subject(prolog_library, "SWI Prolog libraries (see https://www.swi-prolog.org/pldoc/man?section=libpl)").
subject(song_titles, "Pop and rock song titles and bands").
subject(state_abbreviations, "Two-letter abbreviations for states of the United States").

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
card(acronyms, "Alpha", "alphabet").
card(acronyms, "ALU", "arithmetic logic unit").
card(acronyms, "AMA", "ask me anything").
card(acronyms, "ANI", "automatic number identification").
card(acronyms, "ANSI", "American National Standards Institute").
card(acronyms, "AOSP", "Android Open Source Project").
card(acronyms, "APA", "American Psychological Association").
card(acronyms, "API", "application programming interface").
card(acronyms, "App", "application").
card(acronyms, "AR", "augmented reality").
card(acronyms, "Arg", "argument").
card(acronyms, "ARPA", "Advanced Research Projects Agency").
card(acronyms, "ARP", "Address Resolution Protocol").
card(acronyms, "ARPANET", "Advanced Research Projects Agency Network").
card(acronyms, "ARQ", "automatic repeat request").
card(acronyms, "ASAP", "as soon as possible").
card(acronyms, "AS", "autonomous system").
card(acronyms, "ASCII", "American Standard Code for Information Interchange").
card(acronyms, "ASME", "American Society of Mechanical Engineers").
card(acronyms, "ASN", "autonomous system number").
card(acronyms, "ASR", "automatic speech recognition").
card(acronyms, "ATA", "Advanced Technology Attachment").
card(acronyms, "AT", "advanced technology").
card(acronyms, "ATM", "automated teller machine").
card(acronyms, "AUI", "Attachment Unit Interface").
card(acronyms, "AUP", "acceptable use policy").
card(acronyms, "Auto", "autonomous").
card(acronyms, "AVC", "Advanced Video Coding").
card(acronyms, "AVI", "Audio Video Interleaved").
card(acronyms, "AWOL", "absent without leave").
card(acronyms, "AWS", "Amazon Web Services").
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
card(acronyms, "Bit", "binary digit").
card(acronyms, "BOFH", "Bastard Operator From Hell").
card(acronyms, "BOINC", "Berkeley Open Infrastructure for Network Computing").
card(acronyms, "bps", "bits per second").
card(acronyms, "Bps", "bytes per second").
card(acronyms, "BRI", "basic rate interface").
card(acronyms, "BSS", "basic service set").
card(acronyms, "BTC", "bitcoin").
card(acronyms, "CA", "certificate authority").
card(acronyms, "CAD", "computer-aided design").
card(acronyms, "CAPTCHA", "Completely Automated Public Turing Test to tell Computers and Humans Apart").
card(acronyms, "CAT", "Central Africa Time").
card(acronyms, "CBT", "computer-based training").
card(acronyms, "CCD", "charge-coupled device").
card(acronyms, "C", "Celsius").
card(acronyms, "CCNP", "Cisco Certified Network Professional").
card(acronyms, "CDC", "Centers for Disease Control and Prevention").
card(acronyms, "CD", "compact disc").
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
card(acronyms, "Char", "character").
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
card(acronyms, "COBOL", "Common Business Oriented Language").
card(acronyms, "CO", "central office").
card(acronyms, "Code", "source code").
card(acronyms, "Con", "console").
card(acronyms, "COPPA", "Children's Online Privacy Protection Act").
card(acronyms, "Core", "core dump").
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
card(acronyms, "Ctrl", "control key").
card(acronyms, "CTS", "Clear to Send").
card(acronyms, "CUPS", "Common Unix Printing System").
card(acronyms, "CUT", "Coordinated Universal Time").
card(acronyms, "CVS", "Concurrent Version System").
card(acronyms, "DAC", "discretionary access control").
card(acronyms, "DARE", "Drug Abuse Resistance Education").
card(acronyms, "DARPA", "Defense Advanced Research Projects Agency").
card(acronyms, "DASD", "direct access storage device").
card(acronyms, "DAT", "Digital Audio Tape").
card(acronyms, "DAW", "digital audio workstation").
card(acronyms, "DBA", "doing business as").
card(acronyms, "DB", "database").
card(acronyms, "DBMS", "database management system").
card(acronyms, "DCE", "distributed computing environment").
card(acronyms, "DCOM", "Distributed Component Object Model").
card(acronyms, "DDBMS", "distributed database management system").
card(acronyms, "DDE", "Dynamic Data Exchange").
card(acronyms, "D", "depth").
card(acronyms, "DDK", "driver development kit").
card(acronyms, "DDL", "data definition language").
card(acronyms, "DDoS", "Distributed Denial of Service").
card(acronyms, "DDR", "double data rate").
card(acronyms, "DDS", "Digital Data Storage").
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
card(acronyms, "DoS", "denial of service").
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
card(acronyms, "E", "Enlightenment").
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
card(acronyms, "Famicom", "family computer").
card(acronyms, "FAQ", "Frequently Asked Questions").
card(acronyms, "FAT", "file allocation table").
card(acronyms, "FBI", "Federal Bureau of Investigation").
card(acronyms, "FCC", "Federal Communications Commission").
card(acronyms, "FCIP", "Fibre Channel over IP").
card(acronyms, "FDDI", "Fiber Distributed Data Interface").
card(acronyms, "Feat", "feature").
card(acronyms, "F", "fahrenheit").
card(acronyms, "FIFO", "first in, first out").
card(acronyms, "FIPS", "Federal Information Processing Standards").
card(acronyms, "Flash", "Adobe Flash").
card(acronyms, "FM", "frequency modulation").
card(acronyms, "Fn", "function").
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
card(acronyms, "GBIC", "gigabit interface converter").
card(acronyms, "Gbps", "gigabits per second").
card(acronyms, "GCC", "GNU Compiler Collection").
card(acronyms, "GCHQ", "Government Communications Headquarters").
card(acronyms, "GDPR", "General Data Protection Regulation").
card(acronyms, "GFS", "Google File System").
card(acronyms, "GHz", "gigahertz").
card(acronyms, "GIF", "Graphics Interchange Format").
card(acronyms, "GIMP", "GNU image manipulation program").
card(acronyms, "GIS", "Geographic Information System").
card(acronyms, "Gmail", "Google Mail").
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
card(acronyms, "GUID", "globally unique identifier").
card(acronyms, "GUI", "graphical user interface").
card(acronyms, "Gzip", "GNU zip").
card(acronyms, "HAL", "hardware abstraction layer").
card(acronyms, "HBA", "host bus adapter").
card(acronyms, "HDD", "hard disk drive").
card(acronyms, "HD", "high-density").
card(acronyms, "HDLC", "high-level data link control").
card(acronyms, "HDMI", "High-Definition Multimedia Interface").
card(acronyms, "HDML", "handheld device markup language").
card(acronyms, "HDSL", "high-bit-rate digital subscriber line").
card(acronyms, "HEVC", "high efficiency video coding").
card(acronyms, "HFC", "hybrid fiber coax").
card(acronyms, "HFS", "hierarchical file system").
card(acronyms, "H", "height").
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
card(acronyms, "IDEA", "International Data Encryption Algorithm").
card(acronyms, "IDE", "integrated device electronics").
card(acronyms, "ID", "identification").
card(acronyms, "IDS", "intrusion detection system").
card(acronyms, "IEEE", "Institute of Electrical and Electronics Engineers").
card(acronyms, "IE", "Internet Explorer").
card(acronyms, "IETF", "Internet engineering task force").
card(acronyms, "IFIP", "International Federation for Information Processing").
card(acronyms, "IGMP", "Internet Group Management Protocol").
card(acronyms, "IGP", "Interior Gateway Protocol").
card(acronyms, "IIS", "Internet Information Server").
card(acronyms, "IMAP", "Internet Message Access Protocol").
card(acronyms, "IMDb", "Internet Movie Database").
card(acronyms, "IMEI", "International Mobile Equipment Identity").
card(acronyms, "IM", "instant messenger").
card(acronyms, "IMSI", "international mobile subscriber identity").
card(acronyms, "INC", "incorporated").
card(acronyms, "INCITS", "International Committee for Information Technology Standards").
card(acronyms, "Info", "information").
card(acronyms, "IPC", "interprocess communication").
card(acronyms, "IP", "Internet Protocol").
card(acronyms, "IPL", "initial program load").
card(acronyms, "IPng", "Internet Protocol next generation").
card(acronyms, "IPsec", "Internet Protocol security").
card(acronyms, "IPS", "intrusion prevention system").
card(acronyms, "IPTV", "Internet Protocol television").
card(acronyms, "IQ", "intelligence quotient").
card(acronyms, "IRC", "Internet Relay Chat").
card(acronyms, "IrDA", "Infrared Data Association").
card(acronyms, "IRQ", "interrupt request").
card(acronyms, "ISA", "Industry Standard Architecture").
card(acronyms, "ISAM", "indexed sequential access method").
card(acronyms, "ISAPI", "Internet Server Application Programming Interface").
card(acronyms, "ISBN", "International Standard Book Number").
card(acronyms, "ISDN", "Integrated Services Digital Network").
card(acronyms, "ISO", "International Organization for Standardization").
card(acronyms, "ISP", "Internet service provider").
card(acronyms, "ISV", "independent software vendor").
card(acronyms, "ITIL", "Information Technology Infrastructure Library").
card(acronyms, "IT", "information technology").
card(acronyms, "ITU", "International Telecommunication Union").
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
card(acronyms, "KB", "knowledge base").
card(acronyms, "Kbps", "kilobits per second").
card(acronyms, "KDE", "K Desktop Environment").
card(acronyms, "kHz", "kilohertz").
card(acronyms, "kilo", "one thousand").
card(acronyms, "KISS", "Keep It Simple, Stupid").
card(acronyms, "K", "kilobit").
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
card(acronyms, "Lisp", "list processing").
card(acronyms, "LMS", "Learning Management System").
card(acronyms, "LPI", "lines per inch").
card(acronyms, "LP", "long play").
card(acronyms, "LSB", "least significant bit").
card(acronyms, "LSD", "least significant digit").
card(acronyms, "LTE", "Long-Term Evolution").
card(acronyms, "LU", "logical unit").
card(acronyms, "lvl", "level").
card(acronyms, "MAC", "media access control").
card(acronyms, "MADD", "Mothers Against Drunk Driving").
card(acronyms, "MAN", "metropolitan area network").
card(acronyms, "MAR", "memory address register").
card(acronyms, "Matlab", "matrix laboratory").
card(acronyms, "Max", "maximum").
card(acronyms, "Mb", "megabit").
card(acronyms, "MB", "megabyte").
card(acronyms, "Mbps", "megabits per second").
card(acronyms, "MBps", "megabytes per second").
card(acronyms, "MBR", "master boot record").
card(acronyms, "MCA", "Micro Channel Architecture").
card(acronyms, "MD", "Medical Doctor").
card(acronyms, "Memo", "memorandum").
card(acronyms, "MFT", "Master File Table").
card(acronyms, "MHz", "megahertz").
card(acronyms, "MIA", "missing in action").
card(acronyms, "MIB", "management information base").
card(acronyms, "MICR", "magnetic ink character recognition").
card(acronyms, "MIDI", "Musical Instrument Digital Interface").
card(acronyms, "MIME", "Multipurpose Internet Mail Extension").
card(acronyms, "Min", "minimum").
card(acronyms, "MIPS", "millions of instructions per second").
card(acronyms, "MIS", "management information system").
card(acronyms, "MIT", "Massachusetts Institute of Technology").
card(acronyms, "MLA", "Modern Language Association").
card(acronyms, "MMC", "Microsoft Management Console").
card(acronyms, "m", "milli").
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
card(acronyms, "Mutex", "mutual exclusion object").
card(acronyms, "MVC", "model-view-controller").
card(acronyms, "MVP", "most valuable player").
card(acronyms, "MVS", "multiple virtual storage").
card(acronyms, "NAFTA", "North American Free Trade Agreement").
card(acronyms, "NAK", "negative acknowledgment").
card(acronyms, "NaN", "not a number").
card(acronyms, "NASA", "National Aeronautics and Space Administration").
card(acronyms, "NAS", "network-attached storage").
card(acronyms, "NAT", "Network Address Translation").
card(acronyms, "NBA", "National Basketball Association").
card(acronyms, "NCSA", "National Center for Supercomputing Applications").
card(acronyms, "NDA", "non-disclosure agreement").
card(acronyms, "NDIS", "network driver interface specification").
card(acronyms, "ne", "not equal").
card(acronyms, "NetBIOS", "network basic input/output system").
card(acronyms, "Net", "network").
card(acronyms, "NFL", "National Football League").
card(acronyms, "NFS", "network file system").
card(acronyms, "NHL", "National Hockey League").
card(acronyms, "NIC", "network interface card").
card(acronyms, "NIDS", "network intrusion detection system").
card(acronyms, "NiMH", "nickel-metal hydride").
card(acronyms, "NLP", "natural language processing").
card(acronyms, "nm", "nanometer").
card(acronyms, "N", "nano").
card(acronyms, "NNTP", "Network News Transfer Protocol").
card(acronyms, "NOS", "network operating system").
card(acronyms, "NPC", "NP-Complete").
card(acronyms, "NRZ", "non-return-to-zero").
card(acronyms, "NSAP", "Network Service Access Point").
card(acronyms, "NTFS", "NTFS file system").
card(acronyms, "NTP", "Network Time Protocol").
card(acronyms, "NUC", "Next Unit of Computing").
card(acronyms, "Num", "number").
card(acronyms, "OBJ", "object").
card(acronyms, "OCR", "optical character recognition").
card(acronyms, "OCTAVE", "operationally critical threat, asset, and vulnerability evaluation").
card(acronyms, "ODBC", "Open Database Connectivity").
card(acronyms, "OEM", "original equipment manufacturer").
card(acronyms, "OID", "object identifier").
card(acronyms, "OLAP", "online analytical processing").
card(acronyms, "OLED", "organic light-emitting diode").
card(acronyms, "OLE", "OnLine English").
card(acronyms, "OLPC", "one laptop per child").
card(acronyms, "OLTP", "online transaction processing").
card(acronyms, "OMG", "Oh My God").
card(acronyms, "OOP", "object-oriented programming").
card(acronyms, "Open", "open source").
card(acronyms, "OR", "OR operator").
card(acronyms, "OSF", "Open Software Foundation").
card(acronyms, "OSHA", "Occupational Safety and Health Administration").
card(acronyms, "OS", "operating system").
card(acronyms, "OSPF", "open shortest path first").
card(acronyms, "OT", "overtime").
card(acronyms, "PaaS", "Platform as a Service").
card(acronyms, "PAE", "physical address extension").
card(acronyms, "PARC", "Palo Alto Research Center").
card(acronyms, "Parm", "parameter").
card(acronyms, "PB", "petabyte").
card(acronyms, "PCB", "printed circuit board").
card(acronyms, "PCIe", "PCI Express").
card(acronyms, "PCI", "Peripheral Component Interconnect").
card(acronyms, "PCM", "pulse-code modulation").
card(acronyms, "PC", "player character").
card(acronyms, "PDA", "personal digital assistant").
card(acronyms, "PDC", "Primary Domain Controller").
card(acronyms, "PDF", "Portable Document Format").
card(acronyms, "PDP", "Programmed Data Processor").
card(acronyms, "PDU", "protocol data unit").
card(acronyms, "PEAR", "PHP Extension and Application Repository").
card(acronyms, "PGP", "Pretty Good Privacy").
card(acronyms, "PHP", "PHP: Hypertext Preprocessor").
card(acronyms, "Pic", "picture").
card(acronyms, "PIM", "Protocol Independent Multicast").
card(acronyms, "PIN", "personal identification number").
card(acronyms, "PIO", "programmed input/output").
card(acronyms, "PLCC", "plastic leaded chip carrier").
card(acronyms, "Plus", "Microsoft Plus!").
card(acronyms, "PM", "private message").
card(acronyms, "PNG", "Portable Network Graphics").
card(acronyms, "PnP", "plug and play").
card(acronyms, "POP", "Post Office Protocol").
card(acronyms, "POTUS", "President of the United States").
card(acronyms, "POV", "point of view").
card(acronyms, "POW", "Prisoner Of War").
card(acronyms, "PPC", "pay per click").
card(acronyms, "PPGA", "Plastic Pin Grid Array").
card(acronyms, "PPP", "Point-to-Point Protocol").
card(acronyms, "PPV", "pay per view").
card(acronyms, "Prolog", "programming in logic").
card(acronyms, "PROM", "programmable read-only memory").
card(acronyms, "PR", "public relations").
card(acronyms, "PSTN", "public switched telephone network").
card(acronyms, "PSU", "power supply unit").
card(acronyms, "PVR", "personal video recorder").
card(acronyms, "PWA", "progressive web application").
card(acronyms, "PWS", "Personal Web Server").
card(acronyms, "PXE", "preboot execution environment").
card(acronyms, "QA", "quality assurance").
card(acronyms, "QoS", "quality of service").
card(acronyms, "RADAR", "Radio Detection And Ranging").
card(acronyms, "RADIUS", "Remote Authentication Dial-in User Service").
card(acronyms, "RAD", "rapid application development").
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
card(acronyms, "Regex", "regular expression").
card(acronyms, "Rel", "release").
card(acronyms, "REPL", "read-eval-print loop").
card(acronyms, "RFC", "Request for Comments").
card(acronyms, "RFID", "radio frequency identification").
card(acronyms, "RF", "radio frequency").
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
card(acronyms, "RTC", "real-time clock").
card(acronyms, "RTF", "Rich Text Format").
card(acronyms, "RTOS", "real-time operating system").
card(acronyms, "RT", "retweet").
card(acronyms, "RTSP", "Real Time Streaming Protocol").
card(acronyms, "RTS", "Request to Send").
card(acronyms, "SaaS", "Software as a Service").
card(acronyms, "SAN", "storage area network").
card(acronyms, "SATAN", "Security Administrator Tool for Analyzing Networks").
card(acronyms, "SCSI", "small computer system interface").
card(acronyms, "SDK", "software development kit").
card(acronyms, "SDRAM", "synchronous DRAM").
card(acronyms, "SELinux", "Security-Enhanced Linux").
card(acronyms, "SEO", "search engine optimization").
card(acronyms, "SERP", "search engine results page").
card(acronyms, "SE", "second edition").
card(acronyms, "SETI", "Search for Extraterrestrial Intelligence").
card(acronyms, "SFTP", "SSH File Transfer Protocol").
card(acronyms, "SFX", "special effects").
card(acronyms, "SGML", "Standard Generalized Markup Language").
card(acronyms, "SIGINT", "signals intelligence").
card(acronyms, "Sig", "signature").
card(acronyms, "SIMD", "single instruction, multiple data").
card(acronyms, "Sim", "simulation").
card(acronyms, "SLA", "service-level agreement").
card(acronyms, "SLIP", "Serial Line Internet Protocol").
card(acronyms, "SMIL", "Synchronized Multimedia Integration Language").
card(acronyms, "SMP", "symmetric multiprocessing").
card(acronyms, "SMTP", "Simple Mail Transfer Protocol").
card(acronyms, "SNA", "Systems Network Architecture").
card(acronyms, "SNMP", "Simple Network Management Protocol").
card(acronyms, "SOAP", "Simple Object Access Protocol").
card(acronyms, "SOA", "start of authority").
card(acronyms, "SoC", "system on a chip").
card(acronyms, "Source", "source code").
card(acronyms, "SPCA", "Society for the Prevention of Cruelty to Animals").
card(acronyms, "Spec", "specification").
card(acronyms, "SP", "spelling").
card(acronyms, "SQL", "Structured Query Language").
card(acronyms, "SRAM", "static random access memory").
card(acronyms, "SRP", "Single Responsibility Principle").
card(acronyms, "SSD", "solid-state drive").
card(acronyms, "SSE", "Streaming SIMD Extensions").
card(acronyms, "SSID", "service set identifier").
card(acronyms, "SSI", "small-scale integration").
card(acronyms, "Stdin", "standard input").
card(acronyms, "SUV", "Sports Utility Vehicle").
card(acronyms, "SWAT", "Special Weapons And Tactics").
card(acronyms, "SW", "software").
card(acronyms, "sync", "synchronize").
card(acronyms, "SYN", "synchronize").
card(acronyms, "synth", "synthesizer").
card(acronyms, "sysgen", "system generation").
card(acronyms, "sysop", "system operator").
card(acronyms, "Ta", "tantalum").
card(acronyms, "TBA", "to be announced").
card(acronyms, "TBD", "to be determined").
card(acronyms, "TCO", "total cost of ownership").
card(acronyms, "TD", "table data").
card(acronyms, "Tech", "technology").
card(acronyms, "TH", "table head").
card(acronyms, "TIFF", "Tagged Image File Format").
card(acronyms, "Ti", "Titanium").
card(acronyms, "Tk", "toolkit").
card(acronyms, "TLD", "top-level domain").
card(acronyms, "TLS", "Transport Layer Security").
card(acronyms, "TM", "trademark").
card(acronyms, "TN", "twisted nematic").
card(acronyms, "Tor", "The Onion Router").
card(acronyms, "TOS", "type of service").
card(acronyms, "TPM", "trusted platform module").
card(acronyms, "TRS", "Telecommunications Relay Service").
card(acronyms, "TR", "technical report").
card(acronyms, "TTL", "transistor-transistor logic").
card(acronyms, "TTS", "text-to-speech").
card(acronyms, "TTY", "teletypewriter").
card(acronyms, "TV", "television").
card(acronyms, "UA", "user agent").
card(acronyms, "UCE", "unsolicited commercial e-mail").
card(acronyms, "UDF", "user-defined function").
card(acronyms, "UDP", "User Datagram Protocol").
card(acronyms, "UEFI", "Unified Extensible Firmware Interface").
card(acronyms, "UFO", "unidentified flying object").
card(acronyms, "UHCI", "Universal Host Controller Interface").
card(acronyms, "UI", "user interface").
card(acronyms, "UNIVAC", "Universal Automatic Computer").
card(acronyms, "UN", "United Nations").
card(acronyms, "UPC", "universal product code").
card(acronyms, "UPnP", "Universal Plug and Play").
card(acronyms, "UPS", "United Parcel Service").
card(acronyms, "URI", "uniform resource identifier").
card(acronyms, "URL", "Uniform Resource Locator").
card(acronyms, "URN", "Uniform Resource Name").
card(acronyms, "USAF", "United States Air Force").
card(acronyms, "USB", "universal serial bus").
card(acronyms, "UTC", "Coordinated Universal Time").
card(acronyms, "UTF", "Unicode Transformation Format").
card(acronyms, "UT", "Universal Time").
card(acronyms, "UUID", "universal unique identifier").
card(acronyms, "UV", "ultraviolet").
card(acronyms, "UX", "user experience").
card(acronyms, "VAN", "value-added network").
card(acronyms, "VAR", "value-added reseller").
card(acronyms, "VA", "virtual address").
card(acronyms, "VB", "Visual Basic").
card(acronyms, "VC", "virtual circuit").
card(acronyms, "VDU", "visual display unit").
card(acronyms, "Veronica", "Very Easy Rodent-Oriented Net-wide Index to Computer Archives").
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
card(acronyms, "VoIP", "Voice over Internet Protocol").
card(acronyms, "VPN", "virtual private network").
card(acronyms, "VPS", "virtual private server").
card(acronyms, "VRML", "Virtual Reality Modeling Language").
card(acronyms, "VR", "virtual reality").
card(acronyms, "VSAM", "virtual storage access method").
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
card(acronyms, "W", "width").
card(acronyms, "WWW", "World Wide Web").
card(acronyms, "WYSIWYG", "what you see is what you get").
card(acronyms, "XHTML", "Extensible Hypertext Markup Language").
card(acronyms, "XML", "Extensible Markup Language").
card(acronyms, "XMPP", "Extensible Messaging and Presence Protocol").
card(acronyms, "XSL", "Extensible Stylesheet Language").
card(acronyms, "XSLT", "extensible stylesheet language transformations").
card(acronyms, "XSS", "cross-site scripting").
card(acronyms, "X", "X Window System").
card(acronyms, "YAML", "YAML Ain't Markup Language").
card(acronyms, "YT", "youtube").
card(acronyms, "ZIF", "zero insertion force").

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
card(prolog_library, "dcg/basics", "Various general DCG utilities").
card(prolog_library, "dcg/high_order", "High order grammar operations").
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
card(prolog_library, www_browser, "Activating your Web-browser").
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
card(prolog_library, statistics, "Get information about resource usage").
card(prolog_library, strings, "String utilities").
card(prolog_library, simplex, "Solve linear programming problems").
card(prolog_library, solution_sequences, "Modify solution sequences").
card(prolog_library, tables, "XSB interface to tables").
card(prolog_library, terms, "Term manipulation").
card(prolog_library, thread, "High level thread primitives").
card(prolog_library, thread_pool, "Resource bounded thread management").
card(prolog_library, ugraphs, "Graph manipulation library").
card(prolog_library, url, "Analysing and constructing URL").
card(prolog_library, varnumbers, "Utilities for numbered terms").
card(prolog_library, yall, "Lambda expressions").

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
card(song_titles, "Ain't No Mountain High Enough", "Diana Ross").
card(song_titles, "Ain't No Mountain High Enough", "Marvin Gaye & Tammi Terrell").
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
card(song_titles, "Big Girls Don't Cry", "Fergie").
card(song_titles, "Big Girls Don't Cry", "The Four Seasons").
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
card(song_titles, "Can't Help Falling in Love", "Elvis Presley").
card(song_titles, "Can't Help Falling in Love", "UB40").
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
card(song_titles, "Crazy", "Gnarls Barkley").
card(song_titles, "Crazy", "Patsy Cline").
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
card(song_titles, "Fame", "David Bowie").
card(song_titles, "Fame", "Irene Cara").
card(song_titles, "Family Affair", "Mary J Blige").
card(song_titles, "Family Affair", "Sly & The Family Stone").
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
card(song_titles, "Jump", "Kris Kross").
card(song_titles, "Jump", "Van Halen").
card(song_titles, "Jumpin' Jack Flash", "The Rolling Stones").
card(song_titles, "Just Dance", "Lady GaGa & Colby O'Donis").
card(song_titles, "Just My Imagination (Running Away With Me)", "The Temptations").
card(song_titles, "Just the Way You Are", "Billy Joel").
card(song_titles, "Just the Way You Are", "Bruno Mars").
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
card(song_titles, "La Bamba", "Los Lobos").
card(song_titles, "La Bamba", "Ritchie Valens").
card(song_titles, "Lady Marmalade (Voulez-Vous Coucher Aver Moi Ce Soir?)", "Christina Aguilera, Lil' Kim, Mya & Pink").
card(song_titles, "Lady Marmalade (Voulez-Vous Coucher Aver Moi Ce Soir?)", "Patti LaBelle").
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
card(song_titles, "My Love", "Justin Timberlake").
card(song_titles, "My Love", "Wings").
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
card(song_titles, "Stardust", "Artie Shaw").
card(song_titles, "Stardust", "Hoagy Carmichael").
card(song_titles, "Stars & Stripes Forever", "Sousa's Band").
card(song_titles, "Stay (I Missed You)", "Lisa Loeb & Nine Stories").
card(song_titles, "Stayin' Alive", "Bee Gees").
card(song_titles, "Stop! in the Name of Love", "The Supremes").
card(song_titles, "Stormy Weather (Keeps Rainin' All the Time)", "Ethel Waters").
card(song_titles, "Stormy Weather (Keeps Rainin' All the Time)", "Lena Horne").
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
card(song_titles, "The Loco-Motion", "Grand Funk Railroad").
card(song_titles, "The Loco-Motion", "Little Eva").
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
card(song_titles, "Twist & Shout", "The Beatles").
card(song_titles, "Twist & Shout", "The Isley Brothers").
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
card(song_titles, "Venus", "Frankie Avalon").
card(song_titles, "Venus", "Shocking Blue").
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
card(song_titles, "Wild Thing", "The Troggs").
card(song_titles, "Wild Thing", "Tone Loc").
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
