module lab9(input logic [2:0] instin, 
						input logic [5:0] ain,bin,
						input logic clock, enin, sw, rstin,
					output logic [2:0] inst,
					output logic [6:0] dispA1, dispA2, dispB1, dispB2, dispZ1, dispZ2,
					output logic overFlow, aNeg, bNeg, zNeg);
	logic [5:0] z, a,b;
	aluControl alu(.instin(instin),
					.ain(ain),.bin(bin),
					.clock(clock), .enin(enin), .sw(sw), .rstin(rstin),
					.z(z), .a(a), .b(b),
					.inst(inst),.overFlow(overFlow));
	dualDisp dispA(.inputValue(a), .disp1(dispA1), .disp2(dispA2));
	dualDisp dispB(.inputValue(b), .disp1(dispB1), .disp2(dispB2));	
	dualDisp dispZ(.inputValue(z), .disp1(dispZ1), .disp2(dispZ2));	
always_comb begin
	aNeg<=a[5];
	bNeg<=b[5];
	zNeg<=z[5];	
end
endmodule