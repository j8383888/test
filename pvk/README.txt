Here is a binary to my PVK conversion tool. It converts PVK files
to PEM files and back again.
    
Usage is pvk [options]
where options are:
-in file  input file
-out file output file
-topvk    output PVK file
-nocrypt  don't encrypt output file
-strong   use strong encryption for PVK file
-sig      store key as a signature key (default).
-ex       store key as a key exchange key.

Normally the output PEM file is encrypted with triple DES and the PVK file
using the default RC2-128 with 40 bit key. If you use the -nocrypt option
then neither is encrypted.

If you use the -strong option then the output PVK file uses 128 bit RC4 with
a full 128 bit key. 

You should note that you can use signature only keys larger than 512 bits
with the export (crippled) versions of the software. The default is now to
generate a signature only key in the PVK file.

If you want to convert a key from the weak form to the strong form then:

pvk -in weak.pvk -out file.pem
pvk -in file.pem -strong -out strong.pvk -topvk

Will do the trick. Delete the files file.pem and weak.pvk when you are sure
it works OK.

