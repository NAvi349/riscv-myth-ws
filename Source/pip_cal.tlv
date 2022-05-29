   |calc
      @0
         $reset = *reset;

      @1   
         //$val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];

         $valid = $reset ? 0 : (>>1$valid + 1);
         
         $valid_or_reset = $valid || $reset;
         
      ?$valid_or_reset
         @1
            $out[31:0] = $reset ? 0 : >>2$tout;
            
            $sum[31:0] = $out + $val2;  //00
            $diff[31:0] = $out - $val2; //01
            $prod[31:0] = $out * $val2; //10
            $quot[31:0] = $out / $val2; //11   
            
            
         @2
            // op = 100 => memory read
            // op = 101 => memory write
            
            // memory
            $mem[31:0] = $reset ? 0 :
                                  ($op[2:0] == 3'b101) ? >>2$tout :
                                  >>2$mem;

            $tout[31:0] = ($op[2:0] == 3'b000) ? $sum :
                        ($op[2:0] == 3'b001) ? $diff :
                        ($op[2:0] == 3'b010) ? $prod :
                        ($op[2:0] == 3'b011) ? $quot :
                        ($op[2:0] == 3'b100) ? >>2$mem : >>2$tout;
