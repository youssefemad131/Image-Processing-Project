# 🖼️ Image Processor
### A MATLAB GUI-Based Image Processing Application

> An interactive image processing tool built with MATLAB GUIDE, featuring 50+ image processing operations across noise addition/removal, spatial filters, frequency domain, morphological operations, color conversions, and more — all accessible through a user-friendly graphical interface.

---

## 📸 Screenshots

> _Add screenshots of your GUI here_

```
screenshots/
├── main_interface.png
├── filters_demo.png
└── frequency_domain.png
```

---

## ✨ Features

### 🎨 Color & Intensity Operations
| Function | File |
|----------|------|
| RGB to Grayscale | `RGB2gray.m` |
| RGB to Binary | `RGB2Binary.m` |
| Grayscale to Binary | `graytobinary.m` |
| Image Negative | `ImageNegative.m` |
| Brightness & Darkness | `Brightness_Darkness.m` |
| Contrast Stretching | `contrast_stretch.m` |
| Gamma Correction | `GammaCorrection.m` |
| Log Transformation | `Log.m` |
| Bit Plane Slicing | `BitPlaneSlicing.m` |
| Intensity Level Slicing | `IntensityLevelSlicing.m` |
| Histogram Equalization | `Histogram_Equalization.m` |
| Histogram Display | `histogram.m` |

---

### 🔊 Noise Addition
| Function | File |
|----------|------|
| Salt & Pepper Noise | `SaltPepperAdd.m` |
| Uniform Noise | `uniform_noise.m` |
| Rayleigh Noise | `add_rayleigh_noise.m` |
| Exponential Noise | `AddExponentialNoise.m` |
| Gamma Noise | `AddGammaNoise.m` |

---

### 🧹 Noise Removal / Spatial Filters
| Function | File |
|----------|------|
| Salt & Pepper Removal | `SaltPepperRemove.m` |
| Mean Filter | `MeanFilter.m` |
| Median Filter | `median_filter.m` |
| Max Filter | `MaxFilter.m` / `max_filter.m` |
| Min Filter | `MinFilter.m` |
| Midpoint Filter | `MidpointFilter.m` |
| Weighted Filter | `weighted_filter.m` |
| Adaptive Filter | `adaptive_filter.m` |
| Harmonic Filter | `harmonic_filter.m` |
| Contraharmonic Filter | `ContraharmonicFilter.m` |
| Geometric Mean Filter | `geometric_mean_filter.m` |
| Rayleigh Noise Removal | `remove_rayleigh_noise.m` |
| Exponential Noise Removal | `RemoveExponentialNoise.m` |
| Gamma Noise Removal | `RemoveGammaNoise.m` |

---

### 📐 Sharpening & Edge Detection
| Function | File |
|----------|------|
| Line Sharpening | `LineSharpening.m` |
| Point Sharpening | `point_sharpening.m` |
| Line Detection | `line_detection.m` |
| Point Detection | `PointDetection.m` |
| Correlation | `correlation.m` |
| Padding | `padding.m` |

---

### 🌊 Frequency Domain Filters
| Function | File |
|----------|------|
| DFT (Discrete Fourier Transform) | `DFT.m` |
| Inverse Fourier Transform | `InverseFourierTransform.m` |
| Gaussian Low Pass Filter | `gaussianLPF.m` |
| Gaussian High Pass Filter | `gaussianHPF.m` |
| Ideal Low Pass Filter | `IdealLowPassFilter.m` |
| Ideal High Pass Filter | `ideal_high_pass_filter.m` |
| Butterworth Low Pass Filter | `ButterworthLowPass.m` |
| Butterworth High Pass Filter | `butterworthHPF.m` |
| Gaussian Operations | `GaussianOperations.m` |

---

### 🔷 Morphological Operations
| Function | File |
|----------|------|
| Dilation | `dilation.m` |
| Erosion | `erosion.m` |
| Opening | `opening.m` |
| Closing | `closing.m` |

---

## 🗂️ Project Structure

```
ImageProcessor/
├── ImageProcessor.fig        # MATLAB GUIDE GUI layout file
├── ImageProcessor.m          # Main GUI callback functions
├── src/                      # All image processing function scripts
│   ├── RGB2gray.m
│   ├── RGB2Binary.m
│   ├── SaltPepperAdd.m
│   ├── SaltPepperRemove.m
│   ├── uniform_noise.m
│   ├── weighted_filter.m
│   ├── adaptive_filter.m
│   ├── add_rayleigh_noise.m
│   ├── AddExponentialNoise.m
│   ├── AddGammaNoise.m
│   ├── BitPlaneSlicing.m
│   ├── Brightness_Darkness.m
│   ├── butterworthHPF.m
│   ├── ButterworthLowPass.m
│   ├── closing.m
│   ├── ContraharmonicFilter.m
│   ├── contrast_stretch.m
│   ├── correlation.m
│   ├── DFT.m
│   ├── dilation.m
│   ├── erosion.m
│   ├── GammaCorrection.m
│   ├── gaussianHPF.m
│   ├── gaussianLPF.m
│   ├── GaussianOperations.m
│   ├── geometric_mean_filter.m
│   ├── graytobinary.m
│   ├── harmonic_filter.m
│   ├── histogram.m
│   ├── Histogram_Equalization.m
│   ├── ideal_high_pass_filter.m
│   ├── IdealLowPassFilter.m
│   ├── ImageNegative.m
│   ├── IntensityLevelSlicing.m
│   ├── InverseFourierTransform.m
│   ├── line_detection.m
│   ├── LineSharpening.m
│   ├── Log.m
│   ├── max_filter.m
│   ├── MaxFilter.m
│   ├── MeanFilter.m
│   ├── median_filter.m
│   ├── MidpointFilter.m
│   ├── MinFilter.m
│   ├── negative.m
│   ├── opening.m
│   ├── padding.m
│   ├── point_sharpening.m
│   ├── PointDetection.m
│   ├── remove_rayleigh_noise.m
│   ├── RemoveExponentialNoise.m
│   └── RemoveGammaNoise.m
├── Assets/                   # Sample images for testing
│   └── *.png / *.jpg
└── README.md
```

---

## ⚙️ Requirements

| Requirement | Details |
|-------------|---------|
| **MATLAB** | R2018a or later recommended |
| **Toolboxes** | Image Processing Toolbox |
| **OS** | Windows / macOS / Linux |

> To verify the Image Processing Toolbox is installed, run in MATLAB:
> ```matlab
> ver('images')
> ```

---

## 🚀 How to Run

**1. Clone or Download the Repository**

```bash
git clone https://github.com/your-username/ImageProcessor.git
```

Or download the ZIP and extract it.

**2. Open MATLAB and Set the Path**

Launch MATLAB, navigate to the project directory, and add `src/` to the path:

```matlab
cd('path/to/ImageProcessor')
addpath('src')
```

**3. Launch the GUI**

Run directly from the Command Window:

```matlab
ImageProcessor
```

Or open via GUIDE:

```matlab
guide
```
Then go to **File → Open** and select `ImageProcessor.fig`, then press **F5** to run.

**4. Start Processing**

- Click **Load Image** to import an image file
- Browse the available operations from the GUI controls
- Preview results in real time
- Click **Save** to export the processed image

---

## 📝 Notes

- The `.fig` and `.m` files share the same name (`ImageProcessor`) and **must stay in the same folder** — MATLAB requires this for GUIDE-based GUIs.
- Always run `addpath('src')` before launching the GUI, otherwise the callback functions won't be found.
- MATLAB GUIDE is available up to **R2022b**. In R2023a and later, GUIDE was removed. The project can still be run, but editing the layout requires an older MATLAB version or migration to App Designer.
- Sample images are provided in the `Assets/` folder to test filters immediately after setup.

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

*MATLAB Image Processing Project · 2026*
