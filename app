Domain specific languages allow us to easily express problems in certain areas in the right way.
Though they might make it harder to solve some problems, they allow us to optimize for a particular class of problems at hand.
Using tools such as Bison, Antlr, or parser combinators, it is pretty easy to spin up your own language.
So, we are left with the question, what prevents domain specific languages from catching on?
This is the question that I want to answer and engineers solutions to in graduate school.
Graduate school is the right place for me to work on this problem because such a program allows
for longer incentive cycles:
instead of having to get a product out by the end of the quarter, I can spend a while on a project,
and I can develop and try many answers to it, and even more questions.
Additionally, for this particular research focus,
it will greatly aid me to listen to the kinds of problems that my colleagues in a wide variety of focuses are working on.
Perhaps most importantly,
I will be able to learn from experts about how to solve practical problems in my research,
and perhaps I would be of some help back.
In this personal statement I will outline four research lines that either try to find out why DSLs have trouble catching on,
or provide solutions to known problems with DSLs catching on.
They all have a general theme:
we have these really powerful compilers that generate code, can we use them to generate other parts of the development cycle.
I will also provide notes on my previous experience to better illustrate where these ideas come from,
and how I am well suited to take them to completion.

We have really powerful compilers that generate code, can we use them to generate code profilers and debuggers?
When we right code we should care about (among other things) readability, performance, and robustness.
Domain specific languages already provide us (hopefully) with very nice readability.
But, often it can be hard to drag developers away from their shiny tools for C++ and Java.
So, to solve that problem, how about we automatically create code profilers and debuggers from the compiler?
To a first approximation, 
we can use our DSL compiler to attach tags to our generated code language (perhaps C),
and then use the standard C debug flag to generate tags into machine code,
do our debugging and then back through the C tags and then drag those back through the DSL tags.
This is more or less the approach that I took while helping profiling Chapel at Sandia National Labs in the scalable software systems lab.
We were trying to investigate the performance of a linear algebra code that was running on a large multi-node system,
I used a somewhat delicate system of tracing debug tags from generated assembler back through C to Chapel.
This allowed me to successfully investigate the memory bound of this system,
but it was a tedious effort,
and so a process I would like to automate.
Even after automating this process for arbitrary languages,
there are still a couple of problems, 
such as when a DSL generates part of the program as some data (perhaps a full AST like in a Lisp) for the C code to then run over,
or when a runtime has built in network communication (like Chapel) and global address space.
Perhaps we can do some tracking of loads from the data section for tagging?
I'm not sure, but this leaves open interesting questions that I think would be useful to pursue further.

We have really powerful compilers that generate code, can we use them to generate static analyzers?
Static analyzers are powerful, and getting more still;
this is especially the case when we can use them to start synthesizing parts of our program:
perhaps trying to super-optimize that kernel at the core of your program,
or to generate that tree operation that you don't want to mess up.
It would be really great if we could simply import some static analysis/synthesis into our language.
Take importing a type checker as an example,
we can think of a system where we just have a database of unification statements as a C library,
and as we parse code we add the proper information into that database for later checking.
But it does not seem obvious what is the best way to map type unification failures back to source in for an arbitrary language,
and what if we want to do type-based-synthesis: can we use the parser definition to power that synthesis?
This process of converting the semantics of the system back into syntax is in-part what Tiago Fierrari, Loris D'Antoni, Alexandra Silva, and I are experimenting with in a current research project at Wisconsin. 
Using a sketch (a description in a DSL with some parts missing) of a network protocol and a database of examples,
we are synthesizing an actual implemention of that protocol consistent with the examples given.
While it was a pretty straightforward process to implement this conversion,
it did take a couple of days, 
and it would be great if we could do this sort of thing in a more generall manner.
There are a lot of interesting questions about how to best tie a type checker to the source code,
and even more interesting questions about other types of static analysis (can we do plug and play race-condition analysis?).
Surely, this will provide interesting paths for future research.

We have really powerful compilers that generate code, can we use them to figure out what problems users have with our languages?
An important part to any user facing design process (which languages are obviously), is testing with real live users.
What if we had a system that could automatically log where users had problems with our languages.
If a user has trouble understanding some feature of a type system,
how the import system works,
or even just the syntax of our language,
it would be great to be able to record that information in a way useful for later analysis.
I worked on something similar for my senior thesis under the advisement of Aws Albarghouthi.
I created a library that could do function lookup when trying to find code you need based on type in $log(n)$ time (this is novel as far as I know),
and it could be used for any language with types though I only implemented it for Go.
This required a very careful reading of the Go type system,
and being very diligent in getting Go's duct types working right.
It would be great if we could just feed any language to my system and automatically generate the type looker-upper,
so that we would not have had to take all that careful time.
A simple first step would be to just record where users pass in syntactically incorrect programs:
recording the rule in our compiler that could not find a parse,
perhaps indicating a friction in documentation or just in the language design itself.
Languages like Rust have pretty useful helpers for understanding thatt language's linear type system,
perhaps with the previous simple first step we could provide helpers for type systems for arbitrary languages as well.
This will help provide further areas of research, 
as it will help language designers understand why users are having trouble with their language.

We have really powerful compilers that generate code, can we use them to generate direct-manipulation systems for our languages?
Direct-manipulation allows us to combine the precision of text source code,
with other systems drawing upon programmer intuitions of what they think the result should be.
Examples of these systems include automatically generating vector graphics code from a users' drawing,
and changing parts of a users code to meet their desired values for particular variables.
The trick for these systems is to be able to convert semantics back into syntax,
which would mean that to do this generally,
we would need a way to automatically reverse any given parser.
I do not know how to start on this project,
so it would definitely require a good deal of thinking and talking,
but I'm curious to see how it'd go.
This is probably the most difficult challenge, 
but one could imagine using this to help fix tricky synchronization mechanisms by changing what the state should be at some time,
or changing a query in a custom database DSL such that it gives a result that the user is expecting.
But, I think that it allows us to explore other areas in which non-general purpose languages could be useful.

My goal is to make domain specific languages more widely used.
There are a lot of success stories in research of DSLs  allowing users to write readable, performant, and robust code.
In short they help reduce the turn around time of programmer idea to programmer solution.
But, they can often get mired in generating the necessary acoutramont that allows developers to use such languages on a daily basis.
I am not sure what is the best way to make DSLs widely used,
but that is what I in part hope to answer.
Through my research at UNIVERSITY, I would determine whether it is better to continue in academia or proselytize DSLs in industry.
Either way, general purpose languages must be slightly substituted by DSLs in particular contexts.
