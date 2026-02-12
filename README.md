# Deep Learning-Based Segmentation of the Stratum Corneum in Ultra-High-Resolution OCT Images

Work in Progress – MEng Dissertation Project

# Project Overview

This dissertation project focuses on developing and comparing deep learning models for automated segmentation of the stratum corneum in ultra-high-resolution Optical Coherence Tomography (OCT) images of living skin.

The stratum corneum is a thin outer barrier layer of the epidermis that is difficult to segment manually due to its small thickness, weak contrast, and inter-individual variability. Manual annotation is slow and inconsistent, motivating the use of data-driven segmentation models.

This project aims to build reliable, reproducible, and interpretable segmentation pipelines using convolutional neural networks.

# Dataset and Labelling

Pre-existing ultra-high-resolution OCT B-scan dataset

Manual labelling performed using OCTLabelTool in MATLAB

Three boundaries annotated:

Skin Surface (SS)

Stratum Corneum (SC)

Dermal-Epidermal Junction (DEJ)

Ground truth masks generated for supervised training

# Models Implemented (Current Stage)
## U-Net

Encoder–decoder architecture with skip connections

80/20 train–validation split

Learning rate: 0.0001

Final validation accuracy: 82.48%

Stable convergence with decreasing cross-entropy loss

## DeepLab v3

Atrous convolutions for wider contextual capture

Same 80/20 split and training configuration

Final validation accuracy: 85.99%

Faster early convergence than U-Net

Although DeepLab v3 achieved slightly higher validation accuracy, visual inspection of segmentation outputs suggests U-Net produces smoother and more consistent stratum corneum boundaries. This highlights the importance of qualitative evaluation in thin-layer medical segmentation tasks.

# Evaluation Metrics

Mini-batch accuracy

Validation accuracy

Cross-entropy loss

Planned: IoU and Dice coefficient (next stage)

# Current Progress

Completed:

Literature review

Dataset preprocessing and initial labelling

Implementation and training of U-Net and DeepLab v3

Initial quantitative and qualitative evaluation

In Progress:

Improving labelling consistency

Fine-tuning hyperparameters

Computing IoU and Dice metrics

Comparative analysis and ablation studies

# Research Motivation

Existing OCT segmentation studies primarily target broader epidermal layers. Few works specifically evaluate model performance on isolating the stratum corneum, despite its clinical relevance.

This project addresses that gap by directly comparing architectures for thin-layer segmentation in ultra-high-resolution OCT images.

# Ethical Considerations

Uses pre-existing dataset only

No interaction with human participants

Secure data storage following university guidelines

No raw data sharing outside the project

This project remains ongoing and will be updated with further quantitative analysis, hyperparameter optimisation, and extended model comparisons.
