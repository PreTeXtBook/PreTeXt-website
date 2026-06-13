title: Examples
URL:
save_as: examples.html

### Examples

We have a variety of PreTeXt projects designed to be examples of what is possible with PreTeXt.  These are not necessarily <q>best practices</q>, especially since they are also used for testing new features and new code.  They can be an adjunct to the documentation, and are always built with the very latest version of PreText.  Be sure to look for <q>annotated</q> HTML versions of the Sample Article and the Sample Book, which contain easy access to the source code right next to the output.  These source for these examples are part of the PreTeXt repository, so you can explore them further there.

To see examples of actual books (and other projects), see the Gallery at the main page of this site.

### Sample Book

The Sample Book is an example of how a book-length document can be authored and organized. It may have a run of chapters, or be structured into parts. The parts can be <q>structural</q>, where numbering of chapters restarts in each part, or <q>decorative</q>, where chapters are numbered consecutively throughout the book without regard for the parts.

The first version below has only chapters, and no parts.  There is also an annotated version of this variant.  (Note that the source annotations use two spaces for each level of indentation, to conserve screen real estate.  Some authors prefer to use four spaces.  And never use tabs!)

The final chapter contains interactive exercises and programming environments. There are powered by Javascript we get from Runestone Services. A slightly modified build will make an even more interactive version when hosted at [Runestone Academy](https://runestone.academy/) on a dedicated (no-cost) server there.

Chapters Only:

- [Sample Book, Online](examples/sample-book/noparts/html)
- [Sample Book, PDF](examples/sample-book/noparts/sample-book.pdf)

Structural Parts:

- [Sample Book, Online](examples/sample-book/structural/html)
- [Sample Book, PDF](examples/sample-book/structural/sample-book.pdf)

Decorative Parts:

- [Sample Book, Online](examples/sample-book/decorative/html)
- [Sample Book, PDF](examples/sample-book/decorative/sample-book.pdf)

Chapters Only, Hosted at [Runestone Academy](https://runestone.academy/):

- [Sample Book with Interactive Questions and Programs](https://runestone.academy/ns/books/published/PTXSB/index.html?mode=browsing)  (Runestone Academy tends to update every Saturday morning, so there can be differences.)

Annotated with Source Examples, with Parts:

- [Sample Book, Annotated](examples/sample-book/annotated/)

Source:

- [Sample Book, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/sample-book)

### Sample Article

The Sample Article is both a developer’s sandbox and the kitchen sink with <em>every</em> possible PreTeXt feature. It is a sandbox because we frequently test new features here and sometimes also debug problems. So sometimes it contains some preliminary, or immature, examples. It is the kitchen sink because we try to add one of everything. This is both for testing, and so that you can look at output and then examine the source to see how to do something you like or need. There is even a special version of the online output that has copious "View Source" knowls that will show you the PreTeXt source for each division and many blocks

But it is cutting-edge and contains new features before they make it into the Author’s Guide. As a testing platform, we bring the least powerful version of LaTeX to bear for creating the PDF, so this is _always_ built using the pdflatex engine (in contrast to the font example below).   (Note that the source annotations of the "annotated" version use two spaces for each level of indentation, to conserve screen real estate.  Some authors prefer to use four spaces.  And never use tabs!)

- [Sample Article, Online](examples/sample-article/html)
- [Sample Article, Annotated](examples/sample-article/annotated)
- [Sample Article, Electronic PDF (one-sided)](examples/sample-article/sample-article.pdf)
- [Sample Article, Print PDF (two-sided)](examples/sample-article/sample-article-print.pdf)
- [Sample Article, Accessible PDF via XSL-FO](examples/sample-article/sample-article-fo.pdf) (<em>very</em> experimental, but with full PDF/UA-1 accessibility coverage)
- [Sample Article, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/sample-article)

### Accessible PDF via XSL Formatting Objects

This small article is the development sandbox for an <em>experimental</em>, LaTeX-free route to PDF.  Rather than passing through LaTeX, the PreTeXt source is converted to XSL Formatting Objects (XSL-FO) and rendered by the [Apache FOP](https://xmlgraphics.apache.org/fop/) processor.  Mathematics is set with MathJax (as SVG), and the resulting PDF is <em>accessible by default</em>: it is a tagged PDF conforming to PDF/UA-1 (ISO&nbsp;14289-1, the accessibility standard), with a heading outline, alternate text for images and mathematics, document metadata, and a logical reading order built in from the start.

The same source is built three ways below, so the accessible FO PDF can be compared against a traditional LaTeX PDF and the online HTML.  This route is new and still incomplete, so expect some rough edges.

- [Development Article, Accessible PDF via XSL-FO](examples/pdf-fo-development/pdf-fo-development.pdf)
- [Development Article, Online](examples/pdf-fo-development/html)
- [Development Article, Regular (LaTeX) PDF](examples/pdf-fo-development/pdf-fo-development-latex.pdf)
- [Development Article, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/pdf-fo-development)

### WeBWorK Sample Chapter

The WeBWorK Sample Chapter contains examples of various ways to incorporate WeBWorK automated homework problems into your text. This work was initiated with a grant from [OpenOregon](http://openoregon.org/) with a matching grant from [University of Puget Sound](http://www.pugetsound.edu/).

- [WeBWorK Sample Chapter, Online](examples/webwork/sample-chapter/html)
- [WeBWorK Sample Chapter, PDF](examples/webwork/sample-chapter/sample-chapter.pdf)
- [WeBWorK Sample Chapter, PG Problem Archive](examples/webwork/sample-chapter/Integrating_WeBWorK_into_Textbooks.tgz)
- [WeBWorK Sample Chapter, Source at GitHub](https://github.com/PreTeXtBook/pretext/tree/master/examples/webwork/sample-chapter)

### Styling Online Versions

HTML output can employ a variety of styles (independent of content).  We use the Sample Article as a vehicle for demonstrating these styles.  Color schemes may also be changed, but we do not demonstrate any of that here, as each example has its default colors.

- [Sample Article, default-modern style](examples/sample-article/default-modern)
- [Sample Article, denver style](examples/sample-article/denver)
- [Sample Article, boulder style](examples/sample-article/boulder)
- [Sample Article, greely style](examples/sample-article/greely)
- [Sample Article, salem style](examples/sample-article/salem)
- [Sample Article, tacoma style](examples/sample-article/tacoma)

### EPUB Sampler

The EPUB Sampler is designed to test and stress the conversion to EPUB. We build a PDF and an HTML version, as a demonstration, even though EPUB is something of a blend of the two output formats.

- [EPUB Sampler, EPUB Format](examples/epub-sampler/epub-sampler.epub)
- [EPUB Sampler, Online](examples/epub-sampler/html)
- [EPUB Sampler, PDF](examples/epub-sampler/epub-sampler.pdf)

