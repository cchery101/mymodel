"""
Script for making plots
"""

import numpy as np
import matplotlib.pyplot as plt
from read_plot_module import *

GridName = 'grid.txt'
FileName = 'output.txt'

Grid = ReadFile(GridName)
Array = ReadFile(FileName)

plt.plot(Grid, Array)
plt.savefig('plot.png')
