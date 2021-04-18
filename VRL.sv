module VRL#//Имя головного файла
(
parameter R=7,
parameter Br=1,
parameter N=8,
parameter f0=10,
parameter NBAR=2,
parameter SIZEIQ=SIZE/Br,
parameter f=f0/Br,
parameter SIZE=N*Br*f,
parameter Ft=SIZE,
parameter SIZE1=SIZE/3'd2,
parameter R1=$clog2((SIZE1-N)*NBAR),
parameter Rint_i=(4*R+1),
parameter Rint_o=(4*R+1)+R1,
parameter D=4 
) 
(
input Reset_l,C,I,Q,
output [2*R-1:0] SO,
input [0:3] s_of_bar,
output [Rint_i-1:0] V0,V1,V2,V3
);
wire [R-1:0]si;
wire [R-1:0]c;
wire [R-1:0]i;
wire q;
wire [R-1:0]qo;
wire [2*R-1:0] s;
wire [2*R-1:0] s1;
wire [D-1:0] en;
logic [0:3][(4*R)-1:0]  IQR ;
logic [0:3][R-1:0]  IQ ;
logic [0:3] [Rint_o-1:0] chn;
logic signed [0:3] [(4*R+1)-1:0]  crlb ;
OQPSK_MOD #(.SIZE(SIZE),.R(R),.N(N),.f(f),.f0(f0),.Br(Br)) inst0(.C(C),.I(I),.Q(Q),.S(s),.Reset(~Reset_l));//Модуль формирования модулирующего сигнала I
SH #(.SIZE(SIZE),.Br(Br),.D(D)) inst1(.C(C),.E(Reset_l),.En0(en[0]),.En1(en[1]),.En2(en[2]),.En3(en[3]));
SHIFT_S #(.R(R),.W(159) ) inst3 (.*,.S(s),.S_SH(s1));
OQPSK_RSCH #(.SIZE(SIZE),.SIZE1(SIZE1),.R( R),.Rint_i(Rint_i),.Rint_o(Rint_o),.N(N),.f(f),.f0(f0),.Br(Br)) inst2 ( .S(s1[2*R-1:0]) ,.Reset_l(Reset_l),.Clk(C),.IOut(I_O),.QOut(Q_O),.chn(chn ),.crlb(crlb));
assign V0=crlb[0];
assign V1=crlb[1];
assign V2=crlb[2];
assign V3=crlb[3];
assign F0=chn[0];
assign F1=chn[1];
assign F2=chn[2];
assign F3=chn[3];
assign SO=s1;
endmodule 


