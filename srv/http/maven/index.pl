#!/usr/bin/perl
#
# This program demonstrates directory listing.
# It is often used for File Managers, or simply browsing server files.
#
# Features: Sort lexically, and seperate folders from files.
#
use CGI qw/:standard/;
 
## Defining variables:
## $dirpath retrieve its value from the input called "path".
## @FolderContent, @Folders, @Files are array variables to be used later on.
##$dirpath=param('path') if param('path');
use vars qw/@FolderContent, @Folders, @Files/;
 
## Change current path/folder to $dirpath.
##chdir $dirpath;
## Open folder, preparing it for reading.
unless (opendir DIR,'./') { print "Cannot open directory $dirpath: $!\n"; exit; }
	## Collect all objects in the folder into an array variable.
	## Also sort them lexically.
	@FolderContent = sort readdir DIR;
closedir DIR;
 
## Go through each objects collected.
foreach $FolderContent(@FolderContent) {
	## If this object is a folder...
	if (-d $FolderContent) {
		## Put it in the @Folders array variable.
		push(@Folders, $FolderContent);
	}	
}
 
## Print header and HTML title (to be viewable in browser).
print header,start_html("Maven Projects");

print "<h1>Maven Projects</h1>\n";
print "<ul>\n";

## Go through each Folders Objects.
foreach $Folders(@Folders) {
	unless ( ($Folders eq ".") || ($Folders eq "..") ) {
	  ## Print out the folders first.
	  print "<li><a href='$Folders/index.html'>$Folders</a></li>\n";
	}
}

print "</ul>\n";
print end_html;
