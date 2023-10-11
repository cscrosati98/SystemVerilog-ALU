module aluControl(input logic [2:0] instin, 
						input logic [5:0] ain,bin,
						input logic clock, enin, sw, rstin,
					output logic [5:0] z, a,b,
					output logic [2:0] inst,
					output logic overFlow);
		logic [5:0] addZ, subZ;
		logic addOF, subOF;
		logic en, ren, wen;
		logic [14:0] datain, dataout;
		logic fifoFull, fifoEmpty;
		logic [3:0] w_add, r_add;
		reset rs(.clk(clock), .rst(rstin),.rstSync(rst));
		//create submodule for addition
		addition addTop(.a(a),.b(b),.z(addZ),.overFlow(addOF));
		//create submodule for subtraction
		subtraction subTop(.a(a),.b(b),.z(subZ),.overFlow(subOF));
		//create submodule for sychronizing the enable
		synchronizer sync(.clock(clock), .fallEdge(en), .signal(enin), .rst(rst));
		//create a submodule for memory
		memory mem(.data(datain), 
					.wen(wen), .ren(ren),
					.r_addr(r_add), .w_addr(w_add),
					.clock(clock), .q(dataout));
					
		controlFSM fsm(.sw(sw), .en(en), .clock(clock), .rst(rst),
						.w_add(w_add), .r_add(r_add),
						.ren(ren), .wen(wen), 
						.fifoFull(fifoFull), .fifoEmpty(fifoEmpty));		
	
	always_comb
		begin
			//assign value for writing (memory)
			datain[11:6]<=ain;
			datain[5:0]<=bin;
			datain[14:12]<=instin;
		end
	always_comb
		begin
			//assign read value (display)
			a<=dataout[11:6];
			b<=dataout[5:0];
			inst<=dataout[14:12];
		end
	always_comb 
		begin
			case (inst)
				3'b000: begin
					z <= addZ;
					overFlow<=addOF;
				end
				
				3'b001: begin
					z <= subZ;
					overFlow<=subOF;
				end
				
				3'b100: begin
					if(a==b) begin
						z<=6'b000001;
						overFlow<=1'b0;
					end else begin
						z<=6'b000000;
						overFlow<=1'b0;
					end
				end
				
				3'b101: begin
					if(a>b) begin
						z<=6'b000001;
						overFlow<=1'b0;
					end else begin
						z<=6'b000000;
						overFlow<=1'b0;
					end
				end
				
				3'b110: begin
					if(a<b) begin
						z<=6'b000001;
						overFlow<=1'b0;
					end else begin
						z<=6'b000000;
						overFlow<=1'b0;
					end
				end
				
				3'b111: begin
					if(a==5'd0) begin
						z<=6'b000001;
						overFlow<=1'b0;
					end else begin
						z<=6'b000000;
						overFlow<=1'b0;
					end
				end
				
				default: begin
						z<=6'b000000;
						overFlow<=1'b0;
				end
				
			endcase
		end
endmodule