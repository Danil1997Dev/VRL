module MEM_SIGNAL_ROM#
	(
	parameter SIZE=13,
	parameter R=8,
	parameter m=$clog2(SIZE)
	)
	(input  C,In,Reset,
	output logic signed [R-1:0] Y
	);
	bit r,e;
	logic [m-1:0] count;
	reg [R-1:0] a [SIZE-1:0];
	reg [R-1:0] b [SIZE-1:0];
	initial
		begin
			$readmemb("PI_Q.txt", a,0,SIZE-1);
			$readmemb("NI_Q.txt", b,0,SIZE-1);
		end
	COUNT #( .WIDTH(m) ) cnt ( .clk(C),.reset(Reset),.enable(!Reset),.count(count));
	always @(posedge C)
		begin
			if (Reset==1) 
					begin
					end 
			else 
					begin
						if (count==SIZE-1) 
							begin
								if(In==1) 
									begin
										Y[R-1:0]<=a[count];
									end 
								else 
									begin
										Y[R-1:0]<=b[count]; 
									end
								r<=1;
							end
						else 
							begin
								if(In==1) 
									begin
										Y[R-1:0]<=a[count];
									end
								else 
									begin
										Y[R-1:0]<=b[count];
									end
				end
					end
		end
endmodule 
