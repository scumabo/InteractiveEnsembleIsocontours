# InteractiveEnsembleIsocontours
This is the source code of the paper "An Interactive Framework for Visualization of Weather Forecast Ensembles"  in IEEE Transactions on Visualization and Computer Graphics, Special Issue on IEEE VIS2018. The lightweight source code includes all key features and provides two demo data used in the paper. 

# Quick Start
**- Install M_Map https://www.eoas.ubc.ca/~rich/map.html**
**- Install Piotr's Computer Vision Matlab Toolbox https://pdollar.github.io/toolbox/**
**Run "Ensemble.m" to start the interactive tool. Follow the steps, shown in the image below, to explore ensemble isocontours.  **
![Alt text](Doc.png?raw=true "Interface Overview")
**1. Select input data:** We provide two demo datasets for users to reproduce the experiments in the paper. 

**2. Specify isovalues of interest:** Specify the set of isovalues of interest.

**3. Perform preprocessing:** There are mainly two tasks: 1. Compute signed distance transforms for all isocontours. 2. Perform high-density clustering for all specified isovalues in the default setting.

**4. Spaghetti plot:** The linked spaghetti plot to display spatial contexts. 

**5. Bandwidth re-computation (optional):** The bandwidth of high-density clusterings can be interactively selected. 

**6. Enable regional analysis (optional):** This enables a brush in the spaghetti plot for regional analysis. 

**7. Interactive high-density (re-)clustering (optional):** When 5 or 6 changes, redo clustering.

**8. Mode plot:** Attribute space view of the distribution of ensemble isocontours.

**9. Isocontour filtrations:** Interactive selection of ensemble isocontours. 

# Demo Video
