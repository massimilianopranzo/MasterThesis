(* ::Package:: *)

BeginPackage["MyFunctions`"];


LinSpace::usage = "LinSpace[s,f,n] creates a list of n linearly distributed points from s to f included.";


Trapz::usage = "Trapz[x,y,n] gives the approximated area of y using the trapezoidal rule of integration.";


CumTrapz::usage = "CumTrapz[x,y,n] gives a list of the same length of x containing the cumulative approximate areas up to each element of x, using the trapezoidal rule of integration.";


MidArrow::usage = "MidArrow[dir] draws an arrowhead in the middle of a curve. Use it as graphicsobj/.MidArrow[dir].";


Begin["`Private`"];


LinSpace[s_,f_,n_]:=Range[s,f,(f-s)/(n-1)]


Trapz[x_,y_]:=Total@Table[{((y[[i]]+y[[i+1]])Abs@(x[[i+1]]-x[[i]]))/2},{i,1,Length@x-1}]//Flatten


CumTrapz[x_,y_]:=Module[{areas,cumarea},areas=Table[{((y[[i]]+y[[i+1]])Abs@(x[[i+1]]-x[[i]]))/2},{i,1,Length@x-1}];cumarea=0;Table[cumarea=cumarea+areas[[i]],{i,1,Length@areas}]]//Flatten


MidArrow[dir_]:=Line[x_]:>{Arrowheads[{{dir 0.05,0.5}}],Arrow[x]}


End[];


EndPackage[];
