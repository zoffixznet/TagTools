constant $TAGLIB  = "taglib-sharp,  Version=2.0.4.0, Culture=neutral, PublicKeyToken=db62eba44689b5b0";
constant TagLib-File    = CLR::("TagLib.File,$TAGLIB");
constant String-Array   = CLR::("System.String[]");
# constant TagLib-Tag     = CLR::("TagLib.Tag,$TAGLIB");

my $track-number = 1;
my @tracks = lines;
for @tracks -> $filename {
    say :$filename.perl;
    my $file;
    try {
        $file = TagLib-File.Create($filename);
        CATCH { say "Error reading $filename" }
    }

    $file.Tag.Track = $track-number++;
    $file.Tag.TrackCount = +@tracks;
    
    try {
        $file.Save;
        CATCH { say "Error saving changes to $filename" }
    }
}
