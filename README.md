# Haskell Ray Tracer

A simple ray tracer written in Haskell that renders spheres with basic shading and a gradient sky background.

## Features
- Basic **ray-sphere intersection**
- **Surface normal shading** for realistic lighting
- **Gradient background** for sky effect
- Outputs image in **PPM format**

## Installation & Usage

1. **Compile the program:**
   ```sh
   ghc -O2 Main.hs -o raytracer

2. **Run the tracer and save output**
   ```sh
    ./raytacer > image.ppm

3 **View or convert image**
   ```sh
    convert image.ppm output.png
