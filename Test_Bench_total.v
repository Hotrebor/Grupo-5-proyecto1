`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:Roberto Chaves García
//				Johnny Barboza Fallas				
//
// Create Date:   00:59:52 08/11/2015
// Design Name:   Unidad_Circuito
// Module Name:   C:/Users/ROBERTO/Dropbox/Universidad/II semestre 2015/Lab de digitales/Proyectos/Proyecto_1/Test_bench_total.v
// Project Name:  Proyecto_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Unidad_Circuito
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_bench_total;

	// Inputs
	reg clk1;
	reg reset;
	reg humoa;
	reg glp;
	reg humom;
	reg fe;
	reg apagsis;

	// Outputs
	wire [5:0]registro_salidas;
	wire [3:0] AN;
	wire [6:0] CN;

	// Instantiate the Unit Under Test (UUT)
	Unidad_Circuito uut (
		.clk1(clk1), 
		.reset(reset), 
		.humoa(humoa), 
		.glp(glp), 
		.humom(humom), 
		.fe(fe), 
		.apagsis(apagsis), 
		.registro_salidas(registro_salidas), 
		.AN(AN), 
		.CN(CN)
	);

	initial begin
		// Initialize Inputs
		clk1 = 0;
		reset = 0;
		humoa = 0;
		glp = 0;
		humom = 0;
		fe = 0;
		apagsis = 0;

	forever
		#5 
		clk1=~clk1;
	end
	initial begin
		#5000000
			reset = 1;
			humoa = 0;
			glp = 0;
			humom = 0;
			fe = 0;
			apagsis = 0;
		#50000000
			reset = 0;
			humoa = 1;
			glp = 0;
			humom = 0;
			fe = 0;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 0;
			humom = 0;
			fe = 0;
			apagsis = 1;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 1;
			humom = 0;
			fe = 0;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 0;
			humom = 1;
			fe = 0;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 0;
			humom = 0;
			fe = 1;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 1;
			glp = 1;
			humom = 0;
			fe = 0;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 1;
			glp = 0;
			humom = 0;
			fe = 1;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 0;
			humom = 1;
			fe = 1;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 1;
			humom = 1;
			fe = 0;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 1;
			humom = 0;
			fe = 1;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 0;
			glp = 1;
			humom = 1;
			fe = 1;
			apagsis = 0;
		#5000000
			reset = 0;
			humoa = 1;
			glp = 1;
			humom = 0;
			fe = 1;
			apagsis = 0;
		#5000000
			$stop;
		end
      
endmodule
