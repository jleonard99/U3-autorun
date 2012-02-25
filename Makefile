.SILENT:
-include menus.cfg
-include recipes.cfg

MKISOFS = bin\mkisofs
U3TOOL = bin\u3-tool
PERLAPP = C:\Program Files (x86)\ActiveState Perl Dev Kit 9.1.1\bin\perlapp

	
clean:
	@echo + Clean
	@$(RM) test.exe MY.ISO test.iso qa.ini
	
realclean: clean
	@echo + Realclean
	
list-iso:
	7z l MY.ISO

perl-to-exe.title = Convert perl script into EXE file
perl-to-exe:
	@"$(subst \,/,$(PERLAPP))" --force --icon bin/drivepublic.ico --gui test.pl

exe-to-ISO-folder.title = copy EXE into ISO folder
exe-to-ISO-folder:
	@$(CP) test.exe ISO-folder/test.exe

folder-to-iso.title = Create ISO from files in ISO-folder
folder-to-iso:
	@$(MKISOFS) -J -r -o MY.ISO ./ISO-folder

iso-to-usb.title = Transfer ISO into U3-CDROM partition on U3 drive
iso-to-usb:
	@$(U3TOOL) -l MY.ISO i

all.title = run all target in proper order
all:
	@make perl-to-exe
	@make exe-to-ISO-folder
	@make folder-to-iso
	@make iso-to-usb
