/**********************************************************************************
Theaia, Ray Cast Programable graphic Processing Unit.
Copyright (C) 2009  Diego Valverde (diego.valverde.g@gmail.com)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

***********************************************************************************/


//Verilog provides a `default_nettype none compiler directive.  When
//this directive is set, implicit data types are disabled, which will make any
//undeclared signal name a syntax error.This is very usefull to avoid annoying
//automatic 1 bit long wire declaration where you don't want them to be!
`default_nettype none

//The clock cycle
`define CLOCK_CYCLE  5
`define CLOCK_PERIOD 10


//The next section defines the length of the registers, buses and other structures, 
//do not change this valued unless you really know what you are doing (seriously!)
`define WIDTH        8
`define LONG_WIDTH   16




