- zuc.v
  - main file
  - input iv, k
  - when receiving a posedge clk, provide a 32 bit Z and use L_ CNT records which Z is currently listed
- sbox.v
  - include sbox1 and sbox2 for F_func.v
- LSFR.v
  - include initial mode and work mode
- BitReconstrcution.v
- F_func.v
- use zuc.v to continuously receive Z to achieve 128-eea3 and 128-eia3