# MIPS Assembly Project

This repository contains a MIPS assembly project. The main script to execute the program is `run.sh`.

## Description

A MIPS assembly program to calculate the area of a rectangle with the following rules:
- Accepts two positive numbers as input (Length and Width).
- Displays error messages for negative or zero inputs, and for equal inputs.
- Categorizes the rectangle's area:
  - "SMALL" for areas < 100
  - "MEDIUM" for areas ≤ 100 and < 500
  - "LARGE" for areas ≥ 500
- Organized with three procedures: INPUT, CALCULATE, OUTPUT.
- Includes clear instructions and comments, loops until the input `1502` is provided.

## Requirements

To run this project, you need:
- A Linux environment (e.g., WSL on Windows)
- `spim` or `QtSPIM` (MIPS simulator)

## Installation on WSL

1. Install WSL and set up a Linux distribution (e.g., Ubuntu).
   - Follow [Microsoft's guide](https://learn.microsoft.com/en-us/windows/wsl/install) if WSL is not yet installed.

2. Update your package lists:
   ```bash
   sudo apt update
   ```

3. Install `spim`:
   ```bash
   sudo apt install spim
   ```

4. Clone this repository:
   ```bash
   git clone [https://github.com/fairuztsn/coa-15.git](https://github.com/fairuztsn/coa-15.git)
   cd coa-15
   ```

5. Make the `run.sh` script executable:
   ```bash
   chmod +x run.sh
   ```

## Usage

Run the program using the following command:
```bash
./run.sh
```
