# 手写MAKEFILE

## Process

```
#PROCESS


# <tools>
CC      = /usr/bin/gcc
LD      = /usr/bin/ld


# <Directory>
LIB_EX=../Fbb/
LIB_IN=./lib/
EXTOBJ=$(LIB_IN)libSVvv.a
INTOBJ=$(LIB_IN)libNVvv.a
EXTOBJS=./if/lib/obj/*.o
INTOBJS=\
		./al/alm/obj/*.o	\
		./ca/cal/obj/*.o	\
		./js/jsp/obj/*.o	


SUBDIRS=$(shell ls -l | grep ^d | awk '{if($$9 != "head" && $$9 != "APL" && $$9 != "MAST" ) print $$9}')



KVvvtem:LIB
	$(CC) $(INTOBJ) $(LIB_EX)*.a -lpthread -o $@


LIB:$(EXTOBJ) $(INTOBJ)

$(EXTOBJ):$(EXTOBJS)
	@echo "__make_EXTOBJS_START__"
	$(CC) -shared  $(EXTOBJS) -o $@
	@echo "__make_EXTOBJS_END__"

$(INTOBJ):$(INTOBJS)
	@echo "__make_INTOBJS_START__"
	$(CC) -shared  $(INTOBJS) -o $@
	@echo "__make_INTOBJS_END_"

$(EXTOBJS):$(SUBDIRS) 
	@echo "_make_END_(out)"	
	@-mkdir $(LIB_IN)	
$(INTOBJS):$(SUBDIRS)
$(SUBDIRS):ECHO 
	-make -C $@

ECHO:
	@echo "_make_START"

.PHONY:clean	
clean:
	@echo "_clean_START"
	@-rm -r $(LIB_IN)
	@for n in $(SUBDIRS);do make -C $$n clean;done
	@echo "_clean_END"
```

## Module

```
#MODULE




SUBDIRS=$(shell ls -l | grep ^d | awk '{if($$9 != "head") print $$9}')

all:$(SUBDIRS)
	@echo "_make_END"
.PHONY:all	
	
$(SUBDIRS):ECHO 
	-make -C $@

ECHO:
	@echo "_make_START"

.PHONY:clean	
clean:
	@echo "_clean_START"
	@for n in $(SUBDIRS);do make -C $$n clean;done
	@echo "_clean_END"
```

## UNIT

```
#UNIT

#<direcotory>
APL = "../../APL/head"
MAST = "../../MAST/head"
TIME = "../../MAST/TimesTen/head"
PROCESS_HEAD = "../../head"
MODULE_HEAD = "../head"
OBJDIR = obj
MODULE = src
SRCS = $(wildcard src/*.c)
OBJS = $(patsubst %c,%o, $(SRCS))

#<tools>
CC = /usr/bin/gcc




#<options>
CFLAGS = -Wall -fPIC  
#CFLAGS = -w  

#<compile>
all:$(OBJS)
	@-mkdir obj
	@-mv *.o ./$(OBJDIR)

%.o:%.c 
	@echo "	compile direcotory of `pwd`/$< "
	@$(CC) $(CFLAGS) -c $^  -I$(APL) -I$(MAST) -I$(TIME) -I$(PROCESS_HEAD) -I$(MODULE_HEAD) 
 



clean:
	@-rm -r $(OBJDIR) *.o >/dev/null 2>&1
```

## SHELL

```
#!/bin/bash

NOW=`pwd`

cd VVV

FILE=`ls`



if [ $1 == 1 ]
then

#create obj

for i in $FILE
do
	if [[ $i != head && $i != APL && $i != MAST ]];then
		echo "enter $i"
		cd $i 
		RETURN=$?
		if [ $RETURN -eq 0 ];then
			echo "current path"
			pwd

			FILE2=`ls`
			for j in $FILE2
			do
				if [[ $j != head && $j != TimesTen ]];then
					echo "	enter $j"
					cd $j
					RETURN2=$?
					if [ $RETURN2 -eq 0 ];then 
						echo "current path"
						pwd
						echo "create unit makefile"
						#mkdir obj
						cp $NOW/make/unit/makefile ./
						cd ..
					fi
				fi
			done
			echo "create module makefile"
			cp $NOW/make/module/makefile ./
			cd ..
		fi
	fi
done
echo "create process makefile" 
cp $NOW/make/process/makefile ./

elif [ $1 == 0 ]
then

#delete obj

for i in $FILE
do
	if [ $i != head ];then
		echo "enter $i"
		cd $i 
		RETURN=$?
		if [ $RETURN -eq 0 ];then
			echo "current path"
			pwd

			FILE2=`ls`
			for j in $FILE2
			do
				if [[ $j != head && $j != TimesTen ]];then
					echo "	enter $j"
					cd $j
					RETURN2=$?
					if [ $RETURN2 -eq 0 ];then 
						echo "current path"
						pwd
						echo "	delete makefile"
						#rm -r obj
                        rm makefile
						cd ..
					fi
				fi
			done
			rm maikefile
			cd ..
		fi
	fi
done
rm makefile
fi
```

## TREE

```
tree
.
|-- Fbb
|   |-- libNFbb.a
|   `-- libSFbb.a
|-- VVV
|   |-- APL
|   |   `-- head
|   |       |-- Aaa.h
|   |       `-- Vvvlib.h
|   |-- KVvvtem
|   |-- MAST
|   |   |-- TimesTen
|   |   |   `-- head
|   |   |       |-- sql.h
|   |   `-- head
|   |       |-- Alm_event.h
|   |       |-- Almlib.h
|   |       |-- Caplib.h
|   |       |-- DbgCom.h
|   |       |-- DbgIpc.h
|   |       `-- plgld.h
|   |-- al
|   |   |-- alm
|   |   |   |-- makefile
|   |   |   |-- obj
|   |   |   |   |-- NVvvalF_CcMsgCallFuncErr.o
|   |   |   |   |-- NVvvalF_MsgAnalyzeInf.o
|   |   |   |   |-- NVvvalF_MsgProvisioningErr.o
|   |   |   |   `-- NVvvalF_PrcMsgCallFuncErr.o
|   |   |   `-- src
|   |   |       |-- NVvvalF_CcMsgCallFuncErr.c
|   |   |       |-- NVvvalF_MsgAnalyzeInf.c
|   |   |       |-- NVvvalF_MsgProvisioningErr.c
|   |   |       `-- NVvvalF_PrcMsgCallFuncErr.c
|   |   |-- head
|   |   |   `-- Vvvalalm.h
|   |   `-- makefile
|   |-- ca
|   |   |-- cal
|   |   |   |-- makefile
|   |   |   |-- obj
|   |   |   |   |-- NVvvcaF_ThreadStart.o
|   |   |   |   `-- NVvvcacalF_ThreadMain.o
|   |   |   `-- src
|   |   |       |-- NVvvcaF_ThreadStart.c
|   |   |       `-- NVvvcacalF_ThreadMain.c
|   |   |-- head
|   |   |   `-- Vvvcacal.h
|   |   `-- makefile
|   |-- head
|   |   |-- Vvval.h
|   |   |-- Vvvca.h
|   |   |-- Vvvjs.h
|   |   `-- cJSON.h
|   |-- js
|   |   |-- head
|   |   |   `-- Vvvjsjsp.h
|   |   |-- jsp
|   |   |   |-- makefile
|   |   |   |-- obj
|   |   |   |   |-- NVvvjsF_ApnToJsonObj.o
|   |   |   |   |-- NVvvjsF_CamelProfileToJsonObj.o
|   |   |   |   |-- NVvvjsF_DataChk_HLRTemplate.o
|   |   |   |   |-- NVvvjsF_DataChk_Subscriber.o
|   |   |   |   |-- NVvvjsF_DataChk_UpdateSubscriber.o
|   |   |   |   |-- NVvvjsF_DuplChk.o
|   |   |   |   |-- NVvvjsF_DuplChk_HLRTemplate.o
|   |   |   |   |-- NVvvjsF_ErrDetailToJsonObj.o
|   |   |   |   |-- NVvvjsF_Free.o
|   |   |   |   |-- NVvvjsF_HLRTemplateToJsonObj.o
|   |   |   |   |-- NVvvjsF_ImsServiceToJsonObj.o
|   |   |   |   |-- NVvvjsF_Parse.o
|   |   |   |   |-- NVvvjsF_Print.o
|   |   |   |   `-- NVvvjsjspF_IPv6StrToNum.o
|   |   |   `-- src
|   |   |       |-- NVvvjsF_ApnToJsonObj.c
|   |   |       |-- NVvvjsF_CamelProfileToJsonObj.c
|   |   |       |-- NVvvjsF_DataChk_HLRTemplate.c
|   |   |       |-- NVvvjsF_DataChk_Subscriber.c
|   |   |       |-- NVvvjsF_DataChk_UpdateSubscriber.c
|   |   |       |-- NVvvjsF_DuplChk.c
|   |   |       |-- NVvvjsF_DuplChk_HLRTemplate.c
|   |   |       |-- NVvvjsF_ErrDetailToJsonObj.c
|   |   |       |-- NVvvjsF_Free.c
|   |   |       |-- NVvvjsF_HLRTemplateToJsonObj.c
|   |   |       |-- NVvvjsF_ImsServiceToJsonObj.c
|   |   |       |-- NVvvjsF_Parse.c
|   |   |       |-- NVvvjsF_Print.c
|   |   |       `-- NVvvjsjspF_IPv6StrToNum.c
|   |   `-- makefile
|   |-- lib
|   |   |-- libNVvv.a
|   |   `-- libSVvv.a
|   |-- makefile
|-- make
|   |-- module
|   |   `-- makefile
|   |-- process
|   |   `-- makefile
|   `-- unit
|       `-- makefile
`-- objfile.sh
```

