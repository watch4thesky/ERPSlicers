# ERPSlicers

This is a test package for the Automatic Control 2022 Julia course. The implemented functions are computing mean and standard deviations for EEG-data across epochs.

The assumed dataformats are EEG-data of shape (epochs, channels, time-samples) with corresponding labels in a one-dimesional vector. 

The functions in the package is trivial and average_epochs() and std_epochs are implements with differnt syntax just to test differnt ways of using/not using the mutable struct ERPSlicer().