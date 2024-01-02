(* ::Package:: *)

BeginPackage["MyFunctions`"];


LinSpace::usage = "LinSpace[s,f,n] creates a list of n linearly distributed points from s to f included.";


Trapz::usage = "Trapz[x,y,n] gives the approximated area of y using the trapezoidal rule of integration.";


CumTrapz::usage = "CumTrapz[x,y,n] gives a list of the same length of x containing the cumulative approximate areas up to each element of x, using the trapezoidal rule of integration.";


MidArrow::usage = "MidArrow[dir] draws an arrowhead in the middle of a curve. Use it as graphicsobj/.MidArrow[dir].";


GetVars::usage = "GetVars[expr] returns all the variables inside expr"


ScientString::usage = "ScientString[n,dig] returns the number n in sicentific form with dig digits"


DefColors::usage = "DefColors[n] retrieves the default color indexed by n"


Begin["`Private`"];


LinSpace[s_,f_,n_]:=Range[s,f,(f-s)/(n-1)]


Trapz[x_,y_]:=Total@Table[{((y[[i]]+y[[i+1]])Abs@(x[[i+1]]-x[[i]]))/2},{i,1,Length@x-1}]//Flatten


CumTrapz[x_,y_]:=Module[{areas,cumarea},areas=Table[{((y[[i]]+y[[i+1]])Abs@(x[[i+1]]-x[[i]]))/2},{i,1,Length@x-1}];cumarea=0;Table[cumarea=cumarea+areas[[i]],{i,1,Length@areas}]]//Flatten


MidArrow[dir_]:=Line[x_]:>{Arrowheads[{{dir 0.05,0.5}}],Arrow[x]}


GetVars[expr_]:=Union@Cases[expr,s_Symbol/;Not@NumericQ[s],{-1}]


ScientString[n_,dig_]:=ToString[ScientificForm[n,dig],TraditionalForm]


DefColors[n_]:=ColorData[97,"ColorList"][[n]]


End[];


EndPackage[];
