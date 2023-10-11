`timescale 1ns/1ns
module aluTB();
logic [2:0] instin,inst;
logic [5:0] ain, bin, z, a, b;
logic overFlow, enin, sw;
logic rstin=1'b1;
logic clock =1'b0;
logic [2:0] temp_inst;
logic [5:0] temp_a, temp_b;
logic [6:0] dispA1, dispA2, dispB1, dispB2, dispZ1, dispZ2;
logic aNeg, bNeg, zNeg;
`include "instTasks.sv";
task randTask();
for(int i = 0; i<10; i++) begin
	$display("New Task (%d) ---------------------------------", i);
	temp_inst<=$urandom_range(3'b111,3'b000);
	temp_a<=$urandom_range(63,0);
	temp_b<=$urandom_range(63,0);
	#5
	instTask(temp_a, temp_b, temp_inst, 1'b1);
	#20
	instTask(temp_a, temp_b, temp_inst, 1'b0);
end
endtask
lab9 alu(.instin(instin), .ain(ain), .bin(bin),
					.enin(enin),.sw(sw), .rstin,.clock(clock),
					.inst(inst),
					.z(z), .a(a), .b(b),
					.dispA1(dispA1), .dispA2(dispA2), .dispB1(dispB1), .dispB2(dispB2), .dispZ1(dispZ1), .dispZ2(dispZ2),
					.overFlow(overFlow), .aNeg(aNeg), .bNeg(bNeg), .zNeg(zNeg));
//lab9 alu(.instin(instin), .ain(ain), .bin(bin), 
//					.z(z), .a(a), .b(b), .inst(inst), 
//					.overFlow(overFlow), .enin(enin), 
//					.sw(sw),.clock(clock));

	// Generate clock
	always #5 clock <= ~clock;

initial begin
	randTask();
end

endmodule