#!/bin/bash
#
# PreTeXt Website construction
#
# History
#
#  2016-05-11  Initiated
#  2016-05-14  Git for Authors
#  2016-05-15  Sample book, article
#  2016-06-17  Added local option (to catch bugs before pushing MB)
#  2018-12-02  Move to pretextbook.org
#  2019-06-29  Logs and background processes

# Usage:
# $1 "local" --> MBX, GFA repos are purely local (testing), no pull, no upload

# Script Prererquisites
#
# install -d to make directories

# TeX error suppression
# http://tex.stackexchange.com/questions/27878/pdflatex-bash-script-to-supress-all-output-except-error-messages

# Source a custom file with three path names
# See paths.sh.template, copy to paths.sh and edit
# "dot" syntax is POSIX for "source"
# Alternatives: http://stackoverflow.com/questions/192292
DIR="$(dirname "$0")"
. ${DIR}/paths.sh




# echo ${1}

# if [ "${1}" = "local" ] ; then
# 	echo "yay"
# fi
# echo "oldddddd"
# echo ${MB}
# echo ${GFA}

# fine if these directories already exist
install -d ${SITE}
install -d ${LOGS}


# PreTeXt, master branch of *public* repository
if [ "${1}" != "local" ] ; then
	echo
	echo
	echo
	echo "BUILD: MathBook XML repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${MB}
	git checkout master
	git pull
fi

# Git for Authors, master branch of *public* repository
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: Git for Authors repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${GFA}
	git checkout master
	git pull
fi

# PreTeXt Projects, pull if not local
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: PreTeXt Projects repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${PP}
	git checkout master
	git pull
fi

# LaTeXtoLaTeX (pretty print for source annotations), pull if not local
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: LaTeX3LaTeX repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${LTL}
	git checkout main
	git pull
fi

# PreTeXt catalog site, Tom Shemanske ("main" branch!)
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: PreTeXt Catalog Site :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${PC}
	git checkout main
	git pull
fi


####################
# Background scripts
####################

# The PreTeXt Guide
# passing identical args
#########################################./build-guide.sh "${@}" &


###### echo
###### echo "BUILD: sample article, five themes :BUILD"
###### echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
###### 
###### for THEME in default-modern denver tacoma salem greeley; do
######   echo "Building sample article with theme:" $THEME
######   install -d ${SITE}/examples/sample-article/${THEME}
######   # sed w/ stock publication.xml was a disaster
######   ${PTXPTX} -v -c all -f html -d ${SITE}/examples/sample-article/${THEME} -p ${SA}/publication-${THEME}.xml ${SA}/sample-article.xml
###### 
###### 
###### 
###### 
###### done




# Validate minimal article
# (We don't build this one)
echo
echo "VALIDATE: minimal article :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGONE} ${SCHEMA} ${MA}/minimal.xml
xsltproc -xinclude ${PLUS} ${MA}/minimal.xml

# Validate sample book
echo
echo "VALIDATE: sample book :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGMANY} ${SCHEMA} ${SB}/sample-book.xml
xsltproc -xinclude ${PLUS} ${SB}/sample-book.xml

# Validate sample article
echo
echo "VALIDATE: sample article :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGONE} ${SCHEMA} ${SA}/sample-article.xml
xsltproc -xinclude ${PLUS} ${SA}/sample-article.xml

# Validate WW sample chapter
echo
echo "VALIDATE: WeBWorK sample chapter :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGONE} ${SCHEMA} ${WW}/sample-chapter.ptx
xsltproc -xinclude ${PLUS} ${WW}/sample-chapter.ptx

# Validate Publisher's Guide
echo
echo "VALIDATE: the guide :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGMANY} ${SCHEMA} ${G}/guide.xml
xsltproc -xinclude ${PLUS} ${G}/guide.xml

# Validate Showcase Article
echo
echo "VALIDATE: Showcase Article :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGMANY} ${SCHEMA} ${SC}/pretext-showcase.ptx
xsltproc -xinclude ${PLUS} ${SC}/pretext-showcase.ptx

# Validate humanities examples
echo
echo "VALIDATE: humanities examples :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGMANY} ${SCHEMA} ${HIA}/source/hia.xml
xsltproc -xinclude ${PLUS} ${HIA}/source/hia.xml

# Validate fonts-and-characters
echo
echo "VALIDATE: font sample :VALIDATE"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
${JINGONE} ${SCHEMA} ${FC}/fonts-and-characters.xml
xsltproc -xinclude ${PLUS} ${FC}/fonts-and-characters.xml







echo
echo "BUILD: creating the EPUB Sampler :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${SITE}/examples/epub-sampler  ${SITE}/examples/epub-sampler/html
# PDF
${MB}/pretext/pretext -v -o ${SITE}/examples/epub-sampler/epub-sampler.pdf -c all -f pdf -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# HTML
${MB}/pretext/pretext -v -d ${SITE}/examples/epub-sampler/html -c all -f html -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# EPUB
${MB}/pretext/pretext -v -o ${SITE}/examples/epub-sampler/epub-sampler.epub -c all -f epub-svg -p ${ES}/publication.xml ${ES}/epub-sampler.xml


# The PreTeXt Guide
echo
echo "BUILD: creating the guide :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${SITE}/doc/guide ${SITE}/doc/guide ${SITE}/doc/guide/html ${LOGS}
# WeBWork
# ${MB}/pretext/pretext -v -c webwork -x debug.datedfiles no -p ${G}/publication.xml  ${G}/guide.xml
# PDF
# "fancy" vertsion via a LaTeX style file given in a publisher file
${MB}/pretext/pretext -v -o ${SITE}/doc/guide/pretext-guide.pdf -c all -f pdf -p ${G}/publication-styled.xml ${G}/guide.xml
# HTML
${MB}/pretext/pretext -v -d ${SITE}/doc/guide/html -c all -f html -p ${G}/publication.xml ${G}/guide.xml

#
# Sample book
echo
echo "BUILD: creating quick reference :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/doc/quickref
# build doc/quickref/quickref-pretext.pdf, doc/quickref/quickref-cli.pdf
-rm ${SITE}/doc/quickref/quickref-pretext.tex
xelatex -output-directory ${SITE}/doc/quickref ${QR}/quickref-pretext.tex
xelatex -output-directory ${SITE}/doc/quickref ${QR}/quickref-pretext.tex
rm ${SITE}/doc/quickref/quickref-pretext.aux ${SITE}/doc/quickref/quickref-pretext.log
#
-rm ${SITE}/doc/quickref/quickref-cli.tex
xelatex -output-directory ${SITE}/doc/quickref ${QR}/quickref-cli.tex
xelatex -output-directory ${SITE}/doc/quickref ${QR}/quickref-cli.tex
rm ${SITE}/doc/quickref/quickref-cli.aux ${SITE}/doc/quickref/quickref-cli.log

#
# Sample book
echo
echo "BUILD: creating sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# mark up so there is no confusion w/ original AATA
# move to the publisher files once string parameters move
# fails in HTML, so just PDF
# 2022-05-31  Busted, so switch to publication file
# declare WATER='watermark.text "PRETEXT SAMPLE ONLY" watermark.scale 0.25'

# no parts
install -d ${SITE}/examples/sample-book/${SBNP}
install -d ${SITE}/examples/sample-book/${SBNP}/html
${MB}/pretext/pretext -v -f pdf  -c all -p ${SB}/publication-noparts.xml -d ${SITE}/examples/sample-book/${SBNP}      ${SB}/sample-book.xml
${MB}/pretext/pretext -v -f html -c all -p ${SB}/publication-noparts.xml -d ${SITE}/examples/sample-book/${SBNP}/html ${SB}/sample-book.xml

# decorative
install -d ${SITE}/examples/sample-book/${SBDE}
install -d ${SITE}/examples/sample-book/${SBDE}/html
${MB}/pretext/pretext -v -f pdf  -c all -p ${SB}/publication-decorative.xml -d ${SITE}/examples/sample-book/${SBDE}      ${SB}/sample-book-parts.xml
${MB}/pretext/pretext -v -f html -c all -p ${SB}/publication-decorative.xml -d ${SITE}/examples/sample-book/${SBDE}/html ${SB}/sample-book-parts.xml

# structural
install -d ${SITE}/examples/sample-book/${SBST}
install -d ${SITE}/examples/sample-book/${SBST}/html
${MB}/pretext/pretext -v -f pdf  -c all -p ${SB}/publication-structural.xml -d ${SITE}/examples/sample-book/${SBST}      ${SB}/sample-book-parts.xml
${MB}/pretext/pretext -v -f html -c all -p ${SB}/publication-structural.xml -d ${SITE}/examples/sample-book/${SBST}/html ${SB}/sample-book-parts.xml

# Solution Manual is hacked together, needs  pretext/pretext  support
# create, populate build directory
install -d ${SCRATCH}/sb ${SCRATCH}/sb/${SBNP}/pdf/external
cp -a ${SB} ${SCRATCH}/sb
# this only fixes up the necessary filenames so LaTeX compiles
cp ${SB}/external/original-front-cover-aata.pdf ${SCRATCH}/sb/${SBNP}/pdf/external/
cp ${SB}/external/plain-back-cover-aata.pdf     ${SCRATCH}/sb/${SBNP}/pdf/external/
cp ${SB}/external/UPCcode.png                   ${SCRATCH}/sb/${SBNP}/pdf/

cd ${SCRATCH}/sb/${SBNP}/pdf
cp -a ${SB}/sample-book-solutions-manual.xml ${SCRATCH}/sb/sample-book
cp -a ${SB}/sample-book-solutions-manual.xsl ${MBUSER}
xsltproc -o sample-book-solutions-manual.tex -xinclude -stringparam publisher publication-solution-manual.xml ${MBUSER}/sample-book-solutions-manual.xsl ${SCRATCH}/sb/sample-book/sample-book-solutions-manual.xml
texfot xelatex sample-book-solutions-manual.tex
texfot xelatex sample-book-solutions-manual.tex
cp sample-book-solutions-manual.pdf ${SITE}/examples/sample-book/${SBNP}

# Sample book, as HTML only, with "View Source" annotations
echo
echo "BUILD: creating annotated sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# playground for "cleaned-up" annotated version
install -d ${SCRATCH}/sb/annotated
cd ${SCRATCH}/sb/annotated
# mimic pretext script with directory management
cp -a ${SB}/gen .
cp -a ${SB}/ext .
# Pretty-print and drop here, arguments are directories, source will be found
${LTL}/ltol.py xml_pp ${SB} .
${LTL}/ltol.py xml_pp ${SB}/exercises ./exercises
${LTL}/ltol.py xml_pp ${SB}/sage ./sage
# text files being included, just copy
cp ${SB}/code/symmetric-group-8.sage ./code
cp ${SB}/tikz/cyclic-roots-unity.tex ./tikz
# need publication file next to massaged source, for managed directories
cp -a ${SB}/publication-structural.xml .
# location in final tree
install -d ${SITE}/examples/sample-book/annotated
# run script, most inputs are local to cwd
${PTXPTX} -v -c all -f html -x debug.html.annotate yes -d ${SITE}/examples/sample-book/annotated -p publication-structural.xml sample-book-parts.xml


# WebWork sample chapter
echo
echo "BUILD: creating WW sample chapter :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# Extract static and images from server
# -a will abort on bad xml produced by webwork (especially)
${MB}/pretext/pretext -v -a -c webwork -p ${WWPUB} ${WW}/sample-chapter.ptx

# PDF
install -d ${SCRATCH}/ww/pdf
# via script, into scratch, copy to site
${MB}/pretext/pretext -v -c all -f pdf -p ${WWPUB} -d ${SCRATCH}/ww/pdf ${WW}/sample-chapter.ptx
cp ${SCRATCH}/ww/pdf/sample-chapter.pdf ${SITE}/examples/webwork/sample-chapter

# HTML
# overwriting fails, bug in script, is it now fixed?
rm -rf ${SCRATCH}/ww/html ${SITE}/examples/webwork/sample-chapter/html
install -d ${SCRATCH}/ww/html
install -d ${SITE}/examples/webwork/sample-chapter/html
# via script, into scratch, copy to site
${MB}/pretext/pretext -v -c all -f html -p ${WWPUB} -x webwork.divisional.static no -d ${SCRATCH}/ww/html ${WW}/sample-chapter.ptx
cp -a ${SCRATCH}/ww/html/ ${SITE}/examples/webwork/sample-chapter
# Problem Sets
# recycle merged source from PDF run
install -d ${SITE}/examples/webwork/sample-chapter/archive
cd ${SITE}/examples/webwork/sample-chapter/archive
xsltproc -stringparam publisher ${WWPUB} -stringparam chunk.level 1 ${MBXSL}/pretext-ww-problem-sets.xsl ${WW}/sample-chapter.ptx


# Sample article
# N.B. bare minimum, so use pdflatex
echo
echo "BUILD: creating sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/examples/sample-article/html
# PDF
${PTXPTX} -v -c all -f pdf -d ${SITE}/examples/sample-article -p ${SA}/publication.xml ${SA}/sample-article.xml
# HTML
${PTXPTX} -v -c all -f html -d ${SITE}/examples/sample-article/html -p ${SA}/publication.xml ${SA}/sample-article.xml

# Sample article, styled w/ oscarlevin, just HTML
echo
echo "BUILD: creating sample article, oscarlevin style :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/examples/sample-article/oscar
# HTML only, 2-deep sidebar ToC
${PTXPTX} -v -c all -f html -d ${SITE}/examples/sample-article/oscar -p ${SA}/publication-oscarlevin.xml ${SA}/sample-article.xml

# Sample article, styled w/ crc, just HTML
echo
echo "BUILD: creating sample article, crc style :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/examples/sample-article/crc
# HTML only , 2-deep sidebar ToC
${PTXPTX} -v -c all -f html -d ${SITE}/examples/sample-article/crc -p ${SA}/publication-crc.xml ${SA}/sample-article.xml

# Sample article, as HTML only, with "View Source" annotations
echo
echo "BUILD: creating annotated sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# playground for "cleaned-up" annotated version
install -d ${SCRATCH}/sa/annotated
cd ${SCRATCH}/sa/annotated
# mimic pretext script with directory management
install -d external generated
cp -a ${SA}/media/ .
cp -a ${SA}/gen/ .
# Pretty-print and drop here, arguments are directories, source will be found
${LTL}/ltol.py xml_pp ${SA} .
# need publication file next to massaged source, for managed directories
cp -a ${SA}/publication.xml .
# location in final tree
install -d ${SITE}/examples/sample-article/annotated
# run script, most inputs are local to cwd
${PTXPTX} -v -c all -f html -x debug.html.annotate yes -d ${SITE}/examples/sample-article/annotated -p publication.xml sample-article.xml


# Humanities in Action
echo
echo "BUILD: creating humanities :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/examples/humanities/html
# PDF
${PTXPTX} -v -c all -f pdf -d ${SITE}/examples/humanities -p ${HIA}/publication/publication.ptx ${HIA}/source/hia.xml
# HTML
${PTXPTX} -v -c all -f html -d ${SITE}/examples/humanities/html -p ${HIA}/publication/publication.ptx ${HIA}/source/hia.xml


# Characters, Fonts, Languages
# N.B. requires xelatex
# No publisher file
echo
echo "BUILD: creating font sample :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/examples/fonts/html
# PDF
${PTXPTX} -v -c all -f pdf -d ${SITE}/examples/fonts ${FC}/fonts-and-characters.xml
# HTML
${PTXPTX} -v -c all -f html -d ${SITE}/examples/fonts/html ${FC}/fonts-and-characters.xml


# Showcase
echo
echo "BUILD: creating Showcase :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# Passing watermark like this fails with script, move to a publisher file when ready
# declare WATER="-stringparam watermark.text DRAFT -stringparam watermark.scale 1.0"

install -d ${SITE}/examples/showcase ${SITE}/examples/showcase/html
# WW representations, stop frivolous changes in repository
${MB}/pretext/pretext -v -a -c webwork  -x debug.datedfiles no -p ${SC}/publisher/publication.xml            ${SC}/source/pretext-showcase.ptx
# PDF
${MB}/pretext/pretext -v -c all -f pdf  -p ${SC}/publisher/publication.xml -d ${SITE}/examples/showcase      ${SC}/source/pretext-showcase.ptx
#HTML
${MB}/pretext/pretext -v -c all -f html -p ${SC}/publisher/publication.xml -d ${SITE}/examples/showcase/html ${SC}/source/pretext-showcase.ptx

# Git for Authors
echo
echo "BUILD: creating Git for Authors :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/gfa
# PDF
${PTXPTX} -v -c all -f pdf -d ${SITE}/gfa -p ${GFA}/publication/publication.xml ${GFA}/src/gfa.xml
# HTML
${PTXPTX} -v -c all -f html -d ${SITE}/gfa/html -p ${GFA}/publication/publication.xml ${GFA}/src/gfa.xml


# The PreTeXt Schema Literate Program
echo
echo "BUILD: creating the schema literate program :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${SITE}/doc/schema-litprog/html
# PDF
${PTXPTX} -v -c all -f pdf -d ${SITE}/doc/schema-litprog -p ${LP}/publication.xml ${LP}/pretext.xml
# HTML
${PTXPTX} -v -c all -f html -d ${SITE}/doc/schema-litprog/html -p ${LP}/publication.xml ${LP}/pretext.xml


# Catalog
echo
echo "BUILD: creating PreTeXt Catalog page :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cd ${SITE}
cp ${PP}/css/pretext-projects.css .
xsltproc -o catalog-frame.html -xinclude ${PP}/xsl/projects-html.xsl ${PP}/src/projects.xml

# Catalog
echo
echo "BUILD: creating PreTeXt Gallery page :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cd ${SITE}
cp ${PP}/css/pretext-projects.css .
xsltproc -o gallery-frame.html -xinclude ${PP}/xsl/gallery-html.xsl ${PP}/src/projects.xml

# Website pages
echo "BUILD: creating website pages :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cd ${SITE}
xsltproc ${ROOT}/pages/mathbook-website.xsl ${ROOT}/pages/mathbook-site.xml

#####################
# Wait for background
#####################
wait
# audible announcement
# paplay /usr/share/sounds/gnome/default/alerts/glass.ogg
aplay /usr/share/sounds/sound-icons/trumpet-1.wav

#######
# Rsync
#######

# rsync various directories
# See http://everythinglinux.org/rsync/
#   removed: --times --perms --links

# 2023-02-24: restored --delete after recursive

declare RSYNC="rsync --verbose  --progress --stats --compress --rsh=/usr/bin/ssh --recursive --delete --exclude=beta"

# mathbook.pugetsound.edu
# ${RSYNC} ${SITE}/*  beezer@userweb.pugetsound.edu:/home/beezer/mathbook.pugetsound.edu
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: running rsyncs, will need  utmost@utmost.aimath.org  password... :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "BUILD: rsync entire website :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	${RSYNC} ${SITE}/*  utmost@utmost.aimath.org:/home/utmost/www/pretextbook.org/htdocs
fi

echo
echo "Build script complete"
exit 0

### sample book, sample article
### mathbook.pugetsound.edu/examples
##echo
##echo "BUILD: rsync examples directory :BUILD"
##echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
##${RSYNC} ${SITE}/examples/*  beezer@userweb.pugetsound.edu:/home/beezer/mathbook.pugetsound.edu/examples
##
### Git for Authors
### mathbook.pugetsound.edu/gfa
##echo
##echo "BUILD: rsync GFA directory :BUILD"
##echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
##${RSYNC} ${SITE}/gfa/*  beezer@userweb.pugetsound.edu:/home/beezer/mathbook.pugetsound.edu/gfa