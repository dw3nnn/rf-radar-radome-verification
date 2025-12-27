# KPI Summary  
## 77–81 GHz mmWave Radar Radome Evaluation

This document summarizes the key performance indicators (KPIs) extracted from
Level 1 analytic RF characterization of candidate radome designs. All KPIs are
evaluated across the full 77–81 GHz operating band.

Worst-case values are reported where applicable to reflect system-level
robustness rather than nominal-only performance.

---

## 1. Evaluated KPIs

The following KPIs are used throughout the evaluation:

- **IL_max (dB)**  
  Worst-case insertion loss across 77–81 GHz.

- **|Γ|_max**  
  Worst-case magnitude of the reflection coefficient across 77–81 GHz.

- **IL_ripple (dB)**  
  Peak-to-peak variation of insertion loss across the band.

- **Worst-case under tolerance**  
  Maximum KPI observed when radome thickness is perturbed by ±0.1 mm from nominal.

---

## 2. Selected Baseline Thickness (n = 2)

Based on comparative evaluation of n=2 and n=3 half-wavelength solutions,
the n=2 thickness family was selected as the baseline for both materials.
Selection criteria prioritized worst-case RF performance under realistic
manufacturing tolerance.

---

## 3. KPI Summary Table (Worst-Case Under ±0.1 mm Thickness Tolerance)

| Material        | Selected Thickness t* (mm) | IL_max (dB) | |Γ|_max | IL_ripple (dB) | Notes |
|-----------------|---------------------------:|------------:|-------:|---------------:|-------|
| ABS             | 2.228                      | 0.246       | 0.235  | 0.229          | Baseline (n=2) |
| Polycarbonate   | 2.192                      | 0.271       | 0.246  | 0.250          | Baseline (n=2) |

All values represent worst-case performance observed across:
- Frequency: 77–81 GHz  
- Thickness: t* ± 0.1 mm  

---

## 4. Nominal vs Tolerance-Degraded Performance (Reference)

The table below is provided for reference to illustrate sensitivity to
manufacturing variation.

### ABS (t* = 2.228 mm)

| Condition        | IL_max (dB) | |Γ|_max | IL_ripple (dB) |
|------------------|------------:|-------:|---------------:|
| Nominal          | 0.0339      | 0.0881 | 0.0339 |
| t* − 0.1 mm      | 0.2327      | 0.2284 | 0.2100 |
| t* + 0.1 mm      | 0.2464      | 0.2349 | 0.2285 |

### Polycarbonate (t* = 2.192 mm)

| Condition        | IL_max (dB) | |Γ|_max | IL_ripple (dB) |
|------------------|------------:|-------:|---------------:|
| Nominal          | 0.0371      | 0.0923 | 0.0371 |
| t* − 0.1 mm      | 0.2514      | 0.2372 | 0.2261 |
| t* + 0.1 mm      | 0.2712      | 0.2460 | 0.2496 |

---

## 5. Design Selection Rationale

Although both n=2 and n=3 thickness families align with half-wavelength
transparency conditions, the n=2 solution demonstrated:

- Lower nominal reflection and insertion loss
- Improved worst-case KPIs under ±0.1 mm thickness variation
- Reduced radome thickness, improving packaging flexibility

As a result, the n=2 thickness family was selected as the baseline design for
subsequent angular sensitivity, robustness, and system-level evaluation.

---

## 6. Notes and Limitations

- Results are based on a normal-incidence analytic slab model.
- Dielectric loss tangent is assumed negligible at this stage to isolate
  reflection-driven behavior.
- Angular effects and material loss are addressed in subsequent analysis stages.
