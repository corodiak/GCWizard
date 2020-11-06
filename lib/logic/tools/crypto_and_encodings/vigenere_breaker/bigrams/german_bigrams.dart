import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';

class GermanBigrams extends Bigrams {

  GermanBigrams() {

    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    replacementList = {'ä': 'ae','ö': 'oe','ü': 'ue','ß': 'ss'};
    nbr_bigrams = 944226341;
    min_bigrams = 55;
    max_bigrams = 38772514;
    bigrams = [
  //       A       B       C       D       E       F       G       H       I       J       K       L       M       N       O       P       Q       R       S       T       U       V       W       X       Y       Z
    [ 667643, 814073, 796829, 736398, 900826, 741569, 813861, 788369, 699600, 479374, 707898, 857087, 815163, 897533, 490330, 676425, 422461, 846932, 857860, 832287, 884117, 631007, 589078, 567159, 603432, 636022 ], //A
    [ 777627, 566742, 455760, 585510, 904778, 513938, 613313, 551837, 761977, 497757, 496479, 709159, 534513, 586196, 692349, 448749, 201821, 733462, 696908, 665727, 745626, 500928, 572613, 196748, 497496, 540710 ], //B
    [ 639470, 469604, 478356, 567519, 641395, 400968, 396361, 956682, 567258, 275114, 761165, 563847, 443642, 408262, 660573, 404478, 301372, 542887, 539392, 512206, 533574, 397361, 400681, 187510, 394527, 414007 ], //C
    [ 869388, 658952, 556195, 732676, 954903, 643796, 648079, 637725, 876848, 545451, 628713, 669237, 652745, 643902, 726667, 635552, 486556, 723051, 729192, 669721, 755724, 636470, 663480, 280373, 525881, 611698 ], //D
    [ 794468, 834762, 793766, 834116, 777830, 797294, 833736, 848495, 943814, 627477, 771549, 870848, 847761, 992329, 668097, 733691, 534822,1000000, 913042, 853289, 829528, 744365, 773572, 653522, 551680, 735569 ], //E
    [ 775704, 592863, 542422, 720388, 797841, 728581, 643528, 570420, 733041, 507957, 548159, 685007, 605588, 593724, 732198, 575508, 287566, 752531, 665169, 769153, 792556, 543838, 569812, 325837, 343749, 563245 ], //F
    [ 779078, 631468, 451025, 708584, 920639, 612285, 640288, 630280, 755968, 490286, 616500, 718737, 634707, 661945, 637054, 525428, 279907, 756405, 763964, 770546, 733842, 645096, 619364, 219225, 476882, 620891 ], //G
    [ 862816, 661066, 482502, 745934, 884484, 630760, 646198, 629361, 779036, 532405, 641381, 777832, 742654, 766667, 767830, 555333, 337879, 829860, 739639, 834397, 739517, 633799, 719686, 173123, 507825, 627675 ], //H
    [ 712112, 696745, 876239, 760088, 922084, 680889, 821359, 714292, 588591, 531371, 717294, 796529, 799943, 932820, 766462, 639064, 436183, 780013, 867853, 877370, 624190, 699579, 585670, 499103, 341852, 675620 ], //I
    [ 742890, 251490, 243696, 270417, 692209, 206401, 221448, 348002, 422935, 196269, 328101, 249218, 308740, 278650, 603179, 331132,  20001, 299074, 324653, 219647, 667750, 277501, 235838,  30559, 103954, 156091 ], //J
    [ 778465, 551793, 440606, 577622, 790952, 554655, 582218, 554763, 690191, 371392, 542734, 726545, 548164, 600503, 792600, 506502, 306922, 716439, 660686, 773508, 737251, 525637, 567381, 170315, 448582, 544030 ], //K
    [ 838385, 703133, 600101, 752304, 868945, 676104, 686855, 601282, 854761, 486971, 644706, 841260, 658594, 661116, 738682, 588483, 353149, 579201, 780952, 800671, 752839, 631943, 615809, 242572, 583770, 631132 ], //L
    [ 827980, 706498, 539812, 703094, 844747, 668446, 663389, 630557, 836771, 617245, 642624, 637455, 782438, 641362, 741333, 711729, 404326, 625044, 743132, 708702, 747750, 656059, 653923, 333242, 449381, 615044 ], //M
    [ 857925, 782867, 680515, 931161, 905887, 774508, 882520, 755111, 845428, 674564, 801143, 730866, 772285, 831964, 765487, 716330, 529084, 708212, 867018, 858046, 807613, 753660, 785627, 376195, 518798, 790747 ], //N
    [ 624141, 715479, 753636, 714931, 842480, 706935, 694698, 699480, 582759, 559553, 638508, 798487, 761887, 858806, 616833, 700978, 312146, 836899, 758194, 722234, 645652, 621737, 661692, 496755, 478661, 681482 ], //O
    [ 749009, 434854, 469908, 575361, 738569, 680950, 438335, 615568, 727016, 319718, 482524, 693641, 469201, 412581, 722400, 669311, 182595, 790116, 583068, 651504, 665239, 443752, 425443, 197224, 379876, 455728 ], //P
    [ 321589, 194224, 328556, 183285, 208304, 204963, 232257, 151321, 335839,      0, 152542, 245797, 254882, 164654, 164801, 146972,  94370, 161654, 278333, 194912, 641310, 218016, 225898,  32327,  34054, 165966 ], //Q
    [ 872927, 794831, 717186, 860048, 900403, 770517, 800489, 761895, 848581, 672139, 792185, 767277, 777589, 809096, 820016, 714290, 478128, 736190, 850213, 846613, 828888, 739103, 765865, 380070, 538966, 756974 ], //R
    [ 822843, 742931, 873615, 767171, 886042, 705123, 748535, 726908, 854909, 626724, 722322, 714765, 726355, 686650, 799094, 795872, 471862, 680969, 881979, 908332, 751825, 717405, 731757, 363267, 586967, 704174 ], //S
    [ 852685, 712713, 572808, 800617, 943536, 688130, 721584, 743002, 848218, 605095, 665677, 735083, 725953, 707312, 765090, 645466, 398549, 805778, 835295, 792868, 800838, 704687, 773387, 368747, 548607, 799100 ], //T
    [ 663090, 687564, 778458, 677780, 918864, 812528, 713101, 662421, 592514, 438689, 651662, 709191, 790503, 902196, 537047, 663551, 265326, 822415, 841124, 790577, 560582, 609214, 584222, 464725, 375036, 584501 ], //U
    [ 638365, 453286, 348461, 472298, 824032, 490423, 455508, 414827, 715956, 323259, 410033, 400558, 426515, 383275, 823000, 421347, 138482, 434295, 488513, 401835, 446704, 404780, 482349, 188156, 279813, 396924 ], //V
    [ 799874, 433610, 398448, 457814, 838498, 433480, 419952, 455710, 820315, 449847, 435166, 435535, 510486, 479987, 741829, 426787, 102948, 468587, 539647, 412810, 712349, 387621, 488148, 207235, 453104, 365366 ], //W
    [ 496801, 422333, 372761, 457712, 522562, 427088, 413256, 402382, 547756, 231842, 433476, 385389, 419207, 382104, 384083, 566629, 127935, 342566, 473548, 531044, 464196, 415437, 387963, 397297, 311212, 389403 ], //X
    [ 548740, 482744, 486355, 487231, 588069, 407851, 440799, 433129, 473732, 306466, 442851, 484946, 550134, 499402, 523018, 521949, 154253, 459292, 624622, 477862, 452986, 414584, 447193, 216276, 254137, 385133 ], //Y
    [ 675889, 575025, 401521, 586244, 809478, 529852, 548817, 507297, 734082, 367971, 536599, 596396, 545677, 502678, 606005, 482719, 216276, 462571, 571182, 704012, 826072, 558518, 706228, 171799, 450969, 534116 ], //Z
    ];
  }
}
