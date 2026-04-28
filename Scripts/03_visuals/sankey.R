
# nodes — every unique label in order
nodes <- list(
  label = c(
    "",           # 0
    "", # 1
    "Baseline significant",     # 2
    "",  # 3
    "No significant deviations",# 4
    "1 sig.",                   # 5
    "2 sig.",                   # 6
    "3 sig.",                   # 7
    "4 sig.",                   # 8
    "5 sig.",                   # 9
    "6 sig.",                   # 10
    "7 sig."                    # 11
  ),
  color = c(
    "#7BA7D4",  # All iterations
    "#80DEEA",  # Baseline not significant
    "#B39DDB",  # Baseline significant
    "#F48FB1",  # A significant deviation
    "#FFCC80",  # No significant deviations
    "#A5D6A7",  # 1 sig.
    "#A5D6A7",  # 2 sig.
    "#A5D6A7",  # 3 sig.
    "#A5D6A7",  # 4 sig.
    "#A5D6A7",  # 5 sig.
    "#A5D6A7",  # 6 sig.
    "#A5D6A7"   # 7 sig.
  ),
  x = c(
    0.1,                                     # All iterations
    0.33, 0.99,                               # level 2
    0.66, 0.99,                               # level 3
    0.99, 0.99, 0.99, 0.99, 0.99, 0.99, 0.99 # level 4
  ),
  # y position: spread nodes within each column
  y = c(
    0.5,          # All iterations
    0.80, 0.30,   # Baseline not sig, Baseline sig
    0.85, 0.65,   # A sig deviation, No sig deviations
    0.76, 0.80, 0.84, 0.88, 0.92, 0.96, 1  # 1 sig → 7 sig
  )
)

# links — source and target use the index numbers above (0-based)
links <- list(
  source = c(0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 3),
  target = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11),
  value  = c(325, 1279, 205, 116, 75, 61, 30, 31, 4, 3, 1),
  color  = c(
    "#80DEEA", # All → Baseline not sig
    "#B39DDB", # All → Baseline sig
    "#F48FB1", # Baseline not sig → A significant deviation
    "#FFCC80", # Baseline not sig → No significant deviations
    "#A5D6A7", # A sig dev → 1 sig
    "#A5D6A7", # A sig dev → 2 sig
    "#A5D6A7", # A sig dev → 3 sig
    "#A5D6A7", # A sig dev → 4 sig
    "#A5D6A7", # A sig dev → 5 sig
    "#A5D6A7", # A sig dev → 6 sig
    "#A5D6A7"  # A sig dev → 7 sig
  )
)

plot_ly(
  type = "sankey",
  orientation = "h",
  node = nodes,
  link = links
) |>
  plotly::layout(
    title = "Distribution of significance",
    font = list(size = 14),
    annotations = list(
      list(x = 0.07, y = 0.5,  text = "All iterations",            showarrow = FALSE, xanchor = "right"),
      list(x = 0.3, y = 0.2, text = "Baseline non-significant",          showarrow = FALSE, xanchor = "right"),
      list(x = 0.33, y = 0.7,  text = "",                   showarrow = FALSE, xanchor = "right"),
      list(x = 0.63, y = 0.15, text = "A significant deviation",   showarrow = FALSE, xanchor = "right"),
      list(x = 0.66, y = 0.45, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.55, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.66, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.74, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.82, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.90, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.99, text = "",                    showarrow = FALSE, xanchor = "right"),
      list(x = 0.99, y = 0.99, text = "",                    showarrow = FALSE, xanchor = "right")
    )
  )


# #test
# nodes$label <- rep("", length(nodes$label))
# 
# plot_ly(type = "sankey",
#         orientation = "h",
#         node = nodes,
#         link = links) |>
#   layout(
#     annotations = list(
#       list(x = 0.17, y = 0.5,  text = "All iterations",            showarrow = FALSE, font = list(size = 12)),
#       list(x = 0.5,  y = 0.3,  text = "Baseline not significant",  showarrow = FALSE, font = list(size = 12)),
#       list(x = 0.5,  y = 0.85, text = "Baseline significant",      showarrow = FALSE, font = list(size = 12)),
#       list(x = 0.83, y = 0.15, text = "A significant deviation",   showarrow = FALSE, font = list(size = 12)),
#       list(x = 0.83, y = 0.55, text = "No significant deviations", showarrow = FALSE, font = list(size = 12))
#     )
#   )
