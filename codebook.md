---
title: "Getting and cleaning Data. week 4"
author: "Mark Ayzenshteyn"
date: "1/23/2017"
output: html_document
---



## Abstract

This document descibes the work steps performed to generate the output required in the course.

## Data source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following tables were used
* X_train.txt
* subject_train.txt
* Y_train.txt
* X_test.txt
* subject_test.txt
* Y_test.txt
* features.txt
* activity_labels.txt


## Steps

As train and test data were in separate files they were first merged using `rbind`
The feature names were then copied in from features.txt

Only feature names with mean and std in the name `relevantFeatureNames<-grep("mean|std",justFeatureNames)` were maintained.
The X data was merged with Y and then aggregated by activity and subject