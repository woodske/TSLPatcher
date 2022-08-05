# TSLPatcherCLI as designed in Perl...
# Main script. Will use libraries TSLPatcher::GUI and TSLPatcher::FunctionsCLI.
###############################################################################

use experimental qw/smartmatch autoderef switch/;

use Config::IniMan;
use Cwd;

use lib 'lib/site';
use TSLPatcher::FunctionsCLI;

# Testing
# my $gamePath   		= "C:/Users/kwood/Desktop/KotOR1"; # swkotor directory
# my $modPath 		= "D:/compressedMods/K1 Galaxy Map Fix Pack"; # mod directory (folder where TSLPatcher lives)
# my $installOption 	= 0; # Array index for mods with install options

my $gamePath   		= $ARGV[0]; # swkotor directory
my $modPath 		= $ARGV[1]; # mod directory (folder where TSLPatcher lives)
my $installOption 	= $ARGV[2]; # Array index for mods with install options
my $main_ini   		= Config::IniMan->new("$modPath/tslpatcher.ini");
my $build_menu 		= 0;

print "\n~~~ Game Path: $gamePath\n~~~ Mod Path: $modPath\n";

# Sets the base paths for the FunctionsCLI library
TSLPatcher::FunctionsCLI::Set_Base($modPath, $gamePath);

# With install options: Run ProcessNamespaces, SetInstallOption, RunInstallOption, Install
# Without install options: Run ProcessInstallPath, Install
if ($installOption eq "") {
	TSLPatcher::FunctionsCLI::ProcessInstallPath;
	TSLPatcher::FunctionsCLI::Install;
} else {
	TSLPatcher::FunctionsCLI::ProcessNamespaces;
	TSLPatcher::FunctionsCLI::SetInstallOption($installOption);
	TSLPatcher::FunctionsCLI::RunInstallOption;
	TSLPatcher::FunctionsCLI::Install;
}
