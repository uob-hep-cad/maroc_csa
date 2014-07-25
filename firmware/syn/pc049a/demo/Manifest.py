target = "xilinx"
action = "synthesis"

fetchto = "../../../ip_cores"

syn_device = "xc6slx45t"
syn_grade = "-3"
syn_package = "fgg484"
syn_top = "pc049a_top"
syn_project = "pc049a_top_demo.xise"

modules = { "local" : 
            [ "../../../top/pc049a/demo", 
              "../../../whiteRabbit/wr-cores/platform",
              "../../../whiteRabbit/wr-cores/ip_cores/general-cores",
              "../../../whiteRabbit/wr-cores/ip_cores/etherbone-core",
              "../../../whiteRabbit/wr-cores/ip_cores/gn4124-core"] 
            }
