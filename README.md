# SoundItOut
## Code and data associated with Donnelly, et al., 2020
Authors: Patrick M. Donnelly, Liesbeth Gijbels, Kevin Larson, Tanya Matskewich, Paul Linnerud, Patricia K. Kuhl, and Jason D. Yeatman

## Summary

### Dependencies
 `Analysis requires Python 3.6 and MATLAB 2020b software`
* linear mixed effects modeling uses the MATLAB Statistics and Machine Learning Toolbox
* violin plots (in addition to some others) are made using the seaborn visualization package for python: https://seaborn.pydata.org/

### Data
* **data/study1** - data files for crossover study (study 1)
  * data is separated into tables for each outcome measure: **study1_word, study1_pseudo, study1_acc, study1_rate**
  * **study1_demodata** contains demographics information to create Study 1 demographics table

* **data/study2** - data files for RCT (study 2)
  * **study2_longdata** - data in long format (stacked)
  * **study2_widedata** - data in wide format
  * **study2_validationdata** - data for validation study comparing two image cue sets (methods/app design)

### Analysis
* `study1_analysis.m` - MATLAB script to run LME analysis for crossover study (study 1)
* `study2_analysis.m` - MATLAB script to run LME analysis for RCT study (study 2)
* `study2_demo.m` - MATLAB script to generate study 2 deomgraphics table
* `supp_fig1_analysis.ipynb` - Jupyter notebook to run validation study analysis for study 2 app design

### Figures
* `figure2.ipynb` - Jupyter notebook to create figure 2
* `figure3.ipynb` - Jupyter notebook to create figure 3
* `figure4_5.m` - MATLAB script to generate figures 4 & 5, uses LME analysis scripts
