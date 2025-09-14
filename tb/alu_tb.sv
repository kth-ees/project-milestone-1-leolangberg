module alu_tb;                                                                                 
                                                                                               
  parameter BW = 16; // bitwidth                                                               
                                                                                               
  logic unsigned [BW-1:0] in_a;                                                                
  logic unsigned [BW-1:0] in_b;                                                                
  logic             [3:0] opcode;                                                              
  logic unsigned [BW-1:0] out;                                                                 
  logic             [2:0] flags; // {overflow, negative, zero}                                 
                                                                                               
  // Instantiate the ALU                                                                       
  alu #(BW) dut (                                                                              
    .in_a(in_a),                                                                               
    .in_b(in_b),                                                                               
    .opcode(opcode),                                                                           
    .out(out),                                                                                 
    .flags(flags)                                                                              
  );                                                                                           
                                                                                               
  // Generate stimuli to test the ALU                                                          
  initial begin                                                                                
        in_a = '0;                                                                             
        in_b = '0;                                                                             
        opcode = '0;                                                                           
        #10ns;                                                                                 
                                                                                               
        // ADDITION CASES                                                                      
        opcode = 3'b000;                                                                       
        // 1. POS + POS = POS                                                                  
        in_a = 1;                                                                              
        in_b = 2;                                                                              
        #10ns;                                                                                 
        // 2. POS + POS -> F:OVERFLOW                                                          
        in_a = 127;                                                                            
        in_b = 1;                                                                              
        #10ns;                                                                                 
        // 3. POS + NEG -> F:NEGATIVE                                                          
        in_a = 1;                                                                              
        in_b = (-2);                                                                           
        #10ns;                                                                                 
        // 3. NEG + NEG                                                                        
        in_a = (-2);                                                                           
        in_b = (-2);                                                                           
        #10ns;        
