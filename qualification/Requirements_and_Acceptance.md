# Radar + Radome Verification Requirements and Acceptance Criteria

## Objective
Verify an aircraft-mounted radar measurement chain with a protective radome for dielectric mapping of terrain.

## Scope
- Material characterization (vendor dielectric data)
- Fresnel reflection modeling (angle dependence risk)
- Radome downselect (material/thickness) using RF transparency KPIs
- Reflection-to-dielectric inversion pipeline (calibration + plausibility checks)
- Mapping KPI evaluation and frequency retune recommendation (10–20 GHz)

## Assumptions
- Material X is lossless and non-magnetic (μr ≈ 1)
- Nominal normal incidence (θ = 0°) for mapping phase
- Measured data provides reflection coefficient Γ per pixel

## Key Verification KPIs (Acceptance Criteria)
### Radome RF Performance @ operating frequency f0
- Insertion Loss (IL): < 0.50 dB
- Power transmission T: > 0.90
- Return loss due to radome reflections: > 20 dB (equivalently |Γ| < 0.10)

### Mapping Performance
- Dielectric contrast ratio (target vs background): ≥ 0.25
- Cluster separation (Cohen’s d): ≥ 1.0
- Retune gain (10–20 GHz): ≥ 20% contrast improvement vs baseline f0

### Robustness / Quality Controls
- Non-physical inversion outliers (εr < 1, NaN, Inf): < 1% of pixels
- Report dielectric inversion sensitivity: median Δεr per 1% Γ error

## Deliverables
- KPI Summary table (measured/estimated values + pass/fail)
- Radome material downselect and recommended thickness
- Dielectric map with target region identification
- Tolerance/sensitivity analysis (thickness and angle misalignment)
