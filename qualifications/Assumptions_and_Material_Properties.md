# Assumptions and Material Properties  
## mmWave Radar Radome Design (77–81 GHz)

---

## 1. Purpose

This document records the **assumptions, material property priors, and uncertainty models**
used in the simulation and verification of a mmWave radar radome operating in the
77–81 GHz band.

This document supports the system definition and test plan by recording all modeling assumptions used in simulation and analysis.

Values listed here are treated as **engineering estimates** and are intentionally paired
with uncertainty bounds to support sensitivity and robustness analysis later in the project.

---

## 2. Operating Band and Constants

- Frequency band: **77–81 GHz**
- Center frequency: **79 GHz**

### Constants
- Speed of light:  
  \( c = 299{,}792{,}458 \ \text{m/s} \)
- Relative permeability:  
  \( \mu_r \approx 1 \) (assumed for all candidate plastics)

---

## 3. Candidate Radome Materials

ABS and polycarbonate were selected as candidate radome materials due to their
common use in plastic enclosures and accessibility for fabrication.

Published dielectric properties vary by material grade, filler content, and processing
method. For this reason, nominal values are paired with uncertainty ranges.

### Material Property Priors

| Material | εr (nominal) | εr uncertainty | tanδ (nominal) | tanδ treatment | Notes |
|--------|---------------|----------------|----------------|----------------|-------|
| ABS | 2.9 | ±10% (uniform) | 0 (initial) | Treated as uncertain later | Grade- and print-orientation dependent |
| Polycarbonate | 3.0 | ±10% (uniform) | 0 (initial) | Treated as uncertain later | Moisture-sensitive; grade dependent |

Loss tangent is initially set to zero to isolate reflection-driven behavior. Material loss
is introduced later as an uncertain parameter during sensitivity and Monte Carlo analysis.

---

## 4. Geometry Definitions and Tolerances

### 4.1 Radome Thickness (t)

- Variable parameter in optimization and sweeps
- Units: millimeters (mm)

Thickness bounds are selected after computing the wavelength in the material at the
center frequency.

#### Thickness uncertainty model
- \( t \sim \mathcal{N}(t^\*, \sigma_t) \)
- Initial assumption:  
  \( \sigma_t = 0.1 \ \text{mm} \)

---

### 4.2 Antenna-to-Radome Standoff (D)

- Distance between antenna phase center and inner radome surface

#### Standoff uncertainty model
- \( D \sim \mathcal{N}(D^\*, \sigma_D) \)
- Initial assumption:  
  \( \sigma_D = 0.2 \ \text{mm} \)

---

### 4.3 Radome Geometries

Two radome geometries are evaluated:

1. **Flat plate radome**
2. **Spherical cap radome**

These are compared to evaluate sensitivity to incidence angle across the field of view.

---

## 5. Simulation Assumptions by Level

### Level 1 — Normal Incidence Analytic Model
- Radome modeled as air–dielectric–air slab
- Multiple internal reflections included
- Normal incidence assumed
- Outputs:
  - \( |\Gamma(f)| \)
  - \( T(f) \)
  - \( IL(f) \)
  - Worst-case insertion loss across band

### Level 2 — Oblique Incidence
- Oblique incidence modeled for planar radome
- Evaluation angles: 0°, 15°, 30°, 45°, 60°
- Spherical cap evaluated using local surface normal approximation

### Level 3 — 3D Electromagnetic Simulation
- Simplified 3D studies performed using MATLAB where feasible
- Full-wave validation planned using HFSS when access is available
- Outputs include S11 shift, gain change, and pattern distortion

---

## 6. Acceptance Criteria Reference

Performance thresholds and pass/fail criteria are defined in:

