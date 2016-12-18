# INF2100 UiO (Autumn 2100)

Project for the INF2100 course at the University of Oslo (UiO). The assignment 
is to build a compiler for the Pascal2016 language (a "made-up" programming 
language that is a subset of the real Pascal language). The implementation 
language is Java. The entire progject is divided into 4 parts:
- Part 1: Build a scanner that creates a stream of tokens from the source file.
- Part 2: Build a parser which creates a syntax tree using object oriented programming style.
- Part 2: Build a checker which performs type checking and makes sure that the source code clearly follows the language grammars.
- Part 4: Build the code generator which generates Assembler code based on the abstract syntax tree.

To build the project from source, Apache Ant is required. The build process will
generate a `.jar` file. In the terminal, simply go to the `src` directory and type:
	
```bash
ant       # to build
ant clean # to clean the build
ant zip   # to zip the src directory
```

To test the



To run the compiler to compile a source file:
