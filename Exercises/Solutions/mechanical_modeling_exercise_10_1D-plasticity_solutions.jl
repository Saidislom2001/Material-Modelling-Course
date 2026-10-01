### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 42b0fed2-7975-490e-b2f1-eefaf7d98d1c
using LinearAlgebra, CairoMakie

# ╔═╡ ee78e809-d606-49f9-a527-337ae5bdbbae
begin
	using PlutoUI
	TableOfContents(title="Exercise 10")
end

# ╔═╡ 4c247c28-c568-4c5c-b8c7-029c87ed5d0b
st_venant_svg="""<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="50%"
   viewBox="0 0 53.603165 9.1581297"
   version="1.1"
   id="svg1"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1">
    <pattern
       xlink:href="#ZigZag"
       preserveAspectRatio="xMidYMid"
       id="pattern16"
       patternTransform="matrix(0.01,0,0,0.00421065,0,87.269238)"
       x="0"
       y="-52" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="90"
       patternTransform="scale(0.2)"
       id="ZigZag"
       style="fill:#000000"
       x="0"
       y="0"
       preserveAspectRatio="none">
      <path
         style="opacity:1;fill-opacity:1;stroke:none;stroke-width:1;stroke-dasharray:none"
         d="M 50,90 0,40 V 10 L 50,60 100,10 V 40 L 50,90"
         id="zigzag-path-pattern" />
    </pattern>
    <pattern
       xlink:href="#Bricks"
       id="pattern10"
       patternTransform="scale(0.01)"
       x="0"
       y="0"
       preserveAspectRatio="none" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="100"
       id="Bricks"
       style="fill:#000000"
       patternTransform="scale(0.25,0.25)">
      <g
         id="g13367">
        <rect
           style="fill:none;stroke:none;stroke-width:0"
           id="rect13349"
           width="100"
           height="100"
           x="0"
           y="0" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13351"
           width="40"
           height="40"
           x="0"
           y="60" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13353"
           width="90"
           height="40"
           x="0"
           y="10" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13355"
           width="50"
           height="40"
           x="50"
           y="60" />
      </g>
    </pattern>
  </defs>
  <g
     id="layer1"
     transform="translate(-79.915522,-142.16688)">
    <g
       id="g5">
      <g
         id="g4"
         transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)" />
      <g
         id="g6">
        <g
           id="g14">
          <g
             id="g7">
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.377349;stroke-linecap:round;stroke-dasharray:none"
               d="M 80.104192,148.94465 104.274,148.945"
               id="path2" />
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 110.89293,148.94445 h 22.45725"
               id="path2-5" />
            <rect
               style="fill:url(#pattern10);fill-opacity:1;stroke:#000000;stroke-width:0.389;stroke-linecap:round"
               id="rect4"
               width="6.4423723"
               height="3.6642659"
               x="104.4685"
               y="147.05753" />
            <path
               style="fill:none;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 101.21619,151.1565 h 12.49295"
               id="path10" />
            <rect
               style="fill:url(#pattern16);fill-opacity:1;stroke:none;stroke-width:0.218678;stroke-linecap:round;stroke-dasharray:none"
               id="rect10"
               width="6.5019155"
               height="0.35084185"
               x="104.43616"
               y="150.7411" />
          </g>
        </g>
        <text
           xml:space="preserve"
           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.367001;stroke-linecap:round"
           x="112.71535"
           y="146.61807"
           id="text1"><tspan
             id="tspan1"
             style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:Serif;-inkscape-font-specification:Serif;fill:#000000;fill-opacity:1;stroke-width:0.367"
             x="112.71535"
             y="146.61807">σ<tspan
   style="font-size:65%;baseline-shift:super"
   id="tspan2">Y</tspan></tspan></text>
      </g>
    </g>
  </g>
</svg>
""";

# ╔═╡ b490d6f2-4702-43ff-8b2a-04c9e11047f7
prandtl_svg="""<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="107.42765mm"
   height="22.400248mm"
   viewBox="0 0 107.42765 22.400248"
   version="1.1"
   id="svg1"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1">
    <pattern
       xlink:href="#ZigZag"
       preserveAspectRatio="xMidYMid"
       id="pattern16"
       patternTransform="matrix(0.01,0,0,0.00421065,0,87.269238)"
       x="0"
       y="-52" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="90"
       patternTransform="scale(0.2)"
       id="ZigZag"
       style="fill:#000000"
       x="0"
       y="0"
       preserveAspectRatio="none">
      <path
         style="opacity:1;fill-opacity:1;stroke:none;stroke-width:1;stroke-dasharray:none"
         d="M 50,90 0,40 V 10 L 50,60 100,10 V 40 L 50,90"
         id="zigzag-path-pattern" />
    </pattern>
    <pattern
       xlink:href="#Bricks"
       id="pattern10"
       patternTransform="scale(0.01)"
       x="0"
       y="0"
       preserveAspectRatio="none" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="100"
       id="Bricks"
       style="fill:#000000"
       patternTransform="scale(0.25,0.25)">
      <g
         id="g13367">
        <rect
           style="fill:none;stroke:none;stroke-width:0"
           id="rect13349"
           width="100"
           height="100"
           x="0"
           y="0" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13351"
           width="40"
           height="40"
           x="0"
           y="60" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13353"
           width="90"
           height="40"
           x="0"
           y="10" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13355"
           width="50"
           height="40"
           x="50"
           y="60" />
      </g>
    </pattern>
  </defs>
  <g
     id="layer1"
     transform="translate(-26.091027,-135.14112)">
    <g
       id="g5">
      <g
         id="g6">
        <g
           id="g14">
          <g
             id="g7">
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.377349;stroke-linecap:round;stroke-dasharray:none"
               d="M 80.104192,148.94465 104.274,148.945"
               id="path2" />
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 110.89293,148.94445 h 22.45725"
               id="path2-5" />
            <rect
               style="fill:url(#pattern10);fill-opacity:1;stroke:#000000;stroke-width:0.389;stroke-linecap:round"
               id="rect4"
               width="6.4423723"
               height="3.6642659"
               x="104.4685"
               y="147.05753" />
            <path
               style="fill:none;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 101.21619,151.1565 h 12.49295"
               id="path10" />
            <rect
               style="fill:url(#pattern16);fill-opacity:1;stroke:none;stroke-width:0.218678;stroke-linecap:round;stroke-dasharray:none"
               id="rect10"
               width="6.5019155"
               height="0.35084185"
               x="104.43616"
               y="150.7411" />
            <g
               id="g5-2"
               transform="translate(-53.48934,3.5696381e-4)">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.366748;stroke-linecap:round"
                 d="m 79.763741,148.94465 h 8.432882"
                 id="path2-54" />
              <g
                 id="g4-0"
                 transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)">
                <g
                   id="g3">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4" />
                </g>
                <g
                   id="g3-6"
                   transform="rotate(180,103.03614,174.15805)">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2-1" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4-0" />
                </g>
              </g>
              <g
                 id="g4-5"
                 transform="matrix(0.87014747,0,0,1.0015541,17.083963,-25.497552)">
                <g
                   id="g3-4">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2-7" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4-6" />
                </g>
                <g
                   id="g3-6-5"
                   transform="rotate(180,103.03614,174.15805)">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2-1-6" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4-0-9" />
                </g>
              </g>
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.366748;stroke-linecap:round"
                 d="m 125.3052,148.94445 h 8.43293"
                 id="path2-5-5" />
              <g
                 id="g4-5-5"
                 transform="matrix(0.87014747,0,0,1.0015541,29.437447,-25.497552)">
                <g
                   id="g3-4-2">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2-7-5" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4-6-4" />
                </g>
                <g
                   id="g3-6-5-7"
                   transform="rotate(180,103.03614,174.15805)">
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 95.937144,174.15126 4.845666,-8.39294"
                     id="path2-2-1-6-4" />
                  <path
                     style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                     d="m 103.29695,175.1268 -2.50831,-9.3611"
                     id="path2-2-4-0-9-4" />
                </g>
              </g>
            </g>
            <text
               xml:space="preserve"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:Serif;-inkscape-font-specification:Serif;fill:none;stroke:none;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               x="65.063843"
               y="138.8461"
               id="text16"><tspan
                 style="stroke-width:0.337"
                 x="65.063843"
                 y="138.8461"
                 id="tspan17">E</tspan></text>
            <text
               xml:space="preserve"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;line-height:0;font-family:Sans;-inkscape-font-specification:Sans;fill:none;stroke:none;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               x="64.610863"
               y="138.6675"
               id="text18"><tspan
                 id="tspan18"
                 style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:0;font-family:Sans;-inkscape-font-specification:Sans;stroke-width:0.337"
                 x="64.610863"
                 y="138.6675">E</tspan></text>
            <text
               xml:space="preserve"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;line-height:0;font-family:Sans;-inkscape-font-specification:Sans;fill:none;stroke:none;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               x="66.387482"
               y="136.61278"
               id="text19"><tspan
                 id="tspan19"
                 style="stroke-width:0.337"
                 x="66.387482"
                 y="136.61278" /></text>
            <text
               xml:space="preserve"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;line-height:0;font-family:'Noto Color Emoji';-inkscape-font-specification:'Noto Color Emoji';fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none;stroke-opacity:1"
               x="64.204643"
               y="139.70041"
               id="text20"><tspan
                 id="tspan20"
                 style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-opacity:1"
                 x="64.204643"
                 y="139.70041">E</tspan></text>
          </g>
        </g>
        <text
           xml:space="preserve"
           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:none;stroke:#000000;stroke-width:0.367001;stroke-linecap:round"
           x="112.71535"
           y="146.61807"
           id="text1"><tspan
             id="tspan1"
             style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:Serif;-inkscape-font-specification:Serif;fill:#000000;fill-opacity:1;stroke-width:0.367"
             x="112.71535"
             y="146.61807">σ<tspan
   style="font-size:65%;baseline-shift:super"
   id="tspan21">Y</tspan></tspan></text>
      </g>
    </g>
  </g>
</svg>
""";

# ╔═╡ f56ec812-09f9-4819-81d9-aa6ed22a3bfa
md"""
# Mechanical Modeling of Materials – 1D Plasticity
"""

# ╔═╡ 6803190f-e300-402c-aece-35afb5052264
abstract type Abstract1DPlasticity end

# ╔═╡ 41e33398-533a-49b8-8912-e58dc793fabb
abstract type Abstract1DPlasticityState end

# ╔═╡ 0c70529b-5b9f-4e2c-ae15-cdfae29807df
load_time = 0:0.001:1;

# ╔═╡ bdb8156b-1a6d-4e96-8c31-d343e9db9d0e
constant_load(amp::Float64) = t::Float64 -> amp;

# ╔═╡ 802d221a-b2d6-4875-b5a3-7d36e2ab4bc6
linear_load(slope::Float64,x0::Float64) = t::Float64 -> x0 + slope * t;

# ╔═╡ f1b75c44-c920-41d0-b17d-206c8f1331f4
sin_load(f::Float64,amp::Float64) = t::Float64 -> amp * sin(f*t);

# ╔═╡ f1cfcf53-d8d4-4c46-ab2b-71c55e23ec17
md"### The St. Venant Element"

# ╔═╡ 5a3edf07-b6a3-43c0-ab8b-13574fdb0739
HTML(st_venant_svg)

# ╔═╡ 92b6c5b0-d373-4c91-ab32-09c5aa016c77
md"""
The St. Venant element can be visualized as a brick which slides on a surface. At a particular threshold force, the brick will start to move. And when the applied force goes below this value, the block stops moving.
So the St. Venant element behaves like a rigid body when the stress applied is below the threshold stress.
```math
	\dot{\varepsilon}^{p} = \begin{cases}
		\dot{\varepsilon} \quad : \sigma \geq \sigma^{y} \\
		0 \quad : \sigma \leq \sigma^{y}
	\end{cases}
```
"""

# ╔═╡ 024edc8b-2d76-4be4-8860-2494034ceb29
md"""
This element, when used alone doesn't make much sense, since the plastic strain will always be the full strain. For it to have a meaningful purpose, it should be used in combination with other rheological elements.
"""

# ╔═╡ 9a8b112b-32e9-4441-83c3-6d5cc9e3cd7e
struct StVenant <: Abstract1DPlasticity
	σy::Float64
end

# ╔═╡ 8e7b53f1-489c-4906-966d-05a5083d0035
struct StVenantState <: Abstract1DPlasticityState
	εp::Float64
end

# ╔═╡ 1edec6cd-dbd9-4476-9951-68f9d09ac47b
function rheological_model(n::Integer, t::StepRangeLen, ε::Vector{Float64}, σ::Function, material::StVenant, state::StVenantState)
	
	return missing
end;

# ╔═╡ 3e24181b-58fe-4d01-b462-e111d1631a76
md"""
### The Prandtl Body
"""

# ╔═╡ 62472996-ed72-4ec0-9f67-8ef5e53e724a
HTML(prandtl_svg)

# ╔═╡ c891a0eb-ff8e-444c-bfaf-9613c07d1575
md"""
The Prandtl-Body can be described by following equation
```math
	\varepsilon = \dfrac{\sigma}{E} + \varepsilon^{p}
```
The plastic strain $\varepsilon^{p}$ develops discontinuously and remains as a third variable in our equation. It is an *internal variable*.
"""

# ╔═╡ 2e3d306d-0d53-4ff1-b81c-a98213ce7f9b
md"#### The Plastic Algorithm"

# ╔═╡ b049ba88-534c-488c-8bbc-829dc0110266
md"""
The Prandtl model is the most basic form of an elasto-plastic material model. The algorithm for calculating the plastic deformation consists of the **Elastic Predictor** step and the **Plastic Corrector** step. In case of the Prandtl model, the so called *trial* stress is calculated by using the trial plastic strain, which is assumed to be accumulated plastic strain at the previous time step.

```math
	\varepsilon^{p,trial}_{n+1} = \varepsilon^{p}_{n}
```
```math
\sigma^{trial}_{n+1} = E (\varepsilon_{n+1} - \varepsilon^{p,trial}_{n+1})
```

where $\varepsilon_{n+1}$ is the total strain of the current load step and $\varepsilon^{p}_{n}$ is the plastic strain of the previous converged timestep. 

To check if plastic flow exists, we calculate the value of the yield function

```math
\phi^{trial} = |\sigma^{trial}_{n+1}| - \sigma^{y}.
```

If the evaluated trial yield function is greater than 0, we have an unphysical stress state and a plastic corrector step is necessary
```
	if ϕᵗʳⁱᵃˡ > 0
		Plastic Corrector Step
	else
		Elastic Step
	end
```

If we are in the plastic region, to calculate the new stress $\sigma_{n+1}$ and the new plastic strain $\varepsilon^{p}_{n+1}$, the **Plastic Corrector** Step is as follows
```math
	\sigma_{n+1} = \operatorname{sign} \sigma^{trial}_{n+1} \, \sigma^{y}
```
which holds, because the Stresses in both elements have to be the same $\sigma = \sigma^{E}=\sigma^{y}$. Similarly the elastic stress can be evaluated to be
```math
	\operatorname{sign} \sigma^{trial}_{n+1} \, \sigma^{y} = E (\varepsilon_{n+1} - \varepsilon_{n+1}^{p})
```
which we can reformulate to state an expression for the new plastic strain
```math
	\varepsilon_{n+1}^{p} = \varepsilon_{n+1} - \operatorname{sign} \sigma^{trial}_{n+1} \, \dfrac{\sigma^{y}}{E}
```

If however, we are in the **Elastic** region, i.e. Φ < 0, then the plastic strain does not change and the trial stress is the new stress
```math
	\sigma_{n+1} = \sigma^{trial}_{n+1}
```
```math
	\varepsilon^{p}_{n+1} = \varepsilon^{p,trial}_{n+1}
```
"""

# ╔═╡ e8b9a4aa-f784-4247-a6b2-bd6bfb91574f
md"""
#### Implementation of the Prandtl Model
"""

# ╔═╡ 369b8de9-ed4b-449a-bc1f-5a9e440d84d8
md"Since the plastic strain is not a model parameter, in contrast to the Youngs-Modulus E and the yield stress $\sigma^{y}$, it makes sense to create a different structure to store the value of it. Here we create the concrete type `Prandtl` to store the model parameters and the concrete type `PrandtlState` to store the plastic strain."

# ╔═╡ cf99ae1f-0e60-4a82-a1e0-bc1719ce5349
struct Prandtl <: Abstract1DPlasticity
	E::Float64
	σy::Float64
end

# ╔═╡ 8145b56b-ed08-41ec-9189-8dc60eced10b
struct PrandtlState <: Abstract1DPlasticityState
	εp::Float64
end

# ╔═╡ faf67210-7f18-11ed-0c91-81899d8bfb41
function rheological_model_σ(n::Integer, time::StepRangeLen, ε::Function, σ::Vector{Float64}, material::Prandtl, state::PrandtlState)

	# The material parameters
	E = material.E
	σy = material.σy

	# The current plastic strain
	εpₙ = state.εp
	
	# The Points in Time
	tₙ₊₁ = time[n+1]

	# The next strain step
	εₙ₊₁ = ε(tₙ₊₁)
	
	# The Elastic Predictor
	σ_trial = E * (εₙ₊₁ - εpₙ)

	# The Flow Function
	ϕ = abs(σ_trial) - σy

	# plastic corrector
	if ϕ > 0
		εpₙ₊₁ = εₙ₊₁ - sign(σ_trial) * σy / E
		σₙ₊₁ = sign(σ_trial) * σy
	else # In this case, everything stays as it is
		εpₙ₊₁ = εpₙ
		σₙ₊₁ = σ_trial
	end

	new_state = PrandtlState(εpₙ₊₁)

	return σₙ₊₁, new_state
end;

# ╔═╡ c5fccd7e-8545-4b25-a1b5-8cf61fbc9027
md"**Choose your Load Mode**"

# ╔═╡ b0e77b22-41fd-497d-ac9f-b4f860cdc4a6
@bind prandtl_load_string  Select(["Constant", "Sinus", "Linear"])

# ╔═╡ aaf5fb10-5a69-4413-8d3d-a21d0a13e978
begin
	if prandtl_load_string == "Constant"
		md"""Choose the amplitude
		$(@bind prandtl_amp NumberField(0:0.1:10,default=1))
		of the constant load
		"""
	elseif prandtl_load_string == "Sinus"
		md"""Amplitude: $(@bind prandtl_amp NumberField(0:0.1:10,default=1))
		
		Frequency: $(@bind prandtl_freq NumberField(0:0.1:10,default=1)) x π
		"""
	elseif prandtl_load_string == "Linear"
		md"""Slope: $(@bind prandtl_slope NumberField(-1000:0.1:1000,default=1))
		
		Initial Value: $(@bind prandtl_initval NumberField(-1000:0.1:1000,default=0))
		"""
	end
end

# ╔═╡ c4da69c8-2889-4bca-be08-067d6c993009
if prandtl_load_string == "Constant"
	prandtl_load = constant_load(prandtl_amp)
elseif prandtl_load_string == "Sinus"
	prandtl_load = sin_load(prandtl_freq*π,prandtl_amp)
elseif prandtl_load_string == "Linear"
	prandtl_load = linear_load(prandtl_slope,prandtl_initval)
end;

# ╔═╡ 47869642-f7e4-41f9-8dee-802215e6effa
md"### Extended St. Venant Body"

# ╔═╡ 8e5f0047-c130-47b4-b0ca-9632178c87c5
st_venant_parallel_hooke_svg="""
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="60%"
   viewBox="0 0 87.191254 42.089504"
   version="1.1"
   id="svg1"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1">
    <pattern
       xlink:href="#ZigZag"
       preserveAspectRatio="xMidYMid"
       id="pattern16"
       patternTransform="matrix(0.01,0,0,0.00421065,0,87.269238)"
       x="0"
       y="-52" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="90"
       patternTransform="scale(0.2)"
       id="ZigZag"
       style="fill:#000000"
       x="0"
       y="0"
       preserveAspectRatio="none">
      <path
         style="opacity:1;fill-opacity:1;stroke:none;stroke-width:1;stroke-dasharray:none"
         d="M 50,90 0,40 V 10 L 50,60 100,10 V 40 L 50,90"
         id="zigzag-path-pattern" />
    </pattern>
    <pattern
       xlink:href="#Bricks"
       id="pattern10"
       patternTransform="scale(0.01)"
       x="0"
       y="0"
       preserveAspectRatio="none" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="100"
       id="Bricks"
       style="fill:#000000"
       patternTransform="scale(0.25,0.25)">
      <g
         id="g13367">
        <rect
           style="fill:none;stroke:none;stroke-width:0"
           id="rect13349"
           width="100"
           height="100"
           x="0"
           y="0" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13351"
           width="40"
           height="40"
           x="0"
           y="60" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13353"
           width="90"
           height="40"
           x="0"
           y="10" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13355"
           width="50"
           height="40"
           x="50"
           y="60" />
      </g>
    </pattern>
  </defs>
  <g
     id="layer1"
     transform="translate(-63.493314,-142.16688)">
    <g
       id="g5">
      <g
         id="g4"
         transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)" />
      <g
         id="g6">
        <g
           id="g8">
          <g
             id="g14">
            <g
               id="g7">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.377349;stroke-linecap:round;stroke-dasharray:none"
                 d="M 80.104192,148.94465 104.274,148.945"
                 id="path2" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 d="M 110.89293,148.94445 134.074,148.944"
                 id="path2-5" />
              <rect
                 style="fill:url(#pattern10);fill-opacity:1;stroke:#000000;stroke-width:0.389;stroke-linecap:round"
                 id="rect4"
                 width="6.4423723"
                 height="3.6642659"
                 x="104.4685"
                 y="147.05753" />
              <path
                 style="fill:none;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 d="m 101.21619,151.1565 h 12.49295"
                 id="path10" />
              <rect
                 style="fill:url(#pattern16);fill-opacity:1;stroke:none;stroke-width:0.218678;stroke-linecap:round;stroke-dasharray:none"
                 id="rect10"
                 width="6.5019155"
                 height="0.35084185"
                 x="104.43616"
                 y="150.7411" />
            </g>
          </g>
          <text
             xml:space="preserve"
             style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.367001;stroke-linecap:round"
             x="112.71535"
             y="146.61807"
             id="text1"><tspan
               id="tspan1"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:Serif;-inkscape-font-specification:Serif;fill:#000000;fill-opacity:1;stroke-width:0.367"
               x="112.71535"
               y="146.61807">σ<tspan
   style="font-size:65%;baseline-shift:super"
   id="tspan2">Y</tspan></tspan></text>
          <g
             id="g5-9"
             transform="translate(0.335633,26.715361)">
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.366748;stroke-linecap:round"
               d="m 79.763741,148.94465 h 8.432882"
               id="path2-1" />
            <g
               id="g4-9"
               transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)">
              <g
                 id="g3">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4" />
              </g>
              <g
                 id="g3-6"
                 transform="rotate(180,103.03614,174.15805)">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0" />
              </g>
            </g>
            <g
               id="g4-5"
               transform="matrix(0.87014747,0,0,1.0015541,17.083963,-25.497552)">
              <g
                 id="g3-4">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-7" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-6" />
              </g>
              <g
                 id="g3-6-5"
                 transform="rotate(180,103.03614,174.15805)">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1-6" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0-9" />
              </g>
            </g>
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.366748;stroke-linecap:round"
               d="m 125.3052,148.94445 8.43317,1.9e-4"
               id="path2-5-6" />
            <g
               id="g4-5-5"
               transform="matrix(0.87014747,0,0,1.0015541,29.437447,-25.497552)">
              <g
                 id="g3-4-2">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-7-5" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-6-4" />
              </g>
              <g
                 id="g3-6-5-7"
                 transform="rotate(180,103.03614,174.15805)">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1-6-4" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.392857;stroke-linecap:round"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0-9-4" />
              </g>
            </g>
          </g>
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round"
             d="M 134.074,148.944 V 175.66"
             id="path3" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round"
             d="m 80.0845,148.9435 v 26.716"
             id="path3-8" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round"
             d="m 134.2425,161.3185 h 16.27357"
             id="path4" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round"
             d="m 63.661815,160.77058 h 16.27357"
             id="path4-6" />
          <text
             xml:space="preserve"
             style="font-size:4.9389px;line-height:0;font-family:'Noto Color Emoji';-inkscape-font-specification:'Noto Color Emoji';fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round"
             x="118.11867"
             y="166.21107"
             id="text4"><tspan
               id="tspan4"
               style="stroke-width:0.337"
               x="118.11867"
               y="166.21107">E</tspan></text>
        </g>
      </g>
    </g>
  </g>
</svg>
""";

# ╔═╡ d1f00b47-b276-4ef0-90e7-692640411fa9
HTML(st_venant_parallel_hooke_svg)

# ╔═╡ ab42f340-38a0-4f6f-a9df-b6b49f6be6fa
md"""
The Flow-Function and the Flow-Criterion are
```math
\phi = |\sigma - E\varepsilon| - \sigma^{y} \leq 0
```
The strain can be calculated as 
```math
\varepsilon = \dfrac{1}{E}(\sigma - \operatorname{sign} \sigma \, \sigma^{y})
```
And again: We need to utilize the Plastic-Algorithm to be able to use this model.
"""

# ╔═╡ 746e609a-a2e5-4c23-a58d-c7d87e4e2186
struct StVenantExt <: Abstract1DPlasticity
	E::Float64
	σy::Float64
end

# ╔═╡ 21df52be-fd42-4084-ac95-952c101541be
struct StVenantExtState <: Abstract1DPlasticityState 
	εp::Float64
end

# ╔═╡ 27b10729-05ad-4dc2-9c84-c3960857deea
function rheological_model_ε(n::Integer, time::StepRangeLen, σ::Function, ε::Vector{Float64}, material::StVenantExt, state::StVenantExtState)

	E = material.E
	σy = material.σy

	tₙ₊₁ = time[n+1]
	σₙ₊₁ = σ(tₙ₊₁)
	εpₙ = state.εp

	Φ_trial = abs(σₙ₊₁ - E*εpₙ) - σy

	if Φ_trial > 0
		εₙ₊₁ = (σₙ₊₁ - sign(σₙ₊₁) * σy) / E
	else
		εₙ₊₁ = εpₙ
	end
	
	stateₙ₊₁ = StVenantExtState(εₙ₊₁)

	return εₙ₊₁, stateₙ₊₁
end;

# ╔═╡ 655d379b-7de3-4095-87cd-a3d1d4407d24
md"**Choose your Load Mode**"

# ╔═╡ f4d9292e-0ff2-4d35-9375-529bdd3bce6c
@bind st_venant_ext_load_string  Select(["Constant", "Sinus", "Linear"])

# ╔═╡ 017dcac4-542f-4a4b-9036-1e4ff1354f29
begin
	if st_venant_ext_load_string == "Constant"
		md"""Choose the amplitude
		$(@bind st_venant_ext_amp NumberField(0:0.1:10,default=1))
		of the constant load
		"""
	elseif st_venant_ext_load_string == "Sinus"
		md"""Amplitude: $(@bind st_venant_ext_amp NumberField(0:0.1:10,default=1))
		
		Frequency: $(@bind st_venant_ext_freq NumberField(0:0.1:10,default=1)) x π
		"""
	elseif st_venant_ext_load_string == "Linear"
		md"""Slope: $(@bind st_venant_ext_slope NumberField(-1000:0.1:1000,default=1))
		
		Initial Value: $(@bind st_venant_ext_initval NumberField(-1000:0.1:1000,default=0))
		"""
	end
end

# ╔═╡ ab199495-be5e-41fd-806e-0111a3fead07
if st_venant_ext_load_string == "Constant"
	st_venant_ext_load = constant_load(st_venant_ext_amp)
elseif st_venant_ext_load_string == "Sinus"
	st_venant_ext_load = sin_load(st_venant_ext_freq*π,st_venant_ext_amp)
elseif st_venant_ext_load_string == "Linear"
	st_venant_ext_load = linear_load(st_venant_ext_slope,st_venant_ext_initval)
end;

# ╔═╡ 212bf0f8-a10c-4215-bb69-2ae48ee8cdfc
md"### Adding a Spring in Series"

# ╔═╡ 396980a4-893a-4962-8a53-c8ef2905abfe
st_venant_par_ser_hooke="""<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="80%"
   viewBox="0 0 140.98927 42.058544"
   version="1.1"
   id="svg1"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1">
    <pattern
       xlink:href="#ZigZag"
       preserveAspectRatio="xMidYMid"
       id="pattern16"
       patternTransform="matrix(0.01,0,0,0.00421065,0,87.269238)"
       x="0"
       y="-52" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="90"
       patternTransform="scale(0.2)"
       id="ZigZag"
       style="fill:#000000"
       x="0"
       y="0"
       preserveAspectRatio="none">
      <path
         style="opacity:1;fill-opacity:1;stroke:none;stroke-width:1;stroke-dasharray:none"
         d="M 50,90 0,40 V 10 L 50,60 100,10 V 40 L 50,90"
         id="zigzag-path-pattern" />
    </pattern>
    <pattern
       xlink:href="#Bricks"
       id="pattern10"
       patternTransform="scale(0.01)"
       x="0"
       y="0"
       preserveAspectRatio="none" />
    <pattern
       patternUnits="userSpaceOnUse"
       width="100"
       height="100"
       id="Bricks"
       style="fill:#000000"
       patternTransform="scale(0.25,0.25)">
      <g
         id="g13367">
        <rect
           style="fill:none;stroke:none;stroke-width:0"
           id="rect13349"
           width="100"
           height="100"
           x="0"
           y="0" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13351"
           width="40"
           height="40"
           x="0"
           y="60" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13353"
           width="90"
           height="40"
           x="0"
           y="10" />
        <rect
           style="fill-opacity:1;stroke-width:0"
           id="rect13355"
           width="50"
           height="40"
           x="50"
           y="60" />
      </g>
    </pattern>
  </defs>
  <g
     id="layer1"
     transform="translate(-21.683169,-143.91322)">
    <g
       id="g5">
      <g
         id="g4"
         transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)" />
      <g
         id="g6">
        <g
           id="g8"
           transform="translate(-41.810146,1.7313462)"
           style="stroke-width:0.337;stroke-dasharray:none">
          <g
             id="g14"
             style="stroke-width:0.337;stroke-dasharray:none">
            <g
               id="g7"
               style="stroke-width:0.337;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 d="M 80.104192,148.94465 104.274,148.945"
                 id="path2" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 d="M 110.89293,148.94445 134.074,148.944"
                 id="path2-5" />
              <rect
                 style="fill:url(#pattern10);fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 id="rect4"
                 width="6.4423723"
                 height="3.6642659"
                 x="104.4685"
                 y="147.05753" />
              <path
                 style="fill:none;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 d="m 101.21619,151.1565 h 12.49295"
                 id="path10" />
              <rect
                 style="fill:url(#pattern16);fill-opacity:1;stroke:none;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
                 id="rect10"
                 width="6.5019155"
                 height="0.35084185"
                 x="104.43616"
                 y="150.7411" />
            </g>
          </g>
          <text
             xml:space="preserve"
             style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             x="112.71535"
             y="146.61807"
             id="text1"><tspan
               id="tspan1"
               style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-family:Serif;-inkscape-font-specification:Serif;fill:#000000;fill-opacity:1;stroke-width:0.337;stroke-dasharray:none"
               x="112.71535"
               y="146.61807">σ<tspan
   style="font-size:65%;baseline-shift:super;stroke-width:0.337;stroke-dasharray:none"
   id="tspan2">Y</tspan></tspan></text>
          <g
             id="g5-9"
             transform="translate(0.335633,26.715361)"
             style="stroke-width:0.337;stroke-dasharray:none">
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 79.763741,148.94465 h 8.432882"
               id="path2-1" />
            <g
               id="g4-9"
               transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <g
                 id="g3"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4" />
              </g>
              <g
                 id="g3-6"
                 transform="rotate(180,103.03614,174.15805)"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0" />
              </g>
            </g>
            <g
               id="g4-5"
               transform="matrix(0.87014747,0,0,1.0015541,17.083963,-25.497552)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <g
                 id="g3-4"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-7" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-6" />
              </g>
              <g
                 id="g3-6-5"
                 transform="rotate(180,103.03614,174.15805)"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1-6" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0-9" />
              </g>
            </g>
            <path
               style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
               d="m 125.3052,148.94445 8.43317,1.9e-4"
               id="path2-5-6" />
            <g
               id="g4-5-5"
               transform="matrix(0.87014747,0,0,1.0015541,29.437447,-25.497552)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <g
                 id="g3-4-2"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-7-5" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-6-4" />
              </g>
              <g
                 id="g3-6-5-7"
                 transform="rotate(180,103.03614,174.15805)"
                 style="stroke-width:0.360991;stroke-dasharray:none">
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 95.937144,174.15126 4.845666,-8.39294"
                   id="path2-2-1-6-4" />
                <path
                   style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                   d="m 103.29695,175.1268 -2.50831,-9.3611"
                   id="path2-2-4-0-9-4" />
              </g>
            </g>
          </g>
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="M 134.074,148.944 V 175.66"
             id="path3" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="m 80.0845,148.9435 v 26.716"
             id="path3-8" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="m 134.2425,161.3185 h 16.27357"
             id="path4" />
          <path
             style="fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="m 63.661815,160.77058 h 16.27357"
             id="path4-6" />
          <text
             xml:space="preserve"
             style="font-size:4.9389px;line-height:0;font-family:'Noto Color Emoji';-inkscape-font-specification:'Noto Color Emoji';fill:#000000;fill-opacity:1;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             x="118.11867"
             y="166.21107"
             id="text4"><tspan
               id="tspan4"
               style="stroke-width:0.337;stroke-dasharray:none"
               x="118.11867"
               y="166.21107">E<tspan
   style="font-size:65%;baseline-shift:sub"
   id="tspan7">A</tspan></tspan></text>
        </g>
        <g
           id="g5-5"
           transform="translate(28.765827,14.101479)"
           style="stroke-width:0.337;stroke-dasharray:none">
          <path
             style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="m 79.763741,148.94465 h 8.432882"
             id="path2-3" />
          <g
             id="g4-56"
             transform="matrix(0.87014747,0,0,1.0015541,4.7282728,-25.497218)"
             style="stroke-width:0.360991;stroke-dasharray:none">
            <g
               id="g3-2"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-9" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-1" />
            </g>
            <g
               id="g3-6-2"
               transform="rotate(180,103.03614,174.15805)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-1-7" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-0-0" />
            </g>
          </g>
          <g
             id="g4-5-9"
             transform="matrix(0.87014747,0,0,1.0015541,17.083963,-25.497552)"
             style="stroke-width:0.360991;stroke-dasharray:none">
            <g
               id="g3-4-3"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-7-6" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-6-0" />
            </g>
            <g
               id="g3-6-5-6"
               transform="rotate(180,103.03614,174.15805)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-1-6-2" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-0-9-6" />
            </g>
          </g>
          <path
             style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
             d="m 125.3052,148.94445 h 8.43293"
             id="path2-5-1" />
          <g
             id="g4-5-5-8"
             transform="matrix(0.87014747,0,0,1.0015541,29.437447,-25.497552)"
             style="stroke-width:0.360991;stroke-dasharray:none">
            <g
               id="g3-4-2-7"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-7-5-9" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-6-4-2" />
            </g>
            <g
               id="g3-6-5-7-0"
               transform="rotate(180,103.03614,174.15805)"
               style="stroke-width:0.360991;stroke-dasharray:none">
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 95.937144,174.15126 4.845666,-8.39294"
                 id="path2-2-1-6-4-2" />
              <path
                 style="fill:#000000;fill-opacity:0.0968285;stroke:#000000;stroke-width:0.360991;stroke-linecap:round;stroke-dasharray:none"
                 d="m 103.29695,175.1268 -2.50831,-9.3611"
                 id="path2-2-4-0-9-4-3" />
            </g>
          </g>
        </g>
        <text
           xml:space="preserve"
           style="font-size:4.9389px;line-height:0;font-family:'Noto Color Emoji';-inkscape-font-specification:'Noto Color Emoji';fill:#000000;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
           x="146.73779"
           y="153.3812"
           id="text3"><tspan
             id="tspan3"
             style="stroke-width:0.337"
             x="146.73779"
             y="153.3812"></tspan></text>
        <text
           xml:space="preserve"
           style="font-size:4.9389px;line-height:0;font-family:'Noto Color Emoji';-inkscape-font-specification:'Noto Color Emoji';fill:#000000;stroke:#000000;stroke-width:0.337;stroke-linecap:round;stroke-dasharray:none"
           x="146.28349"
           y="153.45987"
           id="text5"><tspan
             id="tspan5"
             style="stroke-width:0.337"
             x="146.28349"
             y="153.45987">E<tspan
   style="font-size:65%;baseline-shift:sub"
   id="tspan6">B</tspan></tspan></text>
      </g>
    </g>
  </g>
</svg>
""";

# ╔═╡ 548f6238-a0e6-45dd-ae24-ead4a1565c86
HTML(st_venant_par_ser_hooke)

# ╔═╡ 7c648cb3-7222-40ad-a189-a8ab11004d36
struct GeneralPrandtl1 <: Abstract1DPlasticity
	A::StVenantExt
	Eᴮ::Float64
end

# ╔═╡ 889432db-3904-4810-bd88-3b5fcd9afc21
struct GeneralPrandtl1State <: Abstract1DPlasticityState
	A::StVenantExtState
end

# ╔═╡ 86388abc-4e40-4d71-9d3e-d5fdbe3aa088
function rheological_model_ε(n::Integer, time::StepRangeLen, σ::Function, ε::Vector{Float64}, material::GeneralPrandtl1, state::GeneralPrandtl1State)

	# get the material parameters
	A = material.A
	Eᴮ = material.Eᴮ

	# get the state
	Astate = state.A

	# calculate the models
	εA, stateA = rheological_model_ε(n,time,σ,ε,A,Astate)
	εB = σ(time[n+1]) / Eᴮ

	# put all together
	new_ε = εA + εB
	new_state = GeneralPrandtl1State(stateA)
	
	return new_ε, new_state
end;

# ╔═╡ 7fd7a998-4374-42db-85f2-b21dfd8a5762
md"**Choose your Load Mode**"

# ╔═╡ 628ba44a-0bb7-4041-bceb-e4f5b41cd80a
@bind gen_p1_load_string  Select(["Constant", "Sinus", "Linear"])

# ╔═╡ 09e1aa2f-bff2-4744-ade5-8d138842d97b
begin
	if gen_p1_load_string == "Constant"
		md"""Choose the amplitude
		$(@bind gen_p1_amp NumberField(0:0.1:10,default=1))
		of the constant load
		"""
	elseif gen_p1_load_string == "Sinus"
		md"""Amplitude: $(@bind gen_p1_amp NumberField(0:0.1:10,default=1))
		
		Frequency: $(@bind gen_p1_freq NumberField(0:0.1:10,default=1)) x π
		"""
	elseif gen_p1_load_string == "Linear"
		md"""Slope: $(@bind gen_p1_slope NumberField(-1000:0.1:1000,default=1))
		
		Initial Value: $(@bind gen_p1_initval NumberField(-1000:0.1:1000,default=0))
		"""
	end
end

# ╔═╡ c6b71507-3bb5-47f0-85df-bf19c0765a85
if gen_p1_load_string == "Constant"
	gen_p1_load = constant_load(gen_p1_amp)
elseif gen_p1_load_string == "Sinus"
	gen_p1_load = sin_load(gen_p1_freq*π,gen_p1_amp)
elseif gen_p1_load_string == "Linear"
	gen_p1_load = linear_load(gen_p1_slope,gen_p1_initval)
end;

# ╔═╡ 5b70d61b-7874-4ec7-845b-07ab5b5213ec
function extract_plastic_strain(state::GeneralPrandtl1State)
	return state.A.εp
end;

# ╔═╡ 70527dd6-2ea5-410f-90fc-3a0e68eac7d7
function extract_plastic_strain(state::StVenantExtState)
	return state.εp
end;

# ╔═╡ f138a901-ebc1-43b1-9919-a85e576ca744
function plot_model_ε(time::StepRangeLen, σ::Function, ε₀::Float64, material::Abstract1DPlasticity,state₀::Abstract1DPlasticityState)

	# number of load steps
	N = length(time)

	# create the solution vector
	ε = zeros(N)

	# create the state vector
	state = Vector{typeof(state₀)}(undef,N)

	# initialize the first solution
	ε[1] = ε₀
	state[1] = state₀

	# calculate the solution
	for n in 1:(N-1)
		ε[n+1], state[n+1] = rheological_model_ε(n,time,σ,ε,material,state[n])
	end

	# Extract the plastic strain
	εp = [ extract_plastic_strain(state[n]) for n in 1:N ]

	#= 
		Here the plotting part begins 
	=#
	
	fig = CairoMakie.Figure()

	ax1 = CairoMakie.Axis(
		fig[1,1],
		title="Plot",
		xlabel="Time t",
		ylabel="Strain ε/Load σ"
	)

	ax2 = CairoMakie.Axis(
		fig[1,2],
		title="Plot",
		xlabel="Strain ε",
		ylabel="Stress σ / Plastic Strain εp"
	)

	CairoMakie.lines!(ax1,time,σ.(time),label="Load σ")
	CairoMakie.lines!(ax1,time,ε,label="ε")
	CairoMakie.lines!(ax1,time,εp,label="εp")

	CairoMakie.lines!(ax2,ε,σ.(time),label="σ")
	CairoMakie.lines!(ax2,ε,εp,label="εp")

	CairoMakie.axislegend(ax1,position=:lt)
	CairoMakie.axislegend(ax2,position=:lt)

	return fig
end;

# ╔═╡ 6ae46a0f-648c-47de-87ff-f93f02f337f4
function plot_model_σ(time::StepRangeLen, ε::Function, σ₀::Float64, material::Abstract1DPlasticity,state₀::Abstract1DPlasticityState)

	# number of load steps
	N = length(time)

	# create the solution vector
	σ = zeros(N)

	# create the state vector
	state = Vector{typeof(state₀)}(undef,N)

	# initialize the first solution
	σ[1] = σ₀
	state[1] = state₀

	# calculate the solution
	for n in 1:(N-1)
		σ[n+1], state[n+1] = rheological_model_σ(n,time,ε,σ,material,state[n])
	end

	# Extract the plastic strain
	εp = [ state[n].εp for n in 1:N ]

	#= 
		Here the plotting part begins 
	=#
	
	fig = CairoMakie.Figure()

	ax1 = CairoMakie.Axis(
		fig[1,1],
		title="Plot",
		xlabel="Time t",
		ylabel="Stress σ/Load ε"
	)

	ax2 = CairoMakie.Axis(
		fig[1,2],
		title="Plot",
		xlabel="Strain ε",
		ylabel="Stress σ"
	)

	CairoMakie.lines!(ax1,time,σ,label="σ")
	CairoMakie.lines!(ax1,time,ε.(time),label="Load ε")
	CairoMakie.lines!(ax1,time,εp,label="εp")

	CairoMakie.lines!(ax2,ε.(time),σ,label="σ")
	CairoMakie.lines!(ax2,ε.(time),εp,label="εp")

	CairoMakie.axislegend(ax1,position=:lt)
	CairoMakie.axislegend(ax2,position=:lt)

	return fig
end;

# ╔═╡ 7ea1a9ca-8c49-48c0-b583-72da163f7112
par_spring = """<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="170.477" height="77.913" viewBox="0 0 170.477 77.913">
<defs>
<g>
<g id="glyph-0-0">
</g>
<g id="glyph-0-1">
<path d="M 7.0625 -2.328125 C 7.078125 -2.375 7.109375 -2.4375 7.109375 -2.46875 C 7.109375 -2.46875 7.109375 -2.578125 6.984375 -2.578125 C 6.890625 -2.578125 6.875 -2.515625 6.859375 -2.453125 C 6.203125 -0.984375 5.84375 -0.3125 4.140625 -0.3125 L 2.6875 -0.3125 C 2.546875 -0.3125 2.515625 -0.3125 2.46875 -0.3125 C 2.359375 -0.328125 2.328125 -0.34375 2.328125 -0.421875 C 2.328125 -0.453125 2.328125 -0.46875 2.375 -0.640625 L 3.0625 -3.375 L 4.046875 -3.375 C 4.890625 -3.375 4.890625 -3.15625 4.890625 -2.90625 C 4.890625 -2.84375 4.890625 -2.71875 4.828125 -2.421875 C 4.8125 -2.375 4.796875 -2.34375 4.796875 -2.3125 C 4.796875 -2.265625 4.828125 -2.203125 4.921875 -2.203125 C 5 -2.203125 5.03125 -2.25 5.078125 -2.40625 L 5.640625 -4.734375 C 5.640625 -4.796875 5.59375 -4.84375 5.515625 -4.84375 C 5.4375 -4.84375 5.40625 -4.78125 5.390625 -4.671875 C 5.171875 -3.90625 5 -3.671875 4.078125 -3.671875 L 3.140625 -3.671875 L 3.734375 -6.078125 C 3.828125 -6.4375 3.84375 -6.46875 4.28125 -6.46875 L 5.6875 -6.46875 C 6.890625 -6.46875 7.203125 -6.1875 7.203125 -5.359375 C 7.203125 -5.125 7.203125 -5.109375 7.15625 -4.828125 C 7.15625 -4.78125 7.140625 -4.703125 7.140625 -4.65625 C 7.140625 -4.609375 7.171875 -4.53125 7.265625 -4.53125 C 7.375 -4.53125 7.390625 -4.59375 7.40625 -4.78125 L 7.609375 -6.515625 C 7.640625 -6.78125 7.59375 -6.78125 7.34375 -6.78125 L 2.296875 -6.78125 C 2.109375 -6.78125 2 -6.78125 2 -6.578125 C 2 -6.46875 2.09375 -6.46875 2.28125 -6.46875 C 2.65625 -6.46875 2.9375 -6.46875 2.9375 -6.296875 C 2.9375 -6.25 2.9375 -6.234375 2.875 -6.046875 L 1.5625 -0.78125 C 1.46875 -0.390625 1.453125 -0.3125 0.65625 -0.3125 C 0.484375 -0.3125 0.375 -0.3125 0.375 -0.125 C 0.375 0 0.46875 0 0.65625 0 L 5.828125 0 C 6.0625 0 6.078125 -0.015625 6.140625 -0.171875 Z M 7.0625 -2.328125 "/>
</g>
<g id="glyph-0-2">
<path d="M 5.15625 -3.71875 C 5.296875 -3.71875 5.65625 -3.71875 5.65625 -4.0625 C 5.65625 -4.296875 5.4375 -4.296875 5.265625 -4.296875 L 2.984375 -4.296875 C 1.484375 -4.296875 0.375 -2.65625 0.375 -1.46875 C 0.375 -0.59375 0.96875 0.109375 1.875 0.109375 C 3.046875 0.109375 4.375 -1.09375 4.375 -2.625 C 4.375 -2.796875 4.375 -3.28125 4.0625 -3.71875 Z M 1.890625 -0.109375 C 1.390625 -0.109375 1 -0.46875 1 -1.1875 C 1 -1.484375 1.109375 -2.296875 1.46875 -2.890625 C 1.890625 -3.578125 2.484375 -3.71875 2.828125 -3.71875 C 3.65625 -3.71875 3.734375 -3.0625 3.734375 -2.75 C 3.734375 -2.28125 3.53125 -1.46875 3.203125 -0.953125 C 2.8125 -0.375 2.265625 -0.109375 1.890625 -0.109375 Z M 1.890625 -0.109375 "/>
</g>
<g id="glyph-1-0">
</g>
<g id="glyph-1-1">
<path d="M 2.328125 -4.4375 C 2.328125 -4.625 2.328125 -4.625 2.125 -4.625 C 1.671875 -4.1875 1.046875 -4.1875 0.765625 -4.1875 L 0.765625 -3.9375 C 0.921875 -3.9375 1.390625 -3.9375 1.765625 -4.125 L 1.765625 -0.578125 C 1.765625 -0.34375 1.765625 -0.25 1.078125 -0.25 L 0.8125 -0.25 L 0.8125 0 C 0.9375 0 1.796875 -0.03125 2.046875 -0.03125 C 2.265625 -0.03125 3.140625 0 3.296875 0 L 3.296875 -0.25 L 3.03125 -0.25 C 2.328125 -0.25 2.328125 -0.34375 2.328125 -0.578125 Z M 2.328125 -4.4375 "/>
</g>
<g id="glyph-1-2">
<path d="M 3.515625 -1.265625 L 3.28125 -1.265625 C 3.265625 -1.109375 3.1875 -0.703125 3.09375 -0.640625 C 3.046875 -0.59375 2.515625 -0.59375 2.40625 -0.59375 L 1.125 -0.59375 C 1.859375 -1.234375 2.109375 -1.4375 2.515625 -1.765625 C 3.03125 -2.171875 3.515625 -2.609375 3.515625 -3.265625 C 3.515625 -4.109375 2.78125 -4.625 1.890625 -4.625 C 1.03125 -4.625 0.4375 -4.015625 0.4375 -3.375 C 0.4375 -3.03125 0.734375 -2.984375 0.8125 -2.984375 C 0.96875 -2.984375 1.171875 -3.109375 1.171875 -3.359375 C 1.171875 -3.484375 1.125 -3.734375 0.765625 -3.734375 C 0.984375 -4.21875 1.453125 -4.375 1.78125 -4.375 C 2.484375 -4.375 2.84375 -3.828125 2.84375 -3.265625 C 2.84375 -2.65625 2.40625 -2.1875 2.1875 -1.9375 L 0.515625 -0.265625 C 0.4375 -0.203125 0.4375 -0.1875 0.4375 0 L 3.3125 0 Z M 3.515625 -1.265625 "/>
</g>
<g id="glyph-2-0">
</g>
<g id="glyph-2-1">
<path d="M 3.875 -2.625 C 3.90625 -2.71875 3.90625 -2.734375 3.90625 -2.78125 C 3.90625 -2.921875 3.796875 -3 3.671875 -3 C 3.59375 -3 3.46875 -2.96875 3.390625 -2.84375 C 3.359375 -2.796875 3.3125 -2.578125 3.28125 -2.4375 L 3.125 -1.859375 C 3.09375 -1.6875 2.875 -0.8125 2.84375 -0.734375 C 2.84375 -0.734375 2.53125 -0.125 2 -0.125 C 1.515625 -0.125 1.515625 -0.578125 1.515625 -0.703125 C 1.515625 -1.078125 1.671875 -1.515625 1.890625 -2.0625 C 1.96875 -2.28125 2 -2.359375 2 -2.484375 C 2 -2.8125 1.71875 -3.078125 1.34375 -3.078125 C 0.640625 -3.078125 0.328125 -2.125 0.328125 -2 C 0.328125 -1.921875 0.421875 -1.921875 0.453125 -1.921875 C 0.546875 -1.921875 0.546875 -1.953125 0.578125 -2.03125 C 0.75 -2.609375 1.046875 -2.875 1.328125 -2.875 C 1.4375 -2.875 1.5 -2.796875 1.5 -2.640625 C 1.5 -2.46875 1.4375 -2.328125 1.40625 -2.234375 C 1.0625 -1.375 1 -1.125 1 -0.8125 C 1 -0.703125 1 -0.375 1.265625 -0.140625 C 1.484375 0.03125 1.78125 0.0625 1.96875 0.0625 C 2.25 0.0625 2.5 -0.03125 2.71875 -0.25 C 2.640625 0.140625 2.5625 0.4375 2.265625 0.78125 C 2.078125 1 1.796875 1.21875 1.421875 1.21875 C 1.375 1.21875 1.046875 1.21875 0.90625 1 C 1.28125 0.953125 1.28125 0.625 1.28125 0.609375 C 1.28125 0.390625 1.078125 0.34375 1.015625 0.34375 C 0.84375 0.34375 0.609375 0.484375 0.609375 0.8125 C 0.609375 1.15625 0.9375 1.421875 1.4375 1.421875 C 2.140625 1.421875 3 0.875 3.21875 0 Z M 3.875 -2.625 "/>
</g>
</g>
<clipPath id="clip-0">
<path clip-rule="nonzero" d="M 106.5 58.984375 L 108.59375 58.984375 L 108.59375 59.582031 L 106.5 59.582031 Z M 106.5 58.984375 "/>
</clipPath>
<clipPath id="clip-1">
<path clip-rule="nonzero" d="M 106.601562 58.984375 L 111.582031 58.984375 L 111.582031 59.582031 L 106.601562 59.582031 Z M 106.601562 58.984375 "/>
</clipPath>
<clipPath id="clip-2">
<path clip-rule="nonzero" d="M 109.589844 58.984375 L 114.570312 58.984375 L 114.570312 59.582031 L 109.589844 59.582031 Z M 109.589844 58.984375 "/>
</clipPath>
<clipPath id="clip-3">
<path clip-rule="nonzero" d="M 112.578125 58.984375 L 117.5625 58.984375 L 117.5625 59.582031 L 112.578125 59.582031 Z M 112.578125 58.984375 "/>
</clipPath>
<clipPath id="clip-4">
<path clip-rule="nonzero" d="M 115.566406 58.984375 L 120.550781 58.984375 L 120.550781 59.582031 L 115.566406 59.582031 Z M 115.566406 58.984375 "/>
</clipPath>
<clipPath id="clip-5">
<path clip-rule="nonzero" d="M 118.558594 58.984375 L 120.671875 58.984375 L 120.671875 59.582031 L 118.558594 59.582031 Z M 118.558594 58.984375 "/>
</clipPath>
<clipPath id="clip-6">
<path clip-rule="nonzero" d="M 106.5 56.746094 L 108.59375 56.746094 L 108.59375 59.582031 L 106.5 59.582031 Z M 106.5 56.746094 "/>
</clipPath>
<clipPath id="clip-7">
<path clip-rule="nonzero" d="M 106.601562 56.746094 L 111.582031 56.746094 L 111.582031 59.582031 L 106.601562 59.582031 Z M 106.601562 56.746094 "/>
</clipPath>
<clipPath id="clip-8">
<path clip-rule="nonzero" d="M 109.589844 56.746094 L 114.570312 56.746094 L 114.570312 59.582031 L 109.589844 59.582031 Z M 109.589844 56.746094 "/>
</clipPath>
<clipPath id="clip-9">
<path clip-rule="nonzero" d="M 112.578125 56.746094 L 117.5625 56.746094 L 117.5625 59.582031 L 112.578125 59.582031 Z M 112.578125 56.746094 "/>
</clipPath>
<clipPath id="clip-10">
<path clip-rule="nonzero" d="M 115.566406 56.746094 L 120.550781 56.746094 L 120.550781 59.582031 L 115.566406 59.582031 Z M 115.566406 56.746094 "/>
</clipPath>
<clipPath id="clip-11">
<path clip-rule="nonzero" d="M 118.558594 56.746094 L 120.671875 56.746094 L 120.671875 59.582031 L 118.558594 59.582031 Z M 118.558594 56.746094 "/>
</clipPath>
<clipPath id="clip-12">
<path clip-rule="nonzero" d="M 106.5 56.746094 L 108.59375 56.746094 L 108.59375 57.988281 L 106.5 57.988281 Z M 106.5 56.746094 "/>
</clipPath>
<clipPath id="clip-13">
<path clip-rule="nonzero" d="M 106.601562 56.746094 L 111.582031 56.746094 L 111.582031 57.988281 L 106.601562 57.988281 Z M 106.601562 56.746094 "/>
</clipPath>
<clipPath id="clip-14">
<path clip-rule="nonzero" d="M 109.589844 56.746094 L 114.570312 56.746094 L 114.570312 57.988281 L 109.589844 57.988281 Z M 109.589844 56.746094 "/>
</clipPath>
<clipPath id="clip-15">
<path clip-rule="nonzero" d="M 112.578125 56.746094 L 117.5625 56.746094 L 117.5625 57.988281 L 112.578125 57.988281 Z M 112.578125 56.746094 "/>
</clipPath>
<clipPath id="clip-16">
<path clip-rule="nonzero" d="M 115.566406 56.746094 L 120.550781 56.746094 L 120.550781 57.988281 L 115.566406 57.988281 Z M 115.566406 56.746094 "/>
</clipPath>
<clipPath id="clip-17">
<path clip-rule="nonzero" d="M 118.558594 56.746094 L 120.671875 56.746094 L 120.671875 57.988281 L 118.558594 57.988281 Z M 118.558594 56.746094 "/>
</clipPath>
<clipPath id="clip-18">
<path clip-rule="nonzero" d="M 141 31 L 170.476562 31 L 170.476562 32 L 141 32 Z M 141 31 "/>
</clipPath>
</defs>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 0.00021875 0.001625 L 28.347875 0.001625 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 0.001625 L 28.347875 28.345375 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 28.345375 L 56.695531 28.345375 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.79701" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 56.695531 28.345375 L 59.183813 30.837563 L 64.164281 25.857094 L 69.148656 30.837563 L 74.129125 25.857094 L 79.109594 30.837563 L 84.090063 25.857094 L 89.074438 30.837563 L 94.054906 25.857094 L 99.035375 30.837563 L 104.015844 25.857094 L 108.996313 30.837563 L 111.4885 28.345375 L 113.386938 28.345375 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-1" x="79.327" y="16.405"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-1" x="86.681" y="17.9"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 113.386938 28.345375 L 141.734594 28.345375 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 28.345375 L 141.734594 0.001625 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 0.001625 L 28.347875 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 -28.346031 L 56.695531 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.79701" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 56.695531 -28.346031 L 59.183813 -25.85775 L 64.164281 -30.838219 L 69.148656 -25.85775 L 74.129125 -30.838219 L 79.109594 -25.85775 L 81.601781 -28.346031 L 85.039281 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-1" x="65.153" y="73.098"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-2" x="72.508" y="74.592"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 85.039281 -28.346031 L 99.215063 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<g clip-path="url(#clip-0)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 0.0001 L 0.000325 3.089944 M 0.000325 0.0001 L 3.090169 3.089944 " transform="matrix(1, 0, 0, -1, 104.60905, 62.96885)"/>
</g>
<g clip-path="url(#clip-1)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 0.0001 L -0.00022375 3.089944 M -0.00022375 0.0001 L 3.08962 3.089944 " transform="matrix(1, 0, 0, -1, 107.59788, 62.96885)"/>
</g>
<g clip-path="url(#clip-2)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 0.0001 L -0.0007725 3.089944 M -0.0007725 0.0001 L 3.089071 3.089944 " transform="matrix(1, 0, 0, -1, 110.58671, 62.96885)"/>
</g>
<g clip-path="url(#clip-3)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 0.0001 L -0.00132125 3.089944 M -0.00132125 0.0001 L 3.088522 3.089944 " transform="matrix(1, 0, 0, -1, 113.57554, 62.96885)"/>
</g>
<g clip-path="url(#clip-4)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 0.0001 L -0.00187 3.089944 M -0.00187 0.0001 L 3.087974 3.089944 " transform="matrix(1, 0, 0, -1, 116.56437, 62.96885)"/>
</g>
<g clip-path="url(#clip-5)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 0.0001 L 0.0014875 3.089944 M 0.0014875 0.0001 L 3.087425 3.089944 " transform="matrix(1, 0, 0, -1, 119.5532, 62.96885)"/>
</g>
<g clip-path="url(#clip-6)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 -0.00044875 L 0.000325 3.089395 M 0.000325 -0.00044875 L 3.090169 3.089395 " transform="matrix(1, 0, 0, -1, 104.60905, 59.98002)"/>
</g>
<g clip-path="url(#clip-7)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 -0.00044875 L -0.00022375 3.089395 M -0.00022375 -0.00044875 L 3.08962 3.089395 " transform="matrix(1, 0, 0, -1, 107.59788, 59.98002)"/>
</g>
<g clip-path="url(#clip-8)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 -0.00044875 L -0.0007725 3.089395 M -0.0007725 -0.00044875 L 3.089071 3.089395 " transform="matrix(1, 0, 0, -1, 110.58671, 59.98002)"/>
</g>
<g clip-path="url(#clip-9)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 -0.00044875 L -0.00132125 3.089395 M -0.00132125 -0.00044875 L 3.088522 3.089395 " transform="matrix(1, 0, 0, -1, 113.57554, 59.98002)"/>
</g>
<g clip-path="url(#clip-10)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 -0.00044875 L -0.00187 3.089395 M -0.00187 -0.00044875 L 3.087974 3.089395 " transform="matrix(1, 0, 0, -1, 116.56437, 59.98002)"/>
</g>
<g clip-path="url(#clip-11)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 -0.00044875 L 0.0014875 3.089395 M 0.0014875 -0.00044875 L 3.087425 3.089395 " transform="matrix(1, 0, 0, -1, 119.5532, 59.98002)"/>
</g>
<g clip-path="url(#clip-12)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 -0.0009975 L 0.000325 3.088846 M 0.000325 -0.0009975 L 3.090169 3.088846 " transform="matrix(1, 0, 0, -1, 104.60905, 56.99119)"/>
</g>
<g clip-path="url(#clip-13)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 -0.0009975 L -0.00022375 3.088846 M -0.00022375 -0.0009975 L 3.08962 3.088846 " transform="matrix(1, 0, 0, -1, 107.59788, 56.99119)"/>
</g>
<g clip-path="url(#clip-14)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 -0.0009975 L -0.0007725 3.088846 M -0.0007725 -0.0009975 L 3.089071 3.088846 " transform="matrix(1, 0, 0, -1, 110.58671, 56.99119)"/>
</g>
<g clip-path="url(#clip-15)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 -0.0009975 L -0.00132125 3.088846 M -0.00132125 -0.0009975 L 3.088522 3.088846 " transform="matrix(1, 0, 0, -1, 113.57554, 56.99119)"/>
</g>
<g clip-path="url(#clip-16)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 -0.0009975 L -0.00187 3.088846 M -0.00187 -0.0009975 L 3.087974 3.088846 " transform="matrix(1, 0, 0, -1, 116.56437, 56.99119)"/>
</g>
<g clip-path="url(#clip-17)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 -0.0009975 L 0.0014875 3.088846 M 0.0014875 -0.0009975 L 3.087425 3.088846 " transform="matrix(1, 0, 0, -1, 119.5532, 56.99119)"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 106.301 -28.346031 L 106.301 -25.510094 L 120.472875 -25.510094 L 120.472875 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 -28.346031 L 104.406469 -28.346031 M 108.191625 -28.346031 L 113.386938 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-2" x="101.079" y="70.892"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-2-1" x="107.129" y="66.105"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-2" x="106.772" y="73.549"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 -28.346031 L 141.734594 -28.346031 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 -28.346031 L 141.734594 0.001625 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
<g clip-path="url(#clip-18)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 0.001625 L 170.08225 0.001625 " transform="matrix(1, 0, 0, -1, 0.199, 31.236)"/>
</g>
</svg>
""";

# ╔═╡ 7ad008d4-964b-4e82-9dae-3448d1c18a95
two_svg = """<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="170.477" height="82.495" viewBox="0 0 170.477 82.495">
<defs>
<g>
<g id="glyph-0-0">
</g>
<g id="glyph-0-1">
<path d="M 7.0625 -2.328125 C 7.078125 -2.375 7.109375 -2.4375 7.109375 -2.46875 C 7.109375 -2.46875 7.109375 -2.578125 6.984375 -2.578125 C 6.890625 -2.578125 6.875 -2.515625 6.859375 -2.453125 C 6.203125 -0.984375 5.84375 -0.3125 4.140625 -0.3125 L 2.6875 -0.3125 C 2.546875 -0.3125 2.515625 -0.3125 2.46875 -0.3125 C 2.359375 -0.328125 2.328125 -0.34375 2.328125 -0.421875 C 2.328125 -0.453125 2.328125 -0.46875 2.375 -0.640625 L 3.0625 -3.375 L 4.046875 -3.375 C 4.890625 -3.375 4.890625 -3.15625 4.890625 -2.90625 C 4.890625 -2.84375 4.890625 -2.71875 4.828125 -2.421875 C 4.8125 -2.375 4.796875 -2.34375 4.796875 -2.3125 C 4.796875 -2.265625 4.828125 -2.203125 4.921875 -2.203125 C 5 -2.203125 5.03125 -2.25 5.078125 -2.40625 L 5.640625 -4.734375 C 5.640625 -4.796875 5.59375 -4.84375 5.515625 -4.84375 C 5.4375 -4.84375 5.40625 -4.78125 5.390625 -4.671875 C 5.171875 -3.90625 5 -3.671875 4.078125 -3.671875 L 3.140625 -3.671875 L 3.734375 -6.078125 C 3.828125 -6.4375 3.84375 -6.46875 4.28125 -6.46875 L 5.6875 -6.46875 C 6.890625 -6.46875 7.203125 -6.1875 7.203125 -5.359375 C 7.203125 -5.125 7.203125 -5.109375 7.15625 -4.828125 C 7.15625 -4.78125 7.140625 -4.703125 7.140625 -4.65625 C 7.140625 -4.609375 7.171875 -4.53125 7.265625 -4.53125 C 7.375 -4.53125 7.390625 -4.59375 7.40625 -4.78125 L 7.609375 -6.515625 C 7.640625 -6.78125 7.59375 -6.78125 7.34375 -6.78125 L 2.296875 -6.78125 C 2.109375 -6.78125 2 -6.78125 2 -6.578125 C 2 -6.46875 2.09375 -6.46875 2.28125 -6.46875 C 2.65625 -6.46875 2.9375 -6.46875 2.9375 -6.296875 C 2.9375 -6.25 2.9375 -6.234375 2.875 -6.046875 L 1.5625 -0.78125 C 1.46875 -0.390625 1.453125 -0.3125 0.65625 -0.3125 C 0.484375 -0.3125 0.375 -0.3125 0.375 -0.125 C 0.375 0 0.46875 0 0.65625 0 L 5.828125 0 C 6.0625 0 6.078125 -0.015625 6.140625 -0.171875 Z M 7.0625 -2.328125 "/>
</g>
<g id="glyph-0-2">
<path d="M 5.15625 -3.71875 C 5.296875 -3.71875 5.65625 -3.71875 5.65625 -4.0625 C 5.65625 -4.296875 5.4375 -4.296875 5.265625 -4.296875 L 2.984375 -4.296875 C 1.484375 -4.296875 0.375 -2.65625 0.375 -1.46875 C 0.375 -0.59375 0.96875 0.109375 1.875 0.109375 C 3.046875 0.109375 4.375 -1.09375 4.375 -2.625 C 4.375 -2.796875 4.375 -3.28125 4.0625 -3.71875 Z M 1.890625 -0.109375 C 1.390625 -0.109375 1 -0.46875 1 -1.1875 C 1 -1.484375 1.109375 -2.296875 1.46875 -2.890625 C 1.890625 -3.578125 2.484375 -3.71875 2.828125 -3.71875 C 3.65625 -3.71875 3.734375 -3.0625 3.734375 -2.75 C 3.734375 -2.28125 3.53125 -1.46875 3.203125 -0.953125 C 2.8125 -0.375 2.265625 -0.109375 1.890625 -0.109375 Z M 1.890625 -0.109375 "/>
</g>
<g id="glyph-1-0">
</g>
<g id="glyph-1-1">
<path d="M 2.328125 -4.4375 C 2.328125 -4.625 2.328125 -4.625 2.125 -4.625 C 1.671875 -4.1875 1.046875 -4.1875 0.765625 -4.1875 L 0.765625 -3.9375 C 0.921875 -3.9375 1.390625 -3.9375 1.765625 -4.125 L 1.765625 -0.578125 C 1.765625 -0.34375 1.765625 -0.25 1.078125 -0.25 L 0.8125 -0.25 L 0.8125 0 C 0.9375 0 1.796875 -0.03125 2.046875 -0.03125 C 2.265625 -0.03125 3.140625 0 3.296875 0 L 3.296875 -0.25 L 3.03125 -0.25 C 2.328125 -0.25 2.328125 -0.34375 2.328125 -0.578125 Z M 2.328125 -4.4375 "/>
</g>
<g id="glyph-1-2">
<path d="M 3.515625 -1.265625 L 3.28125 -1.265625 C 3.265625 -1.109375 3.1875 -0.703125 3.09375 -0.640625 C 3.046875 -0.59375 2.515625 -0.59375 2.40625 -0.59375 L 1.125 -0.59375 C 1.859375 -1.234375 2.109375 -1.4375 2.515625 -1.765625 C 3.03125 -2.171875 3.515625 -2.609375 3.515625 -3.265625 C 3.515625 -4.109375 2.78125 -4.625 1.890625 -4.625 C 1.03125 -4.625 0.4375 -4.015625 0.4375 -3.375 C 0.4375 -3.03125 0.734375 -2.984375 0.8125 -2.984375 C 0.96875 -2.984375 1.171875 -3.109375 1.171875 -3.359375 C 1.171875 -3.484375 1.125 -3.734375 0.765625 -3.734375 C 0.984375 -4.21875 1.453125 -4.375 1.78125 -4.375 C 2.484375 -4.375 2.84375 -3.828125 2.84375 -3.265625 C 2.84375 -2.65625 2.40625 -2.1875 2.1875 -1.9375 L 0.515625 -0.265625 C 0.4375 -0.203125 0.4375 -0.1875 0.4375 0 L 3.3125 0 Z M 3.515625 -1.265625 "/>
</g>
<g id="glyph-2-0">
</g>
<g id="glyph-2-1">
<path d="M 3.875 -2.625 C 3.90625 -2.71875 3.90625 -2.734375 3.90625 -2.78125 C 3.90625 -2.921875 3.796875 -3 3.671875 -3 C 3.59375 -3 3.46875 -2.96875 3.390625 -2.84375 C 3.359375 -2.796875 3.3125 -2.578125 3.28125 -2.4375 L 3.125 -1.859375 C 3.09375 -1.6875 2.875 -0.8125 2.84375 -0.734375 C 2.84375 -0.734375 2.53125 -0.125 2 -0.125 C 1.515625 -0.125 1.515625 -0.578125 1.515625 -0.703125 C 1.515625 -1.078125 1.671875 -1.515625 1.890625 -2.0625 C 1.96875 -2.28125 2 -2.359375 2 -2.484375 C 2 -2.8125 1.71875 -3.078125 1.34375 -3.078125 C 0.640625 -3.078125 0.328125 -2.125 0.328125 -2 C 0.328125 -1.921875 0.421875 -1.921875 0.453125 -1.921875 C 0.546875 -1.921875 0.546875 -1.953125 0.578125 -2.03125 C 0.75 -2.609375 1.046875 -2.875 1.328125 -2.875 C 1.4375 -2.875 1.5 -2.796875 1.5 -2.640625 C 1.5 -2.46875 1.4375 -2.328125 1.40625 -2.234375 C 1.0625 -1.375 1 -1.125 1 -0.8125 C 1 -0.703125 1 -0.375 1.265625 -0.140625 C 1.484375 0.03125 1.78125 0.0625 1.96875 0.0625 C 2.25 0.0625 2.5 -0.03125 2.71875 -0.25 C 2.640625 0.140625 2.5625 0.4375 2.265625 0.78125 C 2.078125 1 1.796875 1.21875 1.421875 1.21875 C 1.375 1.21875 1.046875 1.21875 0.90625 1 C 1.28125 0.953125 1.28125 0.625 1.28125 0.609375 C 1.28125 0.390625 1.078125 0.34375 1.015625 0.34375 C 0.84375 0.34375 0.609375 0.484375 0.609375 0.8125 C 0.609375 1.15625 0.9375 1.421875 1.4375 1.421875 C 2.140625 1.421875 3 0.875 3.21875 0 Z M 3.875 -2.625 "/>
</g>
</g>
<clipPath id="clip-0">
<path clip-rule="nonzero" d="M 106.5 6.777344 L 108.59375 6.777344 L 108.59375 7.472656 L 106.5 7.472656 Z M 106.5 6.777344 "/>
</clipPath>
<clipPath id="clip-1">
<path clip-rule="nonzero" d="M 106.601562 6.777344 L 111.582031 6.777344 L 111.582031 7.472656 L 106.601562 7.472656 Z M 106.601562 6.777344 "/>
</clipPath>
<clipPath id="clip-2">
<path clip-rule="nonzero" d="M 109.589844 6.777344 L 114.570312 6.777344 L 114.570312 7.472656 L 109.589844 7.472656 Z M 109.589844 6.777344 "/>
</clipPath>
<clipPath id="clip-3">
<path clip-rule="nonzero" d="M 112.578125 6.777344 L 117.5625 6.777344 L 117.5625 7.472656 L 112.578125 7.472656 Z M 112.578125 6.777344 "/>
</clipPath>
<clipPath id="clip-4">
<path clip-rule="nonzero" d="M 115.566406 6.777344 L 120.550781 6.777344 L 120.550781 7.472656 L 115.566406 7.472656 Z M 115.566406 6.777344 "/>
</clipPath>
<clipPath id="clip-5">
<path clip-rule="nonzero" d="M 118.558594 6.777344 L 120.671875 6.777344 L 120.671875 7.472656 L 118.558594 7.472656 Z M 118.558594 6.777344 "/>
</clipPath>
<clipPath id="clip-6">
<path clip-rule="nonzero" d="M 106.5 4.636719 L 108.59375 4.636719 L 108.59375 7.472656 L 106.5 7.472656 Z M 106.5 4.636719 "/>
</clipPath>
<clipPath id="clip-7">
<path clip-rule="nonzero" d="M 106.601562 4.636719 L 111.582031 4.636719 L 111.582031 7.472656 L 106.601562 7.472656 Z M 106.601562 4.636719 "/>
</clipPath>
<clipPath id="clip-8">
<path clip-rule="nonzero" d="M 109.589844 4.636719 L 114.570312 4.636719 L 114.570312 7.472656 L 109.589844 7.472656 Z M 109.589844 4.636719 "/>
</clipPath>
<clipPath id="clip-9">
<path clip-rule="nonzero" d="M 112.578125 4.636719 L 117.5625 4.636719 L 117.5625 7.472656 L 112.578125 7.472656 Z M 112.578125 4.636719 "/>
</clipPath>
<clipPath id="clip-10">
<path clip-rule="nonzero" d="M 115.566406 4.636719 L 120.550781 4.636719 L 120.550781 7.472656 L 115.566406 7.472656 Z M 115.566406 4.636719 "/>
</clipPath>
<clipPath id="clip-11">
<path clip-rule="nonzero" d="M 118.558594 4.636719 L 120.671875 4.636719 L 120.671875 7.472656 L 118.558594 7.472656 Z M 118.558594 4.636719 "/>
</clipPath>
<clipPath id="clip-12">
<path clip-rule="nonzero" d="M 106.5 4.636719 L 108.59375 4.636719 L 108.59375 5.78125 L 106.5 5.78125 Z M 106.5 4.636719 "/>
</clipPath>
<clipPath id="clip-13">
<path clip-rule="nonzero" d="M 106.601562 4.636719 L 111.582031 4.636719 L 111.582031 5.78125 L 106.601562 5.78125 Z M 106.601562 4.636719 "/>
</clipPath>
<clipPath id="clip-14">
<path clip-rule="nonzero" d="M 109.589844 4.636719 L 114.570312 4.636719 L 114.570312 5.78125 L 109.589844 5.78125 Z M 109.589844 4.636719 "/>
</clipPath>
<clipPath id="clip-15">
<path clip-rule="nonzero" d="M 112.578125 4.636719 L 117.5625 4.636719 L 117.5625 5.78125 L 112.578125 5.78125 Z M 112.578125 4.636719 "/>
</clipPath>
<clipPath id="clip-16">
<path clip-rule="nonzero" d="M 115.566406 4.636719 L 120.550781 4.636719 L 120.550781 5.78125 L 115.566406 5.78125 Z M 115.566406 4.636719 "/>
</clipPath>
<clipPath id="clip-17">
<path clip-rule="nonzero" d="M 118.558594 4.636719 L 120.671875 4.636719 L 120.671875 5.78125 L 118.558594 5.78125 Z M 118.558594 4.636719 "/>
</clipPath>
<clipPath id="clip-18">
<path clip-rule="nonzero" d="M 106.5 63.566406 L 108.59375 63.566406 L 108.59375 64.164062 L 106.5 64.164062 Z M 106.5 63.566406 "/>
</clipPath>
<clipPath id="clip-19">
<path clip-rule="nonzero" d="M 106.601562 63.566406 L 111.582031 63.566406 L 111.582031 64.164062 L 106.601562 64.164062 Z M 106.601562 63.566406 "/>
</clipPath>
<clipPath id="clip-20">
<path clip-rule="nonzero" d="M 109.589844 63.566406 L 114.570312 63.566406 L 114.570312 64.164062 L 109.589844 64.164062 Z M 109.589844 63.566406 "/>
</clipPath>
<clipPath id="clip-21">
<path clip-rule="nonzero" d="M 112.578125 63.566406 L 117.5625 63.566406 L 117.5625 64.164062 L 112.578125 64.164062 Z M 112.578125 63.566406 "/>
</clipPath>
<clipPath id="clip-22">
<path clip-rule="nonzero" d="M 115.566406 63.566406 L 120.550781 63.566406 L 120.550781 64.164062 L 115.566406 64.164062 Z M 115.566406 63.566406 "/>
</clipPath>
<clipPath id="clip-23">
<path clip-rule="nonzero" d="M 118.558594 63.566406 L 120.671875 63.566406 L 120.671875 64.164062 L 118.558594 64.164062 Z M 118.558594 63.566406 "/>
</clipPath>
<clipPath id="clip-24">
<path clip-rule="nonzero" d="M 106.5 61.328125 L 108.59375 61.328125 L 108.59375 64.164062 L 106.5 64.164062 Z M 106.5 61.328125 "/>
</clipPath>
<clipPath id="clip-25">
<path clip-rule="nonzero" d="M 106.601562 61.328125 L 111.582031 61.328125 L 111.582031 64.164062 L 106.601562 64.164062 Z M 106.601562 61.328125 "/>
</clipPath>
<clipPath id="clip-26">
<path clip-rule="nonzero" d="M 109.589844 61.328125 L 114.570312 61.328125 L 114.570312 64.164062 L 109.589844 64.164062 Z M 109.589844 61.328125 "/>
</clipPath>
<clipPath id="clip-27">
<path clip-rule="nonzero" d="M 112.578125 61.328125 L 117.5625 61.328125 L 117.5625 64.164062 L 112.578125 64.164062 Z M 112.578125 61.328125 "/>
</clipPath>
<clipPath id="clip-28">
<path clip-rule="nonzero" d="M 115.566406 61.328125 L 120.550781 61.328125 L 120.550781 64.164062 L 115.566406 64.164062 Z M 115.566406 61.328125 "/>
</clipPath>
<clipPath id="clip-29">
<path clip-rule="nonzero" d="M 118.558594 61.328125 L 120.671875 61.328125 L 120.671875 64.164062 L 118.558594 64.164062 Z M 118.558594 61.328125 "/>
</clipPath>
<clipPath id="clip-30">
<path clip-rule="nonzero" d="M 106.5 61.328125 L 108.59375 61.328125 L 108.59375 62.570312 L 106.5 62.570312 Z M 106.5 61.328125 "/>
</clipPath>
<clipPath id="clip-31">
<path clip-rule="nonzero" d="M 106.601562 61.328125 L 111.582031 61.328125 L 111.582031 62.570312 L 106.601562 62.570312 Z M 106.601562 61.328125 "/>
</clipPath>
<clipPath id="clip-32">
<path clip-rule="nonzero" d="M 109.589844 61.328125 L 114.570312 61.328125 L 114.570312 62.570312 L 109.589844 62.570312 Z M 109.589844 61.328125 "/>
</clipPath>
<clipPath id="clip-33">
<path clip-rule="nonzero" d="M 112.578125 61.328125 L 117.5625 61.328125 L 117.5625 62.570312 L 112.578125 62.570312 Z M 112.578125 61.328125 "/>
</clipPath>
<clipPath id="clip-34">
<path clip-rule="nonzero" d="M 115.566406 61.328125 L 120.550781 61.328125 L 120.550781 62.570312 L 115.566406 62.570312 Z M 115.566406 61.328125 "/>
</clipPath>
<clipPath id="clip-35">
<path clip-rule="nonzero" d="M 118.558594 61.328125 L 120.671875 61.328125 L 120.671875 62.570312 L 118.558594 62.570312 Z M 118.558594 61.328125 "/>
</clipPath>
<clipPath id="clip-36">
<path clip-rule="nonzero" d="M 141 35 L 170.476562 35 L 170.476562 37 L 141 37 Z M 141 35 "/>
</clipPath>
</defs>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 0.00021875 0.00159375 L 28.347875 0.00159375 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 0.00159375 L 28.347875 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 28.345344 L 56.695531 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.79701" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 56.695531 28.345344 L 59.183813 30.837531 L 64.164281 25.857063 L 69.148656 30.837531 L 74.129125 25.857063 L 79.109594 30.837531 L 81.601781 28.345344 L 85.039281 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-1" x="65.153" y="20.987"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-1" x="72.508" y="22.482"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 85.039281 28.345344 L 99.215063 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g clip-path="url(#clip-0)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 0.00136125 L 0.000325 3.087299 M 0.000325 0.00136125 L 3.090169 3.087299 " transform="matrix(1, 0, 0, -1, 104.60905, 10.76308)"/>
</g>
<g clip-path="url(#clip-1)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 0.00136125 L -0.00022375 3.087299 M -0.00022375 0.00136125 L 3.08962 3.087299 " transform="matrix(1, 0, 0, -1, 107.59788, 10.76308)"/>
</g>
<g clip-path="url(#clip-2)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 0.00136125 L -0.0007725 3.087299 M -0.0007725 0.00136125 L 3.089071 3.087299 " transform="matrix(1, 0, 0, -1, 110.58671, 10.76308)"/>
</g>
<g clip-path="url(#clip-3)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 0.00136125 L -0.00132125 3.087299 M -0.00132125 0.00136125 L 3.088522 3.087299 " transform="matrix(1, 0, 0, -1, 113.57554, 10.76308)"/>
</g>
<g clip-path="url(#clip-4)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 0.00136125 L -0.00187 3.087299 M -0.00187 0.00136125 L 3.087974 3.087299 " transform="matrix(1, 0, 0, -1, 116.56437, 10.76308)"/>
</g>
<g clip-path="url(#clip-5)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 0.00136125 L 0.0014875 3.087299 M 0.0014875 0.00136125 L 3.087425 3.087299 " transform="matrix(1, 0, 0, -1, 119.5532, 10.76308)"/>
</g>
<g clip-path="url(#clip-6)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 0.0008125 L 0.000325 3.08675 M 0.000325 0.0008125 L 3.090169 3.08675 " transform="matrix(1, 0, 0, -1, 104.60905, 7.77425)"/>
</g>
<g clip-path="url(#clip-7)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 0.0008125 L -0.00022375 3.08675 M -0.00022375 0.0008125 L 3.08962 3.08675 " transform="matrix(1, 0, 0, -1, 107.59788, 7.77425)"/>
</g>
<g clip-path="url(#clip-8)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 0.0008125 L -0.0007725 3.08675 M -0.0007725 0.0008125 L 3.089071 3.08675 " transform="matrix(1, 0, 0, -1, 110.58671, 7.77425)"/>
</g>
<g clip-path="url(#clip-9)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 0.0008125 L -0.00132125 3.08675 M -0.00132125 0.0008125 L 3.088522 3.08675 " transform="matrix(1, 0, 0, -1, 113.57554, 7.77425)"/>
</g>
<g clip-path="url(#clip-10)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 0.0008125 L -0.00187 3.08675 M -0.00187 0.0008125 L 3.087974 3.08675 " transform="matrix(1, 0, 0, -1, 116.56437, 7.77425)"/>
</g>
<g clip-path="url(#clip-11)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 0.0008125 L 0.0014875 3.08675 M 0.0014875 0.0008125 L 3.087425 3.08675 " transform="matrix(1, 0, 0, -1, 119.5532, 7.77425)"/>
</g>
<g clip-path="url(#clip-12)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 0.00026375 L 0.000325 3.090108 M 0.000325 0.00026375 L 3.090169 3.090108 " transform="matrix(1, 0, 0, -1, 104.60905, 4.78542)"/>
</g>
<g clip-path="url(#clip-13)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 0.00026375 L -0.00022375 3.090108 M -0.00022375 0.00026375 L 3.08962 3.090108 " transform="matrix(1, 0, 0, -1, 107.59788, 4.78542)"/>
</g>
<g clip-path="url(#clip-14)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 0.00026375 L -0.0007725 3.090108 M -0.0007725 0.00026375 L 3.089071 3.090108 " transform="matrix(1, 0, 0, -1, 110.58671, 4.78542)"/>
</g>
<g clip-path="url(#clip-15)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 0.00026375 L -0.00132125 3.090108 M -0.00132125 0.00026375 L 3.088522 3.090108 " transform="matrix(1, 0, 0, -1, 113.57554, 4.78542)"/>
</g>
<g clip-path="url(#clip-16)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 0.00026375 L -0.00187 3.090108 M -0.00187 0.00026375 L 3.087974 3.090108 " transform="matrix(1, 0, 0, -1, 116.56437, 4.78542)"/>
</g>
<g clip-path="url(#clip-17)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 0.00026375 L 0.0014875 3.090108 M 0.0014875 0.00026375 L 3.087425 3.090108 " transform="matrix(1, 0, 0, -1, 119.5532, 4.78542)"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 106.301 28.345344 L 106.301 31.181281 L 120.472875 31.181281 L 120.472875 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 28.345344 L 104.406469 28.345344 M 108.191625 28.345344 L 113.386938 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-2" x="101.079" y="18.782"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-2-1" x="107.129" y="13.994"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-1" x="106.772" y="21.438"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 28.345344 L 141.734594 28.345344 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 28.345344 L 141.734594 0.00159375 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 0.00159375 L 28.347875 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 28.347875 -28.346062 L 56.695531 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.79701" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 56.695531 -28.346062 L 59.183813 -25.857781 L 64.164281 -30.83825 L 69.148656 -25.857781 L 74.129125 -30.83825 L 79.109594 -25.857781 L 81.601781 -28.346062 L 85.039281 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-1" x="65.153" y="77.68"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-2" x="72.508" y="79.174"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 85.039281 -28.346062 L 99.215063 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g clip-path="url(#clip-18)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 0.00006875 L 0.000325 3.089912 M 0.000325 0.00006875 L 3.090169 3.089912 " transform="matrix(1, 0, 0, -1, 104.60905, 67.55085)"/>
</g>
<g clip-path="url(#clip-19)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 0.00006875 L -0.00022375 3.089912 M -0.00022375 0.00006875 L 3.08962 3.089912 " transform="matrix(1, 0, 0, -1, 107.59788, 67.55085)"/>
</g>
<g clip-path="url(#clip-20)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 0.00006875 L -0.0007725 3.089912 M -0.0007725 0.00006875 L 3.089071 3.089912 " transform="matrix(1, 0, 0, -1, 110.58671, 67.55085)"/>
</g>
<g clip-path="url(#clip-21)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 0.00006875 L -0.00132125 3.089912 M -0.00132125 0.00006875 L 3.088522 3.089912 " transform="matrix(1, 0, 0, -1, 113.57554, 67.55085)"/>
</g>
<g clip-path="url(#clip-22)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 0.00006875 L -0.00187 3.089912 M -0.00187 0.00006875 L 3.087974 3.089912 " transform="matrix(1, 0, 0, -1, 116.56437, 67.55085)"/>
</g>
<g clip-path="url(#clip-23)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 0.00006875 L 0.0014875 3.089912 M 0.0014875 0.00006875 L 3.087425 3.089912 " transform="matrix(1, 0, 0, -1, 119.5532, 67.55085)"/>
</g>
<g clip-path="url(#clip-24)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 -0.00048 L 0.000325 3.089364 M 0.000325 -0.00048 L 3.090169 3.089364 " transform="matrix(1, 0, 0, -1, 104.60905, 64.56202)"/>
</g>
<g clip-path="url(#clip-25)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 -0.00048 L -0.00022375 3.089364 M -0.00022375 -0.00048 L 3.08962 3.089364 " transform="matrix(1, 0, 0, -1, 107.59788, 64.56202)"/>
</g>
<g clip-path="url(#clip-26)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 -0.00048 L -0.0007725 3.089364 M -0.0007725 -0.00048 L 3.089071 3.089364 " transform="matrix(1, 0, 0, -1, 110.58671, 64.56202)"/>
</g>
<g clip-path="url(#clip-27)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 -0.00048 L -0.00132125 3.089364 M -0.00132125 -0.00048 L 3.088522 3.089364 " transform="matrix(1, 0, 0, -1, 113.57554, 64.56202)"/>
</g>
<g clip-path="url(#clip-28)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 -0.00048 L -0.00187 3.089364 M -0.00187 -0.00048 L 3.087974 3.089364 " transform="matrix(1, 0, 0, -1, 116.56437, 64.56202)"/>
</g>
<g clip-path="url(#clip-29)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 -0.00048 L 0.0014875 3.089364 M 0.0014875 -0.00048 L 3.087425 3.089364 " transform="matrix(1, 0, 0, -1, 119.5532, 64.56202)"/>
</g>
<g clip-path="url(#clip-30)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.090169 -0.00102875 L 0.000325 3.088815 M 0.000325 -0.00102875 L 3.090169 3.088815 " transform="matrix(1, 0, 0, -1, 104.60905, 61.57319)"/>
</g>
<g clip-path="url(#clip-31)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.08962 -0.00102875 L -0.00022375 3.088815 M -0.00022375 -0.00102875 L 3.08962 3.088815 " transform="matrix(1, 0, 0, -1, 107.59788, 61.57319)"/>
</g>
<g clip-path="url(#clip-32)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.089071 -0.00102875 L -0.0007725 3.088815 M -0.0007725 -0.00102875 L 3.089071 3.088815 " transform="matrix(1, 0, 0, -1, 110.58671, 61.57319)"/>
</g>
<g clip-path="url(#clip-33)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.088522 -0.00102875 L -0.00132125 3.088815 M -0.00132125 -0.00102875 L 3.088522 3.088815 " transform="matrix(1, 0, 0, -1, 113.57554, 61.57319)"/>
</g>
<g clip-path="url(#clip-34)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087974 -0.00102875 L -0.00187 3.088815 M -0.00187 -0.00102875 L 3.087974 3.088815 " transform="matrix(1, 0, 0, -1, 116.56437, 61.57319)"/>
</g>
<g clip-path="url(#clip-35)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 3.087425 -0.00102875 L 0.0014875 3.088815 M 0.0014875 -0.00102875 L 3.087425 3.088815 " transform="matrix(1, 0, 0, -1, 119.5532, 61.57319)"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 106.301 -28.346062 L 106.301 -25.510125 L 120.472875 -25.510125 L 120.472875 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 -28.346062 L 104.406469 -28.346062 M 108.191625 -28.346062 L 113.386938 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-0-2" x="101.079" y="75.474"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-2-1" x="107.129" y="70.687"/>
</g>
<g fill="rgb(0%, 0%, 0%)" fill-opacity="1">
<use xlink:href="#glyph-1-2" x="106.772" y="78.131"/>
</g>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 99.215063 -28.346062 L 141.734594 -28.346062 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 -28.346062 L 141.734594 0.00159375 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
<g clip-path="url(#clip-36)">
<path fill="none" stroke-width="0.3985" stroke-linecap="butt" stroke-linejoin="miter" stroke="rgb(0%, 0%, 0%)" stroke-opacity="1" stroke-miterlimit="10" d="M 141.734594 0.00159375 L 170.08225 0.00159375 " transform="matrix(1, 0, 0, -1, 0.199, 35.818)"/>
</g>
</svg>""";

# ╔═╡ 38fbcd82-0737-4b33-aaa8-6a171c630a8f
function parameter_input(parameters::Vector,subtitle::Markdown.MD)
	
	return PlutoUI.combine() do Child
		
		inputs = [
			md""" $(name): $(
				Child(name, NumberField(0:.01:10,default=1.))
			)"""
			
			for name in parameters
		]
		
		md"""
		#### Input your Parameters
		##### $(subtitle)
		$(inputs)
		"""
	end
end;

# ╔═╡ 0f5ca7ab-f924-4fbf-ba24-8489d8a3b6af
@bind parameters_prandtl_input parameter_input(["E","σʸ"],md"")

# ╔═╡ b7e288bf-58bc-4140-a6be-c309e83aeab4
parameters_prandtl = Prandtl(
	parameters_prandtl_input.E,
	parameters_prandtl_input.σʸ);

# ╔═╡ 4bdc4c11-0f0a-4577-b2cc-ea0766151892
if prandtl_load(0.) * parameters_prandtl.E > parameters_prandtl.σy
	σ₀_prandtl = parameters_prandtl.σy
else
	σ₀_prandtl = prandtl_load(0.) * parameters_prandtl.E
end;

# ╔═╡ 121a92ff-d527-4305-9b22-ee4472364074
@bind parameters_st_venant_ext_input parameter_input(["E","σʸ"],md"")

# ╔═╡ 7d86c2bd-aa9c-4c2b-9a3f-09e3b04c62ba
parameters_st_venant_ext = StVenantExt(
	parameters_st_venant_ext_input.E,
	parameters_st_venant_ext_input.σʸ);

# ╔═╡ 0cf7858d-f298-4456-abfc-dee53833f2ae
if st_venant_ext_load(0.) > parameters_st_venant_ext.σy
	ε₀_st_venant_ext = st_venant_ext_load(0.) / parameters_st_venant_ext.E
else
	ε₀_st_venant_ext = 0.
end;

# ╔═╡ 10ce7e86-99f0-40fc-92bc-37df7abed441
@bind parameters_gen_p1_input parameter_input(["Eᴬ","Eᴮ","σʸ"],md"")

# ╔═╡ 209ce134-303a-4d67-862d-0fc63f0a774f
parameters_gen_p1 = GeneralPrandtl1(
	StVenantExt(parameters_gen_p1_input.Eᴬ,parameters_gen_p1_input.σʸ),
	parameters_gen_p1_input.Eᴮ
);

# ╔═╡ 1c54a086-9199-43e9-98f5-4e1453391bd1
if gen_p1_load(0.) > parameters_gen_p1_input.σʸ
	ε0_gen_p1 = (parameters_gen_p1_input.Eᴬ + parameters_gen_p1_input.Eᴮ) / (parameters_gen_p1_input.Eᴬ*parameters_gen_p1_input.Eᴮ) * gen_p1_load(0.) - sign(gen_p1_load(0.)) * parameters_gen_p1_input.σʸ
else
	ε0_gen_p1 = gen_p1_load(0.) / parameters_gen_p1.Eᴮ
end;

# ╔═╡ 06b91c40-c267-4935-be8f-7f61f1303caf
begin
	hint(text;blur=true) = blur ? Markdown.MD(
		Markdown.Admonition("hint", "Help"[text])) : Markdown.MD(Markdown.Admonition("note", "Help", [text]))

	warning(text) = Markdown.MD(Markdown.Admonition("warning", "Warning", [text]))

	yays = [ md"Good job! 🐣", md"Yes 👍", md"Splendid! 🎉", md"Nicely done! 🐦",
		md"Well done! 🐤", md"Nice work! 🐧", md"Nice! 🐖", md"Very nice! 🐿" ]

	correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Correct!", 	[text]))
	
	still_missing(text=md"Replace `Missing` with your answer", titel="Not yet! 🦦") =
		Markdown.MD(Markdown.Admonition("warning", titel, [text]))

	keep_working(text=md"This is not the correct answer, try again! 🦥") =
		Markdown.MD(Markdown.Admonition("danger", "Wrong", [text]))

	solution(text; blur=true) = blur ? Markdown.MD(Markdown.Admonition("hint", 
		"Solution", [text])) : Markdown.MD(Markdown.Admonition("note", "Solution", [text]))

	svg(path) = HTML(open(f->read(f, String), path))
end;

# ╔═╡ cc739249-2975-4efa-a1d6-aae7d03fcc8a
begin
	prandtl_ε_test = [.9,1.]

	prandtl_σₙ₊₁_test, _ = rheological_model_σ(1,
		0:0.01:1,
		sin_load(1.,1.),
		prandtl_ε_test,
		Prandtl(1.,.1),
		PrandtlState(0.)
	)

	if !(@isdefined prandtl_σₙ₊₁_test) || prandtl_σₙ₊₁_test === missing
		prandtl_σ_implemented = false
		still_missing()
	elseif prandtl_σₙ₊₁_test ≈ 0.009999833334166664
		prandtl_σ_implemented = true
		correct()
	else
		prandtl_σ_implemented = false
		keep_working()
	end
end

# ╔═╡ 162d216e-cf65-4a3a-b3d5-b73296542a58
if prandtl_σ_implemented == true
	plot_model_σ(load_time,prandtl_load,σ₀_prandtl,parameters_prandtl,PrandtlState(0.))
end

# ╔═╡ d7068d69-7e48-4eb1-accb-dd3a1a0b75ea
begin
	st_venant_ext_ε_test = [.9,1.]

	st_venant_ext_εₙ₊₁_test, _ = rheological_model_ε(1,
		0:0.01:1,
		sin_load(10.,4π),
		st_venant_ext_ε_test,
		StVenantExt(1.,.1),
		StVenantExtState(0.)
	)

	if !(@isdefined st_venant_ext_εₙ₊₁_test) || st_venant_ext_εₙ₊₁_test === missing
		st_venant_ext_implemented = false
		still_missing()
	elseif st_venant_ext_εₙ₊₁_test ≈ 1.154543713281777
		st_venant_ext_implemented = true
		correct()
	else
		st_venant_ext_implemented = true
		keep_working()
	end
end

# ╔═╡ 4c155972-0557-48c8-96e2-5495dbfb1201
if st_venant_ext_implemented == true
	plot_model_ε(load_time,st_venant_ext_load,ε₀_st_venant_ext,parameters_st_venant_ext,StVenantExtState(0.))
end

# ╔═╡ 0b2d0e50-3d03-4ea7-bcaa-5ef3a471fa7d
begin
	gen_prandtl1_ε_test = [.9,1.]

	gen_prandtl1_εₙ₊₁_test, _ = rheological_model_ε(1,
		0:0.01:1,
		sin_load(10.,4π),
		gen_prandtl1_ε_test,
		GeneralPrandtl1(StVenantExt(1.,1.),.1),
		GeneralPrandtl1State(StVenantExtState(0.))
	)

	if !(@isdefined gen_prandtl1_εₙ₊₁_test) || gen_prandtl1_εₙ₊₁_test === missing
		gen_prandtl1_implemented = false
		still_missing()
	elseif gen_prandtl1_εₙ₊₁_test ≈ 12.799980846099547
		gen_prandtl1_implemented = true
		correct()
	else
		gen_prandtl1_implemented = true
		keep_working()
	end
end

# ╔═╡ 335b4d45-7850-4ae8-94b9-083144ff240c
if gen_prandtl1_implemented == true
	plot_model_ε(
		load_time,
		gen_p1_load,
		ε0_gen_p1,
		parameters_gen_p1,
		GeneralPrandtl1State(StVenantExtState(0.))
	)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CairoMakie = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CairoMakie = "~0.10.0"
PlutoUI = "~0.7.49"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "91f8c8840929c37b75df3d1098c1307f660969ba"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractLattices]]
git-tree-sha1 = "763b6f3f6bfabd72c7e262cbb5ddfd43fd5c6398"
uuid = "398f06c4-4d28-53ec-89ca-5b2656b7603d"
version = "0.3.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "50c3c56a52972d78e8be9fd135bfb91c9574c140"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.1"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e092fa223bf66a3c41f9c022bd074d916dc303e7"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "017fcb757f8e921fb44ee063a7aafe5f89b86dd1"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.18.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesCoreExt = "ChainRulesCore"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Automa]]
deps = ["PrecompileTools", "SIMD", "TranscodingStreams"]
git-tree-sha1 = "a8f503e8e1a5f583fbef15a8440c8c7e32185df2"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "1.1.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "8873e196c2eb87962a2048b3b8e08946535864a1"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+4"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CRC32c]]
uuid = "8bf52ea8-c179-5cab-976a-9e18b702a9bc"
version = "1.11.0"

[[deps.CRlibm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e329286945d0cfc04456972ea732551869af1cfc"
uuid = "4e9b3aee-d8a1-5a3d-ad8b-7d824db253f0"
version = "1.0.1+0"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "71aa551c5c33f1a4415867fe06b7844faadb0ae9"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.1.1"

[[deps.CairoMakie]]
deps = ["Base64", "Cairo", "Colors", "FFTW", "FileIO", "FreeType", "GeometryBasics", "LinearAlgebra", "Makie", "PrecompileTools", "SHA"]
git-tree-sha1 = "5e21a254d82c64b1a4ed9dbdc7e87c5d9cf4a686"
uuid = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
version = "0.10.12"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "1713c74e00545bfe14605d2a2be1712de8fbcb58"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.1"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON", "Test"]
git-tree-sha1 = "61c5334f33d91e570e1d0c3eb5465835242582c4"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "c785dfb1b3bfddd1da557e861b919819b82bbe5b"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.27.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DelaunayTriangulation]]
deps = ["DataStructures", "EnumX", "ExactPredicates", "Random", "SimpleGraphs"]
git-tree-sha1 = "d4e9dc4c6106b8d44e40cd4faf8261a678552c7c"
uuid = "927a84f5-c5f4-47a5-9785-b46e178433df"
version = "0.8.12"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "4b138e4643b577ccf355377c2bc70fa975af25de"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.115"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.ExactPredicates]]
deps = ["IntervalArithmetic", "Random", "StaticArrays"]
git-tree-sha1 = "b3f2ff58735b5f024c392fde763f29b057e4b025"
uuid = "429591f6-91af-11e9-00e2-59fbe8cec110"
version = "2.2.8"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e51db81749b0777b2147fbe7b783ee79045b8e99"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+3"

[[deps.Extents]]
git-tree-sha1 = "81023caa0021a41712685887db1fc03db26f41f5"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.4"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "8cc47f299902e13f90405ddb5bf87e5d474c0d38"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "6.1.2+0"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4d81ed14783ec49ce9f2e168208a12ce1815aa25"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+3"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Setfield"]
git-tree-sha1 = "84e3a47db33be7248daa6274b287507dd6ff84e8"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.26.2"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffSparseArraysExt = "SparseArrays"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.Formatting]]
deps = ["Logging", "Printf"]
git-tree-sha1 = "fb409abab2caf118986fc597ba84b50cbaf00b87"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.3"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a2df1b776752e3f344e5116c06d75a10436ab853"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.38"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "d52e255138ac21be31fa633200b65e4e71d26802"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.6"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "846f7026a9decf3679419122b49f8a1fdb48d2d5"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.16+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GeoFormatTypes]]
git-tree-sha1 = "59107c179a586f0fe667024c5eb7033e81333271"
uuid = "68eda718-8dee-11e9-39e7-89f7f65f511f"
version = "0.4.2"

[[deps.GeoInterface]]
deps = ["DataAPI", "Extents", "GeoFormatTypes"]
git-tree-sha1 = "f4ee66b6b1872a4ca53303fbb51d158af1bf88d4"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.4.0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "b62f2b2d76cee0d61a2ef2b3118cd2a3215d3134"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.11"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b0036b392358c80d2d2124746c2bf3d48d457938"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.4+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "f57a64794b336d4990d90f80b147474b869b1bc4"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.9.2"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "10bd689145d2c3b2a9844005d01087cc1194e79e"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.2.1+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalArithmetic]]
deps = ["CRlibm_jll", "LinearAlgebra", "MacroTools", "RoundingEmulator"]
git-tree-sha1 = "ffb76d09ab0dc9f5a27edac2acec13c74a876cc6"
uuid = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
version = "0.22.21"
weakdeps = ["DiffRules", "ForwardDiff", "IntervalSets", "RecipesBase"]

    [deps.IntervalArithmetic.extensions]
    IntervalArithmeticDiffRulesExt = "DiffRules"
    IntervalArithmeticForwardDiffExt = "ForwardDiff"
    IntervalArithmeticIntervalSetsExt = "IntervalSets"
    IntervalArithmeticRecipesBaseExt = "RecipesBase"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "7d703202e65efa1369de1279c162b915e245eed1"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.9"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+3"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "27ecae93dd25ee0909666e6835051dd684cc035e"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+2"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "df37206100d39f79b3376afb6b9cee4970041c61"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.51.1+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "84eef7acd508ee5b3e956a2ae51b05024181dee0"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.2+2"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "4ab7581296671007fc33f07a721631b8855f4b1d"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.1+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "edbf5309f9ddf1cab25afc344b1e8150b7c832f9"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.2+2"

[[deps.LightXML]]
deps = ["Libdl", "XML2_jll"]
git-tree-sha1 = "3a994404d3f6709610701c7dabfc03fed87a81f8"
uuid = "9c8b4983-aa76-5018-a973-4c85ecc9e179"
version = "0.9.1"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "e4c3be53733db1051cc15ecf573b1042b3a712a1"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.3.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LinearAlgebraX]]
deps = ["LinearAlgebra", "Mods", "Primes", "SimplePolynomials"]
git-tree-sha1 = "054fe197a75adcf517933f0c807051d79881f3f3"
uuid = "9b3f67b0-2d00-526e-9884-9e4938f8fb88"
version = "0.2.10"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "f046ccd0c6db2832a9f639e2c669c6fe867e5f4f"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Makie]]
deps = ["Animations", "Base64", "CRC32c", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "Contour", "DelaunayTriangulation", "Distributions", "DocStringExtensions", "Downloads", "FFMPEG_jll", "FileIO", "FixedPointNumbers", "Formatting", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageIO", "InteractiveUtils", "IntervalSets", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MacroTools", "MakieCore", "Markdown", "MathTeXEngine", "Observables", "OffsetArrays", "Packing", "PlotUtils", "PolygonOps", "PrecompileTools", "Printf", "REPL", "Random", "RelocatableFolders", "Setfield", "ShaderAbstractions", "Showoff", "SignedDistanceFields", "SparseArrays", "StableHashTraits", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "TriplotBase", "UnicodeFun"]
git-tree-sha1 = "35fa3c150cd96fd77417a23965b7037b90d6ffc9"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.19.12"

[[deps.MakieCore]]
deps = ["Observables", "REPL"]
git-tree-sha1 = "9b11acd07f21c4d035bd4156e789532e8ee2cc70"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.6.9"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "UnicodeFun"]
git-tree-sha1 = "96ca8a313eb6437db5ffe946c457a401bbb8ce1d"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.5.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.Mods]]
git-tree-sha1 = "0a3c164857cfc4defe0ac09e6b0123d61320abb1"
uuid = "7475f97c-0381-53b1-977b-4c60186c8d62"
version = "2.2.6"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.Multisets]]
git-tree-sha1 = "8ef67bad0a3def6d77aebf1d3645119e7c8e5a54"
uuid = "3b2b4ff1-bcff-5658-a3ee-dbcf1ce5ac09"
version = "0.4.5"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
git-tree-sha1 = "5e1897147d1ff8d98883cda2be2187dcf57d8f0c"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.15.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7493f61f55a6cce7325f197443aa80d32554ba10"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+3"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Optim]]
deps = ["Compat", "FillArrays", "ForwardDiff", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "PositiveFactorizations", "Printf", "SparseArrays", "StatsBase"]
git-tree-sha1 = "ab7edad78cdef22099f43c54ef77ac63c2c9cc64"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "1.10.0"

    [deps.Optim.extensions]
    OptimMOIExt = "MathOptInterface"

    [deps.Optim.weakdeps]
    MathOptInterface = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "bc5bf2ea3d5351edf285a06b0016788a121ce92c"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.5.1"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ed6834e95bd326c52d5675b4181386dfbe885afb"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.55.5+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Permutations]]
deps = ["Combinatorics", "LinearAlgebra", "Random"]
git-tree-sha1 = "f92b0a7b722b1ecfd5c0d77a7eda24b4eea5c56a"
uuid = "2ae35dd2-176d-5d53-8349-f30d82d94d4f"
version = "0.4.22"

[[deps.PikaParser]]
deps = ["DocStringExtensions"]
git-tree-sha1 = "d6ff87de27ff3082131f31a714d25ab6d0a88abf"
uuid = "3bbf5609-3e7b-44cd-8549-7c69f321e792"
version = "0.6.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "OrderedCollections", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "adc25dbd4d13f148f3256b6d4743fe7e63a71c4a"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.12"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "8f6bc219586aef8baf0ff9a5fe16ee9c70cb65e4"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.2"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.RingLists]]
deps = ["Random"]
git-tree-sha1 = "70d8d52c6d4238cace6ae1a7dd2c0c4d43acdf0b"
uuid = "286e9d63-9694-5540-9e3c-4e6708fa07b2"
version = "0.2.9"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RoundingEmulator]]
git-tree-sha1 = "40b9edad2e5287e05bd413a38f61a8ff55b9557b"
uuid = "5eaf0fd0-dfba-4ccb-bf02-d820a40db705"
version = "0.2.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "52af86e35dd1b177d051b12681e1c581f53c281b"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.ShaderAbstractions]]
deps = ["ColorTypes", "FixedPointNumbers", "GeometryBasics", "LinearAlgebra", "Observables", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "79123bc60c5507f035e6d1d9e563bb2971954ec8"
uuid = "65257c39-d410-5151-9873-9b3e5be5013e"
version = "0.4.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Random", "Statistics", "Test"]
git-tree-sha1 = "d263a08ec505853a5ff1c1ebde2070419e3f28e9"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.0"

[[deps.SimpleGraphs]]
deps = ["AbstractLattices", "Combinatorics", "DataStructures", "IterTools", "LightXML", "LinearAlgebra", "LinearAlgebraX", "Optim", "Primes", "Random", "RingLists", "SimplePartitions", "SimplePolynomials", "SimpleRandom", "SparseArrays", "Statistics"]
git-tree-sha1 = "f65caa24a622f985cc341de81d3f9744435d0d0f"
uuid = "55797a34-41de-5266-9ec1-32ac4eb504d3"
version = "0.8.6"

[[deps.SimplePartitions]]
deps = ["AbstractLattices", "DataStructures", "Permutations"]
git-tree-sha1 = "76cdce94e07849d1172ccb8f3a60a0bbbebe58b3"
uuid = "ec83eff0-a5b5-5643-ae32-5cbf6eedec9d"
version = "0.3.3"

[[deps.SimplePolynomials]]
deps = ["Mods", "Multisets", "Polynomials", "Primes"]
git-tree-sha1 = "77b2c5e731f7e50bbd088ccc2810232e06c1afa3"
uuid = "cc47b68c-3164-5771-a705-2bc0097375a0"
version = "0.2.18"

[[deps.SimpleRandom]]
deps = ["Distributions", "LinearAlgebra", "Random"]
git-tree-sha1 = "bb4f42b25b87f124478207a82f5b02dfafdb3e63"
uuid = "a6525b86-64cd-54fa-8f65-62fc48bdc0e8"
version = "0.3.2"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableHashTraits]]
deps = ["Compat", "PikaParser", "SHA", "StructTypes", "Tables", "TupleTools", "WeakKeyIdDicts"]
git-tree-sha1 = "2c44178ac401356247fa0516371e37d49c957897"
uuid = "c5dd0088-6c3f-4803-b00e-f31a60c170fa"
version = "1.3.4"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "47091a0340a675c738b1304b58161f3b0839d454"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.10"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "29321314c920c26684834965ec2ce0dacc9cf8e5"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.4"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "9537ef82c42cdd8c5d443cbc359110cbb36bae10"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.21"

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = ["GPUArraysCore", "KernelAbstractions"]
    StructArraysLinearAlgebraExt = "LinearAlgebra"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

    [deps.StructArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "159331b30e94d7b11379037feeb9b690950cace8"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "3c0faa42f2bd3c6d994b06286bba2328eae34027"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.2"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.TriplotBase]]
git-tree-sha1 = "4d4ed7f294cda19382ff7de4c137d24d16adc89b"
uuid = "981d1d27-644d-49a2-9326-4793e63143c3"
version = "0.1.0"

[[deps.TupleTools]]
git-tree-sha1 = "41e43b9dc950775eac654b9f845c839cd2f1821e"
uuid = "9d95972d-f1c8-5527-a6e0-b4b365fa01f6"
version = "1.6.0"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.WeakKeyIdDicts]]
git-tree-sha1 = "349165887b0cfdcbb97261e7eb0e7f11d7b39845"
uuid = "ecbed89c-9d59-4137-ae1f-d1084086d01c"
version = "0.1.0"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "beef98d5aad604d9e7d60b2ece5181f7888e2fd6"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+3"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2b0e27d52ec9d8d483e2ca0b72b3cb1a8df5c27a"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+3"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "02054ee01980c90297412e4c809c8694d7323af3"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+3"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+3"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee57a273563e273f0f53275101cd41a8153517a"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+3"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b9ead2d2bdb27330545eb14234a2e300da61232e"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "622cf78670d067c738667aaa96c553430b65e269"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+0"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "522c1df09d05a71785765d19c9524661234738e9"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.11.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b7bfd3ab9d2c58c3829684142f5804e4c6499abc"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.45+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "1e53ffe8941ee486739f3c0cf11208c26637becd"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.4+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "d2408cac540942921e7bd77272c32e58c33d8a77"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.5.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7d0ea0f4895ef2f5cb83645fa689e52cb55cf493"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2021.12.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dcc541bb19ed5b0ede95581fb2e41ecf179527d2"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.6.0+0"
"""

# ╔═╡ Cell order:
# ╠═42b0fed2-7975-490e-b2f1-eefaf7d98d1c
# ╟─ee78e809-d606-49f9-a527-337ae5bdbbae
# ╟─4c247c28-c568-4c5c-b8c7-029c87ed5d0b
# ╟─b490d6f2-4702-43ff-8b2a-04c9e11047f7
# ╟─f56ec812-09f9-4819-81d9-aa6ed22a3bfa
# ╠═6803190f-e300-402c-aece-35afb5052264
# ╠═41e33398-533a-49b8-8912-e58dc793fabb
# ╠═0c70529b-5b9f-4e2c-ae15-cdfae29807df
# ╠═bdb8156b-1a6d-4e96-8c31-d343e9db9d0e
# ╠═802d221a-b2d6-4875-b5a3-7d36e2ab4bc6
# ╠═f1b75c44-c920-41d0-b17d-206c8f1331f4
# ╟─f1cfcf53-d8d4-4c46-ab2b-71c55e23ec17
# ╟─5a3edf07-b6a3-43c0-ab8b-13574fdb0739
# ╟─92b6c5b0-d373-4c91-ab32-09c5aa016c77
# ╟─024edc8b-2d76-4be4-8860-2494034ceb29
# ╠═9a8b112b-32e9-4441-83c3-6d5cc9e3cd7e
# ╠═8e7b53f1-489c-4906-966d-05a5083d0035
# ╠═1edec6cd-dbd9-4476-9951-68f9d09ac47b
# ╟─3e24181b-58fe-4d01-b462-e111d1631a76
# ╟─62472996-ed72-4ec0-9f67-8ef5e53e724a
# ╟─c891a0eb-ff8e-444c-bfaf-9613c07d1575
# ╟─2e3d306d-0d53-4ff1-b81c-a98213ce7f9b
# ╟─b049ba88-534c-488c-8bbc-829dc0110266
# ╟─e8b9a4aa-f784-4247-a6b2-bd6bfb91574f
# ╟─369b8de9-ed4b-449a-bc1f-5a9e440d84d8
# ╠═cf99ae1f-0e60-4a82-a1e0-bc1719ce5349
# ╠═8145b56b-ed08-41ec-9189-8dc60eced10b
# ╠═faf67210-7f18-11ed-0c91-81899d8bfb41
# ╟─cc739249-2975-4efa-a1d6-aae7d03fcc8a
# ╟─0f5ca7ab-f924-4fbf-ba24-8489d8a3b6af
# ╟─c5fccd7e-8545-4b25-a1b5-8cf61fbc9027
# ╟─b0e77b22-41fd-497d-ac9f-b4f860cdc4a6
# ╟─aaf5fb10-5a69-4413-8d3d-a21d0a13e978
# ╟─162d216e-cf65-4a3a-b3d5-b73296542a58
# ╠═4bdc4c11-0f0a-4577-b2cc-ea0766151892
# ╠═b7e288bf-58bc-4140-a6be-c309e83aeab4
# ╠═c4da69c8-2889-4bca-be08-067d6c993009
# ╟─47869642-f7e4-41f9-8dee-802215e6effa
# ╟─8e5f0047-c130-47b4-b0ca-9632178c87c5
# ╟─d1f00b47-b276-4ef0-90e7-692640411fa9
# ╟─ab42f340-38a0-4f6f-a9df-b6b49f6be6fa
# ╠═746e609a-a2e5-4c23-a58d-c7d87e4e2186
# ╠═21df52be-fd42-4084-ac95-952c101541be
# ╠═27b10729-05ad-4dc2-9c84-c3960857deea
# ╟─d7068d69-7e48-4eb1-accb-dd3a1a0b75ea
# ╟─121a92ff-d527-4305-9b22-ee4472364074
# ╟─655d379b-7de3-4095-87cd-a3d1d4407d24
# ╟─f4d9292e-0ff2-4d35-9375-529bdd3bce6c
# ╟─017dcac4-542f-4a4b-9036-1e4ff1354f29
# ╟─4c155972-0557-48c8-96e2-5495dbfb1201
# ╟─ab199495-be5e-41fd-806e-0111a3fead07
# ╟─7d86c2bd-aa9c-4c2b-9a3f-09e3b04c62ba
# ╟─0cf7858d-f298-4456-abfc-dee53833f2ae
# ╟─212bf0f8-a10c-4215-bb69-2ae48ee8cdfc
# ╟─396980a4-893a-4962-8a53-c8ef2905abfe
# ╟─548f6238-a0e6-45dd-ae24-ead4a1565c86
# ╠═7c648cb3-7222-40ad-a189-a8ab11004d36
# ╠═889432db-3904-4810-bd88-3b5fcd9afc21
# ╠═86388abc-4e40-4d71-9d3e-d5fdbe3aa088
# ╟─0b2d0e50-3d03-4ea7-bcaa-5ef3a471fa7d
# ╟─10ce7e86-99f0-40fc-92bc-37df7abed441
# ╟─7fd7a998-4374-42db-85f2-b21dfd8a5762
# ╟─628ba44a-0bb7-4041-bceb-e4f5b41cd80a
# ╟─09e1aa2f-bff2-4744-ade5-8d138842d97b
# ╟─335b4d45-7850-4ae8-94b9-083144ff240c
# ╟─1c54a086-9199-43e9-98f5-4e1453391bd1
# ╟─c6b71507-3bb5-47f0-85df-bf19c0765a85
# ╟─209ce134-303a-4d67-862d-0fc63f0a774f
# ╟─5b70d61b-7874-4ec7-845b-07ab5b5213ec
# ╟─70527dd6-2ea5-410f-90fc-3a0e68eac7d7
# ╟─f138a901-ebc1-43b1-9919-a85e576ca744
# ╟─6ae46a0f-648c-47de-87ff-f93f02f337f4
# ╟─7ea1a9ca-8c49-48c0-b583-72da163f7112
# ╟─7ad008d4-964b-4e82-9dae-3448d1c18a95
# ╟─38fbcd82-0737-4b33-aaa8-6a171c630a8f
# ╟─06b91c40-c267-4935-be8f-7f61f1303caf
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
