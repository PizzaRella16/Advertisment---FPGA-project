# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]       
 set_property IOSTANDARD LVCMOS33 [get_ports CLK]
set_property PACKAGE_PIN V17 [get_ports RST]     
 set_property IOSTANDARD LVCMOS33 [get_ports RST]
 
#seven-segment LED display
set_property PACKAGE_PIN W7 [get_ports {CATODE[6]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[6]}]
set_property PACKAGE_PIN W6 [get_ports {CATODE[5]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[5]}]
set_property PACKAGE_PIN U8 [get_ports {CATODE[4]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[4]}]
set_property PACKAGE_PIN V8 [get_ports {CATODE[3]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[3]}]
set_property PACKAGE_PIN U5 [get_ports {CATODE[2]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[2]}]
set_property PACKAGE_PIN V5 [get_ports {CATODE[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[1]}]
set_property PACKAGE_PIN U7 [get_ports {CATODE[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {CATODE[0]}]
set_property PACKAGE_PIN U2 [get_ports {ANODE[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[0]}]
set_property PACKAGE_PIN U4 [get_ports {ANODE[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[1]}]
set_property PACKAGE_PIN V4 [get_ports {ANODE[2]}]               
   set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[2]}]
set_property PACKAGE_PIN W4 [get_ports {ANODE[3]}]          
   set_property IOSTANDARD LVCMOS33 [get_ports {ANODE[3]}]

## Switches
set_property PACKAGE_PIN R2 [get_ports {SEL[1]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {SEL[1]}]
set_property PACKAGE_PIN T1 [get_ports {SEL[0]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {SEL[0]}]
 
 set_property PACKAGE_PIN W13 [get_ports {EasterEgg[3]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {EasterEgg[3]}]
set_property PACKAGE_PIN W14 [get_ports {EasterEgg[2]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {EasterEgg[2]}]
 set_property PACKAGE_PIN W15 [get_ports {EasterEgg[1]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {EasterEgg[1]}]
set_property PACKAGE_PIN W16 [get_ports {EasterEgg[0]}]     
 set_property IOSTANDARD LVCMOS33 [get_ports {EasterEgg[0]}]
 
 
 
set_property PACKAGE_PIN U1 [get_ports START]     
 set_property IOSTANDARD LVCMOS33 [get_ports START]