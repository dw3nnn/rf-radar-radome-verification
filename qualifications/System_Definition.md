# System Definition  
## 77–81 GHz mmWave Radar Radome Evaluation

---

## 1. System Overview

The system under test (SUT) is a **77–81 GHz mmWave radar sensor module operating behind a dielectric radome**.
The objective of this project is to evaluate how radome material, geometry, and packaging constraints
affect RF performance at the system interface.

This work focuses on **RF transparency, robustness, and sensitivity**, rather than internal IC design.

---

## 2. Intended Use Case

- Application band: 77–81 GHz (automotive radar class)
- Deployment scenario:
  - Radar sensor mounted behind a dielectric enclosure or fascia
  - Radome is required for environmental protection and mechanical integration
- Performance priority:
  - Preserve RF performance while meeting packaging constraints

---

## 3. System Block Description

The SUT is modeled as the following functional blocks:

1. **mmWave radar sensor module**
   - Integrated transmitter, receiver, and antenna (AoP assumed)
   - Treated as a known RF source/load with small residual mismatch

2. **RF PCB**
   - Provides power and signal routing
   - RF loss and mismatch treated as fixed priors (not optimized)

3. **Radome / enclosure interface**
   - Primary variable under study
   - Defined by:
     - material dielectric properties
     - wall thickness
     - antenna-to-radome standoff
     - geometry (flat vs curved)

4. **Operating conditions**
   - Nominal and reduced supply (V-BAT scenarios)
   - Thermal environment treated as a constraint on allowable RF loss

---

## 4. Key System Interfaces

### 4.1 Antenna-to-Radome Interface
- Distance from antenna phase center to radome inner surface (D)
- Reflections at this interface can impact effective antenna matching

### 4.2 Radome Geometry
- Flat plate radome
- Spherical cap radome (to reduce effective incidence angle)

### 4.3 Material Properties
- Relative permittivity (εr)
- Loss tangent (tanδ)
- Both treated as uncertain parameters with bounded variation

---

## 5. System Inputs and Outputs

### Inputs (Design / Environmental Parameters)
- Frequency (77–81 GHz)
- Radome material (ABS, Polycarbonate)
- Radome thickness (t)
- Antenna-to-radome standoff (D)
- Angle of incidence
- Operating condition (nominal vs reduced V-BAT)

### Outputs (System Performance Metrics)
- Insertion loss across band
- Reflection magnitude across band
- Worst-case metrics over frequency
- Sensitivity to manufacturing and material variation
- Statistical pass rate under uncertainty

---

## 6. Assumptions and Simplifications

- Radome materials are non-magnetic (μr ≈ 1)
- Initial modeling assumes lossless materials to isolate reflection behavior
- Antenna mismatch is modeled using a small fixed reflection prior
- Thermal effects are treated indirectly via allowable RF loss budgets
- Results are simulation-based; physical validation is planned but not required for initial conclusions

---

## 7. Planned Validation Path

1. Analytic modeling (normal incidence)
2. Oblique-incidence and angular robustness analysis
3. Full-wave EM simulation (planned)
4. Optional hardware validation if resources permit

---

## 8. Scope Boundaries

Out of scope:
- Radar signal processing performance
- Detection algorithms
- Detailed IC-level design

In scope:
- RF interface performance
- Packaging-driven RF effects
- Robustness and tolerance analysis

---

## 9. Document Control

This system definition establishes the scope and assumptions used throughout
the evaluation and test plan.

Changes to system assumptions require re-evaluation of test results.