# Autotuning.jl Documentation

## Introduction

*Autotuning.jl    is   an    autotuning    library   written    in
[Julia](https://julialang.org/)*

Autotuning.jl requires Julia `v1.0` at least.   The objective of this library is
to provide a statistically sound method of exploring the configuration spaces of
*High-Performance   Computing*  (HPC)   programs,  such   as  machine   learning
*hyper-parameters*, compiler  *flags* and  *passes*, *High-Level  Synthesis* for
FPGAs, and *Hardware/Software Codesign*.

Autotuning.jl                              is                              [free
software](https://www.gnu.org/philosophy/free-sw.en.html),  released  under  the
[MIT license](https://spdx.org/licenses/MIT.html).

Optimizing HPC  applications involves  enormous search  spaces with  lengthy and
costly experiments.   The library  allows distributing measurement,  search, and
statistical analysis between nodes.

This library combines traditional stochastic search algorithms and statistically
designed experiments to explore complex search spaces effectively, while keeping
the  balances  needed  for  statistical  analyses.   This  enables  constraining
exploration to regions with efficient configurations as exploration progresses.

## Library Outline

```@contents
Pages = ["lib/public.md"]
```

### [Index](@id main-index)

```@index
Pages = ["lib/public.md"]
```
