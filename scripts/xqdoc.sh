#!/bin/bash
INDEX_HOME=..
BASE_OUTPUT_DIR=bin/xquerydoc

createxqdoc() {
	mkdir -p $BASE_OUTPUT_DIR/$1;
	java -cp lib/xqdoc/xqdoc_conv.jar:lib/xqdoc/antlr-3.1.1.jar:lib/xqdoc/saxon8.jar:lib/xqdoc/xqdoc_saxon.jar org.xqdoc.lite.XQDocLite $INDEX_HOME/$1 .xquery JAN2007 default none $BASE_OUTPUT_DIR/$1;
}

# setup
mkdir -p bin/xquerydoc

# dda collection
createxqdoc 'dda/lib' 
createxqdoc 'dda/rest'
 
# dda-denormalization 
createxqdoc 'scheduler'
createxqdoc 'dda-denormalization'

# dda-urn
createxqdoc 'dda-urn/rest'
createxqdoc 'dda-urn/lib'

# web
createxqdoc 'web'

# delete old documentation
rm ../doc/xquerydoc -r

# copy new documentation
cp bin/xquerydoc ../doc -rv

