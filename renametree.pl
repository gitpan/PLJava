

  my $basedir = $ARGV[0] || './basiclib' ;
  my $ext = exists $ARGV[1] ? $ARGV[1] : 'txt' ;
  
  $ext =~ s/\W//gs ;
  
  $ext = "-$ext" if $ext ;
  
  my @dir = catdir($basedir , 0,1,1) ;
  
  foreach my $dir_i ( @dir ) {
    my $new_file = $dir_i ;
    $new_file =~ s/\.(\w+)(?:-\w+)?$/.$1$ext/ ;
    rename($dir_i , $new_file) ;
    print "$dir_i >> $new_file\n" ;
  }

##########
# CATDIR # (DIR , CUT_BASE , RECURSIVE , ONLY_FILES)
##########

sub catdir {
  my ( $dir , $cut , $r , $f ) = @_ ;
  
  my @files ;
  
  my @DIR = $dir ;
  foreach my $DIR ( @DIR ) {
    my $DH ;
    opendir ($DH, $DIR);

    while (my $filename = readdir $DH) {
      if ($filename ne "\." && $filename ne "\.\.") {
        my $file = "$DIR/$filename" ;
        if ($r && -d $file) { push(@DIR , $file) ;}
        else {
          if (!$f || !-d $file) {
            $file =~ s/^\Q$dir\E\/?//s if $cut ;
            push(@files , $file) ;
          }
        }
      }
    }
    
    closedir ($DH) ;
  }
  
  return( @files ) ;
}

#######
# END #
#######

1;



