# README #

This is the short overview of the framework that describes main scripts, functions and general work-flow.

## Consensus Framework ##

**Consensus Framework** is used to test consensus clustering algorithms.
It consists of numerous MATLAB functions with well description headers and commented steps. Grammar mistakes may occur.

Not all functions are produced by author.

The basic execution script *Script_Contest.m* launches framework.
Main steps of the script are:

1. General Initialization
2. Dataset loading
3. Consensus function initialization
4. Ensemble parameters initialization
5. Ensemble building
6. Consensus running
7. Saving and result presentation

## Steps Description ##

In this section some description of the main steps, listed above, is presented.
Some parts of the functions may vary depending on the goals of your experiments.

###1. General Initialization ###

Main function of this step is *FrameInit(Options)* with input structure *Options*:

```
Options.DataDir = './data/'; % directory with datasets or generators
Options.ConsensusDir = './algorithms/'; % directory with algorithms
Options.UtilsDir = './utils/'; % directory with some useful utilities
Options.EnsembleSrcFuncsDir = './ensmblsrc/'; % directory with ensemble generator functions
Options.ResultsDir = './results/'; % directory that will contain .mat files and figures of experiment execution
Options.XlsDir = './results/'; % directory that will contain xls summary of experiment
Options.SaveFileName = 'Experiments_kmeansGen'; % xls-folder of current experiment in .XlsDir
Options.DrawResults = 1; % flag variable
Options.ExportResults = 1; % flag variable
```
*FrameInit.m* will temporarily add needed folders in your MATLAB path.

###2. Dataset loading ###

This part of script has two steps with special MATLAB function for each.

---------------------------------------------
The first one is *GetDatasetList(Options)*.

The result of this function is Nx3 cell array *DatasetList* that is used to produce a dataset. 

The first column of the array contains user-given names of datasets. They are displayed on outputted figures and .xls files and needed just for clear identification in the output.

The second column contains function-handler of dataset production function.
Dataset production function is needed to output datasets in the proper format (see below).

The third column contains the structure that represents parameters of correspondent dataset production function.

Example:
```
DataParams.PartitionGenParams.numObjects = 500;
DataParams.PartitionGenParams.numClusters = 4;
DataParams.PartitionGenParams.minObjects = 50;


DatasetList = {...
                 'PartGenerated', @partitionGenLoader, DataParams.PartitionGenParams;...
};
```

Functions like *partitionGenLoader(Params)* are required for all types of datasets: generated, real, artificial. All generators and most of the real datasets already have their own production functions implemented.

-----------------------------------------------------

The second step is performed by *LoadData(DatasetList)*. Based on given *DatasetList* this function outputs *Data* cell-array with the following format of structs in each cell:

* .name - name of dataset (string)
* .X - [object x feature] matrix (double)
* .truth - cluster label vector (double)
* .clNum - number of clusters (double)
