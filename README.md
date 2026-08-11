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
git clone https://github.com/Ji2424/oct-skin-segmentation.git
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

### Computational Requirements

Accuracy alone doesn't tell the full story, deployment feasibility matters too. All models were benchmarked for parameter count, GFLOPs, and CPU inference latency (averaged over 100 forward passes):

| Architecture  | Parameters  | GFLOPs | Latency (CPU, ms) |
|---------------|-------------|--------|--------------------|
| U-Net         | 24.4M       | 31.51  | 1600.24            |
| DeepLabV3+    | 26.7M       | 36.93  | 1844.73            |
| U-Net++       | 26.1M       | 73.91  | 3729.75            |

*Latency measured on CPU; a GPU deployment would be considerably faster in absolute terms, though relative differences between models would hold, U-Net++ requires roughly 2x the inference time of U-Net regardless of hardware.*

**Recommendation:** U-Net++ is the best choice where accuracy is the priority (research, pharmaceutical evaluation). U-Net offers the best accuracy-to-efficiency trade-off for real-time or resource-constrained deployment. DeepLabV3+ is not recommended for this task, its deeper backbone adds computational cost without a corresponding accuracy gain.

---

## 🔍 Key Findings
- U-Net++ achieved the highest performance across all metrics  
- Dense skip connections and squeeze-and-excitation blocks improved boundary recovery  
- DeepLabV3+ underperformed on thin structures due to reliance on global context (ASPP) instead of local spatial detail

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
