# ELIXIR STEERS — Workflow comparison use case

A use case for the ELIXIR STEERS project on workflow optimisation.

## Goal

Compare two 3-step workflows that produce similar output, to determine which one is less compute-heavy.

## Workflows

Both workflows perform the same quality-control analysis, but with different tools:

- **FastQC workflow** — uses FastQC, well-established but compute-heavy.
- **Falco workflow** — uses Falco, a lighter, more resource-friendly alternative.

## Repository content

This repository contains the [Nextflow](https://www.nextflow.io/) code used to run the two workflows on the [GenOuest](https://www.genouest.org/) cluster, as well as the results.

The same workflows were also run in [Galaxy](https://galaxyproject.org/) for comparison.
