# Deep-Learning-Based Segmentation of Stratum Corneum in Ultra-High-Resolution OCT Images

An end-to-end medical image segmentation pipeline developed to automate the delineation of the Stratum Corneum (SC) and adjacent epidermal structures within ultra-high-resolution Optical Coherence Tomography (OCT) scans of living skin.

Accurate SC thickness monitoring is an essential biomarker for dermatological clinical diagnostics, assessing cosmetics efficacy, and tracking pharmaceutical transdermal drug delivery. This project implements, tests, and benchmarks three deep architectures to overcome limitations of traditional hand-crafted edge filters against low-contrast tissue boundaries and structural speckle noise.

---

## 📊 Project Features & Classes

The deep learning pipeline maps pixel-level predictions across four mutually exclusive classes:

1. Background  
2. Skin Surface (SS)  
3. Stratum Corneum (SC)  
4. Dermo-Epidermal Junction (DEJ)

### Workflow & Core Preprocessing

- Label Matching  
  Images are annotated using `OCTlabelTool` (MATLAB) and mapped using filename-based verification.

- Image Processing  
  Input scans are resized to a uniform 512 × 512 grid. Contrast Limited Adaptive Histogram Equalisation (CLAHE) is applied to reduce regional optical imbalance, followed by ImageNet normalization.

- Augmentation  
  Training uses geometric and pixel-level augmentations via the `Albumentations` framework to reduce overfitting on limited clinical data.

---

## ⚙️ Repository Setup

### Architecture Stack

- Core Framework: PyTorch  
- Models: `segmentation-models-pytorch` with ResNet-34 backbone  
- Image Processing: OpenCV  

---

### Local Installation

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/oct-skin-segmentation.git
cd oct-skin-segmentation

# Install dependencies
pip install torch torchvision albumentations segmentation-models-pytorch opencv-python matplotlib numpy
```

---

## 📈 Benchmarking Results

Models were evaluated on a dataset expanded from 212 image-mask pairs to 1,272 via augmentation, trained on an NVIDIA T4 GPU.

### Overall Performance Summary

| Architecture   | Mean Pixel Accuracy | Mean IoU | Mean Dice | Global Sensitivity | Global Precision |
|---------------|---------------------|----------|-----------|--------------------|------------------|
| DeepLabV3+    | 98.31%              | 0.7929   | 0.8740    | 0.9379             | 0.8259           |
| U-Net         | 98.66%              | 0.8488   | 0.9136    | 0.9537             | 0.8797           |
| U-Net++       | 98.99%              | 0.8860   | 0.9372    | 0.9670             | 0.9108           |

---

## 🔍 Key Findings

- U-Net++ achieved the highest performance across all metrics  
- Dense skip connections and squeeze-and-excitation blocks improved boundary recovery  
- DeepLabV3+ underperformed on thin structures due to reliance on global context (ASPP) instead of local spatial detail  

---

## 🛠️ Extensions & Planned Enhancements

- Transformer Models  
  Evaluate Vision Transformer hybrids such as TransUNet and Swin-UNet for better global-local feature fusion

- Thickness Measurement Validation  
  Convert segmentation masks into physical thickness estimates and compare with clinical ground truth tools

- Multi-Annotator Integration  
  Introduce inter-observer variability modeling to improve ground truth robustness
