`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Instituto Tecnológico de Costa Rica
// Alumno: Johnny Barboza Fllas
// Profesor: Alfonso Chacon
// 
// Create Date:    14:48:16 08/09/2015 
// Design Name: Máquina de estados tipo Mealy
// Module Name:    Maquina  
// Description: Una máquina de estados, basada en la de tipo Mealy, en la cual se muestra el funcionamiento de 
// los estados en los que va avanzado y como va generando distintas salidas.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
module Maquina(clk, reset, humoa, glp, humom, fe, apagsis, registro_salidas, ledtb, ledprv, ext1, boc1, boc2, int_fe);
	input clk, reset, fe, glp, apagsis, humoa, humom;
	output registro_salidas, ledtb, ledprv, ext1, boc1, boc2, int_fe;
	reg [5:0] salidas, registro_salidas;
	reg ledtb, ledprv, ext1, boc1, boc2, int_fe;
	parameter [4:0] TB=4'h0, HA=4'h1, HM=4'h2, GLP1=4'h3, FE1=4'h4, AS1=4'h5, SalHA=4'h6, SalHM=4'h7, SalGLP=4'h8, SalFE=4'h9;
	reg [4:0] estado, sigestado;
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			begin
				estado <= TB;
				registro_salidas <= 6'b0;
			end
		else
			begin
				registro_salidas <= registro_salidas;
				estado <= sigestado;
				case (estado)					
					TB: if (~(fe|glp|humoa|humom)) registro_salidas <= salidas; else registro_salidas[0]<=0;
					HA: registro_salidas[1] <= salidas[1];
					HM: registro_salidas[2] <= salidas[2];
					GLP1: registro_salidas[3] <= salidas[3];
					FE1: registro_salidas[4] <= salidas[4];
					AS1: if (apagsis) registro_salidas <= salidas; else registro_salidas[5] <= 0;
				endcase
			end
	end
	always @*
		case (estado)
			TB: if (humoa|humom|fe|glp|apagsis) 
					sigestado = HA;
				else 
					sigestado = TB;
			HA: if (humoa)	
					sigestado = SalHA;
				else 
					sigestado = HM;
			SalHA: sigestado = GLP1;
			HM: if (humom) 
					sigestado = SalHM;
				else	
					sigestado = GLP1;
			SalHM: sigestado = GLP1;
			GLP1: if (glp)	
						sigestado = SalGLP;
				else	
					sigestado = FE1;
			SalGLP: sigestado = FE1;
			FE1: if (fe) 
						sigestado = SalFE;
				else	
					sigestado = AS1;
			SalFE: sigestado = AS1;
			AS1: if (apagsis)	
						sigestado = AS1;
				else 
					sigestado = TB;			
			default sigestado = TB;
		endcase
	always @*
	begin
	salidas = 6'h0;
		case(estado)
			TB: if (~(fe|glp|humoa|humom)) salidas = 6'h1; else salidas[0]=0;
			HA: salidas[1] = humoa;
			HM: salidas[2] = humom;
			GLP1: salidas[3] = glp;
			FE1: salidas[4] = fe;
			AS1: if (apagsis) salidas = 6'b100000; else salidas[5]=0; 
		endcase
	end
	always @*	
	begin
	ledtb=0;
	ledprv=0;
	ext1=0;
	boc1=0;
	boc2=0;
	int_fe=0;
		if (registro_salidas[5]==1) begin //Sistema apagado
			ledtb=0;
			ledprv=0;
			ext1=0;
			boc1=0;
			boc2=0;
			int_fe=0;
		end
		else if (registro_salidas[0]) begin //todo bien
			ledtb=1;
			ledprv=0;
			ext1=0;
			boc1=0;
			boc2=0;
			int_fe=0;
		end
		else if ((registro_salidas[1])|(registro_salidas[2]&registro_salidas[3]))
		//Si hay humo alto o combinación de humo medio con glp está mal el sistema
		begin
			ledtb=0;
			ledprv=0;
			ext1=1;
			boc1=0;
			boc2=1;
			int_fe=0;
		end
		else if ((registro_salidas[4]&registro_salidas[3])|(registro_salidas[4]&registro_salidas[2]))
		//Si hay falla eléctrica y glp o falla eléctrica y humo medio
		begin
			ledtb=0;
			ledprv=1;
			ext1=1;
			boc1=0;
			boc2=1;
			int_fe=1;
		end
		else if (registro_salidas[2]|registro_salidas[3]) begin //humo medio o glp
			ledtb=0;
			ledprv=1;
			ext1=1;
			boc1=1;
			boc2=0;
			int_fe=0;
		end
		else if (registro_salidas[4]) begin //falla eléctrica
			ledtb=0;
			ledprv=1;
			ext1=0;
			boc1=1;
			boc2=0;
			int_fe=1;
		end
	end
endmodule
