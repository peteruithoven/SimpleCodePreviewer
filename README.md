SimpleCodePreviewer
===================

SimpleCode previewer for LAOS lasers.

You can retrieve simplecode files from VisiCut by:
- Go to Edit > Settings > Manager laswercutters...
- Edit your lasercutter
- Under settings, find the Debug output file field
- Fill in a filename, this will be generated in the Visicut application 
  On OS X for example: /Applications//VisiCut.app/Contents/Resources/Java

These simplecode files are also stored on the SD card of the lasercutter, but this is cleared on restart. 
(You can disable this using the sys.cleandir setting in the laos config file)

SimpleCode info: http://redmine.laoslaser.org/projects/laos/wiki/SimpleCode
Based on Rick Companje's work: http://companje.nl/laos-laser-simplecode-preview-tool/
