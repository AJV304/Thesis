
# nodes — every unique label in order
nodes <- list(
  label = c(
    "",           # 0
    "", # 1
    "",     # 2
    "",  # 3
    "",# 4
    "",                   # 5
    "",                   # 6
    "",                   # 7
    "",                   # 8
    "",                   # 9
    "",                   # 10
    ""                    # 11
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
    0.0,                                     # All iterations
    0.20, 0.80,                               # level 2
    0.50, 0.80,                               # level 3
    0.80, 0.80, 0.80, 0.80, 0.80, 0.80, 0.80 # level 4
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
    font = list(size = 16),
    annotations = list(
      list(x = 0.08, y = 0.5,   text = "",                         showarrow = FALSE, xanchor = "right"),
      list(x = 0.31, y = 0.20,  text = "<b>Baseline n.s.</b>",       showarrow = FALSE, xanchor = "right"),
      list(x = 0.78, y = 0.73,  text = "<b>Baseline sig.</b>",     showarrow = FALSE, xanchor = "right"),
      list(x = 0.60, y = 0.12,  text = "<b>1+ sig. deviation</b>", showarrow = FALSE, xanchor = "right"),
      list(x = 0.78, y = 0.35,  text = "<b>No sig. deviation</b>", showarrow = FALSE, xanchor = "right"),
      list(x = 0.78, y = 0.22,  text = "<b>1 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = 0.18,  text = "<b>2 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = 0.14,  text = "<b>3 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = 0.10,  text = "<b>4 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = 0.06,  text = "<b>5 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = 0.02,  text = "<b>6 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12)),
      list(x = 0.78, y = -0.02, text = "<b>7 sig.</b>",            showarrow = FALSE, xanchor = "right", font = list(size = 12))
    )
  )
