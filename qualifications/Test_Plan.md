# RF System Evaluation and Test Plan  
## mmWave Radar Radome Characterization (77–81 GHz)

---

## 1. Test Objectives

The objectives of this test plan are to:

1. Quantify the RF impact of dielectric radomes on a mmWave radar system
2. Compare candidate materials and geometries
3. Identify radome designs that meet RF performance targets with margin
4. Evaluate robustness to manufacturing and material uncertainty
5. Provide design recommendations based on system-level metrics

---

## 2. Performance Metrics (KPIs)

The following key performance indicators (KPIs) are evaluated:

- Worst-case insertion loss across 77–81 GHz
- Worst-case reflection magnitude across 77–81 GHz
- Insertion-loss ripple across band
- Angle-of-incidence degradation
- Statistical pass rate under uncertainty

KPIs are evaluated per material, geometry, and operating scenario.

---

## 3. Test Articles

### 3.1 Radome Materials
- ABS
- Polycarbonate

### 3.2 Geometries
- Flat plate radome
- Spherical cap radome

### 3.3 Thickness and Standoff
- Radome thickness swept over realistic enclosure ranges
- Antenna-to-radome standoff swept over packaging-relevant distances

---

## 4. Operating Scenarios

### 4.1 Nominal Operation
- Nominal supply voltage
- Baseline RF performance evaluation

### 4.2 Reduced V-BAT Operation
- Reduced available power margin
- Increased sensitivity to RF loss
- Used to assess whether radome loss impacts system margin

These scenarios are used to evaluate **relative impact**, not absolute power delivery.

---

## 5. Test Methodology

### Level 1 — Analytic RF Characterization
- Normal-incidence dielectric slab model
- Frequency sweep across 77–81 GHz
- Extraction of IL and reflection metrics
- Thickness and material optimization

### Level 2 — Angular Sensitivity
- Oblique-incidence modeling
- Multiple angles across expected field of view
- Comparison of flat vs curved geometries

### Level 3 — Full-Wave Simulation (Planned)
- 3D EM simulation for selected designs
- Validation of analytic trends
- Evaluation of pattern distortion and mismatch

---

## 6. Robustness and Sensitivity Analysis

To evaluate robustness:

- Manufacturing tolerances applied to thickness and standoff
- Material property variation applied to εr and tanδ
- Monte Carlo simulations performed
- Pass/fail rates computed based on KPI thresholds

---

## 7. Debug and Root-Cause Strategy

Observed performance degradation is analyzed using:

- Parametric sweeps to isolate dominant variables
- Sensitivity metrics to rank contributors
- Comparison across geometries and materials

Common root causes include:
- Thickness resonance effects
- Material loss
- Standing-wave interactions
- Angular mismatch

---

## 8. Acceptance Criteria

Designs are considered acceptable if:

- Worst-case insertion loss remains below defined limits
- Reflection magnitude remains below defined limits
- Performance remains within limits under uncertainty
- No severe angular degradation is observed

Acceptance thresholds are recorded in `KPI_Summary.md`.

---

## 9. Test Outputs

Primary outputs include:
- Frequency response plots
- KPI vs thickness and geometry plots
- Sensitivity coefficients
- Monte Carlo histograms and pass rates
- Design recommendations

---

## 10. Reporting

Results are consolidated into a final characterization report summarizing:
- Methodology
- Findings
- Limitations
- Recommended radome designs and trade-offs
