#!/bin/bash
#
# PreTeXt Website construction
#
# History
#
#  2025-11-12  Fresh start

#######################
# Script Infrastructure
#######################

# Source a custom file with relocation path names
# See paths.sh.template, copy to paths.sh and edit
# "dot" syntax is POSIX for "source"
# Alternatives: http://stackoverflow.com/questions/192292
DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
. ${DIR}/paths.sh

echo ${DIR}
# Default is to use public repositories, for the best fidelity
# But sometimes we want to test a change using the current
# version/branch of some repositories, principally pretext itself.
# So we allow a single command line option "local", which if present
# will adjust some components of the build.

if [ "${1}" = "local" ] ; then
	declare PTX=${LOCALPTX}
else
	declare PTX=${REPOS}/pretext
fi

# When debugging changes, leave the local temporary directories
# around for inspection.  See use at the end of the script.
# DEBUG=1 sets the variable to a non-empty string,
#         debugging on, directories remain
# DEBUG=  leaves the variable unset, and directories get cleaned up
DEBUG=1

###############
# Prerequisites
###############

# Certain system executables are presumed:
#   install
#   xsltproc
#   git
#   python
#   notify-send

# Certain tasks are required to build everything here.  This is
# a list of reminders, precise instructions will be elsewhere.

# 1.  Building the PDF of the PreTeXt Guide requires
#     the Libertine Serif OTF font.
#
# 2.  Output formats which depend on "offline" MathJax
#     to render LaTeX will first need to have the
#
#         pretext/script/mjsre/update-sre
#
#     script run in the pretext/script/mjsre directory of
#     the  pretext  repository used from ${REPOS} (${PTX}).
#     This in turn requires having  npm  for installation,
#     and  node  for use.  These formats include EPUB and braille.
#
# 3.  For the examples of the sample article as HTML output
#     with different themes, as a one-time setup step, run
#
#         npm install
#
#     in the pretext/script/cssbuilder directory of
#     the  pretext  repository used from ${REPOS} (${PTX}).
#     This in turn requires having  npm  for installation,
#     and  node  for use.
#
# 4.  The Pelican static site generator is used to build
#     the landing pages.  This requires having Python
#     and Pelican installed.  Run
#
#	      pip install pelican[markdown]
#
# 	  to install Pelican via pip.
#
# 5.  Annotated examples are built from PreTeXt source that
#     has first been pretty-printed by  pretext-format,  the
#     PreTeXt source formatter.  As a one-time setup step, run
#
#         scripts/pretext-format/update-format
#
#     in the  scripts/pretext-format  directory of the website
#     repository.  This in turn requires having  npm  for
#     installation, and  node  for use.
#
# 6.  The "pdf-fo" format (an experimental, LaTeX-free route to an
#     accessible PDF via XSL-FO) is rendered by the Apache FOP
#     processor, which must be installed.  On Debian:
#
#         apt install fop

#######################
# Temporary Directories
#######################

# Customized temporary directories
# SCRATCH is a place to format source for annotated versions
# STAGED holds the entire website before rsyn'ing to server
# ToDo: maybe /tmp is not portable?

# PreTeXt source for annotated versions must be formatted first,
# so the "View Source" annotations are easier to read.  We need
# a "scratch" directory where the source can be manipulated by
# the  pretext-format  tool
SCRATCH=$(mktemp -d "${TMPDIR:-/tmp}/scratch.XXXXXXXX")

# The build script make a temporary copy of all the material that
# belongs on the website, then moves it to the website  host proper.
STAGED=$(mktemp -d "${TMPDIR:-/tmp}/staged.XXXXXXXX")


############################
# Miscellaneous Conveniences
############################

# pretext/pretext executable
declare PTXPTX=${PTX}/pretext/pretext

# PreTeXt source formatter (see scripts/pretext-format/README.md)
declare PTXFORMAT=${DIR}/pretext-format/node_modules/.bin/pretext-format
# Options chosen for compact presentation inside the
# bounded-width knowls used in annotated examples:
# aggressive line-breaking and a two-space indent.
declare PTXFORMATOPTS="--write --break-lines many --break-sentences --tab-size 2"

# PreTeXt Projects repository
declare PP=${REPOS}/pretext-projects

# Git for Authors
declare GFA=${REPOS}/gfa


#####################
# Directory Locations
#####################

# Convenience locations for various directories

declare EXAMPLESOUT=${STAGED}/examples
declare DOCOUT=${STAGED}/doc

# variant destinations for sample book versions
declare SBNP=noparts
declare SBDE=decorative
declare SBST=structural

##################
# Source Materials
##################

# Convenience locations for various source material

declare SA=${PTX}/examples/sample-article
declare SB=${PTX}/examples/sample-book
declare WW=${PTX}/examples/webwork/sample-chapter
declare PFD=${PTX}/examples/pdf-fo-development
declare G=${PTX}/doc/guide
declare ES=${PTX}/examples/epub
declare SS=${PTX}/examples/sample-slideshow
declare SLP=${PTX}/schema
declare PELICAN=${DIR}/../site

###############
# Overall Setup
###############

# Create staging area (especially since it should be regularly trashed)
install -d ${STAGED}

# Scratch directory for formatting source material
install -d ${SCRATCH}

###########################
# Virtual Environment check
###########################

# RAB has Pelican installed in a virtual environment, and
# frequently forgets to switch there.  This is a hard stop.

if ! command -v pelican >/dev/null 2>&1; then
    echo "ERROR: Pelican executable not found.  Did you forget to use the right environment?  Script is not being executed." >&2
    exit 1
fi

# Likewise, pretext-format must be installed via the one-time
# setup step described above (scripts/pretext-format/update-format).
if [ ! -x "${PTXFORMAT}" ]; then
    echo "ERROR: pretext-format executable not found at ${PTXFORMAT}." >&2
    echo "Did you run scripts/pretext-format/update-format (from within the  scripts/pretext-format  directory?)" >&2
    exit 1
fi

##############
# Repositories
##############

# Various repositories are assumed to live under ${REPOS}
# locally.  We catalog them here, by their GitHub names

# 0.  PreTeXtBook/PreTeXt-website

# This repository, holding this script and the page sources.  Unlike
# the repositories below, a stale or modified copy here does not fail
# loudly, it just quietly builds and publishes the wrong site.  So the
# state is checked, and anything unexpected stops the build outright
# rather than letting it proceed.
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: website repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${DIR}/..
	# Each condition is checked on its own.  A plain "git pull --ff-only"
	# is not enough: when the remote has nothing new it succeeds even
	# from a modified or ahead-of-origin copy, which is exactly the state
	# worth catching.
	declare WEBSITE_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	if [ "${WEBSITE_BRANCH}" != "main" ] ; then
		echo "ERROR: the website repository is on branch ${WEBSITE_BRANCH}, not main." >&2
		echo "Switch to main before building, or run  build.sh local  to build from the copy as it stands." >&2
		exit 1
	fi
	if [ -n "$(git status --porcelain --untracked-files=no)" ] ; then
		echo "ERROR: the website repository has uncommitted changes to tracked files." >&2
		echo "Commit or stash them, or run  build.sh local  to build from the copy as it stands." >&2
		exit 1
	fi
	if ! git fetch origin main ; then
		echo "ERROR: could not reach origin to update the website repository." >&2
		exit 1
	fi
	if [ -n "$(git rev-list origin/main..HEAD)" ] ; then
		echo "ERROR: the website repository has commits that are not on origin/main." >&2
		echo "Push them, or run  build.sh local  to build from the copy as it stands." >&2
		exit 1
	fi
	if ! git merge --ff-only origin/main ; then
		echo "ERROR: could not fast-forward the website repository to origin/main." >&2
		exit 1
	fi
fi

# 1.  PreTextBook/pretext

# PreTeXt, master branch of *public* repository
# Do not touch a local version, it might be in
# any sort of state for testing purposes
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: PreTeXt repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${PTX}
	git checkout master
	git pull
fi

# PreTeXt Projects repository
# Data and tools for Catalog and Gallery
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: PreTeXt Projects repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${PP}
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

#################
# Landing pages #
#################

# Gallery and Catalog page, generated from pretext-projects data.
# Produces an HTML file with Pelican metadata, placed where Pelican
# can process it as a page (the "generated" content directory).
echo
echo "BUILD: creating Gallery and Catalog page :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${PELICAN}/generated
xsltproc -o ${PELICAN}/generated/gallery.html --xinclude ${PP}/xsl/gallery-catalog-html.xsl ${PP}/src/projects.xml

# Build the landing pages from the site directory using Pelican.
# This should be run from the "site" directory of the "pretext-website" repository.
# Pelican picks up both "pages" and "generated" directories (see pelican_settings.py).
echo
echo "BUILD: creating landing pages with Pelican :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cd ${PELICAN}
pelican . -o ${STAGED} -s ./pelican_settings.py

# N.B. if you only want to build the site's web pages for testing
# purposes and local viewing, then uncomment the "exit" command below
# to prevent a lot of wating around (and avoid a lot of configuration)
# exit 0

###############
# Documentation
###############

# The PreTeXt Guide, primary documentation
echo
echo "BUILD: creating The Guide :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${DOCOUT}/guide/html
# PDF
# "fancy" vertsion via a LaTeX style file given in a publisher file
${PTXPTX} -v -o ${DOCOUT}/guide/pretext-guide.pdf -c doc -f pdf -p ${G}/publication-styled.xml ${G}/guide.xml
# HTML
${PTXPTX} -v -d ${DOCOUT}/guide/html -c doc -f html -p ${G}/publication.xml ${G}/guide.xml

echo
echo "BUILD: creating the schema literate program :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${DOCOUT}/schema-litprog/html
# PDF
${PTXPTX} -v -c doc -f pdf -d ${DOCOUT}/schema-litprog -p ${SLP}/publication.xml ${SLP}/pretext.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${DOCOUT}/schema-litprog/html -p ${SLP}/publication.xml ${SLP}/pretext.xml

# Git for Authors
echo
echo "BUILD: creating Git for Authors :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${DOCOUT}/gfa/html
# PDF
${PTXPTX} -v -c doc -f pdf -d ${DOCOUT}/gfa -p ${GFA}/publication/publication.ptx ${GFA}/src/gfa.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${DOCOUT}/gfa/html -p ${GFA}/publication/publication.ptx ${GFA}/src/gfa.xml

##########
# Examples
##########

# Sample article
echo
echo "BUILD: creating sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${EXAMPLESOUT}/sample-article/html
# PDF - electronic
${PTXPTX} -v -c doc -f pdf -d ${EXAMPLESOUT}/sample-article -p ${SA}/publication.xml ${SA}/sample-article.xml
# PDF - print, with outfile name change
${PTXPTX} -v -c doc -f pdf -o ${EXAMPLESOUT}/sample-article/sample-article-print.pdf -p ${SA}/publication-print.xml ${SA}/sample-article.xml
# PDF - accessible, via XSL-FO and Apache FOP (very experimental, but
# with full PDF/UA-1 coverage).  Requires the Apache FOP processor
# (Debian package:  fop).  Built twice, once for each of the two text
# fonts this route offers, so the website can present them side by
# side.  The font is a publication file setting, so the two builds
# differ only in the publication file they are given:  publication.xml
# asks for "latin-modern" (also the default),  publication-alegreya.xml
# asks for "alegreya".  Both outfile names carry their font, so that
# neither one reads as the plain or preferred version.
${PTXPTX} -v -c doc -f pdf-fo -o ${EXAMPLESOUT}/sample-article/sample-article-fo-latin-modern.pdf -p ${SA}/publication.xml ${SA}/sample-article.xml
${PTXPTX} -v -c doc -f pdf-fo -o ${EXAMPLESOUT}/sample-article/sample-article-fo-alegreya.pdf -p ${SA}/publication-alegreya.xml ${SA}/sample-article.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/sample-article/html -p ${SA}/publication.xml ${SA}/sample-article.xml

echo
echo "BUILD: creating sample article with themes :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Available themes for HTML builds
THEMES=("default-modern" "tacoma" "greeley" "boulder" "salem" "denver")

# Loop over themes, building sample article into different directories
for THEME in "${THEMES[@]}"; do
    echo "## Sample Article with $THEME theme"
    install -d ${EXAMPLESOUT}/sample-article/${THEME}
    ${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/sample-article/${THEME} -x debug.html.theme-name ${THEME} -p ${SA}/publication.xml ${SA}/sample-article.xml
done

# Sample article, HTML, with "View Source" annotations
echo
echo "BUILD: creating annotated sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# place to work on formatting
install -d ${SCRATCH}/sa/annotated
cd ${SCRATCH}/sa/annotated
# copy creates a "sample-article" directory
cp -a ${SA} .
# Pretty-print the top-level XML source files in place
# (overwriting parts of the copy above), so the
# "View Source" annotations are easier to read.
# The  *.xml  glob also sweeps up files that are never
# shown in the annotated output (publication files,
# etc.) -- formatting them has no real effect but
# also no real cost.
( cd ./sample-article && ${PTXFORMAT} ${PTXFORMATOPTS} *.xml )
# location in final tree
install -d ${EXAMPLESOUT}/sample-article/annotated
# reset, then drop down one more level
cd -
cd ${SCRATCH}/sa/annotated/sample-article
${PTXPTX} -v -c doc -f html -x debug.html.annotate yes -d ${EXAMPLESOUT}/sample-article/annotated -p publication.xml sample-article.xml
cd -

# FO test development article
echo
echo "BUILD: creating FO test development article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# The development document for the "pdf-fo" format: a LaTeX-free,
# accessible PDF rendered through XSL-FO by Apache FOP.  We build
# the same source four ways (the accessible FO PDF, a regular
# LaTeX PDF, HTML, and EPUB) for side-by-side comparison.  The
# "pdf-fo" format requires the Apache FOP processor (Debian
# package:  fop)
install -d ${EXAMPLESOUT}/pdf-fo-development/html
# PDF - accessible, via XSL-FO and Apache FOP (the default outfile
# name is the headline product)
${PTXPTX} -v -c doc -f pdf-fo -d ${EXAMPLESOUT}/pdf-fo-development -p ${PFD}/publication.xml ${PFD}/pdf-fo-development.xml
# PDF - regular (LaTeX), outfile renamed so it does not collide
# with the FO PDF above
${PTXPTX} -v -c doc -f pdf -o ${EXAMPLESOUT}/pdf-fo-development/pdf-fo-development-latex.pdf -p ${PFD}/publication.xml ${PFD}/pdf-fo-development.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/pdf-fo-development/html -p ${PFD}/publication.xml ${PFD}/pdf-fo-development.xml
# EPUB (non-Kindle, mathematics as SVG)
${PTXPTX} -v -c doc -f epub-svg -o ${EXAMPLESOUT}/pdf-fo-development/pdf-fo-development.epub -p ${PFD}/publication.xml ${PFD}/pdf-fo-development.xml

# Sample book
echo
echo "BUILD: creating sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# Tests/illustrates: no parts, decorative parts, structural parts

# no parts
install -d ${EXAMPLESOUT}/sample-book/${SBNP}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-noparts.xml -d ${EXAMPLESOUT}/sample-book/${SBNP}      ${SB}/sample-book.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-noparts.xml -d ${EXAMPLESOUT}/sample-book/${SBNP}/html ${SB}/sample-book.xml
# decorative
install -d ${EXAMPLESOUT}/sample-book/${SBDE}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-decorative.xml -d ${EXAMPLESOUT}/sample-book/${SBDE}      ${SB}/sample-book-parts.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-decorative.xml -d ${EXAMPLESOUT}/sample-book/${SBDE}/html ${SB}/sample-book-parts.xml
# structural
install -d ${EXAMPLESOUT}/sample-book/${SBST}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-structural.xml -d ${EXAMPLESOUT}/sample-book/${SBST}      ${SB}/sample-book-parts.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-structural.xml -d ${EXAMPLESOUT}/sample-book/${SBST}/html ${SB}/sample-book-parts.xml

# Sample book, as HTML, with "View Source" annotations
echo
echo "BUILD: creating annotated sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# place to work on formatting
install -d ${SCRATCH}/sb/annotated
cd ${SCRATCH}/sb/annotated
# copy creates a "sample-book" directory
cp -a ${SB} .
# Pretty-print XML source in place (overwriting parts of
# the copy above), so the "View Source" annotations are
# easier to read.  XML lives in the top level and in the
# exercises  and  sage  subdirectories.  The  *.xml  globs
# also sweep up files that are never shown in the annotated
# output (publication files, etc.) -- formatting them has
# no real effect but also no real cost.
( cd ./sample-book && ${PTXFORMAT} ${PTXFORMATOPTS} *.xml exercises/*.xml sage/*.xml )
# text files being included, just copy
cp ${SB}/code/symmetric-group-8.sage  ./sample-book/code
cp ${SB}/tikz/cyclic-roots-unity.tex  ./sample-book/tikz
# location in final tree
install -d ${EXAMPLESOUT}/sample-book/annotated
# reset, then drop down one more level
cd -
cd ${SCRATCH}/sb/annotated/sample-book
${PTXPTX} -v -c doc -f html -x debug.html.annotate yes -d ${EXAMPLESOUT}/sample-book/annotated -p publication-structural.xml sample-book-parts.xml
cd -

# WebWork sample chapter
echo
echo "BUILD: creating WW sample chapter :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# WW representations for the sample chapter are tracked in the PreTeXt repository,
# so they are kept current via re-generation, and commits with necessary updates.

# PDF
install -d ${EXAMPLESOUT}/webwork/sample-chapter
${PTXPTX} -v -c doc -f pdf -p ${WW}/publisher/publication.xml -d ${EXAMPLESOUT}/webwork/sample-chapter/ ${WW}/sample-chapter.ptx
# HTML
# Publisher file sets all problems to be dynamic, for demonstration purposes
install -d ${EXAMPLESOUT}/webwork/sample-chapter/html
${PTXPTX} -v -c doc -f html -p ${WW}/publisher/publication.xml -d ${EXAMPLESOUT}/webwork/sample-chapter/html ${WW}/sample-chapter.ptx
# Problem archive (PG, set definitions, set headers)
# -z argument makes a "compressed tar archive"
install -d ${EXAMPLESOUT}/webwork/sample-chapter
${PTXPTX} -v -c doc -f webwork-sets -p ${WW}/publisher/publication.xml -z -d ${EXAMPLESOUT}/webwork/sample-chapter ${WW}/sample-chapter.ptx

# EPUB sampler, PDF, HTML, EPUB (SVG)
echo
echo "BUILD: creating the EPUB Sampler :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${EXAMPLESOUT}/epub-sampler/html
# PDF
${PTXPTX} -v -o ${EXAMPLESOUT}/epub-sampler/epub-sampler.pdf -c doc -f pdf -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# HTML
${PTXPTX} -v -d ${EXAMPLESOUT}/epub-sampler/html -c doc -f html -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# EPUB
${PTXPTX} -v -o ${EXAMPLESOUT}/epub-sampler/epub-sampler.epub -c doc -f epub-svg -p ${ES}/publication.xml ${ES}/epub-sampler.xml

# Sample slideshow, as a Beamer PDF and as a reveal.js page
echo
echo "BUILD: creating the Sample Slideshow :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${EXAMPLESOUT}/sample-slideshow/revealjs
# Beamer, which produces the PDF directly
${PTXPTX} -v -d ${EXAMPLESOUT}/sample-slideshow -c doc -f beamer -p ${SS}/publication.xml ${SS}/sample-slideshow.xml
# reveal.js, from the publication file electing embedded resources, so the
# page carries reveal.js, the stylesheets, the fonts, and the mathematics as
# SVG, all inline.  Images are the exception and stay on disk, so the build's
# copies of the managed  external  and  generated  directories travel with the
# page.  (The  _static  directory the build also emits is not referenced by
# this page at all, and is left behind in the staging area.)
${PTXPTX} -v -d ${EXAMPLESOUT}/sample-slideshow/revealjs -c doc -f revealjs -p ${SS}/publication-single-file.xml ${SS}/sample-slideshow.xml


############
# Rsync Site
############

# See http://everythinglinux.org/rsync/
#   removed: --times --perms --links

declare RSYNC="rsync --verbose  --progress --stats --compress --rsh=/usr/bin/ssh --recursive --delete --exclude=beta"

if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: running rsyncs, will need  utmost@utmost.aimath.org  password... :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "BUILD: rsync entire website :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	# "notify-send" only works on Linux
	# printf "\a" is portable, but a bit unreliable
	notify-send "PreTeXt build script commplete.  Waiting for rsync password..." --urgency=critical

	${RSYNC} ${STAGED}/*  utmost@pretextbook.org:/home/utmost/www/pretextbook.org/htdocs
fi

####################
# Wrapup and Cleanup
####################

echo
echo "Build script complete"

# Always clean up generated content directory within site source
rm -rf ${PELICAN}/generated

# DEBUG unset is empty string, test (-z) is true, remove temp directories
if [[ -z "${DEBUG:-}" ]]; then
    rm -rf ${STAGED} ${SCRATCH}
else
	echo "Site staging directory:" ${STAGED}
    echo "Scratch formatting directory:" ${SCRATCH}
fi

exit 0
