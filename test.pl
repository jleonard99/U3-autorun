use strict;
use Win32::GUI;
use Win32API::File qw(:ALL);
use Config::IniFiles;


my $IniFile = "u3-autorun.ini";

sub ScanForGoodDrives{
my $good_drives = [];
foreach my $drive (getLogicalDrives()){
  my $uDriveType = GetDriveType( $drive );
  next if ($uDriveType != DRIVE_REMOVABLE);
  my $uOldMode= SetErrorMode( SEM_FAILCRITICALERRORS );
  push @{$good_drives},$drive if (-e $drive);
  SetErrorMode($uOldMode);
}
return $good_drives;
}

sub GetExeFileName{
  my ( $drive,$IniFile ) = @_;
  my $file = $drive . $IniFile;
  my $cfg = Config::IniFiles->new( -file=>$file );
  my $exefile = $cfg->val("u3-autorun","exefile");
  return $exefile;
}


my $drives = ScanForGoodDrives();

foreach my $drive (@{$drives}){
  my $exefile = $drive . GetExeFileName( $drive,$IniFile );
  system(1,$exefile);
}

my $main = Win32::GUI::Window->new(
                -name   => 'Main',
                -width  => 100,
                -height => 100,
        );
$main->AddLabel(-text => "Hello, world");

#$main->Show();
#Win32::GUI::Dialog();

sub Main_Terminate {
    -1;
}
