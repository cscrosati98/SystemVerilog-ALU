module controlFSM(input logic sw, en, clock, rst,
						output logic [3:0] w_add=4'd0, r_add=4'd0,
						output logic ren, wen, fifoFull, fifoEmpty);
	
	typedef enum logic [1:0] {IDLE, RD, WR} statetype;
	
	statetype presentState = IDLE, nextState;
	
	always_ff@(posedge clock or negedge rst)
	begin
		if(!rst) 
			presentState<=IDLE;
		else
			presentState<=nextState;
	end
	always_comb
		begin
			case(presentState)
			
			IDLE:
			
			if(sw==1'b0 && en==1'b1 &&fifoEmpty==1'b0)
				nextState<=RD;
			else if(sw==1'b1 && en==1'b1 &&fifoFull==1'b0)
				nextState<=WR;
			else
				nextState<=IDLE;
			
			RD://read state
			
			if(fifoEmpty==1'b0&&en==1'b1)
				nextState<=RD;
			else
				nextState<=IDLE;
			
			WR://write state
			
			if(fifoFull==1'b0&&en==1'b1)
				nextState<=WR;
			else
				nextState<=IDLE;
		endcase
	end
	assign fifoFull=(w_add[2:0]==r_add[2:0] && w_add[3]!=r_add[3]);//if wrap doesnt match, but rest does
	assign fifoEmpty=(w_add==r_add); //if entirely equal
	always_ff@(posedge clock or negedge rst)
	begin
		if(!rst) begin
			ren<=(presentState==RD);
			wen<=(presentState==WR);
			r_add=4'd0;
			w_add=4'd0;
		end else begin
			ren<=(presentState==RD);
			wen<=(presentState==WR);
			
			if(presentState==RD) begin
				r_add<=r_add+1'b1;
				end
			if(presentState==WR) begin
				w_add<=w_add+1'b1;
				end
		end
	end


endmodule