`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Roberto Chaves
// 
// Create Date:    16:05:30 08/05/2015 
// Design Name: 		State Machine with 7segment.
// Module Name:    Control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control(clk,reset,estado,AN,CN);
//////SE INICIAN LAS VARIABLES DE ENTRADA Y SALIDA///////
parameter p=8;
input clk,reset;
input [5:0] estado;
output [3:0] AN;
output [6:0]CN;
reg [1:0] cuenta;
reg [3:0] A=4'd1;
reg [6:0] C=6'd1;
wire clk;


/////////Contador de dos bits///////
	always @ (posedge clk or posedge reset)
		if (reset) cuenta <= 0;
		else cuenta <= cuenta+1;
/////////DECODIFICADOR DE LA MAQUINA DE ESTADOS A LO NECESITADO/////////////
	always @(posedge clk)
	
	case (estado)	
		6'b000001:if (cuenta==00) C= 7'b0000010;
				else if (cuenta==01) C= 7'b1000000;
				else if (cuenta==10) C= 7'b1000000;
				else C=7'b0100001; 
		6'b000010:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b010000:if (cuenta==00) C= 7'b0001110;
				else if (cuenta==01) C= 7'b0000110;
				else if (cuenta==10) C= 7'b1;
				else C=7'b1111111;
		6'b000100:if (cuenta==00) C= 7'b0001001;
				else if (cuenta==01) C= 7'b0001011;
				else if (cuenta==10) C= 7'b0101011;
				else C=7'b1111111;
		6'b001000:if (cuenta==00) C= 7'b0000010;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0010010;
				else C=7'b1111111;
		6'b100000:if (cuenta==00) C= 7'b1;
				else if (cuenta==01) C= 7'b1000000;
				else if (cuenta==10) C= 7'b0001110;
				else C=7'b0001110;
		6'b011000:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b010100:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b010010:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b001100:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b001010:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b011100:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		6'b011010:if (cuenta==00) C= 7'b0000011;
				else if (cuenta==01) C= 7'b0001000;
				else if (cuenta==10) C= 7'b0100001;
				else C=7'b1111111;
		default C=7'b1111111;
		endcase
		
///////////////posicion del caracter////////////////

	always @(posedge clk)
		case (cuenta)
			2'd0: A= 4'b0111;
			2'd1: A= 4'b1011;
			2'd2:A= 4'b1101;
			default A=4'b1110;
	endcase
	
	assign AN=A;
	assign CN=C;


endmodule
