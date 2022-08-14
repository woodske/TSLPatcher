# TSLPatcher
A repository for the current state of the TSLPatcher mod installer for Star Wars: Knights of the Old Republic 1 and 2.

## TSLPatcherCLI
TSLPatcherCLI provides the same functionality as TSLPatcher, but without the GUI. This is intended to be used for mod management tools.

### Setup
For Windows 10:
* Install Strawberry Perl v5.16.3.1 (https://strawberryperl.com/releases.html)
* Install dependencies by opening the Command Prompt as an administrator and running: `cpan install pp && cpan install experimental && cpan install Config::IniMan && cpan install Data::Dumper`
* In your File/Path.pm of the default Perl libraries (default path: C:\strawberry\perl\lib\File\Path.pm) on line 87 the function `getpwnam` does not work on windows. Make the following change:
    - Before: my $uid = (getpwnam $arg->{owner})[2];
    - After: my $uid = getlogin || (getpwnam $arg->{owner})[2];

### Usage
TSLPatcherCLI takes three arguments:
1. swkotorDirectory - the game directory that swkotor.exe is in.
2. modDirectory - the extracted mod directory that TSLPatcher.exe and the tslpatchdata directory are in.
3. installOption (optional) - the install option only for mods that have a tslpatcher/namespaces.ini file that matches the array index of the options under `[Namespaces]`. If there is no tslpatcher/namespaces.ini file then don't inclue this. In the example below the `installOption` for Vanilla would be `0` and Ord Mantell would be `1`.
```
[Namespaces]
Namespace1=Vanilla
Namespace2=Ord Mantell
```

Run the script locally: `perl TSLPatcherCLI.pl <swkotorDirectory> <modDirectory> <installOption>`
* Example: `perl TSLPatcherCLI.pl "C:\Program Files (x86)\Steam\steamapps\common\swkotor" "C:\Mods\K1 Galaxy Map Fix Pack" 0`

Build the script to .exe: `pp -o TSLPatcherCLI.exe TSLPatcherCLI.pl`

## Useful Tools

Below are some useful tools for debugging TSLPatcher

* ERFEdit: https://deadlystream.com/files/file/499-erfedit/
    - A tool that allows your to unpack and browse ERF/MOD/SAV/HAK/RIM format files
* Xoreos Tools: https://xoreos.org/downloads/index.html
    - A collection of tools to convert different Bioware file formats to XML (use the xoreos-tools download)
* Data::Dumper: Installed via `cpan install Data::Dumper`
    - A useful printing library for Perl that can print scalars or reference variables in a human readable format. Ex: `print Dumper($struct)`
    - Note: Make sure to comment out this library when making a release, it will get detected as a virus.