module memory(input logic [14:0] data, 
					input logic [3:0] w_addr, r_addr, 
					input logic wen, ren, clock,
					output logic [14:0] q);
					
logic [14:0] mem [7:0]; //init memory
initial begin
	for (int i=0; i<8;i++) begin
		mem[i]= i[14:0];
	end
end
always_ff @(posedge clock)
	begin
	if (wen)
		mem[w_addr] <= data;//write
	if (ren)
		q <= mem[r_addr];//read
	end
endmodule