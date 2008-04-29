#
#
# mkdict.make : MakeDictionary from dict.freq to DBM Dictinary
#
#
bin_PROGRAMS = mkdict lkdict excdict getdict putsem putmarker predict chkcon
LDADD = ../src/libkts.a -lndbm
DEPENDENCIES=../src/libkts.a
AM_CFLAGS = -O2 -I/usr/include/db1 -I../include #-DDEBUG

dict:
	./mkdict	total.dict	kts_dict
	./mkdict	add.dict	kts_dict
	./excdict	exc.dict	kts_dict
	./predict	prefer.dict	kts_dict
