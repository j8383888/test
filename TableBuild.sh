#!/bin/bash
echo `dirname $0`/Table/TableBuild.exe 
echo $*
mono `dirname $0`/Table/TableBuild.exe `pwd`/$*
