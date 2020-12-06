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
One intersting challenging is debugging and profiling on new ohardware like GPUs amnd other ASYCs.
One very intersting area of modern advancement (especially after the recent news out of China and previous work at Google)
is developing debugging tools for quantum hardware.
Robert Rand has worked on QWIRE,
which is a very convient tool for developing these quantum circuits,
and also an interface for their use in a variety of othe programming languages.
We could easily imagine developers using QWIRE in C or Python as part of a large code base.
And, as with any code base we would need to be able to profile and debug any generation of quantum circuits.
It would be intersting to see if we could develop tools that integrate well into existing debuggers (like LLDB)
and profilers (like pprof),
which can simulate the exectuation of QWIRE cicruits (and importantly the cost of loading and reading from quantum hardware)
so that developers can start to use QWIRE in their work.
Trying to solve this puzzle of decoupling profilers and debuggers agnostic from source languages is one of the problems that I would seek to solve.

We have really powerful compilers that generate code, can we use them to generate code for modern networked hardware?
This Fall and last Summer I worked at Sandia National Laboratories where we primarily researched the use of the Chapel programming language for variouis linearalgebra challenges.
One of the areas that we focused on was taking a Matlab code and developing the necessary framework in Chapel 
so that someone who is familiar with MATLAB could easily convert some of their codes into Chapel.
The problem here was that even after being careful about trying to "hide" the multi-node aspects of our code,
we still were left with various artifacts of parallel code that would likely be fairly alien to MATLAB developers.
This sparked a question in my head about whether we could automatically update languages for new hardware.
If so, then we would be able to take a MATLAB (or say it's open source alternative, Octave) compiler,
and automatically update it to work on a multi-node system.
Similiar work has been done for other areas of the development tower such as for arbitrary operating systems.
Could we do something similiar for languages?
John Repppy has worked on the Manticore programming language:
making the Standard ML programming language useable on very parallel systems.
Could use the walth of research on this project,
particularlly using the fairly robust runtime system,
for automatically paralleizing other languages?
If so, then we would  gain to advantages from the decoupling:
first we would be abler to work on a general purpose runtime with a wider range of developer interest,
and second we would be able to update existing languages to a parallel environment. 

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
A simple first step to this research would be to do case study for one particular language:
learn what are the best techniques to do automated user testing for a new langauge, 
and to learn what problem areas we might explore further when developing tooling for creating domain specific languages.
Diderot, worked on in part by John Reppy, is one place we could start. 
This language is an epitome of what a domain specific language should do:
make it easy for users to write very complicated algorithms with very simple and beautiful code.
The direction of this project would be to design a suer study which would determine what problems users have with the language.
We would investigate both misunderstandings in semantics and syntax by developing automated system to aggregate this information.
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
Ravi Chugh's work at the University of Chicago is what has gotten me interested in this area of research.
One interesting challenge that often faces developers that considering using new languages such as DSLs is the cost of switching their current code bases.
What if we thought of the process of code rewriting as a process of direct manipulation?
Just like in normal direct manipulation we have two interfaces that are changing the same underlying semantics,
but in this case we have two languages that changing the same underlying semantics.
As we change between languages in our code base,
we may want to allow people to edit the code base in both the old an new language.
If we had a system that could convert between the two through their agreed upon underlying semantics,
it would be mucuh easier to go about solving this problem.
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
