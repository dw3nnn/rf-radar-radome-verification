# RF Radar Radome Characterization and Verification

## Overview

This project implements a structured RF characterization and verification workflow for a millimeter-wave (mmWave) radar radome operating in the 77–81 GHz band. The work focuses on quantifying the electromagnetic impact of radome material and thickness on reflection, insertion loss, and robustness to manufacturing tolerance.

The project is organized as a multi-level evaluation flow, progressing from first-principles analytic models to higher-fidelity geometry- and angle-dependent analysis. The intent is to mirror early-stage RF hardware verification and design decision-making rather than purely theoretical study.

---

## Project Objectives

The objectives of this project are to:

- Design and execute an RF characterization plan for a mmWave radar radome
- Evaluate candidate radome materials using analytic electromagnetic models
- Select a robust radome thickness based on quantitative KPIs
- Verify frequency-domain performance across the operating band
- Assess sensitivity to realistic manufacturing tolerance
- Establish a scalable framework for higher-fidelity angular and geometric analysis

---

## Evaluation Framework

The project is structured into three evaluation levels:

### Level 1 — Analytic Baseline (Completed)
- Normal-incidence dielectric slab model
- Material screening (ABS, Polycarbonate)
- Thickness sweep and interference-order analysis
- KPI-based thickness selection
- Frequency-domain verification across 77–81 GHz
- Manufacturing tolerance sensitivity (±0.1 mm)

### Level 2 — Angular and Geometry Effects (Planned)
- Oblique-incidence modeling
- TE/TM polarization effects
- Flat plate vs spherical cap geometry comparison
- Scan-angle-dependent KPIs

### Level 3 — Full-Wave Validation (Planned)
- Full-wave electromagnetic simulation
- Validation of analytic predictions
- Higher-order electromagnetic effects

---

## Key Results (Level 1)

- A robust baseline thickness corresponding to the *n = 2* interference order was selected for both materials:
  - **ABS:** 2.228 mm  
  - **Polycarbonate:** 2.192 mm
- Frequency-domain verification confirms:
  - Center-band matching near 79 GHz
  - Predictable detuning under ±0.1 mm thickness variation
  - Worst-case insertion loss below approximately 0.3 dB across the band
- Polycarbonate exhibits slightly higher worst-case reflection and insertion loss than ABS, consistent with its higher dielectric constant.

---

## Repository Structure

    rf-radar-radome-verification/
    ├── src/
    │ ├── common/
    │ │ ├── constants.m
    │ │ ├── materials.m
    │ │ └── kpi_metrics.m
    │ │
    │ └── level1_analytic/
    │ ├── slab_model.m
    │ ├── sweep_thickness.m
    │ ├── compare_n2_n3.m
    │ └── level1b_frequency_plots.m
    │
    ├── figures/
    │ └── level1/
    │ ├── L1_ILmax_vs_t_.png
    │ ├── L1_Gmax_vs_t_.png
    │ ├── L1B_IL_vs_f_tol.png
    │ └── L1B_Gamma_vs_f_tol.png
    │
    ├── qualification/
    │ ├── System_Definition.md
    │ ├── Test_Plan.md
    │ ├── Assumptions_and_Material_Properties.md
    │ └── KPI_Summary.md
    │
    ├── report/
    │ └── RF_Radar_Radome_Characterization_Report.md
    │
    └── README.md


---

## Methodology Summary

- Analytic dielectric slab models are used to rapidly explore the radome design space.
- Performance is evaluated using worst-case KPIs across frequency and manufacturing tolerance.
- Frequency-domain plots are used to verify band centering and identify potential failure modes.
- Each evaluation level builds on validated results from the previous stage.

---

## Tools and Skills Demonstrated

- RF and microwave engineering fundamentals
- Electromagnetic wave propagation and interference
- MATLAB-based modeling and visualization
- KPI-driven design decisions
- Verification-oriented engineering workflow
- Technical documentation and reporting

---

## Project Status

- **Level 1:** Complete  
- **Level 2:** In progress  
- **Level 3:** Planned  

---

## Notes
This project emphasizes analytical clarity, robustness evaluation, and traceable engineering decisions. Mechanical, thermal, and antenna pattern effects are intentionally deferred to later design stages.

