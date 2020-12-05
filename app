Domain specific languages allow us to express problems in natural and convient ways. 
Using tools such as Bison, Antlr, or parser combinators, it is pretty easy to create one.
So, what prevents domain specific languages from catching on?
This is the question that I want to explore and answer in graduate school.
Graduate school is the right place to work on this problem because such a program allows for longer incentive cycles:
instead of having to get a product out by the end of the quarter, I can spend a while on a project,
and I can develop and try many answers to it, and gather even more questions.
Additionally, for this particular research focus,
it will greatly aid me to learn about problems from colleagues in a wide variety of focuses,
so that I might learn how DSLs might help them or the problems that they have with them.
Perhaps most importantly,
I will be able to learn from experts about how to do good engineering research and good user experience research.
In this personal statement I will outline four research lines that either try to find out why DSLs have trouble catching on,
or provide solutions to known problems that prevent DSLs from catching on.
Each paragraph has the same general theme:
we have these really powerful compilers that generate code, can we use them to generate other parts of the development cycle.
I will also provide notes on my previous experience to better illustrate where these ideas come from,
and how I am well suited to take them to completion.

We have really powerful compilers that generate code, can we use them to generate code profilers and debuggers?
When we write code we should care about (among other things) readability, performance, and robustness.
Domain specific languages already provide us (hopefully) with very nice readability.
But, often it can be hard to drag developers away from their shiny tools for C++ and Java into new languages.
And, it takes a good bit of engineering to create these tools for new languages.
To a first approximation, 
we can use our DSL compiler to attach tags to our generated code language (perhaps C),
and then use the standard C debug flag to generate tags into machine code,
do our debugging and then back through the C tags and then drag those back through the DSL tags.
This is more or less the approach that I took while helping profiling the Chapel programming language at Sandia National Labs in the scalable software systems lab.
We were trying to investigate the performance of a linear algebra code that was running on a large multi-node system,
I used a somewhat delicate system of tracing debug tags from generated assembler back through C to Chapel.
This allowed me to successfully investigate the memory bound of this system,
but it was a tedious effort,
and so a process I would like to automate.
Even after automating this process for arbitrary static languages,
there are still a couple of problems, 
such as when a DSL generates part of the program as some data (perhaps a full AST like in a Lisp) for the C code to then run over,
or when a runtime has built in network communication (like Chapel) and a global address space.
Emery Berger's Scalene project is an excelent example of a profiler written for a dynamic language: Python.
It has made making performant Python exceptionally easy,
but I wish I could use this same tool in other dynamic languages (JavaScript and Scheme).
An interesting place to start research at UMass-Amherst would be to take Scalene and figure out how to decouple it enough from Python
in order to be able to plug and play any other dynamic language.
Not only will this be useful for existing imperitive dynamic languages,
but for potential domain specific langauges or general purpose langaugese that are yet to come.
Trying to solve this puzzle of decoupling profilers and debuggers agnostic from source languages is one of the problems that I would seek to solve.

We have really powerful compilers that generate code, can we use them to generate static analyzers and program synthesizers?
Static analyzers are powerful, and getting more so;
this is especially the case when we can use them to start synthesizing parts of our program:
perhaps trying to super-optimize that kernel at the core of your program,
or to automatically that tree operation that you don't want to mess up.
It would be really great if we could simply import some static analysis/synthesis into our language.
Take importing a type checker as an example,
it is not infeasable to simply build a typing datastructure and check unification.
But it does not seem obvious what is the best way to map type unification failures back to source for an arbitrary language,
and what if we want to do type-based-synthesis: can we use the parser definition to power that synthesis?
This process of converting the semantics of the system back into syntax is in-part what Tiago Ferreira, Loris D'Antoni, Alexandra Silva, and I are experimenting with in a current research project at Wisconsin.
Using a sketch (a description in a DSL with some parts missing) of a network protocol and a database of examples,
we are synthesizing an actual implementation as logical formula of that protocol consistent with the examples given,
and then converting that formula back into the DSL for representing network protocols.
While it was a pretty mechanical process to implement this conversion,
it did take a couple of days, 
and it would be great if we could do this sort of thing in a more general manner.
Developers in a wide range of langauges often need to run iterations over large datasets.
They often know roughly what the asymtotic time complexity is of the algorithm that they are trying to achieve,
and they can write a formula stating the decision problem(s) they are trying to answer in the algorithm.
Neil Immerman, and others, have already explored such algorithms applied to synthesizing graph classifiers.
A nice feature of the work is that once a foruma is generated for the classifier it is already pretty easy to convert the formula to a wide range of languages.
One interesting place to extend this simple inductive synthesis model to is multi-decision problems:
can we create a tool that could use this model for specifications with integer solutions,
what about specifications with variable model size?
If we can, then we could create a tool that any user could plug and play into their language for ready synthesis.
There are a lot of interesting questions about how to best tie a type checker to the source code,
and even more interesting questions about other types of static analysis (can we do plug and play race-condition analysis?).
Surely, this will provide interesting paths for future research.
Trying  to solve this puzzle of making synthesizers and analyzers agnostic to language is one of the problems that I would seek to solve.

We have really powerful compilers that generate code, can we use them to figure out what problems users have with new DSLs?
An important part of any user facing design process (which languages are obviously), is testing with real live users.
What if we had a system that could automatically log where users had problems with our languages.
If a user has trouble understanding some feature of a type system,
how the import system works,
which standard library function to use,
or even just the syntax of our language,
it would be great to be able to record that information in a way useful for later analysis.
I worked on something similar for my senior thesis under the advisement of Aws Albarghouthi.
I created a library that could do function lookup when trying to find code you need based on type in $log(n)$ time (this is a novel speedup as far as I know),
and it could be used for any language with types though I only implemented it for Go.
This required a very careful reading of the Go type system,
and being very diligent in getting Go's duck types working right.
It would be great if we could just feed any language to my system and automatically generate the type looker-upper,
so that we would not have had to take all that careful time.
Also, this system was not weighted to functions most commonly used.
Yuriy Brun's work on repairihng code with semantic code search is of paritcular interst here.
SearchRepair uses semantic rather than syntactic symallarity to find bug fixes.
As of the 2015 paper, it seems that the tool is pretty tightly coupled to C and to only certain semantic constructs in C.
What if we could provide a similiar tool to SearchRepair, but one that could find repairs in other languages and convert them to our language of interest.
This could help solve a particularly common language with DSLs.
DSLs are hard to fix because they are not widely seen on GitHub or StackOverflow.
If we could extend SearchRepair to work in a cross langauge manner it would allow us to use fixes from other programming langauges in our new ones.
A simple first step would be to just record where users pass-in syntactically incorrect programs:
recording the rule in our compiler that could not find a parse,
perhaps indicating a friction in documentation or just in the language design itself.
Languages like Rust have useful helpers for understanding that language's linear type system,
perhaps with the previous simple first step we could provide helpers for type systems for arbitrary languages as well.
This will help provide further areas of research, 
as it will help language designers understand why users are having trouble with their DSL.

We have really powerful compilers that generate code, can we use them to generate direct-manipulation systems for our DSLs?
Direct-manipulation allows us to combine the precision of text source code,
with other systems drawing upon programmer intuitions of what they think the result should be.
Examples of these systems include integrating a drawing environment with a coding environment
such that when a user makes changes to the drawing it updates the code,
and when a user makes changes to the code it makes changes to the drawing.
The trick for these systems is to be able to convert semantics (say the final drawing) back into syntax (the code for that drawing, or the drawing environment).
Which would mean that to do this generally,
we would need a way to automatically reverse a given parser:
converting semantics back into syntax.
I do not know how to start on this project,
so it would definitely require a good deal of thinking and talking,
but I'm curious to see how it'd go.
This is probably the most difficult challenge, 
but one could imagine using this to help fix tricky synchronization mechanisms by changing what the state should be at some time,
or changing a query in a custom database DSL such that it gives a result that the user is expecting.
This line of research would allow us to expore new methods of development than justy are traditional source based systems.

My goal is to make domain specific languages more widely used.
There are a lot of success stories in research of DSLs  allowing users to write readable, performant, and robust code.
In short, they help reduce the turn around time of programmer idea to programmer solution.
But for users to feel comfortable using them on a daily basis they need a complete environment,
and being able to automatically create this environment is what I hope to do at graduate school.
I do not believe that I want to be a professor,
but I want to work in a research team in a larger company trying to develop DSLs that help developers in those companies
write readable, performant, and robust systems.
