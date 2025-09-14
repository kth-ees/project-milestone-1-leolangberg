module alu #( BW = 16 ) (
	input  logic unsigned [BW-1:0] in_a,
	input  logic unsigned [BW-1:0] in_b,
	input  logic             [3:0] opcode,
	output logic unsigned [BW-1:0] out,
	output logic             [2:0] flags // {overflow, negative, zero}
);
	logic unsigned [BW-1:0] w;
	logic v, n, z, c; // carry never used...

	always_comb begin
		case(opcode)
			3'b000 : {c, w} = in_a + in_b;		// ADD
			3'b001 : {c, w} = in_a - in_b;		// SUB
			3'b010 : w = in_a & in_b;		// AND
			3'b011 : w = in_a | in_b;		// OR
			3'b100 : w = in_a ^ in_b;		// XOR
			3'b101 : {c, w} = in_a + 1;		// INC
			3'b110 : w = in_a;			// MOVA
			3'b111 : w = in_b;			// MOVB
		endcase	

		v = 1'b0;
		if (f == 3'b000) begin
			// 2 positive numbers give negative sign or
			// 2 negative numbers give positive sign
			if((in_a[BW-1] & in_b[BW-1] & ~w[BW-1]) | 
			  (~in_a[BW-1] & ~in_b[BW-1] & w[BW-1]))
				v = 1'b1;
		end
		if(f == 3'b001) begin
			// same as addition but in subtraction in_b is inversed. (A + (-B))
			if((in_a[BW-1] & ~in_b[BW-1] & ~w[BW-1]) | 
			  (~in_a[BW-1] & in_b[BW-1] & w[BW-1]))
				v = 1'b1;
		end
		if(f == 3'b101) begin
			v = in_a[BW-1] ^ in_a[BW-2];
		end
	end

	assign n = w[BW-1];
	assign z = (w == 0) ? 1 : 0;	// ~|w
	
	assign out = w;
	assign flags = {v,n,z};
	
endmodule
