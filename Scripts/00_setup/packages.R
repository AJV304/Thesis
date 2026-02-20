#Packages

#install.packages("dplyr")
#install.packages("DiagrammeR")

library(dplyr)
library(tidyr)
library(ggplot2)
library(DiagrammeR)
library(mvtnorm)
library(stats)


#------------
#Diagram

```{r}
#| echo: false

#flow-chart for situations
graph <- DiagrammeR(" graph TD; A(Scenario) --> F(Baseline Condition);A --> G(Deviation condition);G --> J(Deviation value); G --> K(Pick best value);")

# Save the diagram as a PNG file
export_graph(graph, file_name = "process-phases.png", file_type = "png")

```

#mermaid code
---
  config:
  theme: redux
layout: dagre
---
  flowchart TB
subgraph identifier["</br>"]
B["Generate data"]
C["Baseline condition"]
D["deviation condition"]

A["Scenario"] --> B
B --> C & D

subgraph identifier2["</br>"]
D --> E["Deviation value"] 
end

subgraph identifier3["</br>"]
D --> G[Pick baseline vs deviation value]
end
end

