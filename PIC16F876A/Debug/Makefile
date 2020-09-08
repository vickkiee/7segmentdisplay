###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = PIC16F876A
COMPILER = "HI-TECH C for PIC10/12/16"
TARGET = Debug
SHELL = C:\Windows\system32\cmd.exe

## Tools general options
CCFLAGS=--pass1 --errformat="Error at file %%f line %%l column %%c: (%%n) %%s" --warnformat="Warning at file %%f line %%l column %%c: (%%n) %%s" --msgformat="Message at file %%f line %%l column %%c: (%%n) %%s" -D_XTAL_FREQ=4000000 -G --chip=16F876A
LDFLAGS=--output=mcof --errformat="Error at file %%f line %%l column %%c: (%%n) %%s" --warnformat="Warning at file %%f line %%l column %%c: (%%n) %%s" --msgformat="Message at file %%f line %%l column %%c: (%%n) %%s" -G --chip=16F876A

## Processing Tools
CC=picc.exe
ASM=picc.exe
LD=picc.exe
LIB=picc.exe
#  C:/Users/aaa/Documents/Personal_Projects/clock2/PIC16F876A/Debug/Debug.cof: TOOL=LD
#     C:/Users/aaa/Documents/Personal_Projects/clock2/PIC16F876A/Debug/main2.p1: TOOL=CC
#        C:/Users/aaa/Documents/Personal_Projects/clock2/PIC16F876A/main2.c

# Build tree:
all:	Debug

Debug:	Debug.cof

Debug.cof:	main2.p1 
	$(LD) $(LDFLAGS)  -O"Debug.cof" "main2.p1"

main2.p1:	../main2.c 
	$(CC) $(CCFLAGS)  -O"main2.p1" "../main2.c"

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf ./Debug.hxl
	rm -rf ./Debug.lst
	rm -rf ./Debug.sym
	rm -rf ./Debug.obj
	rm -rf ./Debug.sdb
	rm -rf ./Debug.as
	rm -rf ./startup.obj
	rm -rf ./startup.rlf
	rm -rf ./startup.as
	rm -rf ./startup.lst
	rm -rf ./funclist.
	rm -rf ./Debug.hex
	rm -rf ./main2.pre
	rm -rf ./main2.lst

# cleanup - delete all generated files
clean:	tidy
	rm -rf Debug.cof
	rm -rf main2.p1

