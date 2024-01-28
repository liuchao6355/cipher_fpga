////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : mux.v
// Description  : .
//
// Author       : hungnt@HW-NTHUNG
// Created On   : Thu Nov 08 10:51:52 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module mux
    (
     a,
     b,
     s,
     c
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations

parameter WIDTH = 1;

////////////////////////////////////////////////////////////////////////////////
// Port declarations

////////////////////////////////////////////////////////////////////////////////
// Output declarations

input     s;
input [WIDTH-1:0] a,b;

output [WIDTH-1:0] c;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

assign             c = s?b:a;

endmodule 