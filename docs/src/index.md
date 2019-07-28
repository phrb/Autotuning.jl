# NODAL Documentation

## Introduction

**NODAL**   is   an  **Open   Distributed   Autotuning   Library**  written   in
[Julia](https://julialang.org/).  NODAL requires Julia `v1.0` at least.  NODAL's
objective  is  to  provide  a   statistically  sound  method  of  exploring  the
configuration  spaces of  *High-Performance Computing*  (HPC) programs,  such as
machine learning *hyper-parameters*, compiler  *flags* and *passes*, *High-Level
Synthesis* for FPGAs, and *Hardware/Software Codesign*.

NODAL   is    [free   software](https://www.gnu.org/philosophy/free-sw.en.html),
released under [GPLv3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).

Optimizing HPC  applications involves  enormous search  spaces with  lengthy and
costly experiments.  NODAL  allows distributing  measurement, search, and
statistical analysis between nodes.

NODAL  combines  traditional  stochastic  search  algorithms  and  statistically
designed experiments to explore complex search spaces effectively, while keeping
the  balances  needed  for   statistical  analyses.  This  enables  constraining
exploration to regions with efficient configurations as exploration progresses.
