local empty_line = [[]]

local header = {
  empty_line,
  empty_line,
  [[            .:-`                                                          ]],
  [[          `+oooo`                                                         ]],
  [[          +-  :o+                                                         ]],
  [[               /o-                                                        ]],
  [[               .oo`                                                       ]],
  [[               /oo:                dP                         oo          ]],
  [[              `oo+o`               88                                     ]],
  [[              :o:.o/      88d888b. 88d888b. .d8888b. 88d888b. dP .d8888b. ]],
  [[             `oo` /o.     88'  `88 88'  `88 88'  `88 88'  `88 88 88'  `   ]],
  [[             :o+  `oo` `  88.  .88 88    88 88.  .88 88    88 88 88.  ... ]],
  [[     -/++++:.oo-   :oo++  88Y888P' dP    dP `88888P' dP    dP dP `88888P' ]],
  [[    ++-..-:/ooo`    .-.   88                                              ]],
  [[ `--o+:------o+--`        dP                                              ]],
  [[    `/oo+///++`                                                           ]],
  [[       .-::-`                                                             ]],
  empty_line,
  empty_line,
}

return {
  "nvimdev/dashboard-nvim",
  opts = {
    config = {
      header = header,
    },
  },
}
