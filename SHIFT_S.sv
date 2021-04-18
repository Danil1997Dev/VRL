module SHIFT_S#(parameter W=8,R=4)(
input Reset_l,C,
input  signed [2*R-1:0] S,
output [2*R-1:0] S_SH
);
integer i;
	reg [2*R-1:0] L [W-1:0];
	always @ (negedge C)
	begin
		if (Reset_l == 1'b1)
		L[0]<=S;
		L[W-1:1] <= L[W-2:0];
			S_SH <= L[W-1];
	end


endmodule
