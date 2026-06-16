# PCB CAD and firmware for pc049a MAROC board

### Two firmware projects:
- `simple` - includes IPBus and MAROC control blocks
- `demo` - includes WhiteRabbit core - currently broken


### To build firmware
* Install Xilinx ISE and a command line environment where `hdlmake` ( from ohwr.org ) works
* pip install hdlmake
* cd firmware/syn/pc049a/simple
* hdlmake
* make

### Software to read out board (Python3)
* cd firmware/scripts
* ./takeMarocData.sh




