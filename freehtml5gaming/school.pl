#!/usr/bin/perl


use strict;
use warnings;
#use diagnostics;
use LWP::Simple;
use XML::Simple;
#use XML::LibXML;
use Data::Dumper;
##https://boardgamegeek.com/xmlapi/boardgame/187645/star-wars-rebellion
my $gameArr = "174046, 129459, 42124, 157958, 59946, 91872, 29109, 73171, 72125, 125898, 19526, 100423, 146021, 154857, 11825, 98347, 145390, 142889, 137872, 113294, 155703, 128011, 140125, 79828, 35350, 42673, 28829, 22877, 39217, 74107, 139137, 163170, 138161, 157354, 100901, 105023, 169124, 8730, 833, 136063, 156224, 146221, 37904, 99, 95103, 2025, 119506, 43570, 39383, 177411, 138431, 746, 103343, 39953, 169255, 104775, 42776, 137669, 86177, 37046, 173275, 143782, 12692, 164338, 146725, 28678, 185383, 142992, 156501, 38765, 116, 36400, 109215, 35677, 186721, 149169, 92666, 53093, 109825, 47055, 157096, 35342, 160968, 65564, 63543, 701, 113873, 119788, 8059, 28, 154203, 144239, 124622, 142854, 46807, 63888, 145654, 62226, 27574, 133405, 62853, 185457, 13883, 28185, 109276, 127023, 33876, 3699, 141523, 14441, 20772, 160499, 126996, 111732, 112138, 62227, 152053, 2324, 29368, 177875, 173064, 185456, 119781, 52461, 1887, 146652, 129437, 137762, 127398, 27035, 37015, 27743, 39941, 94331, 125658, 140620, 165872, 6719, 35452, 25727, 65781, 77423, 110327, 144743, 96848, 130704, 22, 63628, 83330, 8517, 10630, 31638, 131646, 25292, 559, 124708, 42627, 108344, 168274, 28828, 134964, 29678, 1621, 181304, 140519, 133632, 126042, 157809, 144415, 102435, 171662, 39232, 114667, 174660, 15363, 69278, 94104, 150298, 70149, 1491, 131287, 30549, 161936, 40849, 150658, 85769, 55679, 144041, 133038, 91, 42910, 91010, 75782, 44890, 24480, 386, 23094, 118536, 69779, 171835, 166640, 140717, 143519, 109764, 91536, 28143, 40210, 66121, 34499, 40209, 170042, 38805, 36946, 170604, 79073, 91773, 111330, 126025, 136000, 875, 121921, 18, 147370, 132531, 37380, 139147, 94362, 21523, 13081, 59294, 168792, 150484, 146408, 102652, 101929, 133683, 113667, 112092, 135382, 146791, 150997, 2511, 55600, 77130, 3633, 121423, 1705, 40692, 122316, 97786, 122522, 134726, 143185, 124827, 84419, 165838, 71721, 66781, 56320, 85978, 165876, 146006, 86406, 79127, 1270, 4845, 164153, 103886, 103885, 6716, 22827, 38796, 22359, 161614, 132407, 101988, 45986, 41612, 9625, 132799, 178054, 123260, 58281, 93260, 16933, 2653, 125936, 146508, 34119, 27627, 25261, 120677, 97903, 25613, 108906, 123955, 53953, 122967, 131306, 116998, 85897, 63214, 9209, 21348, 22825, 37601, 150010, 155708, 148951, 5455, 7625, 42047, 35815, 121408, 163068, 130960, 12493, 12333, 126163, 85108, 139032, 179251, 62220, 93541, 12623, 131321, 34871, 41066, 115746, 2718, 156776, 138104, 94255, 107861, 38996, 148745, 19358, 35614, 160418, 692, 7222, 7614, 106978, 35035, 25729, 1499, 1499, 3353, 159109, 113924, 137988, 61484, 108665";

#my @gameArr = (8257, 68606, 154310, 128996, 27708, 73369, 3870, 65901, 141932, 111105, 31260, 43018, 154458, 158973, 161970, 48726, 72204, 36986, 137408, 110277);
#my @gameArr = (147253, 91080, 124742, 156266, 175707, 162391, 105551, 134323, 41933, 65534, 15987, 128204, 69789, 131118, 145553, 149241, 88406, 39351, 10093, 61692);
#my @gameArr = (25794, 55829, 28907, 41429, 151022, 7992, 59936, 123123, 67492, 37111, 31759, 97915, 25685, 42997, 170216, 69136, 68876, 131835, 166286, 145836);
#my @gameArr = (69120, 40270, 136440, 119012, 822, 177352, 71906, 104633, 161869, 43443, 155426, 13, 278, 102794, 172287, 553, 132018, 62143, 478, 123499);
#my @gameArr = (133528, 139471, 40765, 36932, 156840, 178900, 57141, 12988, 158899, 21050, 62222, 157002, 24800, 23631, 71882, 31483, 98351, 38471, 72225, 70519);
#my @gameArr = (143986, 29603, 67600, 101785, 59429, 98443, 128445, 145056, 141423, 150376, 65532, 104162, 143827, 483, 127518, 36218, 164655, 156714, 165404, 129731);
#my @gameArr = ();
#my @gameArr = ();



sub getPublisher {

    #my $gameArr = $_[0];
    my $filePage = $_[0];
    print "proc $filePage\n";
    my %gameHash = (
            name => "",
            publisher => [],
            boardgamecategory =>  [],
            yearpublished =>  "0000",
            playingtime  => 0
            
        );
	
	 
	    if (1) {
	    	    

	       $gameHash{yearpublished} = $filePage -> {yearpublished};
	       $gameHash{playingtime} = $filePage -> {playingtime};
	       # print Dumper $filePage;
	           my $name = $filePage -> {name};
	           

	           
#####Deal with array content of name	           
	           if (ref($filePage -> {name}) eq 'ARRAY'){
	               foreach my $n (@{$filePage -> {name}}) {
	                   if (defined $n -> {primary}) {
	                       $gameHash{name} =  $n->{content};
	                       }
                        }
                    } else { $gameHash{name} = $filePage -> {name} -> {content};}
                    
                    
                    
	
	        my $publisher = $filePage -> {boardgamepublisher};
	        
	        #print "Dumping ";
	        #print Dumper %publisher;
	        #print "keys %publisher\n";
	        my $temp = 0;
	        
#####Deal with array content of publisher
	        if (ref($publisher) eq 'ARRAY') {
	            my $temp = @{$filePage -> {boardgamepublisher}};
	            #print "number is: $temp\n";
	            #if ($#temp > 1) {
	                #foreach my $pub (@{$filePage -> {boardgamepublisher}}) {
	                #push @{%gameHash->{publisher}}, $pub->{content};
	                push @{%gameHash->{publisher}}, $filePage -> {boardgamepublisher}[0]->{content};
	            #}
	        } else {
	        push @{%gameHash -> {publisher}}, $filePage -> {boardgamepublisher} -> {content};
	        }
	        
#####Deal with array content of boardgamecategory
	        if (ref($filePage -> {boardgamecategory}) eq 'ARRAY') {
	            my $temp = @{$filePage -> {boardgamecategory}};
	            #print "number is: $temp\n";
	            #if ($#temp > 1) {
	                #foreach my $pub (@{$filePage -> {boardgamecategory}}) {
	                #push @{%gameHash->{publisher}}, $pub->{content};
	                push @{%gameHash->{boardgamecategory}}, $filePage -> {boardgamecategory}[0]->{content};
	            #}
	        } else {
	        push @{%gameHash -> {boardgamecategory}}, $filePage -> {boardgamecategory} -> {content};
	        }
	       undef $filePage;
	    } else {print "low\n";}
	   
	
	return %gameHash;
}




#"INSERT INTO games ( title, publisher, genre, released, playtime) VALUES 
#(name, publisher, boardgamecategory,  yearpublished playingtime"}

 #$gameArr = "174046, 129459, 42124, 157958, 59946, 91872";
 #$gameArr ="174046, 129459 ";
            my $filePage;
            my @gameHashList;
            my $xml = new XML::Simple;
            my $fileName = "http://boardgamegeek.com/xmlapi/boardgame/$gameArr";
            my $fileURL = LWP::Simple::get ($fileName) or print "not gunna work\n";
	    if (defined $fileURL) {
	    	    $filePage = $xml->XMLin($fileURL);
	    	     #print Dumper $filePage;
                    
                    print "booger ";
                    
                    print ref($filePage->{boardgame});
                    print "\n\n";
	    	   
	    	    }

#$formatter->format({args => {'name' => "Ayeleth", 'day' => "Sunday"}})
#@gameArr = "61692";
open (my $OUTFILE, '>>', './games.sql') or die "couldn't open the file";
print "aerh $#{$filePage->{boardgame}}\n";
foreach my $game (@{$filePage->{boardgame}}) {
    print "game:  $game  ";
my %gamePub;
       my %gamePub = getPublisher($game);
    if (%gamePub){
    
        printf $OUTFILE "INSERT INTO games \( title, publisher, genre, released, playtime\) VALUES\(\'$gamePub{name}\', \'$gamePub{publisher}[0]\', \'$gamePub{boardgamecategory}[0]\', \'$gamePub{yearpublished}\', $gamePub{playingtime} \)\;\n"; 
        #print(keys %gamePub);
        #print "$gamePub{name}\n";
        undef %gamePub;
    } 
}
close $OUTFILE;


