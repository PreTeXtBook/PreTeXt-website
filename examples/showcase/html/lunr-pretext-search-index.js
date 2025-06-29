var ptx_lunr_search_style = "textbook";
var ptx_lunr_docs = [
{
  "id": "frontmatter",
  "level": "1",
  "url": "frontmatter.html",
  "type": "Front Matter",
  "number": "",
  "title": "Front Matter",
  "body": "  Many Contributors Some From Academic Departments  From Many Institutions  In Many Locations  beezer@pugetsound.edu        This is a showcase of PreTeXt features. It is meant to be viewed in multiple output forms (HTML, PDF) to demonstrate what is possible from PreTeXt source.   "
},
{
  "id": "mathematics",
  "level": "1",
  "url": "mathematics.html",
  "type": "Section",
  "number": "1",
  "title": "Mathematics",
  "body": " Mathematics   The Quadratic Formula  There is a derivation of the quadratic formula that avoids using fractions until the very end. Suppose that we have an equation , where . Since is also not equal to , we may multiply each side of the equation by and not lose any information: mathematics intertext  mathematics aligned equations  And this is the famous quadratic formula.    Some Amusing Identities  These equations are amusing, although maybe only to mathematicians. Largely taken from math.stackexchange.com . mathematics displayed equations            "
},
{
  "id": "environments",
  "level": "1",
  "url": "environments.html",
  "type": "Section",
  "number": "2",
  "title": "Environments",
  "body": " Environments  Oscar Levin     Demonstrate block environments.    Illustrate styling.      This section will demonstrate some of the environments available in PreTeXt . In addition to cataloging the options an author has to break up content, this will be a nice place to play with various styles that are under development.  Maybe a better way to describe what this section will do is by specifying our objectives. Luckily there is an environment for that.    Traditional Structure  Many mathematics papers and textbook chapters are organized in the traditional definition-lemma-proof-theorem-proof format. Depending on how friendly the paper is, or who the intended audience is, there might be quite a bit of exposition surrounding these elements. This subsection is intended to be an illustration of this structure.  We begin with some basic definitions. Depending on the narrative style of your text, you might want to define terms in the middle of paragraphs. We might call this an inline definition , which can be accomplished using the <term> tag.  More formal texts will likely want numbered definitions.    A numbered definition is a definition that gets a number. Note that we should still put the term being defined in <term> tags.    One advantage to having numbered definitions (see ) is that you can refer to them, just like we just did. We can also refer to titled definitions (see ).   Titled definitions   When a definition is a numbered definition that also gets a title, we call it a titled definition .    At this point it might be useful to give a few examples of the terms defined by your definitions. Of course here the definitions are examples of definitions, so instead will illustrate our point with an example of an example.   This example is an example of an example that stands alone. It does not have a question in it, so it does not need a solution.  Of course examples can consist of more than one paragraph, as this is also an example of. In fact, we could put an ordered list of things that could go in an example:   There could just be a paragraph or two.    There could be a list of examples.    All of the above.      While on this topic, it is worth mentioning that many authors choose to include examples of problems that can be solved. This suggests that part of an example is the solution. For example:   example of example   How do you include an example that has a solution, and maybe also a hint?    Make sure you put the question is the <statement> .    As mentioned in the hint, you must structure the example as a statement, followed by a hint, answer, and\/or solution.  This example is not an example of an example that has a separate answer, but of course you could have an answer as well.     Examples with titles   Can examples have titles?    Yes.    Returning to our main goal of establishing new mathematical theory, we might next state an axiom or two (especially if we are named Euclid). In PreTeXt the environments for axioms are not definition-like (the only definition-like environment is a definition). There are quite a few axiom-like environments.    Axiom-like environments consist of: axiom, conjecture, principle, heuristic, hypothesis, and assumption.    Once you have defined your terms and stated your axioms, you will likely want to prove something. Perhaps you will start with a lemma or two, use them to prove a theorem , followed by a few corollaries . If you are not as confident in the importance of your results, you might call them propositions or just facts .    There exist lemmas that are presented without proof.    The lemma above did not have a proof, since it's proof is obvious.    Lemmas can have proofs.    This is clear, as it follows from the proof of .    Using the two lemmas above, we arrive at the following:   The Fundamental Theorem of Nonsense   Let be any statement that follows from the two lemmas above. Then is true.    There is no reason you need to prove a theorem right away. You can always have some text, like this paragraph, before the proof. You could even have an example of how a theorem could be applied before pulling the reader back in for the eagerly awaited proof.   This is an example of how you might interject an example before completing a proof. As such it is put between the statement of the theorem and its proof.   Note that if you don't give a proof a title, it will get titled proof automatically. It makes sense to put a custom title in this case since you are referring to a proof of the a theorem that was stated without proof earlier.   Proof of  Let be as described in the theorem. By the lemmas, is true.  Therefore, .     The previous theorem is not useful.    Lemmas, theorems, and corollaries naturally go together. There are other theorem-like environments that you might view as parallel to these. Here is an example.    Propositions are like theorems, but perhaps not as important.    If students are reading your textbook, it might be time to collect the main points that you have made for your students and put them in a box. You could also put your result in the box and let your student roam free. The following is an <assemblage> .   Types of environments   PreTeXt allows for a variety of environments:   Definitions    Theorem-like environments    Assemblages, to assemble or summarize important connected ideas.      Your paper will likely have lots of remarks about its content as the connecting text between theorems, as this section exemplifies. However, it might also be useful to highlight important remarks, or to set off remarks that do not otherwise fit into the main flow of the text.   Resist the temptation to use assemblages just because they give you the desired styling.   If your remark is far removed from your main content, you might make it as an aside.   The <aside> environment might be styled so that it is literally on the side of the page. Also, some cats are better than some dogs, but some dogs are better than all cats.    Another environment like a remark is a note . Other remark-like environments are <convention> , <observation> , <warning> , and <insight> .   No self-respecting paper on self-reference would be complete without some open questions. You might make some conjectures, which are axiom-like environments in PreTeXt .    All the conjectures made in this paper are false.    You might also present a question for your readers. The <question> and <problem> environments might be appropriate, although note that these are example-like, as they can receive hints, answers, and solutions.    What's the difference between an example and a question or problem?    Basically, it's just the name of the environment. Practically, the different environments might have pedagogical uses, and potentially they could be styled differently.     Find a better solution to .   As a final example, we present a renamed environment. In PreTeXt , one of the theorem-like environments is fact. But perhaps you would rather use Self Evident Fact as your environment name. The following is coded as <fact> , but using <rename> in <docinfo> we can get the following    It goes without saying!    In addition to <example> , PreTeXt provides two more example-like environments: question and problem.    Inquiry Based Structure  Another way you might structure a chapter is to give students more opportunities to actively engage in the material. You might give a long list of definitions, and then a list of theorems to prove. That would look a lot like the previous section (perhaps with fewer paragraphs between elements).  Alternatively, you can mix inquiry based learning ( IBL ) structure into a more traditionally formatted section using appropriate environments. You might start a section with an <activity> , for example.    Make a list of all the project-like environments, such as this activity.    You might want to break down the activity into smaller tasks, which can be done by specifying each <task> , as in the following project.    First you give an introduction to the project to tie the tasks together. Then:    Specify the first task.     Should the second task have a hint?    It could.      Can tasks, or stand alone projects, have answers or solutions?    Yes. They can have both.    Yes, they can. Depending on how the publisher chooses to produce your book, these could be hidden completely, moved to the back of the book, or displayed as knowls.     You might end the project with a conclusion.    Of course you might still have definitions, theorems, and examples in a document like this.    A definition is illustrative if it serves the purpose of illustrating something.    And then you might have an example.    Should an example always follow a definition?    No, but it could.    Examples are a good way to ask students to think about a problem but provide a solution right away. To encourage students to think about a problem more before giving the solution, you could use an exercise. In PreTeXt , exercises that occur inside a section, along with other content, are called checkpoints , even though they are coded simply as <exercise>     Write an exercise inside a section to show what they look like.    Done.    Of course, in this style of document, collecting important ideas is especially important.   Components of good IBL writing  Texts that support inquiry based learning should contain lots of opportunities for students to engage with the material, but can still be friendly and help students along their journey of discovery.    "
},
{
  "id": "environments-3",
  "level": "2",
  "url": "environments.html#environments-3",
  "type": "Objectives",
  "number": "2",
  "title": "",
  "body": "   Demonstrate block environments.    Illustrate styling.    "
},
{
  "id": "environments-5-3",
  "level": "2",
  "url": "environments.html#environments-5-3",
  "type": "Paragraph (with a defined term)",
  "number": "",
  "title": "",
  "body": "inline definition "
},
{
  "id": "def-numbered-definition",
  "level": "2",
  "url": "environments.html#def-numbered-definition",
  "type": "Definition",
  "number": "2.1",
  "title": "",
  "body": "  A numbered definition is a definition that gets a number. Note that we should still put the term being defined in <term> tags.   "
},
{
  "id": "def-titled-definition",
  "level": "2",
  "url": "environments.html#def-titled-definition",
  "type": "Definition",
  "number": "2.2",
  "title": "Titled definitions.",
  "body": " Titled definitions   When a definition is a numbered definition that also gets a title, we call it a titled definition .   "
},
{
  "id": "environments-5-9",
  "level": "2",
  "url": "environments.html#environments-5-9",
  "type": "Example",
  "number": "2.3",
  "title": "",
  "body": " This example is an example of an example that stands alone. It does not have a question in it, so it does not need a solution.  Of course examples can consist of more than one paragraph, as this is also an example of. In fact, we could put an ordered list of things that could go in an example:   There could just be a paragraph or two.    There could be a list of examples.    All of the above.     "
},
{
  "id": "environments-5-11",
  "level": "2",
  "url": "environments.html#environments-5-11",
  "type": "Example",
  "number": "2.4",
  "title": "",
  "body": " example of example   How do you include an example that has a solution, and maybe also a hint?    Make sure you put the question is the <statement> .    As mentioned in the hint, you must structure the example as a statement, followed by a hint, answer, and\/or solution.  This example is not an example of an example that has a separate answer, but of course you could have an answer as well.   "
},
{
  "id": "environments-5-12",
  "level": "2",
  "url": "environments.html#environments-5-12",
  "type": "Example",
  "number": "2.5",
  "title": "Examples with titles.",
  "body": " Examples with titles   Can examples have titles?    Yes.   "
},
{
  "id": "axiom-example",
  "level": "2",
  "url": "environments.html#axiom-example",
  "type": "Axiom",
  "number": "2.6",
  "title": "",
  "body": "  Axiom-like environments consist of: axiom, conjecture, principle, heuristic, hypothesis, and assumption.   "
},
{
  "id": "environments-5-15",
  "level": "2",
  "url": "environments.html#environments-5-15",
  "type": "Paragraph (with a defined term)",
  "number": "",
  "title": "",
  "body": "lemma theorem corollaries propositions facts "
},
{
  "id": "lem-example",
  "level": "2",
  "url": "environments.html#lem-example",
  "type": "Lemma",
  "number": "2.7",
  "title": "",
  "body": "  There exist lemmas that are presented without proof.   "
},
{
  "id": "lem-with-proof",
  "level": "2",
  "url": "environments.html#lem-with-proof",
  "type": "Lemma",
  "number": "2.8",
  "title": "",
  "body": "  Lemmas can have proofs.    This is clear, as it follows from the proof of .   "
},
{
  "id": "thm-example",
  "level": "2",
  "url": "environments.html#thm-example",
  "type": "Theorem",
  "number": "2.9",
  "title": "The Fundamental Theorem of Nonsense.",
  "body": " The Fundamental Theorem of Nonsense   Let be any statement that follows from the two lemmas above. Then is true.   "
},
{
  "id": "environments-5-22",
  "level": "2",
  "url": "environments.html#environments-5-22",
  "type": "Example",
  "number": "2.10",
  "title": "",
  "body": " This is an example of how you might interject an example before completing a proof. As such it is put between the statement of the theorem and its proof.  "
},
{
  "id": "environments-5-24",
  "level": "2",
  "url": "environments.html#environments-5-24",
  "type": "Proof",
  "number": "2.1.1",
  "title": "Proof of Theorem 2.9.",
  "body": " Proof of  Let be as described in the theorem. By the lemmas, is true.  Therefore, .  "
},
{
  "id": "cor-example",
  "level": "2",
  "url": "environments.html#cor-example",
  "type": "Corollary",
  "number": "2.11",
  "title": "",
  "body": "  The previous theorem is not useful.   "
},
{
  "id": "prop-example",
  "level": "2",
  "url": "environments.html#prop-example",
  "type": "Proposition",
  "number": "2.12",
  "title": "",
  "body": "  Propositions are like theorems, but perhaps not as important.   "
},
{
  "id": "environments-5-31",
  "level": "2",
  "url": "environments.html#environments-5-31",
  "type": "Remark",
  "number": "2.13",
  "title": "",
  "body": " Resist the temptation to use assemblages just because they give you the desired styling.  "
},
{
  "id": "environments-5-34",
  "level": "2",
  "url": "environments.html#environments-5-34",
  "type": "Note",
  "number": "2.14",
  "title": "",
  "body": " Another environment like a remark is a note . Other remark-like environments are <convention> , <observation> , <warning> , and <insight> .  "
},
{
  "id": "conj-example",
  "level": "2",
  "url": "environments.html#conj-example",
  "type": "Conjecture",
  "number": "2.15",
  "title": "",
  "body": "  All the conjectures made in this paper are false.   "
},
{
  "id": "question-example",
  "level": "2",
  "url": "environments.html#question-example",
  "type": "Question",
  "number": "2.16",
  "title": "",
  "body": "  What's the difference between an example and a question or problem?    Basically, it's just the name of the environment. Practically, the different environments might have pedagogical uses, and potentially they could be styled differently.   "
},
{
  "id": "environments-5-39",
  "level": "2",
  "url": "environments.html#environments-5-39",
  "type": "Problem",
  "number": "2.17",
  "title": "",
  "body": " Find a better solution to .  "
},
{
  "id": "fact-example",
  "level": "2",
  "url": "environments.html#fact-example",
  "type": "Self Evident Fact",
  "number": "2.18",
  "title": "",
  "body": "  It goes without saying!   "
},
{
  "id": "subsec-the-rest-4",
  "level": "2",
  "url": "environments.html#subsec-the-rest-4",
  "type": "Activity",
  "number": "2.1",
  "title": "",
  "body": "  Make a list of all the project-like environments, such as this activity.   "
},
{
  "id": "subsec-the-rest-6",
  "level": "2",
  "url": "environments.html#subsec-the-rest-6",
  "type": "Project",
  "number": "2.2",
  "title": "",
  "body": "  First you give an introduction to the project to tie the tasks together. Then:    Specify the first task.     Should the second task have a hint?    It could.      Can tasks, or stand alone projects, have answers or solutions?    Yes. They can have both.    Yes, they can. Depending on how the publisher chooses to produce your book, these could be hidden completely, moved to the back of the book, or displayed as knowls.     You might end the project with a conclusion.   "
},
{
  "id": "def-inquiry",
  "level": "2",
  "url": "environments.html#def-inquiry",
  "type": "Definition",
  "number": "2.19",
  "title": "",
  "body": "  A definition is illustrative if it serves the purpose of illustrating something.   "
},
{
  "id": "subsec-the-rest-10",
  "level": "2",
  "url": "environments.html#subsec-the-rest-10",
  "type": "Example",
  "number": "2.20",
  "title": "",
  "body": "  Should an example always follow a definition?    No, but it could.   "
},
{
  "id": "subsec-the-rest-12",
  "level": "2",
  "url": "environments.html#subsec-the-rest-12",
  "type": "Checkpoint",
  "number": "2.21",
  "title": "",
  "body": "  Write an exercise inside a section to show what they look like.    Done.   "
},
{
  "id": "latex-image",
  "level": "1",
  "url": "latex-image.html",
  "type": "Section",
  "number": "3",
  "title": "Images and Diagrams",
  "body": " Images and Diagrams   Images and Diagrams from latex Code    tikz Examples  image TikZ source     a drawing of a tall building and a tennis ball being launched upward; the path of the ball is an arc that goes upward and then downward to the ground      visual proof of the identity that the sum of k from k=1 to k=n is equal to n+1 choose 2   There is a single ball at the top; beneath that there is a row with two balls; beneath that there is a row with three balls, then four, then five, then six.  Below all this is a row with seven balls and a particular subset of two of those balls is highlighted. The diagram illustrates a correspondence from that pair to a particular ball in the upper collection.        pgfplots Examples  image pgfplots source     a plot of the implicitly defined curve x cos(x y) = 4 - y; the viewing window is [-7,7] x [-4,10.6]      a 3D partial plot of the surface defined by r(u,v) = (u + v, u^2, v^2)             Images and Diagrams from Asymptote    Canada   Canadian flag      European Union   European Union flag      United States   American flag       Area under the curve   graphic showing the area under the plot of the function e^(-x^2)      Five set Venn diagram using ellipses   Venn diagram with five sets using ellipses      Rotatable Deathstar   three-dimensional graphic of stellated icosahedron      "
},
{
  "id": "latex-image-2-2",
  "level": "2",
  "url": "latex-image.html#latex-image-2-2",
  "type": "Figure",
  "number": "3.1",
  "title": "",
  "body": " tikz Examples  image TikZ source     a drawing of a tall building and a tennis ball being launched upward; the path of the ball is an arc that goes upward and then downward to the ground      visual proof of the identity that the sum of k from k=1 to k=n is equal to n+1 choose 2   There is a single ball at the top; beneath that there is a row with two balls; beneath that there is a row with three balls, then four, then five, then six.  Below all this is a row with seven balls and a particular subset of two of those balls is highlighted. The diagram illustrates a correspondence from that pair to a particular ball in the upper collection.      "
},
{
  "id": "latex-image-2-3",
  "level": "2",
  "url": "latex-image.html#latex-image-2-3",
  "type": "Figure",
  "number": "3.2",
  "title": "",
  "body": " pgfplots Examples  image pgfplots source     a plot of the implicitly defined curve x cos(x y) = 4 - y; the viewing window is [-7,7] x [-4,10.6]      a 3D partial plot of the surface defined by r(u,v) = (u + v, u^2, v^2)     "
},
{
  "id": "latex-image-3-2-1",
  "level": "2",
  "url": "latex-image.html#latex-image-3-2-1",
  "type": "Figure",
  "number": "3.3",
  "title": "",
  "body": " Canada   Canadian flag    "
},
{
  "id": "latex-image-3-2-2",
  "level": "2",
  "url": "latex-image.html#latex-image-3-2-2",
  "type": "Figure",
  "number": "3.4",
  "title": "",
  "body": " European Union   European Union flag    "
},
{
  "id": "latex-image-3-2-3",
  "level": "2",
  "url": "latex-image.html#latex-image-3-2-3",
  "type": "Figure",
  "number": "3.5",
  "title": "",
  "body": " United States   American flag    "
},
{
  "id": "latex-image-3-3",
  "level": "2",
  "url": "latex-image.html#latex-image-3-3",
  "type": "Figure",
  "number": "3.6",
  "title": "",
  "body": " Area under the curve   graphic showing the area under the plot of the function e^(-x^2)    "
},
{
  "id": "latex-image-3-4",
  "level": "2",
  "url": "latex-image.html#latex-image-3-4",
  "type": "Figure",
  "number": "3.7",
  "title": "",
  "body": " Five set Venn diagram using ellipses   Venn diagram with five sets using ellipses    "
},
{
  "id": "latex-image-3-5",
  "level": "2",
  "url": "latex-image.html#latex-image-3-5",
  "type": "Figure",
  "number": "3.8",
  "title": "",
  "body": " Rotatable Deathstar   three-dimensional graphic of stellated icosahedron    "
},
{
  "id": "exercises",
  "level": "1",
  "url": "exercises.html",
  "type": "Section",
  "number": "4",
  "title": "Exercises",
  "body": " Exercises  An interesting concept from group theory is that of a Sylow- subgroup.   Sylow- subgroup   If is a finite group, and is a prime number, and is the largest power of dividing , then a Sylow- subgroup of is a subgroup of with order .    This definition allows to be , so might not divide . There is a theorem that gives information about how many Sylow- subgroups a finite group might have.   Sylow Theorem   If is a finite group and is a prime dividing , then the number of Sylow- subgroups of divides and is congruent to modulo .     Sylow- subgroups, group of order  If is a group of order , how many Sylow- subgroups could have?  Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either or . But of those two options, only is congruent to mod . So must have Sylow- subgroup.    Sylow- subgroups, group of order   If is a group of order , how many Sylow- subgroups could have?    Factor and use .     has Sylow- subgroup.    Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either , , or . But of those, only is a real possibility, since only is congruent to mod . So has Sylow- subgroup.     Sylow- subgroups, group of order   If is a group of order , how many Sylow- subgroups could have?    Factor and use .     either has Sylow- subgroup or it has .    Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either or . Both of those are real possibilities, since both are congruent to mod . So either has Sylow- subgroup or it has .    Understanding how to count Sylow- subgroups will help us later when we are classifying finite groups.     Does a group of order have a Sylow- subgroup?      Does always tell you exactly how many Sylow- subgroups a finite group has when you know the order of ?       Vocabulary    Research Sylow and explain who this person was with a short, one-paragraph biography.      Given a group of order , what would be the order of a Sylow- subgroup?      Calculations    If is a group of order for an odd prime , how many Sylow- subgroups might have?      Let be a group of order . For each , how many Sylow- subgroups might have?                           Thinking Deeper    If has only one Sylow- subgroup for some prime , prove that it is a normal subgroup.      If for primes , what conditions on and guarantee that ?      "
},
{
  "id": "exercises-3",
  "level": "2",
  "url": "exercises.html#exercises-3",
  "type": "Definition",
  "number": "4.1",
  "title": "Sylow-<span class=\"process-math\">\\(p\\)<\/span> subgroup.",
  "body": " Sylow- subgroup   If is a finite group, and is a prime number, and is the largest power of dividing , then a Sylow- subgroup of is a subgroup of with order .   "
},
{
  "id": "theorem-sylow",
  "level": "2",
  "url": "exercises.html#theorem-sylow",
  "type": "Theorem",
  "number": "4.2",
  "title": "Sylow Theorem.",
  "body": " Sylow Theorem   If is a finite group and is a prime dividing , then the number of Sylow- subgroups of divides and is congruent to modulo .   "
},
{
  "id": "exercises-6",
  "level": "2",
  "url": "exercises.html#exercises-6",
  "type": "Example",
  "number": "4.3",
  "title": "Sylow-<span class=\"process-math\">\\(3\\)<\/span> subgroups, group of order <span class=\"process-math\">\\(45\\)<\/span>.",
  "body": " Sylow- subgroups, group of order  If is a group of order , how many Sylow- subgroups could have?  Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either or . But of those two options, only is congruent to mod . So must have Sylow- subgroup.  "
},
{
  "id": "exercises-7",
  "level": "2",
  "url": "exercises.html#exercises-7",
  "type": "Checkpoint",
  "number": "4.4",
  "title": "Sylow-<span class=\"process-math\">\\(7\\)<\/span> subgroups, group of order <span class=\"process-math\">\\(63\\)<\/span>.",
  "body": " Sylow- subgroups, group of order   If is a group of order , how many Sylow- subgroups could have?    Factor and use .     has Sylow- subgroup.    Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either , , or . But of those, only is a real possibility, since only is congruent to mod . So has Sylow- subgroup.   "
},
{
  "id": "exercises-8",
  "level": "2",
  "url": "exercises.html#exercises-8",
  "type": "Checkpoint",
  "number": "4.5",
  "title": "Sylow-<span class=\"process-math\">\\(3\\)<\/span> subgroups, group of order <span class=\"process-math\">\\(63\\)<\/span>.",
  "body": " Sylow- subgroups, group of order   If is a group of order , how many Sylow- subgroups could have?    Factor and use .     either has Sylow- subgroup or it has .    Write to represent the number of Sylow- subgroups. We factor , separating the maximal power of from its complement. Since divides and modulo , it follows that divides . So either or . Both of those are real possibilities, since both are congruent to mod . So either has Sylow- subgroup or it has .   "
},
{
  "id": "exercises-10-1",
  "level": "2",
  "url": "exercises.html#exercises-10-1",
  "type": "Reading Question",
  "number": "4.1",
  "title": "",
  "body": "  Does a group of order have a Sylow- subgroup?   "
},
{
  "id": "exercises-10-2",
  "level": "2",
  "url": "exercises.html#exercises-10-2",
  "type": "Reading Question",
  "number": "4.2",
  "title": "",
  "body": "  Does always tell you exactly how many Sylow- subgroups a finite group has when you know the order of ?   "
},
{
  "id": "exercises-11-1-2",
  "level": "2",
  "url": "exercises.html#exercises-11-1-2",
  "type": "Exercise",
  "number": "4.1",
  "title": "",
  "body": "  Research Sylow and explain who this person was with a short, one-paragraph biography.   "
},
{
  "id": "exercises-11-1-3",
  "level": "2",
  "url": "exercises.html#exercises-11-1-3",
  "type": "Exercise",
  "number": "4.2",
  "title": "",
  "body": "  Given a group of order , what would be the order of a Sylow- subgroup?   "
},
{
  "id": "exercises-11-2-2",
  "level": "2",
  "url": "exercises.html#exercises-11-2-2",
  "type": "Exercise",
  "number": "4.3",
  "title": "",
  "body": "  If is a group of order for an odd prime , how many Sylow- subgroups might have?   "
},
{
  "id": "exercises-11-2-3-2",
  "level": "2",
  "url": "exercises.html#exercises-11-2-3-2",
  "type": "Exercise",
  "number": "4.4",
  "title": "",
  "body": "      "
},
{
  "id": "exercises-11-2-3-3",
  "level": "2",
  "url": "exercises.html#exercises-11-2-3-3",
  "type": "Exercise",
  "number": "4.5",
  "title": "",
  "body": "      "
},
{
  "id": "exercises-11-2-3-4",
  "level": "2",
  "url": "exercises.html#exercises-11-2-3-4",
  "type": "Exercise",
  "number": "4.6",
  "title": "",
  "body": "      "
},
{
  "id": "exercises-11-3-2",
  "level": "2",
  "url": "exercises.html#exercises-11-3-2",
  "type": "Exercise",
  "number": "4.7",
  "title": "",
  "body": "  If has only one Sylow- subgroup for some prime , prove that it is a normal subgroup.   "
},
{
  "id": "exercises-11-3-3",
  "level": "2",
  "url": "exercises.html#exercises-11-3-3",
  "type": "Exercise",
  "number": "4.8",
  "title": "",
  "body": "  If for primes , what conditions on and guarantee that ?   "
},
{
  "id": "worksheets",
  "level": "1",
  "url": "worksheets.html",
  "type": "Section",
  "number": "5",
  "title": "Worksheets",
  "body": " Worksheets   A Geometric Prelude     Practice visualizing vector addition  Use vectors without explicit coordinates     It was known to Euclid, and probably earlier, that the midpoints of the sides of any quadrilateral all lie in the same plane (even if the vertices of the quadrilateral do not). In fact, these midpoints are the vertices of a parallelogram, as pictured in .    The midpoints of the sides of a quadrilateral are the vertices of a parallelogram.       The sides of a triangle presented as vectors.       The medians of the triangle are , , and .       In this exercise, we'll use vectors to show that the medians of any triangle ( ) intersect at a point. Recall that medians are the lines connecting the vertices of the triangle to the midpoints of their opposite edges, as in the figure. We'll do this in a few steps.      What is the value of ?      from the previous page is reproduced for your convenience.   The medians of the triangle are , , and .         Show that .    Use .      To show that the point exists (as the common intersection of the ), show that .      If you have time, try to devise a vector proof of Euclid's result presented at the beginning of the workshop. Recall that a parallelogram is a four-sided polygon whose opposite sides are parallel.     Wrap-up  It's possible to do interesting things with vector arithmetic in a coordinate-free way: we didn't specify an origin, or any entries of any vectors in the examples.    "
},
{
  "id": "objectives",
  "level": "2",
  "url": "worksheets.html#objectives",
  "type": "Objectives",
  "number": "5.1",
  "title": "",
  "body": "  Practice visualizing vector addition  Use vectors without explicit coordinates   "
},
{
  "id": "figure-midpoints-of-quadrilateral",
  "level": "2",
  "url": "worksheets.html#figure-midpoints-of-quadrilateral",
  "type": "Figure",
  "number": "5.1",
  "title": "",
  "body": " The midpoints of the sides of a quadrilateral are the vertices of a parallelogram.     "
},
{
  "id": "figure-triangle-cyclic-vectors",
  "level": "2",
  "url": "worksheets.html#figure-triangle-cyclic-vectors",
  "type": "Figure",
  "number": "5.2",
  "title": "",
  "body": " The sides of a triangle presented as vectors.     "
},
{
  "id": "figure-triangle-cyclic-medians",
  "level": "2",
  "url": "worksheets.html#figure-triangle-cyclic-medians",
  "type": "Figure",
  "number": "5.3",
  "title": "",
  "body": " The medians of the triangle are , , and .     "
},
{
  "id": "ex-cyclic",
  "level": "2",
  "url": "worksheets.html#ex-cyclic",
  "type": "Worksheet Exercise",
  "number": "5.1.1",
  "title": "",
  "body": "  What is the value of ?   "
},
{
  "id": "figure-triangle-cyclic-medians-copy",
  "level": "2",
  "url": "worksheets.html#figure-triangle-cyclic-medians-copy",
  "type": "Figure",
  "number": "5.4",
  "title": "",
  "body": " The medians of the triangle are , , and .     "
},
{
  "id": "exercise-vector-addition",
  "level": "2",
  "url": "worksheets.html#exercise-vector-addition",
  "type": "Worksheet Exercise",
  "number": "5.1.2",
  "title": "",
  "body": "  Show that .    Use .   "
},
{
  "id": "worksheets-2-5-3-2",
  "level": "2",
  "url": "worksheets.html#worksheets-2-5-3-2",
  "type": "Worksheet Exercise",
  "number": "5.1.3",
  "title": "",
  "body": "  To show that the point exists (as the common intersection of the ), show that .   "
},
{
  "id": "worksheets-2-5-4",
  "level": "2",
  "url": "worksheets.html#worksheets-2-5-4",
  "type": "Worksheet Exercise",
  "number": "5.1.4",
  "title": "",
  "body": " If you have time, try to devise a vector proof of Euclid's result presented at the beginning of the workshop. Recall that a parallelogram is a four-sided polygon whose opposite sides are parallel.  "
},
{
  "id": "webwork",
  "level": "1",
  "url": "webwork.html",
  "type": "Section",
  "number": "6",
  "title": "WeBWorK",
  "body": " WeBWorK  These exercises demonstrate some WeBWorK features.    Answer Type Variety  WeBWorK answer types   This problem demonstrates that WeBWorK can process many kinds of answers.     Consider the function defined by    The exact value of is and a decimal approximation for this is .    The domain of this function, in interval notation, is .    The graph of intersects the graph of at .     .    The formula for including its restricted domain, is .    is a   power    exponential    linear    quadratic   function.    Which is true of the word radical ?    It shares ancestry with \"radius\", as in the radius of a circle.    It shares ancestry with \"radish\", a vegetable.    It shares ancestry with \"radler\", a mixture of beer and grapefruit soda.                                                     Special Feedback  WeBWorK custom feedback  WeBWorK hint  WeBWorK solution   Try multiplying the exponents to see what feedback you get. Also, try something no one should get credit for, like x^2*x^5 .     Simplify the expression   Add the exponents.        To simplify the product of two powers of the same base, add the exponents.          String Answers  WeBWorK string answers  WeBWorK algorithmic image   Spelling counts, but not capitalization or spaces.     This Venn Diagram groups animals by certain characteristics.    Name an animal that belongs in the center region. Spelling counts!              Open Problem Library  WeBWorK Open Problem Library    WeBWorK has an Open Problem Library with over 40,000 exercises. One of them is this exercise, with file path Library\/PCC\/BasicAlgebra\/NumberBasics\/FactorInteger10.pg .     Find the prime factorization of .         After checking to see if small prime numbers divide , we find that is one divisor. So .  Since both and are prime, the prime factorization of is .         Structured with Tasks  WeBWorK tasks  WeBWorK flexible answer syntax    This problem has multiple parts that must be completed in order. Try answering the second part with various things you might expect a user to enter.   Identify Coefficients  Consider the equation   Identify the coefficients for the quadratic equation using the standard form from Subsection 1.1.   ,  ,   Take the coefficient of for the value of the coefficient of for and the constant for  In this case , they are     Use the Quadratic Formula  Use the quadratic formula to find the solution set to   Recall that the quadratic formula is given in Subsection 1.1.  You already identified  and and the results from using these in the quadratic formula are and         Units in Answers  WeBWorK unit answers   The answers in this exercise require that units be used.       The average cost of gasoline in the United States in 2010 was $2.78 per gallon. How much gasoline would $20 get you in 2010, on average?    In 2011, the average cost was $3.52 per gallon. What percent increase was that from 2010?    In 2012, the cost had risen 2.8% from the 2011 cost. What was the cost of a gallon of gasoline in 2012?                         "
},
{
  "id": "webwork-3",
  "level": "2",
  "url": "webwork.html#webwork-3",
  "type": "Checkpoint",
  "number": "6.1",
  "title": "Answer Type Variety.",
  "body": " Answer Type Variety  WeBWorK answer types   This problem demonstrates that WeBWorK can process many kinds of answers.     Consider the function defined by    The exact value of is and a decimal approximation for this is .    The domain of this function, in interval notation, is .    The graph of intersects the graph of at .     .    The formula for including its restricted domain, is .    is a   power    exponential    linear    quadratic   function.    Which is true of the word radical ?    It shares ancestry with \"radius\", as in the radius of a circle.    It shares ancestry with \"radish\", a vegetable.    It shares ancestry with \"radler\", a mixture of beer and grapefruit soda.                                                   "
},
{
  "id": "webwork-4",
  "level": "2",
  "url": "webwork.html#webwork-4",
  "type": "Checkpoint",
  "number": "6.2",
  "title": "Special Feedback.",
  "body": " Special Feedback  WeBWorK custom feedback  WeBWorK hint  WeBWorK solution   Try multiplying the exponents to see what feedback you get. Also, try something no one should get credit for, like x^2*x^5 .     Simplify the expression   Add the exponents.        To simplify the product of two powers of the same base, add the exponents.        "
},
{
  "id": "webwork-5",
  "level": "2",
  "url": "webwork.html#webwork-5",
  "type": "Checkpoint",
  "number": "6.3",
  "title": "String Answers.",
  "body": " String Answers  WeBWorK string answers  WeBWorK algorithmic image   Spelling counts, but not capitalization or spaces.     This Venn Diagram groups animals by certain characteristics.    Name an animal that belongs in the center region. Spelling counts!            "
},
{
  "id": "webwork-6",
  "level": "2",
  "url": "webwork.html#webwork-6",
  "type": "Checkpoint",
  "number": "6.4",
  "title": "Open Problem Library.",
  "body": " Open Problem Library  WeBWorK Open Problem Library    WeBWorK has an Open Problem Library with over 40,000 exercises. One of them is this exercise, with file path Library\/PCC\/BasicAlgebra\/NumberBasics\/FactorInteger10.pg .     Find the prime factorization of .         After checking to see if small prime numbers divide , we find that is one divisor. So .  Since both and are prime, the prime factorization of is .       "
},
{
  "id": "webwork-7",
  "level": "2",
  "url": "webwork.html#webwork-7",
  "type": "Checkpoint",
  "number": "6.5",
  "title": "Structured with Tasks.",
  "body": " Structured with Tasks  WeBWorK tasks  WeBWorK flexible answer syntax    This problem has multiple parts that must be completed in order. Try answering the second part with various things you might expect a user to enter.   Identify Coefficients  Consider the equation   Identify the coefficients for the quadratic equation using the standard form from Subsection 1.1.   ,  ,   Take the coefficient of for the value of the coefficient of for and the constant for  In this case , they are     Use the Quadratic Formula  Use the quadratic formula to find the solution set to   Recall that the quadratic formula is given in Subsection 1.1.  You already identified  and and the results from using these in the quadratic formula are and       "
},
{
  "id": "webwork-8",
  "level": "2",
  "url": "webwork.html#webwork-8",
  "type": "Checkpoint",
  "number": "6.6",
  "title": "Units in Answers.",
  "body": " Units in Answers  WeBWorK unit answers   The answers in this exercise require that units be used.       The average cost of gasoline in the United States in 2010 was $2.78 per gallon. How much gasoline would $20 get you in 2010, on average?    In 2011, the average cost was $3.52 per gallon. What percent increase was that from 2010?    In 2012, the cost had risen 2.8% from the 2011 cost. What was the cost of a gallon of gasoline in 2012?                        "
},
{
  "id": "pretext-showcase-9-1",
  "level": "1",
  "url": "pretext-showcase-9-1.html",
  "type": "Index",
  "number": "",
  "title": "Index",
  "body": " Index  Entries are alphabetized word-by-word, not letter-by-letter. Topics indexed are PreTeXt features, not any actual content.   "
},
{
  "id": "pretext-showcase-9-2",
  "level": "1",
  "url": "pretext-showcase-9-2.html",
  "type": "Colophon",
  "number": "",
  "title": "Colophon",
  "body": " This article was authored in, and produced with, PreTeXt . It is typeset with the Latin Modern font.  "
}
]

var ptx_lunr_idx = lunr(function () {
  this.ref('id')
  this.field('title')
  this.field('body')
  this.metadataWhitelist = ['position']

  ptx_lunr_docs.forEach(function (doc) {
    this.add(doc)
  }, this)
})
