module SH
#(parameter SIZE=80,D=4,Br=2,T=SIZE/(2*Br*D))
(
	input C, E,
	output logic  En0,En1,En2,En3,
	output logic [T*D-1:0] SH
);

	// Declare the shift register
	reg [T*D-1:0] sh;

	// Shift everything over, load the incoming bit
	always @ (posedge C)
	begin
		if (E == 1'b1)
		begin
			sh[T*D-1:1] <= sh[T*D-2:0];
			sh[0] <= 1'b1;
			En0 = sh[0];
			En1 = sh[T*D/4];
			En2 = sh[T*D/2];
			En3 = sh[3*T*D/4];
		end
		else
		begin
			sh = 0;
			En0  = 0;
			En1  = 0;
			En2  = 0;
			En3  = 0;
		end
	end
assign SH=sh;
	// Catch the outgoing bit
endmodule
