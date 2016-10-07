target = "xilinx"
action = "synthesis"
fetchto = "../../../ip_cores"

syn_device = "xc6slx100t"
syn_grade = "-3"
syn_package = "fgg484"
syn_top = "pc049a_top"
syn_project = "pc049a_top_simple.xise"
syn_tool = "ise"

modules = { "local" : "../../../top/pc049a/simple"
            }
