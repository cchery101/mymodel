"""
Module for reading and plotting data for model project
"""

import matplotlib.pyplot as plt
import numpy as np

def ReadFile(FileName):
    f = open(FileName)
    Array = np.array(f.readlines())
    f.close()
    return Array
