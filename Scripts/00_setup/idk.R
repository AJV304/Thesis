# #Packages
# 
# 
# #------------
# #Diagram
#  echo: false
# 
# #flow-chart for situations
# graph <- DiagrammeR(" graph TD; A(Scenario) --> F(Baseline Condition);A --> G(Deviation condition);G --> J(Deviation value); G --> K(Pick best value);")
# 
# # Save the diagram as a PNG file
# export_graph(graph, file_name = "process-phases.png", file_type = "png")
# 
# 
# #mermaid code
# ---
#   config:
#   theme: redux
# layout: dagre
# ---
#   flowchart TB
# subgraph identifier["</br>"]
# B["Generate data"]
# C["Baseline condition"]
# D["deviation condition"]
# 
# A["Scenario"] --> B
# B --> C & D
# 
# subgraph identifier2["</br>"]
# D --> E["Deviation value"] 
# end
# 
# subgraph identifier3["</br>"]
# D --> G[Pick baseline vs deviation value]
# end
# end
# 

# DiagrammeR(" graph TD; A(Scenario) --> F(Baseline Condition);A --> G(Deviation condition);")
# DiagrammeR(" graph TD; A(Scenario) --> F(Baseline Condition);F --> G(Deviation condition);")
# 
# 
# grViz("
#   digraph flowchart {
#     graph [layout = dot, rankdir = TB]
#     
#     node [shape = rectangle, style = rounded, fontname = Helvetica]
#     
#     B [label = 'Scenario', shape = ellipse]
#     C [label = 'Is the baseline condition significant?', shape = diamond]
#     D [label = 'Record baseline', shape = ellipse]
#     E [label = 'Are any of the deviations significant?', shape = diamond]
#     F [label = 'Record a significant deviation at random', shape = ellipse]
#     G [label = 'Record baseline', shape = ellipse]
#     
#     B -> C
#     C -> D [label = 'yes']
#     C -> E [label = 'no']
#     E -> F [label = 'yes']
#     E -> G [label = 'no']
#   }
# ")
